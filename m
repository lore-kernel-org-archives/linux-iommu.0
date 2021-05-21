Return-Path: <SRS0=NT7l=KQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DFCC43461
	for <iommu@archiver.kernel.org>; Fri, 21 May 2021 09:16:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AF40613D0
	for <iommu@archiver.kernel.org>; Fri, 21 May 2021 09:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF40613D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D58A160DD7;
	Fri, 21 May 2021 09:16:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sQqqM8WhjmUn; Fri, 21 May 2021 09:16:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id CB2C260DCB;
	Fri, 21 May 2021 09:16:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87A43C000E;
	Fri, 21 May 2021 09:16:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E0D9C0001
 for <iommu@lists.linux-foundation.org>; Fri, 21 May 2021 09:16:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 65B0E84581
 for <iommu@lists.linux-foundation.org>; Fri, 21 May 2021 09:16:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QnsCGB3VPzpA for <iommu@lists.linux-foundation.org>;
 Fri, 21 May 2021 09:16:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9F0638457B
 for <iommu@lists.linux-foundation.org>; Fri, 21 May 2021 09:16:39 +0000 (UTC)
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74]
 helo=diego.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <heiko@sntech.de>)
 id 1lk1Gh-0004vA-Bn; Fri, 21 May 2021 11:16:31 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: joro@8bytes.org, will@kernel.org, robh+dt@kernel.org, xxm@rock-chips.com,
 robin.murphy@arm.com, Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: Re: [PATCH v5 3/4] iommu: rockchip: Add internal ops to handle
 variants
Date: Fri, 21 May 2021 11:16:30 +0200
Message-ID: <4753042.QJadu78ljV@diego>
In-Reply-To: <20210521083637.3221304-4-benjamin.gaignard@collabora.com>
References: <20210521083637.3221304-1-benjamin.gaignard@collabora.com>
 <20210521083637.3221304-4-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux-foundation.org, kernel@collabora.com,
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

Am Freitag, 21. Mai 2021, 10:36:36 CEST schrieb Benjamin Gaignard:
> Add internal ops to be able to handle incoming variant v2.
> The goal is to keep the overall structure of the framework but
> to allow to add the evolution of this hardware block.
> 
> The ops are global for a SoC because iommu domains are not
> attached to a specific devices if they are for a virtuel device like
> drm. Use a global variable shouldn't be since SoC usually doesn't
> embedded different versions of the iommu hardware block.
> If that happen one day a WARN_ON will be displayed at probe time.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
