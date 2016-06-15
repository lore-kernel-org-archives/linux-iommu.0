From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 3/3] iommu: convert DT component matching to
 component_match_add_release()
Date: Wed, 15 Jun 2016 15:31:04 +0200
Message-ID: <20160615133104.GL26566@8bytes.org>
References: <20160603141548.GC1041@n2100.armlinux.org.uk>
 <E1b8pyc-0005OV-7X@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <E1b8pyc-0005OV-7X@rmk-PC.armlinux.org.uk>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jun 03, 2016 at 03:21:30PM +0100, Russell King wrote:
> Convert DT component matching to use component_match_add_release().
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/iommu/mtk_iommu.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)

Applied, thanks.
