Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C192E349CFB
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 17:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783963923; cv=none; b=Fi/DuoXLADkRlqOkIydOJV3nHnK5gnr+b0uf2n5OpDpkKucfkIsPuxdnrLMAyD9H1ZsjmGc89gybmU4lEm06iOnT6IPw5EK+xt7fZTxrIFQFYpMoNHjzUtc/lfQhxleeZm6xV/zwje+rD3W24huTeeN5DNIcTIX83kqi5uMMbrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783963923; c=relaxed/simple;
	bh=bvRlhzr7jKOtOr8WJjvqiBvRjPbU/ig595Q+n8nVP8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6UTAU45HbPzN6qOaldk5kJExQKy3HKHvRDOSLPaBtPg6HXE0uwh/rKr0DW6BSoT7orBmOkz3fkrPbaWzV/MFdo1nZfJ8OenBoKkEVrjlQ14BAJXF5FlfA8lUJF5U3OhVClUinBBF+hwgdjXbAFgC+JNcDyjwHH9YkoNe59E230=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gA35Zrvj; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gA35Zrvj"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c0c68aa31so887201cf.3
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 10:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783963919; x=1784568719; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8xHgMO26e+BdHEAssavg9c9wDK8SauQFv9AFW+ZW8FI=;
        b=gA35ZrvjMaYMiiMrREcAP6EHiAxwlDPviMUhhbwjdrK7peu9L/3lclWyO+Xziz4w3+
         M0dh7h9qUMpTg+Ju5QC6zwbZymc/fAdfmEvGjeEiRP9u74WEeSZiciVTbJz7vS7Bxm8a
         T6pFENZLtPdrxZZLZtiDSfhqBZhugVIqN0hGHBUNdNQcB9+tuseTYGPHkza0sDrYbjYX
         VyyfAQKTlhW3iJQe0/rJbPLmgmbpPnDMY6tay0o0wxePNLzzcTHUQ/MYdt/ThHEYO1uM
         /cil6GPiHLt5kuvr0WeVwTeZx4xwg2vDc8iJhx/R3ydmq0uhRO8DBtkuLJ7Se1zi8e/k
         e4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783963919; x=1784568719;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8xHgMO26e+BdHEAssavg9c9wDK8SauQFv9AFW+ZW8FI=;
        b=mUoy9vNqmGVAoIt6FUBOQq1LtwXIpihp0Z8fiYxxZ7Z9weQ9D/jnRGR63w1J+j0pT5
         OTzkUmI0+N8uIzuFYJtnnekCa/r0LqMSnlGZATA8GfokthtphFHR+xfhASwNyK9KuX/Y
         yauqVxUj7npVsWr4h2xkfJ6RcB7m+8uNIAbekvuu9pZCC0Pd7WPI7rQdwi03hn0xx3xR
         CVgQD6D0j/gtLvzeuOvmHuEc5DLl8Il/tf8gwSgfALeCYiNZ6mowG7TaJpJJlEL65UY0
         j3jm4ixmpC5U/B4syF9gruCX1dnREStBH4s7TLEd4viq8YG3hAsRhKZpfVsikE4BSk/5
         mdsA==
X-Forwarded-Encrypted: i=1; AHgh+RonT21G3OmUttInQbI6P+WsIG7h5855xs4vgh7JPyv2xlLGtmTFT0cacLfk2KWGrlssioXcHg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwCOEWSK09cMEs+oM5JJgMpE5zccCnqlUPFRBD/Mx8pHMr2gJ4D
	g2mBB6Mj/BU629+EgnI8gRKAwojKIfnYazJlEIUJK2YfvArtT5natlVb7y/ko4pF1HE=
X-Gm-Gg: AfdE7ckDHazc1Kh/HQ25r7VkXkKNuP24JmIBz4O1sWYnv20jVASW+ATpWYz8SvNztGA
	LwvqWu6ocF1FCjXBxd16RSALZ4SD3taUtg6ASarClWODx+yCFBr9kSJtmo3vfikajWb5YwTvR21
	MKxBqbMdDpkfDpp/dJXsu/puxmxHF/kie+enUbegodsbxnfGtSH2rrjfiSG1RZa9E9b7C0B2P8b
	VYmU7pHXbZtjJrzuGrhdZ9c9CdHRyBS297efyjEPEi/b+vWyOpkFMOZ8lu+zqbicA1EwEZdLPFh
	hWcmKzl8ZnfaKJsr14YOpEd2e6NVoGfYlfU7F6US9MwuG26rEGGDseNXFkh3yexpryGxqBvj63i
	o+wcohshdRGI9AuAb4FAm/Ex3yT2jwMgiKDwCqhxXQwQR4sOWsOyW8HehyLfG
X-Received: by 2002:a05:622a:994:b0:51a:89db:95a4 with SMTP id d75a77b69052e-51cbf177b90mr97106331cf.6.1783963919034;
        Mon, 13 Jul 2026 10:31:59 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caae24d04sm85930261cf.18.2026.07.13.10.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 10:31:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjKVZ-0000000DnOS-25vJ;
	Mon, 13 Jul 2026 14:31:57 -0300
Date: Mon, 13 Jul 2026 14:31:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Peiyang He <peiyang_he@smail.nju.edu.cn>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	baolu.lu@linux.intel.com, kanie@linux.alibaba.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] iommu: Fix dev_iommu memory leak when device_add fails
 in iommu_mock_device_add
Message-ID: <20260713173157.GH3133966@ziepe.ca>
References: <76AC62D46B998556+20260711055119.1003477-1-peiyang_he@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76AC62D46B998556+20260711055119.1003477-1-peiyang_he@smail.nju.edu.cn>

On Sat, Jul 11, 2026 at 01:51:19PM +0800, Peiyang He wrote:
> iommu_mock_device_add() first calls iommu_fwspec_init(), which on
> success allocates both dev->iommu (via dev_iommu_get()) and
> dev->iommu->fwspec. If the subsequent device_add(dev) call fails,
> the error path only calls iommu_fwspec_free(dev), which frees
> fwspec but leaves dev->iommu still allocated.
> 
> This triggers the following kmemleak report when fuzzing with Syzkaller:
> 
> Fix this by calling dev_iommu_free(dev) instead of iommu_fwspec_free(dev)
> in the device_add() failure path. dev_iommu_free() frees both fwspec
> and the outer dev_iommu struct and clears dev->iommu.
> 
> Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Fixes: 2a918911ed3d ("iommufd: Register iommufd mock devices with fwspec")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> ---
>  drivers/iommu/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied thanks

Jason
