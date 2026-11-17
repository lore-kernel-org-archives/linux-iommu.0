Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794939421;
	b=oiXlMNjRGBCMX51vWximoVj4k1TBG9fXsVy8Q/I69p/Kk0JbJY635CjnBYbA8mP1sODa
	 a0B3nRLmahIGWi29Cjz8gRA7tsHOA+96Q7iUyAYreh5eaR+rHJhI5Kq2qRvXkE8Wwdpui
	 PJZqAIdK2RWjdKFud4JrQFt6HGI33EP17Dak4F9V7BDw0FG83yKQoKOTE4z6SdX7siB+9
	 4sReGz5Ojd5WYSqGcalLhScKMAWoq2GlLK653bLiVyGEhh79tVQehBMQgDww+Y97qzRNg
	 9/5InWaayr0NJKEabaVEoczg90KVJrNGh0vjfpmVQfgIZFDSUiUUEAUFbPj2B8AFjuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794939421;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=pepFJC4WupF41wk+cSidNw5vmFTw1POO1gRenleZ+aQ=;
	b=T5uVELMIy0NjvXBkX3y9adtmhQYXaJJYbKg5vwQuF9aihbxQ6YxPv2rKyhZDTJc8PcgA
	 dPWz7oS4K726H8lGAHNlMmc82nO/ypQV/KlRA11QUOTK+zdBtmfABX1YBMUgp9td2dX6F
	 eWLe6oA2/Zrwfm79rJfzG/6nitB6CyDJldHN6a1R+G0dVBsNoagI5QRlcB4By1yiJmn7/
	 GADspkd2zzvuCcSr3CjQDlOrt7K6O9+ze/9BhMR9I93VRRiCgp3Y66cP5BskFRALS1Rfh
	 cu3WOiE3qCP/gX8XZLbJgZjTH3i2mgMLnxflfTSMQVXX7WAeynehow7GvMeAzIFCAPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=IUFNsDeS;
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D71606A32C
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 18:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4D71606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=IUFNsDeS
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-53644b28706so1338861cf.3
        for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 10:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794939420; x=1795544220; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pepFJC4WupF41wk+cSidNw5vmFTw1POO1gRenleZ+aQ=;
        b=IUFNsDeSXqEXUtvv5J1fX+vK8nIjcBpw7etJ0QeiB5XKb88W76inRuv3k2Jko+IWBz
         SCvMe6AeV6KP/00dmG7biJ2o1WTLkD5jsiJnvG+1lNJjXcCmeddcSNT4pqHuYSvRMiC+
         NlNd3SiElxKVb3lukcRc0UQvAQLOY/sNneYWg37UM01ap5KmMJeYYApN4cSDpxDYZa4H
         93llk9TzQ/25jVxrktfENERHm7hFNlbjcTKrlE7iAeqEkY2ry5EsBWP6frf1tlz2zRa7
         Xtu7/ZPGa6QOMjGyCuj+a7XBs7F2+gTgstsBuWebfGaIiMGooWL1SXZVU+t1AY453bq9
         ndiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794939420; x=1795544220;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pepFJC4WupF41wk+cSidNw5vmFTw1POO1gRenleZ+aQ=;
        b=cjKjgvzjD8ecFT7QDAd6Ftf+0b/kOk5GOs/7LtXOdoV9keEDCHGnY2YLkyz3OjzwyW
         q4VX7Ic/HNOgQwyc8QYCs6yuJ/Qj3gMaHJNg3quLl/0i70t759xd9ktsy10nF9cCZQKQ
         4TKau39w2NjzEOhx0c2bHuB7MbPlBg+322/oXEXfl0aKP2wpwtR7gi81ssFmMxIrQ/rM
         tbpfd8qTRT6sn+NvVOmN5f98s0u/5c/p54tpgiTH+WXw6A6qJVD0SwaMavIPnParMfxy
         LVJhLWM2QtaZ1MUNmMWgJVjuX3FzzTGpgDiCbQM6TngUo3aHwCaPDDDkgEpt4MNtFk0n
         +E0g==
X-Forwarded-Encrypted: i=1; AL+hErGPm64Kff63Kbx67Ho0CNRf0Qt6cVJpusJxwQak1Ilm2KNAXlQ+1z7R7rPIntwKYXHLDsg9Vg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+neT/VF1h8TdAu2LMCon3yxIss/04cAzpN8XN1WtlqqsoLI9lQ
	+UEY/bB2Ba1eZ83DY8EbPuxxq8uNtgyLqUiY6yJwk6EBEWqmPLYLkS3FGZTmrRlPVNk=
X-Gm-Gg: AYBFou17MwvTJ54sAgSEF8eyFaRGLOaADvnVYdcbXIspsQy1nDgs8Gig6/Jw3qoOEJV
	JlJFcpZWoZYiiWshSIC5wy0yLVbTvt7Ogl2kzK0CiKK6C4seX40rCyvswyTF/rQ3a1496R7YJjK
	Q/xzJEGu0yWjDNIfpd5DjvGGZYwsohC5FoEDfknpfEYf2sJyz3yZuNfVONomcCTxMYeOEFALkD6
	vjtt9cL5qQNQQDJDs/nOEqk/yXGSVhsggImGPtsOqlrlWmIlIVgQPD4mDoDtwSDhUF/ApiTyksn
	Hty6Y+5W4ww9TIbI9SIwujvcngSI7ZAu4rNjBldIyp0ypG8acLeCMhKHwCdbpycZDvWxzc8SkOs
	IJvGQMivvWo9GqXRrny9L9xDm/t5Yq0MCzO47DtYj5C/T1kW4ZoUIJtWO5R42Sa1GKH4OjcGa8R
	lghgTA4NM4wxLwxJsuteM39adlaZqrCZqJYgj1tysnMADpQp8+mdkupQbAyz6INyRPwozNTHOlx
	sYJAmm8HTiZ0Dng9balJG1MX3dRPASZRIEFLB6KGa3He1qn+uFYFwBMGOkE+wrTcEZhrCjrosmG
	0UDUfg==
X-Received: by 2002:a05:622a:1b10:b0:55c:3b4b:45 with SMTP id d75a77b69052e-55d5a538613mr1980541cf.24.1794939419724;
        Tue, 17 Nov 2026 10:16:59 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d5907ee6dsm2590361cf.19.2026.11.17.10.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 10:16:58 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xTNjm-0000000D0qg-02mP;
	Tue, 17 Nov 2026 14:16:58 -0400
Date: Tue, 17 Nov 2026 14:16:57 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Peng Fan <peng.fan@linux.dev>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
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
Message-ID: <20261117181657.GF2606445@ziepe.ca>
References: <20261112-edma-iommu-v3-v6-0-b038edb8ce6f@nxp.com>
 <20261116193021.GB2452510@ziepe.ca>
 <avwQl18smAW4R6ec@fedora>
 <20261117130005.GC2606445@ziepe.ca>
 <avxs_TU6FHn7MMx8@fedora>
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
In-Reply-To: <avxs_TU6FHn7MMx8@fedora>

On Tue, Nov 17, 2026 at 11:04:29PM +0800, Peng Fan wrote:

> - Keep the DMA controller as one device and describe its channel Stream
>   IDs in the controller node (ordered list, no per-channel child nodes and
>   no requester-ID map).
> - Add a generic dmaengine/IOMMU mechanism that assigns one of those
>   Stream IDs to each dma_chan_dev, so the channel gets its own IOMMU
>   context/domain without inventing a DT device.

IMHO what you really need here is some way to get the DMA API for a
"PASID" combined with some way to convert SIDs in an iommus property
into a "PASID".

How exactly that looks, I'm, not sure, but you probably do need a
struct device to do DMA with as that is integral to how the DMA API
works.

If that is a real struct device or some proxy, I don't know. Long ago
there was some work on this topic and struct device per PASID seemed
to be the direction people were interested in.

> - Use the SMMUv3 shared-SID support (still under reviewing) for channels that
>   must share a SID.

If you get struct device handles for the SID then you don't need this
at all since you'd have exactly N handles with no overlap.

You don't need to force the struct devices you want to use in the DMA
channel's model to be exactly used as the DMA device..
 
> This keeps DT describing real hardware (the controller's SIDs) and moves
> the Linux-specific unbundling into the core instead of a per-driver
> binding. Each channel occupies 64KB MMIO region and works independently.
> With separate DT node, it will be easy for us to do channel device passthrough
> when using Xen hypervisor. Now moving away from this, the remaining question is
> how to expose a channel for Xen/per-channel passthrough without a per-channel
> DT node, seems I need to add some code in Xen hypervisor to support channel
> passthrough.

Normally you'd make a VFIO driver for this, especially if you have a
"PASID". You really care about Xen? It is so weird in this area?

> >Again, since this is the 3rd - 4th case like this, it seems like a
> >popular hardware choice and we should try to do better to make Linux
> >support if we can.
> 
> Yeah, I saw QCOM VPU case and thought child node usage was agreed from
> Krzysztof's reply. So I use same idea here.

It was but at that point it was the only one. Now there are two QCOM
ones, this and maybe another I forget.

Also, IIRC, it wasn't quite like this, the DT was supposed to create
real platform devices. This kernel creates struct devices and attaches
them to DT was the first idea that was pushed back on when it became
too complicated.

Jason
