From: "Li, ZhenHua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [PATCH v11 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
Date: Wed, 10 Jun 2015 17:32:29 +0800
Message-ID: <5578042D.9050407@hp.com>
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
	<1433773583.2952.52.camel@infradead.org>
	<20150608152957.GW20384@8bytes.org>
	<1433778624.2952.82.camel@infradead.org>
	<20150608161315.GX20384@8bytes.org>
	<1433854550.19447.15.camel@infradead.org>
	<20150610092150.GZ20384@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150610092150.GZ20384-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, tom.vaden-VXdhtT5mjnY@public.gmane.org, rwright-VXdhtT5mjnY@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lisa.mitchell-VXdhtT5mjnY@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "Li,
	ZhenHua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>, doug.hatch-VXdhtT5mjnY@public.gmane.org, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, billsumnerlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, li.zhang6-VXdhtT5mjnY@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 06/10/2015 05:21 PM, Joerg Roedel wrote:
> On Tue, Jun 09, 2015 at 01:55:50PM +0100, David Woodhouse wrote:
>> On Mon, 2015-06-08 at 18:13 +0200, Joerg Roedel wrote:
>>> So I think we need to read out that bit when we find translation enabled
>>> and if it is different from what we would set it to, we bail out of any
>>> copying, disable translation and proceed as in a normal boot.
>>
>> Given that this is only for kdump and not the general case of kexec,
>> that's probably tolerable. Of course we do still need to make it *not*
>> broken for the case where DMA_RTADDR_RTT is set, as it is at the
>> moment.
>
> Yes, I just sent a patch for this and will include it into my x86/vt-d
> branch if not objections come in.
>
>> And I suspect if we're doing that, it might be simple enough to make it
>> convert to/from the extended page tables. I don't think we want to
>> preserve PASID tables; only the "second level" (i.e. traditional)
>> translation. So we could happily pull the page table pointer out of
>> either kind of context entry, and install it into either kind. I think
>> there's a simple mapping of translation types too. I need to sort out
>> the translation types when adding the real PASID support (imminently!)
>> anyway.
>
> What happens when we take away the PASID tables from a device? Can it
> also go into some failure state?
> When doing this, we need at least setup the page request queue before we
> copy over anything and change the root-entry. Then we can handle any
> faults that are caused by this and tell the device to not try further.
>
>
> 	Joerg
>
Is PASID part of new specs? Is there any plan to upgrade the driver to 
support the latest vt-d specs?

Zhenhua
