From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v5 2/3] iommu/io-pgtable-arm-v7s: Request DMA32 memory,
 and improve debugging
Date: Fri, 7 Dec 2018 00:05:51 -0800
Message-ID: <20181207080551.GA15120@bombadil.infradead.org>
References: <20181207061620.107881-1-drinkcat@chromium.org>
 <20181207061620.107881-3-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181207061620.107881-3-drinkcat@chromium.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Boichat <drinkcat@chromium.org>
Cc: Michal Hocko <mhocko@suse.com>, Will Deacon <will.deacon@arm.com>, Levin Alexander <Alexander.Levin@microsoft.com>, linux-mm@kvack.org, Christoph Lameter <cl@linux.com>, Huaisheng Ye <yehs1@lenovo.com>, Joerg Roedel <joro@8bytes.org>, hch@infradead.org, Yong Wu <yong.wu@mediatek.com>, David Rientjes <rientjes@google.com>, yingjoe.chen@mediatek.com, Vlastimil Babka <vbabka@suse.cz>, Tomasz Figa <tfiga@google.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>, iommu@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@techsingularity.net>
List-Id: iommu@lists.linux-foundation.org

On Fri, Dec 07, 2018 at 02:16:19PM +0800, Nicolas Boichat wrote:
> +#ifdef CONFIG_ZONE_DMA32
> +#define ARM_V7S_TABLE_GFP_DMA GFP_DMA32
> +#define ARM_V7S_TABLE_SLAB_CACHE SLAB_CACHE_DMA32

This name doesn't make any sense.  Why not ARM_V7S_TABLE_SLAB_FLAGS ?

> +#else
> +#define ARM_V7S_TABLE_GFP_DMA GFP_DMA
> +#define ARM_V7S_TABLE_SLAB_CACHE SLAB_CACHE_DMA

Can you remind me again why it is, on machines which don't support
ZONE_DMA32, why we have to allocate from ZONE_DMA?  My understanding
is that 64-bit machines have ZONE_DMA32 and 32-bit machines don't.
So shouldn't this rather be GFP_KERNEL?

Actually, maybe we could centralise this in gfp.h:

#ifdef CONFIG_64BIT
# ifdef CONFIG_ZONE_DMA32
#define GFP_32BIT	GFP_DMA32
# else
#define GFP_32BIT	GFP_DMA
#else /* 32-bit */
#define GFP_32BIT	GFP_KERNEL
#endif
