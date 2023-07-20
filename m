Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9762619A0B
	for <iommu@lists.linux.dev>; Thu, 20 Jul 2023 10:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689849527; x=1721385527;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MUQDGWmX3jQPF4kFi+U/N/uImNqXd8LSFOduoqtvDBc=;
  b=lh9Rsv7MDnNfdg0Kz6gC/1d9+2ZPd/W/RUYZ7iDVkiHtwFcl3h4k4jvC
   iEPxDBqSUE4Ap2Q6yXp/cW2K1qM/oR5vEvgzuyN0GUgvf953q6QJQILBi
   ZLHuU2yc4+8k5+BVoBPeumE+nz4N14j2WKFc16nkt6074RH0XDVIcPXu9
   OiRT3PuMrC8dok75AT5rAIWk0HeVIYnykwF3oCNelPAtxajAXXzaXh9t1
   Hrt0r0ng57H4Bv8hdxBIBO4DRyfOReTovt+aCWKjOZIQ6h1sguCwADM0z
   ITj/DkmydiK/RzZXQL09dU8VQ6R5i1IqgcMtDsYzElKvSdvcGPamsfoVa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="370263493"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="370263493"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 03:38:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="789754715"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="789754715"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.191.109]) ([10.252.191.109])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 03:38:41 -0700
Message-ID: <68e3a7ab-0387-3e58-8c30-3ace807acee5@linux.intel.com>
Date: Thu, 20 Jul 2023 18:38:37 +0800
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
Subject: Re: [PATCH 01/11] RISC-V: drivers/iommu: Add RISC-V IOMMU - Ziommu
 support.
Content-Language: en-US
To: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>
References: <cover.1689792825.git.tjeznach@rivosinc.com>
 <c33c24036c06c023947ecb47177da273569b3ac7.1689792825.git.tjeznach@rivosinc.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <c33c24036c06c023947ecb47177da273569b3ac7.1689792825.git.tjeznach@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/7/20 3:33, Tomasz Jeznach wrote:
> +struct riscv_iommu_domain {
> +	struct iommu_domain domain;
> +
> +	struct list_head endpoints;
> +	struct mutex lock;
> +	struct riscv_iommu_device *iommu;

How are domains and iommu devices connected? A domain can be attached to
multiple devices, which are possibly behind different iommu devices. So
a domain is possibly connected to multiple iommu devices.

Is it possible?

> +
> +	unsigned mode;		/* RIO_ATP_MODE_* enum */
> +	unsigned pscid;		/* RISC-V IOMMU PSCID */
> +
> +	pgd_t *pgd_root;	/* page table root pointer */
> +};
> +
> +/* Private dev_iommu_priv object, device-domain relationship. */
> +struct riscv_iommu_endpoint {
> +	struct device *dev;			/* platform or PCI endpoint device */
> +	unsigned devid;      			/* PCI bus:device:function number */
> +	unsigned domid;    			/* PCI domain number, segment */
> +	struct rb_node node;    		/* device tracking node (lookup by devid) */
> +	struct riscv_iommu_device *iommu;	/* parent iommu device */
> +
> +	struct mutex lock;
> +	struct list_head domain;		/* endpoint attached managed domain */
> +};

Best regards,
baolu
