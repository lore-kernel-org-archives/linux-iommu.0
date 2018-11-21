From: Christopher Lameter <cl@linux.com>
Subject: Re: [PATCH v2 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page
 tables
Date: Wed, 21 Nov 2018 18:20:02 +0000
Message-ID: <0100016737801f14-84f1265d-4577-4dcf-ad57-90dbc8e0a78f-000000@email.amazonses.com>
References: <20181111090341.120786-1-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181111090341.120786-1-drinkcat@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Boichat <drinkcat@chromium.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, Mel Gorman <mgorman@techsingularity.net>, Levin Alexander <Alexander.Levin@microsoft.com>, Huaisheng Ye <yehs1@lenovo.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Yong Wu <yong.wu@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, Tomasz Figa <tfiga@google.com>, yingjoe.chen@mediatek.com
List-Id: iommu@lists.linux-foundation.org

On Sun, 11 Nov 2018, Nicolas Boichat wrote:

> This is a follow-up to the discussion in [1], to make sure that the page
> tables allocated by iommu/io-pgtable-arm-v7s are contained within 32-bit
> physical address space.

Page tables? This means you need a page frame? Why go through the slab
allocators?
