From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 37/37] vfio: Add support for Shared Virtual Addressing
Date: Wed, 21 Mar 2018 13:40:13 +0000
Message-ID: <09ecbaf4-477c-1a06-4f37-523391e5b92e@arm.com>
References: <1519280641-30258-1-git-send-email-xieyisheng1@huawei.com>
	<1519280641-30258-37-git-send-email-xieyisheng1@huawei.com>
	<e3ae1693-0ed8-65e1-352a-07f79038dcbd@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <e3ae1693-0ed8-65e1-352a-07f79038dcbd-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yisheng Xie <xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org" <bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org" <rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, "lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, rjw-LthD3rsA81gHJAlzAAQw8A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 19/03/18 09:47, Yisheng Xie wrote:
> Hi Jean,
> 
> vfio can be compiled as module, however you use some functions which are not
> exported.

Oh right. I remember the kbuild test robot warning about this once, I
wonder why it didn't find this one.

> comment inline:
> 
> [...]
>> Add two new ioctl for VFIO containers. VFIO_IOMMU_BIND_PROCESS creates a
>> bond between a container and a process address space, identified by a
>> device-specific ID named PASID. This allows the device to target DMA
>> transactions at the process virtual addresses without a need for mapping
>> and unmapping buffers explicitly in the IOMMU. The process page tables are
>> shared with the IOMMU, and mechanisms such as PCI ATS/PRI are used to
>> handle faults. VFIO_IOMMU_UNBIND_PROCESS removes a bond created with
>> VFIO_IOMMU_BIND_PROCESS.
>>
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
>> ---
> [...]
>> +static struct mm_struct *vfio_iommu_get_mm_by_vpid(pid_t vpid)
>> +{
>> +	struct mm_struct *mm;
>> +	struct task_struct *task;
>> +
>> +	rcu_read_lock();
>> +	task = find_task_by_vpid(vpid);
> 
> Maybe can use?
> 	task = pid_task(find_vpid(params.vpid), PIDTYPE_PID)

I'd rather submit a patch requesting to export the symbol. Especially
since this function can be further simplified by using the brand new
find_get_task_by_vpid() helper, introduced by 2ee0826085d1.

>> +	if (task)
>> +		get_task_struct(task);
>> +	rcu_read_unlock();
>> +	if (!task)
>> +		return ERR_PTR(-ESRCH);
>> +
>> +	/* Ensure that current has RW access on the mm */
>> +	mm = mm_access(task, PTRACE_MODE_ATTACH_REALCREDS);
> 
> You will try to export mm_access, I find Felix have tried to, but seems give up:
> 
>  https://patchwork.kernel.org/patch/9744281/

Thanks for the pointer, I'll try to revive this.

Thanks,
Jean
