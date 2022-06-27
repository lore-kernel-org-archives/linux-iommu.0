Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1E8C43334
	for <iommu@archiver.kernel.org>; Mon, 27 Jun 2022 15:32:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 027F140C38;
	Mon, 27 Jun 2022 15:32:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 027F140C38
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=O+GWloio
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CDFlxpUmhY7h; Mon, 27 Jun 2022 15:31:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BF48E40C3F;
	Mon, 27 Jun 2022 15:31:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BF48E40C3F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99EDBC0039;
	Mon, 27 Jun 2022 15:31:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDD49C002D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 15:31:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8AB0F610A2
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 15:31:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8AB0F610A2
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=O+GWloio
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eaUB9wkBGIl6 for <iommu@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 15:31:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EA98560E80
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EA98560E80
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 15:31:54 +0000 (UTC)
Received: by mail-pl1-x636.google.com with SMTP id x20so2880483plx.6
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 08:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iZDC1AGRQHEGpUuB3ISkYbuot/iQPwlOXTIDim4MzLc=;
 b=O+GWloioEOJpO0XyXVRSMZTQsER89gKRWgIfzRViNiUH+wc06BhSdI/DYNimqD0H/7
 +pBzmJ7cigXalaMs2EYCeYKV+G6WBWbR7VsAdyeDZvbyF635dgSBJ9nXlWkul7FYLsu8
 gAtMXnwoSaQlBXInB76dUgvLj6KmA/5ZhOoN5PXuJRteFiHKTnGTlUuAh61yLcYZn323
 AGGQSk+5H0R6Snc1R2Toqjss7pGQnsZttUZ8diX7VWTqboNL5/2x0EEKY7FPIvyhj3+l
 8U+0xCg4eQ3aluY9uc5Aw2N+SRaH40XIYSKcjsS9Uk6Yh8XYwdhjkXZpQ/NAeL8ogA9R
 2+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iZDC1AGRQHEGpUuB3ISkYbuot/iQPwlOXTIDim4MzLc=;
 b=jn/Z0IrBisQUTF08P/7NZvMhLzmoX7nFihaKuekt029baL3RyfQiMfSZkYxDLjK9h3
 4trB238Ejy7yZRg6c0s8MeJlPwsWloeN/VzU3rFebUugQC3aLMd9EG8DOSXKDWsfd4w+
 OvWmPNXMad8e/HABwg1w6MNkpcPJRLnwCeG0bXvgJz8bSisoM5Au67g53WhZ0KG29UTn
 wpIQd5n96Dmt88jA/aeCvzaMF95JFE7HoBsugDhfzUcdnXtNl4T1nPeg1xLiZXmJYA8/
 2h404/bwGF4KtNqLOkAZbubhKmau2/sl/t8DB93RY6UV+nob/CtQ30zRjA9g+NvEiTFM
 DDzg==
X-Gm-Message-State: AJIora/Vn+DXpQGX9a3ekZi+ii5bebtgmx48GCxSXWKzBlszeplPBAB7
 ezIJozklcNJ+LOk4y4vB8Dk=
X-Google-Smtp-Source: AGRyM1sEiEhuPfofrRLQqFzFlVdXiZYLCqnhQsSu7hoQrMhPrjLPj9CQQVl/oAKCcOOKm40jQb6U7g==
X-Received: by 2002:a17:902:cec4:b0:16a:1fc3:b6e6 with SMTP id
 d4-20020a170902cec400b0016a1fc3b6e6mr15435957plg.129.1656343914201; 
 Mon, 27 Jun 2022 08:31:54 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:36:f0eb:a18:55d7:977b])
 by smtp.gmail.com with ESMTPSA id
 y6-20020aa78f26000000b005251ec8bb5bsm7595705pfr.199.2022.06.27.08.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jun 2022 08:31:53 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
To: corbet@lwn.net, rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 hch@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
 paulmck@kernel.org, akpm@linux-foundation.org, keescook@chromium.org,
 songmuchun@bytedance.com, rdunlap@infradead.org,
 damien.lemoal@opensource.wdc.com, michael.h.kelley@microsoft.com,
 kys@microsoft.com
Subject: [PATCH 0/2] swiotlb: Split up single swiotlb lock
Date: Mon, 27 Jun 2022 11:31:48 -0400
Message-Id: <20220627153150.106995-1-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: parri.andrea@gmail.com, thomas.lendacky@amd.com, wei.liu@kernel.org,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, linux-hyperv@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kirill.shutemov@intel.com,
 iommu@lists.linux-foundation.org, andi.kleen@intel.com, vkuznets@redhat.com
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

Traditionally swiotlb was not performance critical because it was only
used for slow devices. But in some setups, like TDX/SEV confidential
guests, all IO has to go through swiotlb. Currently swiotlb only has a
single lock. Under high IO load with multiple CPUs this can lead to
significat lock contention on the swiotlb lock.

Patch 1 is to introduce swiotlb area concept and split up single swiotlb
lock.
Patch 2 set swiotlb area number with lapic number


Tianyu Lan (2):
  swiotlb: Split up single swiotlb lock
  x86/ACPI: Set swiotlb area according to the number of lapic entry in
    MADT

 .../admin-guide/kernel-parameters.txt         |   4 +-
 arch/x86/kernel/acpi/boot.c                   |   3 +
 include/linux/swiotlb.h                       |  27 +++
 kernel/dma/swiotlb.c                          | 202 ++++++++++++++----
 4 files changed, 197 insertions(+), 39 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
