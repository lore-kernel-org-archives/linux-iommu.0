From: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] PCI: Reset PCIe devices to stop ongoing DMA
Date: Tue, 11 Jun 2013 22:45:27 -0600
Message-ID: <CAErSpo5u8qGALt6C+tuPYXdd2YgyMH6fnPnA+afUteEZ7kY0iw@mail.gmail.com>
References: <1368509365-2260-1-git-send-email-indou.takao@jp.fujitsu.com>
	<CAErSpo4t_2Xw76p3Z9FVzyyK-MBovavDu9D=pYoPMjESSxgT=w@mail.gmail.com>
	<51B19DF3.2070009@jp.fujitsu.com>
	<CAErSpo6dfEnzriHD_aWZB_3E-kSzauhNRHPd+VuFX5HONVKgqw@mail.gmail.com>
	<51B6BEDB.3000509@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <51B6BEDB.3000509-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Takao Indoh <indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Cc: "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Haren Myneni <hbabu-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, bill.sumner-VXdhtT5mjnY@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

[+cc Vivek, Haren; sorry I didn't think to add you earlier]

On Tue, Jun 11, 2013 at 12:08 AM, Takao Indoh
<indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org> wrote:
> (2013/06/11 11:20), Bjorn Helgaas wrote:

>> I'm not sure you need to reset legacy devices (or non-PCI devices)
>> yet, but the current hook isn't anchored anywhere -- it's just an
>> fs_initcall() that doesn't give the reader any clue about the
>> connection between the reset and the problem it's solving.
>>
>> If we do something like this patch, I think it needs to be done at the
>> point where we enable or disable the IOMMU.  That way, it's connected
>> to the important event, and there's a clue about how to make
>> corresponding fixes for other IOMMUs.
>
> Ok. pci_iommu_init() is appropriate place to add this hook?

I looked at various IOMMU init places today, and it's far more
complicated and varied than I had hoped.

This reset scheme depends on enumerating PCI devices before we
initialize the IOMMU used by those devices.  x86 works that way today,
but not all architectures do (see the sparc pci_fire_pbm_init(), for
example).  And I think conceptually, the IOMMU should be enumerated
and initialized *before* the devices that use it.

So I'm uncomfortable with that aspect of this scheme.

It would be at least conceivable to reset the devices in the system
kernel, before the kexec.  I know we want to do as little as possible
in the crashing kernel, but it's at least a possibility, and it might
be cleaner.

Bjorn
