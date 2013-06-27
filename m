From: Stuart Yoder <b08248-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 7/9] documentation: iommu: add description of ARM System
	MMU binding
Date: Thu, 27 Jun 2013 13:22:30 -0500
Message-ID: <CALRxmdD5fyp06xW+z=rWagJc_bcJmpr1H9Zbdf=xbg9cCzvVfw@mail.gmail.com>
References: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
	<1370889285-22799-8-git-send-email-will.deacon@arm.com>
	<CALRxmdBxFWoRKv+bUu8VEwNNcAJUej9jM2V8N0rrqrr_Vpe8fQ@mail.gmail.com>
	<20130626133941.GD7417@mudshark.cambridge.arm.com>
	<CALRxmdCycFK2wW=C4aU79mudSaT+2vU8nzXxepdstubg+YSdQg@mail.gmail.com>
	<20130626174231.GH10333@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130626174231.GH10333-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org Discuss" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jun 26, 2013 at 12:42 PM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> On Wed, Jun 26, 2013 at 05:19:48PM +0100, Stuart Yoder wrote:
>> On Wed, Jun 26, 2013 at 8:39 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
>> > I'd suggest looking at the driver I posted to get a gist of how the parsing
>> > code works, but suffice to say that we describe both the number of
>> > interrupts and the actual interrupt numbers here.
>>
>> I understand that the number of interrupts and actual interrupt numbers
>> are described here, but was referring to the _meaning_ of the interrupt
>> numbers.   A binding for a device with 2 interrupts, a TX and RX would
>> normally identify which interrupt specifier is for TX and which is for RX.
>>
>> Based on your code, the 2 global interrupts seem to be the secure
>> and non-secure fault interrupts...which your driver does not differentiate.
>> However, the device tree is describing hardware and  you can't assume
>> that all drivers don't care which is which.
>
> Currently, the driver only works when Linux is running as non-secure, which is
> becoming more and more common since it is required to be able to make use of
> hyp mode.
>
> There are actually two global interrupts for SMMUv1 and SMMUv2, which
> correspond to configuration faults and `other' global faults.

So, why don't we define which interrupt is which in this binding?
...e.g. "The first
interrupt specifier is for the configuration access fault interrupt, the second
interrupt specifier is for other global faults."

How else is software supposed to know which interrupt corresponds to what
event.

Thanks,
Stuart
