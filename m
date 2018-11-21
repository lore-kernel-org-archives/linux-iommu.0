From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v4 0/2] Enable smmu support on sdm845
Date: Wed, 21 Nov 2018 15:52:49 +0000
Message-ID: <20181121155249.GA24883@arm.com>
References: <20181011094930.17010-1-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181011094930.17010-1-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: joro@8bytes.org, robh+dt@kernel.org, andy.gross@linaro.org, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, mark.rutland@arm.com, david.brown@linaro.org, linux-kernel@vger.kernel.org, robin.murphy@arm.com, dianders@chromium.org
List-Id: iommu@lists.linux-foundation.org

Hi Vivek,

On Thu, Oct 11, 2018 at 03:19:28PM +0530, Vivek Gautam wrote:
> This series enables apps-smmu, the "arm,mmu-500" instance
> on sdm845.
> Series tested on SDM845 MTP device with related smmu patch series [1],
> and necessary config change, besides one hack to keep LDO14 in LPM mode
> to boot things up (see the commit in the test branch).
> The tested branch is available at [2].

[...]

>  .../devicetree/bindings/iommu/arm,smmu.txt         |  4 ++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi               | 72 ++++++++++++++++++++++
>  2 files changed, 76 insertions(+)

Given that this doesn't touch any of the driver code, please take this via
the Andy and arm-soc.

Will
