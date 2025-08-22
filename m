Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D5D7261B;
	Fri, 22 Aug 2025 08:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755850790; cv=none; b=DCKDB2qlt6kgrdKqVR65bkXTi4UVd0jiM8E9Aqs6x3A4IHRZqeQot33JgakrEqGeRwxg6HNTH7uW2Di6+n1XaV0Y7CB/6CBGm4zzKRbOaQYjJIANw7ghV0Sp/PqxQOo4SDrE7zEI79vS30QJQgDVJwI902i0KD01k2d7jk5CC34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755850790; c=relaxed/simple;
	bh=HkE8AZTiPlzHsol+TKib6yPCz1oDuxVyBqFtTZA3Btc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRU4JMJ9giTNeNY9np5P7fMiwvXQwgQyAh7TofALq6Qa9k4wvI979p4fqxXSAhQkuKs2kfl3nSdKXhmsjm3xnMMA/02ew3bZ8VrSyouZnR3ZTWS+Wod5tRUQpphRpMwHyun73EQeVmbPwXTFGD2F3IxbkRXSKg4qzCFKUK68Kzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMpKRcVM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMpKRcVM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FF6C113D0;
	Fri, 22 Aug 2025 08:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755850790;
	bh=HkE8AZTiPlzHsol+TKib6yPCz1oDuxVyBqFtTZA3Btc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NMpKRcVM2avITumqfYtpR1lJyNy1YGhcacH85UaXAzpSXOttsKoYASi0FKUaU3c3Z
	 LZHMKa+Bm/tK9LhnO2Le6hkD6TRDDCwIacrsKCKDXxIg3cHlGkfTmyiz4J+tX0OeAk
	 +y6hEJuRDwzIELlvKjoq1Z/cI3PB+gLj+leRv87IKdhqt2q0SAY8ZI6960dHWt5gUK
	 RySJvhreS+KKJ0IDElOiOI+xhgkPpvCHElNb4FFvdwk7IKHfAHFglep3zi7q1pPCd0
	 eL6wJM9h5zVy8CgVKdGsLd1BYeRPNfwPbu3NlXrHrHuE8IRVt4WpZOUTBL6jv9UGHx
	 PdKiNBgxIMILQ==
Date: Fri, 22 Aug 2025 10:19:47 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hector Martin <marcan@marcan.st>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 6/9] dt-bindings: nvme: apple,nvme-ans: Add Apple A11
Message-ID: <20250822-singing-boobook-from-heaven-ef5cf8@kuoka>
References: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
 <20250821-t8015-nvme-v3-6-14a4178adf68@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250821-t8015-nvme-v3-6-14a4178adf68@gmail.com>

On Thu, Aug 21, 2025 at 11:56:43PM +0800, Nick Chan wrote:
> Add ANS2 NVMe bindings for Apple A11 SoC.
> 
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>  .../devicetree/bindings/nvme/apple,nvme-ans.yaml          | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

