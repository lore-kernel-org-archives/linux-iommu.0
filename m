From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: arm-smmu: Add binding doc for Qcom
 smmu-500
Date: Thu, 11 Oct 2018 17:16:30 -0500
Message-ID: <20181011221630.GA5841@bogus>
References: <20181011094930.17010-1-vivek.gautam@codeaurora.org>
 <20181011094930.17010-2-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181011094930.17010-2-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: joro@8bytes.org, robh+dt@kernel.org, andy.gross@linaro.org, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, mark.rutland@arm.com, david.brown@linaro.org, linux-kernel@vger.kernel.org, robin.murphy@arm.com, will.deacon@arm.com, dianders@chromium.org, Vivek Gautam <vivek.gautam@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, 11 Oct 2018 15:19:29 +0530, Vivek Gautam wrote:
> Qcom's implementation of arm,mmu-500 works well with current
> arm-smmu driver implementation. Adding a soc specific compatible
> along with arm,mmu-500 makes the bindings future safe.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
> 
> Changes since v3:
>  - Refined language more to state things directly for the bindings
>    description.
> 
>  Documentation/devicetree/bindings/iommu/arm,smmu.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
