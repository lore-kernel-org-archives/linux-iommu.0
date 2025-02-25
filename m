Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE2726A0CB
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 14:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493614; cv=none; b=bSkBXVMBEgzjQW+21GBiszHVsMS/zMiXFe0547CCipwb9/Pe6gOWyoLOi04SytF4BOMt77Pr1ZTECayFKB/9QpKnOr868JtsDWeCBWQxJKPas6gUvgl5uApzkoSNsrbDgQ7NVAEmgYiM/EkjXJLV/1OLuCzTnEUSv9CbuFYnqIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493614; c=relaxed/simple;
	bh=k3Jnd+U9OwWqNw3+IdZGJZuEccOEDl0bEYKrO90tQ7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4ySemcZlVpLN7ti+twSNkrfnA129nAxaYCSM/AiF/7cr+D9hSibXCNoxaRlSDT5hn06rxayXjesOFrgMzrmbJDFfXrDD205/s1oJ+5p+VwHywx6jMC9RAJN0PDo6YtVMv18cQw/GcSJVHEeyKGVbf8fsMsHaMhSuv6B3qVGNKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=C/gNC1X1; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="C/gNC1X1"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c0155af484so829133385a.0
        for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 06:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740493611; x=1741098411; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8SnNXM6A8h+UsNBw1XaKa9u08oehnHBCxdOEZTKjlPY=;
        b=C/gNC1X1nMYD2sZsvNFtIM6Z8JxAiwQsHljK7nrBByPSNXIvEpeLlnq6MGoX1+ORIs
         jBzcqxg8RB8cykAdLXxB3cLcA8FjUnRP7hy0OATDcNWVToHzEj1pgkJvFpy3EdB9GAbm
         Y/IeoGsqBywOuxzu1Mk7WxtylULUwbjbqrAcI5KlHGZE34UUlipeoDOXFgpcgznMkz06
         enZLDOIiTK6GiXi8lHPnGIIzZiquqU/mHdPgyCgMftlhNES0np+MoXZToMrUVHeD2SeW
         k9YJV/RFzpoYsC5jxUxNDsEMpDanSD4AT+QcDs0iv+CT2A9pLwXLu2+ioyOJnSOu+k2I
         5/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740493611; x=1741098411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8SnNXM6A8h+UsNBw1XaKa9u08oehnHBCxdOEZTKjlPY=;
        b=o7ncOGEFm/HcYpeAtwG3FpTvFkisCzaS/FqTgrMptjFGMmg9pWmfI9AmVhjxRLIQyG
         4bGLA27T3AJCGI2IFUZKATf59CC9cORovOEK1GJkY9MXvDtBjxoHlJqFermNira8Fc8B
         5aPOnHUkeDjnzpwtayUfzraLMdPaey+xpYuVSU/T8vJHrH3iFtAuzvBWq+5uK0BvEjkc
         OPhD0Z0/ATihzDY+WTzFH/nI/A2Rfy2A13nOBCrh8TF2D54is0+ArKStUK/TF7LFJVhF
         rHnJED0CH5fzXXXRHJ/F9TGyZbQIhE48vaVrrvdJstKjjYWsTdAH5585Xmibs2hET8xZ
         QqkA==
X-Gm-Message-State: AOJu0YwuSRO1y4lv1m+SPJwBkrqahZE5qmHtjICOkO9hEC57tiEVnPSi
	GKXdrYowx5S9A6uv4zxuNLlIFmQMr2pqSxkOmr7e1OjXsjDb2vMHuYj2N1pawNs=
X-Gm-Gg: ASbGncvJPZgjiMpPzbVFLyFJR+yItbHAq83COb/WdzesfwVyOtdycp4CwQ5OGbugCAL
	FNER/pOvftKAgjAOU7XpiLs03nVGApYXUO1hECUQYFBcf96i4pumqmF59Y49xul51Xs65RZ67Gb
	sEsTxwYWuyRl/ouWZ2x6Qde6FY/qEa8PVEAFBd9a5pQaT6lbfQ52u2AL8kVySiOygiBZ4Rpn6rS
	gjKgJWroehK6Dgr9FQqs/IDppYu1rnZ4i1UnFMWcyILHgSKySMMTBrUDCZLCzaxf1Wziyl+shiw
X-Google-Smtp-Source: AGHT+IGtWLTt8NbogJPXrjAF5ONcuCebzs779WvEN8sW/5pexHJtcqtUoa0VqhlYaPDj6G0JDriuDA==
X-Received: by 2002:a05:620a:17aa:b0:7c0:c282:702c with SMTP id af79cd13be357-7c23bdfc903mr567767185a.5.1740493611492;
        Tue, 25 Feb 2025 06:26:51 -0800 (PST)
Received: from ziepe.ca ([130.41.10.206])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c23c299294sm112878085a.17.2025.02.25.06.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 06:26:51 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tmvta-00000002T37-1uM0;
	Tue, 25 Feb 2025 10:26:50 -0400
Date: Tue, 25 Feb 2025 10:26:50 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH 2/7] iommu/amd: Remove unused variable
Message-ID: <20250225142650.GD545008@ziepe.ca>
References: <20250225105345.52143-1-vasant.hegde@amd.com>
 <20250225105345.52143-3-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225105345.52143-3-vasant.hegde@amd.com>

On Tue, Feb 25, 2025 at 10:53:40AM +0000, Vasant Hegde wrote:
> Remove 'amd_iommu_aperture_order' as its not used since commit d9cfed925448.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 3 ---
>  1 file changed, 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
