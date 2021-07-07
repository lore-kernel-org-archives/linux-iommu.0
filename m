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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E4AC11F66
	for <iommu@archiver.kernel.org>; Wed,  7 Jul 2021 15:47:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8484461CC3
	for <iommu@archiver.kernel.org>; Wed,  7 Jul 2021 15:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8484461CC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 63CB883112;
	Wed,  7 Jul 2021 15:47:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e_LzfYFBq3ZZ; Wed,  7 Jul 2021 15:47:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5A63682F06;
	Wed,  7 Jul 2021 15:47:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E10EC001A;
	Wed,  7 Jul 2021 15:47:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DEC11C000E
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 15:47:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C127A82F06
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 15:47:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uJIUNIL00Bfs for <iommu@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 15:47:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CCCA183134
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 15:47:16 +0000 (UTC)
Received: by mail-pg1-x52e.google.com with SMTP id 37so2709227pgq.0
 for <iommu@lists.linux-foundation.org>; Wed, 07 Jul 2021 08:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=84IEbLNgJNomBqMgxBtrETy72H72EvXAGdQ00eQF2Mc=;
 b=YNnohj4Chb9T3B9ZYxiBv9YVqoi0X5lB74SQ7L1EnVYnuQ7j+Sylm+oTEpclLAr4Rp
 QMdcSRfsEpsNu8h57gAfWgW+S7FmRK+lRz16mOIVQB9v19q7vKIS/3imFU7L8I+a+CoW
 4CZ1ji2QtUkrwbieeV7oza4eciyEFAW2B4m/iegyGFZxo9emMHECDfkYKuchj9BUm6ka
 +lt0qfR+AlSO/jWbQhKgOe0W6mJ6vX8d+oS1VyY2+/m2yXPG+YkyAhEMSZLvHoK3AYA2
 aynhmc1FnAYYAolwJfs0NpD2mwngTXdQQx4mA0KgjhyurE1FSWmq2vOFbfaVKW7EnbvH
 tEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=84IEbLNgJNomBqMgxBtrETy72H72EvXAGdQ00eQF2Mc=;
 b=aYeHbdgCgds1ZZebZ3PkzAoTj01YN6dJfUgJ9VaKaSJVCu2F3ShPqwhw0ECEaH7ChQ
 GeKkOMI447MtcQsU2vPBwsxai4+yUu+mUKhbsngRpMchVXdPvnMC60c8Xvcu8Tm7b8Xa
 AVBgUF1diQFT3hRAwUqVoWzbGp7t4libO+sY+LJyoHxbghnA1EdGERCdi2o3msn41X+I
 SaR/Q+DJPlia9fQKBwV3RdjThaFzXysr1eNyCr4V2fUP8Jainl/y1jW2Zo9oPeQ0TzjD
 O86j0lBMwvrIoNYGmKuGUKoMMF7o1L+Dd+xdn6sczdo0sZ3EJCEe2HsLiOhYnMrLr3PO
 kZqA==
X-Gm-Message-State: AOAM533phYP+LFwR7vkJUb+q59GRoSEDj4+JMsDOcklU1gtXLUJh+tGG
 OLS43l8S+dSVPERLe0b8ivc=
X-Google-Smtp-Source: ABdhPJwc0xo238tlV5y9FHemJmnwVdI1QKXmzxerVDS/ZE3a5qm/V6a2aCdYF88RGalmD6tecULCLg==
X-Received: by 2002:a63:1601:: with SMTP id w1mr26556927pgl.116.1625672836292; 
 Wed, 07 Jul 2021 08:47:16 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:38:6b47:cf3e:bbf2:d229])
 by smtp.gmail.com with ESMTPSA id q18sm23093560pgj.8.2021.07.07.08.47.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jul 2021 08:47:15 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, jgross@suse.com,
 sstabellini@kernel.org, joro@8bytes.org, will@kernel.org,
 davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, arnd@arndb.de, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com,
 kirill.shutemov@linux.intel.com, akpm@linux-foundation.org,
 rppt@kernel.org, Tianyu.Lan@microsoft.com, thomas.lendacky@amd.com,
 ardb@kernel.org, robh@kernel.org, nramas@linux.microsoft.com,
 pgonda@google.com, martin.b.radev@gmail.com, david@redhat.com,
 krish.sadhukhan@oracle.com, saravanand@fb.com,
 xen-devel@lists.xenproject.org, keescook@chromium.org, rientjes@google.com,
 hannes@cmpxchg.org, michael.h.kelley@microsoft.com
Subject: [Resend RFC PATCH V4 13/13] x86/HV: Not set memory
 decrypted/encrypted during kexec alloc/free page in IVM
Date: Wed,  7 Jul 2021 11:46:27 -0400
Message-Id: <20210707154629.3977369-14-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210707154629.3977369-1-ltykernel@gmail.com>
References: <20210707154629.3977369-1-ltykernel@gmail.com>
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
and not needs to decrypted/encrypted in arch_kexec_post_alloc(pre_free)
_pages just likes AMD SEV VM. So skip them.

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
