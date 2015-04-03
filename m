From: "Li, ZhenHua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [PATCH v9 07/10] iommu/vt-d: enable kdump support in iommu module
Date: Fri, 03 Apr 2015 15:45:19 +0800
Message-ID: <551E450F.4030903@hp.com>
References: <1426743388-26908-1-git-send-email-zhen-hual@hp.com>
	<1426743388-26908-8-git-send-email-zhen-hual@hp.com>
	<20150402110608.GL4441@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150402110608.GL4441-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, tom.vaden-VXdhtT5mjnY@public.gmane.org, rwright-VXdhtT5mjnY@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lisa.mitchell-VXdhtT5mjnY@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "Li,
	ZhenHua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>, doug.hatch-VXdhtT5mjnY@public.gmane.org, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, billsumnerlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, li.zhang6-VXdhtT5mjnY@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,
Thinking about it carefully, I think you suggestions are very helpful, 
and the checks should be:
* All these things should be done in the second kernel, not only the 
kdump kernel. Sometimes user may use kexec manually start a new kernel.
* Copying those tables should only happen in the second kernel, only in 
this situation: iommu is enabled in both first and second kernel.

So, I think we can do this:
1. Use a new variable iommu_enabled_in_last_kernel;
2. When iommu module is loaded, it means the iommu is enabled in current 
kernel.  Then we check DMA_GSTS_TES:
    * if DMA_GSTS_TES is set, then it should be the second kernel(kexec 
starts this kernel manually, or it is kdump kernel), and the first 
kernel used iommu tables.  Here we need to copy these tables; then set 
iommu_enabled_in_last_kernel to 1.
    * if DMA_GSTS_TES is NOT set, then we do not need to care about 
these tables.

3. Replace all
#ifdef CONFIG_CRASH_DUMP
	if (is_kdump_kernel()) {
             // Do some thing
         }
#endif

To:
if (iommu_enabled_in_last_kernel) {
      // Do some thing
}

Do you agree with these?

Thanks
Zhenhua

On 04/02/2015 07:06 PM, Joerg Roedel wrote:
> On Thu, Mar 19, 2015 at 01:36:25PM +0800, Li, Zhen-Hua wrote:
>> +#ifdef CONFIG_CRASH_DUMP
>> +		if (is_kdump_kernel())
>> +			__iommu_update_old_root_entry(iommu, bus);
>> +#endif
>
> All the is_kdump_kernel checks in this patch (and maybe in other patches
> too) should really be checks whether translation on the IOMMU was
> enabled or not when the kernel booted. You might also boot from a kernel
> that had translation disabled into a kdump kernel that wants to enable
> it. In this case these checks would break.
>
> Speaking of booting from kernels with translation disabled, there is a
> valid use of is_kdump_enabled(), to omit iommu initialization in the
> kdump kernel when translation was disabled before. But the other checks
> should depend on the state the iommu had when booting the kdump kernel.
>
>
> 	Joerg
>
