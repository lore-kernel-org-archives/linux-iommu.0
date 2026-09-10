Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD84C35C6AA;
	Thu, 10 Sep 2026 07:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789023692; cv=none; b=trK11RPSfDLV0Q6RIflHv+jV83NSOpAmhc7izWOYWUbU4ic4jLt/nmnSDlTbvDNeaSnY+LWaATPMohgrxd/XENVkh6LcMpSgg7Id040eZwtx8pibPq6YlFy4RXeuTnHnORzUn23gbHwjDjxIY/NrLsnuH3JO1S4QgxyiWSgmGeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789023692; c=relaxed/simple;
	bh=XsD3VHRHoZNsJMnDJCcob/vJuS4VBV4jS5bilr28moI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uT2ugBbCLsBeysQguYloE1ysWxpKi6xS5m8p0I4p5wMifhwqf5begSytTEyR1X/c5PmIZT8vS0kETtznPy/y/Uw5KLcCFZA2Vq4NJOc/gM1nRV1qSO6GCfLyz0lgr4JXmpNDk0C9cHoSaXG+YKzD8VVPlAV+KEXZD0tUN3WcNXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6V29vN1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6V29vN1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521921F000FF;
	Thu, 10 Sep 2026 07:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789023690;
	bh=ypJiqvLlRL2rV4USZE9HiM/RVrXNG6BAdIEP6VExYrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e6V29vN1bnvazKSHBTzHKaj/UMTLOQ8JzG8Ccn7b8bif+QKX40RlVIWbpmd4dJsce
	 gHMDhXPLFFFdk4k7hZvBmZFE5Kt+9xsR+KBESnLF/35KQrN4rSehNgWqb//JZs4zgV
	 M0P4QMZssVFuFWfe31tYKuGL8YAUYGo5fcKZRlr8AYps+xPe/nFPLi43fIureMlmae
	 /aY27qbFeLCNJurr9iB2tn6x3yBVzTnNpzHqt/NwCxYUmdu3VqkAIvVvwRRdolGgIL
	 max/sgT8x7GWxnCyNWIDssXitWvyUKy3Uh1zgt6QDkTo1gsR6Q6hrJ6L+kW5SauRge
	 r81hsp0dR5zpA==
Date: Thu, 10 Sep 2026 09:01:26 +0200
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
Subject: Re: [PATCH v3 10/13] arm64: dts: qcom: lemans: Add Iris context bank
 subnodes
Message-ID: <20260910-glaring-chocolate-caterpillar-0bf216@quoll>
References: <20260909-vpu_iommu_iova_handling-v3-0-2fe43ae45495@oss.qualcomm.com>
 <20260909-vpu_iommu_iova_handling-v3-10-2fe43ae45495@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260909-vpu_iommu_iova_handling-v3-10-2fe43ae45495@oss.qualcomm.com>

On Wed, Sep 09, 2026 at 08:27:17PM +0530, Vikash Garodia wrote:
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
> associated with its respective addressable range. The design was discussed
> and agreed by mainatiners here
> https://lore.kernel.org/all/c7b956a9-d3e8-4e18-b780-5d08f5cd2ca1@kernel.org
> 
> In the past, this limitation was addressed with an iommu-map approach,
> with the iris driver dynamically creating the devices. That approach
> was later concluded to be a hack to avoid having subnodes, and was NAKed
> by the iommu maintainers. It was discussed in detail here:
> https://lore.kernel.org/all/c7b956a9-d3e8-4e18-b780-5d08f5cd2ca1@kernel.org/
> 
> The video-codec node includes address-cells, size-cells and dma-ranges
> to declare 1:1 mapping for DMA translation to the parent.
> 
> Tested-by: Daniel J Blueman <daniel@quora.org>

Really, this commit on Lemans platform was tested?

Best regards,
Krzysztof

