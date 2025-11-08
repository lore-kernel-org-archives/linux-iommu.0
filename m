Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF0B749C;
	Sat,  8 Nov 2025 00:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762561194; cv=none; b=tz8kuBw2l5hqZFmAKxtsbgjPrPzHz+bVFoWXlfRdia3VnLqdCVyocoWt2RtXG2zxSMKF7iXZXlG7g6zdOH+70Oz9Ff8vXDvc/5pd433HUI8EJXn/Urk+vQQkHDgFtbXO2UauZGpoTYjpTrRMQumTlAe9rDOI2ZUgv/mZVas62J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762561194; c=relaxed/simple;
	bh=XgJLKtNjkVJsQfZ71ITg8fCOF/3ehIqbxHwquqIIEIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DiOtGQce8ubHEouRA1iUVr+8S6+xG+M/WOb5xzzNVpgQfSqFAz7D/N6aTSQpFd89qysKvha6fTAqEFg7JgPNOJgrYDDfIrrw6LmnU/cpXKPKJ/GHd6hT0NBZO4M488TsN5FkIBl6blqMS50Ep/E5AwXNR8quWy4nIWrSvhGVTZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jIvmnpH5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jIvmnpH5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=zeMR2YavB+3/5YeBgJN8gTKdNLaP+0wt7Aw1q8B1wGM=; b=jIvmnpH5VbUSLxLHYcQkr8xMUc
	wE4knEnG91KgrKAp/Mw2LHSWcCcJs19s0H7/g78GandkZ4SxEJ6+CUZG/SfI2mDlvB/G7vuwKhey4
	ItulBD/W+WNf205AZ+2Zjl38RtuoE1939HTC2FkURTTloDzeyGFc+TxHIpkIHZTZHmxDJ456cQHXn
	U2N4GcXA1j5g/IGhmqNgxWnE1yQ5KxbdZ0eLsfpOAg4+iXIs2803y/yysuqx9zXNHoJbEeBDlUR76
	mjU+Z9WpWxHfre8EsEKDL6XXAaOZMo7mv/6/xR+VHORu73kRqmqQuxWFj1FZfTvbeJgpCrSyMulEa
	hZ4t3x2A==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHWgI-00000001i1B-27wB;
	Sat, 08 Nov 2025 00:19:50 +0000
Message-ID: <a304ad66-6ab5-44ba-8454-23cd01f7854f@infradead.org>
Date: Fri, 7 Nov 2025 16:19:49 -0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommupt: Actually correct
 pt_test_sw_bit_{acquire_release}() parameter description
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux.dev>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>
References: <20251107233316.7256-2-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251107233316.7256-2-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/7/25 3:33 PM, Bagas Sanjaya wrote:
> In review comment for v1 of genpt documentation fixes [1], Randy
> suggested that pt_test_sw_bit_acquire() parameters description
> should be written using "to read". Commit e4dfaf25df1210 ("iommupt:
> Describe @bitnr parameter"), however, misunderstood the review by
> instead using "to read" on @bitnr parameter on both
> pt_test_sw_bit_acquire() and pt_test_sw_bit_release().
> 
> Actually correct the description.
> 
> [1]: https://lore.kernel.org/linux-doc/9dba0eb7-6f32-41b7-b70b-12379364585f@infradead.org/
> 
> Fixes: e4dfaf25df1210 ("iommupt: Describe @bitnr parameter")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Looks good. Thanks.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  drivers/iommu/generic_pt/pt_common.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/generic_pt/pt_common.h b/drivers/iommu/generic_pt/pt_common.h
> index 3b4e371089140a..e1123d35c90765 100644
> --- a/drivers/iommu/generic_pt/pt_common.h
> +++ b/drivers/iommu/generic_pt/pt_common.h
> @@ -353,7 +353,7 @@ static inline unsigned int pt_max_sw_bit(struct pt_common *common);
>  
>  /**
>   * pt_test_sw_bit_acquire() - Read a software bit in an item
> - * @pts: Entry to set
> + * @pts: Entry to read
>   * @bitnr: Bit to read
>   *
>   * Software bits are ignored by HW and can be used for any purpose by the
> @@ -365,7 +365,7 @@ static inline bool pt_test_sw_bit_acquire(struct pt_state *pts,
>  /**
>   * pt_set_sw_bit_release() - Set a software bit in an item
>   * @pts: Entry to set
> - * @bitnr: Bit to read
> + * @bitnr: Bit to set
>   *
>   * Software bits are ignored by HW and can be used for any purpose by the
>   * software. This does a set bit and release operation.
> 
> base-commit: 91920a9d87f5192c56ba5bf3e133aeb3576b705d

-- 
~Randy
