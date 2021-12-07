Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D09C43217
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 07:56:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 055A5607C2;
	Tue,  7 Dec 2021 07:56:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KG5lqfCZy9sJ; Tue,  7 Dec 2021 07:56:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0674460D9D;
	Tue,  7 Dec 2021 07:56:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B75F5C0030;
	Tue,  7 Dec 2021 07:56:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90D14C0071
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 07:56:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 70D6F607C8
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 07:56:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bNmlAkuFpP0R for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 07:56:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EB41960760
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 07:56:07 +0000 (UTC)
Received: by mail-pl1-x629.google.com with SMTP id p18so8835318plf.13
 for <iommu@lists.linux-foundation.org>; Mon, 06 Dec 2021 23:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/5M9gOfMUisREUkN0oMDl3d5AgAs/rybQfOBV8c7GG0=;
 b=iqMBIlwZ0cRMihL7ebFJzQtnX9gzY8f/Gm2aKiyj/dGxhCyKv5GRhzBpl9NhhQf5Ki
 YauW6iCaVM+V7sWtMpLOPLmOPjg9/BIMvQ0b1wuOkR8TcY3WEujZIqbGpF5f3cw6/06b
 69V2kLpNyPwzybu2vn5o9cRG5Uz6RHC0HwESSGM/r1HIN1AhaPbIGU47hRZ5nwiWWg1e
 gQkfLpRIm3z+OYUAqzGEkm1vChWfc7flJlcj2dBpJlByKd9vDfOLtQflSeYO/abZs5WR
 MCL34gCWxwnyzqBxdthcCJ4C+T8SL3YtulbJgNv6i00TgK+w0a6w+YEtDPbvfTlzg2y3
 wbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/5M9gOfMUisREUkN0oMDl3d5AgAs/rybQfOBV8c7GG0=;
 b=mVnTU/YlXAJJe47+18GNUlgsikEAdd69JbwERMUJ08u2Lgov52o2dbFgNPh1fSvg22
 UDPqeK8QHWVD5n7XpUwYHxKkWPot0HW0eKcZOEP/1I9RWPan639WrFFYiBDDmPcqxMZL
 vOa+lnGHDB3FSIgGMrcZWqRvgamverARteO26tMTKqM07UrSHnFO73gLx3LYRwBBpyN9
 QMLUtcx3jCsU1265wlkREfYwzDNOeOXCmdEcHKC6zggt4uWLKkiaGifxKiIXhqLVbGT/
 D7nqKGNc3wEsshCqS3yjKWLmQ6Nh0BKPfq0Hp4xYBubX44cQucrExGONf5/e8eYJKWT/
 bUaw==
X-Gm-Message-State: AOAM5311+9LoHXH8/geECblUIkzZwmPCpW+B5AaGRxs25IeP5lWJAvtX
 UUXEEwhhxvyouIigzXf29zs=
X-Google-Smtp-Source: ABdhPJzmSQygtcV32AiUSqniemv899Kpepc9kNHnUv4WZ8zdPUOplc9hqggQY5r9lcsEO2Agyr2q0Q==
X-Received: by 2002:a17:90a:6a82:: with SMTP id
 u2mr4795405pjj.105.1638863767382; 
 Mon, 06 Dec 2021 23:56:07 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:0:a463:d753:723:c3a9])
 by smtp.gmail.com with ESMTPSA id n15sm1794353pgs.59.2021.12.06.23.56.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Dec 2021 23:56:07 -0800 (PST)
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
Date: Tue,  7 Dec 2021 02:55:58 -0500
Message-Id: <20211207075602.2452-3-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211207075602.2452-1-ltykernel@gmail.com>
References: <20211207075602.2452-1-ltykernel@gmail.com>
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
