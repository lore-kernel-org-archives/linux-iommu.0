Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.109
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795266178;
	b=zMsPac7vKdV/qovMMv9vEUn5iRY2adBAhqg40mdcr25/MyQ4gH2pv7Ef1y78TY6GJmss
	 ra7OyTBgfbruFfjDiSlK8rCy4SpRp/WEdei8t51UyE4v1N78QLnlpdwSMKG7JyQ7+DJ1M
	 /mAN0qYE7WX1Nspn57xxfP76m0e6EoOBHKJbiSub7BExEnaGbue33vUQqxkBDsAQ1q2ov
	 Fc3JoxPEo4G4KODFKYJRuh8tHky8aNeOUsNJ1YaMuzR8clzqdX7HqQ+MzbTdM+DgN48I0
	 dYVMehya0WEQnh4/iifLiGyrD+tnX13EjMqKKn7dBOtvfiQxmlCI6nY1B6ymdgY2fsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795266178;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=kosSlO4n4eaj/l8QctRPYZS0nYWx+0xDQzEvrB+dFGg=;
	b=A9663zNBTtDNtRsWBN8WfU/5k+5suEV0uZmyhAWmDnsGNUunGdKrhNSuffwD5NjwzYw7
	 qBju39hd4QvuP3wwbgcQUVH/2P/bLd+EkGt9DLh0AaXkxD1zquy2bV+PadoF5d7a9acuW
	 OC9zw7eFaPr45WL/3568Wb+sc8i0FR/pAbp30w5AlGE/S8/MThkb+7U6xFfUpaXR6+PPr
	 7EabAxDL7xy1efBjrxR2u2Md6FjAMHYVv7M4lHSP4VHfQ5tJuXovNYGORUXQIgRtbp++R
	 zg6RCnDfwTHc2lSovTExWU9UGU7DkCppwK8Ei8mUVrkB+Ta8Ks7vBw+eHPVLOntrNwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=evWxxf05;
	arc=none smtp.remote-ip=91.218.175.109
Received: from mta0.migadu.com (out-109.mta0.migadu.com [91.218.175.109])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD82606A332
	for <iommu@lists.linux.dev>; Sat, 21 Nov 2026 13:02:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BD82606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=evWxxf05
X-Envelope-To: iommu@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=AXPl9MSQKEVnxwBZxVz70iQ3WAgcrk7wcvSe7Ve0uwo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795266175; v=1; x=1795870975;
 b=evWxxf05XzVJt8Tiou/ooJaFuuGuIEy6pjt2YmbAgNiOxUhEf41eaNZKkg47SGXEuGOXmAyt
 3WwiAi8ByTAobCpv3Fp+93sxm2LZVZgMx5+WnZdbPDilExVU6ew6/6LAC8t6n1rEElzVU8kRIXn
 y9U/4883p+Brc6sMaiwDe+Bk=
X-Envelope-To: iommu@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 2fb3a475fbc6b1aa;
	Sat, 21 Nov 2026 13:02:54 +0000
X-Mizu-Trace-ID: 2fb3a475fbc6b1aa
X-Migadu-Flow: FLOW_OUT
Date: Sat, 21 Nov 2026 21:02:42 +0800
From: Peng Fan <peng.fan@linux.dev>
To: Jason Gunthorpe <jgg@ziepe.ca>, Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>, Robin Murphy <robin.murphy@arm.com>
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
Message-ID: <awGWcq_nKWShC81B@fedora>
References: <20261112-edma-iommu-v3-v6-0-b038edb8ce6f@nxp.com>
 <20261116193021.GB2452510@ziepe.ca>
 <avwQl18smAW4R6ec@fedora>
 <20261117130005.GC2606445@ziepe.ca>
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
In-Reply-To: <20261117130005.GC2606445@ziepe.ca>

Hi Jason, and all

On Tue, Nov 17, 2026 at 09:00:05AM -0400, Jason Gunthorpe wrote:
>> 

[...]

>> I may not describe it clear in cover-letter.
>> 
>> I understand the concern. Let me explain why I believe it is justified here
>> rather than a hack.
>> 
>> On i.MX eDMA each channel has its own interrupt, its own register region,
>> and on i.MX8QM even its own power domain. Each channel may also have its
>> own Stream ID, or share one when SIDs are scarce. These are genuine
>> per-channel hardware resources, not software fiction.
>> 
>> In dmaengine each channel is already modeled as a channel device (see
>> dmaengine_chan_dev()), and this series puts those devices on a real bus
>> (dmaengine_chan_bus_type) as a prerequisite. The DT child node simply
>> describes that existing device, so its reg/interrupts/power-domains/iommus
>> are attached per channel instead of as index-matched flat lists on the
>> controller.
>
>If they are real devices then why can't they come out as platform
>devices?
>
>I think you are overstating how independent they are. Many single
>devices have per "channel" resources like MMIO and IRQs. That's
>totally normal. It doesn't make the sub resources independent devices.
>
>AFAICT what you have here is some HW designer used SID where they
>should have used SSID and you are trying to hack DT to make that
>usable because Linux does not support a SID as SSID model today.
>
>Again, since this is the 3rd - 4th case like this, it seems like a
>popular hardware choice and we should try to do better to make Linux
>support if we can.

Let's put i.MX eDMA aside, I have one general question regarding
dma channel DMA.

The below two drivers[1] has chan_dma_dev set as true which means they use
dma channel device to do dma memory allocation. And for tegra186, it
use dma channel device for iommu, the buggy part is that it forces
chan dev's bus to platform bus.

Do you think it is reasonable to have chan device(not platform device) do dma
allocation? I ask because if we allow chan device to do dma allocation, we need
to provide a dma channel bus for iommu_buses to fix tegre186(TBH, I 
am not familar with this platform, it even has iommu-map for the dma node).

[1] drivers/dma/tegra186-gpc-dma.c
    drivers/dma/ti/k3-udma.c
    https://elixir.bootlin.com/linux/v7.4-rc1/A/ident/chan_dma_dev

Thanks
Peng

>
>Jason
