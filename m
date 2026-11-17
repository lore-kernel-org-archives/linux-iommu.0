Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794938989;
	b=SsExE8nSpVw+zRSDFFMnsjMga8K7aExW/hs+0Reiq9SNS3gEAUbwTRR3NYSq38Uurqe7
	 tvfK8ZGlPVVYIKk9EtSvb7w9tDUyakepHMUi8OZc57LHiLDrW3cCaXMxzu1I541NLf+2c
	 /mJfavKT57b2GhjD1mPSUHPblQUuxfWZyVHbhcx/iJHbeFVmgEgkj+u3Y9yrvRYgTINm9
	 ZSxRnqqHkuXFg0WJg+zLIN9nEZxzGM5qoy8DOBWsqYez4emU9JnXEDkP8jhvAhjpTxzwS
	 mqPK033aFvx/LkGaSVhm24cLX0mTxLS4nXauO4Rx0RnoBaj09TvcUQbc5CmEd4OfSUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794938989;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=TMrVATcUEwdpvgw6MI+dpJDmx6eLc4X7DAI9r1FJRWU=;
	b=cw4ZFPsSLB4sFhJdEz3w0ZYI5zfdCyA70KHOCo027LCfQARQg5DiCGDNUtwQc1CLwb7W
	 LUEP4Z4qzUBO1xOKDIY0P8fCHs3RotpuMGGjOKs2v3W47V2GfH47iWWrMBjjl84DeDbAr
	 BOKTKJwEs1EUaLTlvRTdhtTTTTnrimE1ybhIW3yx5UVbmj1zo+RHtUFWqMt7KxOwG+e3e
	 U74/XFzF9dz1EwcD+03TickKQ+suH6zw/IZhSVtDz27HI56xzvsMrUTYfFY8NH/eRHEu7
	 oKbWLNW/iu5IJgqccyJVlrTBeBZV3eg0/uSvNJfPmHajPKrU1bySSLPtZP9n57nEAfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=HHzLZ4w6;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D520606A32C
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 18:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D520606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=HHzLZ4w6
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93f22a8515eso13926785a.2
        for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 10:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794938987; x=1795543787; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TMrVATcUEwdpvgw6MI+dpJDmx6eLc4X7DAI9r1FJRWU=;
        b=HHzLZ4w6FXjJNCehE2NBZHH7RYbz9QRGvZwMu+NuGFpKP/08nWB6dYnpdXBwsngtab
         9cRMEU3DwwlGtXfrAvsm6552eBpSOpZzSYPvG6NwsmzQICBXGVarvZLyHGtMhX0l/Cfp
         Rt8H3FUJVI+ifN27kaEYMVmBJNR+UKWAdkwMiasQm00R3Z/xp+Q7TqgvaD/zudfnkywb
         9gJdZy5HwLCk7hgC/cjU3z1EvM1q4gYWe1hCf0OoKwZQQvpOXpLrrfJvVmgfhwy7Pi8R
         l/cFhCDDB1JYNYUaXHW+W75vrgYW+nFiVMxUo4a6s1jMW+iPfuIJ0U1R3buAac3Ew+g1
         mJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794938987; x=1795543787;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TMrVATcUEwdpvgw6MI+dpJDmx6eLc4X7DAI9r1FJRWU=;
        b=GK2aGzQ3CTgmR+XcUFCmdHWLZY7WW3oKKJ2ElqdWNTMZ9uoSd19IurCgpnGjztCTMV
         zsGiKhb9xLpkZNfDI6FmwyMOOPZXHcDVRvrKIvMXtBw3DsoiFpiNL91qsIjBKNJgnZE2
         zjRFO30ErMcxtLLg5exiBvLMdOeEtG7v3Y9SfTdQJoRrWZ+deVPfOc/Dn7lChtGcPvwi
         MekdtLSd8kGZ/vmMZlH2gq/APdz5fLljJcg2ROEOGrGywwQlcTqAQ1N+HLCMkduK2bhX
         KMzE8XgjhIlYubrgFELSoCm8Xrg3chdUmrVoTZOmGxDAbagznafiLxDQ5yaDGSqgrp0b
         jx7Q==
X-Forwarded-Encrypted: i=1; AL+hErHUreVc7UXupF+LeVe9rdXPWHb/5nD31anBGiIOSiXmJMyLA4j3nu5ymDvkUHP6rrOLgY+l4A==@lists.linux.dev
X-Gm-Message-State: APuU4Z/5G3ciA+TOXlNbc5w5iX7m0/T3KJJIlL+Bd+saKz9GKNAB2CeK
	iNoWqVDYx+DjjjVDu01zmedJB7gGz2kapoRvBfY4BySnK4/meBs+UCAsCZpul/irSS4=
X-Gm-Gg: AYBFou0jeUo9uNuTTzhdNCdQKS4vgQvAcn+HYA5eEfhv+HsDPG6by1MXyf0/K6cDMKg
	W5e9eq63AWvYGsu4M5ELjCkUvhN4HMPzI7yziTsa9ysfaSuwweB4hq4T5dj9DpRyqJiLKUNSL/l
	IEQnKaqnT15Fu+33iqiT1E7seKxQYnnnUM1Z8ZAZsZjP0N4JDcVq0pNoD0jYF1Y1fKbmIwiipT0
	tT6Peg/FMLLuSkH+lTAqRVMA/fKQedLIW1j1fG5VjSf7IRDU7xl5TR2wn0doEWSe8wqG41XeumJ
	LgCpYkloYwb2f56oq8kQObWoMoMOlJ4Vw9N2HF5fQM8yDWRkRfRWFUrWRpHyZAQa37dQj7Aw9Y6
	uqn4t+MrupFo1WzDOLg179HPRzJL7pO43BwpdTXKQyOexEiSX8wR9/VXmsHXwgZtaW1o0+KmN8+
	QFfLZk6NUh8XUdKTa6lSf4AH+Tvz0BgNuoCQvnvX4Zessph8fFP22bUt5rEjnvHyX2Cg4m0r0dz
	wSlbld+6M4nstQ5+O25a4WRGxogThGeCQEUxwxHIt1Qd0tVfRMMCmhxkMvyLked6IZKK5K+Sg+L
	mgaSkjQ=
X-Received: by 2002:a05:620a:46a0:b0:949:6ec7:68e2 with SMTP id af79cd13be357-94999650610mr89698785a.79.1794938987121;
        Tue, 17 Nov 2026 10:09:47 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c8b5c1dsm1155175385a.33.2026.11.17.10.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 10:09:46 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xTNcn-0000000D06D-1Abm;
	Tue, 17 Nov 2026 14:09:45 -0400
Date: Tue, 17 Nov 2026 14:09:45 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Peng Fan <peng.fan@linux.dev>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@kernel.org>,
	Larisa IIeana Grigore <larisa.grigore@nxp.com>, imx@lists.linux.dev,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-tegra@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v6 0/9] dmaengine: add DMA channel bus and fsl-edma
 per-channel IOMMU support
Message-ID: <20261117180945.GE2606445@ziepe.ca>
References: <20261112-edma-iommu-v3-v6-0-b038edb8ce6f@nxp.com>
 <20261116193021.GB2452510@ziepe.ca>
 <avwQl18smAW4R6ec@fedora>
 <20261117130005.GC2606445@ziepe.ca>
 <avyGI6QmuZ3DUqc9@SMW015318>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avyGI6QmuZ3DUqc9@SMW015318>

On Tue, Nov 17, 2026 at 10:51:47AM -0600, Frank Li wrote:
> > > In dmaengine each channel is already modeled as a channel device (see
> > > dmaengine_chan_dev()), and this series puts those devices on a real bus
> > > (dmaengine_chan_bus_type) as a prerequisite. The DT child node simply
> > > describes that existing device, so its reg/interrupts/power-domains/iommus
> > > are attached per channel instead of as index-matched flat lists on the
> > > controller.
> >
> > If they are real devices then why can't they come out as platform
> > devices?
> 
> It cause complex when consumer to bindle channel dynmatically.
> 
> for example:
> 
> consumer_A
> {
> 	dmas = <&dma_provider ID>;
> }
> 
> if each channel is platform devices,
> 
> consumer_A
> {
>         dmas = <&dma_provider_chan0 ID>;
> }
> 
> Consumer_A will have to bindle to chan0. Actually, dma engine support bind
> to any free channel. It will be problem when there are not enough channels
> for all peripheral.

That seems like something you should be able to fix in a better way,
like by having the DT know which DMA devices are usable by a consumer
so it can be pooled.

> > I think you are overstating how independent they are. Many single
> > devices have per "channel" resources like MMIO and IRQs. That's
> > totally normal. It doesn't make the sub resources independent devices.
> >
> > AFAICT what you have here is some HW designer used SID where they
> > should have used SSID and you are trying to hack DT to make that
> > usable because Linux does not support a SID as SSID model today.
> >
> > Again, since this is the 3rd - 4th case like this, it seems like a
> > popular hardware choice and we should try to do better to make Linux
> > support if we can.
> 
> What's your prefer?

If a PCI device implemented something like this it would use PASID.

I have one device with many DMA streams is what PASID is for.

Recasting your multi-SID as PASID somehow seems like an interesting direction.

Jason
