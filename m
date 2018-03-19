From: Yisheng Xie <xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 37/37] vfio: Add support for Shared Virtual Addressing
Date: Mon, 19 Mar 2018 17:47:15 +0800
Message-ID: <e3ae1693-0ed8-65e1-352a-07f79038dcbd@huawei.com>
References: <1519280641-30258-1-git-send-email-xieyisheng1@huawei.com>
	<1519280641-30258-37-git-send-email-xieyisheng1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1519280641-30258-37-git-send-email-xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Sudeep Holla <Sudeep.Holla-5wv7dgnIgG8@public.gmane.org>, christian.koenig-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Jean,

vfio can be compiled as module, however you use some functions which are not
exported.

comment inline:

[...]
> Add two new ioctl for VFIO containers. VFIO_IOMMU_BIND_PROCESS creates a
> bond between a container and a process address space, identified by a
> device-specific ID named PASID. This allows the device to target DMA
> transactions at the process virtual addresses without a need for mapping
> and unmapping buffers explicitly in the IOMMU. The process page tables are
> shared with the IOMMU, and mechanisms such as PCI ATS/PRI are used to
> handle faults. VFIO_IOMMU_UNBIND_PROCESS removes a bond created with
> VFIO_IOMMU_BIND_PROCESS.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
> ---
[...]
> +static struct mm_struct *vfio_iommu_get_mm_by_vpid(pid_t vpid)
> +{
> +	struct mm_struct *mm;
> +	struct task_struct *task;
> +
> +	rcu_read_lock();
> +	task = find_task_by_vpid(vpid);

Maybe can use?
	task = pid_task(find_vpid(params.vpid), PIDTYPE_PID)

> +	if (task)
> +		get_task_struct(task);
> +	rcu_read_unlock();
> +	if (!task)
> +		return ERR_PTR(-ESRCH);
> +
> +	/* Ensure that current has RW access on the mm */
> +	mm = mm_access(task, PTRACE_MODE_ATTACH_REALCREDS);

You will try to export mm_access, I find Felix have tried to, but seems give up:

 https://patchwork.kernel.org/patch/9744281/

Thanks
Yisheng
