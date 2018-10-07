From: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH] iommu: Do physical merging in iommu_map_sg()
Date: Sun, 7 Oct 2018 03:38:02 -0700
Message-ID: <20181007103802.GA20091@infradead.org>
References: <1be92cab99ba7fc82cc355bdda239f2ddcb92db0.1538667993.git.robin.murphy@arm.com>
	<20181005071934.GA9238@infradead.org>
	<13093b94-be59-030d-7176-16dab22bcdce@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <13093b94-be59-030d-7176-16dab22bcdce-5wv7dgnIgG8@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Oct 05, 2018 at 11:57:57AM +0100, Robin Murphy wrote:
> Yeah, I fiddled around for ages trying to find the cleanest approach, but
> really there just doesn't seem to be one - I'd say the worst bit of that
> goto is the even-more-subtle need for the explicit break. FWIW the naive
> diff below is only actually +2 source lines, but the duplication does also
> carry through to the object code (at least for my arm64 GCC7 build). I might
> have a quick hack around to see if I can do any better with a do...while
> loop - of course what I *really* want is nested function definitions, but
> that might just be brain damage from doing too much MATLAB in the past ;)

I much prefer this version, even if it leads to slightly larger object
code.
