From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] iommu/vt-d: Propagate error-value from
 ir_parse_ioapic_hpet_scope()
Date: Fri, 23 Oct 2015 12:04:07 +0200
Message-ID: <20151023100407.GB17032@8bytes.org>
References: <1445493651-3398-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445493651-3398-1-git-send-email-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Oct 22, 2015 at 02:00:51PM +0800, Baoquan He wrote:
> Adjust the return value of parse_ioapics_under_ir as negative value representing
> failure and "0" representing succcess. Just make it consistent with other
> function implementation, and we can judge if calling is successfull by
> if (!parse_ioapics_under_ir()) style.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

Applied thanks. I also put below patch on-top to also propate the error
value returned from ir_parse_ioapic_hpet_scope().

>From 66ef950d1841487c852d68d00977726f1cd9f053 Mon Sep 17 00:00:00 2001
From: Joerg Roedel <jroedel@suse.de>
Date: Fri, 23 Oct 2015 11:57:13 +0200
Subject: [PATCH] iommu/vt-d: Propagate error-value from
 ir_parse_ioapic_hpet_scope()

Propagate the error-value from the function ir_parse_ioapic_hpet_scope()
in parse_ioapics_under_ir() and cleanup its calling loop.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/intel_irq_remapping.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 7843252..f3a9bd1 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -934,13 +934,18 @@ static int __init parse_ioapics_under_ir(void)
 	bool ir_supported = false;
 	int ioapic_idx;
 
-	for_each_iommu(iommu, drhd)
-		if (ecap_ir_support(iommu->ecap)) {
-			if (ir_parse_ioapic_hpet_scope(drhd->hdr, iommu))
-				return -1;
+	for_each_iommu(iommu, drhd) {
+		int ret;
 
-			ir_supported = true;
-		}
+		if (!ecap_ir_support(iommu->ecap))
+			continue;
+
+		ret = ir_parse_ioapic_hpet_scope(drhd->hdr, iommu);
+		if (ret)
+			return ret;
+
+		ir_supported = true;
+	}
 
 	if (!ir_supported)
 		return -ENODEV;
-- 
1.8.4.5
