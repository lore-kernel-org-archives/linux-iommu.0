Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E472CA5A;
	Wed, 27 Aug 2025 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310455; cv=none; b=CHWRoyhi6I352kso6aT45XES3jp1iNnQmn8QUBUV7gePJJMzjH3iB9ACLcXS1mHHhtrHR7NwvEB6dVYFURprC5J31HoBvgGVTL6Gw9WrXMAjkz0PePZRIhBfmRvZCjMEyOlYxkUBTvD1WaQVwjOaNBrMThcbenMZ5imYm01xwN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310455; c=relaxed/simple;
	bh=kE5prbuLMMfTkalo6Or2f96AZSVVnnWkRbtWsb2rdSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ee4KlUN0Ic1LSRn912M3g2XPyhlkMqABvsZdKdCTUAnIyzCDP2mIgNQoJ3os+LdAkvdfxIB7CWvDPnWMklWpf+LKhaTU2kmPjii31oxy5k2zZA9JcExsf0JcFGKJOZ6FusXUSj8XgTfSA3cKTPGDthqUUK1ECXWL3nFMbMMJuJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJtbhA46; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJtbhA46"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DDE5C4CEEB;
	Wed, 27 Aug 2025 16:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756310454;
	bh=kE5prbuLMMfTkalo6Or2f96AZSVVnnWkRbtWsb2rdSE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VJtbhA467eMUwjfE86Y8nZu9L4CV1ewBmoughctmukR1m1FJq1Z6G3gunJVzc8rr0
	 gei6CWrhv4E0Xjo5xjTxxpI2v1QOLHgDkVXFKkkx7eArl7XEkL5kUjIfg1LjLy73vJ
	 Yh6f5iIiXfta7i6tdixTD5f1dzwifr6N/hl6fBh401OF9k0ffNano/zal+scXfIUYS
	 PM7GIIlb2ANYWU6bPjqblf4mv2uiPhwOcFmrp1V5SwIrUZNdiFdj9TT/DQj/cCiqpn
	 wQqaV9uV1Jn93R83AvznkCdLMDlekYU/VwqU4iGrcICCp4dkoCKB/1xHvK95ytZYg1
	 WINjmmTA4ybOg==
Message-ID: <d0253c32-6dd4-46a9-bcd0-fa2215aef731@kernel.org>
Date: Wed, 27 Aug 2025 18:00:50 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/apple-dart: Clear stream error indicator bits for
 T8110 DARTs
To: Janne Grunau <j@jannau.net>
Cc: asahi@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>,
 Joerg Roedel <joro@8bytes.org>, Neal Gompa <neal@gompa.dev>
References: <20250826-dart-t8110-stream-error-v1-1-e33395112014@jannau.net>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20250826-dart-t8110-stream-error-v1-1-e33395112014@jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.08.25 12:57, Janne Grunau wrote:
> From: Hector Martin <marcan@marcan.st>
> 
> These registers exist and at least on the t602x variant the IRQ only
> clears when theses are cleared.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---

Reviewed-by: Sven Peter <sven@kernel.org>

