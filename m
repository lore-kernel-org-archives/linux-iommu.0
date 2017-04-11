From: Sunil Kovvuri <sunil.kovvuri-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 3/7] iommu/arm-smmu-v3: Introduce smmu option
	USE_SHARED_IRQS for Silicon errata
Date: Tue, 11 Apr 2017 22:04:41 +0530
Message-ID: <CA+sq2Cev1r3AWpWTsfUqZaJW-h9XkctYGrGe4C9XOW5kqkcRkQ@mail.gmail.com>
References: <1491921765-29475-1-git-send-email-linucherian@gmail.com>
	<1491921765-29475-4-git-send-email-linucherian@gmail.com>
	<b84e2383-1a65-3c5a-8e2c-28eafdb20adc@arm.com>
	<20170411162123.GF17109@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170411162123.GF17109-5wv7dgnIgG8@public.gmane.org>
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
Cc: "Goutham, Sunil" <Sunil.Goutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, sudeep.holla-5wv7dgnIgG8@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linucherian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Geethasowjanya.Akula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, robert.richter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, Geetha <gakula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, LAKML <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 11, 2017 at 9:51 PM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> On Tue, Apr 11, 2017 at 04:54:26PM +0100, Robin Murphy wrote:
>> On 11/04/17 15:42, linucherian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
>> > From: Geetha <gakula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>> >
>> > Cavium 99xx SMMU implementation doesn't not support unique irq lines for
>> > gerror, eventq and cmdq-sync. USE_SHARED_IRQS option enables to use single
>> > irq line for all three interrupts.
>>
>> AFAICS, there's nothing actually wrong with using shared wired IRQs -
>> the architecture spec doesn't appear to say anything about it. I think
>> it might suffice to simply add IRQF_SHARED if we can see the SMMU
>> doesn't support MSIs anyway - it doesn't really seem like something we
>> need to treat as a specific quirk.
>
> No, this is not permitted by the spec. See 3.18.2 ("Interrupt sources"),
> where it's clear that each source asserts a *unique* wired interrupt.
>
> Geetha: does your implementation support MSIs?
>
> Will

No, this silicon doesn't support MSIs.

Thanks,
Sunil.
