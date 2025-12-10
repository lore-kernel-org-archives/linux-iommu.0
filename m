Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0799318120;
	Wed, 10 Dec 2025 12:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765370398; cv=none; b=Z4riaZPPc75Imltz8IkLaIUakvxUZLmmxiD5miGP6fcitGcDPaX9Nz2GJi8EeC2cM0rdMWjRYPm/4i2KkIiAO7Eo+SXVX2MNfCVunEsGRD7cnuZVzFjFzubHwvqNUb9TJoG7GLNbvaqlg7kRV3NHj3zVbu4sebLLYFt8wU+nu4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765370398; c=relaxed/simple;
	bh=ltoA8PAYbQchGv4Tq5FjVCH2RTUlYr/gKQZiFv2B4qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qHkNujKvu8hyLKZtY8YYsbfxy26BZUDP+oo3X7nSIn01U+rsphXDglrqMLYtnV/EfBlqZbgAmu+5kOHUNftDa5QeU80TqIl8l7GApvwA9xU5fCIXheG2kNRVTSzAgb5WqYMsOsn8TTyRTVL05S3KLaULJIHCPQ+omugFFRjlkjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD58C153B;
	Wed, 10 Dec 2025 04:39:48 -0800 (PST)
Received: from [10.57.45.247] (unknown [10.57.45.247])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1E4D3F73B;
	Wed, 10 Dec 2025 04:39:52 -0800 (PST)
Message-ID: <e7c69e9c-6af4-468a-88ed-fb8829afb92e@arm.com>
Date: Wed, 10 Dec 2025 12:39:49 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/3] iommu/arm-smmu-v3: Add device-tree support for
 CMDQV driver
To: Ashish Mhetre <amhetre@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Cc: oe-kbuild-all@lists.linux.dev, thierry.reding@gmail.com,
 jonathanh@nvidia.com, vdumpa@nvidia.com, jgg@ziepe.ca,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, joro@8bytes.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, kernel test robot <lkp@intel.com>,
 will@kernel.org
References: <20251205065850.3841834-2-amhetre@nvidia.com>
 <202512090331.QAFgb6vQ-lkp@intel.com>
 <2bf7bb25-9a6b-42d5-b095-978f7bb81f35@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <2bf7bb25-9a6b-42d5-b095-978f7bb81f35@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-12-10 5:19 am, Ashish Mhetre wrote:
[...]
> Hi Robin, Nic,
> We removed ACPI dependency in Kconfig but driver still depends
> on ACPI for these functions. I will be protecting ACPIspecific
> tegra241-cmdqv code under CONFIG_ACPI similar to what is done
> in arm-smmu-v3 driver. Is this the correct thing to do or do you
> have any other suggestions?

Yes, when I commented that "depends on ACPI || OF" was functionally the 
same as just removing "depends on ACPI", I didn't mean to suggest that 
wasn't necessarily a genuine dependency still.

I guess if you can wrap the ACPI-specific functions in a single #ifdef 
block that's reasonable, however I do now wonder whether things couldn't 
be factored out a bit more - if it's a standard DSDT/SSDT namespace 
device, shouldn't there also be a corresponding platform device created 
for it, which we could look up instead of delving directly into the _CRS 
of the ACPI node itself? (not sure off-hand if there's a straightforward 
inverse of ACPI_COMPANION()...)

Thanks,
Robin.
