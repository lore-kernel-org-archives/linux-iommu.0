From: Hiroshi Doyu <hdoyu@nvidia.com>
Subject: [PATCHv6 01/13] of: introduce of_property_for_earch_phandle_with_args()
Date: Thu, 21 Nov 2013 15:40:37 +0200
Message-ID: <1385041249-7705-2-git-send-email-hdoyu@nvidia.com>
References: <1385041249-7705-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1385041249-7705-1-git-send-email-hdoyu@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: swarren@nvidia.com, will.deacon@arm.com, grant.likely@linaro.org, thierry.reding@gmail.com, swarren@wwwdotorg.org, robherring2@gmail.com, joro@8bytes.org
Cc: Hiroshi Doyu <hdoyu@nvidia.com>, mark.rutland@arm.com, devicetree@vger.kernel.org, iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, galak@codeaurora.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

The following pattern of code is tempting to add a new member for
of_property_for_each_*() family as an idiom.

  for (i = 0;
      !of_parse_phandle_with_args(np, list, cells, i, args); i++)
		<do something with "args">;

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
v5:
New patch for v5.
---
 include/linux/of.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index 276c546..131fef5 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -613,6 +613,9 @@ static inline int of_property_read_u32(const struct device_node *np,
 		s;						\
 		s = of_prop_next_string(prop, s))
 
+#define of_property_for_each_phandle_with_args(np, list, cells, i, args) \
+	for (i = 0; !of_parse_phandle_with_args(np, list, cells, i, args); i++)
+
 #if defined(CONFIG_PROC_FS) && defined(CONFIG_PROC_DEVICETREE)
 extern void proc_device_tree_add_node(struct device_node *, struct proc_dir_entry *);
 extern void proc_device_tree_add_prop(struct proc_dir_entry *pde, struct property *prop);
-- 
1.8.1.5
