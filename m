From: nick <xerofoify-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] iommu:Check that iommu_device_create has completed
	successfully in alloc_iommu
Date: Tue, 29 Dec 2015 11:43:25 -0500
Message-ID: <5682B82D.8020502@gmail.com>
References: <1451365811-19111-1-git-send-email-xerofoify@gmail.com>
	<CAKT61h-n6=enWPAmEkPE36VZvrGFn9_Zj0y4+DdkOB33jyELUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAKT61h-n6=enWPAmEkPE36VZvrGFn9_Zj0y4+DdkOB33jyELUw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Wan ZongShun <mcuos.com-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



On 2015-12-29 02:15 AM, Wan ZongShun wrote:
> 2015-12-29 13:10 GMT+08:00 Nicholas Krause <xerofoify-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>> This adds the proper check to alloc_iommu to make sure that the call
>> to iommu_device_create has completed successfully and if not return
>> to the caller the error code returned after freeing up resources
>> allocated previously by alloc_iommu.
>>
>> Signed-off-by: Nicholas Krause <xerofoify-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  drivers/iommu/dmar.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
>> index 80e3c17..27333b6 100644
>> --- a/drivers/iommu/dmar.c
>> +++ b/drivers/iommu/dmar.c
>> @@ -1069,9 +1069,12 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
>>                 iommu->iommu_dev = iommu_device_create(NULL, iommu,
>>                                                        intel_iommu_groups,
>>                                                        "%s", iommu->name);
>> +       if (IS_ERR(iommu->iommu_dev)) {
>> +               err = PTR_ERR(iommu->iommu_dev);
>> +               goto err_unmap;
>> +       }
> 
> If so, will this bad 'iommu->iommu_dev' break your iommu work?  It
> seems not necessary.
> 
My concern is that if the iommu device is allocated successfully but not loaded
successfully into sysfs does this not make the device useless to some degree 
and therefore there is no point in having this device being allocated without
it's information being exported in sysfs. Again if it's fine without being 
exported in sysfs that's fine and in that case we should at least print to
the console with KERN_CRIT in order to warn of this critical error to the user.
Again I took the first approach but if you/the maintainer Joerg Roedel feel that
the second idea is better I will be glad to send a patch doing that :).
There are also other callers doing this as I found here so depending on 
how we solve this one I will do the others in a patch series:
http://lxr.free-electrons.com/ident?i=iommu_device_create
Hopes that this explains the patch,
Nick
>>
>>         return 0;
>> -
>>  err_unmap:
>>         unmap_iommu(iommu);
>>  error_free_seq_id:
>> --
>> 2.5.0
>>
>> _______________________________________________
>> iommu mailing list
>> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
> 
> 
