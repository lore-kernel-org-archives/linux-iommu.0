Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4675471261
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058851; cv=none; b=SSngB9gYbGx/pH7/WTkuk/ZBoveHSmbws5gCh0ieW19oup8KkoQHFn8zWdfBfLRWTBqmEGZuw7wNjeg1vjfsNSTWRBdzajL6UQM+3Nfd4JxJuhVpWYYNwah4f9QLtrSq/+BlnbHoRQ/RiKy+yWUT3+1hTlIK2a3q3ItJUFxDy+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058851; c=relaxed/simple;
	bh=tn546xQ4ZUmMi62SQvQ5htqUj+7Y641UGmZUBIRyXX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPt/1313g30CJQYyY6B8YHQ3RUxOUVSL0pKgZCuXhIKPeIfaMrJT527cIrADjG7ha5c/jJbo+l2AK0TinuGvCyHTy6Aav/yiVPTaoa/8M6O7dX6SXJivd8yat+5i7HvHzjSV+YOTP6G0USsQ8R9FkvNr0DKtqlDkQA2WkEovgVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IBzOuDmy; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IBzOuDmy"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-517dc520840so34719151cf.3
        for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 06:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1787058848; x=1787663648; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aSsbR6ewr2Y3TGcc2GiG7vLNi19dvlUEWfugzFhClyI=;
        b=IBzOuDmy+stw7/FrHQkfP4OXD3VmSUKFQ40ntqFlGrz1gWuMWTd7mTid8Pgxqr9LvT
         fIqBSu8mxRuK09/GPNtjmvSbonpf7Gyy/oByFtD7WehZleuFUXpSh9umjclsyBsZTOMK
         OfrKewCmTexIi4tzmuHhyJgmFHEaKiOcBkIfn+MEoIryoACKABYc0XsOdRlJ38NdoeH0
         jloD6SRdMMsHS+7qzHdKSQD1Jy1EjAjQteUvl0F83WbThN/un2nBudihWtwEBy1fquwr
         68fcQQ2R5pRZdUNuraQOzZ/3zKzeCMiShHhd01wFp5FvacGuUBxozDDuz7u9+cKF+Cr6
         qx3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787058848; x=1787663648;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aSsbR6ewr2Y3TGcc2GiG7vLNi19dvlUEWfugzFhClyI=;
        b=SehW1DiDU/k+B3AKG6iZJpEM1/ZYVxMHzoMkAXnLrsIB4sLfegfeHU/78jCgcklim4
         3qkC+3XKZzXoU9XWDq3UX3AjnjY1zKo+gunkCanysXftO23CkckhuDD45DLeYK8922Hj
         Lw/ehyms18mCxw6mBlWvhAx7l/ydOgH31nR+z3t07+Qexn4Ttm07JPLmhJmtrCF8y+CQ
         Go8LclPKegXeJxIBQrB5ZYhoJFO9vZ7DSoBJt0m05wPgQZFlTQlgE1O4g8ghaW8+X3vd
         uDFoFRLraYp777HsOiYsvNSvDBi6TMGR47PAoNqln6t2rXBPp8ESsHjfhlZ/53ReGtRf
         qhkg==
X-Gm-Message-State: AOJu0YwnAYboUNT0hGpmC9jaOGp2vnzTC0iWEpUksERjgfVxCLhfXNKY
	ffPuYhiqjve+0FpybZ1UF2hE+59apsr6eTNDDimfyiu4ikhPmLFUHR7KvfBw93xGIQI=
X-Gm-Gg: AR+sD12YIVxBWfCM1eaMNEnbUYPr/UDhkLJAnfO0SDKI96YeZ8gsst4G+R7C04A0bPY
	0XY2appgHS3rgwfYd744mYuMFvRaWhR7p3baqd8/T10xlD7q6kqEFWdpvIebn1nsRrzHPYRMSQL
	7AeUE6OTXxV5lH2jdgYd3ywSg9Lxc/Ym4dM/bwWl9a9lfkyR/dH4GMQGJ++wd9hClW5NiTJPb6N
	tmxggtywNlwLxBC9Z8b8UUbt8xeHiQuyVXKH9JKFRc4i60SG6vRVOqOXo1Hh7hWvHCxnoit7abU
	HvT8UdSUGaGQfDyg+bFgQAYDNUEMsfxbEJHcGBrb0XKx5hfvTQ/GcmVj/QPyUPi/9HcRzjvZZ79
	2qu0UJTFIGSMQv6z/J0nXoRO56kh2gaAb5Ibgpwar4jdEIx2sIvqgmqmdVR4dVad2A+bUSHFw7Q
	cHNxXYc0yDQsuojblkryNrtEtYxZ3IrSxOo73Q/z08PlLeuifwbrVyh0En0N5XBW6aDPv3AaZwc
	C7xBb+kw1kblIa5jw0BQ/mgYgT9FZA5lrRkIJouMZgYXQ==
X-Received: by 2002:a05:622a:64e:b0:50e:635b:5579 with SMTP id d75a77b69052e-52d854313eamr337878081cf.19.1787058847779;
        Tue, 18 Aug 2026 06:14:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c4580faedsm32357436d6.1.2026.08.18.06.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 06:14:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wwJdm-0000000021o-24fh;
	Tue, 18 Aug 2026 10:14:06 -0300
Date: Tue, 18 Aug 2026 10:14:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, fangyu.yu@linux.alibaba.com,
	tomasz.jeznach@linux.dev, oro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com
Subject: Re: [PATCH] iommu/generic_pt: Fix the RISC-V supported feature mask
Message-ID: <20260818131406.GB5482@ziepe.ca>
References: <20260818092444.42755-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818092444.42755-1-andrew.jones@oss.qualcomm.com>

On Tue, Aug 18, 2026 at 11:24:44AM +0200, Andrew Jones wrote:
> The RISC-V format advertises Svpbmt to its users, but omits the feature
> from PT_SUPPORTED_FEATURES. Add it there so configurations which enable
> Svpbmt pass generic page-table feature validation.
> 
> Fixes: f196a8668797 ("iommu/riscv: Advertise Svpbmt support to generic page table")
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> ---
>  drivers/iommu/generic_pt/fmt/iommu_riscv64.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
