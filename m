Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F4E3176F1;
	Sun, 17 Aug 2025 10:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755426746; cv=none; b=bDS9FdhdKasaN6yerSmXKgRgVN+9B5097qFduKwP2gZeYOXbJtoMrsh2YHyxWQMtAqCb988PkQLYcdo3MWTcNMYBajXG3UMPsHPuUhD0bq8+JAY45mlIMi9Zm/E18iepDN/rWFUNTCntuGfUI/2FZKsfcS5E4TB4lD6T7/n2lLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755426746; c=relaxed/simple;
	bh=+Vo2OnMyV3S44FBuzXLli41+EUkEtk3PGeDWSIzIeaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=enwx/zzptUNxiDWAjUPGLquCxVsTHNbIlFKSkG0dOaGqvqhG24aeM6naGuuoKnaUGeobsT9sd6ytuqqClwtj3moNqYL6vK1fqJRKEKBylep1kkBk6YPIvfT9WL/G7cB9yjb/fC6QNKIJYwe/pT3pumOSr83O3hv8MpzgSt67PXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfiolxKH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfiolxKH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A25C4CEEB;
	Sun, 17 Aug 2025 10:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755426745;
	bh=+Vo2OnMyV3S44FBuzXLli41+EUkEtk3PGeDWSIzIeaQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DfiolxKHZvFlGP/P4mTZrq12w4mu8/gEnqIQJjyd0QyFbviifGrfC6IM9lkJ+HWvT
	 WVZULhE3RBrN5QDYhFGOmlLv3KHFWq7nX666fVQw659HB21BjT+bGA+tSzJBalBATx
	 zxmBuRoXAozSIgyX7MlVMCsFXPrqs+l2ZXhNkNI4YhG3KS7N1DF8Ab2O4RKkKW7L86
	 UfiCyG0BZ+DzKhwjBATUcspeB/r3hJa9Bg59LIdLsBNqxXBmXgz+O31D3Bd/ym8WtH
	 hWxgUPmSzIBW7uHLKjuRisKy8HV9vKMUHiZ56Ho4I9+xIIAbGuj2eA9rOaLdsBiTWT
	 8LVNlpN/0qGMg==
Message-ID: <b9ef651e-3e37-4a3b-82da-04bd2b085ddd@kernel.org>
Date: Sun, 17 Aug 2025 12:32:19 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] soc: apple: sart: Add SARTv0 support
To: Nick Chan <towinchenmi@gmail.com>
Cc: asahi@lists.linux.dev, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Rob Herring <robh@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Janne Grunau <j@jannau.net>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Hector Martin <marcan@marcan.st>,
 Jens Axboe <axboe@kernel.dk>, Conor Dooley <conor+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, iommu@lists.linux.dev,
 linux-nvme@lists.infradead.org, Neal Gompa <neal@gompa.dev>,
 Christoph Hellwig <hch@lst.de>
References: <20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com>
 <20250811-t8015-nvme-v1-5-ef9c200e74a7@gmail.com>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20250811-t8015-nvme-v1-5-ef9c200e74a7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.08.25 15:50, Nick Chan wrote:
> Add support for SARTv0 as found on Apple A11 SoC.
> 
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---

Reviewed-by: Sven Peter <sven@kernel.org>

