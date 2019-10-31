Return-Path: <SRS0=DWjf=YY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21225CA9ECB
	for <iommu@archiver.kernel.org>; Thu, 31 Oct 2019 15:33:00 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D55CF2086D
	for <iommu@archiver.kernel.org>; Thu, 31 Oct 2019 15:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="H6w56olD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BixRIEE2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D55CF2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 901B8B79;
	Thu, 31 Oct 2019 15:32:59 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D6439AAE
	for <iommu@lists.linux-foundation.org>;
	Thu, 31 Oct 2019 15:32:58 +0000 (UTC)
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 82C1163D
	for <iommu@lists.linux-foundation.org>;
	Thu, 31 Oct 2019 15:32:58 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5EECC6039E; Thu, 31 Oct 2019 15:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1572535978;
	bh=Wu1p4lTlnkRIn2ZFKfaTp50Re4Hzw0Tp88nEqxRXUxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H6w56olDKvHUqqwcMWNv6CPNBxXRXHVmTJStViy1ihrGv7rlpUJ2er5e7b5VAaLyt
	Fq2cCtmjYFNyxVqK6Fhp7QCu9ZlstaFrNecEmo5rMUpWYKFXHLXIT/oBLwX9AR/Xg/
	1NDpRvZXOD7aL7nhyxf/xFSBvAaXDyjPrj0nKrlg=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
	[199.106.103.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: jcrouse@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 423F46039E;
	Thu, 31 Oct 2019 15:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1572535977;
	bh=Wu1p4lTlnkRIn2ZFKfaTp50Re4Hzw0Tp88nEqxRXUxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BixRIEE21yHa0q9XH28ahzi56AT/NPqXB5o4qHpBc3ERHsj3xe+eB91QJ7dod4cUX
	QOdIkeC7/Pahx4aCosYbabFoZIgFFqGrHVs7CS0wPPlRKUlgv6xXxTnAIPf1FtJV4j
	L3hacs382z2DMq/ZklkJc2iTOJ9KIWhm2wANi4aE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 423F46039E
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date: Thu, 31 Oct 2019 09:32:55 -0600
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 6/7] Revert "iommu/arm-smmu: Make arm-smmu explicitly
	non-modular"
Message-ID: <20191031153255.GB8188@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Will Deacon <will@kernel.org>,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Robin Murphy <robin.murphy@arm.com>
References: <20191030145112.19738-1-will@kernel.org>
	<20191030145112.19738-7-will@kernel.org>
	<20191030230941.GA8188@jcrouse1-lnx.qualcomm.com>
	<20191031120327.GD26059@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191031120327.GD26059@willie-the-truck>
User-Agent: Mutt/1.5.24 (2015-08-30)
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

On Thu, Oct 31, 2019 at 12:03:28PM +0000, Will Deacon wrote:
> On Wed, Oct 30, 2019 at 05:09:41PM -0600, Jordan Crouse wrote:
> > On Wed, Oct 30, 2019 at 02:51:11PM +0000, Will Deacon wrote:
> > > @@ -2235,12 +2237,16 @@ static const struct dev_pm_ops arm_smmu_pm_ops = {
> > >  
> > >  static struct platform_driver arm_smmu_driver = {
> > >  	.driver	= {
> > > -		.name			= "arm-smmu",
> > > -		.of_match_table		= of_match_ptr(arm_smmu_of_match),
> > > -		.pm			= &arm_smmu_pm_ops,
> > > -		.suppress_bind_attrs	= true,
> > > +		.name		= "arm-smmu",
> > > +		.of_match_table	= of_match_ptr(arm_smmu_of_match),
> > > +		.pm		= &arm_smmu_pm_ops,
> > >  	},
> > >  	.probe	= arm_smmu_device_probe,
> > > +	.remove	= arm_smmu_device_remove,
> > >  	.shutdown = arm_smmu_device_shutdown,
> > >  };
> > > -builtin_platform_driver(arm_smmu_driver);
> > > +module_platform_driver(arm_smmu_driver);
> > 
> > I know this is a revert, but wouldn't you still want to be at device_init()
> > level for built in drivers? It always preferable to not defer if given the
> > choice to do so and device_init() is the right level for this driver IMO.
> 
> Hmm, not sure I'm following you completely here. With this change,
> module_init() is used to invoke platform_driver_register(). For builtin
> drivers, module_initx() expands to __initcall(x), which itself expands
> to device_initcall(x). Or are you referrring to something else?
 
 Oh, yep, I was off. For whatever reason I thought device and module were at
 different levels. Sorry for the noise.

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
