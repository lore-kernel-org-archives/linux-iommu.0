From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 0/4] ipmmu-vmsa cleanup
Date: Mon, 6 Nov 2017 13:06:34 -0700
Message-ID: <20171106130634.4a42e18a@t450s.home>
References: <cover.1507918320.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <cover.1507918320.git.robin.murphy@arm.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, laurent.pinchart+renesas@ideasonboard.com, arnd@arndb.de, geert+renesas@glider.be, magnus.damm@gmail.com, linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Fri, 13 Oct 2017 19:23:38 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> Arnd reports a build warning[1] thanks to me missing ipmmu-vmsa's second
> set of ops when converting io-pgtable-arm users to the new iommu_iotlb_*
> callbacks. Rather than just treat the symptom with a point fix, this
> seemed like a good excuse to clean up the messy #ifdeffery and
> duplication in the driver that led to the oversight in the first place.
> 
> Build-tested successfully for arm64, ARM, and ARM + CONFIG_IOMMU_DMA.
> 
> Robin.
> 
> [1]:https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1510423.html
> 
> Robin Murphy (4):
>   iommu/ipmmu-vmsa: Unify domain alloc/free
>   iommu/ipmmu-vmsa: Simplify group allocation
>   iommu/ipmmu-vmsa: Clean up struct ipmmu_vmsa_iommu_priv
>   iommu/ipmmu-vmsa: Unify ipmmu_ops
> 
>  drivers/iommu/ipmmu-vmsa.c | 251 ++++++++++++++-------------------------------
>  1 file changed, 78 insertions(+), 173 deletions(-)
> 

Applied to iommu/ipmmu-vmsa for v4.15.  Thanks,

Alex
