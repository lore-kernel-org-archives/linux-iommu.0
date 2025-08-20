Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA93D277CB3;
	Wed, 20 Aug 2025 22:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755728339; cv=none; b=eHwolqJZ01GRwWJVz5OJap2Y0zGkqtnrVek1mWtWrN6gHfXrfwo1aKPDC+ez5FdyKqaEscgSUyyhHkh3LCv9Ht2Y5KNM2m4KL+EVfJA07+gy63OY2OcQA1VKuAQXcpBTl8jX5JOY2iNHmdQgE5hCYjafO/18gyoGX6AknhNMxSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755728339; c=relaxed/simple;
	bh=R/BkZNm9tZiYfcxpkJb8o6x4WQt+nKkmKkM9VRJvV2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdEXYJAzrhfZTXRV7016vJF8hobPzeeYIl55HPiN0BquYZolZc68pVXI/Av79+vWAUfY2la7paHJ3vXp2nJuEh//NaUn5UjN5YBIixEIlTSCJyIlVhJNpjVfguM0MrEnjAc8b8nuQPMdo/Sk4TcwsLpAD5+c6mqeEwtsdwkCn7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAKdvASJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAKdvASJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3731C4CEE7;
	Wed, 20 Aug 2025 22:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755728338;
	bh=R/BkZNm9tZiYfcxpkJb8o6x4WQt+nKkmKkM9VRJvV2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WAKdvASJOeFeY9PqNztR9l2AspAmbogSBjNYC9IwiujKsl2h4QI5YrO+k9Ni1bdlx
	 whq/tit9TJ7FnI6orG+bJ5mUauaQ3DTdQ0dk1R4nejV55iXxm9JjLbh5YM//to3JDi
	 jRhUrPNszpezhwm14NJP9g0hc6dhAyk4aZS9H468sbn93nAFmSO/qGg6Ywg9ygGDkk
	 Ms9skBLOvqHmkn18wTUGmeywK15ygj3abA4zgdSM2hH6gTSQTMUxiEJ8khRZXuaZch
	 4IiWY51pHl5rhaIQA5gjMkTfRHk01sZ+1K7OCnKXFk6V1S/HI1Zt+R9obiQlWXLsaA
	 Q08EUD39d/YmA==
Date: Wed, 20 Aug 2025 17:18:57 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, asahi@lists.linux.dev,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, Sven Peter <sven@kernel.org>,
	linux-nvme@lists.infradead.org, Hector Martin <marcan@marcan.st>,
	Keith Busch <kbusch@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	linux-kernel@vger.kernel.org, Jassi Brar <jassisinghbrar@gmail.com>,
	Will Deacon <will@kernel.org>, Janne Grunau <j@jannau.net>,
	iommu@lists.linux.dev, Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 3/9] dt-bindings: iommu: apple,sart: Add Apple A11
Message-ID: <175572833738.1513431.970706958062669952.robh@kernel.org>
References: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
 <20250818-t8015-nvme-v2-3-65648cd189e0@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818-t8015-nvme-v2-3-65648cd189e0@gmail.com>


On Mon, 18 Aug 2025 16:42:56 +0800, Nick Chan wrote:
> Add bindings for SARTv0 as found on Apple A11 SoC.
> 
> Reviewed-by: Sven Peter <sven@kernel.org>
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>  Documentation/devicetree/bindings/iommu/apple,sart.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

