Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66273644C6
	for <iommu@lists.linux.dev>; Wed,  7 Jan 2026 15:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767799577; cv=none; b=TXE8Tvx/qcZz4ZeZq2rY4AsigO5J7KmJQDmsLliuS2Em3eeoNLpC8Tl9LoNXkzu4UlGGllsAEIqWFlY0nKBghlCyUVI+vdsCbB7bUPkzOBz9RUxVkeXVKpJ7gIznuyzEmMFISvDFVLRYe4TcfEkwS9BmtHjV98KzX5Zj/WhhBWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767799577; c=relaxed/simple;
	bh=amKscgwf9O32GBAy+eAcc817bb0T9V3d3DwTEJ6J6mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghLCUNS264StrUtdX93J79bxTlgs2QCcqWie81mGpsRAJHcRM5vKDljzGM9lYxK9Z6jv2+WwMfsQvINUni5aItI/UoqkcUdVcmaeIPjDmA3aaLYBfH+Z4kLaY/h6G6V78nJ5GXkGAFi6HEQtIA8hBa1nx7Nd47b2Q6mjknmVUjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pvzxj1AG; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pvzxj1AG"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a0d06cfa93so77655ad.1
        for <iommu@lists.linux.dev>; Wed, 07 Jan 2026 07:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767799575; x=1768404375; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lbmDIhCSS30gfIV3g50RSwwLGOW3EzTKyBm3a+7nOf0=;
        b=Pvzxj1AGCi7EEpXBj+tgT9HotR90fnMAvY14gsc9LQZR6D3vBCsBj1QZ3anvROsnqU
         IKANbbSMcdDpA59T8O59Jv6NgZfVuhTYdmrJD0SyS6GAjXXuOx5nVT/swGqtW7HpPPke
         5DpTg2csuczGjKdCbLSdzBT25+zAlJW08Z8yiRtNg3+uGZIDSUduGDLiPYQkCYOK/brq
         4KPUYzWxxcFMEszFJRh0AcrZW1V1R5QL+ndbgF3+IQYuijktSgDV0VR/wvX48WlsmTtX
         78d6x+PNa6KdZI99jdlzfLSe0feGszXN205F01Bkvm7wD9gCvc5vg5YhtQ4RC2Dgoj7d
         lcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767799575; x=1768404375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lbmDIhCSS30gfIV3g50RSwwLGOW3EzTKyBm3a+7nOf0=;
        b=bJ/y+xVTCBzXKFXo4UEI64inQRhbc6qcckCRy/u6X5Wp3PU5NfkYdY43J4XAEPJMlE
         SFAG1VTcaKap5Nngze5pb7M6EArHlEE9EcvyH23iPwucLakKapG8fU9TfDXUDaTjp5Q8
         5yJHldETXQsNUPYQbVAA80SDuxCe0ILZ90ULMCkhJdFuL5oC5dnmfPyROqaI7iElGPei
         WTnsGiI6PTq5UwJrYzhUsZsQB8Z/5lw4Qh0WWDglV41GE9OiVXY2jziXr9QW3nlPuLSH
         hpkRLOLW/AiMCI/Gbx+tvhQhUWu/zzdwhd9D7fSLVLEGMVQGY0RymAcDRmZnvfe1AlFk
         hQTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWH7AuiJQthtVxIsKhy/PKzmvv4Ou2YBVE9V/q3xyzKzgcufFeJiGbonPJEFOuXcU4h2d4yRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjUvgec945feEi6RSpHU5jV7rKGDMK0E8NsoO4KytusOyMx/uM
	O1kEm+R/SZN5YW5uk8BwVagqkpO1lQrixBUZD6bcBZR6wrfWGsV31/iU+iAhfjsdxw==
X-Gm-Gg: AY/fxX5Uw9tMO15G2geSUJu1DuWgyx1R1IgypnYv+daT9oTMXZx36tiZ2m9ReqYQf1M
	aqb4SD02XE7jq3qF+w1R/4h0pJLxmK3cy5NTmzUL6pgwcJ6CqqIcEevp5Dt+NBhmWsOknWmzFCR
	s03PCSXxn88LGnMtUZdB80Bqlan1qNCuGFUSaK5zzkskh0ojjwL3Vu7HVpfpLDdiFW2LF7Z3P5V
	w+2JsjpLYhpLLdl3di08p54JmI7z9ud5dZMZuhDwSu14Vz9cvL+MdJ1Y/KZi5Z64Shtqfg5mo3l
	fGHV17rH1U7ZQNu9uxUlZzJ0BcmuxqEOY/OCRBPburOiUMZYVsnRqOOQSll4jiCRgQ6WXQ1bs1R
	2x+l9ydj7ZYUJt695dRaBtrhr5B93ZON5EgU1lAhP41pItDdDSvJe7tBbvTg8BgGI7qPn0nHas9
	THKjfu36Rg29K9lOxFplGJ3bnClCi/XB9b/9bNDa3nNH5dj5L0
X-Google-Smtp-Source: AGHT+IH+lNUdBDeuVOlZ0XFJN6S6o7z6ABkgQgy9tsTiSGmVL2tsojD37/6y+OgOeGxqXsN0knzcZA==
X-Received: by 2002:a17:902:ef0b:b0:290:cd63:e922 with SMTP id d9443c01a7336-2a3edc1a4efmr3144205ad.15.1767799574721;
        Wed, 07 Jan 2026 07:26:14 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cd2b3asm53637475ad.88.2026.01.07.07.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 07:26:14 -0800 (PST)
Date: Wed, 7 Jan 2026 15:26:07 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, akpm@linux-foundation.org,
	vbabka@suse.cz, surenb@google.com, mhocko@suse.com,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, xiaqinxin@huawei.com,
	baolu.lu@linux.intel.com, rdunlap@infradead.org
Subject: Re: [PATCH v5 1/4] iommu: Add page_ext for IOMMU_DEBUG_PAGEALLOC
Message-ID: <aV57D6OiuKi2359h@google.com>
References: <20260106162200.2223655-1-smostafa@google.com>
 <20260106162200.2223655-2-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106162200.2223655-2-smostafa@google.com>

On Tue, Jan 06, 2026 at 04:21:57PM +0000, Mostafa Saleh wrote:
> Add a new config IOMMU_DEBUG_PAGEALLOC, which registers new data to
> page_ext.
> 
> This config will be used by the IOMMU API to track pages mapped in
> the IOMMU to catch drivers trying to free kernel memory that they
> still map in their domains, causing all types of memory corruption.
> 
> This behaviour is disabled by default and can be enabled using
> kernel cmdline iommu.debug_pagealloc.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  9 ++++++
>  drivers/iommu/Kconfig                         | 19 +++++++++++
>  drivers/iommu/Makefile                        |  1 +
>  drivers/iommu/iommu-debug-pagealloc.c         | 32 +++++++++++++++++++
>  include/linux/iommu-debug-pagealloc.h         | 17 ++++++++++
>  mm/page_ext.c                                 |  4 +++
>  6 files changed, 82 insertions(+)
>  create mode 100644 drivers/iommu/iommu-debug-pagealloc.c
>  create mode 100644 include/linux/iommu-debug-pagealloc.h
> 

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Thanks!
