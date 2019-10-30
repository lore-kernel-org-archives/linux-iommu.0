Return-Path: <SRS0=11OQ=YX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97DFCA9EC7
	for <iommu@archiver.kernel.org>; Wed, 30 Oct 2019 15:54:51 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DFFF2173E
	for <iommu@archiver.kernel.org>; Wed, 30 Oct 2019 15:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrWB7Mk8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DFFF2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 714A4E89;
	Wed, 30 Oct 2019 15:54:51 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4DDDED4A
	for <iommu@lists.linux-foundation.org>;
	Wed, 30 Oct 2019 15:54:50 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 002588A
	for <iommu@lists.linux-foundation.org>;
	Wed, 30 Oct 2019 15:54:49 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 839C0217D9;
	Wed, 30 Oct 2019 15:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572450889;
	bh=IlRkfmxagkpK4XTHGe5bLRKa65DPVjT3hWJACHX0Xno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SrWB7Mk879bug3XRPDe3MAwhVgzgOcAAesPz2M8kHTWoLEToJxvpV1alV7Y2QuXdN
	ICdfTmCW1N9UyKURUBhdK22PqAZIywFSU/GQMYZNTG/nTOOh1v2tYbnpqX5A2dqOW6
	b02Q73I/Qd3cR0ywJqoCSkvGcEC4u1XbxHj/1Ci0=
Date: Wed, 30 Oct 2019 15:54:45 +0000
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 0/7] iommu: Permit modular builds of ARM SMMU[v3] drivers
Message-ID: <20191030155444.GC19096@willie-the-truck>
References: <20191030145112.19738-1-will@kernel.org>
	<6e457227-ca06-2998-4ffa-a58ab171ce32@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6e457227-ca06-2998-4ffa-a58ab171ce32@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: saravanak@google.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, Bjorn Helgaas <bhelgaas@google.com>
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

Hi Robin,

On Wed, Oct 30, 2019 at 03:35:55PM +0000, Robin Murphy wrote:
> On 30/10/2019 14:51, Will Deacon wrote:
> > As part of the work to enable a "Generic Kernel Image" across multiple
> > Android devices, there is a need to seperate shared, core kernel code
> > from modular driver code that may not be needed by all SoCs. This means
> > building IOMMU drivers as modules.
> > 
> > It turns out that most of the groundwork has already been done to enable
> > the ARM SMMU drivers to be 'tristate' options in drivers/iommu/Kconfig;
> > with a few symbols exported from the IOMMU/PCI core, everything builds
> > nicely out of the box. The one exception is support for the legacy SMMU
> > DT binding, which is not in widespread use and has never worked with
> > modules, so we can simply remove that when building as a module rather
> > than try to paper over it with even more hacks.
> > 
> > Obviously you need to be careful about using IOMMU drivers as modules,
> > since late loading of the driver for an IOMMU serving active DMA masters
> > is going to end badly in many cases. On Android, we're using device links
> > to ensure that the IOMMU probes first.
> 
> Out of curiosity, which device links are those? Clearly not the RPM links
> created by the IOMMU drivers themselves... Is this some special Android
> magic, or is there actually a chance of replacing all the
> of_iommu_configure() machinery with something more generic?

I'll admit that I haven't used them personally yet, but I'm referring to
this series from Saravana [CC'd]:

https://lore.kernel.org/linux-acpi/20190904211126.47518-1-saravanak@google.com/

which is currently sitting in linux-next now that we're upstreaming the
"special Android magic" ;)

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
