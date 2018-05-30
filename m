From: Michal Hocko <mhocko-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [External]  Re: [RFC PATCH v2 00/12] get rid of GFP_ZONE_TABLE/BAD
Date: Wed, 30 May 2018 11:12:06 +0200
Message-ID: <20180530091206.GB27180@dhcp22.suse.cz>
References: <1526916033-4877-1-git-send-email-yehs2007@gmail.com>
	<20180522183728.GB20441@dhcp22.suse.cz>
	<HK2PR03MB16847646E90A10E2D48CEA8E926B0@HK2PR03MB1684.apcprd03.prod.outlook.com>
	<20180524121853.GG20441@dhcp22.suse.cz>
	<HK2PR03MB1684ED6EC6859A88A196DC0C92690@HK2PR03MB1684.apcprd03.prod.outlook.com>
	<20180528133733.GF27180@dhcp22.suse.cz>
	<HK2PR03MB1684C44F2408F3927B1A21BC926C0@HK2PR03MB1684.apcprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <HK2PR03MB1684C44F2408F3927B1A21BC926C0-LG58XzHXFHAzM6+avpAIg682SN/2zMuYvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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

On Wed 30-05-18 09:02:13, Huaisheng HS1 Ye wrote:
> From: owner-linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org [mailto:owner-linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org] On Behalf Of Michal Hocko
> Sent: Monday, May 28, 2018 9:38 PM
> > > In my opinion, originally there shouldn't be such many wrong
> > > combinations of these bottom 3 bits. For any user, whether or
> > > driver and fs, they should make a decision that which zone is they
> > > preferred. Matthew's idea is great, because with it the user must
> > > offer an unambiguous flag to gfp zone bits.
> > 
> > Well, I would argue that those shouldn't really care about any zones at
> > all. All they should carea bout is whether they really need a low mem
> > zone (aka directly accessible to the kernel), highmem or they are the
> > allocation is generally movable. Mixing zones into the picture just
> > makes the whole thing more complicated and error prone.
> 
> Dear Michal,
> 
> I don't quite understand that. I think those, mostly drivers, need to
> get the correct zone they want. ZONE_DMA32 is an example, if drivers can be
> satisfied with a low mem zone, why they mark the gfp flags as
> 'GFP_KERNEL|__GFP_DMA32'?
> GFP_KERNEL is enough to make sure a directly accessible low mem, but it is
> obvious that they want to get a DMA accessible zone below 4G.

They want a specific pfn range. Not a _zone_. Zone is an MM abstraction
to manage memory. And not a great one as the time has shown. We have
moved away from the per-zone reclaim because it just turned out to be
problematic. Leaking this abstraction to users was a mistake IMHO. It
was surely convenient but we can clearly see it was just confusing and
many users just got it wrong.

I do agree with Christoph in other email that the proper way for DMA
users is to use the existing DMA API which is more towards what they
need. Set a restriction on dma-able memory ranges.
-- 
Michal Hocko
SUSE Labs
