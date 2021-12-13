Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F33C4167D
	for <iommu@archiver.kernel.org>; Mon, 13 Dec 2021 07:14:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6F47A409F6;
	Mon, 13 Dec 2021 07:14:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lEz_GpCddaPQ; Mon, 13 Dec 2021 07:14:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E529F40965;
	Mon, 13 Dec 2021 07:14:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3CE4C001E;
	Mon, 13 Dec 2021 07:14:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B94BC0012
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 07:14:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 14D074273B
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 07:14:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MQn2oiLgNp9s for <iommu@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 07:14:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4450842720
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 07:14:25 +0000 (UTC)
Received: by mail-pf1-x42b.google.com with SMTP id g19so14135456pfb.8
 for <iommu@lists.linux-foundation.org>; Sun, 12 Dec 2021 23:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IQVoqBhkMbv3k6OINJ2ThuqOwq/2RghajB/JhTjJmPQ=;
 b=Wqo7YQm2zeFPL0nGRQ/1URjIGV8BliGhkhdwTOPCx+dpnrZLSgG0HCHKgoLI9zbofo
 aV5IVmqv59n6PYoyDMvfYZndvTANTvaQ2r1FFbcM59xXA9I+6SVsk7aGhru5Ixr2ZOfk
 NPZxOHQI5ytzgfG19WNv00a0yPiz2hMK/Lk61MLyNt4pxZIXS0ZHYOS4shfjMxwFsfrP
 BK7BnsVmr9wHf2qjlrukAaSDtQqW8Ttc3ZkIUmSqdgdD5tka5pWHqCY6TUrXt7qzIgOK
 vB8iuXXW7qJ4yoGYBB/46YSezALc7eN0IH0LiDdUHJax3AuetajCPak/tRv2gnMO9IQ4
 tM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IQVoqBhkMbv3k6OINJ2ThuqOwq/2RghajB/JhTjJmPQ=;
 b=SQ6//i6XzAQr3DmdKLcSfgtdpjecQzEkqn2QPa6HehVXhEorSFSIr3Xh7nYCvyVVHI
 fS+hloHP1kayzGmaUyp8xoPFRJaILvLHoQhTHEjzSkjTtzj706Vgrjk6inAhCZ7wnWNm
 cZrZmns+u8FTt+LX81TIB2qJcQIJ3jQnqxbUGW1oBFnrw7+u+anCeauHH3UQIuW4PlUJ
 c0kDweTFVsxpKpGNVyfuNJWJEDINGzmON0AIuOyZGkd/J1TMfHPEBWKeEn/0PbryFeWV
 AkP6WapVKG2oeWs2EgjvUzlB+HLCVd4OkBqgmLyt8ZFBpEVZbcZKEUxfWiausxit4qYB
 oL/Q==
X-Gm-Message-State: AOAM533IoSw0SL72OcwLr2EFCUuRS8temxlHMwAjXiWuhD4ZZwOo+YcS
 eXkbR/SBZPYstJcDen6RoT4=
X-Google-Smtp-Source: ABdhPJwjAKWpKihnmAu8aWL3L+K1y3yAYsNTpxjg65IVsLLMsSna5L5XMs9r0umkWQIy2E3STqhOUQ==
X-Received: by 2002:a63:4a4b:: with SMTP id j11mr51473120pgl.580.1639379664613; 
 Sun, 12 Dec 2021 23:14:24 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:36:a586:a4cb:7d3:4f27])
 by smtp.gmail.com with ESMTPSA id qe12sm6079401pjb.29.2021.12.12.23.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Dec 2021 23:14:24 -0800 (PST)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, davem@davemloft.net, kuba@kernel.org,
 jejb@linux.ibm.com, martin.petersen@oracle.com, arnd@arndb.de,
 hch@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
 thomas.lendacky@amd.com, Tianyu.Lan@microsoft.com,
 michael.h.kelley@microsoft.com
Subject: [PATCH V7 3/5] hyper-v: Enable swiotlb bounce buffer for Isolation VM
Date: Mon, 13 Dec 2021 02:14:04 -0500
Message-Id: <20211213071407.314309-4-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213071407.314309-1-ltykernel@gmail.com>
References: <20211213071407.314309-1-ltykernel@gmail.com>
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
Change since v6:
        * Fix compile error when swiotlb is not enabled.

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
 arch/x86/hyperv/hv_init.c      | 12 ++++++++++++
 arch/x86/kernel/cpu/mshyperv.c | 15 ++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 24f4a06ac46a..749906a8e068 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -28,6 +28,7 @@
 #include <linux/syscore_ops.h>
 #include <clocksource/hyperv_timer.h>
 #include <linux/highmem.h>
+#include <linux/swiotlb.h>
 
 int hyperv_init_cpuhp;
 u64 hv_current_partition_id = ~0ull;
@@ -502,6 +503,17 @@ void __init hyperv_init(void)
 
 	/* Query the VMs extended capability once, so that it can be cached. */
 	hv_query_ext_cap(0);
+
+#ifdef CONFIG_SWIOTLB
+	/*
+	 * Swiotlb bounce buffer needs to be mapped in extra address
+	 * space. Map function doesn't work in the early place and so
+	 * call swiotlb_update_mem_attributes() here.
+	 */
+	if (hv_is_isolation_supported())
+		swiotlb_update_mem_attributes();
+#endif
+
 	return;
 
 clean_guest_os_id:
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 4794b716ec79..e3a240c5e4f5 100644
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
@@ -319,8 +320,20 @@ static void __init ms_hyperv_init_platform(void)
 		pr_info("Hyper-V: Isolation Config: Group A 0x%x, Group B 0x%x\n",
 			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
 
-		if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP)
+		if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP) {
 			static_branch_enable(&isolation_type_snp);
+#ifdef CONFIG_SWIOTLB
+			swiotlb_unencrypted_base = ms_hyperv.shared_gpa_boundary;
+#endif
+		}
+
+#ifdef CONFIG_SWIOTLB
+		/*
+		 * Enable swiotlb force mode in Isolation VM to
+		 * use swiotlb bounce buffer for dma transaction.
+		 */
+		swiotlb_force = SWIOTLB_FORCE;
+#endif
 	}
 
 	if (hv_max_functions_eax >= HYPERV_CPUID_NESTED_FEATURES) {
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
