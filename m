From: Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH v3 01/12] iommu/rockchip: Prohibiat unbind and remove
Date: Thu, 18 Jan 2018 13:17:52 +0900
Message-ID: <CAAFQd5B24j6OSStpYWiO-xfhH131mwNRk3=cEBakMpvsEkQ7wg@mail.gmail.com>
References: <20180117152542.26429-1-jeffy.chen@rock-chips.com> <20180117152542.26429-2-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180117152542.26429-2-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, Ricky Liang <jcliang@chromium.org>, Robin Murphy <robin.murphy@arm.com>, simon xue <xxm@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>Joerg Roedel <joro@8bytes.org>, "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 18, 2018 at 12:25 AM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
> Removal the IOMMUs cannot be done reliably.

nit: Perhaps "Removal of IOMMUs"?

>
> This is similar to exynos iommu driver.
>
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
>
> Changes in v3:
> Also remove remove() and module_exit() as Tomasz suggested.
>
> Changes in v2: None
>
>  drivers/iommu/rockchip-iommu.c | 21 +--------------------
>  1 file changed, 1 insertion(+), 20 deletions(-)

nit: Typo in subject: s/Prohibiat/Prohibit/

Otherwise,

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz
