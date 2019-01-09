From: Dinh Nguyen <dinguyen@kernel.org>
Subject: Re: [PATCH] arm64: dts: stratix10: Add Stratix10 SMMU support
Date: Wed, 9 Jan 2019 10:22:02 -0600
Message-ID: <773738c7-acce-0d33-5a46-5ebb2360824d@kernel.org>
References: <1546629826-1167-1-git-send-email-thor.thayer@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546629826-1167-1-git-send-email-thor.thayer@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: thor.thayer@linux.intel.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org



On 1/4/19 1:23 PM, thor.thayer@linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> Now there are device tree clocks for the ARM64 SMMU,
> add SMMU support to the Stratix10 Device Tree which
> includes adding the SMMU node and adding IOMMU stream
> ids to the SMMU peripherals.
> 
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
>  arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 29 +++++++++++++++++++++++
>  1 file changed, 29 insertions(+)

Applied!

Thanks,
Dinh
