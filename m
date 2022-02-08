Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33173C433FE
	for <iommu@archiver.kernel.org>; Tue,  8 Feb 2022 15:19:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A4F6540943;
	Tue,  8 Feb 2022 15:19:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DQ00PUNHPw5w; Tue,  8 Feb 2022 15:19:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7C7C340271;
	Tue,  8 Feb 2022 15:19:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 578DFC0011;
	Tue,  8 Feb 2022 15:19:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DAD29C000B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 15:19:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C9CEB60736
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 15:19:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oA3jhXwdfQQ8 for <iommu@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 15:19:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 804EE606FF
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 15:19:42 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id D6726B81B92;
 Tue,  8 Feb 2022 15:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62CEBC004E1;
 Tue,  8 Feb 2022 15:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644333578;
 bh=fIjxqOup6OwNvRXLtgfT5VcCzdLMcW360tWbTxHYLyo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=A691zmXwYzGeuKQXa/N6uWG/wsfSLBJIJOtIyoGzTkIcBq2+cKkBle4kAQZ3gf+LW
 6sbg9V+g9m17lomD+4XR/Fq0Nz1KWjzZJ2z9bvoABFRKK4CWEsDwTS+j9diztxWY5U
 5UXR0x7A7qrV8mSM9G9B1Thn/AKdWiSATfqkKb9Oq0w8I+1x5yQItdfX9CJ3aHyB0u
 c+ouxKI86H33fVqpGBCrVmopDZImiC4X5ciw2dWYaI6AzSGK48MqDIEisJYMwKA0h3
 FqxURq4I9v4S9ZRK+D6/wRH6yQ9iL48Qy1h7Yr29kRktyncaj9v2KXS2q3qHR2ftsQ
 7290lS/6N5klA==
Date: Tue, 8 Feb 2022 15:19:32 +0000
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 1/2] iommu/arm-smmu: Use platform_irq_count() to get the
 interrupt count
Message-ID: <20220208151932.GB1802@willie-the-truck>
References: <20211223130046.9365-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211223130046.9365-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <f9efc8e8-9dc6-8a80-15bb-bc2d9aaf60cb@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f9efc8e8-9dc6-8a80-15bb-bc2d9aaf60cb@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Rob Clark <robdclark@chromium.org>,
 "Isaac J. Manjarres" <isaacm@codeaurora.org>, Xin Tan <tanxin.ctf@gmail.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, Prabhakar <prabhakar.csengg@gmail.com>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
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

On Thu, Dec 23, 2021 at 02:14:35PM +0000, Robin Murphy wrote:
> On 2021-12-23 13:00, Lad Prabhakar wrote:
> > platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> > allocation of IRQ resources in DT core code, this causes an issue
> > when using hierarchical interrupt domains using "interrupts" property
> > in the node as this bypasses the hierarchical setup and messes up the
> > irq chaining.
> > 
> > In preparation for removal of static setup of IRQ resource from DT core
> > code use platform_get_irq_count().
> 
> Nit: platform_irq_count()
> 
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >   drivers/iommu/arm/arm-smmu/arm-smmu.c | 12 ++++++------
> >   1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > index 4bc75c4ce402..4844cd075644 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > @@ -2105,12 +2105,12 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
> >   	if (IS_ERR(smmu))
> >   		return PTR_ERR(smmu);
> > -	num_irqs = 0;
> > -	while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, num_irqs))) {
> > -		num_irqs++;
> > -		if (num_irqs > smmu->num_global_irqs)
> > -			smmu->num_context_irqs++;
> > -	}
> > +	num_irqs = platform_irq_count(pdev);
> > +	if (num_irqs < 0)
> > +		return num_irqs;
> > +
> > +	if (num_irqs > smmu->num_global_irqs)
> > +		smmu->num_context_irqs += (num_irqs - smmu->num_global_irqs);
> 
> This seems a bit overcomplicated. I reckon:
> 
> 	smmu->num_context_irqs = num_irqs - smmu->num_global_irqs;
> 	if (num_irqs <= smmu->num_global_irqs) {
> 		dev_err(...
> 
> should do it.
> 
> However, FYI I have some patches refactoring most of the IRQ stuff here that
> I plan to post next cycle (didn't quite have time to get them done for 5.17
> as I'd hoped...), so unless this needs to go in right now as an urgent fix,
> I'm happy to take care of removing platform_get_resource() as part of that
> if it's easier.

Did you get anywhere with this? December 23rd is long forgotten by now ;)

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
