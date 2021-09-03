Return-Path: <SRS0=hF+p=NZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468A2C433F5
	for <iommu@archiver.kernel.org>; Fri,  3 Sep 2021 21:44:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4B9561057
	for <iommu@archiver.kernel.org>; Fri,  3 Sep 2021 21:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B4B9561057
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7587B40160;
	Fri,  3 Sep 2021 21:44:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dinL69AAK2so; Fri,  3 Sep 2021 21:44:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 39E31400D2;
	Fri,  3 Sep 2021 21:44:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F98DC001A;
	Fri,  3 Sep 2021 21:44:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8DC8C000E
 for <iommu@lists.linux-foundation.org>; Fri,  3 Sep 2021 21:44:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C287983684
 for <iommu@lists.linux-foundation.org>; Fri,  3 Sep 2021 21:44:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L88lEJBHGP1R for <iommu@lists.linux-foundation.org>;
 Fri,  3 Sep 2021 21:44:23 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A8405834D5
 for <iommu@lists.linux-foundation.org>; Fri,  3 Sep 2021 21:44:23 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 4D12C4B0; Fri,  3 Sep 2021 23:44:20 +0200 (CEST)
Date: Fri, 3 Sep 2021 23:44:14 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull] IOMMU Updates for Linux v5.15
Message-ID: <YTKXLjwkD3Kn8VUz@8bytes.org>
References: <YTIrHxWNzIwuseXO@8bytes.org>
 <CAHk-=wjTpYOsRPm4T2EV=Sxm52buZrMpRdwSDeedCSF4jh=M1w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHk-=wjTpYOsRPm4T2EV=Sxm52buZrMpRdwSDeedCSF4jh=M1w@mail.gmail.com>
Cc: iommu <iommu@lists.linux-foundation.org>, Will Deacon <will@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Fri, Sep 03, 2021 at 11:43:31AM -0700, Linus Torvalds wrote:
>   choice
>         prompt "IOMMU default domain type"
>         depends on IOMMU_API
>         default IOMMU_DEFAULT_DMA_LAZY if AMD_IOMMU || INTEL_IOMMU
>         default IOMMU_DEFAULT_DMA_STRICT

Huh, yeah, that is bogus. Seems like I overlooked that part of the
patch-set because I was so amazed by the simplifications and cleanups in
the rest of it.

> See what I'm saying? Making the default be based on some random "this
> driver is enabled" when it can then affect *other* drivers that are
> also enabled and not part of the decision seems to be a fundamental
> confusion about what is going on, when it's not at all clear which
> driver will actually be IN USE.

The Kconfig option itself was actually my suggestion, but how the
default value is chosen certainly needs improvement. I will sort this
out with the people involved.

> IOW, the fix might be to just say "the default is always lazy".
> 
> Or the fix might be something that is global to a configuration and
> doesn't rely on which iommu is in use (eg "on x86, the default is
> always LAZY")
> 
> Or the fix is to make that 'iommu_dma_strict' variable - and the
> default value for it - be a per-IOMMU thing rather than be a global.

My preference would be to make 'lazy' or 'strict' the default for all,
but the ARM folks might disagree. On the other side it also doesn't make
sense to let IOMMU drivers override the users Kconfig choice at runtime.
We will discuss this and come up with something better.

Thanks,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
