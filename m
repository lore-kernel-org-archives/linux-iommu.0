Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904241;
	b=FtHKb2H27nS65SoL3FI3T7XDvZWNknZrvdThMAdDtCDSICR404VJZMm+ewBV1mGBXGjq
	 As6xz+jJPQecR7zHOJ/vM+MJjE1/mtMHQq+rgmKm5SvJcr/V8L/cOWUgHyKv8ZYm7OEI8
	 oq4y3OyADdAu+NmEv8RD72gkm7y76FWzseU0drew4XOa38MM0NeyQTEItGrYuKzF2bsbl
	 k7Qb/F5UOvV3Zkd3nVd/FWf7Ybvsn/O9C5N73Ag8KBjFsWmrj4k6cm8G3T+8ysANKjNrL
	 nNGdMnWzqrbiGn98vci2ZHPMcRVAXUMqhdTbLJLFmbNHibKi9/V7CqQrTfntDxhqCrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904241;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=zheIQktVmbZG4c834zKCy7evdo7oC0W6fMu1Q7CHhCE=;
	b=0QqI4FPUPceOLtK/t4q4rDTsvxopiG0TFmIL973rIM5BjDo80M55agJVC8sRc7Z5fT8c
	 Dr9Zx3h73ScGvUg2XSWD3B6WaUlzuVQTnPDdAaJhMjbtmM4dY3EKuTqL+hADBDyQG+TJQ
	 ZBAUf8MSQo7xUuxmFE/3/rNrPWqqZyglRNW4LU+VAZbWVuhR5bhLoOT7SlQ/bkyUuRgXW
	 NFE9egroPz4wtRfIySPGn1lph9ohbKruOEmluBHlC0LhLjcNKNUHSFdDxrtyQYK0H4/Ld
	 FMMal3EM1tCgMLO5DcjzIdTHq/L3Uy0srl+0iFxq8jVH5E99OxHBv2hfx8kqFPOHMJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AqABhpm3;
	arc=none smtp.remote-ip=91.218.175.179
Received: from mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D3E606A8A1
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 08:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6D3E606A8A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AqABhpm3
X-Envelope-To: iommu@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=pyWTIi2y6JoIJ6IOmHBgjnTL/Q73eud7KJwC8hfFNgY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794904239; v=1; x=1795509039;
 b=AqABhpm3NiDW2u51rSlCew3nKj/O5rKF9XyNeS2Wd+I3pWwpWLJJx9V75Bs3D697t8fZDjpr
 DN5VoTfPu1d8qxDkgOwiKg0rDUkXd2Bwedu96VqZ0VXyo+CeeekOuk8G0w75Ebi/P41KTrtSZSf
 s200mf5lcIomdgDsM3MGzbhE=
X-Envelope-To: iommu@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 072b8882c51a40c5;
	Tue, 17 Nov 2026 08:30:29 +0000
X-Mizu-Trace-ID: 072b8882c51a40c5
X-Migadu-Flow: FLOW_OUT
Date: Tue, 17 Nov 2026 16:30:15 +0800
From: Peng Fan <peng.fan@linux.dev>
To: Jason Gunthorpe <jgg@ziepe.ca>
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
Message-ID: <avwQl18smAW4R6ec@fedora>
References: <20261112-edma-iommu-v3-v6-0-b038edb8ce6f@nxp.com>
 <20261116193021.GB2452510@ziepe.ca>
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
In-Reply-To: <20261116193021.GB2452510@ziepe.ca>

On Mon, Nov 16, 2026 at 03:30:21PM -0400, Jason Gunthorpe wrote:
>On Thu, Nov 12, 2026 at 03:53:03PM +0800, Peng Fan (OSS) wrote:
>> I used iommu-map for eDMA, but iommu experts rejected it:
>> "Using iommu-map to describe synthetic dma_chan_dev devices that the
>> kernel creates is the same kind of DT abuse from over here:"
>> More info: https://lore.kernel.org/all/20260917144804.GI3196566@ziepe.ca/
>> 
>> So I followed here [2] as Krzysztof wrote for QCOM VPU:
>> "Thanks Jason for context and detailed arguments. Robin did not chime in
>> yet, but from what I understood the DT-child-node approach will be the
>> way we should go here.
>> 
>> I accept above point of view and I am fine with this, thus Vishnu and
>> Vikash - please go ahead with DT-child-node solution we had some time ago."
>> [2] https://lore.kernel.org/linux-iommu/c7b956a9-d3e8-4e18-b780-5d08f5cd2ca1@kernel.org/
>> 
>> This series adds per-channel DT child node support to fsl-edma and, as a
>> prerequisite, introduces a proper bus for DMA channel devices.
>
>To be fair this is discouraged too, now that I've seen 3-4 people
>trying to do exactly the same thing I'm not as positive about the
>DT-child-node hack.

I may not describe it clear in cover-letter.

I understand the concern. Let me explain why I believe it is justified here
rather than a hack.

On i.MX eDMA each channel has its own interrupt, its own register region,
and on i.MX8QM even its own power domain. Each channel may also have its
own Stream ID, or share one when SIDs are scarce. These are genuine
per-channel hardware resources, not software fiction.

In dmaengine each channel is already modeled as a channel device (see
dmaengine_chan_dev()), and this series puts those devices on a real bus
(dmaengine_chan_bus_type) as a prerequisite. The DT child node simply
describes that existing device, so its reg/interrupts/power-domains/iommus
are attached per channel instead of as index-matched flat lists on the
controller.

Given that context, do you agree that a child node per channel is the
right description here?

Thanks,
Peng

>
>Can all of you come up with a proposal that doesn't involve hacking up
>DT just to unbundle the SIDs?
>
>Jason
>
