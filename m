Return-Path: <SRS0=Fh/M=IX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D5CC433DB
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 17:09:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D4F6619FB
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 17:09:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D4F6619FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6387D401DD;
	Thu, 25 Mar 2021 17:09:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AtZgq7yJTbsQ; Thu, 25 Mar 2021 17:09:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6417C40191;
	Thu, 25 Mar 2021 17:09:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D738C000D;
	Thu, 25 Mar 2021 17:09:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42D9DC000A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 17:08:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3F654401D4
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 17:08:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AmcvLu73aPHD for <iommu@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 17:08:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BA0AB40191
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 17:08:58 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D909619E4;
 Thu, 25 Mar 2021 17:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616692138;
 bh=56A0l6+2zQ5O9rkIHutwsEMDBdqlpzUskFaOTpTah6s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GDkVZOYAKaFCu9XhG9L6xlZbZpW0FDhNpktbHw7nxXpTlKGvTOW17UDX7lFkpPVJV
 vXCCZaLsNUjtc6IoKIr8pnqm+gVceFCpouLM0mKP/nlO9IHre6h+/zjhDpXzhg2x9e
 TDTNluUinlB5azg/97/5Dd5a7MKmcwIcbbMlPOEqm4NJJntlWYKoShXcrb/o7iQWIk
 4Lm8Ve4UdIyZObOtCUeGKNfRbZI7Ifdlxh3euALR6Mp/XKOWEy2l4UPi6htlmNlwmD
 03K7HvBQPH4SJ/ttC5uIrmmGUBTKhRa9LMaD2V7m4wDitiOzCG3qx8QbjcLA3yP7IM
 ofYPAgelluGBg==
Date: Thu, 25 Mar 2021 17:08:54 +0000
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 1/2] iommu: Statically set module owner
Message-ID: <20210325170853.GA15337@willie-the-truck>
References: <f4de29d8330981301c1935e667b507254a2691ae.1616157612.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f4de29d8330981301c1935e667b507254a2691ae.1616157612.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

On Fri, Mar 19, 2021 at 12:52:01PM +0000, Robin Murphy wrote:
> It happens that the 3 drivers which first supported being modular are
> also ones which play games with their pgsize_bitmap, so have non-const
> iommu_ops where dynamically setting the owner manages to work out OK.
> However, it's less than ideal to force that upon all drivers which want
> to be modular - like the new sprd-iommu driver which now has a potential
> bug in that regard - so let's just statically set the module owner and
> let ops remain const wherever possible.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> This is something I hadn't got round to sending earlier, so now rebased
> onto iommu/next to accommodate the new driver :)
> 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       | 1 +
>  drivers/iommu/sprd-iommu.c                  | 1 +
>  drivers/iommu/virtio-iommu.c                | 1 +
>  include/linux/iommu.h                       | 9 +--------
>  5 files changed, 5 insertions(+), 8 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
