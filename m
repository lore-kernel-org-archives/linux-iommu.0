From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 2/3] rpmsg: core: make rpmsg bus DMA capable
Date: Fri, 2 Mar 2018 16:40:53 +0000
Message-ID: <469cfe2c-d4d0-6050-339d-430f893e7775@linaro.org>
References: <20180302145531.20463-1-srinivas.kandagatla@linaro.org>
 <20180302145531.20463-3-srinivas.kandagatla@linaro.org>
 <07503032-b08b-10ea-9d34-ddf85c682a9d@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <07503032-b08b-10ea-9d34-ddf85c682a9d@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, will.deacon@arm.com, bjorn.andersson@linaro.org
Cc: joro@8bytes.org, ohad@wizery.com, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Thanks for your time,

On 02/03/18 16:14, Robin Murphy wrote:
> On 02/03/18 14:55, srinivas.kandagatla@linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> Many of the rpmsg clients like audio drivers need to allocate
>> dma memory. Make this bus DMA capable so that the child devices
>> can use dma apis.
> 
> AFAICS after 15 minutes in the docs and code, the rpmsg "bus" is a 
> virtual one based around shared-memory mailbox communication, so I don't 
> really see how DMA exists in that context - I think maybe that 
> abstraction needs looking at.
> 
> However, from grepping through the DTs it seems at first glance like the 
> non-trivial things under the "qcom,smd" bus mostly map to actual 
> platform devices via the "qcom,smd-edge" property - if those platform 
> devices are the physical DMA masters, they should be the ones used for 
> DMA API operations.

Currently there are very limited rpmsg devices in the mainline that use 
dma. Only one I can think of is wcnss WIFI driver which models up itself 
into another layer of platform device. Not sure if the DMA was the 
reason to do that.

However am working on audio drivers [1] which I modeled up as children 
of the rpmsg bus, so the problem started. There is an IOMMU in between 
APPs and DSP which provides audio services.
There are also other projects like FastRPC which have used similar 
driver model which ended up with same issues.

It all depends on how you model your driver. Audio case we have a rpmsg 
channel which exposes audio functionality. so If we want to use the 
iommu/dma operations we have to add another layer of platform device.
Which also means that rpmsg channel notifications have to be passed to 
these platform devices in some way.

Am not 100% sure if this correct way to fix the issue.

> 
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/rpmsg/rpmsg_core.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
>> index e84c71f8d6ab..540a3f3567b8 100644
>> --- a/drivers/rpmsg/rpmsg_core.c
>> +++ b/drivers/rpmsg/rpmsg_core.c
>> @@ -472,6 +472,7 @@ struct bus_type rpmsg_bus = {
>>       .uevent        = rpmsg_uevent,
>>       .probe        = rpmsg_dev_probe,
>>       .remove        = rpmsg_dev_remove,
>> +    .force_dma    = true,
> 
> Regardless of the above, would you really need to use this brute force 
> hack instead of just fixing the DTs? I'm struggling to find which 
> drivers might currently be relying on this :/

This is one of the two issues. dma-ranges might work in this case, but 
we still have iommu case.

> 
> Robin.
> 
>>   };
>>   EXPORT_SYMBOL(rpmsg_bus);
>>

thanks,
srini
[1]: https://lkml.org/lkml/2018/2/13/719
