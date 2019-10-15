Return-Path: <SRS0=BRyA=YI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC317ECE58F
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 23:55:07 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BD262083B
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 23:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BD262083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 428ACCBE;
	Tue, 15 Oct 2019 23:55:07 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2078DCBD
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 23:55:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 95CAE6D6
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 23:55:05 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	15 Oct 2019 16:55:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,301,1566889200"; d="scan'208";a="370629838"
Received: from oux.sc.intel.com ([10.3.52.57])
	by orsmga005.jf.intel.com with ESMTP; 15 Oct 2019 16:55:04 -0700
From: Yian Chen <yian.chen@intel.com>
To: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-ia64@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>, Ashok Raj <ashok.raj@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>, Tony Luck <tony.luck@intel.com>
Subject: [PATCH] iommu/vt-d: Check VT-d RMRR region in BIOS is reported as
	reserved
Date: Tue, 15 Oct 2019 09:49:32 -0700
Message-Id: <20191015164932.18185-1-yian.chen@intel.com>
X-Mailer: git-send-email 2.17.1
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

VT-d RMRR (Reserved Memory Region Reporting) regions are reserved
for device use only and should not be part of allocable memory pool of OS.

BIOS e820_table reports complete memory map to OS, including OS usable
memory ranges and BIOS reserved memory ranges etc.

x86 BIOS may not be trusted to include RMRR regions as reserved type
of memory in its e820 memory map, hence validate every RMRR entry
with the e820 memory map to make sure the RMRR regions will not be
used by OS for any other purposes.

ia64 EFI is working fine so implement RMRR validation as a dummy function

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Yian Chen <yian.chen@intel.com>
---
 arch/ia64/include/asm/iommu.h |  5 +++++
 arch/x86/include/asm/iommu.h  | 18 ++++++++++++++++++
 drivers/iommu/intel-iommu.c   |  8 +++++++-
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/ia64/include/asm/iommu.h b/arch/ia64/include/asm/iommu.h
index 7904f591a79b..eb0db20c9d4c 100644
--- a/arch/ia64/include/asm/iommu.h
+++ b/arch/ia64/include/asm/iommu.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_IA64_IOMMU_H
 #define _ASM_IA64_IOMMU_H 1
 
+#include <linux/acpi.h>
+
 /* 10 seconds */
 #define DMAR_OPERATION_TIMEOUT (((cycles_t) local_cpu_data->itc_freq)*10)
 
@@ -9,6 +11,9 @@ extern void no_iommu_init(void);
 #ifdef	CONFIG_INTEL_IOMMU
 extern int force_iommu, no_iommu;
 extern int iommu_detected;
+
+static inline int __init
+arch_rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr) { return 0; }
 #else
 #define no_iommu		(1)
 #define iommu_detected		(0)
diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
index b91623d521d9..95fa65a5f0dc 100644
--- a/arch/x86/include/asm/iommu.h
+++ b/arch/x86/include/asm/iommu.h
@@ -2,10 +2,28 @@
 #ifndef _ASM_X86_IOMMU_H
 #define _ASM_X86_IOMMU_H
 
+#include <linux/acpi.h>
+
+#include <asm/e820/api.h>
+
 extern int force_iommu, no_iommu;
 extern int iommu_detected;
 
 /* 10 seconds */
 #define DMAR_OPERATION_TIMEOUT ((cycles_t) tsc_khz*10*1000)
 
+static inline int __init
+arch_rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
+{
+	u64 start = rmrr->base_address;
+	u64 end = rmrr->end_address + 1;
+
+	if (e820__mapped_all(start, end, E820_TYPE_RESERVED))
+		return 0;
+
+	pr_err(FW_BUG "No firmware reserved region can cover this RMRR [%#018Lx-%#018Lx], contact BIOS vendor for fixes\n",
+	       start, end - 1);
+	return -EFAULT;
+}
+
 #endif /* _ASM_X86_IOMMU_H */
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 3f974919d3bd..722290014143 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4306,13 +4306,19 @@ int __init dmar_parse_one_rmrr(struct acpi_dmar_header *header, void *arg)
 {
 	struct acpi_dmar_reserved_memory *rmrr;
 	struct dmar_rmrr_unit *rmrru;
+	int ret;
+
+	rmrr = (struct acpi_dmar_reserved_memory *)header;
+	ret = arch_rmrr_sanity_check(rmrr);
+	if (ret)
+		return ret;
 
 	rmrru = kzalloc(sizeof(*rmrru), GFP_KERNEL);
 	if (!rmrru)
 		goto out;
 
 	rmrru->hdr = header;
-	rmrr = (struct acpi_dmar_reserved_memory *)header;
+
 	rmrru->base_address = rmrr->base_address;
 	rmrru->end_address = rmrr->end_address;
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
