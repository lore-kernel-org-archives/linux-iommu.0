Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1955C433EF
	for <iommu@archiver.kernel.org>; Wed,  9 Mar 2022 12:43:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7AF03813B1;
	Wed,  9 Mar 2022 12:43:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I9-ZRw5gJ4_W; Wed,  9 Mar 2022 12:43:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6A66281421;
	Wed,  9 Mar 2022 12:43:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3443EC001D;
	Wed,  9 Mar 2022 12:43:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D57D8C000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Mar 2022 12:43:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ACA7281421
 for <iommu@lists.linux-foundation.org>; Wed,  9 Mar 2022 12:43:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hxO2RfmIHvaa for <iommu@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 12:43:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 975F7813B1
 for <iommu@lists.linux-foundation.org>; Wed,  9 Mar 2022 12:43:53 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5EC3561947;
 Wed,  9 Mar 2022 12:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0704FC340E8;
 Wed,  9 Mar 2022 12:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646829831;
 bh=NfpZrz/N2z7mKEqxDudtRMZkspXLAswLYMQk23y6/AQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tK04+G+eh8HiQbfVzo9KJZkzySqvXhheh+6DNZALmaiC5uoP6ANl6ksKfrnZblpEj
 xJox+Mo4pseHbX09hV9KZEr56gERT0PfU0NE7Wjh+nVj/rq4wqfzdpOAUuQTZN3TT1
 077EIBTVvrTrRZQmwdTNY4BUhDcPkbe9fjZ8c+pZy5S1PAzm/FRtbZa/ruI/4ZIXoC
 df2bLserL/oi/mFV/ThJf22+yNn6vYfI9pYwFj9WH4mDMxXD0luAGRVZQgp6dRVYjG
 Zp90lJjXbWJ89zAUmeE3fYGaHhEx9r7kdE7UNPnnFTH45OKTE75xWk9chKicR3QjsV
 IjozpGq4upSBA==
Date: Wed, 9 Mar 2022 12:43:45 +0000
From: Will Deacon <will@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: arm-smmu: Document
 nvidia,memory-controller property
Message-ID: <20220309124344.GF397@willie-the-truck>
References: <20211209163600.609613-1-thierry.reding@gmail.com>
 <Ygz7QD4EJX3vZJtD@orome> <Yid9SWbpPQQhNgA4@orome>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yid9SWbpPQQhNgA4@orome>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-tegra@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
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

On Tue, Mar 08, 2022 at 04:59:05PM +0100, Thierry Reding wrote:
> On Wed, Feb 16, 2022 at 02:25:20PM +0100, Thierry Reding wrote:
> > On Thu, Dec 09, 2021 at 05:35:57PM +0100, Thierry Reding wrote:
> > > From: Thierry Reding <treding@nvidia.com>
> > > 
> > > On NVIDIA SoC's the ARM SMMU needs to interact with the memory
> > > controller in order to map memory clients to the corresponding stream
> > > IDs. Document how the nvidia,memory-controller property can be used to
> > > achieve this.
> > > 
> > > Note that this is a backwards-incompatible change that is, however,
> > > necessary to ensure correctness. Without the new property, most of the
> > > devices would still work but it is not guaranteed that all will.
> > > 
> > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > > ---
> > > Changes in v2:
> > > - clarify why the new nvidia,memory-controller property is required
> > > 
> > >  .../devicetree/bindings/iommu/arm,smmu.yaml     | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > 
> > Hi Joerg,
> > 
> > can you pick up patches 1-3 of this series? DT bindings have been
> > reviewed by Rob and Will acked the ARM SMMU change. I can take the
> > device tree changes (patch 4) through the Tegra tree.
> 
> Will, Robin, Joerg,
> 
> I haven't seen this show up in linux-next yet but was hoping to see this
> go in for v5.18. Anything I can do to help this move along?

Hmm, I guess I could've taken 1-3, but after your message to Joerg I just
Acked the driver change on the assumption that was a dependency or
something.

In any case, I'm happy for Joerg to pick these three up directly if he has
time this late in the cycle.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
