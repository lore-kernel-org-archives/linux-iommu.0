From: Takao Indoh <indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: Re: [PATCH v2] PCI: Reset PCIe devices to stop ongoing DMA
Date: Mon, 29 Jul 2013 09:20:21 +0900
Message-ID: <51F5B545.5050300@jp.fujitsu.com>
References: <1368509365-2260-1-git-send-email-indou.takao@jp.fujitsu.com>
	<CAErSpo4t_2Xw76p3Z9FVzyyK-MBovavDu9D=pYoPMjESSxgT=w@mail.gmail.com>
	<51B19DF3.2070009@jp.fujitsu.com>
	<CAErSpo6dfEnzriHD_aWZB_3E-kSzauhNRHPd+VuFX5HONVKgqw@mail.gmail.com>
	<51B6BEDB.3000509@jp.fujitsu.com>
	<CAErSpo5u8qGALt6C+tuPYXdd2YgyMH6fnPnA+afUteEZ7kY0iw@mail.gmail.com>
	<51B93221.2040505@jp.fujitsu.com>
	<CAErSpo5tVK-Z3aOdMTzab-S8o5zLVtDOFQ8-LSYpUgbrJSsxuw@mail.gmail.com>
	<51BA7BB6.1080104@jp.fujitsu.com> <51EF7466.20703@jp.fujitsu.com>
	<20130725142446.GK11993@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130725142446.GK11993-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hbabu-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, bill.sumner-VXdhtT5mjnY@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

(2013/07/25 23:24), Vivek Goyal wrote:
> On Wed, Jul 24, 2013 at 03:29:58PM +0900, Takao Indoh wrote:
>> Sorry for letting this discussion slide, I was busy on other works:-(
>> Anyway, the summary of previous discussion is:
>> - My patch adds new initcall(fs_initcall) to reset all PCIe endpoints on
>>    boot. This expects PCI enumeration is done before IOMMU
>>    initialization as follows.
>>      (1) PCI enumeration
>>      (2) fs_initcall ---> device reset
>>      (3) IOMMU initialization
>> - This works on x86, but does not work on other architecture because
>>    IOMMU is initialized before PCI enumeration on some architectures. So,
>>    device reset should be done where IOMMU is initialized instead of
>>    initcall.
>> - Or, as another idea, we can reset devices in first kernel(panic kernel)
>>
>> Resetting devices in panic kernel is against kdump policy and seems not to
>> be good idea. So I think adding reset code into iommu initialization is
>> better. I'll post patches for that.
> 
> I don't understand all the details but I agree that idea of trying to
> reset IOMMU in crashed kernel might not fly.
> 
>>
>> Another discussion point is how to handle buggy devices. Resetting buggy
>> devices makes system more unstable. One of ideas is using boot parameter
>> so that user can choose to reset devices or not.
> 
> So who would decide which device is buggy and don't reset it. Give
> some details here.

I found the case that kdump does not work after resetting devices and
it works when removing reset patch. The cause of problem is a bug of
PCIe switch chip. If there is boot parameter not to reset devices,
user can use it as workaround.

I think in this case we should add PCI quirk to avoid this buggy
hardware, but we need to wait errata from vendor and it basically takes
long time.

> 
> Can't we simply blacklist associated module, so that it never loads
> and then it never tries to reset the devices?
> 

So you mean that device reset should be done on its driver loading?

Thanks,
Takao Indoh
