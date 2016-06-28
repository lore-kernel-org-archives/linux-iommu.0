From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/3] iommu: remove unneeded check
Date: Tue, 28 Jun 2016 23:37:06 +0200
Message-ID: <3c9dae01-9ccf-b820-b45a-65037d26d440@gmail.com>
References: <461a9f1f-f601-8575-f2cc-78a1bcc12ee5@gmail.com>
	<20160628140922.56953ab9@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160628140922.56953ab9-1yVPhWWZRC1BDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Am 28.06.2016 um 22:09 schrieb Alex Williamson:
> On Tue, 28 Jun 2016 20:40:37 +0200
> Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> 
>> The init function ensures that iommu_group_kset can't be NULL.
>> Therefore this check isn't needed.
> 
> Have you seen your previous patch?  Wasn't this claim that the init
> function ensures iommu_group_kset more true when iommu_init() called
> BUG_ON(!iommu_group_kset) than it is when we can get by with just
> returning -ENOMEM?  Thanks,
> 
Uh, you're right. I was in "module mode" where initcall retvals are
assessed. Here the initcall retval is ignored.
If we leave the BUG_ON in however then the check is actually unneeded
as the system is halted after the BUG_ON.

By the way:
This check is in iommu_group_get_by_id() and this function doesn't seem
to have any user in the kernel. It was added about three years ago.
Is the original intention of this function obsolete meanwhile?

Thanks, Heiner

> Alex
> 
>> Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  drivers/iommu/iommu.c | 3 ---
>>  1 file changed, 3 deletions(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index b36ec9c..b36e24d 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -235,9 +235,6 @@ struct iommu_group *iommu_group_get_by_id(int id)
>>  	struct iommu_group *group;
>>  	const char *name;
>>  
>> -	if (!iommu_group_kset)
>> -		return NULL;
>> -
>>  	name = kasprintf(GFP_KERNEL, "%d", id);
>>  	if (!name)
>>  		return NULL;
> 
> 
