Return-Path: <SRS0=Eb89=SH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8A7C282CE
	for <iommu@archiver.kernel.org>; Fri,  5 Apr 2019 16:54:34 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF5FC20989
	for <iommu@archiver.kernel.org>; Fri,  5 Apr 2019 16:54:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF5FC20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rosenzweig.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8AA7925A7;
	Fri,  5 Apr 2019 16:54:33 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BBB5F2598
	for <iommu@lists.linux-foundation.org>;
	Fri,  5 Apr 2019 16:53:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from rosenzweig.io (rosenzweig.io [107.170.207.86])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 638D5FD
	for <iommu@lists.linux-foundation.org>;
	Fri,  5 Apr 2019 16:53:29 +0000 (UTC)
Received: by rosenzweig.io (Postfix, from userid 1000)
	id CE6015FE8D; Fri,  5 Apr 2019 09:53:28 -0700 (PDT)
Date: Fri, 5 Apr 2019 09:53:28 -0700
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 3/3] drm/panfrost: Add initial panfrost driver
Message-ID: <20190405165328.GA9532@rosenzweig.io>
References: <20190401074730.12241-1-robh@kernel.org>
	<20190401074730.12241-4-robh@kernel.org>
	<5efdc3cb-7367-65e1-d1bf-14051db5da10@arm.com>
	<20190405161632.GA9160@rosenzweig.io>
	<34a7038e-34f0-0cc4-4fc4-9b7dda356df6@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <34a7038e-34f0-0cc4-4fc4-9b7dda356df6@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>,
	Neil Armstrong <narmstrong@baylibre.com>,
	Maxime Ripard <maxime.ripard@bootlin.com>,
	Sean Paul <sean@poorly.run>, Will Deacon <will.deacon@arm.com>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	David Airlie <airlied@linux.ie>, iommu@lists.linux-foundation.org,
	"Marty E . Plummer" <hanetzer@startmail.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190405165328.-MGcS2EFG8TtK4pFqS0swbjAxBQrAHrNPuLGnkbjGng@z>

> Sorry - "Thread Local Storage" - e.g. registers spilled to memory from a
> shader program.

Gotcha, thank you. Register spilling isn't implemented yet, so I haven't
run into this. (Partially because the blob's RA is very good so it's
somewhat nontrivial to get it to spill... not that I've tried, the real
reason is that the RA I have implemented right now works and I don't
want to mess with it ;P)

> At the moment I don't have any permission to share details which aren't
> already public in the kbase driver. Hopefully that situation will
> change. I'm also very much not an expert on anything but the kernel
> driver (I tried to stay away from shader compilers and all that graphics
> knowledge...). The details of the job descriptors is only really
> publicly documented in terms of the "replay workaround" which is quite
> limited.

Alright, no worries! We'll see where the tide turns, indeed :)

> I think we all felt like that :) Still the Nexus 10 wasn't a bad tablet,
> and the Chromebook was an exciting first!

*looks around to 2 Kevins and 2 Veyrons sprawled about* At first,
indeeed.... ;)

> You should be able to express the dependencies using fences. At the time
> kbase was started there was no fence mechanism in the kernel. We
> invented horrible things like UMP[1] and KDS[2] for cross-driver sharing.

Ah-ha, I see; I didn't know if there was an explicit reason kbase didn't
use fencing, but if it didn't exist, that's reason enough.

> It all comes down to how small your job chains are - if you don't need
> to squeeze too many through the hardware you should be fine. But there's
> going to be some performance gain to be had implementing it.

For sure.

> [1] I forget what it actually stands for, but was an attempt to do
> something like dma_buf

Unified Memory Provider, iirc.

> If you don't implement the replay workaround I'm very happy :)

Pff.

> The main missing part for the Arm user space is feature registers. That
> and the lack of SAME_VA is horrible to emulate (keep allocating until it
> happens to land in a free area of user space memory).

Alright, both of those will probably be needed for us sooner or later,
so no harm in implementing those. Thank you!

> Arm user space also makes use of cached memory with explicit cache sync
> operations. It of course works fine with uncached and ignoring the sync,
> but again I'm not sure how much performance is being lost.

I would be interested as well, since even when I used kbase for stuff, I set
everything uncached/unsynced to keep myself sane, but that could be a
very real performance issue on some workloads.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
