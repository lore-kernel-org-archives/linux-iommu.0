From: Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
Subject: Re: [PATCH 7/7] iommu: introduce per-cpu caching to iova allocation
Date: Wed, 13 Apr 2016 14:38:19 +0300
Message-ID: <CAHMfzJmn4WMe+6t8-0hNUHr0agxAcVW4aUzmo5uw_h1v=kA-xw@mail.gmail.com>
References: <20151228161743.GA27929@cs.technion.ac.il>
	<CAN+hb0W=jo00enS_GY7fxHQLD5hrJjP77yf7NyREK_wY90yixw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAN+hb0W=jo00enS_GY7fxHQLD5hrJjP77yf7NyREK_wY90yixw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Dan Tsafrir <dan-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>, Omer Peleg <omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 12, 2016 at 12:54 AM, Benjamin Serebrin via iommu
<iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org> wrote:

>> +/*
>> + * Magazine caches for IOVA ranges.  For an introduction to magazines,
>> + * see the USENIX 2001 paper "Magazines and Vmem: Extending the Slab
>> + * Allocator to Many CPUs and Arbitrary Resources" by Bonwick and Adams.
>
> My colleague gvdl@google suggests: It'd be nice to insert some
> comments on the ways the code here diverges from the paper.  (For
> example, the magazines aren't pre-populated.)

I'll describe any such changes.  But I don't think the paper says
magazine are pre-populated: "We never allocate full magazines
explicitly [...] it suffices to create empty magazines and let full
ones emerge as a side effect of normal allocation/free traffic"
(Section 3.3).

>> + */
>> +
>> +#define IOVA_MAG_SIZE 128
>
> Does this belong in iova.h?

It's an implementation detail and not part of the public interface, so
I'd rather keep it here.

Thanks for all the reviews!
