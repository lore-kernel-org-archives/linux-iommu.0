From: "Li, ZhenHua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [PATCH 0/5] iommu/vt-d: Fix crash dump failure caused by legacy
	DMA/IO
Date: Mon, 01 Dec 2014 14:31:38 +0800
Message-ID: <547C0B4A.4060303@hp.com>
References: <1413878659-1383-1-git-send-email-zhen-hual@hp.com>
	<20141022100525.GD9060@dhcp-16-116.nay.redhat.com>
	<545ACF66.9050509@jp.fujitsu.com> <545AD061.4000102@hp.com>
	<545AD353.8060207@jp.fujitsu.com> <545AD8D3.90709@hp.com>
	<545B2885.8070009@jp.fujitsu.com> <545B2C07.1070701@hp.com>
	<5465A0E0.4020001@hp.com> <20141117133858.GA31920@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20141117133858.GA31920-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, tom.vaden-VXdhtT5mjnY@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lisa.mitchell-VXdhtT5mjnY@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, doug.hatch-VXdhtT5mjnY@public.gmane.org, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, li.zhang6-VXdhtT5mjnY@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Joerg,

After I implement these two steps, there comes a new fault:

[1.594890] dmar: DRHD: handling fault status reg 2
[1.594894] dmar: INTR-REMAP: Request device [[41:00.0] fault index 4d
[1.594894] INTR-REMAP:[fault reason 34] Present field in the IRTE entry
is clear

It is caused by similar reason, so I will fix it like fixing the DMAR
faults: Do NOT disable and re-enable the interrupt remapping, try to
use data from old kernel.


Thanks
Zhenhua

On 11/17/2014 09:38 PM, Joerg Roedel wrote:
> On Fri, Nov 14, 2014 at 02:27:44PM +0800, Li, ZhenHua wrote:
>> I am working following  your directions:
>>
>> 1.  If the VT-d driver finds the IOMMU enabled, it reuses its root entry
>> table, and do NOT disable-enable iommu. Other data will be copied.
>>
>> 2. When a device driver issues the first dma_map command for a
>> device, we assign a new and empty page-table, thus removing all
>> mappings from the old kernel for the device.
>>
>> Please let me know if I get something wrong.
>
> Yes, this sounds right. Happily waiting for patches :)
>
>
> 	Joerg
>
