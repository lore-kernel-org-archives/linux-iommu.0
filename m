Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795033973;
	b=y6vH5huvMdSEsz3dZpcf83Ip9/7vKG0lsSrbdx8WBO3xTGspwl6HHFPCYyT9i9HRJex8
	 5Q759hHQ6k2uhhG+m+nnN/LQEim4j51t+4sjyHekK0kc2tOv9DTYd3ZS+HHA8lbIZue9T
	 2L9Wsa+QXOfI92rqcRVfHI+Fgnj350JKSg/KmMTqpI3EL0i5vmA8NcY6n1+AnjTZKoY3g
	 CTe5jVSLTKYei6AxllG2syXwu0cIQImWCsIokBctJHBZ2WgXqwidSjj65QaxmXgp0If4w
	 I/r8xyCXceJO1ktU3xToN5ZPbDOpnMlQhufMEk2Vs3zbnLJ2MlWbS2VJcIdgNYh8Z7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795033973;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Ooh2Ut4OkXb4cnFIzK24GOQEm3EtxNlb5xhtxv/8OV4=;
	b=jKAhNDo5AEcl359+U4QaM3l2nhzkYfgbunT/WNg2SCkTB8tODe870l45RXtoI/OZEYnA
	 JP78ykeIc0QTjted26ZCxE1iJ2i10q6vVqbxMvshQaJERf/OhNN6aq5PLJLEayFgX7c1m
	 Noh28JLxsDYGK9JYgjyjVtRFviPksqxHy2B8ltpKkFZikkmZx7QXteFgDMCN3LdN7c+Xv
	 KRHl/cTThgX0Ixfq+yk7YMKGUROvjW4fkt3CwyAIAgRX3/xaO/QbCuKR1yMDhk0MZkOar
	 sDB8N2kcD6uQG8VQOpo2eS3OxpnMgiWSiZLMvb3mJxIVuLZX3iNrnJ/mSbiVnCbt9Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iwUpONJa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0724606A320;
	Wed, 18 Nov 2026 20:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iwUpONJa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433671F000C4;
	Wed, 18 Nov 2026 20:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795033973;
	bh=Ooh2Ut4OkXb4cnFIzK24GOQEm3EtxNlb5xhtxv/8OV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iwUpONJaUZJPm+lXfBmkJc0tKTinjGLkWtnilXXoN2c5fi4Cj/2nKIMegk74eoqwI
	 S/9+rLm9GzfnB4NHfENFH/Lz0PrpvlBvocecRjvuNR5xNun/AxYylBQyPOJ3YU0c+5
	 hzIE9sWbbGAF9xmHBgvni12CMMGL7heqcEvsP5XIMGHCLPUAI1OP3NfLBGh9QKhcpG
	 +Di9hNVRs82vn+OjO6QWEBIYZtDMhJMkyRtT6+q4N9E9oQII6G58ZTMtei6KzYg1hn
	 5BiQ+wU4nOzTfnfoMicgqiA4ryx1KIUKHTvPlgPCoXNmcV6E91OTWsJWAwVLAyk4Bi
	 4PqgTqj5roQeA==
Date: Wed, 18 Nov 2026 14:32:51 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Arun Iyengar <aiyengar1990@gmail.com>
Cc: Simon Xue <xxm@rock-chips.com>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Conor Dooley <conor+dt@kernel.org>, iommu@lists.linux.dev,
	Pranjal Shrivastava <praan@google.com>,
	Robin Murphy <robin.murphy@arm.com>, devicetree@vger.kernel.org,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Niklas Cassel <cassel@kernel.org>, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v3 1/3] dt-bindings: iommu: arm,smmu-v3: Allow a clock
 and a reset
Message-ID: <179503397082.838785.14210006963521500308.robh@kernel.org>
References: <20261113-smmu-v3-pcie-pd-v3-0-39eb4f919529@gmail.com>
 <20261113-smmu-v3-pcie-pd-v3-1-39eb4f919529@gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113-smmu-v3-pcie-pd-v3-1-39eb4f919529@gmail.com>


On Fri, 13 Nov 2026 08:45:05 +0000, Arun Iyengar wrote:
> The RK3588 PCIe MMU-600 has a clock (ACLK_MMU_PCIE) and a reset
> (SRST_A_MMU_PCIE) in the CRU. When no PCIe controller holds the clock,
> it is gated as unused and the SMMU stops responding. Allow one clock and
> one reset.
> 
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

