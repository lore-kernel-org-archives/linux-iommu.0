From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [bug report] iommu/arm-smmu: Make use of the iommu_register
	interface
Date: Wed, 22 Feb 2017 11:26:48 +0000
Message-ID: <96801505-0808-1ab0-8d10-2b6f22bec35f@arm.com>
References: <20170215083648.GA12604@mwanda> <20170222110042.GC4154@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170222110042.GC4154-l3A5Bk7waGM@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 22/02/17 11:00, Joerg Roedel wrote:
> Hi Dan,
> 
> thanks for the report! There are more bogus things going on here.
> 
> On Wed, Feb 15, 2017 at 11:36:48AM +0300, Dan Carpenter wrote:
>> The patch 9648cbc9625b: "iommu/arm-smmu: Make use of the 
>> iommu_register interface" from Feb 1, 2017, leads to the following 
>> Smatch complaint:
>>
>> drivers/iommu/arm-smmu-v3.c:1810 arm_smmu_remove_device()
>> 	 warn: variable dereferenced before check 'master' (see line 1809)
>>
>> drivers/iommu/arm-smmu-v3.c
>>   1808		master = fwspec->iommu_priv;
>>   1809		smmu = master->smmu;
>>                        ^^^^^^^^^^^^
>> New dereference.
>>
>>   1810		if (master && master->ste.valid)
>>                     ^^^^^^
>> Old code checked for NULL.
>>
>>   1811			arm_smmu_detach_dev(dev);
>>   1812		iommu_group_remove_device(dev);
> 
> So the master pointer comes from fwspec->iommu_priv, and master is freed
> later in the function. But I can't find where the fwspec->iommu_priv
> pointer is cleared. To me it looks like this breaks when a device is
> removed and the added again.

The pointer isn't cleared because the whole fwspec is freed on the very
next line.

Robin.

> 
> Robin, Will, can you have a look please?
> 
> 
> Thanks,
> 
> 	Joerg
> 
