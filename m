Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D543F194C98
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 23:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772236162; cv=none; b=nhYpv/4ZTi46pvt0OBW/J6KOk7gOmZfRvL0ynZItmsh0kSuPDJ++jJJtxKYWyfuJP0iuXIEI5W1kcdNBEd2LxPpUXEyWDo350BrlH/N9I1VRCdlNImZq2KGQXSy/bJjjR+OSNLg8C29SUUogMXlAoX1s8017xLDEQL+OG6IzKc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772236162; c=relaxed/simple;
	bh=j4VTjA3cOiQbL9EyWBWAJKfoFKjq3qaFDUDUlGAjF2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxzHL7iC3df05LhwHkvgQ4miw8Nk6ea486BQa5POu3Pb3844CQFw9JLGQ/BtAhvHn6i00Rc1xBxUjZbOqiezm4hdtEl7cJcvwCJYQMz/+R4RsB91+V3Tvg0mKbLnVNkqIPAkbNasKJIvhjqdNdWj+Ug6TA3svCCCKzGGw5xoUS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iKLfCOIq; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iKLfCOIq"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cb5138df1aso263570985a.3
        for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 15:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1772236160; x=1772840960; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nO36Wwnz4VFlolQfBmDKUPxAbctQ89oZdcB1bnzVy98=;
        b=iKLfCOIqMrTQSj86JNpyYegmPJHAR/Cftqv/CWvXxTiz7LNqgpDkEpITkiOsHSehQC
         HRDD+DJyec1hoKBVrs7CP9riIkQnpjm+8dUDbJr08Swmjp9KMLb9iw2+x4o67tdGeRqI
         Dg7tYucyKOm8tCHv3u0GLAzp132D/l0LYXfViBfTRe7sxDpVBQSieSwVVni2CAFPrKNs
         csFGiitJI4e8tXDs2pU0kf9SGV0KYTVfjc8CzR/PPt3dOrOB+6Z0qHD9QK7hLj16fvjM
         RomRuTfU+M6G1fCrhLK1x14pUjiaa9iy0yNBaEVRmUMjasF2FRDizvyMjjCqpCwfHs7L
         Yzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772236160; x=1772840960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nO36Wwnz4VFlolQfBmDKUPxAbctQ89oZdcB1bnzVy98=;
        b=PyMGoHUylf/6jNfstOqQiyHh84K0QSz2grbi2Bsowp9yKTYLwjUTHMaM2+1sBDmJbl
         oEaYOopqNReNjk8buDBjK5yiUdRM2ebwrYGRbUtWDjqKOzL3Iw1T5pkUW/rnOZrVHtYO
         qH52Ha2aadYvkDV7Vk/sFK2sgthKTyw10/z9QpuFmyCMHE2H13fth7O63kW4c+qqJ3Jr
         hLnvUaiiDLqplNgvWdi9yO5Or4XKa+QNi2HiFuKn4+ZLrqN9dXYBFIm4DgXCGmIt+cl2
         EdMHw04UwZe1YUqoNXQFlvr27030qLOteKTicPf+twHVQoQ+BJOUFZm6amtJGtkqheLX
         GUGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOXCNsy+za6nqcPbPZfQtSO64L8GZ12ZfnJI8QULg9MTpXs+5O9T5X5INC/aU2XKcrbIaDew==@lists.linux.dev
X-Gm-Message-State: AOJu0YxbrxEt3AyQxA3iAyxNQ5TZTC6KvgUCwc4ZlTFZ6x7wuMe3qi9I
	4uqX2eSbUwKd0PRbUHYLHsqX2Rl1inQBx2HK3O2nAK5EzYYcOfRcxzPHY0nNEHTwftc=
X-Gm-Gg: ATEYQzzJrtXEiLBcDTyX48lWU/5n93p9Lta5eRXKlntuB0ZuazNYmk2a7a3PbOJZn6H
	SufOEk4UKTcvfi0GE4wj+CnGmYZ2ZuCeqQXHxSWa2LvTY/S3QxEyFc+X5Vt45S/gh6nMNqX8Uzm
	qZOp53wuNHPBbguignuSbenv7MxbCUvEXJ+31tYc4tq41cttWiSqr8BBWZ/SnJQkf7AsTP3Wpx0
	OxYSXuwrSvBVb24j12lF62kgT6lSybjncJ/lKRadwoTJkomX3kOPHjclDEqEj2QTauY3wKTGNNf
	lpufpJhyqLBhh/a3C3De5l4Q+PozCBLQC0tY+7Kyzhrrj6OVTofP7DSFLPaZgsZM9pE/j2AaRJQ
	XxbDzSZ47y7rdYpg0Aj58wojInwWcTuhJ9gjSQRCsSLiWhG8jxSLiYmt3q3wFDMOKpJoGeINAdP
	FQNEI9L4QLRtrzF9ukKz2hTotm6F6RaZAcja7D12pQ0dTg5z+KPB3ce/61Xryoy0bFkB7VUOA0e
	SYyWlIX
X-Received: by 2002:a05:620a:390a:b0:8c6:a26b:7e92 with SMTP id af79cd13be357-8cbc8d734e5mr635592485a.15.1772236159721;
        Fri, 27 Feb 2026 15:49:19 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf732bc1sm584834585a.46.2026.02.27.15.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 15:49:18 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vw7aA-00000001Wgs-0cyq;
	Fri, 27 Feb 2026 19:49:18 -0400
Date: Fri, 27 Feb 2026 19:49:18 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sam Sun <samsun1006219@gmail.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Subject: Re: [Bug] WARNING in pt_iommu_amdv1_init
Message-ID: <20260227234918.GM44359@ziepe.ca>
References: <CAEkJfYMQrwrhK133NCkzhyOa=1Gj1ME5H1g1d15qWxXUdzNhsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEkJfYMQrwrhK133NCkzhyOa=1Gj1ME5H1g1d15qWxXUdzNhsA@mail.gmail.com>

On Sat, Feb 21, 2026 at 02:53:35PM +0800, Sam Sun wrote:
> Dear developers and maintainers,
> 
> We encountered a bug in the iommufd selftest framework that triggers a
> kernel warning, which can lead to a kernel panic when panic_on_warn is
> enabled. The issue was observed on kernel version 6.19.0 (commit
> 2961f841b025), using syzbot kernel config to compile
> (https://syzkaller.appspot.com/text?tag=KernelConfig&x=e2f061f80b102378).
> 
> We analyzed the root cause of this bug. In
> drivers/iommu/iommufd/selftest.c, the mock_domain_alloc_pgtable()
> function configures the mock AMDv1 domain with the PT_FEAT_DYNAMIC_TOP
> feature flag. However, the generic page table framework strictly
> requires any driver requesting this feature to implement specific
> hardware callbacks in driver_ops (specifically change_top and
> get_top_lock).

Hmm. I think the related issue is that the iommu selftest doesn't use
the MOCK_IOMMUPT_AMDV1 type. It was something I was using but a part
didn't get merged.

So it makes sense only syzkaller would hit this by inputting that
value.

Let me reflect on it if we should fix or delete the MOCK_IOMMUPT_AMDV1

Thanks,
Jason
