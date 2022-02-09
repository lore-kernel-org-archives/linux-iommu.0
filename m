Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEECAC43217
	for <iommu@archiver.kernel.org>; Wed,  9 Feb 2022 12:23:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7752381309;
	Wed,  9 Feb 2022 12:23:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JbKKNzsIA6oH; Wed,  9 Feb 2022 12:23:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6BA8480BCF;
	Wed,  9 Feb 2022 12:23:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2674BC0077;
	Wed,  9 Feb 2022 12:23:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2396AC000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 12:23:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 11F5382A0E
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 12:23:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x4hValqJijQN for <iommu@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 12:23:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 915F0829A9
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 12:23:27 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id
 d9-20020a17090a498900b001b8bb1d00e7so2047833pjh.3
 for <iommu@lists.linux-foundation.org>; Wed, 09 Feb 2022 04:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gHeTaNHwKSwgi47qQAMrwwvH4JdfELhdvY0tFE0Qdgg=;
 b=S4UvQ+/nM+8fNSw1PE4f+4FCLumVlciBxAOJ92AgHiZW5Ix90CFkrXBfCJanEy1u1i
 h327fu0yGbej2+hz5q+Zr0jyauX4+htYZAfhTLDCwNO2q1P4ImBDYBAkWo7RPHALengd
 kDUQWdymGHyVPMuDDkXrx08iNMBIZlw8riENN2e+BqMa+rRIHJdTVFbay4OuPv2cWXVJ
 Go/F0Wn7BvcSKRVOMdKi65o/pnm3jzVTWYQdyW5blerbNx580YsOv35CvZnKjZQwwd94
 n94rOuGsjXEn3fK3r+Ugv5VolUI/8ppVsMa0ccRAf15Vg5NteIKxqt7svtTCD3RALfd7
 MJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gHeTaNHwKSwgi47qQAMrwwvH4JdfELhdvY0tFE0Qdgg=;
 b=v56vG5DnvH/Ay0pDw6247cMaGYQbBnDygxPGDtH9qBBPNh1rEG98305DqIUB5Wbkny
 wgd2DWlo2clxmb9e+oBUfjKUgC91+zOSz1ZE9j9GdTSyvhHU8ArQUWvZL5OtTT4IMcV4
 6RuM6Rjbr1aNkKFtMS+mQBKQmGspzdCQTf019sjX2uKlFKeUJge8DBEJfzSUJr3RjeNI
 zwlbdMggVUqlzCvDlD1RrNKriB+86vWS/FnzmQk3lxeCWXeqVTq3bvR2EFOIvOYGGEzA
 RnDlM0lLeowvDCY9NsZafaFgfbeSTPgUImgSIt68uCStZaHzEZGHqxQ0I5HB60wbGk0m
 +CsA==
X-Gm-Message-State: AOAM532ZtjnjWuSRD+v4E9njjIU9USNhU9sckQH/3EqWYBDl7gIrB1BO
 tvwo1N+6fF6t5R32WCmbaDs=
X-Google-Smtp-Source: ABdhPJwVRhlS8xFIf1Zk17POR18zyrDa+Pemk4xck9NefmzGyh/YFa/RyzlAaK6sHR+JvpUJrSy0lg==
X-Received: by 2002:a17:902:b185:: with SMTP id
 s5mr2181136plr.123.1644409407053; 
 Wed, 09 Feb 2022 04:23:27 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:a:9d5c:32bf:5c81:da87])
 by smtp.gmail.com with ESMTPSA id lb3sm6300990pjb.47.2022.02.09.04.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Feb 2022 04:23:26 -0800 (PST)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, hch@infradead.org, m.szyprowski@samsung.com,
 robin.murphy@arm.com, michael.h.kelley@microsoft.com
Subject: [PATCH V2 2/2] x86/hyperv: Make swiotlb bounce buffer allocation not
 just from low pages
Date: Wed,  9 Feb 2022 07:23:02 -0500
Message-Id: <20220209122302.213882-3-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209122302.213882-1-ltykernel@gmail.com>
References: <20220209122302.213882-1-ltykernel@gmail.com>
MIME-Version: 1.0
Cc: parri.andrea@gmail.com, thomas.lendacky@amd.com,
 linux-hyperv@vger.kernel.org, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, brijesh.singh@amd.com, vkuznets@redhat.com,
 hch@lst.de
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

In Hyper-V Isolation VM, swiotlb bnounce buffer size maybe 1G at most
and there maybe no enough memory from 0 to 4G according to memory layout.
Devices in Isolation VM can use memory above 4G as DMA memory and call
swiotlb_alloc_from_low_pages() to allocate swiotlb bounce buffer not
limit from 0 to 4G.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 5a99f993e639..50ba4622c650 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -343,6 +343,7 @@ static void __init ms_hyperv_init_platform(void)
 		 * use swiotlb bounce buffer for dma transaction.
 		 */
 		swiotlb_force = SWIOTLB_FORCE;
+		swiotlb_set_alloc_from_low_pages(false);
 #endif
 	}
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
