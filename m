Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDD9370AE0;
	Tue, 29 Sep 2026 08:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790669780; cv=none; b=GceLoIJ+JaD9rLcfg9VbJJ+k5f23MEIalsWsqqcr5j2dqbXLGS6BmwYc0y1CfNjGKos7ji+qkiCxv78XG0lvMgyHRg+ePHxBMdOCNQ07KkAFmcTNJOjIoItoLGUL9pHDbZpTap9+k3uCa54UFNBXaaBjSPKg67LRN5Ng85MxIVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790669780; c=relaxed/simple;
	bh=66HRjhKLAJ6uPXz3VliDoKzODGayGuh0qwuwW7KDOc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8g06OHNC0Pt9rbWKshfiPEjmh2xDc+YK3BNaS3jptT+RLDOcG0YfLs/iu6Ky5moj3H6pgrBqAYiRyuqcZzRdB3XgSN0m3CkQPyfyYGnoMIRjHjl0xbMHTODIsXkVKEd6FSH51eb+j9n3FmJBV1E2qKd1UAYN1/tAX0ZhwNc+ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FB1NVZv6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FB1NVZv6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665DD1F000FF;
	Tue, 29 Sep 2026 08:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790669776;
	bh=u85DHQjzFjhjJwGM5qYe2m+Wu3+JBRzNXyLVLc7SDKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FB1NVZv6x3IyrLnfD9QkqxVp+v39HFsLNCR/yEaV9MTzxg1D+S9IF31eEhnh9QIGh
	 EPjeUJt5QWFa/+fL46Y6mbxuFMCE2Vnmqd0U8fV2sdhlDLz2M2x0qYDoop4cyJgRCg
	 3lj5ImVnZ41dAPNPPBP2QYfYCgA4u/q2FpqfBdUtUVv5iCne7oiI2Q2NGVIa5+p8CC
	 oX+JmZwQajW7NFfcaOmUTLRAnBToqghXGZ5UPvX1q2lyHub/7KMdDHhzonCYKQSFIt
	 kJq1tS0Xhiqnue7d2sUvYJnqZj0Vahl2PoZKnxcaF48Nnp+20eZMNS2xEbInUgnH4X
	 SNt7abk6wfIIw==
Date: Tue, 29 Sep 2026 10:16:12 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH 2/7] dt-bindings: mailbox: Add Apple M3 compatibles
Message-ID: <20260929-debonair-busy-hamster-be2fda@quoll>
References: <20260925-apple-m3-nvme-v1-0-5e832e2f4aa9@jannau.net>
 <20260925-apple-m3-nvme-v1-2-5e832e2f4aa9@jannau.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260925-apple-m3-nvme-v1-2-5e832e2f4aa9@jannau.net>

On Fri, Sep 25, 2026 at 10:22:49AM +0200, Janne Grunau wrote:
> The ASC mailbox on Apple M3, M3 Pro and M3 Max/Ultra is compatible to
> the mailbox on M1 ("apple,asc-mailbox-v4"). Add their per-SoC
> compatibles "apple,t8122-asc-mailbox", "apple,t6030-asc-mailbox" and
> "apple,t6031-asc-mailbox" to its dt-bindings.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

