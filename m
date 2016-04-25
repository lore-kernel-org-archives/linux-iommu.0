From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 4/7] io-64-nonatomic: Add relaxed accessor variants
Date: Mon, 25 Apr 2016 14:32:42 +0100
Message-ID: <20160425133242.GC30830@arm.com>
References: <cover.1460391217.git.robin.murphy@arm.com>
	<44173fd4e8efd27d670cadc6b30e215243a14099.1460391217.git.robin.murphy@arm.com>
	<20160421161859.GK929@arm.com> <571A5A9E.7040305@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <571A5A9E.7040305-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Hitoshi Mitake <mitake.hitoshi-Zyj7fXuS5i5L9jVzuh4AOg@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, brian.starkey-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Apr 22, 2016 at 06:08:46PM +0100, Robin Murphy wrote:
> On 21/04/16 17:18, Will Deacon wrote:
> >On Wed, Apr 13, 2016 at 06:13:00PM +0100, Robin Murphy wrote:
> >>Whilst commit 9439eb3ab9d1 ("asm-generic: io: implement relaxed
> >>accessor macros as conditional wrappers") makes the *_relaxed forms of
> >>I/O accessors universally available to drivers, in cases where writeq()
> >>is implemented via the io-64-nonatomic helpers, writeq_relaxed() will
> >>end up falling back to writel() regardless of whether writel_relaxed()
> >>is available (identically for s/write/read/).
> >>
> >>Add corresponding relaxed forms of the nonatomic helpers to delegate
> >>to the equivalent 32-bit accessors as appropriate.
> >>
> >>CC: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> >>CC: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
> >>CC: Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> >>CC: Hitoshi Mitake <mitake.hitoshi-Zyj7fXuS5i5L9jVzuh4AOg@public.gmane.org>
> >>Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> >>---
> >>  include/linux/io-64-nonatomic-hi-lo.h | 25 +++++++++++++++++++++++++
> >>  include/linux/io-64-nonatomic-lo-hi.h | 25 +++++++++++++++++++++++++
> >>  2 files changed, 50 insertions(+)
> >>
> >>diff --git a/include/linux/io-64-nonatomic-hi-lo.h b/include/linux/io-64-nonatomic-hi-lo.h
> >>index 11d7e84..1a85566 100644
> >>--- a/include/linux/io-64-nonatomic-hi-lo.h
> >>+++ b/include/linux/io-64-nonatomic-hi-lo.h
> >>@@ -21,6 +21,23 @@ static inline void hi_lo_writeq(__u64 val, volatile void __iomem *addr)
> >>  	writel(val, addr);
> >>  }
> >>
> >>+static inline __u64 hi_lo_readq_relaxed(const volatile void __iomem *addr)
> >>+{
> >>+	const volatile u32 __iomem *p = addr;
> >>+	u32 low, high;
> >>+
> >>+	high = readl_relaxed(p + 1);
> >>+	low = readl_relaxed(p);
> >>+
> >>+	return low + ((u64)high << 32);
> >>+}
> >>+
> >>+static inline void hi_lo_writeq_relaxed(__u64 val, volatile void __iomem *addr)
> >>+{
> >>+	writel_relaxed(val >> 32, addr + 4);
> >>+	writel_relaxed(val, addr);
> >>+}
> >
> >Could we not generate the _relaxed variants with some macro magic?
> 
> We _could_ - indeed I started doing that, but then decided that the
> obfuscation of horrible macro-templated functions wasn't worth saving a
> couple of hundred bytes in some code that isn't exactly difficult to
> maintain and has needed touching once in 4 years.
> 
> If you did want to go down the macro route, I may as well also generate both
> lo-hi and hi-lo headers all from a single template, it'd be really clever...
> <alarm bells> ;)

I certainly wasn't suggesting any more than the obvious macroisation,
but I'll leave it up to Arnd, as I think this falls on his lap.

Will
