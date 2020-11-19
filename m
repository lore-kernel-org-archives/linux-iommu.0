Return-Path: <SRS0=wYjh=EZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0C5C2D0E4
	for <iommu@archiver.kernel.org>; Thu, 19 Nov 2020 08:53:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 320A420758
	for <iommu@archiver.kernel.org>; Thu, 19 Nov 2020 08:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbV9Ofh3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 320A420758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9A32B873AB;
	Thu, 19 Nov 2020 08:53:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FQYaNp+yL73U; Thu, 19 Nov 2020 08:53:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id CA1A3869FE;
	Thu, 19 Nov 2020 08:53:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB2E6C1825;
	Thu, 19 Nov 2020 08:53:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96D55C0891
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 08:53:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8291E204DE
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 08:53:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hSxmSX3Zq2Mq for <iommu@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 08:53:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id B84F1204D5
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 08:53:09 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 06DFB20758;
 Thu, 19 Nov 2020 08:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605775989;
 bh=F1Ox8ZDjpt1A8s9Yeijg/9qfPwEBH7cjPRBb6NfVKFA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GbV9Ofh3G7mZa7mWJ8ep2EGwyk87oPhmhBLkdLFFrubFgzIQibUz2JPh0Qj/xrk6F
 gf+S6Nf5tTV5f/A+dvAlDArOxu82mqYn0JFYBQep2b2VNsXgg9f8tvIcVay9zq9+5t
 ZXbuFqbcGaFJPh4fc+5kSj8xMkIU69nMgNPFSzwg=
Date: Thu, 19 Nov 2020 08:53:04 +0000
From: Will Deacon <will@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [Patch V8 1/3] iommu: Add support to change default domain of an
 iommu group
Message-ID: <20201119085303.GA3599@willie-the-truck>
References: <20200925190620.18732-1-ashok.raj@intel.com>
 <20200925190620.18732-2-ashok.raj@intel.com>
 <20201118135153.GB2177@willie-the-truck>
 <568d4dee-ad10-ca4f-d51a-8909afb6b782@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <568d4dee-ad10-ca4f-d51a-8909afb6b782@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Will Deacon <will.deacon@arm.com>, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Ashok Raj <ashok.raj@intel.com>,
 Christoph Hellwig <hch@lst.de>
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

On Thu, Nov 19, 2020 at 10:18:05AM +0800, Lu Baolu wrote:
> The original author of this patch series has left Intel. I am now the
> backup.

Ok, thanks for letting me know.

> On 11/18/20 9:51 PM, Will Deacon wrote:
> > On Fri, Sep 25, 2020 at 12:06:18PM -0700, Ashok Raj wrote:
> > > From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>

[...]

> > > +free_new_domain:
> > > +	iommu_domain_free(group->default_domain);
> > > +	group->default_domain = prev_dom;
> > > +	group->domain = prev_dom;i
> > 
> > Hmm. This seems to rely on all users of group->default_domain holding the
> > group->mutex. Have you confirmed that this is the case? There's a funny
> > use of iommu_group_get() in the exynos IOMMU driver at least.
> 
> Emm. This change happens within the area with group->mutex held. Or I
> am not getting your point?

Yeah, sorry, I wasn't very clear. This code holds the group->mutex, and it
relies on _anybody_ else who wants to inspect group->default_domain also
holding that mutex, otherwise they could observe a transient domain pointer
which we free on the failure path here.

My question is whether or not there is code that inspects
group->default_domain without group->mutex held? The exynos case doesn't
obviously hold it, and I'd like to make sure that there aren't others that
we need to worry about.

Does that make more sense?

Thanks,

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
