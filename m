From: Peng Fan <van.freenix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC] iommu: arm-smmu: correct reference count
Date: Mon, 9 Nov 2015 13:41:45 +0800
Message-ID: <20151109054143.GA5704@linux-jyl1.ap.freescale.net>
References: <1446555557-3097-1-git-send-email-van.freenix@gmail.com>
	<20151103131734.GE14159@arm.com> <20151104024825.GA27479@shlinux2>
	<20151106122338.GI6087@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151106122338.GI6087-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Peng Fan <b51431-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On Fri, Nov 06, 2015 at 12:23:39PM +0000, Will Deacon wrote:
>On Wed, Nov 04, 2015 at 10:48:28AM +0800, Peng Fan wrote:
>> On Tue, Nov 03, 2015 at 01:17:34PM +0000, Will Deacon wrote:
>> >On Tue, Nov 03, 2015 at 08:59:17PM +0800, Peng Fan wrote:
>> >> iommu_group_alloc will initialize the reference count for group to 1.
>> >> iommu_group_add_device also increase the group reference count,
>> >> if nothing bad happends. And we need to add iommu_group_put to
>> >> decrease the reference count for group.
>> >> 
>> >> Signed-off-by: Peng Fan <van.freenix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> >> Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
>> >> Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
>> >> ---
>> >> 
>> >> Not sure whether my understanding is correct or not. I checked rockchip-iommu.c
>> >> exynos-iommu.c and fsl_pamu_domain.c, and they all have iommu_group_put after
>> >> iommu_group_add_device.
>> >
>> >Doesn't this pair up with the iommu_group_remove_device in
>> >arm_smmu_remove_device? Are you actually seeing an issue in practice?
>> 
>> In arm_smmu_add_platform_device,
>> iommu_group_alloc --> group->device_kobj ref count will be init to 1.
>> iommu_group_add_device --> group->device_kobj ref count will be added 1 to 2.
>> 
>> In arm_smmu_remove_device:
>> iommu_group_remove_device --> Decrease group->device_kobj ref count by 1.
>> After arm_smmu_remove_device, the ref count of group->device_kobj is not 0.
>> 
>> So I think need to add iommu_group_put after iommu_group_add_device.
>> If I am wrong, please correct me.
>
>Ok, I see what you're saying. iommu_group_get_for_dev has exactly the
>same issue, so could you update arm-smmu-v3.c as well, please?

I did not see the update about device_group for iommu, when I worked out this patch.
Rebased to latest linux/master, whether to arm-smmu.c or arm-smmu-v3.c,
only add 'iommu_group_put' at the end of iommu_group_get_for_dev is ok as the
following.

I'll send out V2.

Thanks,
Peng.

>
>Thanks,
>
>Will
