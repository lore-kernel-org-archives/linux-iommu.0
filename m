Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5342768EA;
	Fri, 31 May 2024 09:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717147937; cv=none; b=VLy42g8ACqPr9ILXndg3iGIJmMJ+JEeDsTmUqILy5dIYfv2k+Wt6JKOGqj3TDV3qIlOhDOSUcmFye44YJ4t/EyT56DPu62bayBkg7RxEWh48J73FeiNFoP6XTK5f7C3/ctDsR+pqVZgdRtMZT7NWIzyhBJz1s653puFLN4mAdpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717147937; c=relaxed/simple;
	bh=BNlEZVWKmmSynJ3s+ToRZwZGUYwR1GZgOKkG1m+2oIE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RfgyHttVZrZbEN7H6LCzltGSEddPWk8FC+nBq/Ntk4nKRc4zFVqodv7v/+y/PbTiC6+iUo/RrTvt5vL2lU1uzntKSzTM6O12/5cnhc2KU358x3g4lp8JAireBaMZ/B42DnAIrkpz8fPHcQNCvMmbThYz10a4pPhFLP3h8xaBRVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CEAC1424;
	Fri, 31 May 2024 02:32:39 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2CBF3F641;
	Fri, 31 May 2024 02:32:12 -0700 (PDT)
Date: Fri, 31 May 2024 10:32:09 +0100
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
Message-ID: <20240531103209.7db573c8@donnerap.manchester.arm.com>
In-Reply-To: <bc550e12-7ad6-4592-994d-dca5a95e88ca@arm.com>
References: <20240530233800.27705-1-andre.przywara@arm.com>
	<20240530233800.27705-6-andre.przywara@arm.com>
	<bc550e12-7ad6-4592-994d-dca5a95e88ca@arm.com>
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

On Fri, 31 May 2024 09:42:36 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

Hi Robin,

> On 2024-05-31 12:38 am, Andre Przywara wrote:
> > The Allwinner H616 contains a scatter-gather IOMMU connected to some
> > video related devices. It's almost compatible to the one used in the H6,
> > though with minor incompatibilities.
> > 
> > Add the DT node describing its resources, so that devices like the video
> > or display engine can connect to it.  
> 
> Without also describing those connections, though, having this node 
> enabled in the DT means the driver will just bind, block DMA, and 
> prevent those devices from working. That's probably not what you want.

The IOMMU manages the Display Engine (DE), the Deinterlacer (DI), the
video engine (VE) and the 2D acceleration engine (G2D).
None of those devices are supported for the H616 in mainline yet, but there
are patches out there for the DE and VE, at least. Especially the video
codecs benefit from scatter-gather, so with this patch they can make use
of it from day one.

I agree that the series on its own is not very useful, but there are quite
some H616 patches in flight out there, so this is an attempt to clean those
up, picking the low hanging fruits first ;-)

Cheers,
Andre

> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >   arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> > index 9c1980e24cb21..44f04619a43ac 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> > @@ -320,6 +320,15 @@ x32clk_fanout_pin: x32clk-fanout-pin {
> >   			};
> >   		};
> >   
> > +		iommu: iommu@30f0000 {
> > +			compatible = "allwinner,sun50i-h616-iommu";
> > +			reg = <0x030f0000 0x10000>;
> > +			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&ccu CLK_BUS_IOMMU>;
> > +			resets = <&ccu RST_BUS_IOMMU>;
> > +			#iommu-cells = <1>;
> > +		};
> > +
> >   		gic: interrupt-controller@3021000 {
> >   			compatible = "arm,gic-400";
> >   			reg = <0x03021000 0x1000>,  
> 

