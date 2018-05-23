From: Huaisheng HS1 Ye <yehs1-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>
Subject: RE: [External]  Re: [RFC PATCH v2 00/12] get rid of GFP_ZONE_TABLE/BAD
Date: Wed, 23 May 2018 16:07:16 +0000
Message-ID: <HK2PR03MB16847646E90A10E2D48CEA8E926B0@HK2PR03MB1684.apcprd03.prod.outlook.com>
References: <1526916033-4877-1-git-send-email-yehs2007@gmail.com>
	<20180522183728.GB20441@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180522183728.GB20441-2MMpYkNvuYDjFM9bn6wA6Q@public.gmane.org>
Content-Language: zh-CN
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
Cc: "kstewart-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <kstewart-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Ocean HY1 He <hehy1-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "alexander.levin-H+0wwilmMs1BDgjK7y7TUQ@public.gmane.org" <alexander.levin-H+0wwilmMs1BDgjK7y7TUQ@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-btrfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-btrfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, NingTing Cheng <chengnt-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>, "xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org" <xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org>, "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "colyli-l3A5Bk7waGM@public.gmane.org" <colyli-l3A5Bk7waGM@public.gmane.org>, "mgorman-3eNAlZScCAx27rWaFMvyedHuzzzSOjJt@public.gmane.org" <mgorman-3eNAlZScCAx27rWaFMvyedHuzzzSOjJt@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, "vbabka-AlSwsSmVLrQ@public.gmane.org" <vbabka-AlSwsSmVLrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Michal Hocko [mailto:mhocko-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org]
Sent: Wednesday, May 23, 2018 2:37 AM
> 
> On Mon 21-05-18 23:20:21, Huaisheng Ye wrote:
> > From: Huaisheng Ye <yehs1-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>
> >
> > Replace GFP_ZONE_TABLE and GFP_ZONE_BAD with encoded zone number.
> >
> > Delete ___GFP_DMA, ___GFP_HIGHMEM and ___GFP_DMA32 from GFP bitmasks,
> > the bottom three bits of GFP mask is reserved for storing encoded
> > zone number.
> >
> > The encoding method is XOR. Get zone number from enum zone_type,
> > then encode the number with ZONE_NORMAL by XOR operation.
> > The goal is to make sure ZONE_NORMAL can be encoded to zero. So,
> > the compatibility can be guaranteed, such as GFP_KERNEL and GFP_ATOMIC
> > can be used as before.
> >
> > Reserve __GFP_MOVABLE in bit 3, so that it can continue to be used as
> > a flag. Same as before, __GFP_MOVABLE respresents movable migrate type
> > for ZONE_DMA, ZONE_DMA32, and ZONE_NORMAL. But when it is enabled with
> > __GFP_HIGHMEM, ZONE_MOVABLE shall be returned instead of ZONE_HIGHMEM.
> > __GFP_ZONE_MOVABLE is created to realize it.
> >
> > With this patch, just enabling __GFP_MOVABLE and __GFP_HIGHMEM is not
> > enough to get ZONE_MOVABLE from gfp_zone. All callers should use
> > GFP_HIGHUSER_MOVABLE or __GFP_ZONE_MOVABLE directly to achieve that.
> >
> > Decode zone number directly from bottom three bits of flags in gfp_zone.
> > The theory of encoding and decoding is,
> >         A ^ B ^ B = A
> 
> So why is this any better than the current code. Sure I am not a great
> fan of GFP_ZONE_TABLE because of how it is incomprehensible but this
> doesn't look too much better, yet we are losing a check for incompatible
> gfp flags. The diffstat looks really sound but then you just look and
> see that the large part is the comment that at least explained the gfp
> zone modifiers somehow and the debugging code. So what is the selling
> point?

Dear Michal,

Let me try to reply your questions.
Exactly, GFP_ZONE_TABLE is too complicated. I think there are two advantages
from the series of patches.

1. XOR operation is simple and efficient, GFP_ZONE_TABLE/BAD need to do twice
shift operations, the first is for getting a zone_type and the second is for
checking the to be returned type is a correct or not. But with these patch XOR
operation just needs to use once. Because the bottom 3 bits of GFP bitmask have
been used to represent the encoded zone number, we can say there is no bad zone
number if all callers could use it without buggy way. Of course, the returned
zone type in gfp_zone needs to be no more than ZONE_MOVABLE.

2. GFP_ZONE_TABLE has limit with the amount of zone types. Current GFP_ZONE_TABLE
is 32 bits, in general, there are 4 zone types for most ofX86_64 platform, they
are ZONE_DMA, ZONE_DMA32, ZONE_NORMAL and ZONE_MOVABLE. If we want to expand the
amount of zone types to larger than 4, the zone shift should be 3. That is to say,
a 32 bits zone table is not enough to store all zone types.
And the most painful thing is that, current GFP bitmasks' space is quite
space-constrained it only have four ___GFP_XXX could be used as below,

	#define ___GFP_DMA		0x01u
	#define ___GFP_HIGHMEM	0x02u
	#define ___GFP_DMA32		0x04u
	(___GFP_NORMAL equals to 0x00)

If we use the implementation of these patches, there is a maximum of 8 zone types
could be used. The method of encoding and decoding is quite simple and users could
have an intuitive feeling for this as below, and the most important is that, there
is no BAD zone types eventually.

	A ^ B ^ B = A

And by the way, our v3 patches are ready, but the smtp of Gmail is quite unstable
for some firewall reason in my side, I will try to resend them ASAP.

Sincerely,
Huaisheng Ye
