Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2378054279
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 14:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003635; cv=none; b=kQA8JFZ1VvXAy/cBTnApkgQ1QXb1pylkQcnGVj+bDAKs4YJUaA8BQ9JvkQaokFIbfltSI1qP6cjI3l25eRmAg21Z2LtMLFVxty1kNrkfS1yS199fSDzdW5jCBQFGfWe8D0dmR2GPBOy3GA44RtiRP7SGdCdZkXa+TyE55zCgHbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003635; c=relaxed/simple;
	bh=MP9cwT7tF4h/zPcm+gSYgwsGGRaT2JCrT66NUZwYfFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=urDXQQsBVANlwt3VN0RrSMbqOq6B06mdnft5v5hiqC7F4Q9wKNNNFIPbfDI9N2ykkW6G4febBwhXg4YG1F8APqnyN2tUDsbKNbV7P6w3W+lVg9LuVAR0kzDzTZcyyl+LyiDqTGJI9x903hYUSEvOrNnDV1+ApSm80VfqqgKSx+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37591FEC;
	Tue, 15 Oct 2024 07:47:43 -0700 (PDT)
Received: from [10.57.87.12] (unknown [10.57.87.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 731B63F71E;
	Tue, 15 Oct 2024 07:47:11 -0700 (PDT)
Message-ID: <a8c42a6c-bac3-4ebc-8a29-e6c0ed4567c3@arm.com>
Date: Tue, 15 Oct 2024 15:47:05 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] iommu/arm-smmu-v3: bypass streamid zero on i.MX95
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Joy Zou <joy.zou@nxp.com>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20241015-smmuv3-v1-0-e4b9ed1b5501@nxp.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20241015-smmuv3-v1-0-e4b9ed1b5501@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-15 4:14 am, Peng Fan (OSS) wrote:
> i.MX95 eDMA3 connects to DSU ACP, supporting dma coherent memory to
> memory operations. However TBU is in the path between eDMA3 and ACP,
> need to bypass the default SID 0 to make eDMA3 work properly.

I'm confused, why not just describe that the device owns this StreamID 
in the DT the normal way, i.e, "iommus = <&smmu 0>;"?

Thanks,
Robin.

> I was also thinking to introduce "bypass-sids = <0xA 0xB 0xC ...>" to
> make this reusable for others, but not sure. I could switch to
> "bypass-sids" if you prefer.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> Peng Fan (2):
>        dt-bindings: iommu: arm,smmu-v3: introduce nxp,imx95-bypass-sid-zero
>        iommu/arm-smmu-v3: Bypass SID0 for NXP i.MX95
> 
>   .../devicetree/bindings/iommu/arm,smmu-v3.yaml        |  4 ++++
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c           | 19 ++++++++++++++++---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h           |  1 +
>   3 files changed, 21 insertions(+), 3 deletions(-)
> ---
> base-commit: d61a00525464bfc5fe92c6ad713350988e492b88
> change-id: 20241014-smmuv3-120b24bc4659
> 
> Best regards,

