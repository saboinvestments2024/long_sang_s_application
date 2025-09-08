import 'package:flutter/material.dart';
import '../utils/responsive_helper.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/enhanced_bottom_navigation_bar.dart';

/**
 * AdaptiveLayout - Base layout that adapts to different screen sizes
 * 
 * This layout provides a foundation for responsive design by automatically
 * switching between different layout patterns based on screen size:
 * - Mobile: Stack layout with bottom navigation
 * - Tablet: Side navigation with content area
 * - Desktop: Permanent drawer with navigation rail
 * 
 * Features:
 * - Automatic layout switching based on screen breakpoints
 * - Consistent navigation patterns across devices
 * - Material Design 3 compliant spacing and sizing
 * - Smooth transitions between layout modes
 * - Accessibility-friendly navigation
 * 
 * Usage:
 * ```dart
 * AdaptiveLayout(
 *   title: "Billiards App",
 *   currentIndex: _currentIndex,
 *   onNavigationChanged: (index) => setState(() => _currentIndex = index),
 *   body: _pages[_currentIndex],
 * )
 * ```
 */
class AdaptiveLayout extends StatefulWidget {
  const AdaptiveLayout({
    Key? key,
    required this.title,
    required this.currentIndex,
    required this.onNavigationChanged,
    required this.body,
    this.appBarActions,
    this.floatingActionButton,
    this.showAppBar = true,
    this.username,
  }) : super(key: key);

  final String title;
  final int currentIndex;
  final ValueChanged<int> onNavigationChanged;
  final Widget body;
  final List<Widget>? appBarActions;
  final Widget? floatingActionButton;
  final bool showAppBar;
  final String? username;

  @override
  State<AdaptiveLayout> createState() => _AdaptiveLayoutState();
}

class _AdaptiveLayoutState extends State<AdaptiveLayout> 
    with TickerProviderStateMixin {
  late AnimationController _layoutAnimationController;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _layoutAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _slideAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _layoutAnimationController,
      curve: Curves.easeInOut,
    ));
    
    _layoutAnimationController.forward();
  }

  @override
  void dispose() {
    _layoutAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, deviceType) {
        switch (deviceType) {
          case DeviceType.mobile:
            return _buildMobileLayout();
          case DeviceType.tablet:
            return _buildTabletLayout();
          case DeviceType.desktop:
            return _buildDesktopLayout();
        }
      },
    );
  }

  Widget _buildMobileLayout() {
    return Scaffold(
      appBar: widget.showAppBar ? _buildAppBar() : null,
      body: AnimatedBuilder(
        animation: _slideAnimation,
        builder: (context, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.1),
              end: Offset.zero,
            ).animate(_slideAnimation),
            child: FadeTransition(
              opacity: _slideAnimation,
              child: widget.body,
            ),
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: widget.currentIndex,
        onTap: widget.onNavigationChanged,
      ),
      floatingActionButton: widget.floatingActionButton,
    );
  }

  Widget _buildTabletLayout() {
    return Scaffold(
      body: Row(
        children: [
          // Side Navigation
          Container(
            width: ResponsiveHelper.getNavigationRailWidth(context),
            child: _buildSideNavigation(),
          ),
          // Main Content
          Expanded(
            child: Column(
              children: [
                if (widget.showAppBar) 
                  Container(
                    child: _buildAppBar(),
                  ),
                Expanded(
                  child: AnimatedBuilder(
                    animation: _slideAnimation,
                    builder: (context, child) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.1, 0),
                          end: Offset.zero,
                        ).animate(_slideAnimation),
                        child: FadeTransition(
                          opacity: _slideAnimation,
                          child: widget.body,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: widget.floatingActionButton,
    );
  }

  Widget _buildDesktopLayout() {
    return Scaffold(
      body: Row(
        children: [
          // Permanent Navigation Drawer
          Container(
            width: ResponsiveHelper.getNavigationRailWidth(context),
            child: _buildPermanentDrawer(),
          ),
          // Main Content Area
          Expanded(
            child: Column(
              children: [
                if (widget.showAppBar) 
                  Container(
                    child: _buildAppBar(),
                  ),
                Expanded(
                  child: Container(
                    constraints: ResponsiveHelper.getContainerConstraints(context),
                    child: AnimatedBuilder(
                      animation: _slideAnimation,
                      builder: (context, child) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.1, 0),
                            end: Offset.zero,
                          ).animate(_slideAnimation),
                          child: FadeTransition(
                            opacity: _slideAnimation,
                            child: widget.body,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: widget.floatingActionButton,
    );
  }

  PreferredSizeWidget? _buildAppBar() {
    if (!widget.showAppBar) return null;
    
    return CustomAppBar(
      username: widget.username ?? "user",
      onLeadingTap: () {
        // Handle app bar leading tap
      },
    );
  }

  Widget _buildSideNavigation() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          right: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 16, tablet: 24)),
          ..._buildNavigationItems(),
        ],
      ),
    );
  }

  Widget _buildPermanentDrawer() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          right: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drawer Header
          Container(
            height: 120,
            padding: ResponsiveHelper.getSafePadding(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "@${widget.username ?? 'user'}",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          // Navigation Items
          Expanded(
            child: ListView(
              padding: ResponsiveHelper.getSafePadding(context),
              children: _buildNavigationItems(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildNavigationItems() {
    final navigationItems = [
      NavigationItem(
        icon: Icons.home_outlined,
        selectedIcon: Icons.home,
        label: "Trang chủ",
        index: 0,
      ),
      NavigationItem(
        icon: Icons.search_outlined,
        selectedIcon: Icons.search,
        label: "Tìm kiếm",
        index: 1,
      ),
      NavigationItem(
        icon: Icons.sports_outlined,
        selectedIcon: Icons.sports,
        label: "Giải đấu",
        index: 2,
      ),
      NavigationItem(
        icon: Icons.groups_outlined,
        selectedIcon: Icons.groups,
        label: "Câu lạc bộ",
        index: 3,
      ),
      NavigationItem(
        icon: Icons.person_outline,
        selectedIcon: Icons.person,
        label: "Hồ sơ",
        index: 4,
      ),
    ];

    final deviceType = ResponsiveHelper.getDeviceType(context);

    return navigationItems.map((item) {
      final isSelected = widget.currentIndex == item.index;
      
      if (deviceType == DeviceType.desktop) {
        return _buildDesktopNavigationItem(item, isSelected);
      } else {
        return _buildCompactNavigationItem(item, isSelected);
      }
    }).toList();
  }

  Widget _buildDesktopNavigationItem(NavigationItem item, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: () => widget.onNavigationChanged(item.index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected 
                  ? Theme.of(context).colorScheme.secondaryContainer
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  isSelected ? item.selectedIcon : item.icon,
                  color: isSelected 
                      ? Theme.of(context).colorScheme.onSecondaryContainer
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 16),
                Text(
                  item.label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isSelected 
                        ? Theme.of(context).colorScheme.onSecondaryContainer
                        : Theme.of(context).colorScheme.onSurfaceVariant,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompactNavigationItem(NavigationItem item, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: () => widget.onNavigationChanged(item.index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected 
                  ? Theme.of(context).colorScheme.secondaryContainer
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Icon(
                  isSelected ? item.selectedIcon : item.icon,
                  color: isSelected 
                      ? Theme.of(context).colorScheme.onSecondaryContainer
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(height: 4),
                Text(
                  item.label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isSelected 
                        ? Theme.of(context).colorScheme.onSecondaryContainer
                        : Theme.of(context).colorScheme.onSurfaceVariant,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NavigationItem {
  const NavigationItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.index,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final int index;
}
