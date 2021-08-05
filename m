Return-Path: <SRS0=+AsR=M4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66675C4338F
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 11:21:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14EC160E52
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 11:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 14EC160E52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D02AD4049D;
	Thu,  5 Aug 2021 11:21:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W8-hYQqqaMTl; Thu,  5 Aug 2021 11:21:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B83F140455;
	Thu,  5 Aug 2021 11:21:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B94CC001A;
	Thu,  5 Aug 2021 11:21:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66CF0C000E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 11:21:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5E15460A8D
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 11:21:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GFc4oPWzfPOR for <iommu@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 11:21:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 42CC660A8A
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 11:21:19 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 514BA60E52;
 Thu,  5 Aug 2021 11:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628162479;
 bh=VFjPtC9UhoM5gV86KddMtIiMoUfeT0FE4dm7xQ3W6Cc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MG0aCq2J0TAoC4bp0QExr9x8nHi3ql8ui5whAPq7792IAnLdi7gSysxE6TMaT6Vjc
 CobHs41s8ZGRZgRFlwEzqxtjqyrimdIFgde5Ir4GX/6KAgLbV1n7YCtfpBU3arbOry
 Ulq3puR70zHNAwVQXxOMuWh/SBagtDDSid7BOav1SvK54ArCtJvuG4Jx+og+oiYWxb
 7vzVlx+cpM+VDVpLidQcgiTTj9lllSlrafW6UJMhB/iaV3il7HMO0esb3c43RLFuhv
 nIETmcSfEzAJESa4I7JAwy5pe7otuCqY4p5wZDfZ5MezC79T/QSBOOq8IAf4njOP+w
 qrfPLNDU1J26w==
Date: Thu, 5 Aug 2021 12:21:14 +0100
From: Will Deacon <will@kernel.org>
To: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Remove some unneeded init in
 arm_smmu_cmdq_issue_cmdlist()
Message-ID: <20210805112114.GA1029@willie-the-truck>
References: <1624293394-202509-1-git-send-email-john.garry@huawei.com>
 <bebc7b1b-e60c-d5e6-812a-63580d7029cc@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bebc7b1b-e60c-d5e6-812a-63580d7029cc@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linuxarm@huawei.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com,
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

On Thu, Aug 05, 2021 at 11:22:15AM +0100, John Garry wrote:
> On 21/06/2021 17:36, John Garry wrote:
> > Members of struct "llq" will be zero-inited, apart from member max_n_shift.
> > But we write llq.val straight after the init, so it was pointless to zero
> > init those other members. As such, separately init member max_n_shift
> > only.
> > 
> > In addition, struct "head" is initialised to "llq" only so that member
> > max_n_shift is set. But that member is never referenced for "head", so
> > remove any init there.
> > 
> > Removing these initializations is seen as a small performance optimisation,
> > as this code is (very) hot path.
> > 
> 
> Hi Will,
> 
> Any chance you can pick up this small optimisation?

Yup! I've actually queued it locally, but I may end up asking Joerg to take
it directly depending on what else I queue for 5.15. So far, most of the
SMMU stuff is all part of wider refactorings.

Cheers,

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
