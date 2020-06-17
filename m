Return-Path: <SRS0=yzgR=76=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7D6C433E3
	for <iommu@archiver.kernel.org>; Wed, 17 Jun 2020 18:24:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A80BD21927
	for <iommu@archiver.kernel.org>; Wed, 17 Jun 2020 18:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A80BD21927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 72E4E892A1;
	Wed, 17 Jun 2020 18:24:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zPZLip-mCdaR; Wed, 17 Jun 2020 18:24:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id EF1E988D24;
	Wed, 17 Jun 2020 18:24:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DAD6AC0892;
	Wed, 17 Jun 2020 18:24:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07ABAC016E
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 18:24:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id EAF4287336
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 18:24:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tDBxCQ0SdSfB for <iommu@lists.linux-foundation.org>;
 Wed, 17 Jun 2020 18:24:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3FE24873D6
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 18:24:15 +0000 (UTC)
IronPort-SDR: NYR7qh97Kpm15c0sjYb7TiMcKm0S4+S5WdeZ69RDzSLn7oiASlla8tDMeqbjEe4w6VNjyC9lxT
 nw4P8amGwawg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2020 11:24:14 -0700
IronPort-SDR: lHRveg8z0UDU7sCeMJ/57WVnDx3CDh9sI2Q8WJkyVZcyywmxHzkLOhgjnCmUBkbkYOgGGrhznC
 y/YAY/8OGi1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,523,1583222400"; d="scan'208";a="308874147"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
 by orsmga008.jf.intel.com with ESMTP; 17 Jun 2020 11:24:14 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, "Peter Zijlstra" <peterz@infradead.org>,
 "H Peter Anvin" <hpa@zytor.com>, "David Woodhouse" <dwmw2@infradead.org>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 "Dave Hansen" <dave.hansen@intel.com>, "Tony Luck" <tony.luck@intel.com>,
 "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
 "Christoph Hellwig" <hch@infradeed.org>, "Ashok Raj" <ashok.raj@intel.com>,
 "Jacob Jun Pan" <jacob.jun.pan@intel.com>,
 "Dave Jiang" <dave.jiang@intel.com>, "Sohil Mehta" <sohil.mehta@intel.com>,
 "Ravi V Shankar" <ravi.v.shankar@intel.com>
Subject: [PATCH v3 02/13] ocxl: Change type of pasid to unsigned int
Date: Wed, 17 Jun 2020 11:23:42 -0700
Message-Id: <1592418233-17762-3-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1592418233-17762-1-git-send-email-fenghua.yu@intel.com>
References: <1592418233-17762-1-git-send-email-fenghua.yu@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, iommu@lists.linux-foundation.org,
 x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

PASID is defined as "int" although it's a 20-bit value and shouldn't be
negative int. To be consistent with type defined in iommu, define PASID
as "unsigned int".

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v2:
- Create this new patch to define PASID as "unsigned int" consistently in
  ocxl (Thomas)

 drivers/misc/ocxl/config.c        |  3 ++-
 drivers/misc/ocxl/link.c          |  6 +++---
 drivers/misc/ocxl/ocxl_internal.h |  6 +++---
 drivers/misc/ocxl/pasid.c         |  2 +-
 drivers/misc/ocxl/trace.h         | 20 ++++++++++----------
 include/misc/ocxl.h               |  6 +++---
 6 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/misc/ocxl/config.c b/drivers/misc/ocxl/config.c
index c8e19bfb5ef9..22d034caed3d 100644
--- a/drivers/misc/ocxl/config.c
+++ b/drivers/misc/ocxl/config.c
@@ -806,7 +806,8 @@ int ocxl_config_set_TL(struct pci_dev *dev, int tl_dvsec)
 }
 EXPORT_SYMBOL_GPL(ocxl_config_set_TL);
 
-int ocxl_config_terminate_pasid(struct pci_dev *dev, int afu_control, int pasid)
+int ocxl_config_terminate_pasid(struct pci_dev *dev, int afu_control,
+				unsigned int pasid)
 {
 	u32 val;
 	unsigned long timeout;
diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
index 58d111afd9f6..931f6ae022db 100644
--- a/drivers/misc/ocxl/link.c
+++ b/drivers/misc/ocxl/link.c
@@ -492,7 +492,7 @@ static u64 calculate_cfg_state(bool kernel)
 	return state;
 }
 
-int ocxl_link_add_pe(void *link_handle, int pasid, u32 pidr, u32 tidr,
+int ocxl_link_add_pe(void *link_handle, unsigned int pasid, u32 pidr, u32 tidr,
 		u64 amr, struct mm_struct *mm,
 		void (*xsl_err_cb)(void *data, u64 addr, u64 dsisr),
 		void *xsl_err_data)
@@ -572,7 +572,7 @@ int ocxl_link_add_pe(void *link_handle, int pasid, u32 pidr, u32 tidr,
 }
 EXPORT_SYMBOL_GPL(ocxl_link_add_pe);
 
-int ocxl_link_update_pe(void *link_handle, int pasid, __u16 tid)
+int ocxl_link_update_pe(void *link_handle, unsigned int pasid, __u16 tid)
 {
 	struct ocxl_link *link = (struct ocxl_link *) link_handle;
 	struct spa *spa = link->spa;
@@ -608,7 +608,7 @@ int ocxl_link_update_pe(void *link_handle, int pasid, __u16 tid)
 	return rc;
 }
 
-int ocxl_link_remove_pe(void *link_handle, int pasid)
+int ocxl_link_remove_pe(void *link_handle, unsigned int pasid)
 {
 	struct ocxl_link *link = (struct ocxl_link *) link_handle;
 	struct spa *spa = link->spa;
diff --git a/drivers/misc/ocxl/ocxl_internal.h b/drivers/misc/ocxl/ocxl_internal.h
index 345bf843a38e..3ca982ba7472 100644
--- a/drivers/misc/ocxl/ocxl_internal.h
+++ b/drivers/misc/ocxl/ocxl_internal.h
@@ -41,7 +41,7 @@ struct ocxl_afu {
 	struct ocxl_afu_config config;
 	int pasid_base;
 	int pasid_count; /* opened contexts */
-	int pasid_max; /* maximum number of contexts */
+	unsigned int pasid_max; /* maximum number of contexts */
 	int actag_base;
 	int actag_enabled;
 	struct mutex contexts_lock;
@@ -69,7 +69,7 @@ struct ocxl_xsl_error {
 
 struct ocxl_context {
 	struct ocxl_afu *afu;
-	int pasid;
+	unsigned int pasid;
 	struct mutex status_mutex;
 	enum ocxl_context_status status;
 	struct address_space *mapping;
@@ -128,7 +128,7 @@ int ocxl_config_check_afu_index(struct pci_dev *dev,
  * pasid: the PASID for the AFU context
  * tid: the new thread id for the process element
  */
-int ocxl_link_update_pe(void *link_handle, int pasid, __u16 tid);
+int ocxl_link_update_pe(void *link_handle, unsigned int pasid, __u16 tid);
 
 int ocxl_context_mmap(struct ocxl_context *ctx,
 			struct vm_area_struct *vma);
diff --git a/drivers/misc/ocxl/pasid.c b/drivers/misc/ocxl/pasid.c
index d14cb56e6920..a151fc8f0bec 100644
--- a/drivers/misc/ocxl/pasid.c
+++ b/drivers/misc/ocxl/pasid.c
@@ -80,7 +80,7 @@ static void range_free(struct list_head *head, u32 start, u32 size,
 
 int ocxl_pasid_afu_alloc(struct ocxl_fn *fn, u32 size)
 {
-	int max_pasid;
+	unsigned int max_pasid;
 
 	if (fn->config.max_pasid_log < 0)
 		return -ENOSPC;
diff --git a/drivers/misc/ocxl/trace.h b/drivers/misc/ocxl/trace.h
index 17e21cb2addd..019e2fc63b1d 100644
--- a/drivers/misc/ocxl/trace.h
+++ b/drivers/misc/ocxl/trace.h
@@ -9,13 +9,13 @@
 #include <linux/tracepoint.h>
 
 DECLARE_EVENT_CLASS(ocxl_context,
-	TP_PROTO(pid_t pid, void *spa, int pasid, u32 pidr, u32 tidr),
+	TP_PROTO(pid_t pid, void *spa, unsigned int pasid, u32 pidr, u32 tidr),
 	TP_ARGS(pid, spa, pasid, pidr, tidr),
 
 	TP_STRUCT__entry(
 		__field(pid_t, pid)
 		__field(void*, spa)
-		__field(int, pasid)
+		__field(unsigned int, pasid)
 		__field(u32, pidr)
 		__field(u32, tidr)
 	),
@@ -38,21 +38,21 @@ DECLARE_EVENT_CLASS(ocxl_context,
 );
 
 DEFINE_EVENT(ocxl_context, ocxl_context_add,
-	TP_PROTO(pid_t pid, void *spa, int pasid, u32 pidr, u32 tidr),
+	TP_PROTO(pid_t pid, void *spa, unsigned int pasid, u32 pidr, u32 tidr),
 	TP_ARGS(pid, spa, pasid, pidr, tidr)
 );
 
 DEFINE_EVENT(ocxl_context, ocxl_context_remove,
-	TP_PROTO(pid_t pid, void *spa, int pasid, u32 pidr, u32 tidr),
+	TP_PROTO(pid_t pid, void *spa, unsigned int pasid, u32 pidr, u32 tidr),
 	TP_ARGS(pid, spa, pasid, pidr, tidr)
 );
 
 TRACE_EVENT(ocxl_terminate_pasid,
-	TP_PROTO(int pasid, int rc),
+	TP_PROTO(unsigned int pasid, int rc),
 	TP_ARGS(pasid, rc),
 
 	TP_STRUCT__entry(
-		__field(int, pasid)
+		__field(unsigned int, pasid)
 		__field(int, rc)
 	),
 
@@ -107,11 +107,11 @@ DEFINE_EVENT(ocxl_fault_handler, ocxl_fault_ack,
 );
 
 TRACE_EVENT(ocxl_afu_irq_alloc,
-	TP_PROTO(int pasid, int irq_id, unsigned int virq, int hw_irq),
+	TP_PROTO(unsigned int pasid, int irq_id, unsigned int virq, int hw_irq),
 	TP_ARGS(pasid, irq_id, virq, hw_irq),
 
 	TP_STRUCT__entry(
-		__field(int, pasid)
+		__field(unsigned int, pasid)
 		__field(int, irq_id)
 		__field(unsigned int, virq)
 		__field(int, hw_irq)
@@ -133,11 +133,11 @@ TRACE_EVENT(ocxl_afu_irq_alloc,
 );
 
 TRACE_EVENT(ocxl_afu_irq_free,
-	TP_PROTO(int pasid, int irq_id),
+	TP_PROTO(unsigned int pasid, int irq_id),
 	TP_ARGS(pasid, irq_id),
 
 	TP_STRUCT__entry(
-		__field(int, pasid)
+		__field(unsigned int, pasid)
 		__field(int, irq_id)
 	),
 
diff --git a/include/misc/ocxl.h b/include/misc/ocxl.h
index 06dd5839e438..5eca04c8da97 100644
--- a/include/misc/ocxl.h
+++ b/include/misc/ocxl.h
@@ -429,7 +429,7 @@ int ocxl_config_set_TL(struct pci_dev *dev, int tl_dvsec);
  * desired AFU. It can be found in the AFU configuration
  */
 int ocxl_config_terminate_pasid(struct pci_dev *dev,
-				int afu_control_offset, int pasid);
+				int afu_control_offset, unsigned int pasid);
 
 /*
  * Read the configuration space of a function and fill in a
@@ -466,7 +466,7 @@ void ocxl_link_release(struct pci_dev *dev, void *link_handle);
  * 'xsl_err_data' is an argument passed to the above callback, if
  * defined
  */
-int ocxl_link_add_pe(void *link_handle, int pasid, u32 pidr, u32 tidr,
+int ocxl_link_add_pe(void *link_handle, unsigned int pasid, u32 pidr, u32 tidr,
 		u64 amr, struct mm_struct *mm,
 		void (*xsl_err_cb)(void *data, u64 addr, u64 dsisr),
 		void *xsl_err_data);
@@ -474,7 +474,7 @@ int ocxl_link_add_pe(void *link_handle, int pasid, u32 pidr, u32 tidr,
 /*
  * Remove a Process Element from the Shared Process Area for a link
  */
-int ocxl_link_remove_pe(void *link_handle, int pasid);
+int ocxl_link_remove_pe(void *link_handle, unsigned int pasid);
 
 /*
  * Allocate an AFU interrupt associated to the link.
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
