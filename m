Return-Path: <SRS0=RnLw=MA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEE6C11F67
	for <iommu@archiver.kernel.org>; Thu,  8 Jul 2021 16:44:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B0F961874
	for <iommu@archiver.kernel.org>; Thu,  8 Jul 2021 16:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B0F961874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B87C83C48;
	Thu,  8 Jul 2021 16:44:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HYJx4rlcJfoa; Thu,  8 Jul 2021 16:44:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 037A183C51;
	Thu,  8 Jul 2021 16:44:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DFD47C001A;
	Thu,  8 Jul 2021 16:44:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4BDFCC000E
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 16:44:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2AAAC60C10
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 16:44:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MoeZvtbztSsf for <iommu@lists.linux-foundation.org>;
 Thu,  8 Jul 2021 16:44:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 867F660BFA
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 16:44:31 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 88F256145A;
 Thu,  8 Jul 2021 16:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625762671;
 bh=W3zJ1dUIVfwK2RD5Gb/pjjaY8IvTpKuqVuwPdbuz25M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Sp+30VCoqVzKdRCHxsdjheJ32Al4GyKkdqY67UI3HBglP9/4ElBHuP/C2H/FyWKo7
 e/R4/9B3d7vhaPNlh1DPVXpIf7uT6p/REBIACdKpJwJF9GZS42ymRBAxS0kVUi63dX
 LFzIygW0HZtu2Ulg0IazOQ0jJMqOOsCWNLsNFVLNWlAdaw+e6puTS7FlMwyfD5gEdI
 lFB3Rrin6g2B0nXBBJNO+PUuvd4DpkVlBGoDw/jR5Tje1HakbrKaEjYhMjAxMq0G0/
 9JUb/J7ll5Lxx3f7sEDifcv8wjoDYV7KpD0n+YA4MYDlWDIvbopDufBoyo/NtyqWxC
 FAtOTP/W4ikEQ==
Date: Thu, 8 Jul 2021 17:44:19 +0100
From: Will Deacon <will@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v15 06/12] swiotlb: Use is_swiotlb_force_bounce for
 swiotlb data bouncing
Message-ID: <20210708164418.GB23598@willie-the-truck>
References: <0f7bd903-e309-94a0-21d7-f0e8e9546018@arm.com>
 <YN/7xcxt/XGAKceZ@Ryzen-9-3900X.localdomain>
 <20210705190352.GA19461@willie-the-truck>
 <20210706044848.GA13640@lst.de>
 <20210706132422.GA20327@willie-the-truck>
 <a59f771f-3289-62f0-ca50-8f3675d9b166@arm.com>
 <20210706140513.GA26498@lst.de>
 <bb32d5a6-2b34-4524-e171-3e9f5f4d3a94@arm.com>
 <20210706170657.GD20750@willie-the-truck>
 <e1c026c6-22c7-8979-4941-de9cfab3863a@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e1c026c6-22c7-8979-4941-de9cfab3863a@kernel.org>
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
 jgross@suse.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 intel-gfx@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
 jani.nikula@linux.intel.com, Rob Herring <robh+dt@kernel.org>,
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

On Tue, Jul 06, 2021 at 12:14:16PM -0700, Nathan Chancellor wrote:
> On 7/6/2021 10:06 AM, Will Deacon wrote:
> > On Tue, Jul 06, 2021 at 04:39:11PM +0100, Robin Murphy wrote:
> > > On 2021-07-06 15:05, Christoph Hellwig wrote:
> > > > On Tue, Jul 06, 2021 at 03:01:04PM +0100, Robin Murphy wrote:
> > > > > FWIW I was pondering the question of whether to do something along those
> > > > > lines or just scrap the default assignment entirely, so since I hadn't got
> > > > > round to saying that I've gone ahead and hacked up the alternative
> > > > > (similarly untested) for comparison :)
> > > > > 
> > > > > TBH I'm still not sure which one I prefer...
> > > > 
> > > > Claire did implement something like your suggestion originally, but
> > > > I don't really like it as it doesn't scale for adding multiple global
> > > > pools, e.g. for the 64-bit addressable one for the various encrypted
> > > > secure guest schemes.
> > > 
> > > Ah yes, that had slipped my mind, and it's a fair point indeed. Since we're
> > > not concerned with a minimal fix for backports anyway I'm more than happy to
> > > focus on Will's approach. Another thing is that that looks to take us a
> > > quiet step closer to the possibility of dynamically resizing a SWIOTLB pool,
> > > which is something that some of the hypervisor protection schemes looking to
> > > build on top of this series may want to explore at some point.
> > 
> > Ok, I'll split that nasty diff I posted up into a reviewable series and we
> > can take it from there.
> 
> For what it's worth, I attempted to boot Will's diff on top of Konrad's
> devel/for-linus-5.14 and it did not work; in fact, I got no output on my
> monitor period, even with earlyprintk=, and I do not think this machine has
> a serial console.

Looking back at the diff, I completely messed up swiotlb_exit() by mixing up
physical and virtual addresses.

> Robin's fix does work, it survived ten reboots with no issues getting to X
> and I do not see the KASAN and slub debug messages anymore but I understand
> that this is not the preferred solution it seems (although Konrad did want
> to know if it works).
> 
> I am happy to test any further patches or follow ups as needed, just keep me
> on CC.

Cheers. Since this isn't 5.14 material any more, I'll CC you on a series
next week.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
