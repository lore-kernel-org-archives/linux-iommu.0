Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460DDC433EF
	for <iommu@archiver.kernel.org>; Mon, 13 Dec 2021 07:14:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E81A3409BC;
	Mon, 13 Dec 2021 07:14:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 67xwLMbeA1Zh; Mon, 13 Dec 2021 07:14:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9A3A040965;
	Mon, 13 Dec 2021 07:14:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8313AC001E;
	Mon, 13 Dec 2021 07:14:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A402C0012
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 07:14:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4705260EF8
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 07:14:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jksv0EE2xHWT for <iommu@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 07:14:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B81C960EF7
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 07:14:23 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 j6-20020a17090a588600b001a78a5ce46aso14020522pji.0
 for <iommu@lists.linux-foundation.org>; Sun, 12 Dec 2021 23:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LTLz7GgAX11MfClfWm4VByenkQJ5cwVcinYkI0CYydg=;
 b=eIBO98gr6cqdhEubdZxn7qJbRXcsGJcQJKCTBTWQMyIeHrNp5xrHWYdAoKYNVGEidJ
 LFwP3LjGoL5tFuzB2FoB5YpZg5bwVmowqjbEIb8AsmhZerCmxw86+voMBrO3FdsH4LZ1
 v8oAohgYKdqLsMvZ/GTDqezGmPqe06lPPdMYJ8kKDtdDCRGI+T2u1D6j25qAwdvo7zlI
 679EHAHUZ/Q7woRuLMzvvmv9YQOH/DT1Dkg52bG9+CtfhWhBq/5McohZ6K/5TT2Unmva
 iRnNz4FNW2NV5wXk4ssnY1Wipt5DNixWOWnYmq/MRnkkFwLm0dKEKvTE3IQj4PHbr8gx
 d9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LTLz7GgAX11MfClfWm4VByenkQJ5cwVcinYkI0CYydg=;
 b=ADcWyQDKsbs/hvSQdv4f/jtzSj35uJLqCrmaqK6QBZMIE+raEZpA5Kcy0FAqcqYyQk
 2c7elFFKdoo6WvVhW0S2DeSFyGnW9zlA4Tk2GC5BlU0jXEGtYQha9IKi3OzElx0y+sXs
 3I8cZmpGZuUEMPzkvBjDYG9jbZd5uNp5KUNKtcFFU2729amMDCQQsgmRjjaAFkUEsUaj
 /1U8U1GKgGMxlcyRJqM1eFImbt4GyN0iMYmB4psYIi9a+Iavbtk4JfG9dYH/vihdtnFR
 3PPxnOE3vXv8+2sxzKlWQ/gittx2B9GpMAIeL+TeYKbYlUmacJvRCY8pajTrn/5AjpqN
 +NhA==
X-Gm-Message-State: AOAM53250yCHFhpWB9vAA4ihZnTYCePxZAT1LO4kUnACDzJPHF6tSh7j
 mt6V86VPmvb4NPhDzpYmLYo=
X-Google-Smtp-Source: ABdhPJwyUng+IRJS7MH80C/GEuQWaWTRNRKCx4z2HRH688KUyKHYm7NSiU3shK/X0mt0z+tL2buWiw==
X-Received: by 2002:a17:902:c947:b0:141:e7f6:d688 with SMTP id
 i7-20020a170902c94700b00141e7f6d688mr92839450pla.56.1639379663188; 
 Sun, 12 Dec 2021 23:14:23 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:36:a586:a4cb:7d3:4f27])
 by smtp.gmail.com with ESMTPSA id qe12sm6079401pjb.29.2021.12.12.23.14.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Dec 2021 23:14:22 -0800 (PST)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, davem@davemloft.net, kuba@kernel.org,
 jejb@linux.ibm.com, martin.petersen@oracle.com, arnd@arndb.de,
 hch@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
 thomas.lendacky@amd.com, Tianyu.Lan@microsoft.com,
 michael.h.kelley@microsoft.com
Subject: [PATCH V7 2/5] x86/hyper-v: Add hyperv Isolation VM check in the
 cc_platform_has()
Date: Mon, 13 Dec 2021 02:14:03 -0500
Message-Id: <20211213071407.314309-3-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213071407.314309-1-ltykernel@gmail.com>
References: <20211213071407.314309-1-ltykernel@gmail.com>
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

Hyper-V provides Isolation VM for confidential computing support and
guest memory is encrypted in it. Places checking cc_platform_has()
with GUEST_MEM_ENCRYPT attr should return "True" in Isolation vm. e.g,
swiotlb bounce buffer size needs to adjust according to memory size
in the sev_setup_arch(). Add GUEST_MEM_ENCRYPT check for Hyper-V Isolation
VM.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
Change since v6:
	* Change the order in the cc_platform_has() and check sev first.

Change since v3:
	* Change code style of checking GUEST_MEM attribute in the
	  hyperv_cc_platform_has().
---
 arch/x86/kernel/cc_platform.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
index 03bb2f343ddb..6cb3a675e686 100644
--- a/arch/x86/kernel/cc_platform.c
+++ b/arch/x86/kernel/cc_platform.c
@@ -11,6 +11,7 @@
 #include <linux/cc_platform.h>
 #include <linux/mem_encrypt.h>
 
+#include <asm/mshyperv.h>
 #include <asm/processor.h>
 
 static bool __maybe_unused intel_cc_platform_has(enum cc_attr attr)
@@ -58,12 +59,19 @@ static bool amd_cc_platform_has(enum cc_attr attr)
 #endif
 }
 
+static bool hyperv_cc_platform_has(enum cc_attr attr)
+{
+	return attr == CC_ATTR_GUEST_MEM_ENCRYPT;
+}
 
 bool cc_platform_has(enum cc_attr attr)
 {
 	if (sme_me_mask)
 		return amd_cc_platform_has(attr);
 
+	if (hv_is_isolation_supported())
+		return hyperv_cc_platform_has(attr);
+
 	return false;
 }
 EXPORT_SYMBOL_GPL(cc_platform_has);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
