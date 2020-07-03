Return-Path: <SRS0=r5As=AO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D49CC433E2
	for <iommu@archiver.kernel.org>; Fri,  3 Jul 2020 15:40:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02C51208E4
	for <iommu@archiver.kernel.org>; Fri,  3 Jul 2020 15:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="elkxLORL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C51208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D707987D99;
	Fri,  3 Jul 2020 15:40:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vXV9LEmH5woe; Fri,  3 Jul 2020 15:40:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5AD5287CD6;
	Fri,  3 Jul 2020 15:40:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5116AC088E;
	Fri,  3 Jul 2020 15:40:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A106C0733
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 15:40:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 481FB87CEA
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 15:40:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BJHKXhodMUf2 for <iommu@lists.linux-foundation.org>;
 Fri,  3 Jul 2020 15:40:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D81EC87CD6
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 15:40:32 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 989D92088E;
 Fri,  3 Jul 2020 15:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593790832;
 bh=Csd/koDiDw1K1inIpkFWBNC1R6v7CBb2CU5Zmf57acc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=elkxLORLhsNPysnTycAsiV9dFFqH0sJrERhvHzdVnSoWd31u24otySgv6AFBrN1xi
 20i17gBg/JBftX4eTBohoOLJbWQxcuzwVPUj4482fpgRShUysZjsxNRm6OrzzFkGzP
 JyEoNBGIJ+mor3VD4UbEyhZTuwVDS+N5L2VhAXhA=
Date: Fri, 3 Jul 2020 16:40:26 +0100
From: Will Deacon <will@kernel.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCHv3 7/7] drm/msm/a6xx: Add support for using system
 cache(LLC)
Message-ID: <20200703154025.GB19327@willie-the-truck>
References: <cover.1593344119.git.saiprakash.ranjan@codeaurora.org>
 <449a6544b10f0035d191ac52283198343187c153.1593344120.git.saiprakash.ranjan@codeaurora.org>
 <20200703133732.GD18953@willie-the-truck>
 <ecfda7ca80f6d7b4ff3d89b8758f4dc9@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ecfda7ca80f6d7b4ff3d89b8758f4dc9@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Sean Paul <sean@poorly.run>, freedreno@lists.freedesktop.org,
 David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Matthias Kaehlcke <mka@chromium.org>, Akhil P Oommen <akhilpo@codeaurora.org>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 "Kristian H . Kristensen" <hoegsberg@google.com>,
 Stephen Boyd <swboyd@chromium.org>, Robin Murphy <robin.murphy@arm.com>,
 Sharat Masetty <smasetty@codeaurora.org>, linux-arm-kernel@lists.infradead.org,
 Emil Velikov <emil.velikov@collabora.com>
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

On Fri, Jul 03, 2020 at 08:23:07PM +0530, Sai Prakash Ranjan wrote:
> On 2020-07-03 19:07, Will Deacon wrote:
> > On Mon, Jun 29, 2020 at 09:22:50PM +0530, Sai Prakash Ranjan wrote:
> > > diff --git a/drivers/gpu/drm/msm/msm_iommu.c
> > > b/drivers/gpu/drm/msm/msm_iommu.c
> > > index f455c597f76d..bd1d58229cc2 100644
> > > --- a/drivers/gpu/drm/msm/msm_iommu.c
> > > +++ b/drivers/gpu/drm/msm/msm_iommu.c
> > > @@ -218,6 +218,9 @@ static int msm_iommu_map(struct msm_mmu *mmu,
> > > uint64_t iova,
> > >  		iova |= GENMASK_ULL(63, 49);
> > > 
> > > 
> > > +	if (mmu->features & MMU_FEATURE_USE_SYSTEM_CACHE)
> > > +		prot |= IOMMU_SYS_CACHE_ONLY;
> > 
> > Given that I think this is the only user of IOMMU_SYS_CACHE_ONLY, then
> > it
> > looks like it should actually be a property on the domain because we
> > never
> > need to configure it on a per-mapping basis within a domain, and
> > therefore
> > it shouldn't be exposed by the IOMMU API as a prot flag.
> > 
> > Do you agree?
> > 
> 
> GPU being the only user is for now, but there are other clients which can
> use this.
> Plus how do we set the memory attributes if we do not expose this as prot
> flag?

I just don't understand the need for it to be per-map operation. Put another
way, if we extended the domain attribute to apply to cacheable mappings
on the domain and not just the table walk, what would break?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
