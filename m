Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025BD31353D
	for <iommu@lists.linux.dev>; Mon,  1 Dec 2025 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764598389; cv=none; b=m9++4rd69mRmV7xMXQ3DLpRCaYsYwBvaXpawTPdxVu2n3ov2AwEcrSXKTc/nfpYo8gk7FQqnW7P/vmiE+Iz7Ce3Z1MOe5o0DviKMH9ELRylWhU6M3pesIpdF9NIuwu8beULC0KfurkNgw44QHZ8QlNCr65IgXFOLMkMrUk3LlBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764598389; c=relaxed/simple;
	bh=NbSTMvUS8n1sMtEWZ1VrvCGVUDSy1rNVBRO4B/w4vQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ae22fmMz3XwaZeqnsNpcySVVEH+PuYBiBsRp/Tq/tsqwCIabgMO71VNf2uX4CG81Xoevzljwzr1cRd0is393GYC2fC8r9+q/7Ytw/gKa9B35W1broTP+JIVkrSifs0iyts04aPO1AR2k1abu/oqlqT4cRLt5plmx4fL4bMws0ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13DE6153B;
	Mon,  1 Dec 2025 06:12:59 -0800 (PST)
Received: from [10.57.88.78] (unknown [10.57.88.78])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76F723F73B;
	Mon,  1 Dec 2025 06:13:03 -0800 (PST)
Message-ID: <b66e1993-fe07-4826-9bf4-728e640ccacd@arm.com>
Date: Mon, 1 Dec 2025 14:13:00 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/3] arm64: dts: nvidia: Add nodes for CMDQV
To: Ashish Mhetre <amhetre@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>,
 will@kernel.org, joro@8bytes.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolinc@nvidia.com
Cc: thierry.reding@gmail.com, vdumpa@nvidia.com, jgg@ziepe.ca,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20251125071659.3048659-1-amhetre@nvidia.com>
 <20251125071659.3048659-4-amhetre@nvidia.com>
 <dff3a962-82dd-4aac-ae11-69f0e95ba04d@nvidia.com>
 <acae92d8-3394-436c-be8e-8bed7a923e85@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <acae92d8-3394-436c-be8e-8bed7a923e85@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-12-01 9:36 am, Ashish Mhetre wrote:
> 
> On 11/25/2025 3:52 PM, Jon Hunter wrote:
>>
>>
>> On 25/11/2025 07:16, Ashish Mhetre wrote:
>>> The Command Queue Virtualization (CMDQV) hardware is part of the
>>> SMMUv3 implementation on NVIDIA Tegra SoCs. It assists in
>>> virtualizing the command queue for the SMMU.
>>>
>>> Update SMMU compatible strings to use nvidia,tegra264-smmu to enable
>>> CMDQV support. Add device tree nodes for the CMDQV hardware and enable
>>> them on the tegra264-p3834 platform where SMMUs are enabled. Each SMMU
>>> instance is paired with its corresponding CMDQV instance via the
>>> nvidia,cmdqv property.
>>>
>>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>>> ---
>>>   .../arm64/boot/dts/nvidia/tegra264-p3834.dtsi |  8 +++
>>>   arch/arm64/boot/dts/nvidia/tegra264.dtsi      | 55 +++++++++++++++++--
>>>   2 files changed, 58 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi b/arch/ 
>>> arm64/boot/dts/nvidia/tegra264-p3834.dtsi
>>> index 06795c82427a..375d122b92fa 100644
>>> --- a/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
>>> +++ b/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
>>> @@ -26,5 +26,13 @@ iommu@5000000 {
>>>           iommu@6000000 {
>>>               status = "okay";
>>>           };
>>> +
>>> +        cmdqv@5200000 {
>>> +            status = "okay";
>>> +        };
>>
>> This needs to be ordered in the file according to its address.
> 
> Hi Jon, Thanks for the review.
> cmdqv nodes follow same ordering as its corresponding iommu nodes.
> I have added them immediately after corresponding iommu nodes.
> Can you please check and see if it's fine? Same applies to your
> similar comments below as well.

It's fairly standard practice to order DT nodes by unit address where 
applicable (and alphabetically by node name otherwise). The platform 
maintainers aren't necessarily familiar with the intended usage of every 
individual node when they have to resolve merge conflicts etc., so 
maintaining a straightforward consistent pattern is generally easier for 
everyone.

Thanks,
Robin.
