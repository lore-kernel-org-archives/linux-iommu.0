From: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Patch V2 2/2] iommu: remove sysfs_link to device in
	iommu_group/devices when failed
Date: Thu, 24 Mar 2016 14:51:21 +0000
Message-ID: <20160324145121.GA30863@vultr.guest>
References: <1458771911-30785-1-git-send-email-richard.weiyang@gmail.com>
	<1458771911-30785-3-git-send-email-richard.weiyang@gmail.com>
	<20160323170415.65ecf521@t450s.home>
Reply-To: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160323170415.65ecf521-1yVPhWWZRC1BDLzU/O5InQ@public.gmane.org>
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
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Mar 23, 2016 at 05:04:15PM -0600, Alex Williamson wrote:
>On Wed, 23 Mar 2016 22:25:11 +0000
>Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
>> The original code forgets to remove the sysfs_link to a device in
>> iommu_group/devices directory, when the creation fails or conflicts on the
>> name.
>> 
>> This patch tries to remove the sysfs_link on the failure.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  drivers/iommu/iommu.c |    1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 2696a38..8f480ba 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -403,6 +403,7 @@ rename:
>>  	ret = sysfs_create_link_nowarn(group->devices_kobj,
>>  				       &dev->kobj, device->name);
>>  	if (ret) {
>> +		sysfs_remove_link(group->devices_kobj, device->name);
>>  		kfree(device->name);
>>  		if (ret == -EEXIST && i >= 0) {
>>  			/*
>
>If we failed to create a link, potentially due to a conflicting link
>already present, then aren't we arbitrarily removing that conflicting
>link with this change?  If sysfs_create_link_nowarn() fails then we
>haven't created a link of our own to remove.  This looks wrong.  Thanks,
>

Hmm... you are right, that's my bad.

Do you have comments on the first patch?

>Alex

-- 
Wei Yang
Help you, Help me
