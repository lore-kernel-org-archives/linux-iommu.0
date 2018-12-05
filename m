From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4 1/3] mm: slab/slub: Add check_slab_flags function to
 check for valid flags
Date: Wed, 5 Dec 2018 14:34:20 +0100
Message-ID: <6dc0181c-406d-bd13-f36b-98496f488979@suse.cz>
References: <20181205054828.183476-1-drinkcat@chromium.org>
 <20181205054828.183476-2-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205054828.183476-2-drinkcat@chromium.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Boichat <drinkcat@chromium.org>, Will Deacon <will.deacon@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Mel Gorman <mgorman@techsingularity.net>, Levin Alexander <Alexander.Levin@microsoft.com>, Huaisheng Ye <yehs1@lenovo.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Yong Wu <yong.wu@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, Tomasz Figa <tfiga@google.com>, yingjoe.chen@mediatek.com, hch@infradead.org, Matthew Wilcox <willy@infradead>
List-Id: iommu@lists.linux-foundation.org

On 12/5/18 6:48 AM, Nicolas Boichat wrote:
> Remove duplicated code between slab and slub, and will make it
> easier to make the test more complicated in the next commits.
> 
> Fixes: ad67f5a6545f ("arm64: replace ZONE_DMA with ZONE_DMA32")

Well, not really. Patch 3 does that and yeah this will be a prerequisity
for a clean stable backport, but we don't tag all prerequisities like
this, I think?

> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
