From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 07/11] iommu/arm-smmu: Make use of the iommu_register
	interface
Date: Fri, 10 Feb 2017 17:07:47 +0000
Message-ID: <35cd4154-df22-bd8c-6c0b-0a074ab0c179@arm.com>
References: <1486639981-32368-1-git-send-email-joro@8bytes.org>
	<1486639981-32368-8-git-send-email-joro@8bytes.org>
	<9bba214f-4d83-1e37-2df8-2f7db11f7d1f@arm.com>
	<20170210152553.GJ7339@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170210152553.GJ7339-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 10/02/17 15:25, Joerg Roedel wrote:
> On Fri, Feb 10, 2017 at 02:20:34PM +0000, Robin Murphy wrote:
>>> @@ -1795,8 +1798,10 @@ static int arm_smmu_add_device(struct device *dev)
>>>  	}
>>>  
>>>  	group = iommu_group_get_for_dev(dev);
>>> -	if (!IS_ERR(group))
>>> +	if (!IS_ERR(group)) {
>>>  		iommu_group_put(group);
>>> +		iommu_device_link(&smmu->iommu, dev);
>>
>> Given the coupling evident from this and the other patches, might it
>> work to simply do the linking/unlinking automatically in
>> iommu_group_{add,remove}_device()?
> 
> Yes, this is one of the goals too. But currently we don't have a generic
> device->hw_iommu mapping in the iommu-code which would allow to call
> the link/unlink functions in generic code too.

At some point we should change the iommu_ops pointer in iommu_fwspec for
an iommu_device pointer - that would then give us an easy
dev->fwpec->hw_iommu relationship which is mostly managed by core code
already. In the meantime I was imagining just passing it around,
something like iommu_group_add_device(hw_iommu, group, dev), but now I
suspect that'd be running up against a similar objection to before ;)

Robin.

> 
> But changing this is one of the next things on my list :)
> 
> 
> 
> 	Joerg
> 
