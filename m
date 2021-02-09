Return-Path: <SRS0=nJTY=HL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83111C433E0
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 09:23:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF11964DA1
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 09:23:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF11964DA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7C0D586256;
	Tue,  9 Feb 2021 09:23:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Oa_IIs8G_Usd; Tue,  9 Feb 2021 09:23:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E4EDF86224;
	Tue,  9 Feb 2021 09:23:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9AFFC0891;
	Tue,  9 Feb 2021 09:23:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98BACC013A
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 09:23:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 803F786226
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 09:23:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e5igkAM4PjCJ for <iommu@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 09:23:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id CECE086224
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 09:23:15 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF67C64E4F;
 Tue,  9 Feb 2021 09:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1612862595;
 bh=ZuzO8IlPH7OdvzOuM3hUuPGrV2BGw7BR18s5NWN+cQo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=2IZd9JV5qM4aI8JsCkjZZuIE+UcwO+cZ/8Tzp/xkBac6h1v5ahUFGgLchn6WAvHWP
 TTpbmG95sCUDlWRidU6dAfH5GDSinRQmdtdG5VZuur1DwcnrvtroT/g4T4IlgJjrY5
 7e9KljC+q9VAdsCIo/5dP1dy/Ykm0EgIhSJoAfSo=
Date: Tue, 9 Feb 2021 10:23:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: obayashi.yoshimasa@socionext.com
Subject: Re: DMA direct mapping fix for 5.4 and earlier stable branches
Message-ID: <YCJUgKDNVjJ4dUqM@kroah.com>
References: <CAFA6WYNazCmYN20irLdNV+2vcv5dqR+grvaY-FA7q2WOBMs__g@mail.gmail.com>
 <YCIym62vHfbG+dWf@kroah.com>
 <CAFA6WYM+xJ0YDKenWFPMHrTz4gLWatnog84wyk31Xy2dTiT2RA@mail.gmail.com>
 <YCJCDZGa1Dhqv6Ni@kroah.com>
 <27bbe35deacb4ca49f31307f4ed551b5@SOC-EX02V.e01.socionext.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <27bbe35deacb4ca49f31307f4ed551b5@SOC-EX02V.e01.socionext.com>
Cc: sumit.garg@linaro.org, daniel.thompson@linaro.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com, hch@lst.de
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

On Tue, Feb 09, 2021 at 09:05:40AM +0000, obayashi.yoshimasa@socionext.com wrote:
> > > As the drivers are currently under development and Socionext has
> > > chosen 5.4 stable kernel for their development. So I will let
> > > Obayashi-san answer this if it's possible for them to migrate to 5.10
> > > instead?
> 
>   We have started this development project from last August, 
> so we have selected 5.4 as most recent and longest lifetime LTS 
> version at that time.
> 
>   And we have already finished to develop other device drivers, 
> and Video converter and CODEC drivers are now in development.
> 
> > Why pick a kernel that doesn not support the features they require?
> > That seems very odd and unwise.
> 
>   From the view point of ZeroCopy using DMABUF, is 5.4 not 
> mature enough, and is 5.10 enough mature ?
>   This is the most important point for judging migration.

How do you judge "mature"?

And again, if a feature isn't present in a specific kernel version, why
would you think that it would be a viable solution for you to use?

good luck!

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
