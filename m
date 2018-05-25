From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH v2 00/12] get rid of GFP_ZONE_TABLE/BAD
Date: Fri, 25 May 2018 05:00:44 -0700
Message-ID: <20180525120044.GA4649@bombadil.infradead.org>
References: <1526916033-4877-1-git-send-email-yehs2007@gmail.com>
 <20180522183728.GB20441@dhcp22.suse.cz>
 <20180524051919.GA9819@bombadil.infradead.org>
 <20180524122323.GH20441@dhcp22.suse.cz>
 <20180524151818.GA21245@bombadil.infradead.org>
 <20180524152943.GA11881@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180524152943.GA11881@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Hocko <mhocko@kernel.org>
Cc: Huaisheng Ye <yehs2007@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, vbabka@suse.cz, mgorman@techsingularity.net, kstewart@linuxfoundation.org, alexander.levin@verizon.com, gregkh@linuxfoundation.org, colyli@suse.de, chengnt@lenovo.com, hehy1@lenovo.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, xen-devel@lists.xenproject.org, linux-btrfs@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>
List-Id: iommu@lists.linux-foundation.org

On Thu, May 24, 2018 at 05:29:43PM +0200, Michal Hocko wrote:
> > ie if we had more,
> > could we solve our pain by making them more generic?
> 
> Well, if you have more you will consume more bits in the struct pages,
> right?

Not necessarily ... the zone number is stored in the struct page
currently, so either two or three bits are used right now.  In my
proposal, one can infer the zone of a page from its PFN, except for
ZONE_MOVABLE.  So we could trim down to just one bit per struct page
for 32-bit machines while using 3 bits on 64-bit machines, where there
is plenty of space.

> > it more-or-less sucks that the devices with 28-bit DMA limits are forced
> > to allocate from the low 16MB when they're perfectly capable of using the
> > low 256MB.
> 
> Do we actually care all that much about those? If yes then we should
> probably follow the ZONE_DMA (x86) path and use a CMA region for them.
> I mean most devices should be good with very limited addressability or
> below 4G, no?

Sure.  One other thing I meant to mention was the media devices
(TV capture cards and so on) which want a vmalloc_32() allocation.
On 32-bit machines right now, we allocate from LOWMEM, when we really
should be allocating from the 1GB-4GB region.  32-bit machines generally
don't have a ZONE_DMA32 today.
