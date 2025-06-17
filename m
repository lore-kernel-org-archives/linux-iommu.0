Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D406F2BEFF3
	for <iommu@lists.linux.dev>; Tue, 17 Jun 2025 10:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750155638; cv=none; b=Powf3saNFIoHX5cWkL8c9zWcyxmQUwwLgMspWiU4HHYzoGePL2XUlROUh9bGX3uCQdrRRgZYwcmk1gxy0inpoK1j7kbpZMtuBVKOAfVjTV9X6TIh5/fYdu6YZVhXm+VJZYaJi/3PfGcnL8em9G3MlWv98X53nDNO/QdWWlo5sbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750155638; c=relaxed/simple;
	bh=eBW41vqY5xJiQy10C1mP/0GzsMdKQV16PWKKrruJKuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=l/fevGbfgQvTsSpAC4Hnzoh6H5i9VWspJaNvBKmUUdyzSUbZPMX1B6Iy7PoXV02pFpiaK+Ck3LYOPYHckbDKaqvz9CU3mvdZRHOVB7IyUge6qiA57OtUrHDw0j5sPntBqJcErC50n8ltytRB5Abm3xb9J2SA29cel4tE+OQlM5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36B681596;
	Tue, 17 Jun 2025 03:20:15 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 921183F58B;
	Tue, 17 Jun 2025 03:20:33 -0700 (PDT)
Message-ID: <4b74ff9d-7451-4c11-b9ad-66ffd83fd2d2@arm.com>
Date: Tue, 17 Jun 2025 11:20:32 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/4] arm64: cpufeature: Introduce MATCH_ALL_EARLY_CPUS
 capability type
To: =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
 ryan.roberts@arm.com, yang@os.amperecomputing.com, catalin.marinas@arm.com,
 will@kernel.org, jean-philippe@linaro.org, robin.murphy@arm.com,
 joro@8bytes.org, maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
 james.morse@arm.com, broonie@kernel.org, ardb@kernel.org, baohua@kernel.org,
 david@redhat.com, jgg@ziepe.ca, nicolinc@nvidia.com, jsnitsel@redhat.com,
 mshavit@google.com, kevin.tian@intel.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20250617095104.6772-1-miko.lenczewski@arm.com>
 <20250617095104.6772-2-miko.lenczewski@arm.com>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20250617095104.6772-2-miko.lenczewski@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/06/2025 10:51, Mikołaj Lenczewski wrote:
> From: Catalin Marinas <catalin.marinas@arm.com>
> 
> For system-wide capabilities, the kernel has the SCOPE_SYSTEM type. Such
> capabilities are checked once the SMP boot has completed using the
> sanitised ID registers. However, there is a need for a new capability
> type similar in scope to the system one but with checking performed
> locally on each CPU during boot (e.g. based on MIDR_EL1 which is not a
> sanitised register).
> 
> Introduce ARM64_CPUCAP_MATCH_ALL_EARLY_CPUS which, together with
> ARM64_CPUCAP_SCOPE_LOCAL_CPU, ensures that such capability is enabled
> only if all early CPUs have it. For ease of use, define
> ARM64_CPUCAP_EARLY_LOCAL_CPU_FEATURE which combines SCOPE_LOCAL_CPU,
> PERMITTED_FOR_LATE_CPUS and MATCH_ALL_EARLY_CPUS.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
> Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
> ---

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

