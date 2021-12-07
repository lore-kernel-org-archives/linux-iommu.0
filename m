Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D165BC43217
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 07:20:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 74CB741C87;
	Tue,  7 Dec 2021 07:20:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2IN-YD30SSUG; Tue,  7 Dec 2021 07:20:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 59A6541C70;
	Tue,  7 Dec 2021 07:20:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 432C8C001E;
	Tue,  7 Dec 2021 07:20:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2554C0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 07:20:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 915F541C70
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 07:20:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jXPIrSQgKPyH for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 07:20:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E26E641C63
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 07:20:03 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 w33-20020a17090a6ba400b001a722a06212so1503034pjj.0
 for <iommu@lists.linux-foundation.org>; Mon, 06 Dec 2021 23:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FlswnO/0tf48MZik9N6nEWD7pUN7KQPdPDwLH82NPGY=;
 b=ZUYxHapqYileQn8hhOCFMMj8QIp8KEPV0W94icQthoyQDxFqF2qi4eBhQEenSAEKx9
 nSqb0koAGw4UhwV3u/7y07bqwmrRM252LdPQcz9KZwirKEBoaYyEa58bv60s7M5ds/tp
 LTSsetYg+OqKw1rK5UbBOQBOSB1pUrvgtc0OIhxDcrG/hRKnynLMCh0yillC8dXJIjkW
 lCLMr4yuctx+hNoB+GkZX7lipWQNoK6cULVzuVBng4x/3Voa/rk+7hj0S+ZPjOqk1zNN
 rF8sPEWmJFGduIuU0Ye47YSLyJXgP+6QGRv8pObOM59fRIJW/XwHapgqHFcjlRQGHcCV
 x5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FlswnO/0tf48MZik9N6nEWD7pUN7KQPdPDwLH82NPGY=;
 b=15Xlfjrl1CtF7xclnf/LnQhuSRAdExAylRqi/eboNgKo7/L0NOQ8GU0sqT+t2h6via
 MEbt4AXwZIf1Ga1wY9W4C8q5QXvhTOwXnypv4JhGBLv+ITOjx+8PzX2UY6zFvRoGZYuc
 bi38DPpUrwkdMPjeA2t649pZY9dexE7a65ERSsB+sRSJDsjpV2zVtYefMJajrBcZdLHW
 eAoKjta/SqtA1bnOAoijtShWw/xDUBBBFQp22bLDu3UwVRdCarbjwOiai1y0tVrsJaCw
 D127xnpPXbjBvgjyjwtKQOUJFO2tlVXmo8t0TbdQ6fgdkwHe6VI/yDxoZl3wGIYOtrBS
 lqjg==
X-Gm-Message-State: AOAM530K85Zmb80Y/+4ubaI8VSDJCwMN/Hl+0ZFLfawP2HseLCKHHXUz
 jMHBIfweY41hR7WmRsLBhSw=
X-Google-Smtp-Source: ABdhPJyxALWG+b3iVsK0XjKaOBmbsY6naSRBitlf7O2DVQnd9Z1TiWI+zVWBxsqqAUm436USe9HW6w==
X-Received: by 2002:a17:90a:6e41:: with SMTP id
 s1mr4515958pjm.166.1638861602466; 
 Mon, 06 Dec 2021 23:20:02 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:38:e747:5b78:1904:a4ed])
 by smtp.gmail.com with ESMTPSA id u12sm2081789pfk.71.2021.12.06.23.20.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Dec 2021 23:20:02 -0800 (PST)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, davem@davemloft.net, kuba@kernel.org,
 jejb@linux.ibm.com, martin.petersen@oracle.com, arnd@arndb.de,
 hch@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
 Tianyu.Lan@microsoft.com, thomas.lendacky@amd.com,
 michael.h.kelley@microsoft.com
Subject: [PATCH V6 3/5] hyper-v: Enable swiotlb bounce buffer for Isolation VM
Date: Tue,  7 Dec 2021 02:19:39 -0500
Message-Id: <20211207071942.472442-4-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211207071942.472442-1-ltykernel@gmail.com>
References: <20211207071942.472442-1-ltykernel@gmail.com>
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, parri.andrea@gmail.com,
 linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 linux-scsi@vger.kernel.org, konrad.wilk@oracle.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dave.hansen@intel.com,
 iommu@lists.linux-foundation.org, vkuznets@redhat.com, hch@lst.de
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

hyperv Isolation VM requires bounce buffer support to copy
data from/to encrypted memory and so enable swiotlb force
mode to use swiotlb bounce buffer for DMA transaction.

In Isolation VM with AMD SEV, the bounce buffer needs to be
accessed via extra address space which is above shared_gpa_boundary
(E.G 39 bit address line) reported by Hyper-V CPUID ISOLATION_CONFIG.
The access physical address will be original physical address +
shared_gpa_boundary. The shared_gpa_boundary in the AMD SEV SNP
spec is called virtual top of memory(vTOM). Memory addresses below
vTOM are automatically treated as private while memory above
vTOM is treated as shared.

Swiotlb bounce buffer code calls set_memory_decrypted()
to mark bounce buffer visible to host and map it in extra
address space via memremap. Populate the shared_gpa_boundary
(vTOM) via swiotlb_unencrypted_base variable.

The map function memremap() can't work in the early place
(e.g ms_hyperv_init_platform()) and so call swiotlb_update_mem_
attributes() in the hyperv_init().

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
Change since v4:
	* Remove Hyper-V IOMMU IOMMU_INIT_FINISH related functions
	  and set SWIOTLB_FORCE and swiotlb_unencrypted_base in the
	  ms_hyperv_init_platform(). Call swiotlb_update_mem_attributes()
	  in the hyperv_init().

Change since v3:
	* Add comment in pci-swiotlb-xen.c to explain why add
	  dependency between hyperv_swiotlb_detect() and pci_
	  xen_swiotlb_detect().
	* Return directly when fails to allocate Hyper-V swiotlb
	  buffer in the hyperv_iommu_swiotlb_init().
---
 arch/x86/hyperv/hv_init.c      | 10 ++++++++++
 arch/x86/kernel/cpu/mshyperv.c | 11 ++++++++++-
 include/linux/hyperv.h         |  8 ++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 24f4a06ac46a..9e18a280f89d 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -28,6 +28,7 @@
 #include <linux/syscore_ops.h>
 #include <clocksource/hyperv_timer.h>
 #include <linux/highmem.h>
+#include <linux/swiotlb.h>
 
 int hyperv_init_cpuhp;
 u64 hv_current_partition_id = ~0ull;
@@ -502,6 +503,15 @@ void __init hyperv_init(void)
 
 	/* Query the VMs extended capability once, so that it can be cached. */
 	hv_query_ext_cap(0);
+
+	/*
+	 * Swiotlb bounce buffer needs to be mapped in extra address
+	 * space. Map function doesn't work in the early place and so
+	 * call swiotlb_update_mem_attributes() here.
+	 */
+	if (hv_is_isolation_supported())
+		swiotlb_update_mem_attributes();
+
 	return;
 
 clean_guest_os_id:
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 4794b716ec79..baf3a0873552 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -18,6 +18,7 @@
 #include <linux/kexec.h>
 #include <linux/i8253.h>
 #include <linux/random.h>
+#include <linux/swiotlb.h>
 #include <asm/processor.h>
 #include <asm/hypervisor.h>
 #include <asm/hyperv-tlfs.h>
@@ -319,8 +320,16 @@ static void __init ms_hyperv_init_platform(void)
 		pr_info("Hyper-V: Isolation Config: Group A 0x%x, Group B 0x%x\n",
 			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
 
-		if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP)
+		if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP) {
 			static_branch_enable(&isolation_type_snp);
+			swiotlb_unencrypted_base = ms_hyperv.shared_gpa_boundary;
+		}
+
+		/*
+		 * Enable swiotlb force mode in Isolation VM to
+		 * use swiotlb bounce buffer for dma transaction.
+		 */
+		swiotlb_force = SWIOTLB_FORCE;
 	}
 
 	if (hv_max_functions_eax >= HYPERV_CPUID_NESTED_FEATURES) {
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index b823311eac79..1f037e114dc8 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1726,6 +1726,14 @@ int hyperv_write_cfg_blk(struct pci_dev *dev, void *buf, unsigned int len,
 int hyperv_reg_block_invalidate(struct pci_dev *dev, void *context,
 				void (*block_invalidate)(void *context,
 							 u64 block_mask));
+#if IS_ENABLED(CONFIG_HYPERV)
+int __init hyperv_swiotlb_detect(void);
+#else
+static inline int __init hyperv_swiotlb_detect(void)
+{
+	return 0;
+}
+#endif
 
 struct hyperv_pci_block_ops {
 	int (*read_block)(struct pci_dev *dev, void *buf, unsigned int buf_len,
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
