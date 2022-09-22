Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BABC3C26;
	Thu, 22 Sep 2022 14:05:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 7381A43EB1;
	Thu, 22 Sep 2022 14:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1663855515; bh=zazRxHKtoneGKsskBRsohC7oce8ruEz8HWEHQMMKR3Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hwq1CgHEtDkOP+DEoK9qIjM8a8yuGdKuFMm834GspvP7dE/YoaUydpDNQU/KEH8cz
	 NzZAST22rCXOchWb/vSuMBrxMQDTZzxSMUcgyzQRD9LvSvGo2bs4GqM2iYnoh/tTAk
	 rx66yfpmWHBOIG+5QkX5PT6wI9MJ0+0oIHuVQRnkgnL+AHHv+6MENO8vZ1BO6LWbq/
	 X8tIracsg/nPgSmFd8oNssgAFB+P4GDq4gDRJWl2Em3Albi2yr0Qrizx9NORial9Na
	 DkKyWMVxTgAMwWyxG9RqnTzTl03ifqrlQNVm9Rt9KsrlpJedCp/W4ugkh7tXA/6dqv
	 mXmih0BkwfRpw==
Message-ID: <ff713226-333c-72e6-da79-7f0b54b6d15d@marcan.st>
Date: Thu, 22 Sep 2022 23:05:10 +0900
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 2/5] iommu/io-pgtable: Move Apple DART support to its
 own file
Content-Language: es-ES
To: Janne Grunau <j@jannau.net>, iommu@lists.linux.dev
Cc: Konrad Dybcio <konrad.dybcio@somainline.org>, asahi@lists.linux.dev,
 Robin Murphy <robin.murphy@arm.com>, Sven Peter <sven@svenpeter.dev>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220916094152.87137-1-j@jannau.net>
 <20220916094152.87137-3-j@jannau.net>
From: Hector Martin <marcan@marcan.st>
In-Reply-To: <20220916094152.87137-3-j@jannau.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16/09/2022 18.41, Janne Grunau wrote:
> The pte format used by the DARTs found in the Apple M1 (t8103) is not
> fully compatible with io-pgtable-arm. The 24 MSB are used for subpage
> protection (mapping only parts of page) and conflict with the address
> mask. In addition bit 1 is not available for tagging entries but disables
> subpage protection. Subpage protection could be useful to support a CPU
> granule of 4k with the fixed IOMMU page size of 16k.
> 
> The DARTs found on Apple M1 Pro/Max/Ultra use another different pte
> format which is even less compatible. To support an output address size
> of 42 bit the address is shifted down by 4. Subpage protection is
> mandatory and bit 1 signifies uncached mappings used by the display
> controller.
> 
> It would be advantageous to share code for all known Apple DART
> variants to support common features. The page table allocator for DARTs
> is less complex since it uses a two levels of translation table without
> support for huge pages.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> Acked-by: Sven Peter <sven@svenpeter.dev>
> 
> ---

[...]

> +static void *__dart_alloc_pages(size_t size, gfp_t gfp,
> +				    struct io_pgtable_cfg *cfg)
> +{
> +	struct device *dev = cfg->iommu_dev;
> +	int order = get_order(size);
> +	struct page *p;
> +
> +	VM_BUG_ON((gfp & __GFP_HIGHMEM));
> +	p = alloc_pages(gfp | __GFP_ZERO, order);
> +	if (!p)
> +		return NULL;
> +
> +	return page_address(p);
> +}

This throws a warning:

drivers/iommu/io-pgtable-dart.c: In function ‘__dart_alloc_pages’:
drivers/iommu/io-pgtable-dart.c:112:24: warning: unused variable ‘dev’
[-Wunused-variable]
  112 |         struct device *dev = cfg->iommu_dev;
      |                        ^~~

The fix is trivial, of course.

- Hector
