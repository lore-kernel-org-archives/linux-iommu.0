Return-Path: <SRS0=C8jr=MS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E92DC4320A
	for <iommu@archiver.kernel.org>; Mon, 26 Jul 2021 13:20:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3033F6056C
	for <iommu@archiver.kernel.org>; Mon, 26 Jul 2021 13:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3033F6056C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EC01D402DC;
	Mon, 26 Jul 2021 13:20:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DaTNJzXHGVac; Mon, 26 Jul 2021 13:20:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 39E1240163;
	Mon, 26 Jul 2021 13:20:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 110F3C001A;
	Mon, 26 Jul 2021 13:20:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8940EC000E
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 13:20:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 63FC8605E0
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 13:20:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EEq85EGTKrjP for <iommu@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 13:20:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 320746058D
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 13:20:07 +0000 (UTC)
Received: from maud (unknown [IPv6:2600:8800:8c04:8c00::ffa6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: alyssa)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 1F5A91F424CD;
 Mon, 26 Jul 2021 14:19:57 +0100 (BST)
Date: Mon, 26 Jul 2021 09:19:52 -0400
From: Alyssa Rosenzweig <alyssa@collabora.com>
To: Sven Peter <sven@svenpeter.dev>
Subject: Re: [PATCH v4 3/3] iommu: dart: Add DART iommu driver
Message-ID: <YP62eOnGSpXOumX+@maud>
References: <20210627143405.77298-1-sven@svenpeter.dev>
 <20210627143405.77298-4-sven@svenpeter.dev>
 <f3574c75-db2d-47fc-bda5-0f0f627fb524@arm.com>
 <30b00cf1-6366-4075-be8a-992fb1778306@www.fastmail.com>
 <69259ab4-0da9-ddc7-97b0-9ef1e33a39ec@arm.com>
 <de9dcabd-a3c3-4f34-9f09-6e23deed3a98@www.fastmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <de9dcabd-a3c3-4f34-9f09-6e23deed3a98@www.fastmail.com>
Cc: devicetree@vger.kernel.org, Rouven Czerwinski <r.czerwinski@pengutronix.de>,
 Arnd Bergmann <arnd@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
 Petr Mladek via iommu <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Alexander Graf <graf@amazon.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Marc Zyngier <maz@kernel.org>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Stan Skowronek <stan@corellium.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Mark Kettenis <mark.kettenis@xs4all.nl>
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

> I'll let my current version simmer for a bit and wait until it's been
> tested by a few people and will send it in a week or so then!

New version has my T-b :)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
