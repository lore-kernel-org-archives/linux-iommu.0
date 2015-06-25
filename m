From: "Li, ZhenHua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [PATCH 00/19] Fix Intel IOMMU breakage in kdump kernel
Date: Thu, 25 Jun 2015 14:35:53 +0800
Message-ID: <558BA149.5060603@hp.com>
References: <1434178047-17809-1-git-send-email-joro@8bytes.org>
	<1435066290.12045.2.camel@infradead.org>
	<20150623140631.GB2724@suse.de>
	<1435070334.12045.24.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1435070334.12045.24.camel-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Li, ZhenHua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jroedel-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 06/23/2015 10:38 PM, David Woodhouse wrote:
> On Tue, 2015-06-23 at 16:06 +0200, Joerg Roedel wrote:
>> On Tue, Jun 23, 2015 at 02:31:30PM +0100, David Woodhouse wrote:
>>> However, it's still fairly gratuitous for all non-broken hardware, and
>>> will tend to hide hardware and driver bugs during testing of new
>>> hardware.
>>>
>>> I'd much rather see this limited to a blacklist of known-broken
>>> devices, an accompanied by a kernel message along the lines of
>>>
>>>   'Preserving VT-d page tables for broken HP device xxxx:xxxx'
>>>
>>> For *any* device which isn't so broken that it craps itself on taking
>>> a DMA fault and cannot be reset, this page table copy shouldn't be
>>> needed, right?
>>
>> In theory yes, but as it came to my mind recently, there is this BIOS
>> "value-add" called APEI (ACPI Platform Error Interface) which has a
>> 'Firmware first' mode.
>>
>> So when this is active the firmware handles any errors happening in the
>> system and reports them to the OS with a severity it can decide on its
>> own.
>>
>> Such errors could be DMA target aborts, for example. And I have seen
>> systems where at least rejected interrupt requests were reported to the
>> OS as fatal errors, causing a kernel panic in Linux. But the firmware is
>> also free to report ordinary DMA failures as fatal errors, who knows...
>
> Yay for BIOS value subtract.
>
> The thing is, this would be utterly broken. The IOMMU is supposed to
> protect us from rogue devices. In this hypothetical scenario, a device
> can bring the entire system down and we have no chance to isolate it
> and recover. It means that assigning devices to guests should be
> *disallowed* because it can't be done securely.
>
> On this kind of system, we might as well turn off the IOMMU entirely as
> in a lot of respects, it's only making things *worse*.
>
>> So while you are right that these changes might hide hardware and driver
>> bugs, I think it is still the best to try avoiding such faults at all
>> costs in the kdump kernel to actually get a dump, even if the device
>> would actually be able to recover from the master abort.
>
> How about an *option* to do it for all devices (which in turn can
> perhaps be triggered by a system-level blacklist for things like APEI,
> or perhaps just a system DMI match on "HP").
>
Hi David,
It is a bad idea to check the DMI match on "HP". Though I have not see
any similar problems on other systems, I believe there are. Also not
all HP systems have such problem.
I agree with a blacklist for devices.

Thanks
Zhenhua
