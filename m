Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401191;
	b=mBaF8Q3FndAdTr1QzmJEKcUqXShk3gvF5JbMKzyUuyl60/lygeLjjfaIRN6wCVDVK3R1
	 3drkqXNnwTpjxyzeGM8XSQ1N2Rnqo7h6fexbpOA0e2HeXHcpWmn5mNfcc50A2L6KMb5E+
	 1n5E133U6D2dszzt9pus7EYzK9lq9odlaWYLPpuLQmX0d3ARKNmzhm1cimxpBQ8XRSL5T
	 fZu0/e/HIBhQmIZD2b2k2HjPUhoiJaj2eAtNKpAbZivXvH/42aNTkSObdST/h1xOeWF5e
	 p6oUSeXJvSJd2u6/Hd2KEPHp97rLdmbBZc+0QDjkfnER/u6bDHidQQd2tB7lQmufi7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401191;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=SHj7bmBau/ON4wrVotHqsjE11ISH4HLh0/LAv4uQZj8=;
	b=LdRistw/ctzVAcHu37WLtyZNvTE7CZofJErzJgHhAh+svTgoKMsXsi7coy2TRVU++4Bl
	 MNI+OmjTZHCGkfTpc4LjO+DBoYBJLDJdumfbH1M1SiV+/xp3115CQUfQS/9JcJJ8iLO2w
	 Tp3hdQilk7ggpFNDgTPmEKgOxbnuKn+8HAB63jc8d2Mq0cUSHuT4HkLJ8b+QyhwI5zikh
	 3tnoDyk6JC6bOwEsh99jfpNz2bhD3hTmmFfOQcgnnp1LehNE1814s2lHntbtl55+1sJKB
	 qVjTzRq8J5SQZ7hH1SWcZ3XuseOoQj+SdQjFBKKfdohGZxeiZBDknIgoMiKIx3YcIzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NhegUqfA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25276606A321;
	Wed, 11 Nov 2026 12:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NhegUqfA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4C91F00A07;
	Wed, 11 Nov 2026 12:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794401190;
	bh=SHj7bmBau/ON4wrVotHqsjE11ISH4HLh0/LAv4uQZj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NhegUqfA361A1Zssh1t4Q4dCNuAxd41ocwR+bRcyHMwuO2CDY0qsBVGsWna/Z0FKC
	 VAsOdU/Zwi0mA5dc84h1YSESP1DhBu/F2CylTzEuv3G0kJIrBtQEMZVvoKPm4FKvgP
	 sVdmIG/m28QWRqxUBZs7VaMASwiwoVUdzm/zi8LUtmZO+Lnjn98PPJalX/PM7811QJ
	 fuO1yx5ZY/jin+Gjyl16Y3dytlNpJ7oCbDXdnaSql7CP1KYHx1EnQlrFvkrWWpE3Q6
	 us8MbRvJ74BJirIS6vfi4Ag6QFeDWcSaDJNzWVkTHwFrM59oGQVEkjVtpFafy3+Pmh
	 mf/Eoa5KvqPLw==
Date: Wed, 11 Nov 2026 13:46:27 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
	Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH 03/15] dt-bindings: nvme: apple: Add
 apple,t8142-nvme-ans2 compatible
Message-ID: <20261111-comical-quaint-turaco-e8c1c2@quoll>
References: <20261106-apple-dts-m4-m5-nvme-v1-0-22f4827b4ece@cyberchaos.dev>
 <20261106-apple-dts-m4-m5-nvme-v1-3-22f4827b4ece@cyberchaos.dev>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261106-apple-dts-m4-m5-nvme-v1-3-22f4827b4ece@cyberchaos.dev>

On Fri, Nov 06, 2026 at 10:04:12PM +0100, Yureka Lilian wrote:
> "apple,t8142-nvme-ans2" on the Apple M5 SoC is compatible with
> "apple,t8132-nvme-ans2" so add its per-SoC compatible.
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>  Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Squash all nvmem patches. Don't add compatibles one by one.

Best regards,
Krzysztof

