Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE271F1534;
	Thu, 10 Sep 2026 07:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789023643; cv=none; b=VeiEZ30ycJDxCiQmmeHBJFX27op2VInS2ibh5S5q+JVuxuUQdz6lR9B7/RKZKW+FCalKOvF5gbAWKnnmBmrqjWhwCwJlgb1Ied2MnhCWkO5hMqil48U/cZuTUs7RC4WtahAa7LCSgFg9yKBYTA4Yps0F3d1AZwssAscvYponzCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789023643; c=relaxed/simple;
	bh=b2PTiwNpdiJ2jDGC/0d1pDN9PZeipK7iUziHSTPl/Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBzVc9hl8IC5/3mUC5+usowhol+jeL9KM4D6h5+rlw7zJJ45WMWbgwD8cpf/7czmR0cYGgAdWABXQl2MJeRZMiNnTvi4EmiotlzOhwuFA77sqia2nS7pwSh88Mz5IOIW/3d8Kwtgj/PGQ43MPrsPgGQDj6QBZcjRKTo8p0BjELA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+kW54PL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+kW54PL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C431F000FF;
	Thu, 10 Sep 2026 07:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789023636;
	bh=PLB7kdrnKKPLtjHGr3TMWL2XoiSmb4bVzzTlrFoNjDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j+kW54PLttAEPCNTppMGzu9T/O7QsFxFVkduNmwUAxX3ZpjY8bzatNCtrzaICDpWj
	 fPHknBWxpcNPrElEhmi/9wOh+fRRCQV0Pbe50RFTWvvh8F2ATgsw/i/XVvh8KwwVjW
	 wuyz0ywCkxxp8+2iotnZYdtM3Q0bQ950awJYhgSayQL+qh/4GiQ8rBqGuEZw6r/HOt
	 Gaq20jgN/54M1nq6RKuivcmVrGSh1AIYhkrgyz+5+Z38AuxX4+u433Z+T7ZX0ATPxf
	 PpdgvxZwjTaZUosut4zmJHNceIZ7VVoJiBHB8RxCxLIr2vbdWGdIAYqTiwVzQUl1xt
	 UNAIe1I+AkE4g==
Date: Thu, 10 Sep 2026 09:00:32 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, Bryan O'Donoghue <bod@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Stanimir Varbanov <stanimir.varbanov@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, linux-media@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, iommu@lists.linux.dev, Daniel J Blueman <daniel@quora.org>, 
	Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH v3 02/13] dt-bindings: media: qcom,sm8550-iris: Add
 context bank subnodes
Message-ID: <20260910-gracious-angelic-frogmouth-bcddc1@quoll>
References: <20260909-vpu_iommu_iova_handling-v3-0-2fe43ae45495@oss.qualcomm.com>
 <20260909-vpu_iommu_iova_handling-v3-2-2fe43ae45495@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260909-vpu_iommu_iova_handling-v3-2-2fe43ae45495@oss.qualcomm.com>

On Wed, Sep 09, 2026 at 08:27:09PM +0530, Vikash Garodia wrote:
> The VPU issues DMA through several SMMU streams, and the hardware does
> not give every stream the same addressable range. The non-pixel stream
> cannot address the low 600MB of IOVA space, while the pixel stream can
> address the full range:
>     +-----------------------------------------------------------+
>     | non-pixel stream addressable range (600 MB - 3.5 GB)      |
>     | 0x25800000 - 0xe0000000                                   |
>     +-----------------------------------------------------------+
>     | pixel stream addressable range (0 - 3.5 GB)               |
>     | 0x00000000 - 0xe0000000                                   |
>     +-----------------------------------------------------------+
> A single "iommus" property on the video-codec node puts every stream in
> one IOMMU domain sharing one IOVA allocator, so nothing restricts a
> non-pixel buffer to avoid 0 to 600MB. Once an allocation lands below
> that boundary the hardware faults, which shows up as unhandled SMMU page
> faults and spontaneous reboots:
> https://gitlab.freedesktop.org/drm/msm/-/work_items/100
> 
> Given that the address range restriction is for specific VPU stream, it
> should be ideally be moved to that stream. To achieve the same, a subset
> of streams is now represented as subnodes, so that each can be
> associated with its respective addressable range. The design was
> discussed and agreed by mainatiners here
> https://lore.kernel.org/all/c7b956a9-d3e8-4e18-b780-5d08f5cd2ca1@kernel.org
> 
> In the past, this limitation was addressed with an iommu-map approach,
> with the iris driver dynamically creating the devices. That approach was
> later concluded to be a hack to avoid having subnodes, and was NAKed by
> the iommu maintainers. It was discussed in detail here:
> https://lore.kernel.org/all/c7b956a9-d3e8-4e18-b780-5d08f5cd2ca1@kernel.org/
> 
> Update example to the subnode form. Doing so, it picks up the supporting
> properties needed on the video-codec node, address-cells, size-cells and
> dma-ranges to declare 1:1 DMA translation into the parent. Given a soc
> with address-cells and size-cells as 2, update the video-codec "reg"
> accordingly.
> 
> This patch depends-on:
> https://github.com/devicetree-org/dt-schema/pull/207
> 
> Tested-by: Daniel J Blueman <daniel@quora.org>

I already asked at v2.

Best regards,
Krzysztof

