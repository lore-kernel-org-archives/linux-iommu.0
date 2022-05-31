Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC918C433F5
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 16:19:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7EA3141C46;
	Tue, 31 May 2022 16:19:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vxyc8N65lVWA; Tue, 31 May 2022 16:19:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1733541C42;
	Tue, 31 May 2022 16:19:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF597C0039;
	Tue, 31 May 2022 16:19:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7B9CC002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 16:19:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9708441C46
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 16:19:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y6Gwsw2eKZPg for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 16:19:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BD9D141C42
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 16:19:19 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0CA5B604F5;
 Tue, 31 May 2022 16:19:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D2CC385A9;
 Tue, 31 May 2022 16:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654013958;
 bh=C7JqPHYdDIfIV1hFpEuC1J6B7QEItv7CaH7EVzTRasE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=c7uCs1jy8TG74D+Nj32f4BthpKKQvR+72bqpZXJZDojOu/Ri4D//ChSLI2vkj884B
 k35ZMlm5UJfSwDAtNkaERyfhCvFvZXDpAthbHc4HkQ7W03zyQPBFHoKp7stXu318GC
 5VM4zAwxH7TtP3LB1s/bzGOH8e9Lq2vjBfscQPE3016J1EHU4Nqji9R8xT3oCFM7zr
 HGeViJPNgdB51Kq1EoXhNEyKiBj2Ya4ArkH46ly3m4pxnzPNywvMEU2/pM4mGnrLa2
 psUMVuVTbOqTI27e5Hs7HKH8fpB6H+JgeeIjB7UTyNZkdBfYSv+/9JLpw/iQ0xyJfZ
 r4XR05x5qaAjg==
Date: Tue, 31 May 2022 17:19:11 +0100
From: Will Deacon <will@kernel.org>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH 1/6] iommu/qcom: Use the asid read from device-tree if
 specified
Message-ID: <20220531161910.GE25502@willie-the-truck>
References: <20220527212901.29268-1-konrad.dybcio@somainline.org>
 <20220527212901.29268-2-konrad.dybcio@somainline.org>
 <20220531154631.GA25502@willie-the-truck>
 <CAF6AEGsWsHfQZnszG=NgP0BufxO-DP4LwvsAYkrz2wRhcJuOXw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF6AEGsWsHfQZnszG=NgP0BufxO-DP4LwvsAYkrz2wRhcJuOXw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Konrad Dybcio <konrad.dybcio@somainline.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 jamipkettunen@somainline.org, Rob Herring <robh+dt@kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Andy Gross <agross@kernel.org>, Martin Botka <martin.botka@somainline.org>,
 ~postmarketos/upstreaming@lists.sr.ht,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
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

On Tue, May 31, 2022 at 09:15:22AM -0700, Rob Clark wrote:
> On Tue, May 31, 2022 at 8:46 AM Will Deacon <will@kernel.org> wrote:
> >
> > On Fri, May 27, 2022 at 11:28:56PM +0200, Konrad Dybcio wrote:
> > > From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> > >
> > > As specified in this driver, the context banks are 0x1000 apart.
> > > Problem is that sometimes the context number (our asid) does not
> > > match this logic and we end up using the wrong one: this starts
> > > being a problem in the case that we need to send TZ commands
> > > to do anything on a specific context.
> >
> > I don't understand this. The ASID is a software construct, so it shouldn't
> > matter what we use. If it does matter, then please can you explain why? The
> > fact that the context banks are 0x1000 apart seems unrelated.
> 
> I think the connection is that mapping from ctx bank to ASID is 1:1

But in what sense? How is the ASID used beyond a tag in the TLB? The commit
message hints at "TZ commands" being a problem.

I'm not doubting that this is needed to make the thing work, I just don't
understand why.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
