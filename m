Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401221;
	b=lPU5H5/BDr5tPJ9DknYW9CCCOkHKInt5sdpmR8Not59tt8/LIMhnGYnSC7UUUMowV5f+
	 Xy5g8mtTqAoUXyDzsXB7om3+jrjXMn/uZie/JpNsxwTu3abr4I/khSxkN+qRQXCai6xGe
	 TKQjETEIe4e9UbOM7Cg/nnTEJWuNVdVni96tRtkhCQG01nu15cFIZEUMpxdFFMsWgjneG
	 ewDPmJWlc04dPFFW7gjn9bEiZEdYCSVFgbGgOZY7kh0xOMosykluGLrz9br8DyQU5Oc1i
	 IeImVw5rRXPHYgcX4EZf4NCSTXp9hmsp75pzuQ6JhTaf3qwGbTqBDkZAVhf2wKgdrYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401221;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=K4KsszHoQU25eoLKNk19Xgiydvgb75r3NOFjVZOwVl4=;
	b=c35cVPjQgLN5mVUfR+rxRdN/Udidv8WDh61ecZVZlffFXNmOPUjWloHKNMANH8c3Thot
	 mxJLF0ELOhfvvI65t+O6odrzbL6i6sagA6ABVGMmqzytk4cn+aj5xjwy3NYvmAKKLvuNe
	 xrfRmKASWn51hEM5tRfAsO2i6MVayFZrz2fklcBXbThf0cSfy1BorH4CZWeVBb2LM1zT6
	 ezBoxA5oPnIl/HDi6SWX32r64PJ4oKhcb4xFiXdW93cSjYi2wY3/ybqk3+14kFxOI8gS/
	 i0kInOKU4+9G7PMyh83kF2jWIIPInVX4l5DMybs8LBcR5v3YN+33EaY16H58gOzXsFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nOefZ9Au;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DE8606A324;
	Wed, 11 Nov 2026 12:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nOefZ9Au
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58021F00A05;
	Wed, 11 Nov 2026 12:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794401221;
	bh=K4KsszHoQU25eoLKNk19Xgiydvgb75r3NOFjVZOwVl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nOefZ9AuKw2af0APzYszhjr9lNBNl3iOe4vesBFAvwseV8O/YjueOjx9WG9DNBwLd
	 NypvJUnQlFaSejzvulYLfdeiZJtNPVgZufvsyxv0yFFTJfcVuOc/qCOg0ZHcMmYr3J
	 f+FjyOWBHRomV2AlXfPiVBeiHVInrosetF5wOTfszdzObI9HOsIryW2oKcfBk8bTcI
	 SbK9G++K283ZWgbQ7spQFteD0RxsJB/2SNGLj6u6pKpzYn5Yl84ygFyFISdOwbzbZc
	 Dnv2NY6jg8OyNdc8mev6W87CwEcVtuJEy6a4ZzqP2xl1AA3rFkvCiev5sIfTCkwXF3
	 a9RN4LBuAd3Hg==
Date: Wed, 11 Nov 2026 13:46:58 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
	Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH 07/15] dt-bindings: mailbox: apple,mailbox: Add t8142
 compatible
Message-ID: <20261111-daring-tacky-cockatrice-a9bae9@quoll>
References: <20261106-apple-dts-m4-m5-nvme-v1-0-22f4827b4ece@cyberchaos.dev>
 <20261106-apple-dts-m4-m5-nvme-v1-7-22f4827b4ece@cyberchaos.dev>
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
In-Reply-To: <20261106-apple-dts-m4-m5-nvme-v1-7-22f4827b4ece@cyberchaos.dev>

On Fri, Nov 06, 2026 at 10:04:16PM +0100, Yureka Lilian wrote:
> The mailbox hardware remains unchanged on M5 SoC so just add its per-SoC
> compatible.

Please stop inflating this. You are only making it difficult to review
your work.

I am dropping entire set from DT patchwork.

Best regards,
Krzysztof

