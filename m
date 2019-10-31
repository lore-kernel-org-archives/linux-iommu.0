Return-Path: <SRS0=DWjf=YY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DE9CA9EC3
	for <iommu@archiver.kernel.org>; Thu, 31 Oct 2019 12:03:34 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3FEC20873
	for <iommu@archiver.kernel.org>; Thu, 31 Oct 2019 12:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cES5yBB/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3FEC20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id BCD9E129D;
	Thu, 31 Oct 2019 12:03:33 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E0DAA1297
	for <iommu@lists.linux-foundation.org>;
	Thu, 31 Oct 2019 12:03:32 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9D99E174
	for <iommu@lists.linux-foundation.org>;
	Thu, 31 Oct 2019 12:03:32 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 97D3A2086D;
	Thu, 31 Oct 2019 12:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572523412;
	bh=PCgpgl5TvROz0Gbm25l3kuycLpN7y37Y2PSEmcK//es=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=cES5yBB/8oCqueLi5bsvAcXmS39D5iPrOpxzDP624XUXSRf31gQ8Eq1XNIxWwWpx0
	zHeCfsdTPGGAG9UT2U1uTiJLtK7U3/b9WSHEu6JQNf3JVa9BUrxGtG5+FatO9RJuC6
	OcUF/8sJ7Qd4ScxdaqU8v64N8WjOx+RD4iIZxx6Q=
Date: Thu, 31 Oct 2019 12:03:28 +0000
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 6/7] Revert "iommu/arm-smmu: Make arm-smmu explicitly
	non-modular"
Message-ID: <20191031120327.GD26059@willie-the-truck>
References: <20191030145112.19738-1-will@kernel.org>
	<20191030145112.19738-7-will@kernel.org>
	<20191030230941.GA8188@jcrouse1-lnx.qualcomm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191030230941.GA8188@jcrouse1-lnx.qualcomm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

On Wed, Oct 30, 2019 at 05:09:41PM -0600, Jordan Crouse wrote:
> On Wed, Oct 30, 2019 at 02:51:11PM +0000, Will Deacon wrote:
> > @@ -2235,12 +2237,16 @@ static const struct dev_pm_ops arm_smmu_pm_ops = {
> >  
> >  static struct platform_driver arm_smmu_driver = {
> >  	.driver	= {
> > -		.name			= "arm-smmu",
> > -		.of_match_table		= of_match_ptr(arm_smmu_of_match),
> > -		.pm			= &arm_smmu_pm_ops,
> > -		.suppress_bind_attrs	= true,
> > +		.name		= "arm-smmu",
> > +		.of_match_table	= of_match_ptr(arm_smmu_of_match),
> > +		.pm		= &arm_smmu_pm_ops,
> >  	},
> >  	.probe	= arm_smmu_device_probe,
> > +	.remove	= arm_smmu_device_remove,
> >  	.shutdown = arm_smmu_device_shutdown,
> >  };
> > -builtin_platform_driver(arm_smmu_driver);
> > +module_platform_driver(arm_smmu_driver);
> 
> I know this is a revert, but wouldn't you still want to be at device_init()
> level for built in drivers? It always preferable to not defer if given the
> choice to do so and device_init() is the right level for this driver IMO.

Hmm, not sure I'm following you completely here. With this change,
module_init() is used to invoke platform_driver_register(). For builtin
drivers, module_initx() expands to __initcall(x), which itself expands
to device_initcall(x). Or are you referrring to something else?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
