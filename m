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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E13C11F69
	for <iommu@archiver.kernel.org>; Wed,  7 Jul 2021 15:46:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C485061CC8
	for <iommu@archiver.kernel.org>; Wed,  7 Jul 2021 15:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C485061CC8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A0A64401BD;
	Wed,  7 Jul 2021 15:46:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P4vBIogHKbbI; Wed,  7 Jul 2021 15:46:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7EEA4400E3;
	Wed,  7 Jul 2021 15:46:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A476C001A;
	Wed,  7 Jul 2021 15:46:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 960E0C000E
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 15:46:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 75C3F4063D
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 15:46:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dwt1RlZlhkm1 for <iommu@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 15:46:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BACE140661
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 15:46:44 +0000 (UTC)
Received: by mail-pg1-x52c.google.com with SMTP id h4so2661839pgp.5
 for <iommu@lists.linux-foundation.org>; Wed, 07 Jul 2021 08:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0MmjMjO7XvUbpBRdqqPG7tGmikUa5z2pWikCp/JzIEY=;
 b=UW7L39XXXA0lFLWgWURoFcPlCEh4S4Z8KGVwXPdNWOZ1uC97xNL/QzrnRe932i5Zpl
 v+us9x+QqUCVOJR7NW0cti8Dlvz3ntW5JBnk3T8mrXTQQXScCfMHjoOC5qWs78n+WXHy
 l0/TBbeXhFNdgxncs8vmuBc0rOiOjaE2C0pPG29QKAwWxzv4x0ZxqdciLaEAszX0ad2L
 rytLK20HtdLSd1w9TyUEPQIWBcbAQAlFIoL9atuDdZLes8JZJ04ezb04sQO7vSDnJg/s
 lgt8L6SFaYrDfbO40RdC74i07ap4lhvqEU/pQl2wDRJfhNq+GPC5XQGz2XIiVhjZjRsT
 5j1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0MmjMjO7XvUbpBRdqqPG7tGmikUa5z2pWikCp/JzIEY=;
 b=iqeKMaMfX8M6fiSg1ez6/wO7zQpre1CgvS4dpe00eGcSCs8AKMhtX0aaEOjD5FJz6V
 yY1xprwNwx25CxhDZysRhY2zbmY9K78H/i5KrVGsQOssQ2fN0j2WzeTgoBL2QrRMtcgo
 T3nSTIZGUwEozr480KN7knGU7W4RafuCKC08IPvYU+m/fFC6/QhfBhtVk2ZkhNfyuO6u
 1CS0UWkZe+bj+qcfXWY3NhcDKLYk7c9xNkIkV6ry/mO3WUMX1ZMC5BPf33cGh1dg/sIS
 VQeHrqs3PgLGYn7XUtGy0NH5BUCCbKvhOoCigid/we1ID9TxhvzzMwXPL8mzZURNf+at
 GlyQ==
X-Gm-Message-State: AOAM532DOY5W/DmzWZOThFAUimKUev0KKhEOY6keiXxlDZ41Z+ucOhi9
 A0CtCqPi+C/VuCeKol0faNE=
X-Google-Smtp-Source: ABdhPJyAY8zlw6ShjL9q8KFDuhfqbUuaIuxnQh2fAt/BqNVogHlUsHJh8B4rAjBi+hH2uyVONxd4RA==
X-Received: by 2002:a05:6a00:8c4:b029:2b4:8334:ed4d with SMTP id
 s4-20020a056a0008c4b02902b48334ed4dmr25950524pfu.36.1625672804218; 
 Wed, 07 Jul 2021 08:46:44 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:38:6b47:cf3e:bbf2:d229])
 by smtp.gmail.com with ESMTPSA id q18sm23093560pgj.8.2021.07.07.08.46.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jul 2021 08:46:43 -0700 (PDT)
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
Subject: [Resend RFC PATCH V4 02/13] x86/HV: Initialize shared memory boundary
 in the Isolation VM.
Date: Wed,  7 Jul 2021 11:46:16 -0400
Message-Id: <20210707154629.3977369-3-ltykernel@gmail.com>
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

Hyper-V exposes shared memory boundary via cpuid
HYPERV_CPUID_ISOLATION_CONFIG and store it in the
shared_gpa_boundary of ms_hyperv struct. This prepares
to share memory with host for SNP guest.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 arch/x86/kernel/cpu/mshyperv.c |  2 ++
 include/asm-generic/mshyperv.h | 12 +++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 10b2a8c10cb6..8aed689db621 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -334,6 +334,8 @@ static void __init ms_hyperv_init_platform(void)
 	if (ms_hyperv.priv_high & HV_ISOLATION) {
 		ms_hyperv.isolation_config_a = cpuid_eax(HYPERV_CPUID_ISOLATION_CONFIG);
 		ms_hyperv.isolation_config_b = cpuid_ebx(HYPERV_CPUID_ISOLATION_CONFIG);
+		ms_hyperv.shared_gpa_boundary =
+			(u64)1 << ms_hyperv.shared_gpa_boundary_bits;
 
 		pr_info("Hyper-V: Isolation Config: Group A 0x%x, Group B 0x%x\n",
 			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 3ae56a29594f..2914e27b0429 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -34,8 +34,18 @@ struct ms_hyperv_info {
 	u32 max_vp_index;
 	u32 max_lp_index;
 	u32 isolation_config_a;
-	u32 isolation_config_b;
+	union {
+		u32 isolation_config_b;
+		struct {
+			u32 cvm_type : 4;
+			u32 Reserved11 : 1;
+			u32 shared_gpa_boundary_active : 1;
+			u32 shared_gpa_boundary_bits : 6;
+			u32 Reserved12 : 20;
+		};
+	};
 	void  __percpu **ghcb_base;
+	u64 shared_gpa_boundary;
 };
 extern struct ms_hyperv_info ms_hyperv;
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
