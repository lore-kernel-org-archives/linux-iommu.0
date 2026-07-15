Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797D53C4554
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 19:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784145546; cv=none; b=iL5xKae4C/fGWzcEZnyo7P9ZeOdFU09b142946+/UUrs52z8bGOrYZU60oxydNAanrX8LFj9Co/Us6yNikZfXOJxCLPWiPH9l64UNeZMQmU2FoKMT6HFCmkE/Mi/5zWLgNTDsntdXZKtk6Z1Mz6lD38PEna+/upg8WieG4ZhBMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784145546; c=relaxed/simple;
	bh=Kek4Q4VU/DWeBG/x6ryLXvZVsLcqKSmwGeQ8VK2Of6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5nZdeRHf9PuD/k4nUs9zIaPhhYZZcX4RFAZoWqryKLAAyUldQwsHrxVrNrs86w8kejmlw8aNhWzBimmv8mMSvWla6xbsaPx7GEacVrsdJJk1msuT/P8ZwJK+zzOfFmXG7Uz8EIi9beZuxvY8ezaRn51s+dcclAiZKrOWzNsSPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FkMJ9PmZ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FkMJ9PmZ"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ccdf36f63dso31265ad.0
        for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 12:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784145543; x=1784750343; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IV+eVU/BHEvjC83dTcoXEiFif2QrI2TpFVMZfUeCzig=;
        b=FkMJ9PmZJ0bNdpFsnLJDjVf67s0PFGlO58abjUNOMtX9WlIxSlbwgw1SQTh5j7daSe
         62YnWNDFMHCD/r61RBDImEZ/GW4JmmxNGSCDYE6A3HGIhnmxmoIcd2nB4l5+CZBDlW6F
         FtIaJRVBlcY6tckiQgHQ0IdFUOdEWiV8X6HwFpjBwrQ//2yGAzv1nQiMz585XdTc3Xby
         6+a4YtDjCEQdL5PUqyD4pxJq2ByFSnLLj0NjnoCtSJmCO0dcEEgL861LIpTpLZ5WRtUm
         0FS8/3V9ETIelYr0BaOp2/61e5TijrsIh32pV31w7nhRNQOA19Ipn1aBKNArgW+akxM3
         vwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784145543; x=1784750343;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IV+eVU/BHEvjC83dTcoXEiFif2QrI2TpFVMZfUeCzig=;
        b=sCCukOWIYj4Hno1k1V5zjCYatvar26jLgBhtTK0wtbjOn376VXIIjtzPSjehJCNUbn
         LhS96KHiAk5KcuNeA6jDQiPt2wthUnCS9IfIeCyFNhmRezHO7DCeJ6ZMBt8UNJIJ2fnb
         SE9oglh3c+wpxOWbzkUaigWfQ346Z+XLY7v/sQJn5FrLDhkiMigb/QqjeG2oBaFZCzg7
         TuV9oURjCXXq5rLmGXmkYDJssX6jfdn3RMpCqO1s+YeNkn72zYOv2HpDamJ41F84OPRm
         WAm9ZrPL+6FrrXq4S4+oeoWntpZ38xj9pMIrFyEjoFHGFOzFWnmutN0Zy8LliX6eIB/+
         Cb/g==
X-Forwarded-Encrypted: i=1; AHgh+RoDArLe1+zvH/TC/cbYl4KC9Cb41YLtQYqi2iEqdgZ5r+cffUoC2lg8eyN/Lk3TWDSABpRwbQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzisHdwMnSlCtPasSOeR/+HvL0k2ygTY7iIrl9g7g5IsnTTMdWq
	DhPgW83hvcsgiYpcEYk85xhSMFFZQBZXZW2S+bdQmf5Z7X2DuucevY76DS9RAXInSg==
X-Gm-Gg: AfdE7cnUbWiSdUtJMhGPdnApYZTXi3B2YE5T9PbtIDFvB80d9uEMxN7uRR4nbQvVlmJ
	tJI9R2WXuaSop5iU8dF7m58Ah55cayUYrW9fL8HbY0fnAbM2w73ipd8gjZoikReplAUJED4+OJh
	ohPD4KmmT8IS89gZq/qPfUY4InXq8Usv1JxhwPuZiWMXtcHUf614kWlOO7o25X+n2RqS/cdh3dB
	I6TGXBrkGaR0ODoLWpAFlYPmzKIREyT6cl2VekMBKrAUp8dE0+7V/0bdaz3n7pSVKqkY2YrAVfY
	tgiyMK7C6Fc/IK9IX76qes5MVuE7FtBFmUOH4GTv55eIB85C+XpIx+HR7xM0PuMt3lfXBGXI5sa
	UsuRRTRapro7y/mp4YMZDcmzo/CnPOshl8qZxwc4nVoBErAZVIRU3ECAgL6MJCh+CXYDT2R96bv
	ve+vxBDX1XPkwqT/EFSgI42zmc4RzDMSQRfeDdxUMl4sIY9auF9Tdg8g1nrvvnglQmJPwxfudVF
	Dg8kMrgmcU=
X-Received: by 2002:a17:903:2b0d:b0:2c6:cbcb:bc72 with SMTP id d9443c01a7336-2cf1abf6570mr468465ad.23.1784145542863;
        Wed, 15 Jul 2026 12:59:02 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e2a06182csm807385a91.0.2026.07.15.12.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 12:59:02 -0700 (PDT)
Date: Wed, 15 Jul 2026 19:58:57 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev, 
	kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [RFC PATCH v2 03/10] dma: contiguous: Add API to check if an
 allocation is from CMA
Message-ID: <alfmVTYNgoP1GHQY@google.com>
References: <20260708234854.4044652-1-skhawaja@google.com>
 <20260708234854.4044652-4-skhawaja@google.com>
 <20260715062116.GA21348@unreal>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260715062116.GA21348@unreal>

On Wed, Jul 15, 2026 at 09:21:16AM +0300, Leon Romanovsky wrote:
>On Wed, Jul 08, 2026 at 11:48:47PM +0000, Samiullah Khawaja wrote:
>> Add an API that uses cma_for_each() to check whether a DMA allocation is
>> from a CMA region.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  include/linux/dma-map-ops.h |  6 ++++++
>>  kernel/dma/contiguous.c     | 24 ++++++++++++++++++++++++
>>  2 files changed, 30 insertions(+)
>
><...>
>
>>  #ifdef CONFIG_DMA_DECLARE_COHERENT
>> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
>> index 03f52bd17120..0b1702bf39ca 100644
>> --- a/kernel/dma/contiguous.c
>> +++ b/kernel/dma/contiguous.c
>> @@ -130,6 +130,30 @@ struct cma *dev_get_cma_area(struct device *dev)
>>  }
>>  EXPORT_SYMBOL_GPL(dev_get_cma_area);
>>
>> +struct dma_cma_check_data {
>> +	phys_addr_t start;
>> +	phys_addr_t end;
>> +};
>
>If this series is retried, use "struct phys_vec" here instead of
>declaring a new structure:
>https://elixir.bootlin.com/linux/v7.1.3/source/include/linux/types.h#L173

Sure this sounds great.
>
>Thanks.

Sami
