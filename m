Return-Path: <SRS0=7Zqx=JL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11AEC43611
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 14:50:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 812B26117A
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 14:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 812B26117A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 481A884579;
	Wed, 14 Apr 2021 14:50:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RtqVZ1Af2570; Wed, 14 Apr 2021 14:50:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 35AE98456C;
	Wed, 14 Apr 2021 14:50:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEA0EC000A;
	Wed, 14 Apr 2021 14:50:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 909EAC000A
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 14:50:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7801B8456A
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 14:50:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id utW8px4ZTg7X for <iommu@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 14:50:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E6EDA84568
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 14:50:26 +0000 (UTC)
Received: by mail-pl1-x633.google.com with SMTP id p16so6280241plf.12
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 07:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Iz6kQKmaAStJz2j939/tUEj2NIuTRDYIEtDill+C7IA=;
 b=D2taYVTe0z905CX87qYISBKtJJpcQncx/+jlzFtm+dqJ1FQrZXjYZ180oWEO28Y5y7
 hlj6+yRPwjy4zDBc0qTSTOI4n3R9lkebe1U3i+D2ckp00qt3mqEM+7XERpL1KMDNXJn4
 7wjSfLucr+uk3vZczBhcDhkKTijEPUzFZEFYwB9fuw000bOFSdkhpR5X452OAoNmDZSB
 6R6DV6d3gKGUbhWxGXR8WhVAEQ7hP4x7wYAWlA87Le8gNxzh+cepaPjZjUSKkvMtMjhr
 s43ZTcJK8Kv06ThNFTuC2wlW97YulfZnT+41LKU+KQPRORDoo8Bg8JSixilt/nL1ihKW
 mQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Iz6kQKmaAStJz2j939/tUEj2NIuTRDYIEtDill+C7IA=;
 b=jdk0kQ0oa1FGnySU42oxNKNtGf4Mbbfst1cTP1j8xbMjZJgpLeAiuFZMZqDzwts5vv
 spbUvyjMw4AFlj64Ri01/4Cb0yU87eCulmDAN8Gre81NYOvjuyZNBOZcrA2MZUB0LoWV
 p6gcYEDz8kwqadn2eRKDtrqyjqQKuLDXqKPRN2gapID13pYt4SwBBeWF8s72KGmQuetU
 ZZeS9PirnYtusPzYABqtKWVu7Pq1mfl8Kn2T/WWOBpK48wrxbLgSTIZgOEX+nbI6wP6V
 G5OgvOoX+lSE6k7RYSHxsWNjR63JEkUd67OdpgPRIdZvYHHo6Fi9pa//sIQL0m+RSrRK
 LN6A==
X-Gm-Message-State: AOAM531yrtyyc49awmREzWTt4hoL8lfa/RDc8H04bI7rI5Z9Cr44glzx
 j3BOCEPyMYW74HsaADffJFs=
X-Google-Smtp-Source: ABdhPJwoWQUtM+Kmo2QdePpZgHK8I2K8arUG2KPZ/TVvHugCh22W4iDEwoDeLZUiglDRWNvFY5wZBA==
X-Received: by 2002:a17:90a:bf17:: with SMTP id
 c23mr4103212pjs.12.1618411826429; 
 Wed, 14 Apr 2021 07:50:26 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:35:ebad:12c1:f579:e332])
 by smtp.gmail.com with ESMTPSA id w67sm17732522pgb.87.2021.04.14.07.50.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Apr 2021 07:50:26 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 x86@kernel.org, hpa@zytor.com, arnd@arndb.de, akpm@linux-foundation.org,
 gregkh@linuxfoundation.org, konrad.wilk@oracle.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com, joro@8bytes.org,
 will@kernel.org, davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com
Subject: [Resend RFC PATCH V2 02/12] x86/HV: Initialize shared memory boundary
 in Isolation VM
Date: Wed, 14 Apr 2021 10:49:35 -0400
Message-Id: <20210414144945.3460554-3-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210414144945.3460554-1-ltykernel@gmail.com>
References: <20210414144945.3460554-1-ltykernel@gmail.com>
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, thomas.lendacky@amd.com,
 linux-hyperv@vger.kernel.org, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, brijesh.singh@amd.com, vkuznets@redhat.com,
 sunilmut@microsoft.com
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

Hyper-V exposes shared memory boundary via cpuid HYPERV_
CPUID_ISOLATION_CONFIG and store it in the shared_gpa_
boundary of ms_hyperv struct. This prepares to share
memory with host for AMD SEV SNP guest.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 arch/x86/kernel/cpu/mshyperv.c |  2 ++
 include/asm-generic/mshyperv.h | 13 ++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index e88bc296afca..aeafd4017c89 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -328,6 +328,8 @@ static void __init ms_hyperv_init_platform(void)
 	if (ms_hyperv.features_b & HV_ISOLATION) {
 		ms_hyperv.isolation_config_a = cpuid_eax(HYPERV_CPUID_ISOLATION_CONFIG);
 		ms_hyperv.isolation_config_b = cpuid_ebx(HYPERV_CPUID_ISOLATION_CONFIG);
+		ms_hyperv.shared_gpa_boundary =
+			(u64)1 << ms_hyperv.shared_gpa_boundary_bits;
 
 		pr_info("Hyper-V: Isolation Config: Group A 0x%x, Group B 0x%x\n",
 			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index c6f4c5c20fb8..b73e201abc70 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -34,8 +34,19 @@ struct ms_hyperv_info {
 	u32 max_vp_index;
 	u32 max_lp_index;
 	u32 isolation_config_a;
-	u32 isolation_config_b;
+	union
+	{
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
