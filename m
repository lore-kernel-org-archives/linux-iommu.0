Return-Path: <SRS0=cNfX=L6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B1AC07E9E
	for <iommu@archiver.kernel.org>; Tue,  6 Jul 2021 16:57:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 332E361C60
	for <iommu@archiver.kernel.org>; Tue,  6 Jul 2021 16:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 332E361C60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0540A4043E;
	Tue,  6 Jul 2021 16:57:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3-b5fgIC8GMX; Tue,  6 Jul 2021 16:57:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DDDB24013B;
	Tue,  6 Jul 2021 16:57:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0E53C001A;
	Tue,  6 Jul 2021 16:57:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3886FC000E
 for <iommu@lists.linux-foundation.org>; Tue,  6 Jul 2021 16:57:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 06A064059F
 for <iommu@lists.linux-foundation.org>; Tue,  6 Jul 2021 16:57:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rWp6umwg6x5b for <iommu@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 16:57:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 56CEE40592
 for <iommu@lists.linux-foundation.org>; Tue,  6 Jul 2021 16:57:33 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 027E761A0F;
 Tue,  6 Jul 2021 16:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625590652;
 bh=5up8/Bb0rLsCNavkU95AUJkD0QYWqQ8IKvDM0S2EuWE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BdlCeYWdA0LGQqw4NCthGEImHDcykOTXLbRY0p2OzfXTSjVjgAkalkpSZRdXk7myS
 ggdoMpep1HYdBLP4alpxbeLY2vbW4R6HTU/Vi4e5HLBlWUzcqfaGM7iFoc0a6mvwIQ
 OtryjDMBpvdg7dJuiMXwOl88SmpKdFQmz0rw3SopyQp4YNJrpHbSZzb5034J5yMjTF
 8iEUr6dVhZVSqKBvB0pDdDElb2vQPGkIFBQxZHqD6FxdW2DFwsOiJcnDaYmQKnMJGl
 2f5cYXW5YDte/kZj3tp146452h4FgBzYXIDAdb4rsa2LksEi8bwpu2LbdNX+D444o2
 b9VQWPtZ1e95g==
Date: Tue, 6 Jul 2021 17:57:21 +0100
From: Will Deacon <will@kernel.org>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v15 06/12] swiotlb: Use is_swiotlb_force_bounce for
 swiotlb data bouncing
Message-ID: <20210706165720.GC20750@willie-the-truck>
References: <ea28db1f-846e-4f0a-4f13-beb67e66bbca@kernel.org>
 <20210702135856.GB11132@willie-the-truck>
 <0f7bd903-e309-94a0-21d7-f0e8e9546018@arm.com>
 <YN/7xcxt/XGAKceZ@Ryzen-9-3900X.localdomain>
 <20210705190352.GA19461@willie-the-truck>
 <20210706044848.GA13640@lst.de>
 <20210706132422.GA20327@willie-the-truck>
 <a59f771f-3289-62f0-ca50-8f3675d9b166@arm.com>
 <20210706140513.GA26498@lst.de>
 <YORsr0h7u5l9DZwh@char.us.oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YORsr0h7u5l9DZwh@char.us.oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Jim Quinlan <james.quinlan@broadcom.com>, heikki.krogerus@linux.intel.com,
 linux-devicetree <devicetree@vger.kernel.org>, peterz@infradead.org,
 benh@kernel.crashing.org, joonas.lahtinen@linux.intel.com,
 dri-devel@lists.freedesktop.org, chris@chris-wilson.co.uk,
 grant.likely@arm.com, paulus@samba.org, Frank Rowand <frowand.list@gmail.com>,
 mingo@kernel.org, Jianxiong Gao <jxgao@google.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Saravana Kannan <saravanak@google.com>, mpe@ellerman.id.au,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, xypron.glpk@gmx.de,
 Christoph Hellwig <hch@lst.de>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, bskeggs@redhat.com,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Thierry Reding <treding@nvidia.com>, matthew.auld@intel.com,
 Nicolas Boichat <drinkcat@chromium.org>, thomas.hellstrom@linux.intel.com,
 jgross@suse.com, intel-gfx@lists.freedesktop.org,
 maarten.lankhorst@linux.intel.com, jani.nikula@linux.intel.com,
 Nathan Chancellor <nathan@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 rodrigo.vivi@intel.com, Bjorn Helgaas <bhelgaas@google.com>,
 Claire Chang <tientzu@chromium.org>, Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 boris.ostrovsky@oracle.com, airlied@linux.ie, linuxppc-dev@lists.ozlabs.org,
 Randy Dunlap <rdunlap@infradead.org>, Qian Cai <quic_qiancai@quicinc.com>,
 lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Daniel Vetter <daniel@ffwll.ch>, Greg KH <gregkh@linuxfoundation.org>,
 Tom Lendacky <thomas.lendacky@amd.com>, Robin Murphy <robin.murphy@arm.com>,
 bauerman@linux.ibm.com
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

On Tue, Jul 06, 2021 at 10:46:07AM -0400, Konrad Rzeszutek Wilk wrote:
> On Tue, Jul 06, 2021 at 04:05:13PM +0200, Christoph Hellwig wrote:
> > On Tue, Jul 06, 2021 at 03:01:04PM +0100, Robin Murphy wrote:
> > > FWIW I was pondering the question of whether to do something along those 
> > > lines or just scrap the default assignment entirely, so since I hadn't got 
> > > round to saying that I've gone ahead and hacked up the alternative 
> > > (similarly untested) for comparison :)
> > >
> > > TBH I'm still not sure which one I prefer...
> > 
> > Claire did implement something like your suggestion originally, but
> > I don't really like it as it doesn't scale for adding multiple global
> > pools, e.g. for the 64-bit addressable one for the various encrypted
> > secure guest schemes.
> 
> Couple of things:
>  - I am not pushing to Linus the Claire's patchset until we have a
>    resolution on this. I hope you all agree that is a sensible way
>    forward as much as I hate doing that.

Sure, it's a pity but we could clearly use a bit more time to get these
just right and we've run out of time for 5.14.

I think the main question I have is how would you like to see patches for
5.15? i.e. as patches on top of devel/for-linus-5.14 or something else?

Cheers,

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
