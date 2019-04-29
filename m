From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v1] iommu/amd: flush not present cache in iommu_map_page
Date: Mon, 29 Apr 2019 04:59:16 -0700
Message-ID: <20190429115916.GA5349@infradead.org>
References: <20190424165051.13614-1-tmurphy@arista.com>
 <20190426140429.GG24576@8bytes.org>
 <CAPL0++6_Hyozhf+eA2LM=t_Vuq8HaDzcczAUm0S4=DAw4jmMpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPL0++6_Hyozhf+eA2LM=t_Vuq8HaDzcczAUm0S4=DAw4jmMpA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Murphy <tmurphy@arista.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, Tom Murphy <murphyt7@tcd.ie>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Sat, Apr 27, 2019 at 03:20:35PM +0100, Tom Murphy wrote:
> I am working on another patch to improve the intel iotlb flushing in
> the iommu ops patch which should cover this too.

So are you looking into converting the intel-iommu driver to use
dma-iommu as well?  That would be great!
