Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A0C7E
	for <iommu@lists.linux.dev>; Sat, 31 Dec 2022 13:35:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23F6C433EF;
	Sat, 31 Dec 2022 13:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1672493703;
	bh=dUnijUHbgerYaBzn9Rg23kVSkLXe70+EE1pNnR1zUuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cHSEUqYKnvGPlARWi/AMAcNkhRPToDn/GslN7uuW7RCqWuaQYIkinrbZS7FQZnSNg
	 KJvdsv/d106SjzhUn94GO+7gkl7XeUUKYTbOzvZSPF06l6vyeVVFrjnUB83YnlxbJ7
	 0QgKMIrjv9W/IgRGE3h6V1Jica9hfh4tquR+7iH092UQEBdqprp1cLxtc6mJiqmx7B
	 pnauiV8ZT94c4SdYOgdZs4EMBN22OtSuiFEOOdWKOetoRrL3sQxGQ9h44j+WSwvjAk
	 muZa1FADl9+FohPmFi2kYrMf9QUU0BVWMJFaVdq3WeHi2Vz0CBtbKcFOdgExKpe6jP
	 AhHJtzDcCQ4IA==
Date: Sat, 31 Dec 2022 21:34:55 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: devicetree@vger.kernel.org, iommu@lists.linux.dev,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org, Li Yang <leoyang.li@nxp.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v2 1/2] arm64: dts: ls1028a: declare cache-coherent page
 table walk feature for IOMMU
Message-ID: <20221231133454.GF6112@T480>
References: <20221215135636.3684026-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215135636.3684026-1-vladimir.oltean@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Thu, Dec 15, 2022 at 03:56:35PM +0200, Vladimir Oltean wrote:
> The SMMUv2 driver for MMU-500 reads the ARM_SMMU_GR0_ID0 register at
> probe time and tries to determine based on the CTTW (Coherent
> Translation Table Walk) bit whether this feature is supported.
> 
> Unfortunately, it looks like the SMMU integration in the NXP LS1028A has
> wrongly tied the cfg_cttw signal to 0, even though the SoC documentation
> specifies that "The SMMU supports cache coherency for page table walks
> and DVM transactions for page table cache maintenance operations."
> 
> Device tree provides the option of overriding the ID register via the
> dma-coherent property since commit bae2c2d421cd ("iommu/arm-smmu: Sort
> out coherency"), and that's what we do here.
> 
> Telling struct io_pgtable_cfg that the SMMU page table walks are
> coherent with the CPU caches brings performance benefits, because it
> avoids certain operations such as __arm_lpae_sync_pte() for PTE updates.
> 
> Link: https://lore.kernel.org/linux-iommu/3f3112e4-65ff-105d-8cd7-60495ec9054a@arm.com/
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Applied both, thanks!
