Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A382519A0A
	for <iommu@lists.linux.dev>; Thu, 20 Jul 2023 12:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689856974; x=1721392974;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JaJ/lkSSzUjKz6n6+OtO6yZ6zwybCck47wRM8qdASR0=;
  b=c1uJgjve0caO4kd7gTa6y6OpC1nXw67EcBT4SBdIjZIXJjT/UAIMMlw6
   jFHPDsHaO4a/X0a1FbcLHMZNOoEUoTzxveIww3Ti4GdK/K2/dPYfMHlmP
   aSc4pExBeeafyHBCp1qtpNB2b7K+jeS6oN5p64k+XVy1GWctD/XxeMmF/
   dMGgU6KY6g+e1tMLEWIO1VGhmgZj6g+A4uBL90nGv8jB3OAEhAdJzKyu0
   HQm0Y/2SSsMmo15JAkxuRii5XXPGBaqsjNsWVXW2TpOcXXd7ZAmX/BqSH
   Q0BVhASV1suRwaiYs/mv9INSw3/AXLkGrGoOsTWLnF44r3b0nZYt3HyzX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="397594576"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="397594576"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 05:42:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="701605663"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="701605663"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.191.109]) ([10.252.191.109])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 05:42:47 -0700
Message-ID: <376985dd-a8b9-b86a-3c12-4633dd4505d7@linux.intel.com>
Date: Thu, 20 Jul 2023 20:42:43 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: baolu.lu@linux.intel.com, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <apatel@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Nick Kossifidis <mick@ics.forth.gr>,
 Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux@rivosinc.com
Subject: Re: [PATCH 04/11] MAINTAINERS: Add myself for RISC-V IOMMU driver
Content-Language: en-US
To: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>
References: <cover.1689792825.git.tjeznach@rivosinc.com>
 <e1578b96b9c75433d8c49b6a173ff47a64675c2b.1689792825.git.tjeznach@rivosinc.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <e1578b96b9c75433d8c49b6a173ff47a64675c2b.1689792825.git.tjeznach@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/7/20 3:33, Tomasz Jeznach wrote:
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> ---
>   MAINTAINERS | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aee340630eca..d28b1b99f4c6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18270,6 +18270,13 @@ F:	arch/riscv/
>   N:	riscv
>   K:	riscv
>   
> +RISC-V IOMMU
> +M:	Tomasz Jeznach <tjeznach@rivosinc.com>
> +L:	linux-riscv@lists.infradead.org

Please add the iommu subsystem mailing list.

iommu@lists.linux.dev

It's the right place to discuss iommu drivers.

> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> +F:	drivers/iommu/riscv/
> +
>   RISC-V MICROCHIP FPGA SUPPORT
>   M:	Conor Dooley <conor.dooley@microchip.com>
>   M:	Daire McNamara <daire.mcnamara@microchip.com>

Best regards,
baolu
