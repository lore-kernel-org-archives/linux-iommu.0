From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v6 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page
 tables
Date: Fri, 11 Jan 2019 11:21:55 +0100
Message-ID: <20190111102155.in5rctq5krs4ewfi@8bytes.org>
References: <20181210011504.122604-1-drinkcat@chromium.org>
 <CANMq1KAmFKpcxi49wJyfP4N01A80B2d-2RGY2Wrwg0BvaFxAxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANMq1KAmFKpcxi49wJyfP4N01A80B2d-2RGY2Wrwg0BvaFxAxg@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Nicolas Boichat <drinkcat@chromium.org>
Cc: Will Deacon <will.deacon@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, Mel Gorman <mgorman@techsingularity.net>, Levin Alexander <Alexander.Levin@microsoft.com>, Huaisheng Ye <yehs1@lenovo.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, iommu@lists.linux-foundation.org, lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, Yong Wu <yong.wu@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, Tomasz Figa <tfiga@google.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 02, 2019 at 01:51:45PM +0800, Nicolas Boichat wrote:
> Does anyone have any further comment on this series? If not, which
> maintainer is going to pick this up? I assume Andrew Morton?

Probably, yes. I don't like to carry the mm-changes in iommu-tree, so
this should go through mm.

Regards,

	Joerg
