From: Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
Subject: Re: [PATCH V2 0/4]IOMMU: avoid lock contention in iova allocation
Date: Fri, 22 Jan 2016 13:35:52 +0200
Message-ID: <CAHMfzJn8Lf29-Ph9kJf5QrPAT2SLg+xkFsv9bp3snXzxx6-8hw@mail.gmail.com>
References: <cover.1452297604.git.shli@fb.com>
	<20160110225610.GA16778@cs.technion.ac.il>
	<20160111033749.GA1811285@devbig084.prn1.facebook.com>
	<20160120122103.GE18805@8bytes.org>
	<20160120180956.GA230160@devbig084.prn1.facebook.com>
	<CAHMfzJmAUWT8X4492_84smUgQMW9pW1yNfOxC6e7ur9TitA2cA@mail.gmail.com>
	<20160120211421.GA684235@devbig084.prn1.facebook.com>
	<20160121231326.GA16905@cs.technion.ac.il>
	<20160122001801.GA4114061@devbig084.prn1.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160122001801.GA4114061-tb7CFzD8y5b7E6g3fPdp/g2O0Ztt9esIQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Shaohua Li <shli-b10kYP2dOMg@public.gmane.org>
Cc: Kernel-team-b10kYP2dOMg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jan 22, 2016 at 2:18 AM, Shaohua Li <shli-b10kYP2dOMg@public.gmane.org> wrote:

> Yes, I know a typical per-cpu cache algorithm will free entry to the
> per-cpu cache first. I didn't do it because it's not worthy in my test.
> We definitely should do it if it's worthy though. My point is we don't
> need implement the per-cpu that complicated. It could be simply:
>
> alloc:
>  - refill per-cpu cache if it's empty
>  - alloc from per-cpu cache
>
> free
>  - free to per-cpu cache
>  - if per-cpu cache hits threshold, free to global

It seems that in a workload in which a cpu does an alloc followed by a
free, this will access the global allocator every time, which makes
the cache useless.  The magazines algorithm we use solves these
thrashing problems, that's why it's slightly more complicated.  See
Section 3 in https://www.usenix.org/legacy/event/usenix01/bonwick.html
for details.

My point is that per-cpu caching of a global allocator is a well-known
problem with standard solutions, which our patch adopts.  We could
keep iterating here, but to solve all the issues that magazines solve,
we'll probably end up with similar complexity.
