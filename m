From: Vlastimil Babka <vbabka-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH v2 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page
	tables
Date: Tue, 4 Dec 2018 15:35:41 +0100
Message-ID: <b99dd00f-fe1c-1cac-8ee3-5b0c1af9a92e@suse.cz>
References: <20181111090341.120786-1-drinkcat@chromium.org>
	<CANMq1KDxmRcWhtaJbrLHqx6yPGkNaK7WNYYf+iFjH1e8XdrwRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CANMq1KDxmRcWhtaJbrLHqx6yPGkNaK7WNYYf+iFjH1e8XdrwRg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Christoph Lameter <cl-vYTEC60ixJUAvxtiuMwx3w@public.gmane.org>, Michal Hocko <mhocko-IBi9RG/b67k@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, Matthew Wilcox <willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Levin Alexander <Alexander.Levin-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, Huaisheng Ye <yehs1-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Hsin-Yi Wang <hsinyi-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Pekka Enberg <penberg-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Mike Rapoport <rppt-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, David Rientjes <rientjes-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Joonsoo Kim <iamjoonsoo.kim-Hm3cg6mZ9cc@public.gmane.org>, Mel Gorman <mgorman-3eNAlZScCAx27rWaFMvyedHuzzzSOjJt@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-arm Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 12/4/18 10:37 AM, Nicolas Boichat wrote:
> On Sun, Nov 11, 2018 at 5:04 PM Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
>>
>> This is a follow-up to the discussion in [1], to make sure that the page
>> tables allocated by iommu/io-pgtable-arm-v7s are contained within 32-bit
>> physical address space.
>>
>> [1] https://lists.linuxfoundation.org/pipermail/iommu/2018-November/030876.html
> 
> Hi everyone,
> 
> Let's try to summarize here.
> 
> First, we confirmed that this is a regression, and IOMMU errors happen
> on 4.19 and linux-next/master on MT8173 (elm, Acer Chromebook R13).
> The issue most likely starts from ad67f5a6545f ("arm64: replace
> ZONE_DMA with ZONE_DMA32"), i.e. 4.15, and presumably breaks a number
> of Mediatek platforms (and maybe others?).
> 
> We have a few options here:
> 1. This series [2], that adds support for GFP_DMA32 slab caches,
> _without_ adding kmalloc caches (since there are no users of
> kmalloc(..., GFP_DMA32)). I think I've addressed all the comments on
> the 3 patches, and AFAICT this solution works fine.
> 2. genalloc. That works, but unless we preallocate 4MB for L2 tables
> (which is wasteful as we usually only need a handful of L2 tables),
> we'll need changes in the core (use GFP_ATOMIC) to allow allocating on
> demand, and as it stands we'd have no way to shrink the allocation.
> 3. page_frag [3]. That works fine, and the code is quite simple. One
> drawback is that fragments in partially freed pages cannot be reused
> (from limited experiments, I see that IOMMU L2 tables are rarely
> freed, so it's unlikely a whole page would get freed). But given the
> low number of L2 tables, maybe we can live with that.
> 
> I think 2 is out. Any preference between 1 and 3? I think 1 makes
> better use of the memory, so that'd be my preference. But I'm probably
> missing something.

I would prefer 1 as well. IIRC you already confirmed that alignment
requirements are not broken for custom kmem caches even in presence of
SLUB debug options (and I would say it's a bug to be fixed if they
weren't). I just asked (and didn't get a reply I think) about your
ability to handle the GFP_ATOMIC allocation failures. They should be
rare when only single page allocations are needed for the kmem cache.
But in case they are not an option, then preallocating would be needed,
thus probably option 2.

> [2] https://patchwork.kernel.org/cover/10677529/, 3 patches
> [3] https://patchwork.codeaurora.org/patch/671639/
> 
> Thanks,
> 
> Nicolas
> 
