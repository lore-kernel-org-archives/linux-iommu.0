Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C7813B58D;
	Sat, 23 Aug 2025 07:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755934138; cv=none; b=OnTRgErIOzKfi1Z23SyXJh8muWFaPunE2xmWA8QsNFuV101ud5ObmGqQKmGsII1JfPNcaVSMeX37UHCi80xN2utanQCOAZX1Cp7eVdyT03M60LatrnxkoGjiQv/lrTfZ3PwY4NVFv+g6d0UuLoKjPjxEbE2PW5+Wnr7AAS6JfPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755934138; c=relaxed/simple;
	bh=o5ysTK5lUokkQlsJ4ZNuL632O1gJLfvxM3SuJVSpKKs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gjOvN8idBLkZ9W3AJL/no45VySnoyQR9B1IouZkfum9494iR2g+At9V3Mu+3E5D9AUmSx+Rn7eCBu2zTu5u3kN8NgTVtulv9i3tZBlqRjKe9XX6O6Ihn3O3Eowy45y9hxZhV69AarAQDTcrqgHW0jo48e1iz/ALu28oGtKQib9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApN3htTq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApN3htTq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7C1C4CEE7;
	Sat, 23 Aug 2025 07:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755934137;
	bh=o5ysTK5lUokkQlsJ4ZNuL632O1gJLfvxM3SuJVSpKKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ApN3htTqKwvJMqTVr/MCNwfEyaqVeh/IlfKc5zg0JqC+1mN6hk4VcjlN8dA7tmtto
	 c7lHv/c8FqgXoysYwwm3jNdh0g7s9GYopBJSVUlub/NBD+FxAGl8FWC5vsFiDb9fBQ
	 WrZEhVcBHjveVLoRnK2yC2Sh0/+TNNJ0X4FlO7j5VXvOCFORVUUBE78m9dhPwYerab
	 KGAjaFKOweHoEKoic6MKZUO5pyUc2fVQOhpJ0S5JXt1DVOH0oUYFCjj7wMgNIKt+wR
	 BdW+7oaTBKfr/qk272qhgwc3E3cY3X762rKj0HlhqyLTpXm594vZ/lXy+IQPl9MTD7
	 7qhUcDWV+ItlQ==
From: Sven Peter <sven@kernel.org>
To: Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hector Martin <marcan@marcan.st>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nick Chan <towinchenmi@gmail.com>
Cc: Sven Peter <sven@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: Re: (subset) [PATCH v3 0/9] Add support ANS2 NVMe on Apple A11
Date: Sat, 23 Aug 2025 09:28:30 +0200
Message-Id: <175593408419.53541.12520438370584715457.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
References: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 21 Aug 2025 23:56:37 +0800, Nick Chan wrote:
> Apple A11 SoC comes with an NVMe controller that is similar to the
> NVMe controller in M1, but less customized. Notably, it does not
> have NVMMU or Linear SQ.
> 
> The controller is wired to an older variant of the SART address filter,
> and uses an older variant of ASC mailbox, so add support for them too.
> 
> [...]

Applied to git@github.com:AsahiLinux/linux.git (apple-soc/drivers-6.18), thanks!

[1/9] dt-bindings: mailbox: apple,mailbox: Add ASC mailboxes on Apple A11 and T2
      https://github.com/AsahiLinux/linux/commit/32299eb03414
[2/9] soc: apple: mailbox: Add Apple A11 and T2 mailbox support
      https://github.com/AsahiLinux/linux/commit/fee2e558b488
[3/9] dt-bindings: iommu: apple,sart: Add Apple A11
      https://github.com/AsahiLinux/linux/commit/08d37b6bdfa7
[4/9] soc: apple: sart: Make allow flags SART version dependent
      https://github.com/AsahiLinux/linux/commit/240893c1f5b3
[5/9] soc: apple: sart: Add SARTv0 support
      https://github.com/AsahiLinux/linux/commit/58b28ca2e669

Best regards,
-- 
Sven Peter <sven@kernel.org>

