From: Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: RFC: IOMMU/AMD: Error Handling
Date: Tue, 30 Apr 2013 11:09:08 -0400
Message-ID: <517FDE94.7080700@redhat.com>
References: <517ECDDA.3000606@amd.com> <517ED3A9.2050508@redhat.com>
	<BA42942F2D0DED45AFB0A6216D1E951D44CBE1F9@sausexdag01.amd.com>
	<517EE940.8010005@redhat.com> <517FDB96.7060602@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <517FDB96.7060602-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Suravee Suthikulanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 04/30/2013 10:56 AM, Suravee Suthikulanit wrote:
> On 4/29/2013 4:42 PM, Don Dutile wrote:
>> On 04/29/2013 04:34 PM, Duran, Leo wrote:
>>> I'm wondering if resetting the IOMMU at init-time (once) would clear any BIOS induced noise.
>>> Leo
>>>
>> Well, depends what you mean by 'reset'....
>> (a) setting it up for OS use is effectively a reset, but doesn't quiesce a device
>> doing dma reads of a (bios-setup) queue. then the noisy messages begin
>> (b) disable the iommu, and then the dma just occurs... and bad for writes, potentially.
>>
>> Similar issue is being reported & worked for kdump, where device are still
>> doing DMA while the system is trying to 'reset' to the kexec'd kernel, and
>> take a crash dump.
>>
>> Solution: stop devices from doing dma... but some you _want_ enabled throughout...
>> like keyboard & mouse via usb controller, so you get to pick os from
>> grub... not so for kexec...
>>
>> so, again, for isolation faults.... let the hw do its job -- isolate
>> and throttle/silence the fault messages on a per-device, time-duration heuristic
>> so the system can get through boot-up where enough OS is init'd (drivers started)
>> to stop the temporary noise.
> This sounds more like issue with the order of how things are initialized in the system.
> If so, could we separate the code which enabling of IOMMU error logging/handling and
> delay it until we are certain that systems are stable?
>
So, you are proposing we not enable fault events when IOMMU is initially configured;
use the IOMMU through boot/driver-config, hoping all is well, and if not, continue blindly,
and then enable IOMMU faults post/late-init ?

> Suravee
>
