Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C005F12E5B
	for <iommu@lists.linux.dev>; Thu,  2 May 2024 01:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714614031; cv=none; b=gkWajeAPWuS4BhmONfFecjc8yRz5DMFzDFv10WcKac9Bh1Uza+E2oeCCy/luTJPOsehjG8xfodHlAIYsH/UZod6h4x6OULJUFDzMbefjl//x3vvM9Zymc7GQZq5uvIF2gHmFagF3Hp9EI7x0pu2o5kth4g4m9IWDVffQqDyYJ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714614031; c=relaxed/simple;
	bh=rB8QaHvvVc37SrREtm9E3Ka0ivGapfuZ+pPLjENqNqQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ivzyzr6wdqB5ysiYBlkg62ZjFPk+a3k55PqtrFdUoY9iIgUNYXFeBC2988G3UiSrQsYdIWRrTz/rP8BWj+ssHBgOWGHX/gMmyywAF/et6Cp/LJgCXCmpyp/dBKh2O5tZ8bPKbYTWL+GxjQxLZn3LgC1XwEjloh083xV5PJ5se3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lKC8oalt; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lKC8oalt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714614029; x=1746150029;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rB8QaHvvVc37SrREtm9E3Ka0ivGapfuZ+pPLjENqNqQ=;
  b=lKC8oaltZ4ToAIITWfH43JEy0e3UkuTaXYNIImfqLYKM93u1KBve/3sk
   ofmd2MepQ7xDEzO1rV2gLmi7gdRtOQAJ6U5b0fnRccHj1D1a/GQkl5i8f
   eQ1n6zv6VVMtZJegAz7vJjRwmm6EBT4g2tPoFJbD7pBRGPeuV+LDbIcda
   1LsmhHKVIBqmYox5x+gCrggDeex0kcquXRHbxEBUh+cJYAaVSMEnYjAw3
   fcxCFg3pZBH8v1wqmqMB2Yv9+nI5X1Q4KKtl+nG4OYz4OAysAAlSOVIul
   F9GaSUikkxxgb3InG6QSb1FFiuTX6oNmLCMhgPdnYJpVfdz8+I2gP1FGB
   g==;
X-CSE-ConnectionGUID: x36YSs49QQG3H+I5yVghxA==
X-CSE-MsgGUID: xiLFLo0ZSTazhviqlcSN8w==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="32883903"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="32883903"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 18:40:29 -0700
X-CSE-ConnectionGUID: h5YM6Yf1Q9GE9Rwcx5b5JA==
X-CSE-MsgGUID: QsBLxdJaTuCtZm8iROSJEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31581522"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa004.fm.intel.com with ESMTP; 01 May 2024 18:40:25 -0700
Message-ID: <104358de-ea86-4e25-8942-ba285d6f317b@linux.intel.com>
Date: Thu, 2 May 2024 09:38:54 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <apatel@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Nick Kossifidis <mick@ics.forth.gr>,
 Sebastien Boeuf <seb@rivosinc.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org, iommu@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux@rivosinc.com
Subject: Re: [PATCH v3 5/7] iommu/riscv: Device directory management.
To: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>
References: <cover.1714494653.git.tjeznach@rivosinc.com>
 <ce3b82a20db0b776685269674ce9b7a926d5680d.1714494653.git.tjeznach@rivosinc.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ce3b82a20db0b776685269674ce9b7a926d5680d.1714494653.git.tjeznach@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/1/24 4:01 AM, Tomasz Jeznach wrote:
> @@ -128,6 +489,7 @@ void riscv_iommu_remove(struct riscv_iommu_device *iommu)
>   {
>   	iommu_device_unregister(&iommu->iommu);
>   	iommu_device_sysfs_remove(&iommu->iommu);
> +	riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_MODE_OFF);
>   }
>   
>   int riscv_iommu_init(struct riscv_iommu_device *iommu)
> @@ -138,12 +500,13 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
>   	if (rc)
>   		return dev_err_probe(iommu->dev, rc, "unexpected device state\n");
>   
> -	/*
> -	 * Placeholder for a complete IOMMU device initialization.
> -	 * For now, only bare minimum: enable global identity mapping mode and register sysfs.
> -	 */
> -	riscv_iommu_writeq(iommu, RISCV_IOMMU_REG_DDTP,
> -			   FIELD_PREP(RISCV_IOMMU_DDTP_MODE, RISCV_IOMMU_DDTP_MODE_BARE));
> +	rc = riscv_iommu_iodir_alloc(iommu);
> +	if (rc)
> +		goto err_init;
> +
> +	rc = riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_MODE_MAX);
> +	if (rc)
> +		goto err_init;
>   
>   	rc = iommu_device_sysfs_add(&iommu->iommu, NULL, NULL, "riscv-iommu@%s",
>   				    dev_name(iommu->dev));

The device directory root page might be allocated in
riscv_iommu_iodir_alloc(),

+	if (!iommu->ddt_root) {
+		iommu->ddt_root = riscv_iommu_get_pages(iommu, 0);
+		iommu->ddt_phys = __pa(iommu->ddt_root);
+	}

But I didn't find any place to free it in the error paths. Did I
overlook anything?

Best regards,
baolu
