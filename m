Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401162;
	b=GFEt3MCRU2lYRbxFM+Ehw4jVPaEcanPT3japW9lBULZdCM264wGfpQmXKiQ1xw16/1Qs
	 He6YXAIMMhW6ZEhaDg/mUO9e5yfjSNhrHxkyR//FOC7c5u6iEEoTRATE9ry6PYF1yAOLl
	 AXSbshNDmbRtN6zNrQDZdMpDAsQTjjrsUbc2eebcsWtXih+u6uJ8CISTuOpoZ7mvj5C6M
	 isOFaPSHETzXjM48Z2GV9Nhxhw2ABougCHUM4u6DPzQyaxtrtZK+LFLXsR+aXAg1RWLI5
	 9EaKIUjRT7wAV535KnsuJngzBwpB5jj+loP5i/DW9eqvCnnka9wU0j2icDw+zjFi7bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401162;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=z5BCYv76c8kIBtjGRC+c0LPz+SKFyrga3AVP3L1K+5o=;
	b=JazErJ+VbrJYtQFbbHuImOH0lubAhqEuOfM9CvCZXDvudhToHlsECKm1ZjEMrn3sx+BJ
	 AppUhgjGCdc0y/kK1XCaG4n6JjgvKgJyDMv6eDjIMJY7LgzZkh99imXBto7GmJIRzZRuy
	 JHiURs1QW7aVAyb4q+LDGJwva61ZmPHxAnZzBUELpA0w54XRepvzmHitB3ofbcevirwlG
	 RyTFyyHdjAAg9hB1F0NbY3Yj6e+3JP/DyAEhu7+xeKGl3Oh+Vx9W9lXKh62oYJzI5kziy
	 9xQFEUhgpguQFwt3/oYvb54Ob8s+z3qh961nDcSdGnUzACX8vcBZBvS2Gaad5cLkL4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RHLZYOZC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666FE606A332;
	Wed, 11 Nov 2026 12:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RHLZYOZC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE521F00A05;
	Wed, 11 Nov 2026 12:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794401162;
	bh=z5BCYv76c8kIBtjGRC+c0LPz+SKFyrga3AVP3L1K+5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RHLZYOZCrsgqoLaM7Y61icKNl+4pudcP/UHwpqHxpl6eBDxMW5Z3KjlzSVieqHbMc
	 qM1joFeefCCSgxz4fs4AqbRQleX21he5aEs71YFiCjUtoET9xeIV+LBQc/+7IRCoGF
	 sE7ySPku8hfMULWVe/vR+T1A4zg8k4qUEwTptfoVg+B6KiZt0iKN78t6yE5jKdx/b5
	 z4btscL8zQeYTUi6iUIs+mu25VrsmgHj682w3o7lYerU4nLtWmEOswHVlPpqKorjHE
	 LafsJYk8UyKdk2Mu5fEUZ4zDc9UZOxqOrQzOORlGh/NHz0dxdCDNNgpccZH7+c7tKm
	 3A2NH7JrLtjkg==
Date: Wed, 11 Nov 2026 13:45:58 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
	Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH 01/15] dt-bindings: nvme: apple: Add
 apple,t8140-nvme-ans2 compatible
Message-ID: <20261111-brawny-lavender-ferret-83a692@quoll>
References: <20261106-apple-dts-m4-m5-nvme-v1-0-22f4827b4ece@cyberchaos.dev>
 <20261106-apple-dts-m4-m5-nvme-v1-1-22f4827b4ece@cyberchaos.dev>
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
In-Reply-To: <20261106-apple-dts-m4-m5-nvme-v1-1-22f4827b4ece@cyberchaos.dev>

On Fri, Nov 06, 2026 at 10:04:10PM +0100, Yureka Lilian wrote:
> "apple,t8140-nvme-ans2" on the Apple A18 Pro SoC is compatible
> with "apple,t8132-nvme-ans2" so add its per-SoC compatible.
> ---
>  Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Please run scripts/checkpatch.pl on the patches and fix reported
warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
patches and (probably) fix more warnings. Some warnings can be ignored,
especially from --strict run, but the code here looks like it needs a
fix. Feel free to get in touch if the warning is not clear.

Best regards,
Krzysztof

