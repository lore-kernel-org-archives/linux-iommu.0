Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8A954673;
	Fri, 31 May 2024 10:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717151090; cv=none; b=lYK8iHaAjasA40DJWbmycJvoFCQG+Hu+OqxB0ZYu1ZnV29U5qSawYeol7w15ntueTYrTINTzUU0s6D6XjRdfcc5xU1q2+6e6VCtPDpJdnyEkxYsTNTpP+SP9treFMDU9ZOC1K7cIm8yPOG7NeZvaKZb6sxGkObHI05d5WotEvAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717151090; c=relaxed/simple;
	bh=3iFjX4wt0DJ4oC3/Izl/t6MXl/D5UVlqWwCet2BhxPo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aTRMKQeB/6ni3Rljxzi42kK1eOlXyJj5koYP4R1MbFdFzivSUidehX9BeSp+P/6jzqgcmlQvQhzXIML+8/+cbnTdyZv2sYIUoziDCGkkEY3yVqIMEmVHan1l3beJN30D4MgVoWPdHGWhrRCJSpTyyEutOU95TwKJZp192Ravy2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DFA61424;
	Fri, 31 May 2024 03:25:12 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBC8C3F641;
	Fri, 31 May 2024 03:24:45 -0700 (PDT)
Date: Fri, 31 May 2024 11:24:43 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Chen-Yu
 Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel
 Holland <samuel@sholland.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, Chris
 Morgan <macromorgan@hotmail.com>, Ryan Walklin <ryan@testtoast.com>,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/5] arm64: dts: allwinner: h616: add IOMMU node
Message-ID: <20240531112443.319863a3@donnerap.manchester.arm.com>
In-Reply-To: <adb96c77-fc8b-4be1-b2f7-0a321b7ad593@arm.com>
References: <20240530233800.27705-1-andre.przywara@arm.com>
	<20240530233800.27705-6-andre.przywara@arm.com>
	<bc550e12-7ad6-4592-994d-dca5a95e88ca@arm.com>
	<20240531103209.7db573c8@donnerap.manchester.arm.com>
	<adb96c77-fc8b-4be1-b2f7-0a321b7ad593@arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 May 2024 10:45:41 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> On 2024-05-31 10:32 am, Andre Przywara wrote:
> > On Fri, 31 May 2024 09:42:36 +0100
> > Robin Murphy <robin.murphy@arm.com> wrote:
> > 
> > Hi Robin,
> >   
> >> On 2024-05-31 12:38 am, Andre Przywara wrote:  
> >>> The Allwinner H616 contains a scatter-gather IOMMU connected to some
> >>> video related devices. It's almost compatible to the one used in the H6,
> >>> though with minor incompatibilities.
> >>>
> >>> Add the DT node describing its resources, so that devices like the video
> >>> or display engine can connect to it.  
> >>
> >> Without also describing those connections, though, having this node
> >> enabled in the DT means the driver will just bind, block DMA, and
> >> prevent those devices from working. That's probably not what you want.  
> > 
> > The IOMMU manages the Display Engine (DE), the Deinterlacer (DI), the
> > video engine (VE) and the 2D acceleration engine (G2D).
> > None of those devices are supported for the H616 in mainline yet, but there
> > are patches out there for the DE and VE, at least. Especially the video
> > codecs benefit from scatter-gather, so with this patch they can make use
> > of it from day one.  
> 
> Oh, I see - I assumed that stuff like display was more exciting and

Yeah, it arguably is, and Jernej had early patches already two years ago,
I think. However there are some changes in the IP that require some rework
in the DE driver for proper support, IIUC, so the upstreaming is somewhat
on hold.
Of course this didn't prevent Armbian from taking those early patches
anyway, so a lot of people are not even aware of the problem :-(

Cheers,
Andre

> likely to be supported already, so read "can connect to it" in the 
> present tense. If it's a future "can use it as soon as they are also 
> supported", then there's no concern, and indeed this is arguably the 
> ideal order of doing things.
> 
> Cheers,
> Robin.

