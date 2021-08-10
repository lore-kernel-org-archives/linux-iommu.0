Return-Path: <SRS0=o4oj=NB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1687BC432BE
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 09:16:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B08886056B
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 09:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B08886056B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 759E6831A5;
	Tue, 10 Aug 2021 09:16:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bRrPE-4Ul5g0; Tue, 10 Aug 2021 09:16:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 41DD18316A;
	Tue, 10 Aug 2021 09:16:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC649C0010;
	Tue, 10 Aug 2021 09:16:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2FDCEC000E
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 09:16:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0A9C4605EB
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 09:16:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rUbhKWK3--O6 for <iommu@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 09:16:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7C5EE605D1
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 09:16:26 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3C166056B;
 Tue, 10 Aug 2021 09:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628586986;
 bh=hG1PKIfUobySTRl3kToyKQWcPI+bWs/Llfdg4HtV8Lc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mOAHGE6mrYyzdYOiATqBh3ctWbADLleThoclue/CxW6EWM3taq8sQYiRgsVZlnr09
 pTsO2mPLnhhPRbGIXVu+JQJ2eRglxQu799oybVa190XqsKer2qr7WDXFO6on/S0RdX
 rcaqL3+aDwZeiOVHzyEQ/0bEATuepbIqh1CLsdxN/hNFhyRgjwfkEBZW+iEoIap9QV
 Gx8IBDY7U01l8JCBcG53fyX1QSncT2DWzpjXp4GoKw3IIKzCKbj/Cy16Vee4V4RCDg
 +Y0VAfWigUKKCWw/eJynPJN7yEgpHxV4zOqqDEZ+BI+3XY4Utiq060cAGEHVTTGNQv
 PykOiqiyVk43A==
Date: Tue, 10 Aug 2021 10:16:19 +0100
From: Will Deacon <will@kernel.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [Freedreno] [PATCH 0/3] iommu/drm/msm: Allow non-coherent
 masters to use system cache
Message-ID: <20210810091619.GA2494@willie-the-truck>
References: <20210802105544.GA27657@willie-the-truck>
 <CAF6AEGvtpFu8st=ZFNoKjP9YsAenciLxL1zMFi_iqMCvdby73w@mail.gmail.com>
 <20210802151409.GE28735@willie-the-truck>
 <CAF6AEGtzvyEUm0Fc8QT5t9KNK7i0FbFyi7zDM2_PMCzZBp7qbw@mail.gmail.com>
 <20210809145651.GC1458@willie-the-truck>
 <CAF6AEGsSUojA=V0n2iRWTCn++buqN=Eoxo0r3=+=PBu1O=H-AQ@mail.gmail.com>
 <20210809170508.GB1589@willie-the-truck>
 <CAF6AEGtmZ3LzAJdtnKDQDbEN-a6_JgdN-fZ96pkU3dZqkiW91g@mail.gmail.com>
 <20210809174022.GA1840@willie-the-truck>
 <76bfd0b4248148dfbf9d174ddcb4c2a2@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <76bfd0b4248148dfbf9d174ddcb4c2a2@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 David Airlie <airlied@linux.ie>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Jordan Crouse <jcrouse@codeaurora.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Akhil P Oommen <akhilpo@codeaurora.org>, Sean Paul <sean@poorly.run>,
 "list@263.net:IOMMU DRIVERS , Joerg Roedel <joro@8bytes.org>,
 " <iommu@lists.linux-foundation.org>,
 Kristian H Kristensen <hoegsberg@google.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Daniel Vetter <daniel@ffwll.ch>,
 freedreno <freedreno@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
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

On Mon, Aug 09, 2021 at 11:17:40PM +0530, Sai Prakash Ranjan wrote:
> On 2021-08-09 23:10, Will Deacon wrote:
> > On Mon, Aug 09, 2021 at 10:18:21AM -0700, Rob Clark wrote:
> > > On Mon, Aug 9, 2021 at 10:05 AM Will Deacon <will@kernel.org> wrote:
> > > > On Mon, Aug 09, 2021 at 09:57:08AM -0700, Rob Clark wrote:
> > > > > But I suppose we could call it instead IOMMU_QCOM_LLC or something
> > > > > like that to make it more clear that it is not necessarily something
> > > > > that would work with a different outer level cache implementation?
> > > >
> > > > ... or we could just deal with the problem so that other people can reuse
> > > > the code. I haven't really understood the reluctance to solve this properly.
> > > >
> > > > Am I missing some reason this isn't solvable?
> > > 
> > > Oh, was there another way to solve it (other than foregoing setting
> > > INC_OCACHE in the pgtables)?  Maybe I misunderstood, is there a
> > > corresponding setting on the MMU pgtables side of things?
> > 
> > Right -- we just need to program the CPU's MMU with the matching memory
> > attributes! It's a bit more fiddly if you're just using ioremap_wc()
> > though, as it's usually the DMA API which handles the attributes under
> > the
> > hood.
> > 
> > Anyway, sorry, I should've said that explicitly earlier on. We've done
> > this
> > sort of thing in the Android tree so I assumed Sai knew what needed to
> > be
> > done and then I didn't think to explain to you :(
> > 
> 
> Right I was aware of that but even in the android tree there is no user :)

I'm assuming there are vendor modules using it there, otherwise we wouldn't
have been asked to put it in. Since you work at Qualcomm, maybe you could
talk to your colleagues (Isaac and Patrick) directly?

> I think we can't have a new memory type without any user right in upstream
> like android tree?

Correct. But I don't think we should be adding IOMMU_* anything upstream
if we don't have a user.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
