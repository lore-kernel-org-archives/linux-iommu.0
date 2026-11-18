Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795036335;
	b=KNZJpFrM5wTAMdeGgnaX/mvUGcOinTlh8AteBlFk+C7ZjNKIco6ROAQtU7FYGJqH+Tsj
	 XhVcULGe3ukIh1eCLLzO8uAJQnMySslHPo5d2QjHl+NbKtt1Ik59UmgJwTm6KGejweREC
	 ZdJLkeq7t0oToGbGJMNzEEgwBtmMLs7POSVbOabw1RIZbB4aFFiu/plV9ydlyrMAqDaFt
	 J1f8qibtua+7L8hRGgnDwjQYaI59xce1ePfSwgMH8oRtX3i6l7bhU9bDFieLd2TDremDR
	 IZxruNDswhVNQKwzsF3GnavNC2cOoSAV7sgwPXE6Vkk24ovRInZ2Wj06vOvxNAnbcNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795036335;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=HDCAkeZEKgNECITteEp+O5Hl5QzBetAGqDu6m3T4vtc=;
	b=Pf08yCmTwnFPkiKtvusrnOh2wPVx5M20DJTKuAnN3lQlPRi/d9Y6gAy+WSSXfTadVZp6
	 5hIwvvTTRfaTSTWvvvioUcyrp2TGJNrua7YwYMYDrAojbkHkAiKKPByFX2WHU0z7Gm95q
	 YHmd9jsb2xazIWA8+KpGaoBtZvf4+NeUspmmzZaYmTNcVO3+Feb7SdbwGd1X1G0Y9F7cH
	 xKf42v65LXs8gLS3wE0jHfXzYanhjKDzvprjgZth4Ni7MpU/TV+whR+3CszOGcegMuxQO
	 wD04XHlE0/5lHS74ZALw3BcE/52Xv95srDgdc3Dux95sKWL1SbXUSKwSn0wOcXtEA4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UV+J/67M";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770AE606A330;
	Wed, 18 Nov 2026 21:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UV+J/67M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7651F000C4;
	Wed, 18 Nov 2026 21:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795036335;
	bh=HDCAkeZEKgNECITteEp+O5Hl5QzBetAGqDu6m3T4vtc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UV+J/67MbY357XaDQY1wb463wX0IRk8wkHXFkoWEZenbFaJyhzFuIQfXCNSwvwfJU
	 qy6eTYeIkjCOEiGamXPX38F9pDt1amP3aLvKuwNzXFBA5vb4wdeguOZ46imbpQM3HH
	 VbmZy/7x+nH69YQY2OOsAnYP+h77GPwhZ10eb8lYWdibiRsgakr8hNR513hYa6OsHA
	 gpASOlSPUVEOm4CFtta8+PxVQjSIgJg3YiJ5RcBr/ZHi2Xty17GWUHctn85sd1BqVt
	 XJsm/JrHHT7qBnq9NK7Lz9rP/vkw47eMBX/Cx9FWYGHGKivBZvrjK+3uTjCI4IYbJ+
	 LGk/gzldD+MoA==
Date: Wed, 18 Nov 2026 15:12:13 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Arun Iyengar <aiyengar1990@gmail.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Sergei Khomenkov <shomenkow@gmail.com>, linux-media@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>,
	Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
	Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Tharit Tangkijwanichakul <tharitt97@gmail.com>,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Will Deacon <will@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: Re: [PATCH v3 09/12] dt-bindings: iommu: verisilicon: Add the reset
 lines
Message-ID: <179503633303.1026294.13265931291841937198.robh@kernel.org>
References: <20261113-hantro-robust-v3-0-82383c722ad2@gmail.com>
 <20261113-hantro-robust-v3-9-82383c722ad2@gmail.com>
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
In-Reply-To: <20261113-hantro-robust-v3-9-82383c722ad2@gmail.com>


On Fri, 13 Nov 2026 16:40:40 +0000, Arun Iyengar wrote:
> The RK3588 AV1 IOMMU is part of the AV1 block and has no reset lines
> of its own: the four AV1 resets also cover it. Its registers can't be
> accessed while they are asserted. Describe them.
> 
> Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
> ---
>  Documentation/devicetree/bindings/iommu/verisilicon,iommu.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

