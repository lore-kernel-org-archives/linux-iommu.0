From: Thor Thayer <thor.thayer@linux.intel.com>
Subject: Re: [PATCHv4 0/2] iommu/arm-smmu: Add Stratix10 SMMU Support
Date: Tue, 30 Oct 2018 08:38:17 -0500
Message-ID: <65377977-8534-557a-b77b-f5f8f6962385@linux.intel.com>
References: <1538773020-27784-1-git-send-email-thor.thayer@linux.intel.com>
Reply-To: thor.thayer@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538773020-27784-1-git-send-email-thor.thayer@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org, aisheng.dong@nxp.com, sboyd@kernel.org
Cc: vivek.gautam@codeaurora.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

Gentle ping...

On 10/05/2018 03:56 PM, thor.thayer@linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> Add SMMU support for the Stratix10 SOCFPGA. This patch requires
> clock enables for the master TBUs and therefore has a dependency
> on patches currently being reviewed.
> 
> This patchset is dependent on the patch series [1]
> 
> v4  Address Vivek's comment.
>      Abandon dependency on [2] (no recent activity/reviews)
>      Implement device tree parsing of clock on top of [1].
> v3  Address comment from Robin and change dependency on device
>      tree bulk clock patches [2].
> v2  Change to dependency on [1].
> 
> [1] [v16,0/5] iommu/arm-smmu: Add runtime pm/sleep support
> https://patchwork.kernel.org/cover/10581891/
> 
> [2] [PATCH V6 0/4] clk: new APIs to handle all available clocks
> https://lkml.org/lkml/2018/8/31/97
> 
> Thor Thayer (2):
>    arm64: dts: stratix10: Add Stratix10 SMMU support
>    iommu/arm-smmu: Get clock config from device tree
> 
>   arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 29 ++++++++++++++++++++++
>   drivers/iommu/arm-smmu.c                          | 30 ++++++++++++++++++++---
>   2 files changed, 56 insertions(+), 3 deletions(-)
> 

Any comments on this patchset? I realize the dependency still needs to 
be accepted but the clock portion of the dependency which is what this 
patch builds on hasn't changed in the last iterations.
