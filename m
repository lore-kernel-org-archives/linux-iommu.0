Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0C6391E4C;
	Wed, 10 Jun 2026 08:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781081113; cv=none; b=a9X8b/kzoOVcLkpTNYHt+MIKhRiD3Q/TwmBqInxWUl38MKETQeQNQ0YRQqkCf2NupGqpYDzNoZYjccEfoebsoR/AusLkD/mkkKfQ9BHwSMkAt5V1T9G63k8T1yb4/iT/D5eJgcrrhwC24fLVv1R9ar8E4BYlWWa1fTd/SbTssPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781081113; c=relaxed/simple;
	bh=79dR3ec1X7G4Pv+5qYv3XvdOClyoQArgLr1CO+yrC54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gwGlG+xoV9Y7XekPJu9o6+MR3v5tFPjT1WruI8IPtoLbeeuaDVpz5xAXSlzo9wQaNeGVMph5EueGEE2Bszp+ugXX6yeumPYScXxQFJPg0JQwvQn8dnXJJgLxr4zYMI/EWMBSDBL97RYLbNMygxM/J/X3EPrwRdRxHMV/tuoOCpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJpAL0cV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJpAL0cV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB0B1F00893;
	Wed, 10 Jun 2026 08:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781081111;
	bh=v1jCvYF1UWZxDV4ocmTiPKKrNLTz98XdwDOkWa7eeJU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jJpAL0cVq8UgMWLY6pGq+xoa61xoIbMPFZvg3QdEK23OCroaoMmRWD7IZ9VEWVA7L
	 VNvwCTHr5z3gtQ9Edx6Qob2Lqj6XfMUPx2UBvFtBlAI63Qf0+nDe04MRdGWCgtCJKB
	 O03xK8gtjVMhTK9lxhc0X+LrBBtKfJFbcWPfisgwmp/GgQ3v93pRG8Hpbzk06sOoBO
	 0XUYhwMNNffUSnAC+zmEq0SJxFlV0ATENZJEwp9aS7ftk4RaoFGmGzHeePkpfiUfb3
	 OjefkVn4IBC9QzMOAphXIfzOxOcVMwaEYzpDk8L34aIA5zirvNPS96wZsE4TeAOYRP
	 An+vun2QHkSZA==
Message-ID: <383dddd5-be5d-4c8d-bbf0-f889b83af374@kernel.org>
Date: Wed, 10 Jun 2026 09:44:59 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 11/12] arm64: dts: qcom: glymur: Add iris video node
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org
References: <20260610-glymur-v8-0-1c79b9d51fc0@oss.qualcomm.com>
 <ml_9sjHrXhEekEoq2gGpd-TK18TRhfINS8p6Nvz54Vsic2kRx3LrHye0pdi-i2RbEDkaFxaUI8cLNtSc3wGK4w==@protonmail.internalid>
 <20260610-glymur-v8-11-1c79b9d51fc0@oss.qualcomm.com>
Content-Language: en-US
From: Bryan O'Donoghue <bod@kernel.org>
In-Reply-To: <20260610-glymur-v8-11-1c79b9d51fc0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/06/2026 07:29, Vishnu Reddy wrote:
> +			memory-region = <&video_mem>;

What about the 600 MB limit ?

Lads - please stop pushing new bindings until there's a solution in 
place for that.

Either codify the block Daniel has - which TBH I think is wrong because 
it prohibits allocation < 600 MB for pixel buffers.

Or restrict the IOVAs in the driver _or_ via syntax magic in DT.

Either way we know this is buggy !

---
bod
