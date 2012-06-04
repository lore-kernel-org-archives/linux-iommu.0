From: Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu: dmar: replace printks with appropriate pr_*()
Date: Mon, 04 Jun 2012 18:28:09 -0400
Message-ID: <4FCD3679.60706@redhat.com>
References: <1338845342-12464-1-git-send-email-ddutile@redhat.com>	
	<1338845342-12464-2-git-send-email-ddutile@redhat.com>
	<1338848137.18442.2.camel@joe2Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1338848137.18442.2.camel@joe2Laptop>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Cc: chrisw-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, suresh.b.siddha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, mingo-X9Un+BFzKDI@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 06/04/2012 06:15 PM, Joe Perches wrote:
> On Mon, 2012-06-04 at 17:29 -0400, Donald Dutile wrote:
>> Replace printk(KERN_*  with pr_*() functions.
>
> Please add
> #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> before any include and remove the embedded PREFIX
> from each printk
>
>> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
>
> []
>
>>   			break;
>>   		}
>>   		pdev = pci_get_slot(bus, PCI_DEVFN(path->dev, path->fn));
>>   		if (!pdev) {
>> -			printk(KERN_WARNING PREFIX
>> -			"Device scope device [%04x:%02x:%02x.%02x] not found\n",
>> +			pr_warn(PREFIX "Device scope device"
>> +				"[%04x:%02x:%02x.%02x] not found\n",
>>   				segment, bus->number, path->dev, path->fn);
>
> Please don't split any format string.  You removed
> a space between the scope device and an open bracket.
> It's OK for format strings to exceed 80 chars.
>
>
Joe,
Thanks for the feeback.  I'll incorporate the changes once
others have a chance to review & feedback as well.

- Don
