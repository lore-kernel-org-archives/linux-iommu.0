Return-Path: <SRS0=FZ/Z=M3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C232C4320A
	for <iommu@archiver.kernel.org>; Wed,  4 Aug 2021 18:45:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE20660720
	for <iommu@archiver.kernel.org>; Wed,  4 Aug 2021 18:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CE20660720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A64F860A63;
	Wed,  4 Aug 2021 18:45:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X33d0gJqNB1N; Wed,  4 Aug 2021 18:45:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9CF8360612;
	Wed,  4 Aug 2021 18:45:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78A30C001A;
	Wed,  4 Aug 2021 18:45:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36534C000E
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 18:45:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2531B60A38
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 18:45:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Aib-QbXa1LwK for <iommu@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 18:45:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9761A608DE
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 18:45:28 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id j1so4335902pjv.3
 for <iommu@lists.linux-foundation.org>; Wed, 04 Aug 2021 11:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4UOe5b2fx3Fh6u6Lqilgce/bFIZGpTYCRKnCgcNYEYs=;
 b=NSH/LJRx35rv2Coaect5ebgngqcRbKdFYRhidD5HVV5WQJ6WgjqN12zsAK/Gkyy/7x
 I+8VVT2Mhji0abHf/4jevoNiqwA2z7AmqJJVhMzUjdfoVd85qVx8uMqrxdgmtcLVb8lb
 U81wGAO1FRvQOYHaKxIbPqzzd3/XAOzV0ItIJ6C84F4cFY/LOvV8nCJUAumysIFMIv2f
 ZmUlz8s+pI1p+14JTXmlgoJTnXDIzGQ798aDHtD7uRw0m/ZW+926eQUGYXfO/+c8JHxA
 lwxp04iNL7R8HklDJ+fqB1ltRK00B3Q2EOwhwQpIOQvtt2GkuXmjdei+LviGqNTXKo/P
 QtVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4UOe5b2fx3Fh6u6Lqilgce/bFIZGpTYCRKnCgcNYEYs=;
 b=XZrRNpFS59rwCZDCr2ShuLHdsS+REz9GW/M/SzfY9fA+EgBfb7uBFahkRQy9Z7CwXj
 JW6LFYZCORp1eLVoawA3dmIZoLCadq6mKqAHwBC1vcwYv8jsQk5+d1glEvCez2lQGLsM
 Zchh1Y4MmFIRCuiJ9qrwbc9sMcmbcLygnJp9LjfOOMFkiWdatMkcsCJAXj74t78CIMg7
 ZW9okoAhz7LD/O49SRKfhLhwkSnvnumRmUHxE0FQIIC2aWiWrUqfCUhABlXusIvCxBRA
 ACeb3CxZkISHHMTth8fr1G+PlnqIxU+NwVlwAvyrjDlcXNYzuhg5ZAMBd346PRYL6YZi
 fTOA==
X-Gm-Message-State: AOAM533x682JZc11PuL9gzpBOl0uCBdnX75j13FeIZ+PO6kSJh7x1wAB
 WmqBqLm2wgwyS1JhjgJ1QL0=
X-Google-Smtp-Source: ABdhPJxPyx87KdC9aGTdRDzgUUm8YpYNF92sxS8SZIEQhtuiHOOQQbprX6PFum9C1CwkqaEKm/aS0w==
X-Received: by 2002:a17:90b:34e:: with SMTP id
 fh14mr530326pjb.100.1628102728038; 
 Wed, 04 Aug 2021 11:45:28 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:f:1947:6842:b8a8:6f83])
 by smtp.gmail.com with ESMTPSA id f5sm3325647pjo.23.2021.08.04.11.45.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Aug 2021 11:45:27 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, jgross@suse.com,
 sstabellini@kernel.org, joro@8bytes.org, will@kernel.org,
 davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, arnd@arndb.de, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com, Tianyu.Lan@microsoft.com,
 rppt@kernel.org, kirill.shutemov@linux.intel.com,
 akpm@linux-foundation.org, brijesh.singh@amd.com, thomas.lendacky@amd.com,
 pgonda@google.com, david@redhat.com, krish.sadhukhan@oracle.com,
 saravanand@fb.com, aneesh.kumar@linux.ibm.com,
 xen-devel@lists.xenproject.org, martin.b.radev@gmail.com, ardb@kernel.org,
 rientjes@google.com, tj@kernel.org, keescook@chromium.org,
 michael.h.kelley@microsoft.com
Subject: [PATCH V2 02/14] x86/HV: Initialize shared memory boundary in the
 Isolation VM.
Date: Wed,  4 Aug 2021 14:44:58 -0400
Message-Id: <20210804184513.512888-3-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210804184513.512888-1-ltykernel@gmail.com>
References: <20210804184513.512888-1-ltykernel@gmail.com>
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, parri.andrea@gmail.com,
 linux-hyperv@vger.kernel.org, linux-scsi@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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
index dcfbd2770d7f..773e84e134b3 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -327,6 +327,8 @@ static void __init ms_hyperv_init_platform(void)
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
