From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 0/9] iommu: clean up/remove modular stuff from
 non-modules.
Date: Tue, 27 Nov 2018 11:11:56 +0100
Message-ID: <20181127101156.GA12298@8bytes.org>
References: <1543271498-28966-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1543271498-28966-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Hiroshi Doyu <hdoyu@nvidia.com>, Honghui Zhang <honghui.zhang@mediatek.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Matthias Brugger <matthias.bgg@gmail.com>, Nate Watterson <nwatters@codeaurora.org>, Rob Clark <robdclark@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Simon Xue <xxm@rock-chips.com>, Stepan Moskovchenko <stepanm@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.
List-Id: iommu@lists.linux-foundation.org

Hi Paul,

thanks for your cleanup!

The iommu-tree uses another rule for the subject line of patches. Can
you please resend with correct subject lines? See below for what is
used.

The general format is:

	iommu/<driver>: _C_apital letter starting subject

Please also collect the Acks you get and add them to the patches before
the resend.

On Mon, Nov 26, 2018 at 05:31:29PM -0500, Paul Gortmaker wrote:
> Paul Gortmaker (9):
>   iommu: audit and remove any unnecessary uses of module.h
Fine.
>   iommu: rockchip: make it explicitly non-modular
	iommu/rockchip: Make it explicitly non-modular
>   iommu: msm_iommu: make it explicitly non-modular
	iommu/msm: Make it explicitly non-modular
>   iommu: mtk_iommu: make it explicitly non-modular
	iommu/mediatek: Make it explicitly non-modular
>   iommu: ipmmu-vmsa: make it explicitly non-modular
	iommu/ipmmu-vmsa: Make it explicitly non-modular
>   iommu: qcom_iommu: make it explicitly non-modular
	iommu/qcom: Make it explicitly non-modular
>   iommu: tegra-gart: make it explicitly non-modular
	iommu/tegra: Make it explicitly non-modular
>   iommu: arm-smmu: make it explicitly non-modular
	iommu/arm-smmu: Make arm-smmu explicitly non-modular
>   iommu: arm-smmu-v3: make it explicitly non-modular
	iommu/arm-smmu: Make arm-smmu-v3 explicitly non-modular

Thanks a lot,

       Joerg
