Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8E3305053
	for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 16:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764003086; cv=none; b=BZ7qQuQlLR/zlsH6akwAvGpxicX7zzQyQd1s1LXQZERg8oun5RbmPfCfrM+0jYfuYDe0fjbi892qLRYKQ5g3Hg3GQe1SbI7kYnv97ghK6DfjpmjPP2r+2LpnH+/Eaw5vIHK2ei17sJIu+vQpcyAl1c3pb/29bqDlfZCYRhAEbRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764003086; c=relaxed/simple;
	bh=gDnwfPg9jc5DTHv76+SKqQxhEtEHAC5h//p7/nzJh/s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gLBOjmBVg71oZEZR/GRQDz5LIy1GKu7gzw2SpNser3ZdN1T8K7iFhZRmiGj+tBQUX6YGbOXJdUi94CsAktrRpDG7hSWu4M9UJ82LM9h+m34vtKGrHTNdqjZ84cO4cAlJWuQ0yewLLRLv0dDM+2MlNHMzu39b/CVz7Oo5fd1K9do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE0D514BF;
	Mon, 24 Nov 2025 08:51:16 -0800 (PST)
Received: from [10.1.30.67] (unknown [10.1.30.67])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 802493F86F;
	Mon, 24 Nov 2025 08:51:21 -0800 (PST)
Message-ID: <5237fb86-dec6-46e3-82bc-d41f3d537e53@arm.com>
Date: Mon, 24 Nov 2025 16:51:19 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Robin Murphy <robin.murphy@arm.com>
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
 <0319bdf5-0a46-40fc-93f8-30d74cf6475a@arm.com>
 <351373ed-c699-4945-a978-cb35412918bc@oss.qualcomm.com>
 <e6fb7000-7aac-45b6-b4f9-c9efa2a98d57@oss.qualcomm.com>
Content-Language: en-GB
In-Reply-To: <e6fb7000-7aac-45b6-b4f9-c9efa2a98d57@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-11-12 2:42 pm, Charan Teja Kalla wrote:
> 
> 
> On 11/11/2025 11:57 PM, Charan Teja Kalla wrote:
>>
>> On 11/5/2025 10:58 PM, Robin Murphy wrote:
>>>> The other motivation for this patchset is the below usecase.
>>>> USECASE [1]:
>>>> ------------
>>>> Video IP, 32bit, have 2 hardware sub blocks(or can be called as
>>>> functions) called as pixel and nonpixel blocks, that does decode and
>>>> encode of the video stream. These logical blocks are configured to
>>>> generate different stream IDs.
>>>>
>>>> With the classical approach of representing all sids with iommus= end up
>>>> in using a single translation context limited to the 4GB. There are
>>>> video usecases which needs larger IOVA space, like higher concurrent
>>>> video sessions(eg: 32 session and 192MB per session) where 4GB of IOVA
>>>> is not sufficient.
>>>>
>>>> For this case, each functionality is represented in the firmware(device
>>>> tree) by the 'rid' field of the iommu-map property and the video driver
>>>> creates sub platform devices for each of this functionality and call
>>>> into IOMMU configuration. Each rid(function id) in the dt property
>>>> indicates the bit that can be associated by the driver passed input id.
>>>>
>>>> Example:
>>>> iommu {
>>>>      #iommu-cells = 2;
>>>> };
>>>>
>>>> video-codec@foobar {
>>>>      compatible = "qcom,video";
>>>>      iommus = <&apps_smmu 0x1234 0xca>;
>>>>      iommu-map= <0x1 &iommu 0x1940 0x0 0x1>,
>>>>                  <0x1 &iommu 0x1941 0x0 0x1>,
>>>>                  <0x2 &iommu 0x1942 0x0 0x1>,
>>>>                  <0x4 &iommu 0x1943 0x0 0x1>,
>>>>                  <0x4 &iommu 0x1944 0x0 0x1>;
>>>> };
>>>>
>>>> video-driver:
>>>> #define PIXEL_FUNC       (1)
>>>> #define NON_PIXEL_FUNC       (2)
>>>> #define SECURE_FUNC       (4)
>>>>
>>>> case1: All these functionalities requires individual contexts.
>>>> Create 3 subdevices for each of this function and call
>>>> of_dma_configure_id(..,id), id = 0x1, 0x2, 0x4.
>>>>
>>>> Case2: Secure and non-secure functionalities require individual
>>>> contexts. Create 2 subdevices and call of_dma_configure_id(..,id), id =
>>>> 0x3(bitmap of pixel and non-pixel), 0x4 (secure).
>>>>
>>>> Credits: to Dmitry for thorough discussions on the RFC patch and major
>>>> help in getting the consenus on this approach, to Konrad & Bjorn for
>>>> offline discussions and reviews, to Robin for his inputs on IOMMU front,
>>>> to Bod, Rob and Krzysztof for all valuable inputs.
>>>>
>>>> [1] https://lore.kernel.org/all/20250627-video_cb-
>>>> v3-0-51e18c0ffbce@quicinc.com/
>>>> [2] https://lore.kernel.org/all/20250928171718.436440-1-
>>>> charan.kalla@oss.qualcomm.com/#r
>>>>
>>>> Charan Teja Kalla (6):
>>>>     of: create a wrapper for of_map_id()
>>>>     of: introduce wrapper function to query the cell count
>>>>     of: parse #<name>-cells property to get the cell count
>>>>     of: detect and handle legacy iommu-map parsing
>>>>     of: add infra to parse iommu-map per IOMMU cell count
>>>>     of: use correct iommu-map parsing logic from of_iommu layer
>>>>
>>>>    drivers/iommu/of_iommu.c |  59 +++++++--
>>>>    drivers/of/base.c        | 269 +++++++++++++++++++++++++++++++++++----
>>>>    include/linux/of.h       |  19 +++
>>>>    3 files changed, 314 insertions(+), 33 deletions(-)
>>> Hmm, I did actually have a quick go at this the other week too, and
>>> while I though it was a bit clunky, it was still significantly simpler
>>> than this seems to be...
>>>
>>> FWIW: https://gitlab.arm.com/linux-arm/linux-rm/-/commits/iommu-map - I
>> Thanks a lot Robin for taking a look and sorry for the delayed reply as
>> I was on vacation.
>>
>> stripped code_snippet from your patch:
>> 	offset = 0;
>> 	out_base = map + offset + 2;
>> 	id_off = masked_id - id_base;
>> 	if (masked_id < id_base || id_off >= id_len)
>> 		continue;
>> 	for (int i = 0; id_out && i < cells; i++)
>> 		id_out[i] = id_off + be32_to_cpu(out_base[i]);
>>
>>
>> seems way cleaner than mine...
>>
>> Actually, we also have a case of a device emitting 2 distinct
>> identifiers, eg: a device is emitting 0x1940, 0x1944 and 0x1A20 sids and
>> attached to a single context bank. If I use mask to cover all these sids
>> in a single iommu-map entry, it does overlap with other device SID.
>>
>> I don't think that patch you shared can be used to cover the above, or
>> it is?

No, the point of my patch is just to correctly respect #cells and 
hopefully discourage any further abuse of Linux's current behaviour. The 
fact that Linux interprets multiple mappings for the same input ID as a 
set of equivalent choices to pick one of, rather than a set that must 
all be maintained in parallel, is an orthogonal concern. Again there's 
not necessarily one right answer there.

>> Hence I resorted to the approach where RID used as the bitmap of indices
>> to cover such cases for platform devices, which it seems you clearly
>> didn't like....otherwise, any otherway we can handle such cases?

Eww, if the intent of that was to bake further abuse into DT ABI to 
bodge around Linux behaviour then I double-NAK it even harder :)

> Hi Robin,
> 
> Don't want to bother you with my ideas, but I can't think of other ways
> to handle such cases of multi-map than the below. I just tried this code on
> Qemu on top of your patches(with some nit compilation fixes) and just checked
> if devices are added to the iommu groups.

My initial thought would be to either add an index argument so that 
callers can keep count and request the Nth match if they want to - like 
we do in various resource management APIs, for instance - or go all the 
way and convert the existing target and id_out complexity into 
usage-specific callbacks too.

> ----------------------8888---------------------------------------------
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index a511ecf21fcd..ac005e70de7d 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -16,6 +16,7 @@
>   #include <linux/pci.h>
>   #include <linux/slab.h>
>   #include <linux/fsl/mc.h>
> +#include <linux/platform_device.h>
>   
>   #include "iommu-priv.h"
>   
> @@ -41,6 +42,18 @@ static int of_iommu_xlate(struct device *dev,
>   	return ret;
>   }
>   
> +static int of_iommu_configure_cb(void *arg, u32 *id_out)
> +{
> +	struct of_phandle_args *iommu_spec =
> +		(struct of_phandle_args *)((void *)id_out - offsetof(struct of_phandle_args, args));

Not sure whether to be impressed or disgusted... If we are to take a 
callback approach then it should probably standardise on passing a full 
of_phandle_args to encode the map output. Particularly given what I've 
just noticed below...

> +	struct device *dev = arg;
> +	int err;
> +
> +	err = of_iommu_xlate(dev, iommu_spec);
> +	of_node_put(iommu_spec->np);
> +	return err;
> +}
> +
>   static int of_iommu_configure_dev_id(struct device_node *master_np,
>   				     struct device *dev,
>   				     const u32 *id)
> @@ -48,12 +61,10 @@ static int of_iommu_configure_dev_id(struct device_node *master_np,
>   	struct of_phandle_args iommu_spec = { .args_count = 1 };

Oh dear, I totally overlooked this, and off the top of my head I'm not 
sure it's simple to fix :(

So it's still not actually working as intended. Oh well, I did say it 
was untested...

Thanks,
Robin.
