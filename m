From: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
Subject: Re: [PATCH v3] iommu: Add driver for Renesas VMSA-compatible IPMMU
Date: Thu, 10 Jul 2014 08:20:25 +0900
Message-ID: <53BDCE39.1070306@renesas.com>
References: <1396435657-3922-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <538D55C2.3090209@renesas.com> <1837932.hUVa08Puz4@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1837932.hUVa08Puz4@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: khiem.nguyen.xt@renesas.com, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, iommu@lists.linux-foundation.org, linux-sh@vger.kernel.org, Joerg Roedel <joro@8bytes.org>
List-Id: iommu@lists.linux-foundation.org

Hi Laurent,

Thanks for your explanation.

I'm fine with current situation. 
I have also checked other drivers and they did the same.
As you said, let's improve this driver when the time comes.

Thanks.

Best regards,
KHIEM Nguyen

On 6/4/2014 2:39 AM, Laurent Pinchart wrote:
> Hi,
> 
> On Tuesday 03 June 2014 13:57:38 Khiem Nguyen wrote:
>> Hi Laurent,
>>
>> Thanks for the patch.
>>
>>> +	if (!iommu_present(&platform_bus_type))
>>> +		bus_set_iommu(&platform_bus_type, &ipmmu_ops);
>>
>> With this code, if error occurs, it's hidden.
>>
>> I think it should be like below,
>>
>>> +	ret = bus_set_iommu(&platform_bus_type, &ipmmu_ops);
>>> +	if (ret < 0)
>>> +		return ret;
>>
>> In this case, if error occurs, -EBUSY is returned.
>> It's easier for troubleshooting the issue.
>>
>> How do you think ?
> 
> I agree that we have a problem, but the problem is broader than this. Only one 
> IOMMU type can be associated with a given bus, so things will break as soon as 
> we will compile multiple IOMMU drivers in a multiplatform kernel. I'd like to 
> fix this properly, but it requires IOMMU framework changes, and thus time. In 
> the meantime we could apply your proposed modification, but it needs an 
> additional platform_driver_unregister() call in the bus_set_iommu() error 
> path.
> 
