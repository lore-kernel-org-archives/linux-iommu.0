From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] Remove old no iommu direct mapping code
Date: Fri, 26 Apr 2019 17:02:42 +0200
Message-ID: <20190426150242.GL24576@8bytes.org>
References: <20190423200335.3888-1-tmurphy@arista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190423200335.3888-1-tmurphy@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Murphy <tmurphy@arista.com>
Cc: iommu@lists.linux-foundation.org, murphyt7@tcd.ie, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 23, 2019 at 09:03:34PM +0100, Tom Murphy wrote:
> These checks were intended to handle devices not mapped by the IOMMU.
> Since the AMD IOMMU driver uses per-device dma_ops these functions can
> no longer be called by direct mapped devices. So these checks aren't
> needed anymore.
> 
> Signed-off-by: Tom Murphy <tmurphy@arista.com>
> ---
>  drivers/iommu/amd_iommu.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)

This has already been done by Christoph, see

	https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/commit/?id=7a5dbf3ab2f04905cf8468c66fcdbfb643068bcb

Regards,

	Joerg
