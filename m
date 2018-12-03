From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 0/9] iommu: clean up/remove modular stuff from
 non-modules.
Date: Mon, 3 Dec 2018 14:32:45 +0100
Message-ID: <20181203133245.cqwrdjbobop7x36y@8bytes.org>
References: <1543691957-17608-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1543691957-17608-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Hiroshi Doyu <hdoyu@nvidia.com>, Honghui Zhang <honghui.zhang@mediatek.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Matthias Brugger <matthias.bgg@gmail.com>, Nate Watterson <nwatters@codeaurora.org>, Rob Clark <robdclark@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Simon Xue <xxm@rock-chips.com>, Stepan Moskovchenko <stepanm@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.
List-Id: iommu@lists.linux-foundation.org

On Sat, Dec 01, 2018 at 02:19:08PM -0500, Paul Gortmaker wrote:
> Paul Gortmaker (9):
>   iommu: audit and remove any unnecessary uses of module.h
>   iommu/rockchip: Make it explicitly non-modular
>   iommu/msm: Make it explicitly non-modular
>   iommu/mediatek: Make it explicitly non-modular
>   iommu/ipmmu-vmsa: Make it explicitly non-modular
>   iommu/qcom: Make it explicitly non-modular
>   iommu/tegra: Make it explicitly non-modular
>   iommu/arm-smmu: Make arm-smmu explicitly non-modular
>   iommu/arm-smmu: Make arm-smmu-v3 explicitly non-modular

Applied all, thanks Paul.
