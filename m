Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F12C4332F
	for <iommu@archiver.kernel.org>; Tue, 23 Nov 2021 14:37:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 144B7403F7;
	Tue, 23 Nov 2021 14:37:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eVOBKm6g083B; Tue, 23 Nov 2021 14:37:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8DF4740400;
	Tue, 23 Nov 2021 14:37:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5DAB8C0037;
	Tue, 23 Nov 2021 14:37:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89288C0012
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 14:36:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7561E403F7
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 14:36:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lbrTImlZdlGr for <iommu@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 14:36:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B68BD401C7
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 14:36:58 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id o14so17235073plg.5
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 06:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=i+xUpMEUxrmLaLZETYGitNsZhfrMVhJB1Bk6Yp08byU=;
 b=AlKcv7Y4VFkVezS6aJXAds/NWYnLHTHgFDawHsIGURkEQw1ZQprC+xxgttepVcIQUM
 5T5M0RL+DPFTteQFgNGSjajmwgRX1J2Y5QsSwTqvWdVg1A+EWhpdaWNqmbKB24YbhnwY
 VTf6iEPD2bD9xmmRrEK7FLp6gAd4SMfhDEAaTdaySH6ygkl9daOZYS/EkqwnTKSZglAK
 egCsNvtL8/Q16NYzGtBDx6YW50D+dp/CauiDtizCo8lfzW3y900HzjaUttJ2TmSaJV4N
 ShJbzW4YSovU0kpEhKAaY2ps0ZKmQFzKQmxGR0raTUS1hPCogFjcj1BjeQYlXNYc4eIF
 EFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=i+xUpMEUxrmLaLZETYGitNsZhfrMVhJB1Bk6Yp08byU=;
 b=Jouk5V5xnQqmGeZFaEUBIaXkLsUdvc3YzlVCMnSyBpnAg7HuSDI4qXYppAGuoRjIn9
 eUkd9qZLLD5TC8q8TkxDENCY0Pd65Ygv+VK/lqabNGW6ISD2VltQChdhWiy6Larrqnf/
 U4hD+QOdR6U7QTMseXxWwEXvfdJUnkQaLcCwV4BVE3m1b16inBnUl9vg68jcsdar5bvB
 MVjjwSbHVY2Rs7QWOXKwM83M2E9bpIEGgeHkfoNp2/INa3dMCsUkIOZG8XwiIQARC4vZ
 G0MLEqn7Dpj6VlapjskwuFcrhLlMjavDIqvpzX/lkfHuXXkTwO2ysH7y+WFUBVmi47f8
 YnXA==
X-Gm-Message-State: AOAM531R/gtwJjw9iCbDvc2nytt+wBVkLGjFLsl8oidj++iGURXkUsFi
 SdegOzEuIPDLPsoaZA+FCmY=
X-Google-Smtp-Source: ABdhPJwRbhdcFhTlrcl5ARyO8E5M5xT/1VQMfqX2FgiEinsxJqYW1NtlXEltffF5Oag+q0rt470N+g==
X-Received: by 2002:a17:90b:180b:: with SMTP id
 lw11mr3650766pjb.108.1637678218159; 
 Tue, 23 Nov 2021 06:36:58 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:1:af65:c3d4:6df:5a8b])
 by smtp.gmail.com with ESMTPSA id j13sm11926127pfc.151.2021.11.23.06.36.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Nov 2021 06:36:57 -0800 (PST)
From: Tianyu Lan <ltykernel@gmail.com>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 luto@kernel.org, peterz@infradead.org, jgross@suse.com,
 sstabellini@kernel.org, boris.ostrovsky@oracle.com, kys@microsoft.com,
 haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, joro@8bytes.org, will@kernel.org, davem@davemloft.net,
 kuba@kernel.org, jejb@linux.ibm.com, martin.petersen@oracle.com,
 hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
 Tianyu.Lan@microsoft.com, thomas.lendacky@amd.com,
 xen-devel@lists.xenproject.org, michael.h.kelley@microsoft.com
Subject: [PATCH V2 3/6] x86/hyper-v: Add hyperv Isolation VM check in the
 cc_platform_has()
Date: Tue, 23 Nov 2021 09:30:34 -0500
Message-Id: <20211123143039.331929-4-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211123143039.331929-1-ltykernel@gmail.com>
References: <20211123143039.331929-1-ltykernel@gmail.com>
MIME-Version: 1.0
Cc: parri.andrea@gmail.com, linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 linux-scsi@vger.kernel.org, konrad.wilk@oracle.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dave.hansen@intel.com,
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

Hyper-V provides Isolation VM which has memory encrypt support. Add
hyperv_cc_platform_has() and return true for check of GUEST_MEM_ENCRYPT
attribute.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 arch/x86/kernel/cc_platform.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
index 03bb2f343ddb..f3bb0431f5c5 100644
--- a/arch/x86/kernel/cc_platform.c
+++ b/arch/x86/kernel/cc_platform.c
@@ -11,6 +11,7 @@
 #include <linux/cc_platform.h>
 #include <linux/mem_encrypt.h>
 
+#include <asm/mshyperv.h>
 #include <asm/processor.h>
 
 static bool __maybe_unused intel_cc_platform_has(enum cc_attr attr)
@@ -58,9 +59,23 @@ static bool amd_cc_platform_has(enum cc_attr attr)
 #endif
 }
 
+static bool hyperv_cc_platform_has(enum cc_attr attr)
+{
+#ifdef CONFIG_HYPERV
+	if (attr == CC_ATTR_GUEST_MEM_ENCRYPT)
+		return true;
+	else
+		return false;
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
