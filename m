From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 0/3] iommu: Kerneldoc improvements
Date: Tue, 26 Feb 2019 11:10:55 +0100
Message-ID: <20190226101055.GD20740@8bytes.org>
References: <20190220130053.784-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190220130053.784-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Dmitry Osipenko <digetx@gmail.com>, Baoquan He <bhe@redhat.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Geert,

On Wed, Feb 20, 2019 at 02:00:50PM +0100, Geert Uytterhoeven wrote:
> This series contains a fix for an incorrect kerneldoc parameter, and
> adds the missing kerneldoc for two recently added IOMMU methods.
> 
> Thanks!
> 
> Geert Uytterhoeven (3):
>   iommu: Fix kerneldoc for iommu_ops.flush_iotlb_all()
>   iommu: Document iommu_ops.iotlb_sync_map()
>   iommu: Document iommu_ops.is_attach_deferred()
> 
>  include/linux/iommu.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied patches 2 and 3, I already have a change similar to patch 1 in
the tree.

Thanks,

	Joerg
