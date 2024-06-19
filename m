Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F02770FA
	for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 12:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718801170; cv=none; b=YqoCEnG883vjvI0kXBqIMvkt/ZkvEA7sKES1xT9dK8nkwJdWR9V7aNNPaKt2lBZNfLda160NWyGnbr2vSQkU5sA3c+I9wUKXuQ/0Hlznd8dlZRnC6At1tp6ij6suThieFqx1D5Iu/VmX/lz4OFVDYNftkOIWXJu7WnEZuinWlnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718801170; c=relaxed/simple;
	bh=A18lYP5BdCr43fW19fZ/J/98CKMZ+MMqipWAn49xL+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T9WRSvHws8EBC1e7rarSWXFWmcrFhqrTenRByM7wkHUZ6KWeOgRle9LWivtIaYyQbIXvTot4jN85m1lss4AYXZ47qsBJRu5IB4TkjrF2YnBJFLrm8v1yuoU/yqLMYvgTPQNmmK68Vy+DGJQuSCESRX3HKEiAO+m3X1KDSrbLJCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2FB31042;
	Wed, 19 Jun 2024 05:46:31 -0700 (PDT)
Received: from [10.57.71.86] (unknown [10.57.71.86])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A92F43F6A8;
	Wed, 19 Jun 2024 05:46:05 -0700 (PDT)
Message-ID: <000bca96-dd66-49d2-a540-f4cf36d74ee8@arm.com>
Date: Wed, 19 Jun 2024 13:46:03 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] New config added to handle 64-bit systems with 32-bit DMA
 support
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Alberto Secondi <albertosecondi@gmail.com>, hch@lst.de,
 m.szyprowski@samsung.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, alberto.secondi@abinsula.com,
 Davide Salaris <davide.salaris@abinsula.com>
References: <20240619091737.669040-1-albertosecondi@gmail.com>
 <0e03afd6-46be-4fc7-a974-bf506d8e503c@arm.com>
 <CAOf5uwkU1qCxC=OamNHLq3d3SZGVuX8_eh1_MYt6TELT4C1j5Q@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CAOf5uwkU1qCxC=OamNHLq3d3SZGVuX8_eh1_MYt6TELT4C1j5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024-06-19 12:43 pm, Michael Nazzareno Trimarchi wrote:
> Hi Robin
> 
> On Wed, Jun 19, 2024 at 12:36 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2024-06-19 10:17 am, Alberto Secondi wrote:
>>> ------ Tessian Warning ------
>>>
>>> Be careful, the email's sending address "albertosecondi@gmail[.]com" has never been seen on your company's network before today
>>>
>>> This warning message will be removed if you reply to or forward this email to a recipient outside of your organization.
>>>
>>> ---- Tessian Warning End ----
>>>
>>> From: Alberto Secondi <alberto.secondi@abinsula.com>
>>>
>>> The kernel assumes that 64-bit systems have 64-bit DMA support through
>>> CONFIG_ARCH_DMA_ADDR_T_64BIT. This is not always true; for example, several
>>> iMX8 systems (verified on iMX8MM and iMX8MP) have DMA with only 32-bit support.
>>> This results in several drivers requesting DMA_BIT_MASK(64), which causes
>>> malfunctions, particularly when systems have more than 3GB of DRAM (verified
>>> with the lan743x driver and iMX8 systems with 4GB of DRAM). Therefore, a new
>>> config ARCH_64BIT_HAS_DMA32_ONLY was added to manage 64-bit systems with 32-bit
>>> DMA, which adjusts DMA_BIT_MASK(n) accordingly.
>>
>> No. If a system has devices naturally capable of >32-bit DMA, and memory
>> at >32-bit system physical addresses, but only a 32-bit interconnect in
>> between, that needs to be described properly in Devicetree/ACPI, not
>> hacked around with completely non-portable kernel bodges.
>>
> 
> commit 4251a3ac4de9625a284a9c046cc915487e9b2a5e
> Author: Lucas Stach <l.stach@pengutronix.de>
> Date:   Tue May 4 10:20:51 2021 +0200
> 
>      arm64: dts: imx8mm: specify dma-ranges
> 
>      DMA addressing capabilities on i.MX8MM are limited by the interconnect,
>      same as on i.MX8MQ. Add dma-ranges to the the peripheral bus to let
>      the kernel know about this.
> 
>      Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
>      Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>      Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>      Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index 64aa38fd2b6e0..e7648c3b83905 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -261,6 +261,7 @@ soc@0 {
>                  #address-cells = <1>;
>                  #size-cells = <1>;
>                  ranges = <0x0 0x0 0x0 0x3e000000>;
> +               dma-ranges = <0x40000000 0x0 0x40000000 0xc0000000>;
>                  nvmem-cells = <&imx8mm_uid>;
>                  nvmem-cell-names = "soc_unique_id";
> 
> 
> Somenthing like this should already do it?

Hmm, indeed... so the question to dig into would be why that's 
apparently not getting picked up by of_dma_get_range() for that device.

Thanks,
Robin.
