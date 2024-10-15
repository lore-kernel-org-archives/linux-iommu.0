Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49C21CB9FE
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 15:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729005199; cv=none; b=g7sPuKLl1hPb5PGXTbTozQhJfDRfiK39mo/11Er219fftw8R5i/tXt3ybDLYjYzER+HkUnCnAx1v1wnu8r3wmTTkLRtZjJpVK2IRkA5UcW+FjpQf+6aumhYIuVEicuSggLmzQnc1n6eR36/uGAIPryIURjw5f1Z3ii4vhBcUaFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729005199; c=relaxed/simple;
	bh=3UPyQizIPwmlNL9o3FwCIlDalR14jtlqmUX94lslLSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q36JGfkr7z6cBELAHyVeYFyXTuIU8YK10mkLhLc6MxaVUlFyqJyWjI8v8tIb6p2yVjoNiwAX2XdwFod0sqlDpCrOvjBTdInbIbX3DGZ07WVGYGuWJKF6S7Vlf1yEyg8tix937PWcCGdITKMxPTiZGR4lEWNMuSeBJh2cdwFP+kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4CEBFEC;
	Tue, 15 Oct 2024 08:13:46 -0700 (PDT)
Received: from [10.57.87.12] (unknown [10.57.87.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4FFF33F528;
	Tue, 15 Oct 2024 08:13:15 -0700 (PDT)
Message-ID: <ab21d602-5349-47be-b346-2fbc041fa13e@arm.com>
Date: Tue, 15 Oct 2024 16:13:13 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] iommu/arm-smmu-v3: Bypass SID0 for NXP i.MX95
To: Jason Gunthorpe <jgg@ziepe.ca>, Pranjal Shrivastava <praan@google.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peng Fan <peng.fan@nxp.com>
References: <20241015-smmuv3-v1-0-e4b9ed1b5501@nxp.com>
 <20241015-smmuv3-v1-2-e4b9ed1b5501@nxp.com> <Zw4kKDFOcXEC78mb@google.com>
 <20241015124723.GI1825128@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20241015124723.GI1825128@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-15 1:47 pm, Jason Gunthorpe wrote:
> On Tue, Oct 15, 2024 at 08:13:28AM +0000, Pranjal Shrivastava wrote:
> 
>> Umm.. this was specific for rmr not a generic thing. I'd suggest to
>> avoid meddling with the STEs directly for acheiving bypass. Playing
>> with the iommu domain type could be neater. Perhaps, modify the
>> ops->def_domain_type to return an appropriate domain?
> 
> Yeah, that is the expected way, to force the def_domain_type to
> IDENTITY and refuse to attach a PAGING/BLOCKED domain.

There is no domain, this is bypassing an arbitrary StreamID not 
associated with any device. Which incidentally is something an IORT RMR 
can quite happily achieve already (I think the DT reserved-memory 
binding does need a proper device node to relate to, though).

Thanks,
Robin.
