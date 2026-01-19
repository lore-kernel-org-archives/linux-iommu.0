Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2E52773F4
	for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 15:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768837745; cv=none; b=TYBrRX0pOVgIixrXYbxNOmPZfSA+hTYMFrJClN0w76ySzkKFzN1DS68PacDfSxByutAk/sUCnRMxKNpra09gcHZJET5ms3kk1FyjuIsr0ph025XqrmhnRaDHZUH/R6osAa8d00sF5NB6nnPAL9anb1fdS8t4AoLycAJ0JhocD0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768837745; c=relaxed/simple;
	bh=BL3meZqsZ6zyWrqmX2gWLKX25saoedB0Z4kpaDwfnzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWSVGtJW4W2rAWff0uK/9vVYq8KLB5Al28hpJDeXUE46f04moK/psZjxKtO1Mt44wle+JirtQRtINNzY6GtseSACjLRNz4NrpSbZV907izIznlHu8cWXYi4nVnY1LTb3FwB7xkEWMl+zuIKwvRGJkdjFG39rGzGfVPAHneBGTag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=HW0W0lCk; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="HW0W0lCk"
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id EA7845FE9B;
	Mon, 19 Jan 2026 16:49:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1768837741;
	bh=BL3meZqsZ6zyWrqmX2gWLKX25saoedB0Z4kpaDwfnzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HW0W0lCkK4CaHA4Z0Y6y0pe30gQQ2PlASyvv3YVMM07Fb1uDmQybHHE/TxTEwaxFd
	 KejVucrd2Hg38/eDkNJxoiBSxWEgpH78R3wmtduIrTwWV8n5q9Rh1afo2ZJhCmXf3j
	 W8Ixey6KgB6GqCdXjZY4eWayYOTd5PY8DkFdNsyK9Hc37dJz1FFEhimJm0klWU6OeT
	 sr4iT5Vnhl6kMPgXxY1aDhCAncqtEb0rbRNheZ06p5ZXKyFEaqCVP9CEDQuAVdRSlJ
	 asaZCz/xHBE/ktb7q2dHNRLThdHrW34nX/CPQzzXQgLgCQkjzsqjP+nI6QEuX5S9Dv
	 67jjjGxBIe0DA==
Date: Mon, 19 Jan 2026 16:48:59 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net, will@kernel.org, 
	robin.murphy@arm.com, akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, 
	mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, 
	david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	rppt@kernel.org, xiaqinxin@huawei.com, baolu.lu@linux.intel.com, 
	rdunlap@infradead.org
Subject: Re: [PATCH 1/2] mm/page_ext: Add page_ext_get_phys()
Message-ID: <qu5oksvcaytolppeeale6rwf4bzvckvfdg3iw77kowrg4fn24a@p4hmieukkttu>
References: <20260119142246.3821052-1-smostafa@google.com>
 <20260119142246.3821052-2-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119142246.3821052-2-smostafa@google.com>

On Mon, Jan 19, 2026 at 02:22:45PM +0000, Mostafa Saleh wrote:
> +static inline struct page_ext *page_ext_get_phys(phys_addr_t phys)

The name is misleading as it indicates that the function returns a physical
address. Maybe name it page_ext_from_phys()?

> +{
> +	return NULL;
> +}
> +
>  static inline void page_ext_put(struct page_ext *page_ext)
>  {
>  }
> diff --git a/mm/page_ext.c b/mm/page_ext.c
> index 297e4cd8ce90..5fe65a0ac4f3 100644
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -538,6 +538,29 @@ struct page_ext *page_ext_get(const struct page *page)
>  	return page_ext;
>  }
>  
> +/**
> + * page_ext_get_phys() - Get the page_ext structure for a physical address.
> + * @phys: The physical address to query.
> + *
> + * This function safely gets the `struct page_ext` associated with a given
> + * physical address. It performs validation to ensure the address corresponds
> + * to a valid, online struct page before attempting to access it.
> + * It should return NULL for (MMIO, ZONE_DEVICE, holes, offline memory)

It should?

-Joerg
