Return-Path: <SRS0=YfIy=NA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569A5C4338F
	for <iommu@archiver.kernel.org>; Mon,  9 Aug 2021 17:56:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0846461058
	for <iommu@archiver.kernel.org>; Mon,  9 Aug 2021 17:56:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0846461058
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C47224042E;
	Mon,  9 Aug 2021 17:56:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OrtsN1zRvU1X; Mon,  9 Aug 2021 17:56:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 91C5D402BA;
	Mon,  9 Aug 2021 17:56:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6DF0BC001A;
	Mon,  9 Aug 2021 17:56:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 908F4C000E
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 17:56:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7EFED4041E
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 17:56:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OKsg-lTQ0mwY for <iommu@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 17:56:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 717E640400
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 17:56:29 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id
 m24-20020a17090a7f98b0290178b1a81700so1137268pjl.4
 for <iommu@lists.linux-foundation.org>; Mon, 09 Aug 2021 10:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WJ8Qj60FdMGjOsTL0G9bdAidXdjqOzX7Q2WO2gNuvy8=;
 b=kCOSzGmSmj2pkcs1y/QfkWI/Rb7FWu5Rt4HurHSycKb+4UJ6Aawe7iIjpLCK57NZvg
 WiKFB2lpA+UNPjQlXnkCjTyoLNfzfD6exWmoaSXwOTH3P5K09H7X97U+U6AERK1MWKDZ
 Uf9gBLdRp3afuP7JcZ7KvCly3MyakdtS0qQtW8YXpaZpP2oaIZuXn8AWr8r0q7m5PL19
 tGreCVJAddF2G7xYeJM4tw24jIsggOxYdQF69HhvqJzxkbw7sa2z7MLBTUyIBYEQNqtI
 yiQt/exmEXhRuDLkVp63WhMYXTqisSEe9mzIC1qRRU8DWNDpsvO5gCpWRZsGVSmFCKkw
 sUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WJ8Qj60FdMGjOsTL0G9bdAidXdjqOzX7Q2WO2gNuvy8=;
 b=Y38N+vmSAENLmVlXI/wgTRlx+5o1Hi++AeuBLwYaUEDWIAdKdaS1ZgsYcHX7ZTdkWp
 I+kKVYTniHwmT4DQv5yEocAOCmcjxTxPwB0mVzo6oGijvIekUS7ORMylg1DqTxkFbodR
 9DPog/HDcZ5RBTzwr6L91FMn9kCbGkS46A0A/kn+Mxw4+aLR1dkpcpdtpje7XsoTXA+i
 fDE7mJTcz08m9bEig60elBunQ1nGAGYYlHuNaydFVa7y9SvCrMx6YAAODsw6xZNwp2wj
 LvJqKw7+oAf1Kt0IimT9VOSgk42trwcC3u36fLxdn3s2HYMZ77z54sZx9InIjjkWGrqO
 8sQQ==
X-Gm-Message-State: AOAM530hexDo8c8t4M6bZT/pijmU5imOXKIb0rnMjKORlwzdolI6S5KR
 txHjqlgt796fvA0l4O4fWiE=
X-Google-Smtp-Source: ABdhPJxmwF3scgEEjXrYinjzLnwHVvcE27E2cso3ne1oTy5d8B/iiqwH78j0wxYg/3jFPvSCO0RgTg==
X-Received: by 2002:a62:1c42:0:b029:3c3:59ee:6068 with SMTP id
 c63-20020a621c420000b02903c359ee6068mr19584222pfc.72.1628531788936; 
 Mon, 09 Aug 2021 10:56:28 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:2:106e:6ed1:5da1:2ac4])
 by smtp.gmail.com with ESMTPSA id x14sm20589708pfa.127.2021.08.09.10.56.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Aug 2021 10:56:28 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, jgross@suse.com,
 sstabellini@kernel.org, joro@8bytes.org, will@kernel.org,
 davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, arnd@arndb.de, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com, thomas.lendacky@amd.com,
 brijesh.singh@amd.com, ardb@kernel.org, Tianyu.Lan@microsoft.com,
 pgonda@google.com, martin.b.radev@gmail.com, akpm@linux-foundation.org,
 kirill.shutemov@linux.intel.com, rppt@kernel.org, sfr@canb.auug.org.au,
 saravanand@fb.com, krish.sadhukhan@oracle.com, aneesh.kumar@linux.ibm.com,
 xen-devel@lists.xenproject.org, rientjes@google.com, hannes@cmpxchg.org,
 tj@kernel.org, michael.h.kelley@microsoft.com
Subject: [PATCH V3 02/13] x86/HV: Initialize shared memory boundary in the
 Isolation VM.
Date: Mon,  9 Aug 2021 13:56:06 -0400
Message-Id: <20210809175620.720923-3-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210809175620.720923-1-ltykernel@gmail.com>
References: <20210809175620.720923-1-ltykernel@gmail.com>
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, parri.andrea@gmail.com,
 linux-hyperv@vger.kernel.org, linux-scsi@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dave.hansen@intel.com,
 iommu@lists.linux-foundation.org, vkuznets@redhat.com
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
index 6b5835a087a3..2b7f396ef1a5 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -313,6 +313,8 @@ static void __init ms_hyperv_init_platform(void)
 	if (ms_hyperv.priv_high & HV_ISOLATION) {
 		ms_hyperv.isolation_config_a = cpuid_eax(HYPERV_CPUID_ISOLATION_CONFIG);
 		ms_hyperv.isolation_config_b = cpuid_ebx(HYPERV_CPUID_ISOLATION_CONFIG);
+		ms_hyperv.shared_gpa_boundary =
+			(u64)1 << ms_hyperv.shared_gpa_boundary_bits;
 
 		pr_info("Hyper-V: Isolation Config: Group A 0x%x, Group B 0x%x\n",
 			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 4269f3174e58..aa26d24a5ca9 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -35,8 +35,18 @@ struct ms_hyperv_info {
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
