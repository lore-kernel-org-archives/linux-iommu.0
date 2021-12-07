Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6B7C43217
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 07:20:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8630E41C82;
	Tue,  7 Dec 2021 07:20:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0_W6sET0IiJL; Tue,  7 Dec 2021 07:20:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 735D941C83;
	Tue,  7 Dec 2021 07:20:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0ED90C0072;
	Tue,  7 Dec 2021 07:20:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A107FC0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 07:20:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7D64A4018A
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 07:20:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eMEPU2-JiONj for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 07:20:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BD76C40284
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 07:20:01 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id n8so8807917plf.4
 for <iommu@lists.linux-foundation.org>; Mon, 06 Dec 2021 23:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/5M9gOfMUisREUkN0oMDl3d5AgAs/rybQfOBV8c7GG0=;
 b=HQHILh0xfC+iio9HXP69cg5B0dsEbz8x0SgxiL8EZOWUxKe6Ml6IwPDIHHaNOYrcA1
 Xxvzo2aLk6XNd843SAFKVx1Dfou84UVuugLsqXZeTUDDctogYBzWrIGSmK415TugOxuy
 fYdJ9D/jc82SQXAHeSye2vTPxLZSWB5ptOmKVXHtmi2TfuDes14mH+msFJYGnR78L+Y0
 LCioRvoUtQhcvkrYfuHIryPrZE4eTO7N2JuqU2XNKLwk8LEQhj48TJZP6ywFHHRuNYax
 q2TWgArPWgAg4RXVBaPnCD53dqA79mOKKFB5cL7wxyoMc4w1z/2kiA9dDR7KEgFiUG/5
 LEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/5M9gOfMUisREUkN0oMDl3d5AgAs/rybQfOBV8c7GG0=;
 b=Ai/+Pwg00m6Ge7z1Vt1CaZX08gfEWGSN2Tk9sVy9hken+l5821fIc+FBF3mqiCtjys
 hwxGDCCSF4BSOKe3ttfj0PD3ayimDGW3APZsM/82G8TdjfOWpyHWvbr6qYwClfAu4TOT
 n1dj2v+KR+5S5Zai+WYtnSyI3ikzoTHhmlgWxQW/MzLTDXcFSfZMxkTGequbQRH054me
 T63CbYtmVKn8Guxaw9ROUy/RDqeFehNpmXVQ1gPoNtLHIEIexbuPcWPFctWY8RquMm1j
 pIS+R0lKnM/5dBZFWis4a8bAyeafgQRpVTOqC/31dEbOr7Mba1xqGLbVgjSEF8TBfr+j
 ALng==
X-Gm-Message-State: AOAM5316XKzAdp+RTmLTcA8MGz+utWWmNZe8IItvkAZ73jblhghL8QDD
 KFDz3E9hcZv5d+beYPOs69I=
X-Google-Smtp-Source: ABdhPJy/mQHIDBNoBo1q+GH/lMBNnM+gLAlWH9a0/39dNkp3kkA+Nzc597FxFq/ZQE4xMfrbxf8ZSQ==
X-Received: by 2002:a17:902:82c9:b0:142:401f:dc9 with SMTP id
 u9-20020a17090282c900b00142401f0dc9mr50143445plz.43.1638861601201; 
 Mon, 06 Dec 2021 23:20:01 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:38:e747:5b78:1904:a4ed])
 by smtp.gmail.com with ESMTPSA id u12sm2081789pfk.71.2021.12.06.23.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Dec 2021 23:20:00 -0800 (PST)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, davem@davemloft.net, kuba@kernel.org,
 jejb@linux.ibm.com, martin.petersen@oracle.com, arnd@arndb.de,
 hch@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
 Tianyu.Lan@microsoft.com, thomas.lendacky@amd.com,
 michael.h.kelley@microsoft.com
Subject: [PATCH V6 2/5] x86/hyper-v: Add hyperv Isolation VM check in the
 cc_platform_has()
Date: Tue,  7 Dec 2021 02:19:38 -0500
Message-Id: <20211207071942.472442-3-ltykernel@gmail.com>
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

Hyper-V provides Isolation VM which has memory encrypt support. Add
hyperv_cc_platform_has() and return true for check of GUEST_MEM_ENCRYPT
attribute.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
Change since v3:
	* Change code style of checking GUEST_MEM attribute in the
	  hyperv_cc_platform_has().
---
 arch/x86/kernel/cc_platform.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
index 03bb2f343ddb..47db88c275d5 100644
--- a/arch/x86/kernel/cc_platform.c
+++ b/arch/x86/kernel/cc_platform.c
@@ -11,6 +11,7 @@
 #include <linux/cc_platform.h>
 #include <linux/mem_encrypt.h>
 
+#include <asm/mshyperv.h>
 #include <asm/processor.h>
 
 static bool __maybe_unused intel_cc_platform_has(enum cc_attr attr)
@@ -58,9 +59,16 @@ static bool amd_cc_platform_has(enum cc_attr attr)
 #endif
 }
 
+static bool hyperv_cc_platform_has(enum cc_attr attr)
+{
+	return attr == CC_ATTR_GUEST_MEM_ENCRYPT;
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
