Return-Path: <SRS0=gESx=YZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65601CA9ED1
	for <iommu@archiver.kernel.org>; Fri,  1 Nov 2019 17:21:53 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36ECC21734
	for <iommu@archiver.kernel.org>; Fri,  1 Nov 2019 17:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNqm3Wkx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36ECC21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3CBB8102C;
	Fri,  1 Nov 2019 17:21:52 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3F42D101E
	for <iommu@lists.linux-foundation.org>;
	Fri,  1 Nov 2019 17:21:51 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E319A466
	for <iommu@lists.linux-foundation.org>;
	Fri,  1 Nov 2019 17:21:50 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 96FF42085B;
	Fri,  1 Nov 2019 17:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572628910;
	bh=BROMF+gRXeSy51qya14vXyEQaseWUTq9hj4mzpZv8S4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HNqm3WkxmX5SqCf18g8DLpkh8TebVc3yct+TNG0t6EV+1/50HAVBmlehyJzXWbjpc
	C+TiG2YeqmiC5sfgM1ZQ/FAc6kgCe9PZ/x7cEsV6W4/fRqfXRluDCpezRyChzcw50w
	ObhzgEwmmLnyF3X9Pob06HER/VmLrhXZwRtMr6j0=
Date: Fri, 1 Nov 2019 17:21:46 +0000
From: Will Deacon <will@kernel.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH 0/7] iommu: Permit modular builds of ARM SMMU[v3] drivers
Message-ID: <20191101172145.GA3983@willie-the-truck>
References: <20191030145112.19738-1-will@kernel.org>
	<6e457227-ca06-2998-4ffa-a58ab171ce32@arm.com>
	<20191030155444.GC19096@willie-the-truck>
	<CAGETcx9ogWQC1ZtnS_4xC3ShqBpuRSKudWEEWC22UZUEhdEU4A@mail.gmail.com>
	<20191031193758.GA2607492@lophozonia>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191031193758.GA2607492@lophozonia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Bjorn Helgaas <bhelgaas@google.com>, iommu@lists.linux-foundation.org,
	Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
	Saravana Kannan <saravanak@google.com>
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

Hi Jean-Philippe,

Quick question while you figure out the devlink stuff with Saravana...

On Thu, Oct 31, 2019 at 08:37:58PM +0100, Jean-Philippe Brucker wrote:
> On Wed, Oct 30, 2019 at 05:57:44PM -0700, Saravana Kannan via iommu wrote:
> > > > > Obviously you need to be careful about using IOMMU drivers as modules,
> > > > > since late loading of the driver for an IOMMU serving active DMA masters
> > > > > is going to end badly in many cases. On Android, we're using device links
> > > > > to ensure that the IOMMU probes first.
> > > >
> > > > Out of curiosity, which device links are those? Clearly not the RPM links
> > > > created by the IOMMU drivers themselves... Is this some special Android
> > > > magic, or is there actually a chance of replacing all the
> > > > of_iommu_configure() machinery with something more generic?
> > >
> > > I'll admit that I haven't used them personally yet, but I'm referring to
> > > this series from Saravana [CC'd]:
> > >
> > > https://lore.kernel.org/linux-acpi/20190904211126.47518-1-saravanak@google.com/
> > >
> > > which is currently sitting in linux-next now that we're upstreaming the
> > > "special Android magic" ;)
> 
> Neat, I'm trying to do the same for virtio-iommu. It needs to be modular
> because it depends on the virtio transport, which distributions usually
> build as a module. So far I've been managing the device links in
> virtio-iommu's add_device() and remove_device() callbacks [1]. Since it
> relies on the existing probe deferral, I had to make a special case for
> virtio-iommu to avoid giving up after initcalls_done [2].

As far as symbols exported from the IOMMU and PCI layers, did you find you
needed anything on top of the stuff I'm exporting in patches 1 and 3?

Cheers,

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
