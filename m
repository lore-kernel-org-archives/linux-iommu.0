Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368B423D291;
	Sat, 16 Aug 2025 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755352940; cv=none; b=U+TwNRaOd4cgdE041CfnwzGdc0hmirQejppaQKeXHpykaQ0/YrcQ2BvgDw+2/YiugqLKNZt/7YTdvcGymKxyAKU8XAbO7QFrKDUWXpuaApBpna0x9cOw08IUeE11Zqj88kKh0j7YM8VrAW5x6AxdDM+4vufSLH+ux9Y54NDnroM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755352940; c=relaxed/simple;
	bh=qO/300I+Jt1lgxY0j084jr/ihK+Jo7wjNEO7mZkVJ2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T7j2gR8u7WnmH88zUQi49btP3699EvHNiMt458M/5rahAlCs02rD94HebEOGzIoe8jQEyPYT+IpEOcubz9LTOa2SixJ7bK8rElekGW/+2anshL02N4SuIHe93X/kJg7tzUEpwIQHgpqRRa8LHlbKuUhYFv7hw/2vtm0gDuT5440=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEE0xysx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEE0xysx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5A2C4CEEF;
	Sat, 16 Aug 2025 14:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755352938;
	bh=qO/300I+Jt1lgxY0j084jr/ihK+Jo7wjNEO7mZkVJ2I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EEE0xysxcNFJlzz0kqO2yzGdaL0+MMRpMUoazV+Ww68zR57fCxIBP8q1YCSIjT9K2
	 NvXtgYiUnPe81t0nktHEBdgqleO0PIk5LhiVC89eospNlDdmKZfTGdJQNlOm2qlZ/V
	 8L/gsCk8mO7jj3GdNvOKkBa0a569Bg4ifFE6czf+kv3saNunLYpbeEIaDZJ8SwEeiU
	 V8uZwrQaPeJ19U7CqPQzClcie5phDvg5A5Yv4Qilaq8UYGPdHUMETELx5WkigXYq/6
	 6QZt2RbIdcxxAaSG2vgVrDxgJhDoV4NEAK+DiY8yVLjNJFGVY6rUqomzt0gsuWo4Vj
	 gAOlmncDsJoPw==
Message-ID: <e75431be-adab-461c-9a35-3245b3cb3534@kernel.org>
Date: Sat, 16 Aug 2025 16:02:14 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iommu: io-pgtable: Add 4-level page table support
To: Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Neal Gompa <neal@gompa.dev>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Hector Martin <marcan@marcan.st>
References: <20250814-apple-dart-4levels-v1-0-db2214a78c08@jannau.net>
 <20250814-apple-dart-4levels-v1-2-db2214a78c08@jannau.net>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20250814-apple-dart-4levels-v1-2-db2214a78c08@jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.08.25 10:40, Janne Grunau wrote:
> From: Hector Martin <marcan@marcan.st>
> 
> DARTs on t602x SoCs are of the t8110 variant but have an IAS of 42,
> which means optional support for an extra page table level.
> 
> Refactor the PTE management to support an arbitrary level count, and
> then calculate how many levels we need for any given configuration.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---

Same comment like for the previous patch about the commit description
but otherwise this looks good to me. With that changed:

Reviewed-by: Sven Peter <sven@kernel.org>


Thanks,


Sven

