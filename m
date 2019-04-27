From: Tom Murphy <tmurphy@arista.com>
Subject: Re: [PATCH v1] iommu/amd: flush not present cache in iommu_map_page
Date: Sat, 27 Apr 2019 15:20:35 +0100
Message-ID: <CAPL0++6_Hyozhf+eA2LM=t_Vuq8HaDzcczAUm0S4=DAw4jmMpA@mail.gmail.com>
References: <20190424165051.13614-1-tmurphy@arista.com> <20190426140429.GG24576@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190426140429.GG24576@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, Tom Murphy <murphyt7@tcd.ie>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

> The iommu_map_page function is called once per physical page that is
> mapped, so in the worst case for every 4k mapping established. So it is
> not the right place to put this check in.

Ah, you're right, that was careless of me.

> From a quick glance this check belongs into the map_sg() and the
> amd_iommu_map() function, but without the dom->updated check.
>
> Besides, to really support systems with np-cache in a way that doesn't
> destroy all performance, the driver also needs range-flushes for IOTLBs.

I am working on another patch to improve the intel iotlb flushing in
the iommu ops patch which should cover this too.

> Currently it can only flush a 4k page of the full address space of a
> domain. But that doesn't mean we shouldn't fix the missing flushes now.
>
> So please re-send the patch with the check at the two places I pointed
> out above.

will do
