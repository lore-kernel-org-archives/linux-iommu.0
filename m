Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5853C76AD
	for <iommu@lists.linux.dev>; Thu, 10 Sep 2026 10:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789035867; cv=none; b=Av3IQcehn3WSztA2A6RghoSACnNLobX1/ZCYLrsxayxPHLetvYWMMGqnUXNFUbrm7Ia+Va+yyn3JZCxYjPmxBO4aIe/cEKN8djrmZdnGuZRiKFNs4QLT5DYOMvNNU0MEaNH8b12wSfbenpyxA85QhVsZ9rGp5BbbC4sBZFw78lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789035867; c=relaxed/simple;
	bh=0VyEVvYeNWtZqLC2vVA2N3epmqwfXEEJjEfrshlgK8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S3rqAVLwvx6RF9/ArjAF5xNUPPpEcLXZqyy3d1I2B8CpJdvGe4Yvj+2wawiZCnRlCYmTplRp5N1Bt018kD2x1XKtO3wcRDtwXyPgoQ1sYOZly+iwUWSn81L0AazFq3wk7v5WpZ1G3ecsObRgMKKbKdOWh2VKSErpvZFjQM9BUQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=U9PHLvJ3; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="U9PHLvJ3"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CFA1143D;
	Thu, 10 Sep 2026 03:24:21 -0700 (PDT)
Received: from [10.2.212.8] (e134344.arm.com [10.2.212.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 689913F7B4;
	Thu, 10 Sep 2026 03:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789035864; bh=0VyEVvYeNWtZqLC2vVA2N3epmqwfXEEJjEfrshlgK8k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U9PHLvJ3ax9U5iM/TVSVBsRv3Hxc8mks2EqBXvTRpWpNdsjerhR7/N4LrFKSbD7V1
	 fZXIAw1mslbH2YxsrIU22+UX9eYsxbU+CNPD0tjBT0kkHzyFcRzwGeGHV8rYAlhPnf
	 u5EkbdWxmSUU+2Q5bo+nHgLv0Tlm95ARxRol5i24=
Message-ID: <d006c7e3-e270-4261-b1bb-f5e6420c084c@arm.com>
Date: Thu, 10 Sep 2026 11:24:19 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/5] fs/resctrl: Add a "devices" file to assign
 devices to groups
To: Qinxin Xia <xiaqinxin@huawei.com>, zhangzhanpeng.jasper@bytedance.com,
 joro@8bytes.org, palmer@dabbelt.com, tony.luck@intel.com,
 reinette.chatre@intel.com, tomasz.jeznach@linux.dev, zengheng4@huawei.com,
 fustini@kernel.org, cuiyunhui@bytedance.com, wangzhou1@hisilicon.com
Cc: will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
 aou@eecs.berkeley.edu, alex@ghiti.fr, Dave.Martin@arm.com,
 james.morse@arm.com, babu.moger@amd.com, corbet@lwn.net, shuah@kernel.org,
 jgg@ziepe.ca, kevin.tian@intel.com, yuanzhu@bytedance.com,
 iommu@lists.linux.dev, linuxarm@huawei.com, baolin.wang@linux.alibaba.com
References: <20260901140802.1215508-1-xiaqinxin@huawei.com>
 <20260901140802.1215508-6-xiaqinxin@huawei.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20260901140802.1215508-6-xiaqinxin@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Qinxin,

On 01/09/2026 15:08, Qinxin Xia wrote:
> Expose the device QoS tracking through a new "devices" file. Writing a
> device name assigns it to the group, tagging its DMA with the group's QoS
> IDs.
> 
> The file is only shown where an IOMMU can tag device DMA.
> 
> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
> ---
>  Documentation/filesystems/resctrl.rst |  18 ++++-
>  fs/resctrl/rdtgroup.c                 | 101 ++++++++++++++++++++++++++
>  2 files changed, 117 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
> index e4b66af55ffb..aa205ccaabf6 100644
> --- a/Documentation/filesystems/resctrl.rst
> +++ b/Documentation/filesystems/resctrl.rst
> @@ -546,8 +546,8 @@ directories can be created to monitor subsets of tasks in the CTRL_MON
>  group that is their ancestor. These are called "MON" groups in the rest
>  of this document.
>  
> -Removing a directory will move all tasks and cpus owned by the group it
> -represents to the parent. Removing one of the created CTRL_MON groups
> +Removing a directory will move all tasks, cpus and devices owned by the
> +group it represents to the parent. Removing one of the created CTRL_MON groups
>  will automatically remove all MON groups below it.
>  
>  Moving MON group directories to a new parent CTRL_MON group is supported
> @@ -581,6 +581,20 @@ All groups contain the following files:
>  	idle tasks. Instead, a CPU's idle task is always considered as a
>  	member of the group owning the CPU.
>  
> +"devices":
> +	Reading this file shows the list of all devices that belong to
> +	this group. Writing a device name to the file will add a device to
> +	the group, tagging its DMA with the group's QoS IDs. Multiple
> +	devices can be added by separating the names with commas. A single
> +	failure encountered while attempting to assign a device will cause
> +	the operation to abort and already added devices before the failure
> +	will remain in the group. Failures will be logged to
> +	/sys/fs/resctrl/info/last_cmd_status.
> +
> +	The device name is the one listed under
> +	/sys/kernel/iommu_groups/<id>/devices/. This file is only present
> +	when an IOMMU can tag the DMA of devices behind it with a QoS class.

What's the expectation when there is more than one device listed? It seems odd to specify the
iommu_group by device name when there may be more than one device. Would it not be better to just
use the id directly?

There are also other platform devices such as the GPU which may not be behind an SMMU/IOMMU but can
be an MPAM requester. We should also take these into account when designing the interface. One
,unworkable, idea is that under a 'devices' directory there could be two files, iommu_group and
platform_device. The iommu_group would take an iommu_group id (as per /sys/kernel/iommu_groups/<id>)
and the platform_device the name from /sys/bus/platform/devices/. I suggest separate files to avoid
any naming conflicts. However, this does leave the problem that the 'devices' directory would likely
then be considered a CTRL_MON group by tools and so not a usable interface.

One other consideration is the life cycle and scope of the resctrl domains. For instance, if the
IOMMU is upstream of a cache which supports cache allocation then the cache allocation for the
instance downstream of the IOMMU should still be configurable even if the associated CPUs are
disabled. For MPAM systems IIUC this would require extra topology information than what is currently
available in the ACPI description. I plan to bring this up with the MPAM architects. I'm not sure
what's available for other architectures. The existing 'io_alloc' and 'io_alloc_cbm' (not used on
MPAM) look to side step this by keeping them in the info directory.

Thanks,

Ben

> +
>  "cpus":
>  	Reading this file shows a bitmask of the logical CPUs owned by
>  	this group. Writing a mask to this file will add and remove
> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
> index c33891ead788..3633b3521941 100644
> --- a/fs/resctrl/rdtgroup.c
> +++ b/fs/resctrl/rdtgroup.c
> @@ -985,6 +985,92 @@ static const struct iommu_qos_device_ops rdtgroup_qos_device_ops = {
>  	.remove = rdtgroup_remove_device,
>  };
>  
> +static ssize_t rdtgroup_devices_write(struct kernfs_open_file *of,
> +				      char *buf, size_t nbytes, loff_t off)
> +{
> +	struct rdtgroup *rdtgrp;
> +	char *token;
> +	int ret = 0;
> +
> +	if (!buf)
> +		return -EINVAL;
> +
> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> +	if (!rdtgrp) {
> +		rdtgroup_kn_unlock(of->kn);
> +		return -ENOENT;
> +	}
> +	rdt_last_cmd_clear();
> +
> +	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED ||
> +	    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
> +		ret = -EINVAL;
> +		rdt_last_cmd_puts("Pseudo-locking in progress\n");
> +		goto unlock;
> +	}
> +
> +	while ((token = strsep(&buf, ","))) {
> +		struct device *dev;
> +
> +		token = strim(token);
> +		if (!*token) {
> +			rdt_last_cmd_puts("Device list parsing error\n");
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		dev = iommu_group_find_device_by_name(token);
> +		if (!dev) {
> +			rdt_last_cmd_printf("No device %s\n", token);
> +			ret = -ENODEV;
> +			break;
> +		}
> +
> +		ret = rdtgroup_set_device(dev, rdtgrp);
> +		if (ret == -EOPNOTSUPP)
> +			rdt_last_cmd_printf("Device %s does not support QoS\n",
> +					    token);
> +		else if (ret)
> +			rdt_last_cmd_printf("Error while processing device %s\n",
> +					    token);
> +		/*
> +		 * rdtgroup_set_device() takes its own reference on a new
> +		 * rdtdev; drop the temporary reference returned by the
> +		 * lookup regardless of the outcome.
> +		 */
> +		put_device(dev);
> +		if (ret)
> +			break;
> +	}
> +
> +unlock:
> +	rdtgroup_kn_unlock(of->kn);
> +	return ret ?: nbytes;
> +}
> +
> +static int rdtgroup_devices_show(struct kernfs_open_file *of,
> +				 struct seq_file *s, void *v)
> +{
> +	struct rdtgroup *rdtgrp;
> +	struct rdtdev *rdtdev;
> +
> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> +	if (!rdtgrp) {
> +		rdtgroup_kn_unlock(of->kn);
> +		return -ENOENT;
> +	}
> +
> +	mutex_lock(&rdtdev_mutex);
> +	list_for_each_entry(rdtdev, &rdtdev_list, node)
> +		if (is_rmid_match_dev(rdtdev, rdtgrp) ||
> +		    is_closid_match_dev(rdtdev, rdtgrp))
> +			seq_printf(s, "%s\n", kobject_name(&rdtdev->dev->kobj));
> +	mutex_unlock(&rdtdev_mutex);
> +
> +	rdtgroup_kn_unlock(of->kn);
> +	return 0;
> +}
> +
>  static void rdt_move_group_devices(struct rdtgroup *from, struct rdtgroup *to)
>  {
>  	struct rdtdev *rdtdev;
> @@ -2295,6 +2381,14 @@ static struct rftype res_common_files[] = {
>  		.seq_show	= rdtgroup_tasks_show,
>  		.fflags		= RFTYPE_BASE,
>  	},
> +	{
> +		.name		= "devices",
> +		.mode		= 0644,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.write		= rdtgroup_devices_write,
> +		.seq_show	= rdtgroup_devices_show,
> +		.fflags		= RFTYPE_BASE,
> +	},
>  	{
>  		.name		= "mon_hw_id",
>  		.mode		= 0444,
> @@ -2363,6 +2457,13 @@ static int rdtgroup_add_files(struct kernfs_node *kn, unsigned long fflags)
>  
>  	for (rft = rfts; rft < rfts + len; rft++) {
>  		if (rft->fflags && ((fflags & rft->fflags) == rft->fflags)) {
> +			if (!strcmp(rft->name, "devices") &&
> +			    (!resctrl_arch_devices_supported() ||
> +			     ((fflags & RFTYPE_CTRL) &&
> +			      !resctrl_arch_alloc_capable()) ||
> +			     ((fflags & RFTYPE_MON) &&
> +			      !resctrl_arch_mon_capable())))
> +				continue;
>  			ret = rdtgroup_add_file(kn, rft);
>  			if (ret)
>  				goto error;

