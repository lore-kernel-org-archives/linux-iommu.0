Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793685593;
	b=UKOSnu8x2UFDDAxiIIX4BAXRA9h6ctfN8IEtSegnVY3xgvJqgUvrH5ASI3JvS20kRQA3
	 7Y2EhQlR3uuadHEXpF6Hvk8zS78iSGYeHHb8llVVz6vmnBjfjNfpNm0umRFlsxtcjo5Bo
	 Iyc75+l0qSeCq+UaGhCtdh54STvZ8uxDoGGgBL2RIFwzTaErIuQPyqnEtUpu7Lmz90R8G
	 sPfusDl7xLUfQvx4+cvJz6aCsHUK1hxMwwqcquhSCyR9x3MghBAuqK34kk56G0tLPpErT
	 XgIxgzO0lSGvqvPbYnt1tR8W86Oo6B7tjvyMgCRMzRKxtCAw/9VH9z6FKAMkWmAIUPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793685593;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ngSZ2pqR2sxPQ2bO2CF7a94hWgprN24K+32PDqqmK40=;
	b=qgQX7JgFMlkJErUtjxWg3a52nutL6wplsXNqWzvj//d/j7ssvvH4qgWZ6XhL/MmH6mpN
	 Dtv8zOVC5Xnxl1vTWLl7xZKqeFwdYvSUDMjsyEPFwrHUpSlpBG0wbViv9xlk8x/qRd3H9
	 2wn5rvP+k1NvMJuy/NUPqwtQT92YYAj6lqgeuFnm6g2+XBUpYZTQQht/iO6qcLm6EVWwL
	 fvAgJwudgobEWKQy/+YrLyGg78q82eZr+28vMmoFQLzCKNQc/GKz17M5PW4KILQLsk7Dp
	 /OHMHXTsY+30C5rHpvDCuqn4/eSABT53VIr8lcvBqY+khn0aAn8jgBCER1WlXoMlFQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gap6WM2k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401FE606A324;
	Tue,  3 Nov 2026 05:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gap6WM2k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79CC91F000C1;
	Tue,  3 Nov 2026 05:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793685592;
	bh=ngSZ2pqR2sxPQ2bO2CF7a94hWgprN24K+32PDqqmK40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gap6WM2kbcvJLj8N3Kr0C3GGvAOF52jS3O2quUzstowWmW4i/7W/JGMxOLh+vgNMD
	 a4DDqL2vl/MeciMqeDh3B/4Dbb+8uhYWFwbLwcz3WUCyU1VtxNcMWgGhu/xYr+ZAfA
	 +WyNkJ6PTa6NbnujZIcc8A/Wit+5nWYViJMKfOj77ezmx4GeO8ShsDRTwqZfhIxJXN
	 BGkyJatlIgSaGqz/qQkqQ6EeObav4UQGzpaMQU5XWRkPiWH4qbegYLZz7ZENh1T0ow
	 bCKx0J/yMvhW+yn6b+RThKStPNS5hdjq+oJBDfxqwJ59Q3Ro3eEGobjbRvGzcYU7/4
	 jwKX8CZf2UD5w==
From: Sven Peter <sven@kernel.org>
To: Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yureka Lilian <yureka@cyberchaos.dev>
Cc: Sven Peter <sven@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Add Apple SART4 support
Date: Tue,  3 Nov 2026 06:59:41 +0100
Message-ID: <179368556096.107891.6027524594611326128.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261018-apple-sartv4-v1-0-1eaa5d63f6a2@cyberchaos.dev>
References: <20261018-apple-sartv4-v1-0-1eaa5d63f6a2@cyberchaos.dev>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 18 Oct 2026 18:38:09 +0200, Yureka Lilian wrote:
> this patch series adds the dt-bindings and driver changes required to
> get the new SART4 IOMMU on the Apple Silicon T6050 (M5 Pro/Max) SoCs
> up and running, which is required to use the internal NVMe.
> 
> The dt-bindings and device tree nodes for the ANS2 are omitted here,
> since the minimal device tree is not ready yet.
> 
> [...]

Applied to local tree (apple-soc/drivers-7.5), thanks!

[1/2] dt-bindings: iommu: apple,sart: Add apple,t6050-sart compatible
      https://github.com/AsahiLinux/linux/commit/d276a2b7f437
[2/2] soc: apple: sart: Add SART4 support
      https://github.com/AsahiLinux/linux/commit/01098fba87a0

Best regards,
-- 
Sven Peter <sven@kernel.org>

