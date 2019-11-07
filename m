Return-Path: <SRS0=3PM5=Y7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F61C5DF61
	for <iommu@archiver.kernel.org>; Thu,  7 Nov 2019 12:48:27 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA8F22187F
	for <iommu@archiver.kernel.org>; Thu,  7 Nov 2019 12:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2qZGpLRX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA8F22187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A1C791149;
	Thu,  7 Nov 2019 12:48:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 27B8110B6
	for <iommu@lists.linux-foundation.org>;
	Thu,  7 Nov 2019 12:48:25 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id CFB6F8A8
	for <iommu@lists.linux-foundation.org>;
	Thu,  7 Nov 2019 12:48:24 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id A82DC2178F;
	Thu,  7 Nov 2019 12:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573130904;
	bh=CsU4m13XWIFTtMoZN2G9/jcV1LU2ZEOp3TgoYZ0+WzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2qZGpLRXalDMWfpBsoJCG+ufQ92m+LvQFtbiJ6TuH2j14oih7aZJ8jywjEiUYAgRr
	/c1kyoPCYrcbTNxVzBIHStyoLx4kFLxPtq4VKYtZffR5XFIxkoi5l2LuL0IMTu8dXp
	60xkzXzfG5dR62xaF/b8UWJxhMcnV27q54cHlA5Y=
Date: Thu, 7 Nov 2019 12:48:20 +0000
From: Will Deacon <will@kernel.org>
To: "Isaac J. Manjarres" <isaacm@codeaurora.org>
Subject: Re: [PATCH 7/7] iommu/arm-smmu: Allow building as a module
Message-ID: <20191107124819.GB12385@willie-the-truck>
References: <20191030145112.19738-1-will@kernel.org>
	<20191030145112.19738-8-will@kernel.org>
	<20191104193400.GA24983@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191104193400.GA24983@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Bjorn Helgaas <bhelgaas@google.com>, iommu@lists.linux-foundation.org,
	Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Isaac,

On Mon, Nov 04, 2019 at 11:34:00AM -0800, Isaac J. Manjarres wrote:
> On Wed, Oct 30, 2019 at 02:51:12PM +0000, Will Deacon wrote:
> > diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-impl.c
> > index 5c87a38620c4..2f82d40317d6 100644
> > --- a/drivers/iommu/arm-smmu-impl.c
> > +++ b/drivers/iommu/arm-smmu-impl.c
> > @@ -5,6 +5,7 @@
> >  #define pr_fmt(fmt) "arm-smmu: " fmt
> >  
> >  #include <linux/bitfield.h>
> > +#include <linux/module.h>
> >  #include <linux/of.h>
> >  
> >  #include "arm-smmu.h"
> > @@ -172,3 +173,8 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
> >  
> >  	return smmu;
> >  }
> > +EXPORT_SYMBOL_GPL(arm_smmu_impl_init);
> > +
> > +MODULE_DESCRIPTION("IOMMU quirks for ARM architected SMMU implementations");
> > +MODULE_AUTHOR("Robin Murphy <robin.murphy@arm.com>");
> > +MODULE_LICENSE("GPL v2");
> 
> A minor comment: I was curious about why arm-smmu.c and arm-smmu-impl.c
> were being compiled as two separate modules, as opposed to combining
> them into one module? The latter approach seemed more appropriate, given
> that arm-smmu-impl doesn't offer much as a module on its own. Thoughts?

Yes, you're right. The simple answer is that I couldn't come up with a good
name for the combined module, since "arm-smmu" is already taken by the core
part of the driver and I don't want to rename that file. Looking at what a
few other drivers do, it seems that "arm-smmu-mod" might be the best bet
so I'll incorporate that change for v2 and put you on cc.

Thanks!

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
