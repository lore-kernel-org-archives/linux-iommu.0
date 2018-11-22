From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page
 tables
Date: Wed, 21 Nov 2018 18:35:58 -0800
Message-ID: <20181122023558.GO3065@bombadil.infradead.org>
References: <20181111090341.120786-1-drinkcat@chromium.org>
 <0100016737801f14-84f1265d-4577-4dcf-ad57-90dbc8e0a78f-000000@email.amazonses.com>
 <20181121213853.GL3065@bombadil.infradead.org>
 <c5ccde1e-a711-ad33-537c-2d5a0bd9edd4@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <c5ccde1e-a711-ad33-537c-2d5a0bd9edd4@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Michal Hocko <mhocko@suse.com>, Will Deacon <will.deacon@arm.com>, Levin Alexander <Alexander.Levin@microsoft.com>, linux-mm@kvack.org, Christopher Lameter <cl@linux.com>, Nicolas Boichat <drinkcat@chromium.org>, Huaisheng Ye <yehs1@lenovo.com>, Joerg Roedel <joro@8bytes.org>, Yong Wu <yong.wu@mediatek.com>, David Rientjes <rientjes@google.com>, yingjoe.chen@mediatek.com, Vlastimil Babka <vbabka@suse.cz>, Tomasz Figa <tfiga@google.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>, iommu@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@techsingularity.net>
List-Id: iommu@lists.linux-foundation.org

On Wed, Nov 21, 2018 at 10:26:26PM +0000, Robin Murphy wrote:
> These are IOMMU page tables, rather than CPU ones, so we're already well
> outside arch code - indeed the original motivation of io-pgtable was to be
> entirely independent of the p*d types and arch-specific MM code (this Armv7
> short-descriptor format is already "non-native" when used by drivers in an
> arm64 kernel).

There was quite a lot of explanation missing from this patch description!

> There are various efficiency reasons for using regular kernel memory instead
> of coherent DMA allocations - for the most part it works well, we just have
> the odd corner case like this one where the 32-bit format gets used on
> 64-bit systems such that the tables themselves still need to be allocated
> below 4GB (although the final output address can point at higher memory by
> virtue of the IOMMU in question not implementing permissions and repurposing
> some of those PTE fields as extra address bits).
> 
> TBH, if this DMA32 stuff is going to be contentious we could possibly just
> rip out the offending kmem_cache - it seemed like good practice for the
> use-case, but provided kzalloc(SZ_1K, gfp | GFP_DMA32) can be relied upon to
> give the same 1KB alignment and chance of succeeding as the equivalent
> kmem_cache_alloc(), then we could quite easily make do with that instead.

I think you should look at using the page_frag allocator here.  You can
use whatever GFP_DMA flags you like.
