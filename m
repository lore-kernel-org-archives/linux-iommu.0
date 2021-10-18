Return-Path: <SRS0=5Tlr=PG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0968AC433EF
	for <iommu@archiver.kernel.org>; Mon, 18 Oct 2021 10:25:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 810E960FF2
	for <iommu@archiver.kernel.org>; Mon, 18 Oct 2021 10:25:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 810E960FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 499AC82681;
	Mon, 18 Oct 2021 10:25:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0ymNwSrVRNmj; Mon, 18 Oct 2021 10:25:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2DB18823F9;
	Mon, 18 Oct 2021 10:25:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D63C0C0011;
	Mon, 18 Oct 2021 10:25:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B11AC000D
 for <iommu@lists.linux-foundation.org>; Mon, 18 Oct 2021 10:25:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7618F403B6
 for <iommu@lists.linux-foundation.org>; Mon, 18 Oct 2021 10:25:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UAFDxRbCccYk for <iommu@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 10:25:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8D766402B9
 for <iommu@lists.linux-foundation.org>; Mon, 18 Oct 2021 10:25:49 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 6D49D450; Mon, 18 Oct 2021 12:25:45 +0200 (CEST)
Date: Mon, 18 Oct 2021 12:25:38 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH v2 1/5] [RFC]iommu: Add a IOMMU_DEVONLY protection flag
Message-ID: <YW1LollkmP9HvxjT@8bytes.org>
References: <20211001143427.1564786-1-boris.brezillon@collabora.com>
 <20211001143427.1564786-2-boris.brezillon@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211001143427.1564786-2-boris.brezillon@collabora.com>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Will Deacon <will@kernel.org>,
 dri-devel@lists.freedesktop.org, Steven Price <steven.price@arm.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On Fri, Oct 01, 2021 at 04:34:23PM +0200, Boris Brezillon wrote:
> +/*
> + * Mapping is only accessed by the device behind the iommu. That means other
> + * devices or CPUs are not expected to access this physical memory region,
> + * and the MMU driver can safely restrict the shareability domain to the
> + * device itself.
> + */
> +#define IOMMU_DEVONLY	(1 << 6)

I am not entirely happy with the name, how about

	IOMMU_DEV_PRIVATE?

PRIV would conflict with IOMMU_PRIV (which should probably also be
IOMMU_PRIVILEGED, but thats another problem).

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
