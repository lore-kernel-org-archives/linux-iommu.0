Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB569C43219
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 14:12:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9353E4034E;
	Mon,  6 Dec 2021 14:12:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d_SVLlld4Ips; Mon,  6 Dec 2021 14:12:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 257F44034B;
	Mon,  6 Dec 2021 14:12:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB889C0072;
	Mon,  6 Dec 2021 14:11:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54965C0012
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 14:11:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 43F6860C14
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 14:11:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t5f94V2w9dZ5 for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 14:11:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2A8526079A
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 14:11:55 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 nh10-20020a17090b364a00b001a69adad5ebso8450281pjb.2
 for <iommu@lists.linux-foundation.org>; Mon, 06 Dec 2021 06:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=c94kxaesuiraty8vU1XcHdW6Y29KA3FWH99u5YD+zaQ=;
 b=Brq2mimjObX21h84ZlwsdVqoHa8seEX14RIOTL/JqSORMB6eVFY5W7i0gDlXvB8YjD
 WHM7TR4u5wkiTCGdCVj50Oz7CNCC1x5WtKYcJYfD0qUI3XSGqi0v6hZZOtQ0dWEoLu7j
 jlBBHkFsCUXW8FU9XoF1gAp7WofnCuvPPVwYav7pHZMFb/RlNTn+eurZYyb2m1O51BnI
 t051ZXODLIeL8n2gXn6atA8nsje2TCH6TG/UXxH93W+iGFDXbp0QTQ5W+VkgqLpzLhWe
 w6NTq3PUImMcceKV6Ll95jHdYRzSwOpTd1MuPSOq1oMZaTzFltgAgThST7GxVhM3B6+4
 bKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=c94kxaesuiraty8vU1XcHdW6Y29KA3FWH99u5YD+zaQ=;
 b=J/WKjF11/eXWydz3pwbtUEpQVBpQaSqSqT8B2hu1cj1q7XuFUKkMeEQstTKLUEtXCB
 dAWFoGh8d1l0jXacfw50+qnW+iioN4Vi/pWlhKM6m0oKNkcXm0M47ZjurYgY5Fcu9qKg
 HeyC5gK4uyZRySgvRAEd6GPh3FEIDeNQgXvYTrfauVmTbvQ6/+R85CzKq6/iGIW8xRdS
 SPHCdD6m9M6pEmxSnptQaDb1qLwU5mq5/fQ3K85aPh0IRtNGcvdtt6X/xNkn/NJDFQ93
 DTAg6KNE2v11lqSEkZRWxwg02tgaVw9mg6j9CWJUYLAq4P1AZAWgxJn1mlIUSN84UNLH
 4+1w==
X-Gm-Message-State: AOAM532rwjPurZFLpQSwzQBz2NHUXexRaE986V4L0i7mnR8eU1ISMePW
 rm+otUyTalJETlbkMhcCjgk=
X-Google-Smtp-Source: ABdhPJyI7RrZ8Xex/dRl/iPF/2y+DXSSDfDYcIbgrzJbuSVZS0yQeN/8Q7NmVriRLB0HNCKMZuXpLg==
X-Received: by 2002:a17:902:9f98:b0:144:e777:f88e with SMTP id
 g24-20020a1709029f9800b00144e777f88emr44096480plq.31.1638799914443; 
 Mon, 06 Dec 2021 06:11:54 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:8:b5b5:3f40:cec1:40a0])
 by smtp.gmail.com with ESMTPSA id g19sm7717606pfc.145.2021.12.06.06.11.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Dec 2021 06:11:54 -0800 (PST)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, davem@davemloft.net, kuba@kernel.org,
 jejb@linux.ibm.com, martin.petersen@oracle.com, arnd@arndb.de,
 hch@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
 thomas.lendacky@amd.com, Tianyu.Lan@microsoft.com,
 michael.h.kelley@microsoft.com
Subject: [PATCH V5 2/5] x86/hyper-v: Add hyperv Isolation VM check in the
 cc_platform_has()
Date: Mon,  6 Dec 2021 09:11:42 -0500
Message-Id: <20211206141145.447453-3-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211206141145.447453-1-ltykernel@gmail.com>
References: <20211206141145.447453-1-ltykernel@gmail.com>
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

Hyper-V provides Isolation VM which has memory encrypt support. Add
hyperv_cc_platform_has() and return true for check of GUEST_MEM_ENCRYPT
attribute.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
Change since v3:
	* Change code style of checking GUEST_MEM attribute in the
	  hyperv_cc_platform_has().
---
 arch/x86/kernel/cc_platform.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
index 03bb2f343ddb..7b66793c0f25 100644
--- a/arch/x86/kernel/cc_platform.c
+++ b/arch/x86/kernel/cc_platform.c
@@ -11,6 +11,7 @@
 #include <linux/cc_platform.h>
 #include <linux/mem_encrypt.h>
 
+#include <asm/mshyperv.h>
 #include <asm/processor.h>
 
 static bool __maybe_unused intel_cc_platform_has(enum cc_attr attr)
@@ -58,9 +59,20 @@ static bool amd_cc_platform_has(enum cc_attr attr)
 #endif
 }
 
+static bool hyperv_cc_platform_has(enum cc_attr attr)
+{
+#if IS_ENABLED(CONFIG_HYPERV)
+	return attr == CC_ATTR_GUEST_MEM_ENCRYPT;
+#else
+	return false;
+#endif
+}
 
 bool cc_platform_has(enum cc_attr attr)
 {
+	if (hv_is_isolation_supported())
+		return hyperv_cc_platform_has(attr);
+
 	if (sme_me_mask)
 		return amd_cc_platform_has(attr);
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
