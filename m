Return-Path: <SRS0=4RPJ=Z7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CEAC43603
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 15:08:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47F892077B
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 15:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjKqp/mL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F892077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 08DC821543;
	Mon,  9 Dec 2019 15:08:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j+75c+tiNoK5; Mon,  9 Dec 2019 15:08:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2A58D20C92;
	Mon,  9 Dec 2019 15:08:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B3E0C1796;
	Mon,  9 Dec 2019 15:08:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72667C0881
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 15:07:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 61D3D8514B
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 15:07:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0mQXVvCkinBw for <iommu@lists.linux-foundation.org>;
 Mon,  9 Dec 2019 15:07:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 662FE84E5D
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 15:07:58 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id c9so16590779wrw.8
 for <iommu@lists.linux-foundation.org>; Mon, 09 Dec 2019 07:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=i9S04JDPyYWqmVYsR9CCUAiqutorZgMZt/OWk8Z0jLs=;
 b=DjKqp/mLV5RlPNLnYcqvmWnPEEETVXv4EyspYbunjaTfFLHBv7o5xFaaqx4LXgM5Mf
 b16Ly0UR1viJI8Hh0TmcG2lUNMBuWy2Rm7a/MzhTtdcI4bj0rl+kffI7NRl2TpDPI1vG
 8xRDod5/4Y0wiog27SE3AJnel1tAA+Gd2tXo3WXl3DOh5vuVHdYqkPCEg5aYZHgoPrIM
 QUMuEJLYU4v+sRUVzQbtNN0ZtzhYN3L83ljzD6p3N1EuM+m5pKgw0AKTkradaohdB9Ei
 ePJZTQV5Z+I8vShHTn4VqFdZiyPh6DFyHqy+viEgKg2VNqPKtHZlSdJGqXXNgDvLSs9O
 x4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=i9S04JDPyYWqmVYsR9CCUAiqutorZgMZt/OWk8Z0jLs=;
 b=uTP7Sc4KcqTuuZsCtr/6MPKD4tBzslQvjqjlHwS7MFHOyS1OMpOACy+miXt1NVNY9Z
 v2tYOOeqY4i/i3bz0JLvtdyhhjNNnqUeVhHwRod3N4tuKlS0Lh1xE4FSZVXcG5gk2P0d
 pTquuL2GBmTEq0c4prR1St8VyHdqjVCVk8gFR8mt0Ww+mlj7SgbhSpmm+wpKdOvQO81z
 alRLsH7fvhOC4nG9XWvVLFRCMCiatf9bMNSfYmyMktV6paAJ/JaVdop/Pm5FOb9F0MkJ
 34t3z1sr+Uhr7Jw8zN8NeVPzTfQXXNlAE8dD+aFZKciZp78annTGj+egoEv6Hrilnqhy
 cDvw==
X-Gm-Message-State: APjAAAUQQ3BaXww0xZL/i3Vqoye+03++n9Hey/3c9a4yg2QI0Kp65tPR
 9dlTY4+PE3BsbtqGRhSlJfA=
X-Google-Smtp-Source: APXvYqzGieSGCM1eahc8eoNyjBUi4olOJR8GjSmssbMHpICHRsLwq00wg/cxhK5N8DYZAEF0nDUkIw==
X-Received: by 2002:adf:e6cb:: with SMTP id y11mr2728041wrm.345.1575904076660; 
 Mon, 09 Dec 2019 07:07:56 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
 by smtp.gmail.com with ESMTPSA id l7sm27588659wrq.61.2019.12.09.07.07.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2019 07:07:54 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [RFC 0/2] iommu: arm-smmu: Add support for early direct mappings
Date: Mon,  9 Dec 2019 16:07:46 +0100
Message-Id: <20191209150748.2471814-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Cc: linux-tegra@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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

From: Thierry Reding <treding@nvidia.com>

On some platforms, the firmware will setup hardware to read from a given
region of memory. One such example is a display controller that is
scanning out a splash screen from physical memory.

During Linux' boot process, the ARM SMMU will configure all contexts to
fault by default. This means that memory accesses that happen by an SMMU
master before its driver has had a chance to properly set up the IOMMU
will cause a fault. This is especially annoying for something like the
display controller scanning out a splash screen because the faults will
result in the display controller getting bogus data (all-ones on Tegra)
and since it repeatedly scans that framebuffer, it will keep triggering
such faults and spam the boot log with them.

In order to work around such problems, scan the device tree for IOMMU
masters and set up a special identity domain that will map 1:1 all of
the reserved regions associated with them. This happens before the SMMU
is enabled, so that the mappings are already set up before translations
begin.

One thing that was pointed out earlier, and which I don't have a good
idea on how to solve it, is that the early identity domain is not
discarded. The assumption is that the standard direct mappings code of
the IOMMU framework will replace the early identity domain once devices
are properly attached to domains, but we don't have a good point in time
when it would be safe to remove the early identity domain.

One option that I can think of would be to create an early identity
domain for each master and inherit it when that master is attached to
the domain later on, but that seems rather complicated from an book-
keeping point of view and tricky because we need to be careful not to
map regions twice, etc.

Any good ideas on how to solve this? It'd also be interesting to see if
there's a more generic way of doing this. I know that something like
this isn't necessary on earlier Tegra SoCs with the custom Tegra SMMU
because translations are only enabled when the devices are attached to a
domain. I'm not sure about other IOMMUs, but in the absence of a struct
device, I suspect that we can't really do anything really generic that
would work across drivers.

Thierry

Thierry Reding (2):
  iommu: arm-smmu: Extract arm_smmu_of_parse()
  iommu: arm-smmu: Add support for early direct mappings

 drivers/iommu/arm-smmu.c | 195 +++++++++++++++++++++++++++++++++++++--
 drivers/iommu/arm-smmu.h |   2 +
 2 files changed, 189 insertions(+), 8 deletions(-)

-- 
2.23.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
