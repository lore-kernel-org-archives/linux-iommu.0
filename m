Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBACF1FBCB5;
	Sun, 17 Aug 2025 10:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755426693; cv=none; b=oUcrERDPSjgSPXmVuK11b0kpXppkT913GjolTua/MUkM1HQJ/51u/MT+4cgzaCTEemgEQbtqw5gZQIztvjD4WYCawdVRRmvoSgj+oQnh8xAOv1EnY+Trf+d4rPNfAQceJRi4nk/D/iQb3PaBpngrHDwasaYAQX851up2CNIAp0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755426693; c=relaxed/simple;
	bh=xBBiE5WdAUPpvLQbRAatiXL9xSljMYM/qDXrY7Yqptg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D8NXIpyUa4kNJMB5m87al5vpxIBqyOb5zKhjNe/rYPLjgoIsgA7vQHiXs1TjdWupgsnKWqpNgP7G5Shy95Ccfi5TEP/7hfeHVHlyiZDkYuD7XLcOhpZRpFhri0xWKEg1lHUVs77VUp1gllWn1ucEuAMlvyxRpEIm8xDiK3wlBe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0XMiPl6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0XMiPl6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A03C4CEEB;
	Sun, 17 Aug 2025 10:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755426691;
	bh=xBBiE5WdAUPpvLQbRAatiXL9xSljMYM/qDXrY7Yqptg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B0XMiPl6hsygWKcyNYXgNpr+hcuMosl2YoYW9o2Y1YUzbLZTabKWsKTR79aRncyU0
	 eQ3utSKm2JbvBVcC3/dSwH5RBb2xEk0mc8Ml2iKv+IdEKIcx9fqzCjgGdcfJN5hNxw
	 3xi0lauQV0sa2paZ5tUUEk/ZCeqSifwvIryqFTt9EzX1xTrT/G+YiCBS35X3bpiXrM
	 rk4CXXbXYcizCvUu0xIbddNgGPPNVVvvze6qUvzqs84bk2SAS4lGqgF8SxyVKjE/nO
	 xKWZV99ypLiIEUKrACtEsocwQX1Y6/mO2PUgNXZmxibHIs8adKSoxt5GiAEJzWiUfv
	 QGrgaoKkIXTAQ==
Message-ID: <1b7adb41-5002-41b4-9108-eeb6001424a7@kernel.org>
Date: Sun, 17 Aug 2025 12:31:25 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] soc: apple: sart: Make allow flags SART version
 dependent
To: Nick Chan <towinchenmi@gmail.com>
Cc: asahi@lists.linux.dev, Janne Grunau <j@jannau.net>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Hector Martin <marcan@marcan.st>,
 Conor Dooley <conor+dt@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 devicetree@vger.kernel.org, iommu@lists.linux.dev,
 linux-nvme@lists.infradead.org, Jassi Brar <jassisinghbrar@gmail.com>,
 Neal Gompa <neal@gompa.dev>, Jens Axboe <axboe@kernel.dk>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>
References: <20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com>
 <20250811-t8015-nvme-v1-4-ef9c200e74a7@gmail.com>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20250811-t8015-nvme-v1-4-ef9c200e74a7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.08.25 15:50, Nick Chan wrote:
> SART versions that uses different allow flags will be added.
> 
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
Reviewed-by: Sven Peter <sven@kernel.org>

