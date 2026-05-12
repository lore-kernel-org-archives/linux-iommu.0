Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504E43B8409
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778598743; cv=none; b=u12idzFBnzGj5XJyPzNvtBZOzLxRNdX8BNrtuQFDSlo30umPS3doHJN9vSeGq6JGkLr/KDJsgOB+RD4fa6yb0G+VtlG/jQcbCSgYt3ts6CsXqsk919a68iNe3tV4AuAwWdXC4HEVgXRPbv8+UN583exE9i5d5aH/NLuujbuNLtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778598743; c=relaxed/simple;
	bh=jMSK8dzwc4SayPadFvopl7Cutk1+Oj8G3x7GLFF5VWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUnQ4070ozJQ/p5L31tmvWvdmZkJoV839y7bHq4TI9RDDZ/vqeJkNCxMNaRtGiIYxSgh7FSotchfFrbHCSVIyQFKwiv/9RTb/Xy5rW+6qCWXPMPWz98YBLKzZIEcXhGqEqV5kKJ6KesQ31OLn7WT8lSe1k6GXy2GwpADr3LJQBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=FgMg8CYE; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FgMg8CYE"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-90d042fa745so127501285a.1
        for <iommu@lists.linux.dev>; Tue, 12 May 2026 08:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778598739; x=1779203539; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f5QZGcD1HP6wx7LkGFPePizbOfmssvqTnXeHIaO3M7c=;
        b=FgMg8CYEGo8OHsLFmDU5k6ozSX8lBcGzm+3PlnmQqCQgCYo/b2bc/2HWqmRsff/xHr
         MqxMQo7oAHbOBRY125tMRw2ZzIeaTJ6HEC26ohJNx8v4PrS79WjGWnDRV0/jxbQWz6BW
         S6fgw7ueG+9mbqeWdQNdLttYo68UEuSRDuQG6kF5byi9UzNc76zloWHSnLl/y+8cchHO
         yOQZVFgp9fv+0cGDoXUev2GzX1UUzwGm2MFoovnKkXlxgpqDafHdDEZZeiphd2EaeMWs
         wxAQxojTKxVr/FUEL0VyCAujGmEeqwhin5Zpv8jmbGahd26KpOnHoRNWIvsZvuSapIN3
         Hr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778598739; x=1779203539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f5QZGcD1HP6wx7LkGFPePizbOfmssvqTnXeHIaO3M7c=;
        b=bQFipqtiWBUVnKP4xIsTW15KveQVqHKz+elkbaK6vSyg46hePP45nJ5OcP2NH5RrMf
         nqotVuRyBYHakPk2PVuZtFzcF9A1i/jHW9ImW1mfRarrIrwJup81ID9QDpsyMgfj3uQM
         N8P3s9kAOnYBTRQraSxl4CDHMXv6u0dkgdNyLF0YXS5jsPAZNRqXgWqwiB88yT9/YZcP
         hGeF+CxByVbz1gZDWEVYz9Hmo3IPJWHYF0PPEqZ/iu1+kfn33e8PwC9RMZHSEiWLrB7R
         pvOZlVeGE7hSNqeWOw4t6enkFV2f0Xvd6wl4WPPyC4MrNvs1/PePIY9uo56ZDjIZpPMv
         YWWA==
X-Forwarded-Encrypted: i=1; AFNElJ8jLMT9aUWElbaOh+YTOoN9Y76od43fG2ARPld5NNXJbMWJf+694iYK/LaSsCZcY8cPGi9w6g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxrvVqjSsvh11XzsQuZA0lYxYc91Ep3eZN2A6D5NO0ESy5/YYit
	wEjVOd4yw3qWA1381eHO5HIBO/CFyJTpdK+xvz71336rfjQkgmRJVZTjYzXdTlLLkcI=
X-Gm-Gg: Acq92OHRcc9EVEQF3GAJ7kTmnEdhqsED3U6tYmephqT7B8KLjDeKO76HTsCNogbaSMN
	QdnJKpJ3WaeLckkuvxDsB+HfHuYUjhZe/8tlStz+T8yQOWabRhpX60J3tuFH9NzY5PQNEn6f/9H
	RhzZdilcSMylpeFQkRWL9KAfL6OxlglI0Z6hQ2skOmGDFEI0CeDq3VAS1/9OpOnBJKqUoiNaFAl
	XMSv4AZaMkYTkKj7oTBxK98/v+Tmt1ECGaGSLeo6WjEEFA6eWwurwyaGhcBz9NDQpTGbt0EuZMV
	vt06lJ9CwgnW6Fb9DtY0ctyn8EuF9n19rgmx/IerrJjiqkjEkefFBxl0/siz4fs+L7+TJvMf4HC
	cgpiWkqx3e4AAHO4uJmmiQ4SvyazXUUEQ2FDk62kkvMatyCjQePmWAiR8bQDe9ppCwlbxipw5wc
	kl8iSI4OfuK98EgifWrPTXtdtmUfxttHbgj4JwrRGg8xElI6aNFfQiBWYjTf008n7S8Rz9yjE0d
	3DRjA==
X-Received: by 2002:a05:620a:29cf:b0:8ef:ba6:1a42 with SMTP id af79cd13be357-90cfd34cbb9mr453281585a.29.1778598738983;
        Tue, 12 May 2026 08:12:18 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b9286171sm1410125485a.12.2026.05.12.08.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 08:12:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wMomP-00000000AVF-3i1q;
	Tue, 12 May 2026 12:12:17 -0300
Date: Tue, 12 May 2026 12:12:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: fangyu.yu@linux.alibaba.com
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	kevin.tian@intel.com, nutty.liu@hotmail.com, guoren@kernel.org,
	kvm@vger.kernel.org, iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iommupt: Fixup build warning by using BIT_ULL() for
 RISCVPT_NC/IO
Message-ID: <20260512151217.GF7702@ziepe.ca>
References: <20260512144330.91113-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512144330.91113-1-fangyu.yu@linux.alibaba.com>

On Tue, May 12, 2026 at 10:43:30PM +0800, fangyu.yu@linux.alibaba.com wrote:
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> 
> Fix build warning on 32-bit configurations by using BIT_ULL() for
> RISCVPT_NC and RISCVPT_IO.
> 
> Fixes: 6c21eb174c6c ("iommupt: Encode IOMMU_MMIO/IOMMU_CACHE via RISC-V Svpbmt bits")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202605121350.wZxB51k0-lkp@intel.com/
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> ---
>  drivers/iommu/generic_pt/fmt/riscv.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
