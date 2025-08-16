Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B7613FD86;
	Sat, 16 Aug 2025 13:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755352303; cv=none; b=uBYyGHwGSbqBEKhgmPHPgxXDnByFLi+IWpm2hHQdoYJB1/yW0KectgukZJDl4LFARkSECJj5u1cthmLnL8DFSlrN6HdZz6uH5H1bMfn2xsvNWsyErUTBmuSNGVGrrOi5raS/DzQATRFkjSSFVhhZkvIBG267DVc9u6WV0oMSAxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755352303; c=relaxed/simple;
	bh=/qZDmh5/8XKUYKj91nL5Btm7IQfUf6RnaVizyK1MG9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MdJ83G5JpL7V5KgPN1Yu/xuZtYF6SS4XcYD7JmxlZA2umWJ9qnF8H5+dxXSXWQCUXVAkfjjhyCKyuZG5bnWcJ3C8tGy2qtRgI7YliHfic972T29OMnScsAE5v9R/0xxdd9EtkFg97fl5FrOJrj6USpxwT3kl2XeCRZMf8cW+p5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4sXc0/H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4sXc0/H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26215C4CEEF;
	Sat, 16 Aug 2025 13:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755352303;
	bh=/qZDmh5/8XKUYKj91nL5Btm7IQfUf6RnaVizyK1MG9I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e4sXc0/H+gZwdIb1XeOq7sXcmeOPPFTpoTkG6dJ1dnrSNA4Oe1nRM1nZ0w0tIdzAy
	 yJxh4Lm0PPOrugXk0mwxbSpCv6O1FfULeqTeckExLj+TY8ZQNcLYmy6NYMqK2fNGyX
	 qsvCRSuDdDFSXz3b/FPKCdLSrYmYLxhq8OKY1ZqsWKU7b4g7GrZ7CyaUlYfSiIs9RL
	 u4aaBhT5adufXXDYC+qCY+3JNPoN8osPPZ+L1p/3J/4WTngmQ5Ff1cmaxjfjs++f1j
	 i/6tOFg5PdAcCI2KuaHvGfXYT8/mrk0mBQyeuX3WKkqONYdymg/z78/6zpSrMiNTYY
	 VODErzwKryGMQ==
Message-ID: <bbfe3c37-db5d-4860-b3ec-546975304426@kernel.org>
Date: Sat, 16 Aug 2025 15:51:39 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] iommu: apple-dart: Make the hw register fields u32s
To: Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Neal Gompa <neal@gompa.dev>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Hector Martin <marcan@marcan.st>
References: <20250814-apple-dart-4levels-v1-0-db2214a78c08@jannau.net>
 <20250814-apple-dart-4levels-v1-1-db2214a78c08@jannau.net>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20250814-apple-dart-4levels-v1-1-db2214a78c08@jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.08.25 10:40, Janne Grunau wrote:
> From: Hector Martin <marcan@marcan.st>
> 
> The registers are 32-bit and the offsets definitely don't need 64 bits
> either, these should've been u32s.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---

The commit description should start with iommu/apple-dart to keep 
consistent with the subsystem style. With that:

Reviewed-by: Sven Peter <sven@kernel.org>



Thanks,

Sven

