Return-Path: <SRS0=bViT=VU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C89C76190
	for <iommu@archiver.kernel.org>; Tue, 23 Jul 2019 15:38:33 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFDC322543
	for <iommu@archiver.kernel.org>; Tue, 23 Jul 2019 15:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iW3wa0oY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFDC322543
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B787AC9E;
	Tue, 23 Jul 2019 15:38:31 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CF717C77
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Jul 2019 15:38:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 852DF709
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Jul 2019 15:38:30 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 2FC15217D4;
	Tue, 23 Jul 2019 15:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563896310;
	bh=6BjcRpGUXnApNQz7lAjtezIG7TvYHSpnsTToA6ldcuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iW3wa0oYpaL//UuyWsMLm+i+ND0M4tiRPisfgZng7jScBCMId0zVJa49Mdc8nwHLu
	hpaqz0kgnbWK8ct6/KTj2+eF9ntu+s0xnTiUavTb6xKJKLg+QXKysth4nuK7evoo8o
	d2fcuUXNNxoXFbVMXP4iuPbe3D77Nir5iUNw/TAw=
Date: Tue, 23 Jul 2019 16:38:23 +0100
From: Will Deacon <will@kernel.org>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH v2] iommu: add support for drivers that manage iommu
	explicitly
Message-ID: <20190723153822.gm4ossn43nvqbyak@willie-the-truck>
References: <20190702202631.32148-2-robdclark@gmail.com>
	<20190710182844.25032-1-robdclark@gmail.com>
	<20190722142833.GB12009@8bytes.org>
	<CAF6AEGvJc2RK3GkpcXiVKsuTX81D3oahnu=qWJ9LFst1eT3tMg@mail.gmail.com>
	<20190722154803.GG12009@8bytes.org>
	<CAF6AEGvWf3ZOrbyyWjORuOVEPOcPr+JSEO78aYjhL-GVhDZnTg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF6AEGvWf3ZOrbyyWjORuOVEPOcPr+JSEO78aYjhL-GVhDZnTg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: Rob Clark <robdclark@chromium.org>, aarch64-laptops@lists.linaro.org,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
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

On Mon, Jul 22, 2019 at 09:23:48AM -0700, Rob Clark wrote:
> On Mon, Jul 22, 2019 at 8:48 AM Joerg Roedel <joro@8bytes.org> wrote:
> >
> > On Mon, Jul 22, 2019 at 08:41:34AM -0700, Rob Clark wrote:
> > > It is set by the driver:
> > >
> > > https://patchwork.freedesktop.org/patch/315291/
> > >
> > > (This doesn't really belong in devicetree, since it isn't a
> > > description of the hardware, so the driver is really the only place to
> > > set this.. which is fine because it is about a detail of how the
> > > driver works.)
> >
> > It is more a detail about how the firmware works. IIUC the problem is
> > that the firmware initializes the context mappings for the GPU and the
> > OS doesn't know anything about that and just overwrites them, causing
> > the firmware GPU driver to fail badly.
> >
> > So I think it is the task of the firmware to tell the OS not to touch
> > the devices mappings until the OS device driver takes over. On x86 there
> > is something similar with the RMRR/unity-map tables from the firmware.
> >
> 
> Bjorn had a patchset[1] to inherit the config from firmware/bootloader
> when arm-smmu is probed which handles that part of the problem.  My
> patch is intended to be used on top of his patchset.  This seems to me
> like the best solution, if we don't have control over the firmware.

Hmm, but the feedback from Robin on the thread you cite was that this should
be generalised to look more like RMRR, so there seems to be a clear message
here.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
