Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D489A3328FF
	for <iommu@lists.linux.dev>; Wed,  5 Nov 2025 17:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762363742; cv=none; b=BElujoyeYZhbPSHx26UoNzHrigXbJJPZrkuMNrW+JSmPyQrzglhXUdDsis8CfCxsG0g0Ji/Sl0AU8s1kZo9qo9wsnJsRLeqPSjgfNLTwByvWtf66YfIZ1OKHOGKkz2Q1+Y/5vPxBqMBcHeRi2U4j9MskGaCt0XupdlBSm/oNos8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762363742; c=relaxed/simple;
	bh=k2ZM3DJwll1Max1svThLctb3ZOnNVY45eztnrBFDlek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I0qmxhiHC1cb+4BOuX5q3o9ILt4k185Lv1QFQ0mxnp7QYkDgPMQgqOdjabt7fSI2+/wqrF+PB6XUTpOAyb7y1iU9fIfmYeLeMensxyCiv0Q6HIAiGSkYW/2eSCbfEhki0xXk75XZyLPv3qr6SSGcK/mZXtTp+maluu0th2sYhno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61199169C;
	Wed,  5 Nov 2025 09:28:52 -0800 (PST)
Received: from [10.57.86.139] (unknown [10.57.86.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F09593F63F;
	Wed,  5 Nov 2025 09:28:54 -0800 (PST)
Message-ID: <0319bdf5-0a46-40fc-93f8-30d74cf6475a@arm.com>
Date: Wed, 5 Nov 2025 17:28:51 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] of: iommu-map parsing for multi-cell IOMMU
To: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>, will@kernel.org,
 joro@8bytes.org, robh@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
 konrad.dybcio@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com,
 bod@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 saravanak@google.com, prakash.gupta@oss.qualcomm.com,
 vikash.garodia@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <cover.1762235099.git.charan.kalla@oss.qualcomm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <cover.1762235099.git.charan.kalla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-11-04 8:50 am, Charan Teja Kalla wrote:
> The iommu-map property has been defined for the PCIe usecase and has
> been hardcoded to assume single cell for IOMMU specification, ignoring
> the #iommu-cells completely. Since the initial definition the iommu-maps
> property has been reused for other usecases and we can no longer assume
> that the single IOMMU cell properly describes the necessary IOMMU
> streams. Expand the iommu-map to take #iommu-cells into account, while
> keeping the compatibility with the existing DTs, which assume single
> argument.
> 
> Unlike single iommu-cell, it is complex to establish a linear relation
> between input 'id' and output specifier for multi iommu-cells. To handle
> such cases, rely on arch-specific drivers called through
> of_iommu_xlate() from of_iommu layer, aswell it is expected the 'len'
> passed is always 1. In the of_iommu layer, the below relation is
> established before calling into vendor specific driver:
> 
> a) For platform devices, 'rid' defined in the iommu-map tuple indicates
> a function, through a bit position, which is compared against passed
> input 'id' that represents a bitmap of functions represented by the
> device.
> 
> b) For others, 'rid' is compared against the input 'id' as an integer
> value.
> 
> Thus the final representation when #iommu-cells=n is going to be,
> iommu-map = <rid/functionid IOMMU_phandle cell0 .. celln len>;, where
> len = 1.
> 
> The RFC for this patch set is found at [2].
> 
> The other motivation for this patchset is the below usecase.
> USECASE [1]:
> ------------
> Video IP, 32bit, have 2 hardware sub blocks(or can be called as
> functions) called as pixel and nonpixel blocks, that does decode and
> encode of the video stream. These logical blocks are configured to
> generate different stream IDs.
> 
> With the classical approach of representing all sids with iommus= end up
> in using a single translation context limited to the 4GB. There are
> video usecases which needs larger IOVA space, like higher concurrent
> video sessions(eg: 32 session and 192MB per session) where 4GB of IOVA
> is not sufficient.
> 
> For this case, each functionality is represented in the firmware(device
> tree) by the 'rid' field of the iommu-map property and the video driver
> creates sub platform devices for each of this functionality and call
> into IOMMU configuration. Each rid(function id) in the dt property
> indicates the bit that can be associated by the driver passed input id.
> 
> Example:
> iommu {
> 	#iommu-cells = 2;
> };
> 
> video-codec@foobar {
> 	compatible = "qcom,video";
> 	iommus = <&apps_smmu 0x1234 0xca>;
> 	iommu-map= <0x1 &iommu 0x1940 0x0 0x1>,
>                 <0x1 &iommu 0x1941 0x0 0x1>,
>                 <0x2 &iommu 0x1942 0x0 0x1>,
>                 <0x4 &iommu 0x1943 0x0 0x1>,
>                 <0x4 &iommu 0x1944 0x0 0x1>;
> };
> 
> video-driver:
> #define PIXEL_FUNC	   (1)
> #define NON_PIXEL_FUNC	   (2)
> #define SECURE_FUNC	   (4)
> 
> case1: All these functionalities requires individual contexts.
> Create 3 subdevices for each of this function and call
> of_dma_configure_id(..,id), id = 0x1, 0x2, 0x4.
> 
> Case2: Secure and non-secure functionalities require individual
> contexts. Create 2 subdevices and call of_dma_configure_id(..,id), id =
> 0x3(bitmap of pixel and non-pixel), 0x4 (secure).
> 
> Credits: to Dmitry for thorough discussions on the RFC patch and major
> help in getting the consenus on this approach, to Konrad & Bjorn for
> offline discussions and reviews, to Robin for his inputs on IOMMU front,
> to Bod, Rob and Krzysztof for all valuable inputs.
> 
> [1] https://lore.kernel.org/all/20250627-video_cb-v3-0-51e18c0ffbce@quicinc.com/
> [2] https://lore.kernel.org/all/20250928171718.436440-1-charan.kalla@oss.qualcomm.com/#r
> 
> Charan Teja Kalla (6):
>    of: create a wrapper for of_map_id()
>    of: introduce wrapper function to query the cell count
>    of: parse #<name>-cells property to get the cell count
>    of: detect and handle legacy iommu-map parsing
>    of: add infra to parse iommu-map per IOMMU cell count
>    of: use correct iommu-map parsing logic from of_iommu layer
> 
>   drivers/iommu/of_iommu.c |  59 +++++++--
>   drivers/of/base.c        | 269 +++++++++++++++++++++++++++++++++++----
>   include/linux/of.h       |  19 +++
>   3 files changed, 314 insertions(+), 33 deletions(-)

Hmm, I did actually have a quick go at this the other week too, and 
while I though it was a bit clunky, it was still significantly simpler 
than this seems to be...

FWIW: https://gitlab.arm.com/linux-arm/linux-rm/-/commits/iommu-map - I 
can give it some polish and testing to post properly if you like.

Thanks,
Robin.
