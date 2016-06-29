From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/3] iommu: remove unneeded check
Date: Wed, 29 Jun 2016 21:01:21 +0200
Message-ID: <aef72270-8969-5759-e847-539d4fdce215@gmail.com>
References: <461a9f1f-f601-8575-f2cc-78a1bcc12ee5@gmail.com>
	<20160628140922.56953ab9@t450s.home>
	<3c9dae01-9ccf-b820-b45a-65037d26d440@gmail.com>
	<20160628160734.065ec7e1@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160628160734.065ec7e1-1yVPhWWZRC1BDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Am 29.06.2016 um 00:07 schrieb Alex Williamson:
> On Tue, 28 Jun 2016 23:37:06 +0200
> Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> 
>> Am 28.06.2016 um 22:09 schrieb Alex Williamson:
>>> On Tue, 28 Jun 2016 20:40:37 +0200
>>> Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>   
>>>> The init function ensures that iommu_group_kset can't be NULL.
>>>> Therefore this check isn't needed.  
>>>
>>> Have you seen your previous patch?  Wasn't this claim that the init
>>> function ensures iommu_group_kset more true when iommu_init() called
>>> BUG_ON(!iommu_group_kset) than it is when we can get by with just
>>> returning -ENOMEM?  Thanks,
>>>   
>> Uh, you're right. I was in "module mode" where initcall retvals are
>> assessed. Here the initcall retval is ignored.
>> If we leave the BUG_ON in however then the check is actually unneeded
>> as the system is halted after the BUG_ON.
>>
So please disregard patch 2 of the series.

>> By the way:
>> This check is in iommu_group_get_by_id() and this function doesn't seem
>> to have any user in the kernel. It was added about three years ago.
>> Is the original intention of this function obsolete meanwhile?
> 
> 
> Alexey, this is a question for you.  Did the user of this function
> never materialize:
> 
> commit aa16bea929aed6ea854b55d2be8306a9fb40e694
> Author: Alexey Kardashevskiy <aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>
> Date:   Mon Mar 25 10:23:49 2013 +1100
> 
>     iommu: Add a function to find an iommu group by id
>     
>     As IOMMU groups are exposed to the user space by their numbers,
>     the user space can use them in various kernel APIs so the kernel
>     might need an API to find a group by its ID.
>     
>     As an example, QEMU VFIO on PPC64 platform needs it to associate
>     a logical bus number (LIOBN) with a specific IOMMU group in order
>     to support in-kernel handling of DMA map/unmap requests.
>     
>     The patch adds the iommu_group_get_by_id(id) function which performs
>     such search.
> 
> If not, let's remove it.  Dead code is broken code.  Thanks,
> 
> Alex
> 
And also disregard patch 3 of the series until we have a decision how to
go on with iommu_group_get_by_id(id).

>>>> Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>> ---
>>>>  drivers/iommu/iommu.c | 3 ---
>>>>  1 file changed, 3 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>>> index b36ec9c..b36e24d 100644
>>>> --- a/drivers/iommu/iommu.c
>>>> +++ b/drivers/iommu/iommu.c
>>>> @@ -235,9 +235,6 @@ struct iommu_group *iommu_group_get_by_id(int id)
>>>>  	struct iommu_group *group;
>>>>  	const char *name;
>>>>  
>>>> -	if (!iommu_group_kset)
>>>> -		return NULL;
>>>> -
>>>>  	name = kasprintf(GFP_KERNEL, "%d", id);
>>>>  	if (!name)
>>>>  		return NULL;  
>>>
>>>   
>>
> 
> 
