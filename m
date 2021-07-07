Return-Path: <SRS0=iPMr=L7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC66C11F6F
	for <iommu@archiver.kernel.org>; Wed,  7 Jul 2021 15:35:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5F8261CBE
	for <iommu@archiver.kernel.org>; Wed,  7 Jul 2021 15:35:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F8261CBE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 80E8C40679;
	Wed,  7 Jul 2021 15:35:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YA5Z5rGljrrl; Wed,  7 Jul 2021 15:35:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0E36C4068E;
	Wed,  7 Jul 2021 15:35:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF948C001A;
	Wed,  7 Jul 2021 15:35:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B7E9C000E
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 15:35:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0D95982E1A
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 15:35:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GYmPujoKdQ1l for <iommu@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 15:35:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A914382D04
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 15:35:35 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id
 p17-20020a17090b0111b02901723ab8d11fso1903033pjz.1
 for <iommu@lists.linux-foundation.org>; Wed, 07 Jul 2021 08:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TDHZQgnHR8D2Lbss+oxbhfWYDj9fVT4IV0q165q+scY=;
 b=jlhWksTt9ZXMQ3V5VZdagp4ykYr1NEm+E0/uwOYCfTgwiWHndiHvF1l07h0g10O76p
 /1E2rtwwZ9f1CUV+vUiBNbbCbTCtaahPxUZ7tRHr/nHBT2W6v86oKAwn8ZCCNPMumLn2
 0rXBqE/jPPwXQxXwuI41eD0/HivvOqDW6houVOHuI1fZVGi2I+zpMwIEd/ablG8Mh+Xd
 5CUPqxt1iAquu91aga4I00EZPhCMpR6UmUQsadux88HjkMINPdMyFaX59QQ6qLR52QGu
 HmmUFOOXJe8oM/DULJDYHJsB1MTWsYHfYYloQags21tXXhIuF7MvwEDioPNBthxVDBiR
 2eeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TDHZQgnHR8D2Lbss+oxbhfWYDj9fVT4IV0q165q+scY=;
 b=kaPP5eEKcKCsQjET0jjpbJrCTyqzYnSMoL/4eXr2sx3QbSbSx3v1Lpt/B/coaAHw0S
 UNwRntEeJg6q9xWL0zIzdmrXsMK88rJm64DB8OItonVXfAvYSXeapH1ztyzkBbn2pMNn
 ebhQv4q++7kp8N9qAZJJgV8X/shhiwYswk3JwKqrbzt+wpmmRW0/4Gu99g8OQxFK3dw+
 kMpE2jCXytFLKHIgroPdl/S3PdMXEjG5Bks1Tlss+YgHSoYBiUtalpSiP0rLqdKtrad4
 K1hrrkyECNn+CMNpWEkB5PUhYUmzyECVHTj0USfiEfRqVFmFMB8RuRwQ2pwJg3qR6gw5
 jl3w==
X-Gm-Message-State: AOAM5311oSAs2wlImBQ//gHdgwLkrIodnxjptoSj1rw/nry6Hq46Y9xm
 MCxCO5bTyruDp6WUFOJ78CA=
X-Google-Smtp-Source: ABdhPJxmKhX5fK2x5od9d5gvzBUJ0Dcm3yqb9eF3Fi8VSAbfNgyMwfqdNVErf+9OlaGCHUhH+iCf7g==
X-Received: by 2002:a17:902:b604:b029:128:bfa5:3c4c with SMTP id
 b4-20020a170902b604b0290128bfa53c4cmr21695343pls.29.1625672135173; 
 Wed, 07 Jul 2021 08:35:35 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:0:6b7f:cf3e:bbf2:d229])
 by smtp.gmail.com with ESMTPSA id y11sm21096877pfo.160.2021.07.07.08.35.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jul 2021 08:35:34 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, jgross@suse.com,
 sstabellini@kernel.org, joro@8bytes.org, will@kernel.org,
 davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, arnd@arndb.de, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com, rppt@kernel.org,
 akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
 Tianyu.Lan@microsoft.com, thomas.lendacky@amd.com, ardb@kernel.org,
 nramas@linux.microsoft.com, robh@kernel.org, keescook@chromium.org,
 rientjes@google.com, pgonda@google.com, martin.b.radev@gmail.com,
 hannes@cmpxchg.org, saravanand@fb.com, krish.sadhukhan@oracle.com,
 xen-devel@lists.xenproject.org, tj@kernel.org,
 michael.h.kelley@microsoft.com
Subject: [RFC PATCH V4 12/12] x86/HV: Not set memory decrypted/encrypted
 during kexec alloc/free page in IVM
Date: Wed,  7 Jul 2021 11:34:53 -0400
Message-Id: <20210707153456.3976348-13-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210707153456.3976348-1-ltykernel@gmail.com>
References: <20210707153456.3976348-1-ltykernel@gmail.com>
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
 brijesh.singh@amd.com, linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 anparri@microsoft.com, vkuznets@redhat.com
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

Hyper-V Isolation VM reuses set_memory_decrypted/encrypted function
and not needs to decrypt/encrypt memory in arch_kexec_post_alloc(pre_free)
_pages() just likes AMD SEV VM. So skip them.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 arch/x86/kernel/machine_kexec_64.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index c078b0d3ab0e..0cadc64b6873 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -26,6 +26,7 @@
 #include <asm/kexec-bzimage64.h>
 #include <asm/setup.h>
 #include <asm/set_memory.h>
+#include <asm/mshyperv.h>
 
 #ifdef CONFIG_ACPI
 /*
@@ -598,7 +599,7 @@ void arch_kexec_unprotect_crashkres(void)
  */
 int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, gfp_t gfp)
 {
-	if (sev_active())
+	if (sev_active() || hv_is_isolation_supported())
 		return 0;
 
 	/*
@@ -611,7 +612,7 @@ int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, gfp_t gfp)
 
 void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages)
 {
-	if (sev_active())
+	if (sev_active() || hv_is_isolation_supported())
 		return;
 
 	/*
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
