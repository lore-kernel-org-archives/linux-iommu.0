From: Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH v2 05/13] iommu/rockchip: Fix error handling in init
Date: Wed, 17 Jan 2018 14:26:43 +0900
Message-ID: <CAAFQd5AFHheE+5Dx=0=BeL2W1EYd=Kmcb8fKcCBFRgP8ViuxgQ@mail.gmail.com>
References: <20180116132540.18939-1-jeffy.chen@rock-chips.com> <20180116132540.18939-6-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180116132540.18939-6-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, Ricky Liang <jcliang@chromium.org>, Robin Murphy <robin.murphy@arm.com>, simon xue <xxm@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 16, 2018 at 10:25 PM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
> It's hard to undo bus_set_iommu() in the error path, so move it to the
> end of rk_iommu_probe().

Does this work fine now? I remember we used to need this called in an
early initcall for all the ARM/ARM64 DMA stuff to work.

Best regards,
Tomasz
