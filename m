From: Matthew Wilcox <willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [RFC PATCH v2 00/12] get rid of GFP_ZONE_TABLE/BAD
Date: Wed, 23 May 2018 22:19:19 -0700
Message-ID: <20180524051919.GA9819@bombadil.infradead.org>
References: <1526916033-4877-1-git-send-email-yehs2007@gmail.com>
	<20180522183728.GB20441@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180522183728.GB20441-2MMpYkNvuYDjFM9bn6wA6Q@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Michal Hocko <mhocko-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: kstewart-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Huaisheng Ye <yehs1-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>, hehy1-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alexander.levin-H+0wwilmMs1BDgjK7y7TUQ@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-btrfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Huaisheng Ye <yehs2007-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, chengnt-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, colyli-l3A5Bk7waGM@public.gmane.org, mgorman-3eNAlZScCAx27rWaFMvyedHuzzzSOjJt@public.gmane.org, vbabka-AlSwsSmVLrQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, May 22, 2018 at 08:37:28PM +0200, Michal Hocko wrote:
> So why is this any better than the current code. Sure I am not a great
> fan of GFP_ZONE_TABLE because of how it is incomprehensible but this
> doesn't look too much better, yet we are losing a check for incompatible
> gfp flags. The diffstat looks really sound but then you just look and
> see that the large part is the comment that at least explained the gfp
> zone modifiers somehow and the debugging code. So what is the selling
> point?

I have a plan, but it's not exactly fully-formed yet.

One of the big problems we have today is that we have a lot of users
who have constraints on the physical memory they want to allocate,
but we have very limited abilities to provide them with what they're
asking for.  The various different ZONEs have different meanings on
different architectures and are generally a mess.

If we had eight ZONEs, we could offer:

ZONE_16M	// 24 bit
ZONE_256M	// 28 bit
ZONE_LOWMEM	// CONFIG_32BIT only
ZONE_4G		// 32 bit
ZONE_64G	// 36 bit
ZONE_1T		// 40 bit
ZONE_ALL	// everything larger
ZONE_MOVABLE	// movable allocations; no physical address guarantees

#ifdef CONFIG_64BIT
#define ZONE_NORMAL	ZONE_ALL
#else
#define ZONE_NORMAL	ZONE_LOWMEM
#endif

This would cover most driver DMA mask allocations; we could tweak the
offered zones based on analysis of what people need.

#define GFP_HIGHUSER		(GFP_USER | ZONE_ALL)
#define GFP_HIGHUSER_MOVABLE	(GFP_USER | ZONE_MOVABLE)

One other thing I want to see is that fallback from zones happens from
highest to lowest normally (ie if you fail to allocate in 1T, then you
try to allocate from 64G), but movable allocations hapen from lowest
to highest.  So ZONE_16M ends up full of page cache pages which are
readily evictable for the rare occasions when we need to allocate memory
below 16MB.

I'm sure there are lots of good reasons why this won't work, which is
why I've been hesitant to propose it before now.
