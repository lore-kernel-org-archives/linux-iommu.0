Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813852F3E
	for <iommu@lists.linux.dev>; Thu, 30 Mar 2023 13:43:05 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F21482F4;
	Thu, 30 Mar 2023 06:43:48 -0700 (PDT)
Received: from [10.57.54.254] (unknown [10.57.54.254])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCB1F3F663;
	Thu, 30 Mar 2023 06:43:02 -0700 (PDT)
Message-ID: <beae35a5-b094-087a-8443-5f669a2a37c6@arm.com>
Date: Thu, 30 Mar 2023 14:42:55 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/3] iommu/rockchip: Disable the device link during resume
Content-Language: en-GB
To: Jagan Teki <jagan@amarulasolutions.com>, Heiko Stuebner
 <heiko@sntech.de>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: iommu@lists.linux.dev, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-amarula <linux-amarula@amarulasolutions.com>,
 Simon Xue <xxm@rock-chips.com>
References: <20230330131746.1475514-1-jagan@amarulasolutions.com>
 <20230330131746.1475514-2-jagan@amarulasolutions.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230330131746.1475514-2-jagan@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-03-30 14:17, Jagan Teki wrote:
> Rockchip iommu is trying to enable the associated device at runtime
> resume however some devices might enable the iommu during their pm
> runtime resume operation which indeed leads iommu to use the wrong
> domain and this leads to device iommu page fault.
> 
> An example of this behavior has been observed in Rockchip RK3328, where
> iommu stalls request timeout dring VOP device enablement.
> 
> Here is the dmesg log for the same:
> 
> rockchip-drm display-subsystem: bound ff370000.vop (ops vop_component_ops)
> dwhdmi-rockchip ff3c0000.hdmi: supply avdd-0v9 not found, using dummy regulator
> rk_iommu ff373f00.iommu: Enable stall request timed out, status: 0x00004b
> dwhdmi-rockchip ff3c0000.hdmi: supply avdd-1v8 not found, using dummy regulator
> rk_iommu ff373f00.iommu: Disable paging request timed out, status: 0x00004b
> dwhdmi-rockchip ff3c0000.hdmi: Detected HDMI TX controller v2.11a with HDCP (inno_dw_hdmi_phy2)
> dwhdmi-rockchip ff3c0000.hdmi: registered DesignWare HDMI I2C bus driver
> rockchip-drm display-subsystem: bound ff3c0000.hdmi (ops dw_hdmi_rockchip_ops)
> [drm] Initialized rockchip 1.0.0 20140818 for display-subsystem on minor 0
> 
> This issue is reproduced if we enable the display in U-Boot however
> U-Boot is not even touched any iommu register as the U-Boot display
> uses the simple frame buffer like other Rockchip platforms RK3399,
> and RK3328 do.
> 
> When VOP is trying to enable the iommu using runtime resume call
> pm_runtime_resume_and_get from @vop_enable then the iommu runtime
> resume call @rk_iommu_resume will try to attach the VOP in the wrong
> domain via @rk_iommu_enable will lead to the vop iommu page fault.

That sounds like a driver bug. The whole point of the device link is 
supposed to be that the IOMMU gets suspended after the VOP, and resumed 
before it, so it can make sure that whatever translations the VOP was 
using are restored *before* the VOP starts trying to access them again. 
If the IOMMU driver is failing to restore the correct state on resume, 
no amount of DT abuse is the right answer.

I can understand if the IOMMU itself expects to be idle for the initial 
configuration at probe time, and gets unhappy if we try to reset it 
while (bypass) VOP traffic for the bootloader framebuffer is still going 
through, but that's an entirely different issue, and again hacking 
around with runtime PM doesn't seem like the right answer.

Thanks,
Robin.

> 
> vop_enable()
>     pm_runtime_resume_and_get()
>        rk_iommu_resume()
>           rk_iommu_enable()
>              ... vop iommu page fault ...
> 	    rk_iommu ff373f00.iommu: Enable stall request timed out, status: 0x00004b
> 	    rk_iommu ff373f00.iommu: Disable paging request timed out, status: 0x00004b
> 
> So, this patch is trying to disable the device link for those devices
> that are enabled rockchip,disable-device-link-resume flag assumes here
> VOP device.
> 
> This makes the device enablement for that iommu domain ignored during
> the rk_iommu_resume call as it assumes it handled iommu device
> attachment in the associated device itself.
> 
> vop_enable()
>     pm_runtime_resume_and_get()
>        rk_iommu_resume()
>           ... ignore the device link ...
> 	    rockchip_drm_dma_attach_device()
> 	       iommu_attach_device()
> 
> Here is the downstream patch for similar issue,
> https://github.com/rockchip-linux/kernel/commit/85959f645ba38617233fbf44f442f8a88875d765
> 
> Co-developed-by: Simon Xue <xxm@rock-chips.com>
> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>   drivers/iommu/rockchip-iommu.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index f30db22ea5d7..bcff0dc21223 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -111,6 +111,7 @@ struct rk_iommu {
>   	struct clk_bulk_data *clocks;
>   	int num_clocks;
>   	bool reset_disabled;
> +	bool dlr_disable; /* avoid access iommu when runtime ops called */
>   	struct iommu_device iommu;
>   	struct list_head node; /* entry in rk_iommu_domain.iommus */
>   	struct iommu_domain *domain; /* domain to which iommu is attached */
> @@ -1250,6 +1251,8 @@ static int rk_iommu_probe(struct platform_device *pdev)
>   
>   	iommu->reset_disabled = device_property_read_bool(dev,
>   					"rockchip,disable-mmu-reset");
> +	iommu->dlr_disable = device_property_read_bool(dev,
> +					"rockchip,disable-device-link-resume");
>   
>   	iommu->num_clocks = ARRAY_SIZE(rk_iommu_clocks);
>   	iommu->clocks = devm_kcalloc(iommu->dev, iommu->num_clocks,
> @@ -1346,6 +1349,9 @@ static int __maybe_unused rk_iommu_suspend(struct device *dev)
>   	if (!iommu->domain)
>   		return 0;
>   
> +	if (iommu->dlr_disable)
> +		return 0;
> +
>   	rk_iommu_disable(iommu);
>   	return 0;
>   }
> @@ -1357,6 +1363,9 @@ static int __maybe_unused rk_iommu_resume(struct device *dev)
>   	if (!iommu->domain)
>   		return 0;
>   
> +	if (iommu->dlr_disable)
> +		return 0;
> +
>   	return rk_iommu_enable(iommu);
>   }
>   
