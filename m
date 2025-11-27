Received: from mail-m49216.qiye.163.com (mail-m49216.qiye.163.com [45.254.49.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F0D3C1F
	for <iommu@lists.linux.dev>; Thu, 27 Nov 2025 08:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764230555; cv=none; b=oAym+zI8bw5XglHy/ziTPQzjp8AZnhIY7ef2PEkN7WvwsLglQQ8kxJWHXk5g4fYZO1yJY9q2cKzhMmVLMRYiAJLMI9t30+l3Y4Ko8FXNMQOGBPcLf10ec7mttsdOWWug97iWAttDO3JoGFjr/ya4GUy2xskRaRFbVbr5p32h5G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764230555; c=relaxed/simple;
	bh=nf6fxmWmCJCzyXYRt1QH2rnmEZB5RFiqYgs0IKHWgwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EEeeGuQqLfUqNWy0JYe6xQAmfy5kyAP7+/iw9JjYK2pdfgT7vFgL2K3LL/JdADXlGPPdvk0bNOqdcV71f9XvQRI5tIVC6W5s9rXF/eB4U2f0dWg/IOyX1PxdPETpCQMh4PNQ4b4cXWUJuoBLnJ92zumXvzogDB9h5gUuW8spcTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Vl7ExnL0; arc=none smtp.client-ip=45.254.49.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Vl7ExnL0"
Received: from [172.16.12.51] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2b1921d28;
	Thu, 27 Nov 2025 16:02:21 +0800 (GMT+08:00)
Message-ID: <324ba201-8cfb-4a7c-87c8-366f657ffd8a@rock-chips.com>
Date: Thu, 27 Nov 2025 16:02:20 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iommu: rockchip: Add support for
 multiple interface clocks
To: Krzysztof Kozlowski <krzk@kernel.org>, Chaoyi Chen <kernel@airkyi.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251126083345.88-1-kernel@airkyi.com>
 <20251126083345.88-2-kernel@airkyi.com>
 <20251127-enigmatic-faithful-viper-baefa2@kuoka>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <20251127-enigmatic-faithful-viper-baefa2@kuoka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9ac455afef03abkunm152125166ae01b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh5CSlZMHR1CGhhCTE0ZQxpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Vl7ExnL0xwkuLXb9VOoyo6qNANWdAmo/wYjgMpjdol9LR0oDRuJIwvUB+uCSp3LmuwKg8GUhDBBFhdwxkt5Ndf2jTHRZsjhN/+N8p3l5sbNwtWGCwWc8tecJo5tKGPPmsCnMSyjCX65Uqrnik2BFx57hgN9yLvkLNU4wCozEvyY=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=1LYx8D2nnDemgXO9g6TLvymKor13ip90yPxjnDbRoRs=;
	h=date:mime-version:subject:message-id:from;

On 11/27/2025 3:49 PM, Krzysztof Kozlowski wrote:
> On Wed, Nov 26, 2025 at 04:33:44PM +0800, Chaoyi Chen wrote:
>> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>
>> The iommu found on RK3576 NPU/RKVDEC may contains more than one
>> interface clock.
> 
> So you need to restrict this per each variant. See writign schema doc in
> DT dir.

Oh, I will rewrite it in v2. Thank you.


> 
> Best regards,
> Krzysztof
> 
> 
> 

-- 
Best, 
Chaoyi
