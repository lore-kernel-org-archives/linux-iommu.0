Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1879C3DCDA3
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 12:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784290883; cv=none; b=gecZGaLIrUP5QC+C1NL416+JTwYsHFCDLodcBhEBi6T/LmypofAnU1dQ7FD8ZAZR5sX2r+6tlEAc/kZG8hVyE/EEyid6gMvZ5+6nUG+xHjI0OisscJYVK59uxKQPwIGwHwYG0truuemZRDt0DMsYliHJ89/PmCMncXldWzxhq90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784290883; c=relaxed/simple;
	bh=12JKqVcIZ52E2RLSxqShm8ptLKwpwxt2fZwzEHcI1Sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qAQQZU1ssbhT5u1df2YpKeFuI8cnldpWRxL1RgRbDBzDk+X611Wf26qVquNybPZQtcK6hvXOa0697Sg6Z2gjog6Im8v4fOswoSmhPX+i3yM91UIHV2kvJlcomIhxJyGHKZWlg1GlsCVWHNWDY3WKyQIcY63FrNiBBwrK3kGwSjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=s02f0Fj0; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="s02f0Fj0"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB7571476;
	Fri, 17 Jul 2026 05:21:15 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CD653F7B4;
	Fri, 17 Jul 2026 05:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784290879; bh=12JKqVcIZ52E2RLSxqShm8ptLKwpwxt2fZwzEHcI1Sk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s02f0Fj0gEDxPOKdbFt0hj9bVWROJ4+nqGTlH7fJYt6Am1SLtfGBpHaK+s+YcsjUn
	 68WVavT9WpIVJBPQE0hhc2YB33mvKz08BXVzgDu8MTXC2UIcZC8JhxaZ+DHPjxMB0z
	 LxTIM8ClFctMv13i6Txtm3vaqEYPcdva7jAS8I74=
Message-ID: <f61a0a67-2cb5-4fac-818e-70eb9ed69f95@arm.com>
Date: Fri, 17 Jul 2026 13:21:14 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-iommu: Introduce API to reserve IOVA regions for
 dynamically created devices
To: Konrad Dybcio <konradybcio@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>, joro@8bytes.org,
 will@kernel.org, m.szyprowski@samsung.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, dikshita.agarwal@oss.qualcomm.com,
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Robin Clark <robclark@qti.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>
References: <20260119054936.3350128-1-busanna.reddy@oss.qualcomm.com>
 <cfd23f75-8952-4463-abd5-815b995031b0@arm.com>
 <bb59f07e-ca7e-f012-6a4b-0a148350b69c@oss.qualcomm.com>
 <20260612172649.GM1066031@ziepe.ca>
 <da77c21d-25b3-46c3-a48f-71f0549e9f5f@oss.qualcomm.com>
 <20260615125257.GS1066031@ziepe.ca>
 <dcc0d02e-91fb-ddbe-399a-0191bab94c4f@oss.qualcomm.com>
 <20260617194038.GC231643@ziepe.ca>
 <e9e76c9f-b3b1-4ffd-9547-183556f6bb60@kernel.org>
 <20260618151745.GD231643@ziepe.ca>
 <dba037fa-0f21-4a50-8727-076a3b177c47@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <dba037fa-0f21-4a50-8727-076a3b177c47@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/07/2026 11:44 am, Konrad Dybcio wrote:
> On 6/18/26 5:17 PM, Jason Gunthorpe wrote:
>> On Thu, Jun 18, 2026 at 01:57:40PM +0200, Krzysztof Kozlowski wrote:
> 
> [...]
> 
>> So, if we are going to do a hack in DT to accomodate Linux, I argue to
>> choose explicit child devices so VPU does not need to create a special
>> bus, call of_dma_configue, or hack in new DMA API things that only it
>> will ever use.
> 
> Bit late to the party, but I'll chime in with some more "amazing news"..
> 
> All of the multimedia HW on QC platforms (camera, display, GPU, video
> and their specialized variations) has at least part of the same problems:
> 
> * Multiple SID groups that need to be accommodated for different purposes
>    (normal vs secure buffers provided by the same device, different
>    "logical functions" generally speaking) apply to all of them
> 
> * Different IOVA limitations per SID group seems to also concern at
>   least the camera uC ("ICP") (but not all of camera hw)
> 
> * Remoteprocs (and therefore also the audio stack) expose a number of
>    subfunctions, some of which we currently model as subnodes (although
>    many arguably only exist as such because someone decided it was
>    convenient to express them this way). This, for example led to the
>    representation of each SID group associated with the remoteproc
>    (fastrpc/"run compute on rproc") as a separate node:
> 
> -- qcom/hamoa.dtsi
> remoteproc_adsp: remoteproc@6800000 {
> 	[...]
> 
> 	// no iommus OR iommus used for another purpose (fw loading)
> 
> 	fastrpc {
> 		// no iommus
> 
> 		compute-cb@3 {
> 			compatible = "qcom,fastrpc-compute-cb";
> 			reg = <3>;
> 			iommus = <&apps_smmu 0x1003 0x80>,
> 				 <&apps_smmu 0x1063 0x0>;
> 			dma-coherent;
> 		};
> 
> 		compute-cb@4 {
> 			compatible = "qcom,fastrpc-compute-cb";
> 			reg = <4>;
> 			iommus = <&apps_smmu 0x1004 0x80>,
> 				 <&apps_smmu 0x1064 0x0>;
> 			dma-coherent;
> 		};
> 
> 		[...] (there's a lot of them)
> 	};
> };
> 
> There may be more hiding in plain sight, but those are the ones I'm
> aware of.
> 
> 
> I was kinda hoping there would be more buy-in to follow what PCIe
> does, but to my understanding you're opposed to it because "vpu_bus"
> is not dynamically discoverable. PCIe generally obviously is, but
> we already have prior art regarding hardwired/onboard devices - many
> qcom DTs carry per-board iommu-map overrides to please the allocator
> with known-in-advance BDF values (because the HW has only so many
> SIDs):

It's not really about dynamic discoverability, it's more the fact that 
PCI requester IDs are a real and well-defined thing.

> -- qcom/qcs6490-rb3gen2-industrial-mezzanine.dtso
> iommu-map = <0x0 &apps_smmu 0x1c00 0x1>,
>              <0x100 &apps_smmu 0x1c01 0x1>,
>              <0x208 &apps_smmu 0x1c04 0x1>,
>              <0x210 &apps_smmu 0x1c05 0x1>,
>              <0x218 &apps_smmu 0x1c06 0x1>,
>              <0x300 &apps_smmu 0x1c07 0x1>,
>              <0x400 &apps_smmu 0x1c08 0x1>,
>              <0x500 &apps_smmu 0x1c09 0x1>,
>              <0x501 &apps_smmu 0x1c10 0x1>;
> 
> Although it seems to me that it's more of a hack than anything else..

No, that is describing a genuine mapping of physical PCIe requester ID 
values to physical SMMU StreamID values which exists in the system, and 
which any OS needs to understand in order to be able to configure the 
SMMU correctly at all. Sure, that mapping probably is programmed in a 
lookup table in the root complex by the bootloader in a board-specific 
manner (like I know the NXP Layerscape platforms do, for instance) but 
it's still a real description of the system configuration, and it's 
perfectly fine if StreamIDs and/or LUT entries are limited to only 
configure BDFs known to be present at boot (if there's no SR-IOV or 
hotplug to worry about), since it's a reasonable expectation that an OS 
won't go arbitrarily renumbering buses just for fun.

It's another thing entirely to have a bunch of distinct logical devices 
whose only physical identifier is already an SMMU StreamID, then invent 
a fake mapping of made-up numbers to StreamIDs in order to pretend they 
can use common infrastructure, except still needing invasive hacks at 
almost every level of said common infrastructure in order to even try to 
make it actually work.

How anyone can read, let alone write "This creates a limitation when 
child requires a different iommu-address range than its parent, as 
device tree cannot express the reservation per child." and not 
immediately conclude that the Devicetree binding must be wrong because 
it is unable to adequately describe the properties and requirements of 
the hardware, frankly I struggle to imagine...

Thanks,
Robin.

> 
> 
> With that in mind, do you still prefer that this is handled through
> separate nodes, presumably for all of the aforementioned cases?
> 
> Konrad

