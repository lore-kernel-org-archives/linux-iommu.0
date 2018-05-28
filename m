From: Michal Hocko <mhocko-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [External]  Re: [RFC PATCH v2 00/12] get rid of GFP_ZONE_TABLE/BAD
Date: Mon, 28 May 2018 15:37:33 +0200
Message-ID: <20180528133733.GF27180@dhcp22.suse.cz>
References: <1526916033-4877-1-git-send-email-yehs2007@gmail.com>
	<20180522183728.GB20441@dhcp22.suse.cz>
	<HK2PR03MB16847646E90A10E2D48CEA8E926B0@HK2PR03MB1684.apcprd03.prod.outlook.com>
	<20180524121853.GG20441@dhcp22.suse.cz>
	<HK2PR03MB1684ED6EC6859A88A196DC0C92690@HK2PR03MB1684.apcprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <HK2PR03MB1684ED6EC6859A88A196DC0C92690-LG58XzHXFHAzM6+avpAIg682SN/2zMuYvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Huaisheng HS1 Ye <yehs1-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>
Cc: "kstewart-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <kstewart-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Ocean HY1 He <hehy1-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "alexander.levin-H+0wwilmMs1BDgjK7y7TUQ@public.gmane.org" <alexander.levin-H+0wwilmMs1BDgjK7y7TUQ@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-btrfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-btrfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, NingTing Cheng <chengnt-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>, "xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org" <xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org>, "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "colyli-l3A5Bk7waGM@public.gmane.org" <colyli-l3A5Bk7waGM@public.gmane.org>, "mgorman-3eNAlZScCAx27rWaFMvyedHuzzzSOjJt@public.gmane.org" <mgorman-3eNAlZScCAx27rWaFMvyedHuzzzSOjJt@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, "vbabka-AlSwsSmVLrQ@public.gmane.org" <vbabka-AlSwsSmVLrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri 25-05-18 09:43:09, Huaisheng HS1 Ye wrote:
> From: Michal Hocko [mailto:mhocko-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org]
> Sent: Thursday, May 24, 2018 8:19 PM> 
> > > Let me try to reply your questions.
> > > Exactly, GFP_ZONE_TABLE is too complicated. I think there are two advantages
> > > from the series of patches.
> > >
> > > 1. XOR operation is simple and efficient, GFP_ZONE_TABLE/BAD need to do twice
> > > shift operations, the first is for getting a zone_type and the second is for
> > > checking the to be returned type is a correct or not. But with these patch XOR
> > > operation just needs to use once. Because the bottom 3 bits of GFP bitmask have
> > > been used to represent the encoded zone number, we can say there is no bad zone
> > > number if all callers could use it without buggy way. Of course, the returned
> > > zone type in gfp_zone needs to be no more than ZONE_MOVABLE.
> > 
> > But you are losing the ability to check for wrong usage. And it seems
> > that the sad reality is that the existing code do screw up.
> 
> In my opinion, originally there shouldn't be such many wrong
> combinations of these bottom 3 bits. For any user, whether or
> driver and fs, they should make a decision that which zone is they
> preferred. Matthew's idea is great, because with it the user must
> offer an unambiguous flag to gfp zone bits.

Well, I would argue that those shouldn't really care about any zones at
all. All they should carea bout is whether they really need a low mem
zone (aka directly accessible to the kernel), highmem or they are the
allocation is generally movable. Mixing zones into the picture just
makes the whole thing more complicated and error prone.
[...]
> > That being said. I am not saying that I am in love with GFP_ZONE_TABLE.
> > It always makes my head explode when I look there but it seems to work
> > with the current code and it is optimized for it. If you want to change
> > this then you should make sure you describe reasons _why_ this is an
> > improvement. And I would argue that "we can have more zones" is a
> > relevant one.
> 
> Yes, GFP_ZONE_TABLE is too complicated. The patches have 4 advantages as below.
> 
> * The address zone modifiers have new operation method, that is, user should decide which zone is preferred at first, then give the encoded zone number to bottom 3 bits in GFP mask. That is much direct and clear than before.
> 
> * No bad zone combination, because user should choose just one address zone modifier always.
> * Better performance and efficiency, current gfp_zone has to take shifting operation twice for GFP_ZONE_TABLE and GFP_ZONE_BAD. With these patches, gfp_zone() just needs one XOR.
> * Up to 8 zones can be used. At least it isn't a disadvantage, right?

This should be a part of the changelog. Please note that you should
provide some number if you claim performance benefits. The complexity
will always be subjective.
-- 
Michal Hocko
SUSE Labs
