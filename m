Return-Path: <SRS0=qwh6=M2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05512C4338F
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 12:36:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A91B760EFF
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 12:36:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A91B760EFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 77B496077B;
	Tue,  3 Aug 2021 12:36:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Byi5fXF2Gi-j; Tue,  3 Aug 2021 12:36:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C3A836068B;
	Tue,  3 Aug 2021 12:35:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F6A1C0010;
	Tue,  3 Aug 2021 12:35:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 678A4C000E
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 12:35:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 452C182884
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 12:35:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9Hn3cE4uoIFG for <iommu@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 12:35:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9FD488258D
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 12:35:54 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB7A860EB9;
 Tue,  3 Aug 2021 12:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627994154;
 bh=M3BfNEx5IT0rbeH9S8HguBwKyx5n0nfj2QOvBxh6dfs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=a/xS1WCtL1WvKPUClr+Tt60U7LD7wFszy7P/0EqgtrJH66isd+ncDa1kvgNCl9SHK
 DB87VQfSkLspaKTUsxiqxEDxPu8dZ306YBMAccLbr+MK9Bc9+lrsHBrLeEGCuRzDvs
 TF1/4ZYm7qqAAz/dJtbeSC+qnHZzSV34b2NdTHLyci/VuMdtO6XXbdWqiUE2/sy7Xf
 cLrtanB3IWDPr/hXT6xNSGBgTR2cQ9eHt4eRujYm/tB2YNaxWTAD6s1Eu2625axov2
 q3XAXVKXHu/I+1pNwOXWHe0PI5CRZPPw9Ckoju0MEPqom/L1qvFhIG4dueK/iTHsCH
 cX4/GAqHEVRlw==
Date: Tue, 3 Aug 2021 13:35:49 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 23/24] iommu/arm-smmu: Allow non-strict in
 pgtable_quirks interface
Message-ID: <20210803123548.GA30932@willie-the-truck>
References: <cover.1627468308.git.robin.murphy@arm.com>
 <0fcd1f5225a6b435cbc697551a6247cd435c04db.1627468310.git.robin.murphy@arm.com>
 <20210802130438.GA28547@willie-the-truck>
 <3dd7cdae-7111-6ff2-6350-a0e19fe4ab66@arm.com>
 <20210803103559.GA30690@willie-the-truck>
 <529750e7-89a0-cfb7-8cef-36bb78b06340@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <529750e7-89a0-cfb7-8cef-36bb78b06340@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-kernel@vger.kernel.org, dianders@chromium.org,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

On Tue, Aug 03, 2021 at 01:13:12PM +0100, Robin Murphy wrote:
> On 2021-08-03 11:36, Will Deacon wrote:
> > Overall, I'm really nervous about the concurrency here and think we'd be
> > better off requiring the unbind as we have for the other domain changes.
> 
> Sure, the dynamic switch is what makes it ultimately work for Doug's
> use-case (where the unbind isn't viable), but I had every expectation that
> we might need to hold back those two patches for much deeper consideration.
> It's no accident that the first 22 patches can still be usefully applied
> without them!

Oh, the rest of the series looks great which is why I jumped on this bit!

> In all honesty I don't really like this particular patch much, mostly
> because I increasingly dislike IO_PGTABLE_QUIRK_NON_STRICT at all, but since
> the interface was there it made it super easy to prove the concept. I have a
> more significant refactoring of the io-pgtable code sketched out in my mind
> already, it's just going to be more work.

Intriguing... Move the smp_wmb() into the IOVA code instead?

> > With your changes, I think quite a few things can go wrong.
> > 
> >    * cookie->fq_domain may be observed but iovad->fq could be NULL
> 
> Good point, I guess that already technically applies (if iovad->fq sat in a
> write buffer long enough), but it certainly becomes far easier to provoke.
> However a barrier after assigning fq_domain (as mentioned above) paired with
> the control dependency around the queue_iova() call would also fix that,
> right?
> 
> >    * We can miss the smp_wmb() in the pgtable code but end up deferring the
> >      IOVA reclaim
> >    * iommu_change_dev_def_domain() only holds the group mutex afaict, so can
> >      possibly run concurrently with itself on the same domain?
> >    * iommu_dma_init_fq() can flip the domain type back from
> >      IOMMU_DOMAIN_DMA_FQ to IOMMU_DOMAIN_DMA on the error path
> >    * set_pgtable_quirks() isn't atomic, which probably is ok for now, but the
> >      moment we use it anywhere else it's dangerous
> 
> In other words, IO_PGTABLE_QUIRK_NON_STRICT is definitely the problem. I'll
> have a hack on that this afternoon, and if it starts to look rabbit-holey
> I'll split this bit off and post v3 of the rest of the series.
> 
> If all the io-pgtable and fq behaviour for a given call could be consistent
> based on a single READ_ONCE(cookie->fq_domain) in iommu_dma_unmap(), do you
> see any remaining issues other than the point above?

I'd have to see the patches, and I didn't look exhaustively at the current
stuff. But yes, I think the basic flow needs to be that there is an atomic
flag (i.e. cookie->fq_domain) which indicates which mode is being used
and if you flip that concurrently then you need to guarantee that everybody
is either using the old more or the new mode and not some halfway state in
between.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
