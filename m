Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75329C28D17
	for <iommu@archiver.kernel.org>; Sun,  5 Dec 2021 08:18:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2441460A7C;
	Sun,  5 Dec 2021 08:18:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TzGi6oXPfSfw; Sun,  5 Dec 2021 08:18:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0661660632;
	Sun,  5 Dec 2021 08:18:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8D2CC002F;
	Sun,  5 Dec 2021 08:18:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98939C0012
 for <iommu@lists.linux-foundation.org>; Sun,  5 Dec 2021 08:18:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0E66482B1A
 for <iommu@lists.linux-foundation.org>; Sun,  5 Dec 2021 08:18:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FzDZsFAjIolQ for <iommu@lists.linux-foundation.org>;
 Sun,  5 Dec 2021 08:18:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 96A5E82B51
 for <iommu@lists.linux-foundation.org>; Sun,  5 Dec 2021 08:18:21 +0000 (UTC)
Received: by mail-pg1-x533.google.com with SMTP id r5so7405300pgi.6
 for <iommu@lists.linux-foundation.org>; Sun, 05 Dec 2021 00:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4R1/x5dPl8v2bhM1Wqw8GMKwcXKdEyhlm+eRit5majU=;
 b=a199mwwb41SK+3g5nwV1xKmU5gwizT35AAVUi8EUk8s8aLOnPfOSMZ+DMLR46xQuuT
 MqpKzZctmq0YmBBHMP3tAH2eroIBBD8cjLj9PwaEnB2C+snyDUEO0j82lTDGHRmYP/Ig
 bOlyN98YpBfGN+bx8S2gYeEnhpOJjbcYfo8JrVl6Zu9l3rXzJxaFYHM8Fh6XecuDTX9k
 5k2jwAETpzg9EPf0K2t1k+SG8YOophQYDcE2OtnxPueV/d+iE6faWflgKeHhF2CU0RAD
 qzeN6hrSJXIMDWCljoYMoMo+3fsMt5kyd2hroMZAspPvmtkNm8//oYiJKnc/mtxPyMW4
 vQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4R1/x5dPl8v2bhM1Wqw8GMKwcXKdEyhlm+eRit5majU=;
 b=iNDmsWg+aWFEYP1jGlGbFrNMIteUfGJ1lSV6Rsz2aBfYhv8gMEOte/KXKZyINV2Nv7
 Kw0UBV2JsCN9MbiNzRZmGOE++4Dv3M0++x4975KzGFBtAkSvy3HvIbJU2KXvYpaJBbFi
 o8Qog96HBOCPUqoTZU6ywoVvpsBo1CI2P+4UWLEeXC5/iXDlYB5Agu+d/3wkLGvyQ8SU
 BmuD0ZEuYJ3DwU07BNG7ZI/J/lgUT0fLMA2TYdpQjU52nKrDdYNWAQxYz32wlo3oytpB
 X/A5TXlMFY7nAyzLR7k5yi1Y1lFb6XE8Fv79/vWHYjtBz3TWaEwF6Yx0x46IKtxGEzw5
 cr5w==
X-Gm-Message-State: AOAM532nrSatXa0GQZBKMBOUfaf5PdnCPzmCT4dYLjEg0bRTvjXB5Dhi
 G/hvpKh5lLuT4j/ntUOvxWs=
X-Google-Smtp-Source: ABdhPJwjVr/PR4pWsnzxcrhE9ySNvBZumxc7tiGS3XuTHA+biQhguZE4c/ixNuJ3guQaZnB9mhHD+w==
X-Received: by 2002:a05:6a00:1741:b0:4ad:55e0:55b with SMTP id
 j1-20020a056a00174100b004ad55e0055bmr3973425pfc.58.1638692301062; 
 Sun, 05 Dec 2021 00:18:21 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:7:87aa:e334:f070:ebca])
 by smtp.gmail.com with ESMTPSA id s8sm6439905pgl.77.2021.12.05.00.18.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Dec 2021 00:18:20 -0800 (PST)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, jgross@suse.com, sstabellini@kernel.org,
 boris.ostrovsky@oracle.com, joro@8bytes.org, will@kernel.org,
 davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, arnd@arndb.de, hch@infradead.org,
 m.szyprowski@samsung.com, robin.murphy@arm.com, thomas.lendacky@amd.com,
 Tianyu.Lan@microsoft.com, xen-devel@lists.xenproject.org,
 michael.h.kelley@microsoft.com
Subject: [PATCH V4 2/5] x86/hyper-v: Add hyperv Isolation VM check in the
 cc_platform_has()
Date: Sun,  5 Dec 2021 03:18:10 -0500
Message-Id: <20211205081815.129276-3-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211205081815.129276-1-ltykernel@gmail.com>
References: <20211205081815.129276-1-ltykernel@gmail.com>
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
index 03bb2f343ddb..27c06b32e7c4 100644
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
+#ifdef CONFIG_HYPERV
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
