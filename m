Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E26C183CB0
	for <iommu@lists.linux.dev>; Fri,  7 Mar 2025 20:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741378824; cv=none; b=n74GpCv6yx1k+W/GYBwJvSx8FwTMR6z/mwxaOE5/Tb7D9FFEKasuuebxYtUC9qLPCLiUC2aiAHVYKixnlwWw7ePis7XBQc4/Mh7Ykk1etaliKAgS8gHblYHA6o3582ByMxlrKy2hSZHwZydPQw2LQtlDfaUqGSyyBUt7oG+ZunU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741378824; c=relaxed/simple;
	bh=JpJH0rWkOmn0NClRLdATD4XUL+hcKgZciootdkF/49Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ivTePREIJ5F3MiEQrPfZM3tDe9plLxMksGc+nuL9rJnhqESbWFSEnAudfnt9aVmgDVCHhcvzr4JPte8yYhExJTA3uaP61XfLWZCZYvgx8N3PTAGWWT8BoQWUVVfwg0CrOIrGW0jF5eiv4s2nDvitTtXJWYkMTAIAydb4WCZfYJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55B7413D5;
	Fri,  7 Mar 2025 12:20:34 -0800 (PST)
Received: from [10.57.37.135] (unknown [10.57.37.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A666F3F5A1;
	Fri,  7 Mar 2025 12:20:17 -0800 (PST)
Message-ID: <ea78c21b-db4a-4144-b1b5-b1a37e1ed51c@arm.com>
Date: Fri, 7 Mar 2025 20:20:15 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iommu: Get DT/ACPI parsing into the proper probe
 path
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Stuart Yoder <stuyoder@gmail.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>, Nipun Gupta
 <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, Charan Teja Kalla <quic_charante@quicinc.com>
References: <cover.1740753261.git.robin.murphy@arm.com>
 <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
 <Z8sBuzx6sGq24n0g@lpieralisi>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <Z8sBuzx6sGq24n0g@lpieralisi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-03-07 2:24 pm, Lorenzo Pieralisi wrote:
[...]
>> diff --git a/drivers/acpi/arm64/dma.c b/drivers/acpi/arm64/dma.c
>> index 52b2abf88689..f30f138352b7 100644
>> --- a/drivers/acpi/arm64/dma.c
>> +++ b/drivers/acpi/arm64/dma.c
>> @@ -26,6 +26,11 @@ void acpi_arch_dma_setup(struct device *dev)
>>   	else
>>   		end = (1ULL << 32) - 1;
>>   
>> +	if (dev->dma_range_map) {
>> +		dev_dbg(dev, "dma_range_map already set\n");
>> +		return;
>> +	}
>> +
> 
> Why are we checking that dev->dma_range_map exists here rather than
> at function entry ? Is that because we want to run the previous code
> for some reasons even if dev->dma_range_map is already set ?
> 
> Just noticed, the OF counterpart does not seem to take the same
> approach, so I am just flagging this up if it matters at all.

The intent is just to ensure it's safe to come through this path more 
than once for the time being - it doesn't really matter whether or not 
we repeat anything apart from allocating and assigning dma_range_map, 
since that leaks the previous allocation. Thus this check is logically 
guarding the acpi_dma_get_range() call in this path, and the 
of_dma_get_range() call in the other.

> Other than that, for acpi/arm64:
> 
> Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

Thanks!

Robin.
