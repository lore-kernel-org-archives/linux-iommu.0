Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793685992;
	b=Fxf7vLz5lKH6YIv4FezZyHkpFga7Fwwiw1XD0DqXbcj1u3gFpBTG9+tFv4aoZmqTebK0
	 P31GEBZYwN+PS9V2IZzPFClhpC8UPlinkdOtwQLSAXNGHbAB7rvNrNNulTrIyvjpJ9FG0
	 6258oJMGulW4ugBHl7/8sZWe37LVCjIkBbXHfTrr+naecMc0ujr/nAciV1/t64eac+Iz1
	 kKS32oQy6UCbSQcbAfjj/VVMP2DaodM1K79PC0eZwM6MBi6eKSzJsqIGYyQoFYod+4hqH
	 5r9nRFclMigVe3QUa1G8GuIeurP36ZFW+u7bIXv36ygkhhb+6Qd1JXyCwJm78JxpkAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793685992;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=G7dBpgXDg8IWtuGJ7pMO6Cw0uUaelzS3qcqMb/c3wUQ=;
	b=zsgKVxticxOAkHV8eP0ceduTom1j3qsgP1UQWgaUky/JNYhJB5AsjNSCp/ZoOs4Q0R7Z
	 Zl5+XUgoO9aGtlEd76oXMxUqqELrs7f26JdFGgnnMw1eXRDbWv9KBDIP6Cz5vyx61SvUo
	 AtZLmMSy8paBEqfn19r9ZgLc/uYpOpEOL3PjRP7KzTp0amXc1C9CR+jwrohR01id3YQD2
	 Na+NUrCO3G14Viq10Lv0VwEPFsupt5jWB7eEzks9XNe61p8hgEuLAu8IxW1xhlWQqHOyI
	 UeCuSroCH7qalyCkxjxOnE3fT5PmNkN0tFJP0isMLdn1OlwxVDvrjjj0y8A4BxW0lhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W5XQ1MrM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C01606A32D;
	Tue,  3 Nov 2026 06:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W5XQ1MrM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698671F000C1;
	Tue,  3 Nov 2026 06:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793685991;
	bh=G7dBpgXDg8IWtuGJ7pMO6Cw0uUaelzS3qcqMb/c3wUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W5XQ1MrMLmf/v9KDbp37KF4erp9rYyVMWYf4qhsjtOmpcggSNBb4TC1ry8S93ONc6
	 QN5zfcnA+fuC0KBHoUzOHZmOJLJu6RIrVX8iUsRocBOk5M3S5sxHGVfBSosyEWfQFh
	 UvsowjKfA2nw1BqS1H0kOzAuPOfzTLALDfzUbRCtvcdAECvvXs8hHT/kXO8/fc9sSC
	 b+yIi2F0CxqCvvuoENG9bhq1pb5jArRQvp7xR2njthtd6ZheQ1OU1Og5BO+/D05fgX
	 dTAWOlCa7QmqwdQ3/yDnQ5D0+wHhcfhXUHE5x7SRab+cv3dRT3mHZJNLMTgU9emTGY
	 MFxiv3lKDdh+g==
From: Sven Peter <sven@kernel.org>
To: Neal Gompa <neal@gompa.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>,
	Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>,
	linux-nvme@lists.infradead.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	iommu@lists.linux.dev,
	Michael Reeves <michael.reeves077@gmail.com>
Subject: Re: (subset) [PATCH 0/7] NVMe support for Apple M3, M3 Pro and M3 Max/Ultra devices
Date: Tue,  3 Nov 2026 07:06:24 +0100
Message-ID: <179368585837.109404.1193998615991501898.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925-apple-m3-nvme-v1-0-5e832e2f4aa9@jannau.net>
References: <20260925-apple-m3-nvme-v1-0-5e832e2f4aa9@jannau.net>
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

On Fri, 25 Sep 2026 10:22:47 +0200, Janne Grunau wrote:
> Hej,
> 
> this series adds NVMe support to all M3, M3 Pro and M3 Max/Ultra
> devices. The hardware works the same way as T602x (M2 Pro/Max/Ultra). If
> there were changes they don't affect the way the existing Linux drivers
> use the hardware. So this series adds new per-SoC compatible strings to
> the mailbox, SART (IOMMU) and ANS (NVMe host controller) bindings and
> the device nodes.
> 
> [...]

Applied to local tree (apple-soc/dt-7.5), thanks!

[2/7] dt-bindings: mailbox: Add Apple M3 compatibles
      https://github.com/AsahiLinux/linux/commit/b96264bcbdd2
[3/7] dt-bindings: iommu: apple,sart: Add Apple M3 compatibles
      https://github.com/AsahiLinux/linux/commit/300a52ab04e4
[4/7] dt-bindings: nvme: apple,nvme-ans: Add Apple M3 compatibles
      https://github.com/AsahiLinux/linux/commit/5874c917ad89
[5/7] arm64: dts: apple: t6030: Add NVMe device nodes
      https://github.com/AsahiLinux/linux/commit/b876489f1f3a
[6/7] arm64: dts: apple: t6031: Add NVMe device nodes
      https://github.com/AsahiLinux/linux/commit/ff00db14d0f5
[7/7] arm64: dts: apple: t8122: Add NVMe device nodes
      https://github.com/AsahiLinux/linux/commit/acb925da4987

Best regards,
-- 
Sven Peter <sven@kernel.org>

