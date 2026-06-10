Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3568E348C67;
	Wed, 10 Jun 2026 17:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781110978; cv=none; b=fILncN820InYJOGWcGoGqHGWxArigykHjk+5lMznhe5KU4s4ys/9FKcb1lGxxwYfI7ccCnc5UXTMGBgnWdsnmqKXYs+tmrIFZVglRUY3Xh3MNgvRj7Vgmugjw3RoyUzr+Ta9jWzJnF0BhpOMMgMImQLhK55DkTBUNcA9Lm5kXzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781110978; c=relaxed/simple;
	bh=S5MFmg5m/c186ICeYr0wlxrq2bsDUua7Z+5h6Y3DMUg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bTJXHCjrT2KAebGXuBFAhof0hj9EZnjejjSiwTTL+pjo/VaD+cdePPAd7PCK8iQ+lZ6WqmyxRW+6EqFbcMtPjf9+4QxWua9VmQKjCrnshVdsAIHaPB9p063sDeDFOXc/p5qeTciQYe2gq/BOUipO7mLW6cY2CAyU2iB8qdyIP/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iN+mR1YZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iN+mR1YZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFF21F00893;
	Wed, 10 Jun 2026 17:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781110975;
	bh=8AwSJODo9SXO6D3Aid6z5KkkoRluYiytZXKMrqeE+i4=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=iN+mR1YZEVPB931+p6b8xpj/aFcO8t3bawD+bLvwf2y8s8yJhEZtIBG8SHMQ2wD0y
	 wQRChT2eS8T55T9ey2yaYW+jXA99ikXRj+kGPc2eddPgaLMjXf5QaY0SYfK638iEK0
	 Jlr222SpW8oNZRSEqgwRQZ0Kw9sewuc4bL7Put5tpeXJMuOWVNoM/QptkO6wAylap5
	 g9mQb4Srmr8+9DYqb992cQmri7tNlzRVF+fUx4TxNI71TzRTbolDE+G8NLxUeW8jAQ
	 Izk0V1XchaC6jTQeXbWDYJijh/VrbwJ52UkV8j0PEb0HBjR0kTvp5vHlOZTDxdIeED
	 VeVMlgc275KjA==
Message-ID: <47b67e63-f856-4d2d-b4fa-b14ca363d4f8@kernel.org>
Date: Wed, 10 Jun 2026 19:02:51 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sven Peter <sven@kernel.org>
Subject: Re: [PATCH] iommu/apple-dart: correct CONFIG_PCIE_APPLE macro name in
 comment
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
References: <20260609195605.149650-1-enelsonmoore@gmail.com>
Content-Language: en-US
In-Reply-To: <20260609195605.149650-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.06.26 21:56, Ethan Nelson-Moore wrote:
> A comment in drivers/iommu/apple-dart.c incorrectly refers to
> CONFIG_PCI_APPLE instead of CONFIG_PCIE_APPLE. Correct it.
> 
> Discovered while searching for CONFIG_* symbols referenced in code but
> not defined in any Kconfig file.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---

Reviewed-by: Sven Peter <sven@kernel.org>



Thanks,


Sven
