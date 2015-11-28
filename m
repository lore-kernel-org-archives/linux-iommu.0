From: chenfeng <puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Subject: Re: [PATCH V5 RESEND 2/3] iommu/hisilicon: Add hi6220-SoC smmu driver
Date: Sat, 28 Nov 2015 10:19:14 +0800
Message-ID: <56590F22.90105@hisilicon.com>
References: <1447986309-47548-1-git-send-email-puck.chen@hisilicon.com>
 <1447986309-47548-3-git-send-email-puck.chen@hisilicon.com>
 <20151127120203.GI24300@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151127120203.GI24300-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, puck.chen-Dw/NWeUnuQfQT0dZR+AlfA@public.gmane.org, w.f-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, guodong.xu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, arnd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, haojian.zhuang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On 2015/11/27 20:02, Joerg Roedel wrote:
> On Fri, Nov 20, 2015 at 10:25:08AM +0800, Chen Feng wrote:
>> +config HI6220_IOMMU
>> +	bool "Hi6220 IOMMU Support"
>> +	depends on ARM64
>> +	select IOMMU_API
>> +	select IOMMU_IOVA
>> +	help
>> +	  Enable IOMMU Driver for hi6220 SoC. The IOMMU API and IOMMU IOVA
>> +	  is also selected.
> 
> The last sentence is of little help for the user. Better put the reasons
> in here when a user should select this option.
> 
>> +	/*set axi id*/
> 
> Coding style nit: Please write these oneline comments with spaces, like
> this:
> 
> 	/* set axi id */
> 

learned,Thanks.
>> +static int hi6220_smmu_attach_dev(struct iommu_domain *domain,
>> +				  struct device *dev)
>> +{
>> +	dev->archdata.iommu = &iova_allocator;
>> +
>> +	return 0;
>> +}
>> +
>> +static void hi6220_smmu_detach_dev(struct iommu_domain *domain,
>> +				   struct device *dev)
>> +{
>> +	dev->archdata.iommu = NULL;
>> +}
> 
> This basically means that this driver only supports one domain, right?
yes.
> That is not compatible with the iommu-api requirements.
> 
> You need to create an iommu-group per smmu in your system and put all
> devices translated by this smmu in that group. And then you must change
> your code to allow attaching/detaching this iommu-group to different
> domains.
> 
I read the code,I am confused about these concepts.
In my opinion,
IOMMU-Domain: The masters in one domain share the same iova space. Is that right?
IOMMU-GROUP: As you mentioned up,all devices translated by this smmu should be into one group.
I can do this. But if there is only on domain in the system, how can I attaching/detaching the group
to different domains.

I think I have something wrong with these concepts.

Could you help to give me some suggestions.

> 
> 	Joerg
> 
> 
> .
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
