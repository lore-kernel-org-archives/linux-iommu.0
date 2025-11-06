Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF0A2F39D7;
	Thu,  6 Nov 2025 23:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762472896; cv=none; b=b4i1bwp05u8VzNYcQe2kYCFcVStu7uQg2wCcRnm6RR/6nuulQ7JO/vEfKLTAK3xt15vHPRWgYhQaeR6HzsBgLhecaRs4os6m50WlCWo1RqAKq/w+HoDXvLjUqcwlQNi92oSfWUZM84ExhH/rkJ2BBSS+GGtNcHkP1LEjjKIrzOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762472896; c=relaxed/simple;
	bh=TnpdPvH+RZ2LrlXRMB0uxyj+0oHXbiY9DRoi/gpHLZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YOC/s0u3LCBCeSzZ7Wqe2TwYUPrjCX/E79mB87FJPksys4gtyTuPeBVeuooSQulICfIpIYlxKP+KQXC+rdNjugDUpqpFcjowcFeW296AkVn5BARSQU8eOycxupvV4NBKWCX65B0dnvrrzg84OJNFBZQ5dZOMTS5ZZXWLwQwJB8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=USVRjQRb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="USVRjQRb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=OYz7MP8O2k8oBKZENe/xkYWnFpyCZoav16ctpYVEDG0=; b=USVRjQRbYJQTy+3GtLjYFb/dkM
	2D75bMF8DXeY9aF5J8IogdFizhCV2ipRrbRlCaCcgS6cUDdV+xkcqAig03+hWJVT7rrqWlTAoaGDE
	jUmhcGGM6LkXnt3XTSNLil9OMWiZhuGNk/KqMVpIpTTwYV6Sa28EhgFOeTfu65OQCUAeo2+f6FE8V
	RIFVZd6ZX7GgB/dCVaAW3z6cjh5wLQxWzuAw1+TenO3xRYHnkkpOzTtk3yUzBOCJ3BIc/RcUC4T7n
	E8bFjO8OTSxTaJPu3fM1hjbw5dRKg2+eS26jB3kFG9HkkBJsGymyBpJ3U5qNVvxn18qND/aGq/2ST
	MQkUkqIw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vH9i7-0000000GPM2-1F4B;
	Thu, 06 Nov 2025 23:48:11 +0000
Message-ID: <9dba0eb7-6f32-41b7-b70b-12379364585f@infradead.org>
Date: Thu, 6 Nov 2025 15:48:10 -0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommupt: Describe @bitnr parameter
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux.dev>
Cc: Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Samiullah Khawaja <skhawaja@google.com>,
 Kevin Tian <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>
References: <20251106073845.36445-1-bagasdotme@gmail.com>
 <20251106073845.36445-3-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251106073845.36445-3-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/5/25 11:38 PM, Bagas Sanjaya wrote:
> Sphinx reports kernel-doc warnings when making htmldocs:
> 
> WARNING: ./drivers/iommu/generic_pt/pt_common.h:361 function parameter 'bitnr' not described in 'pt_test_sw_bit_acquire'
> WARNING: ./drivers/iommu/generic_pt/pt_common.h:371 function parameter 'bitnr' not described in 'pt_set_sw_bit_release'
> 
> Describe @bitnr to squash them.
> 
> Fixes: bcc64b57b48e ("iommupt: Add basic support for SW bits in the page table")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  drivers/iommu/generic_pt/pt_common.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/generic_pt/pt_common.h b/drivers/iommu/generic_pt/pt_common.h
> index b5628f47e0db40..54c16355be2842 100644
> --- a/drivers/iommu/generic_pt/pt_common.h
> +++ b/drivers/iommu/generic_pt/pt_common.h
> @@ -354,6 +354,7 @@ static inline unsigned int pt_max_sw_bit(struct pt_common *common);
>  /**
>   * pt_test_sw_bit_acquire() - Read a software bit in an item
>   * @pts: Entry to set
> + * @bitnr: Bit to set

Shouldn't both of these (above) to "to read" instead of "to set"?

>   *
>   * Software bits are ignored by HW and can be used for any purpose by the
>   * software. This does a test bit and acquire operation.
> @@ -364,6 +365,7 @@ static inline bool pt_test_sw_bit_acquire(struct pt_state *pts,
>  /**
>   * pt_set_sw_bit_release() - Set a software bit in an item
>   * @pts: Entry to set
> + * @bitnr: Bit to set
>   *
>   * Software bits are ignored by HW and can be used for any purpose by the
>   * software. This does a set bit and release operation.

-- 
~Randy

