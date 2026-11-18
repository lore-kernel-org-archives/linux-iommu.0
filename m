Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795033959;
	b=QWwuijXwuax7Ud30aLXDimDCwrPmAO9aDfZOl/FbV5d5xD0U4QbXF2VxlFauyu6iu/v9
	 v7r/gWtha+ImzK2Tic5/oCMxvxJj8gRXcWp3Lwkvo5aAbvOjjYjLTWrtD52KS57FwVy7g
	 KeJSGtufUUYVu58DpjyswZaPWT4qsxG7kJnCg+hZL+0BEmRZBvvLdkt2rQSxQVWkYdHiX
	 EP99xlb2Z++RwM9quf2pxM3bncmCoBLUpAN90/zu/qdqp/1jo0LY8eMZtBFqMY1gqGK7E
	 v0VR7okxY2oJ78sY4IqaSfs2ft0B4sULexzJ6l85djIwOObbPpKcTLDrJW2Wd0ADWCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795033959;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=XJmqha3jczEcaerimpEtNez8vFhS9CMO3UzYk56rIsY=;
	b=0ghSkzCfdoB0SbASpzB7QbSpayTuqJg3UBjLLad1ms5VIHlLeKeoVUCNWnivLO2hZhSl
	 FiyagKf3OCv5QKII0MGlkXGAdY/DBFLyBEobHIXqyJLt9n0hRMSZQIBCVbaWKt3sMmdG1
	 5PtU3nTVOlVc1RJMit7E0fEQl4WJb+mk4syixrc6V91DJvCRfXubI0qz9Iga2S+acpSy7
	 68BHeqiAAJ247cRAeSMhkfK3vIdZBuCUCdsYF0bCYTPB6lQq5mzGVHQJEMqCJK5m8yXku
	 Te6aqawegYIa0jHZeCKcOmZCcWrmqhGcNCVNWF8610WjbHwyBzlfgQFhFCYWMkkr+4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ak41hTEh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F014B606A333;
	Wed, 18 Nov 2026 20:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ak41hTEh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9666B1F000C6;
	Wed, 18 Nov 2026 20:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795033958;
	bh=XJmqha3jczEcaerimpEtNez8vFhS9CMO3UzYk56rIsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ak41hTEh2Or4toXQzz7176z2UqaczmbWwvTnufoviYFJytOETfRg2aa0QK/68A9Nm
	 gxIYDh6Ag75SdaG3TKZW+16O2wyybY+cPkHsLxDWD/QC6bQ5ym6fGzH9mXMsP5DIN3
	 RHP8zK8feAO8BB4Mab8J7Y97Ukhy6y5e7wtbkPSyl4jNHX5Gx8z9d2Rd9qpgn4b7jr
	 auWnbP5kFSpwUUmbK7pHZg5D0Ah7yuAxK01zgG47x/QVPNEYHIg57EsxCwJ2N6MCb9
	 jY8keMjByapseewDHzDH4TGhtnl06j0T31BCfNER9ddo3G9guNLbixjZlh1e4oJdCw
	 NFaYBExwJyP7A==
Date: Wed, 18 Nov 2026 14:32:36 -0600
From: Rob Herring <robh@kernel.org>
To: Arun Iyengar <aiyengar1990@gmail.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Niklas Cassel <cassel@kernel.org>,
	Pranjal Shrivastava <praan@google.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>,
	Finley Xiao <finley.xiao@rock-chips.com>
Subject: Re: [PATCH v3 2/3] iommu/arm-smmu-v3: Enable an optional clock
Message-ID: <20261118203236.GA823624-robh@kernel.org>
References: <20261113-smmu-v3-pcie-pd-v3-0-39eb4f919529@gmail.com>
 <20261113-smmu-v3-pcie-pd-v3-2-39eb4f919529@gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113-smmu-v3-pcie-pd-v3-2-39eb4f919529@gmail.com>

On Fri, Nov 13, 2026 at 08:45:06AM +0000, Arun Iyengar wrote:
> On the RK3588 the PCIe SMMU's clock is gated as unused when no PCIe
> controller holds it, and the next register access (the CR0 write at
> shutdown) hangs. Enable the clock from the firmware node, if there is
> one, while the driver is bound.
> 
> Do it first in probe, as the firmware probe may take a Tegra CMDQV
> reference that only arm_smmu_impl_probe() releases.
> 
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 6d4520c47308..d3f42316b0d6 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -12,6 +12,7 @@
>  #include <linux/acpi.h>
>  #include <linux/acpi_iort.h>
>  #include <linux/bitops.h>
> +#include <linux/clk.h>
>  #include <linux/crash_dump.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
> @@ -5786,12 +5787,22 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	resource_size_t ioaddr;
>  	struct arm_smmu_device *smmu;
>  	struct device *dev = &pdev->dev;
> +	struct clk *clk;
>  
>  	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
>  	if (!smmu)
>  		return -ENOMEM;
>  	smmu->dev = dev;
>  
> +	/*
> +	 * Before the firmware probe: it may take a reference on the Tegra
> +	 * CMDQV device that only arm_smmu_impl_probe() releases.
> +	 */
> +	clk = devm_clk_get_optional_enabled(dev, NULL);
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dev, PTR_ERR(clk),
> +				     "failed to enable clock\n");

The primary point of the "optional" flavor of get functions is so the 
get function itself can print an error rather than every driver doing 
it. So drop the error print here.

Rob
