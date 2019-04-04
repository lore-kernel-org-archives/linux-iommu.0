From: Khalid Aziz <khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH v9 12/13] xpfo, mm: Defer TLB flushes for non-current
	CPUs (x86 only)
Date: Thu, 4 Apr 2019 16:55:48 -0600
Message-ID: <91f1dbce-332e-25d1-15f6-0e9cfc8b797b@oracle.com>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
	<4495dda4bfc4a06b3312cc4063915b306ecfaecb.1554248002.git.khalid.aziz@oracle.com>
	<CALCETrXMXxnWqN94d83UvGWhkD1BNWiwvH2vsUth1w0T3=0ywQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CALCETrXMXxnWqN94d83UvGWhkD1BNWiwvH2vsUth1w0T3=0ywQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, steven.sistare-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Tycho Andersen <tycho-E0fblnxP3wo@public.gmane.org>, Andi Kleen <ak-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, aneesh.kumar-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org, James Morris <jmorris-gx6/JNMH7DfYtjvyW6yDsg@public.gmane.org>, David Rientjes <rientjes-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, anthony.yznaga-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, Rik van Riel <riel-ebMLmSuQjDVBDgjK7y7TUQ@public.gmane.org>, Nicholas Piggin <npiggin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mike Rapoport <rppt-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Souptick Joarder <jrdr.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, arunks-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "Woodhouse, David" <dwmw-vV1OtcyAfmbQXOPxS62xeg@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:DOCUMENTATION" <linux-doc@vger.k>
List-Id: iommu@lists.linux-foundation.org

On 4/3/19 10:10 PM, Andy Lutomirski wrote:
> On Wed, Apr 3, 2019 at 10:36 AM Khalid Aziz <khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org> wrote:
>>
>> XPFO flushes kernel space TLB entries for pages that are now mapped
>> in userspace on not only the current CPU but also all other CPUs
>> synchronously. Processes on each core allocating pages causes a
>> flood of IPI messages to all other cores to flush TLB entries.
>> Many of these messages are to flush the entire TLB on the core if
>> the number of entries being flushed from local core exceeds
>> tlb_single_page_flush_ceiling. The cost of TLB flush caused by
>> unmapping pages from physmap goes up dramatically on machines with
>> high core count.
>>
>> This patch flushes relevant TLB entries for current process or
>> entire TLB depending upon number of entries for the current CPU
>> and posts a pending TLB flush on all other CPUs when a page is
>> unmapped from kernel space and mapped in userspace. Each core
>> checks the pending TLB flush flag for itself on every context
>> switch, flushes its TLB if the flag is set and clears it.
>> This patch potentially aggregates multiple TLB flushes into one.
>> This has very significant impact especially on machines with large
>> core counts.
> 
> Why is this a reasonable strategy?

Ideally when pages are unmapped from physmap, all CPUs would be sent IPI
synchronously to flush TLB entry for those pages immediately. This may
be ideal from correctness and consistency point of view, but it also
results in IPI storm and repeated TLB flushes on all processors. Any
time a page is allocated to userspace, we are going to go through this
and it is very expensive. On a 96-core server, performance degradation
is 26x!!

When xpfo unmaps a page from physmap only (after mapping the page in
userspace in response to an allocation request from userspace) on one
processor, there is a small window of opportunity for ret2dir attack on
other cpus until the TLB entry in physmap for the unmapped pages on
other cpus is cleared. Forcing that to happen synchronously is the
expensive part. A multiple of these requests can come in over a very
short time across multiple processors resulting in every cpu asking
every other cpusto flush TLB just to close this small window of
vulnerability in the kernel. If each request is processed synchronously,
each CPU will do multiple TLB flushes in short order. If we could
consolidate these TLB flush requests instead and do one TLB flush on
each cpu at the time of context switch, we can reduce the performance
impact significantly. This bears out in real life measuring the system
time when doing a parallel kernel build on a large server. Without this,
system time on 96-core server when doing "make -j60 all" went up 26x.
After this optimization, impact went down to 1.44x.

The trade-off with this strategy is, the kernel on a cpu is vulnerable
for a short time if the current running processor is the malicious
process. Is that an acceptable trade-off?

I am open to other ideas on reducing the performance impact due to xpfo.

> 
>> +void xpfo_flush_tlb_kernel_range(unsigned long start, unsigned long end)
>> +{
>> +       struct cpumask tmp_mask;
>> +
>> +       /*
>> +        * Balance as user space task's flush, a bit conservative.
>> +        * Do a local flush immediately and post a pending flush on all
>> +        * other CPUs. Local flush can be a range flush or full flush
>> +        * depending upon the number of entries to be flushed. Remote
>> +        * flushes will be done by individual processors at the time of
>> +        * context switch and this allows multiple flush requests from
>> +        * other CPUs to be batched together.
>> +        */
> 
> I don't like this function at all.  A core function like this is a
> contract of sorts between the caller and the implementation.  There is
> no such thing as an "xpfo" flush, and this function's behavior isn't
> at all well defined.  For flush_tlb_kernel_range(), I can tell you
> exactly what that function does, and the implementation is either
> correct or incorrect.  With this function, I have no idea what is
> actually required, and I can't possibly tell whether it's correct.
> 
> As far as I can see, xpfo_flush_tlb_kernel_range() actually means
> "flush this range on this CPU right now, and flush it on remote CPUs
> eventually".  It would be valid, but probably silly, to flush locally
> and to never flush at all on remote CPUs.  This makes me wonder what
> the point is.
> 

I would restate that as "flush this range on this cpu right now, and
flush it on remote cpus at the next context switch". A better name for
the routine and a better description is a reasonable change to make.

Thanks,
Khalid
