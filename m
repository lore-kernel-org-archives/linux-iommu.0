Return-Path: <SRS0=KfvE=G6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EF3C433E6
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 19:09:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AD3364D9E
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 19:09:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AD3364D9E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D528187382;
	Wed, 27 Jan 2021 19:09:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fSWs2mvFd9RI; Wed, 27 Jan 2021 19:09:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6B99487377;
	Wed, 27 Jan 2021 19:09:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52F00C013A;
	Wed, 27 Jan 2021 19:09:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 181BAC013A
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 19:09:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 044B286C50
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 19:09:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qGyYhuDiIRe5 for <iommu@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 19:09:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8118C805E2
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 19:09:39 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD89664DCB
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 19:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611774579;
 bh=CxVDcZVJbTgcZjdsMfJhxJ/yjKbh0SkOEhIy1FhN6KI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=dMLi9XGhBP7sr8rYS8BJ6RsXQgysILPqv1nJNJw5qZ2DyBAUhNdQHjQzvgV8VDl5V
 i9ALC6nJBeYrDal6V0wxRS4Oj1rRdlQYA2H+6vx80Ni8//ZnxbR84eJSWfwHwrfZ+m
 huSnvJCgYsqg1ZdsYmI36XpPssTAyzZXC+4+K+R4HGTQDEa3D+1wQRcxlMx60l4siq
 AfiYedGDWYh3rdmwOf3EskK8mgLe27CYkM02ik5LmlsDCtLrT6rKv/7dbdltGG8jZf
 /EYeZUc7HMTHGMwYIun5xzt1qfY9eHYEiUSksWtwoi1uycXl8bbKrxFsjyJ+0QBHbZ
 W+EkVBD/JX9uw==
Received: by mail-ed1-f44.google.com with SMTP id b21so3779254edy.6
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 11:09:38 -0800 (PST)
X-Gm-Message-State: AOAM530/PAJW7AXmMcR0lDxeOdD9PWQQCFDWm9nCd7laptrWIAJVKPbX
 K75CSb6oXptaKgIA5idzct0XMtGSW1iB9kJNyQ==
X-Google-Smtp-Source: ABdhPJxDhEsE7SeDYEXoCEJP81XWI54Z2K7fxKs16oNcCLHvf630uv8EyH4cluj/eac/SPi55kJ7fCq1wMrnsmcwKMs=
X-Received: by 2002:a05:6402:1751:: with SMTP id
 v17mr10650676edx.289.1611774577245; 
 Wed, 27 Jan 2021 11:09:37 -0800 (PST)
MIME-Version: 1.0
References: <20210119105203.15530-1-yong.wu@mediatek.com>
 <YBFj9whLvqlV2erm@aptenodytes>
 <159d4486-bb7e-249d-2bad-f5bba839041d@arm.com>
In-Reply-To: <159d4486-bb7e-249d-2bad-f5bba839041d@arm.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 27 Jan 2021 13:09:25 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKgGOAe-ZSw9qJ7POVv5nJuX+UoJE-MS3drKrM119pw-w@mail.gmail.com>
Message-ID: <CAL_JsqKgGOAe-ZSw9qJ7POVv5nJuX+UoJE-MS3drKrM119pw-w@mail.gmail.com>
Subject: Re: [PATCH v2] of/device: Update dma_range_map only when dev has
 valid dma-ranges
To: Robin Murphy <robin.murphy@arm.com>
Cc: devicetree@vger.kernel.org, Nicolas Boichat <drinkcat@chromium.org>,
 srv_heupstream <srv_heupstream@mediatek.com>,
 Frank Rowand <frowand.list@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Tomasz Figa <tfiga@google.com>, Linux IOMMU <iommu@lists.linux-foundation.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

On Wed, Jan 27, 2021 at 7:13 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> [ + Christoph, Marek ]
>
> On 2021-01-27 13:00, Paul Kocialkowski wrote:
> > Hi,
> >
> > On Tue 19 Jan 21, 18:52, Yong Wu wrote:
> >> The commit e0d072782c73 ("dma-mapping: introduce DMA range map,
> >> supplanting dma_pfn_offset") always update dma_range_map even though it was
> >> already set, like in the sunxi_mbus driver. the issue is reported at [1].
> >> This patch avoid this(Updating it only when dev has valid dma-ranges).
> >>
> >> Meanwhile, dma_range_map contains the devices' dma_ranges information,
> >> This patch moves dma_range_map before of_iommu_configure. The iommu
> >> driver may need to know the dma_address requirements of its iommu
> >> consumer devices.
> >
> > Just a gentle ping on this issue, it would be nice to have this fix merged
> > ASAP, in the next RC :)
>
> Ack to that - Rob, Frank, do you want to take this through the OF tree,
> or shall we take it through the DMA-mapping tree like the original culprit?

I've already got some fixes queued up and can take it.

Suggested-by doesn't mean you are happy with the implementation. So
Acked-by or Reviewed-by?

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
