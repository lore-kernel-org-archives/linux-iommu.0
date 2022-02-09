Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A67C433EF
	for <iommu@archiver.kernel.org>; Wed,  9 Feb 2022 12:23:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 120ED40342;
	Wed,  9 Feb 2022 12:23:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0fGfhcYAn_mY; Wed,  9 Feb 2022 12:23:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C35BB400A4;
	Wed,  9 Feb 2022 12:23:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8EB01C0011;
	Wed,  9 Feb 2022 12:23:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0579EC000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 12:23:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C779640342
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 12:23:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9LBv0i-iXQca for <iommu@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 12:23:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 21E2C400A4
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 12:23:25 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 h14-20020a17090a130e00b001b88991a305so4901860pja.3
 for <iommu@lists.linux-foundation.org>; Wed, 09 Feb 2022 04:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PaNAnkJHSrjZ0Ymtt0aSkScJLuMHMgg0pqapqtDp4Dg=;
 b=kG2jKtGn8FULF5Ds5XfJZeSjKGW8Z8VsxO88USCD/ONYRvH1ZbCv1iMkOxl1JMSf8+
 eheKtiPIHZsWTNp3HZ21/r/rjz3rQbSWpwXeHM9DNwCNmzVpWkhUySynBc/IKb4XyIoM
 08SUYZ+uS4lmGwcnmBPZIByJ5c9MwXzg3b/UVBRT9m+3qnWRAeSXVFCcbGOGh4b3s69x
 mPmGSShDHb9qmiD3OpblYzRIj5dZYn/mW4GGBp9VaIvQ8iCHks9MVNAUwJ12yt5o8D+F
 sJc80rONtY8+GYo3q3BQPp+cSBsR4WhMTrzuOaLZFzME/o92PFFpl9e/0BH6QF2XJUDx
 s7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PaNAnkJHSrjZ0Ymtt0aSkScJLuMHMgg0pqapqtDp4Dg=;
 b=JzJH2lxFWnCEbUFqgvq5SKGTmFBLJNvToQcptqcnsAGtnB9XJDZgv9GE0AFI14Z+0A
 09G5oXHMK/hxKqrrLeatF7e0bFYr5Zvhs99/P/zS7brXX9YIEdoCWcOVJRcle/iDw2Mf
 OUwLQMbSJiEfvlYOW4BA5wElLkGu+pfyuc23AzvCBCZ5eLg+DrkC8/YDlWBlcDmm+Idd
 JI+3l3TDUeJByS7YJ2isqPvme39QlJh6M23yXHeRnXxuvBWBpDDKr8LZjiITnRBCmpCo
 ekRE/lICndPspl10Rf0ZCGHN+fbWR/FoUXOzGzxI7WYf5/e5SQZuh9yi8EZw98v5RXI/
 GphA==
X-Gm-Message-State: AOAM532EEsx2holQPRhm+bboO9u3IZ8z1gQJlT7wqTFIXlfwvNIgB9H3
 aKVXWGCK0KP1E8kJ8gWaenM=
X-Google-Smtp-Source: ABdhPJy3B8Zxcj0qnCCCdhXCsjncbSBovC/HETIu1yprqv435k5YpCYPC9/wJY8qtxvGP2tJK79sSA==
X-Received: by 2002:a17:90b:1e42:: with SMTP id
 pi2mr2281656pjb.176.1644409405570; 
 Wed, 09 Feb 2022 04:23:25 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:a:9d5c:32bf:5c81:da87])
 by smtp.gmail.com with ESMTPSA id lb3sm6300990pjb.47.2022.02.09.04.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Feb 2022 04:23:25 -0800 (PST)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, hch@infradead.org, m.szyprowski@samsung.com,
 robin.murphy@arm.com, michael.h.kelley@microsoft.com
Subject: [PATCH V2 0/2] x86/hyperv/Swiotlb: Add
 swiotlb_set_alloc_from_low_pages() switch function.
Date: Wed,  9 Feb 2022 07:23:00 -0500
Message-Id: <20220209122302.213882-1-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Hyper-V Isolation VM may fail to allocate swiotlb bounce buffer due
to there is no enough contiguous memory from 0 to 4G in some cases.
Current swiotlb code allocates bounce buffer in the low end memory.
This patchset adds a new function swiotlb_set_alloc_from_low_pages()
to control swiotlb bounce buffer from low pages or no limitation.
Devices in Hyper-V Isolation VM may use memory above 4G as DMA memory
and switch swiotlb allocation in order to avoid no enough contiguous
memory in low pages.

Tianyu Lan (2):
  Swiotlb: Add swiotlb_alloc_from_low_pages switch
  x86/hyperv: Make swiotlb bounce buffer allocation not just from low
    pages

 arch/x86/kernel/cpu/mshyperv.c |  1 +
 include/linux/swiotlb.h        |  1 +
 kernel/dma/swiotlb.c           | 18 ++++++++++++++++--
 3 files changed, 18 insertions(+), 2 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
