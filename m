Return-Path: <SRS0=vo+x=MZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB569C4338F
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 10:55:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7483560FC0
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 10:55:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7483560FC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 457EE606EA;
	Mon,  2 Aug 2021 10:55:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z8wi0-Q0dc1p; Mon,  2 Aug 2021 10:55:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3FAE7607FA;
	Mon,  2 Aug 2021 10:55:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16B04C001B;
	Mon,  2 Aug 2021 10:55:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8170FC000E
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 10:55:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6350740161
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 10:55:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hxcUnKiL80P1 for <iommu@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 10:55:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B3F6E40193
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 10:55:51 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99A0860FD8;
 Mon,  2 Aug 2021 10:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627901751;
 bh=FydgtdwsRp9EnGLAnZNQbni8BGi4iPlFDNZ5+Emj/bA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MvBW1mFBfhWkp0RBKF+6rg70GNMqy/Ec+rGLHr9Ib+LS8A4Wn5wG+szv9Xfj8Z6QI
 6fUU9w5xm+BMjbL9SbQ0Oso5xWOJ89CdZuCx2EF1mHeGKGSqOKSWyyDXtlZiM+X7VM
 l6LHTB6s9uL2CWcNTxtbGafHUBYmR24zuSfY+KRQOVaCTmDzulBFvuP5vqjUPF/STf
 GZAlfD1MvRTjG2fhXvc6VcceLei2ZKbtfdSkQxmg6r2vWyg1rKF4+s7Bvl1XGDyY76
 nqYofb5tXVzNHKDJ1m7EUsm3XyckKGDN1FlCa2R4Sqn1VxZZvZ7cMat6rEfaDEADzU
 kXlX2gcQrkz5Q==
Date: Mon, 2 Aug 2021 11:55:45 +0100
From: Will Deacon <will@kernel.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCH 0/3] iommu/drm/msm: Allow non-coherent masters to use
 system cache
Message-ID: <20210802105544.GA27657@willie-the-truck>
References: <cover.1610372717.git.saiprakash.ranjan@codeaurora.org>
 <20210728140052.GB22887@mms-0441>
 <8b2742c8891abe4fec3664730717a089@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8b2742c8891abe4fec3664730717a089@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: isaacm@codeaurora.org, freedreno <freedreno@lists.freedesktop.org>,
 Jordan Crouse <jcrouse@codeaurora.org>, David Airlie <airlied@linux.ie>,
 linux-arm-msm@vger.kernel.org, Akhil P Oommen <akhilpo@codeaurora.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Kristian H Kristensen <hoegsberg@google.com>,
 Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>,
 linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>
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

On Thu, Jul 29, 2021 at 10:08:22AM +0530, Sai Prakash Ranjan wrote:
> On 2021-07-28 19:30, Georgi Djakov wrote:
> > On Mon, Jan 11, 2021 at 07:45:02PM +0530, Sai Prakash Ranjan wrote:
> > > commit ecd7274fb4cd ("iommu: Remove unused IOMMU_SYS_CACHE_ONLY flag")
> > > removed unused IOMMU_SYS_CACHE_ONLY prot flag and along with it went
> > > the memory type setting required for the non-coherent masters to use
> > > system cache. Now that system cache support for GPU is added, we will
> > > need to set the right PTE attribute for GPU buffers to be sys cached.
> > > Without this, the system cache lines are not allocated for GPU.
> > > 
> > > So the patches in this series introduces a new prot flag IOMMU_LLC,
> > > renames IO_PGTABLE_QUIRK_ARM_OUTER_WBWA to IO_PGTABLE_QUIRK_PTW_LLC
> > > and makes GPU the user of this protection flag.
> > 
> > Thank you for the patchset! Are you planning to refresh it, as it does
> > not apply anymore?
> > 
> 
> I was waiting on Will's reply [1]. If there are no changes needed, then
> I can repost the patch.

I still think you need to handle the mismatched alias, no? You're adding
a new memory type to the SMMU which doesn't exist on the CPU side. That
can't be right.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
