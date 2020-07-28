Return-Path: <SRS0=UphA=BH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2381C433E8
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 05:01:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AAA621744
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 05:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QLDIFiwe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AAA621744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 367A9228A4;
	Tue, 28 Jul 2020 05:01:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zNX09yYM-ihB; Tue, 28 Jul 2020 05:01:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5EA622041B;
	Tue, 28 Jul 2020 05:01:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DB56C004F;
	Tue, 28 Jul 2020 05:01:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B7F2C004D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 05:01:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E8566204DC
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 05:01:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ymQ7RMYHpjZs for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jul 2020 05:01:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by silver.osuosl.org (Postfix) with ESMTPS id 2E23B2041B
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 05:01:47 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id z5so11209328pgb.6
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jul 2020 22:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pvK0ev5cxRiAMES2LwocRB0zuTfv4RSfxEp+cEikUek=;
 b=QLDIFiweKFoEeNtrtNBe8Z0TBBcqdWvmwRC0OtwsgH0XE//RxcPxO1+FWIBAKL+8sH
 H1q/GUF6ztaNV045qC5aYjMEHpRq5cCdo0rh7LuzJ6Bnn0yjqTEbVdeAuqKcj+2sVjb0
 IkRwS+zgtBoc84wtK1WEbg6TwcuGvllnZ6mus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pvK0ev5cxRiAMES2LwocRB0zuTfv4RSfxEp+cEikUek=;
 b=MlfON+aUHOSI0IGczMq6VLKwt7nDMpjKWo8lmcdtGVsZM0bNXd2QC98xxsCJh7HEVt
 Y7j392++rbIY8o9lY62opm83p+7AVOT3L4N5MWgHplZX9Ach+fIYCjGzVOLCKY9Nzu0J
 4XBWtlOl8HwbNRSez+AwOcekbUUp175krGx1LEfOpUkAja+Fdt/Yud1FkZPPEN/zUjBy
 XOTUVUGtaaogBUzCPBvflfcq2kGYQdnxgm8wlYf0tbw0MM0uZcKGoy/VlMY2Dryro3V+
 tfwbLw/fUx23heGkdepRwGahVW2XHxFR3cyyupLQzDpGPKjpnrFnho17otW7zIMiS1Ez
 2aZw==
X-Gm-Message-State: AOAM5303ekbhd//shz8KAqxgs8BlnUuO+1eDSaCVf06pg+t810Qi3yo/
 yVci3fmg/dYPRJSip8xySxWRAA==
X-Google-Smtp-Source: ABdhPJy67ViNBgTVNsG3xR6SCIBkpWpQ424Q+eyNgk/Qkb1lwIhrNajWk8Z3yx2L14WHn2HWf2CHjw==
X-Received: by 2002:a62:7958:: with SMTP id u85mr113344pfc.248.1595912506759; 
 Mon, 27 Jul 2020 22:01:46 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:3e52:82ff:fe5e:cc9d])
 by smtp.gmail.com with ESMTPSA id mg17sm1278157pjb.55.2020.07.27.22.01.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2020 22:01:45 -0700 (PDT)
From: Claire Chang <tientzu@chromium.org>
To: robh+dt@kernel.org, frowand.list@gmail.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com
Subject: [RFC v2 0/5] Restricted DMA
Date: Tue, 28 Jul 2020 13:01:35 +0800
Message-Id: <20200728050140.996974-1-tientzu@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, heikki.krogerus@linux.intel.com,
 saravanak@google.com, suzuki.poulose@arm.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, bgolaszewski@baylibre.com,
 iommu@lists.linux-foundation.org, drinkcat@chromium.org, tientzu@chromium.org,
 dan.j.williams@intel.com, treding@nvidia.com
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

This series implements mitigations for lack of DMA access control on
systems without an IOMMU, which could result in the DMA accessing the
system memory at unexpected times and/or unexpected addresses, possibly
leading to data leakage or corruption.

For example, we plan to use the PCI-e bus for Wi-Fi on one MTK platform and
that PCI-e bus is not behind an IOMMU. As PCI-e, by design, gives the
device full access to system memory, a vulnerability in the Wi-Fi firmware
could easily escalate to a full system exploit (remote wifi exploits: [1a],
[1b] that shows a full chain of exploits; [2], [3]).

To mitigate the security concerns, we introduce restricted DMA. The
restricted DMA is implemented by per-device swiotlb and coherent memory
pools. The feature on its own provides a basic level of protection against
the DMA overwriting buffer contents at unexpected times. However, to
protect against general data leakage and system memory corruption, the
system needs to provide a way to restrict the DMA to a predefined memory
region (this is usually done at firmware level, e.g. in ATF on some ARM
platforms).

[1a] https://googleprojectzero.blogspot.com/2017/04/over-air-exploiting-broadcoms-wi-fi_4.html
[1b] https://googleprojectzero.blogspot.com/2017/04/over-air-exploiting-broadcoms-wi-fi_11.html
[2] https://blade.tencent.com/en/advisories/qualpwn/
[3] https://www.bleepingcomputer.com/news/security/vulnerabilities-found-in-highly-popular-firmware-for-wifi-chips/


Claire Chang (5):
  swiotlb: Add io_tlb_mem struct
  swiotlb: Add device swiotlb pool
  swiotlb: Use device swiotlb pool if available
  dt-bindings: of: Add plumbing for restricted DMA pool
  of: Add plumbing for restricted DMA pool

 .../reserved-memory/reserved-memory.txt       |  35 ++
 drivers/iommu/intel/iommu.c                   |   8 +-
 drivers/of/address.c                          |  39 ++
 drivers/of/device.c                           |   3 +
 drivers/of/of_private.h                       |   6 +
 drivers/xen/swiotlb-xen.c                     |   4 +-
 include/linux/device.h                        |   4 +
 include/linux/dma-direct.h                    |   8 +-
 include/linux/swiotlb.h                       |  49 +-
 kernel/dma/direct.c                           |   8 +-
 kernel/dma/swiotlb.c                          | 418 +++++++++++-------
 11 files changed, 393 insertions(+), 189 deletions(-)

--
v1: https://lore.kernel.org/patchwork/cover/1271660/
Changes in v2:
- build on top of swiotlb
 
2.28.0.rc0.142.g3c755180ce-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
