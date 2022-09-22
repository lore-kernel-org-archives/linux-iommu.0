Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEF23C26;
	Thu, 22 Sep 2022 14:06:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 8FCAD425F5;
	Thu, 22 Sep 2022 14:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1663855565; bh=IydF5r0bwDxzvvlIl9TxDhyPgIBbw9VfI21vnIe6xyc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QWCLSwH9Zu8tmvAgyNU8L+E3ZSC2DJr9cXDYuKOJ4wnNv0KYrpVxZsO6cLeh4dIgK
	 b1/WnbRUlVqVguRXcwXDLBamyaYegJjAprs0dn0b0CpT/uJBcDDN36XJQpl3vejslY
	 OfudroNDHHsAOhx9HcBzRqL/uf5r3knwDt6mbDozdmaHf7A8BYM88Ee2kKpF7Ulq6H
	 fLvbaOBeAUEB3zW/7kBi58NBMXBk7hHyb5h9a7Wj3XPQ+TQQh+Ox5sfhquCeIoktVn
	 CAsOJJ1hQrqjIEwyV6yLXHF64QOd/eMc1pG8Gz5IEUydjfypAeGLFWr74TIYuOXPR6
	 2L4ljj6UaGwXg==
Message-ID: <1a3771f5-39e6-4360-2b8d-2563ebdffd37@marcan.st>
Date: Thu, 22 Sep 2022 23:05:59 +0900
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 0/5] iommu: M1 Pro/Max DART support
Content-Language: es-ES
To: Janne Grunau <j@jannau.net>, iommu@lists.linux.dev
Cc: Konrad Dybcio <konrad.dybcio@somainline.org>, asahi@lists.linux.dev,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Joerg Roedel <joro@8bytes.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Rob Herring <robh+dt@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Sven Peter <sven@svenpeter.dev>,
 Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20220916094152.87137-1-j@jannau.net>
From: Hector Martin <marcan@marcan.st>
In-Reply-To: <20220916094152.87137-1-j@jannau.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/09/2022 18.41, Janne Grunau wrote:
> Hej,
> 
> this is the next attempt adding support for the DART found in Apple's
> M1 Pro/Max/Ultra. This adds a separate io-pgtable implementation for
> DART. As already mentioned in v2 the pte format is not fully compatible
> with io-pgtable-arm. Especially the 2nd least significant bit is used
> and is not available to tag tables/pages.
> io-pgtable-dart.c is copied from io-pgtable-arm.c and support for
> unused features is removed. Support for 4k IO pages is left for A7 to
> A11 SoCs as there's work underway to run Linux on them.
> 
> The incompatibilities between both Apple DART pte seems manageable in
> their own io-pgtable implementation. A short list of the known
> differences:
> 
>  - the physical addresses are shifted left by 4 bits and and have 2 more
>    bits inside the PTE entries
>  - the read/write protection flags are at a different position
>  - the subpage protection feature is now mandatory. For Linux we can
>    just configure it to always allow access to the entire page.
>  - BIT(1) tags "uncached" mappings (used for the display controller)
> 
> There is second type of DART (t8110) present on M1 Pro/Max SoCs which
> uses the same PTE format as t6000.
> 
> Changes in v5:
> - collected Sven's ack
> - minor fixes in "iommu/io-pgtable: Move Apple DART support to its own
>   file"
> 
> Changes in v4:
> - split dart and io-pgtable-dart build to allow building dart as module
> - add missing "SELECT IOMMU_IO_PGTABLE"
> - made map/unmap_pages/iova_to_phys inon-recursive
> - replace pgd concatenation with multiple table handling
> - simplified config and page size checks
> - collected Robin's Ack
> 
> Changes in v3:
> - move APPLE_DART to its own io-pgtable implementation, copied from
>   io-pgtable-arm and simplified
> 
> Changes in v2:
> - added Rob's Acked-by:
> - add APPLE_DART2 io-pgtable format
> 
> Janne Grunau (1):
>   iommu/io-pgtable: Move Apple DART support to its own file
> 
> Sven Peter (4):
>   dt-bindings: iommu: dart: add t6000 compatible
>   iommu/io-pgtable: Add DART subpage protection support
>   iommu/io-pgtable-dart: Add DART PTE support for t6000
>   iommu: dart: Support t6000 variant
> 
>  .../devicetree/bindings/iommu/apple,dart.yaml |   4 +-
>  MAINTAINERS                                   |   1 +
>  drivers/iommu/Kconfig                         |  13 +-
>  drivers/iommu/Makefile                        |   1 +
>  drivers/iommu/apple-dart.c                    |  24 +-
>  drivers/iommu/io-pgtable-arm.c                |  63 ---
>  drivers/iommu/io-pgtable-dart.c               | 470 ++++++++++++++++++
>  drivers/iommu/io-pgtable.c                    |   3 +
>  include/linux/io-pgtable.h                    |   1 +
>  9 files changed, 512 insertions(+), 68 deletions(-)
>  create mode 100644 drivers/iommu/io-pgtable-dart.c
> 

For the whole series, modulo the trivial warning I mentioned:

Acked-by: Hector Martin <marcan@marcan.st>

Let's get this merged please, it's been blocking t6000 support for a
long time now :)

- Hector
