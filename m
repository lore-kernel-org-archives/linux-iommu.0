From: Huaisheng HS1 Ye <yehs1-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>
Subject: RE: [External]  Re: [RFC PATCH v2 00/12] get rid of GFP_ZONE_TABLE/BAD
Date: Fri, 25 May 2018 09:43:09 +0000
Message-ID: <HK2PR03MB1684ED6EC6859A88A196DC0C92690@HK2PR03MB1684.apcprd03.prod.outlook.com>
References: <1526916033-4877-1-git-send-email-yehs2007@gmail.com>
	<20180522183728.GB20441@dhcp22.suse.cz>
	<HK2PR03MB16847646E90A10E2D48CEA8E926B0@HK2PR03MB1684.apcprd03.prod.outlook.com>
	<20180524121853.GG20441@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180524121853.GG20441-2MMpYkNvuYDjFM9bn6wA6Q@public.gmane.org>
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
Sent: Thursday, May 24, 2018 8:19 PM> 
> > Let me try to reply your questions.
> > Exactly, GFP_ZONE_TABLE is too complicated. I think there are two advantages
> > from the series of patches.
> >
> > 1. XOR operation is simple and efficient, GFP_ZONE_TABLE/BAD need to do twice
> > shift operations, the first is for getting a zone_type and the second is for
> > checking the to be returned type is a correct or not. But with these patch XOR
> > operation just needs to use once. Because the bottom 3 bits of GFP bitmask have
> > been used to represent the encoded zone number, we can say there is no bad zone
> > number if all callers could use it without buggy way. Of course, the returned
> > zone type in gfp_zone needs to be no more than ZONE_MOVABLE.
> 
> But you are losing the ability to check for wrong usage. And it seems
> that the sad reality is that the existing code do screw up.

In my opinion, originally there shouldn't be such many wrong combinations of these bottom 3 bits. For any user, whether or driver and fs, they should make a decision that which zone is they preferred. Matthew's idea is great, because with it the user must offer an unambiguous flag to gfp zone bits.

Ideally, before any user wants to modify the address zone modifier, they should clear it firstly, then ORing the GFP zone flag which comes from the zone they prefer.
With these patches, we can loudly announce that, the bottom 3 bits of zone mask couldn't accept internal ORing operations.
The operations like __GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM is illegal. The current GFP_ZONE_TABLE is precisely the root of this problem, that is __GFP_DMA, __GFP_DMA32 and __GFP_HIGHMEM are formatted as 0x1, 0x2 and 0x4.

> 
> > 2. GFP_ZONE_TABLE has limit with the amount of zone types. Current GFP_ZONE_TABLE
> > is 32 bits, in general, there are 4 zone types for most ofX86_64 platform, they
> > are ZONE_DMA, ZONE_DMA32, ZONE_NORMAL and ZONE_MOVABLE. If we want to expand the
> > amount of zone types to larger than 4, the zone shift should be 3.
> 
> But we do not want to expand the number of zones IMHO. The existing zoo
> is quite a maint. pain.
> 
> That being said. I am not saying that I am in love with GFP_ZONE_TABLE.
> It always makes my head explode when I look there but it seems to work
> with the current code and it is optimized for it. If you want to change
> this then you should make sure you describe reasons _why_ this is an
> improvement. And I would argue that "we can have more zones" is a
> relevant one.

Yes, GFP_ZONE_TABLE is too complicated. The patches have 4 advantages as below.

* The address zone modifiers have new operation method, that is, user should decide which zone is preferred at first, then give the encoded zone number to bottom 3 bits in GFP mask. That is much direct and clear than before.

* No bad zone combination, because user should choose just one address zone modifier always.
* Better performance and efficiency, current gfp_zone has to take shifting operation twice for GFP_ZONE_TABLE and GFP_ZONE_BAD. With these patches, gfp_zone() just needs one XOR.
* Up to 8 zones can be used. At least it isn't a disadvantage, right?

Sincerely,
Huaisheng Ye
