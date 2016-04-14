From: Benjamin Serebrin via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH v2 7/7] iommu: introduce per-cpu caching to iova allocation
Date: Thu, 14 Apr 2016 14:18:32 -0700
Message-ID: <CAN+hb0WOaokFYc6C+mR6rdj4WwmMUSzDHDZngfUvy-5cEve_-g@mail.gmail.com>
References: <cover.1460548546.git.mad@cs.technion.ac.il>
	<b208a304d83088aae7ecac10a3062dc57c0a2f79.1460548546.git.mad@cs.technion.ac.il>
	<CAN+hb0W=+tuQp3cm_VKoU=LKiVQDPMtGrZGq=59rcaWsy2S-+A@mail.gmail.com>
	<CAHMfzJmjZWeUpmTVb-Z7NMJUp0N84ZK4zwUWdAKHv4sd4TXPMg@mail.gmail.com>
Reply-To: Benjamin Serebrin <serebrin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAHMfzJmjZWeUpmTVb-Z7NMJUp0N84ZK4zwUWdAKHv4sd4TXPMg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
Cc: Dan Tsafrir <dan-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>, Omer Peleg <omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Shaohua Li <shli-b10kYP2dOMg@public.gmane.org>, Godfrey van der Linden <gvdl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Kernel-team-b10kYP2dOMg@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Apr 14, 2016 at 2:05 PM, Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org> wrote:
> On Thu, Apr 14, 2016 at 9:26 PM, Benjamin Serebrin via iommu
> <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org> wrote:
>
>> It was pointed out that DMA_32 or _24 (or anything other non-64 size)
>> could be starved if the magazines on all cores are full and the depot
>> is empty.  (This gets more probable with increased core count.)  You
>> could try one more time: call free_iova_rcaches() and try alloc_iova
>> again before giving up
>
> That's not safe, unfortunately.  free_iova_rcaches() is meant to be
> called only when the domain is dying and the CPUs won't access the
> rcaches.

Fair enough.  Is it possible to make this safe, cleanly and without
too much locking during the normal case?

> It's tempting to make the rcaches work only for DMA_64 allocations.
> This would also solve the problem of respecting the pfn_limit when
> allocating, which Shaohua Li pointed out.  Sadly, intel-iommu.c
> converts DMA_64 to DMA_32 by default, apparently to avoid dual address
> cycles on the PCI bus.  I wonder about the importance of this, though,
> as it doesn't seem that anything equivalent happens when iommu=off.

I agree.  It's tempting to make all DMA_64 allocations grow up from
4G, leaving the entire 32 bit space free for small allocations.  I'd
be willing to argue that that should be the default, with some
override for anyone who finds it objectionable.

Dual address cycle is really "4 more bytes in the TLP header" on PCIe;
a 32-bit address takes 3 doublewords (12 bytes) while a 64-bit address
takes 4 DW (16 bytes).  What's 25% of a read request between friends?
And every read request has a read response 3DW TLP plus its data, so
the aggregate bandwidth consumed is getting uninteresting.  Similarly
for writes, the additional address bytes don't cost a large
percentage.

That being said, it's a rare device that needs more than 4GB of active
address space, and it's a rare system that needs to mix a
performance-critical DMA_32 (or 24) and _64 device in the same page
table.
