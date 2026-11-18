Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795033472;
	b=3R2GsO7BXaU82hN62QDzkOYnneAtnPmem3nPepePy916vOt8iehaHq4rts4kGkS9JvN9
	 3TGLKxcdJZmPruELDzALXRykcAToeae1VNy8nY0Jz5q78adyT/PfGPD39hwRAsofRjIJg
	 XYNsm06F+Av/pej93tSX3/YVBAAxkFdLgYxptCuhI0HyjtKZc88QG7MRft8kOargjEEeR
	 pJkPS/qPIlbvgYEfHGFMXkChcezC0y02Bk+aG0K5fvgsMb8Tqio5olF1pKrrVVZ3diQ6C
	 t9fFdEmXHcyd2vxAqLRhhaihi8N7kp7xLRZFMXtmE+zqqP7paeLpwDBu+Ltfz4b76Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795033472;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=FxLntHqNI1+h3sJPoaAEyO+/hQb8YRhU4FckPwMqXOY=;
	b=SDris7DYKzPh5ZhOy9H/8VdNlcpY73lMfcvBdRKkLEXhKyS/0b6TtNEY6iSXm5BR/cgF
	 T2Qxinio60Dsd/LMEPwyzqwES07sofssrIbKf6g1+EMq1feUgRSl38O48RHlfxSzRPQ/R
	 tMaYmsKRlW4ALHA2wTge7f6NVWJ5D2VFtCxfITU11WziiBJORM5iMGeR522csmiuZZebt
	 od2ATt/RHXfIJKire/Q53qxTrPovz/Gy1POopX1yO5C9cqWXGJuhb5CVHUL1zTFKm+If+
	 9Lb3cZ4AJgDUECe1GLxZ3/8CR9gBaq2XZnLaQAe9io2nOO/Eh0hnU0D1sgmG8m3uibw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y44GakXv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A369606A325;
	Wed, 18 Nov 2026 20:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y44GakXv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B7B1F000C5;
	Wed, 18 Nov 2026 20:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795033472;
	bh=FxLntHqNI1+h3sJPoaAEyO+/hQb8YRhU4FckPwMqXOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y44GakXvG5GHKA31JnnJ8TOHTL4DJuDPzANJjJWG60MjNDOfyRHhJIm8vJ9IDSIev
	 kJKebboMkeglmR/Z3kWmpAzBb/AQDqIH9Izq2L/2oEbS6SEXi6ZsaYaQUkJZjqCiEE
	 /cEFzHQ3SGAkusbdtG1G+mq2iETbisKSIMwmFp2X1YKr62QeB8t2Omdt7o8wYE65tf
	 74JyKMlIkz2XlLsmuBGfkZAol4hWxO6LXScQh90VN9uTyIGALwX/totrf6ZkzLWXcR
	 OAC91HP6t82IYLn0SO6X1Zc4Z9eHlbMjrylVDrjpOpZr9CRq/RJ7Wgclipi8eTEcKP
	 JLUuYHqvl39TQ==
Date: Wed, 18 Nov 2026 14:24:26 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: krzk+dt@kernel.org, rppt@kernel.org, jenswi@kernel.org,
	danielmentz@google.com, akpm@linux-foundation.org,
	sudeep.holla@kernel.org, linux-mm@kvack.org, ryan.roberts@arm.com,
	ardb@kernel.org, catalin.marinas@arm.com, sumit.garg@kernel.org,
	op-tee@lists.trustedfirmware.org, will@kernel.org,
	robin.murphy@arm.com, mark.rutland@arm.com, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	david@kernel.org, devicetree@vger.kernel.org, hch@lst.de,
	thierry.reding@kernel.org, linux-arm-kernel@lists.infradead.org,
	m.szyprowski@samsung.com
Subject: Re: [PATCH v3 4/8] dt-bindings: reserved-memory: Add
 lendable-dma-pool
Message-ID: <179503346493.801350.7313588345506554121.robh@kernel.org>
References: <20261111110738.872947-1-vdonnefort@google.com>
 <20261111110738.872947-5-vdonnefort@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111110738.872947-5-vdonnefort@google.com>


On Wed, 11 Nov 2026 11:07:34 +0000, Vincent Donnefort wrote:
> Add bindings for the "lendable-dma-pool" reserved-memory CMA pool, used
> to dynamically unmap pages from the kernel direct map before lending
> them to a secure world.
> 
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> ---
>  .../reserved-memory/lendable-dma-pool.yaml    | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reserved-memory/lendable-dma-pool.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

