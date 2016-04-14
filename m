From: Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
Subject: Re: [PATCH v2 7/7] iommu: introduce per-cpu caching to iova allocation
Date: Fri, 15 Apr 2016 00:05:37 +0300
Message-ID: <CAHMfzJmjZWeUpmTVb-Z7NMJUp0N84ZK4zwUWdAKHv4sd4TXPMg@mail.gmail.com>
References: <cover.1460548546.git.mad@cs.technion.ac.il>
	<b208a304d83088aae7ecac10a3062dc57c0a2f79.1460548546.git.mad@cs.technion.ac.il>
	<CAN+hb0W=+tuQp3cm_VKoU=LKiVQDPMtGrZGq=59rcaWsy2S-+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAN+hb0W=+tuQp3cm_VKoU=LKiVQDPMtGrZGq=59rcaWsy2S-+A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Benjamin Serebrin <serebrin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Dan Tsafrir <dan-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>, Omer Peleg <omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Shaohua Li <shli-b10kYP2dOMg@public.gmane.org>, Godfrey van der Linden <gvdl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Kernel-team-b10kYP2dOMg@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Apr 14, 2016 at 9:26 PM, Benjamin Serebrin via iommu
<iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org> wrote:

> It was pointed out that DMA_32 or _24 (or anything other non-64 size)
> could be starved if the magazines on all cores are full and the depot
> is empty.  (This gets more probable with increased core count.)  You
> could try one more time: call free_iova_rcaches() and try alloc_iova
> again before giving up

That's not safe, unfortunately.  free_iova_rcaches() is meant to be
called only when the domain is dying and the CPUs won't access the
rcaches.

It's tempting to make the rcaches work only for DMA_64 allocations.
This would also solve the problem of respecting the pfn_limit when
allocating, which Shaohua Li pointed out.  Sadly, intel-iommu.c
converts DMA_64 to DMA_32 by default, apparently to avoid dual address
cycles on the PCI bus.  I wonder about the importance of this, though,
as it doesn't seem that anything equivalent happens when iommu=off.
