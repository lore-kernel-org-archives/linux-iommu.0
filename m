Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B2C33B6EF
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 12:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772539558; cv=none; b=tyuE28CyQyeUwcEoFszELHmpcDYMn+7YN6FvO/vjvWCTuFtVIHnGtaUSLHWlxkiabdz6UiSiM8rd82BbeowAIc/bJ5ILWVvWy2AFGMSKMO8LAoUAvrAilFJAIqS5LGyNJu9rq87asZFyfgMgqRg8SQUS4dfMtvc1R2xmrf+DTAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772539558; c=relaxed/simple;
	bh=1ePO/IgVt2FReZvhWWYrlsfewEOlrQou7s6BZReWdU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tufvXd/oKupb06fEnrIzw9pEhMilzCUQz1sMB6lNJvkwWiN+zIWk4Ry3LRWmDeYyrGUXWHOJd7TLdAKyflawYyxOR+tWPeY4GrzTL9Og4HWHhyFW9I4GZ4d4ubyXL4k7Inf2Ig83Amhdu3gpbloosT68UT13DtLkrtGZmKF6ljU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=d5xInaiV; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="d5xInaiV"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cb420f7500so533745185a.2
        for <iommu@lists.linux.dev>; Tue, 03 Mar 2026 04:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1772539556; x=1773144356; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jZ1nSawE4P4OeC8ZH5K/sS7Ya9tFRdTVx7qqpOzi/qg=;
        b=d5xInaiVvR2zAqGvIx5RnTMP2EqbsU0E8gBIyV3D5ilnmPs4GUuQqdrmsb85trdbU4
         zlXOnKzZmBL0eWAEAt9u/A4T2evUUpnpi99N27BP9hVbo9gX2cI2fTJhOEy5e9wrNVDA
         GKseQaSSUKaAaqBDs2wR9NS0hUyhMdaJkZpAYjffhx87UnX3Dw5wFrTkIIpRwaVZO+EP
         XrP/gujxSuKsW0iRJLoDpZsW9Mno+yqNc1A6F5e7LgJJab90bmSaYJux2zGQO1AMlAF4
         evKfR3kFcLYKwcheEY0MUJsTsfPlHYGi7HWhTWjx1oH3mF0PXTKslpMMK+v7t+xFuFvQ
         acrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772539556; x=1773144356;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jZ1nSawE4P4OeC8ZH5K/sS7Ya9tFRdTVx7qqpOzi/qg=;
        b=TUav+zauadUPQXKnVW4ttsT3pgvDgqs7XYqA+d+NL6ISyERY7lHxuIQpKEgrTkVGbS
         /lY4edk9hJjycfgmDYOwmSmHknhi6bZfQQwhB47XvohbX0cFheoJIkyNAVNfa5rZYlFL
         2wOGyQ1NXsESSN3gIadG76g/HA5JvEASFJVoKGIh51pqEIiSLhVWVHNeogzD1Qchcis8
         eEBZBCrTGh6Ny1bDdmGeWM6ZW5KhN7gCf9H+qs2Kp2u5TlaGNeSGMfMlsONLWuo4spKt
         rF1nFeGgAJEyQ1bZhK2i2wrPGO5kz1EEvBSlfK8sdGJcVM4fYUVi4ghswcpSgflikSX6
         6foQ==
X-Gm-Message-State: AOJu0YwY3lInA97N7bvx+wLgpdm5uofKOTHyOHNF3FnPP9CcBimmqmfa
	cvvFVpzmOr9O+ecvgx8nqtd5jsTzNixxOVkCAnxgm+F2BIT6b9HdhhCP1elm3ch1wOE=
X-Gm-Gg: ATEYQzyW3E6NP32jdnFhLY04cwU74tE3anOM7ihj5v5NC6EMiRuLsoFsehF0XQ5ibAo
	LlISgRFwRrr8Q/CWSnZsDr+JInjCeJxaufyDLpfimW8DbePopgzKU+Bvxllkjg4TQH6AQKOxXnC
	l/IkFe1AfqR4i7vRhMz5IZ6MwxEywfb17Fykc7KVKmlQB8JZH4am5MCBUYJfvaZSGr4pXr3RIVM
	HEv7nzp+AGZcxcmKFTbxX8BEz0O74G9ikDnXNw6BjLl7a8zX/ILzTYGP84M+vI+f/QNFrTynPlS
	g2OMjR2/KsAD+I4QRmoE7t5bPgBgSMl4ogzuEEimmkffhemF/xD2qNWyY7+JECCdZowC0BU9X8n
	dMVO0l0m6q06xfd1ISc1wH/nwUuDl/l/8327fQRkdOcAYHuODDROxuJL58bpgv2SzKSZbMTb0nc
	igv16IQXTBm96VED7aZ36GjweCuLuE6QrxftwYUqZhxVBR4en60drOxzp7ylxxRxmfR7vpefHkv
	7gXTM2N
X-Received: by 2002:a05:620a:2847:b0:8c6:e0c5:7b9f with SMTP id af79cd13be357-8cbc8df1e96mr2047829385a.44.1772539555915;
        Tue, 03 Mar 2026 04:05:55 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf7175c6sm1400668685a.37.2026.03.03.04.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 04:05:55 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vxOVe-00000004CT6-1weX;
	Tue, 03 Mar 2026 08:05:54 -0400
Date: Tue, 3 Mar 2026 08:05:54 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: iommu@lists.linux.dev, vasant.hegde@amd.com,
	suravee.suthikulpanit@amd.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Adhere to IVINFO[VASIZE] for address limits
Message-ID: <20260303120554.GC964116@ziepe.ca>
References: <cf1a1e3d96c3571ac5caa528caa84751d40be1bc.1772208939.git.Ankit.Soni@amd.com>
 <20260302235715.GY44359@ziepe.ca>
 <mqobyculj4g3mv2ipf2rbacbw62ew2utq2kini5hql5r22khhc@btukh6fex6zb>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mqobyculj4g3mv2ipf2rbacbw62ew2utq2kini5hql5r22khhc@btukh6fex6zb>

On Tue, Mar 03, 2026 at 11:47:21AM +0000, Ankit Soni wrote:

> > > +	/*
> > > +	 * IVINFO[VASIZE] encodes the log2 of the maximum virtual address
> > > +	 * processed by the IOMMU.
> > > +	 */
> > > +	switch (vasize) {
> > > +	case 32:
> > > +	case 40:
> > > +	case 48:
> > > +	case 64:
> > > +		return vasize;
> > > +	default:
> > > +		pr_warn_once("IVRS: IVINFO[VASIZE]=0x%x is invalid, defaulting to 64‑bit VA\n",
> > > +			     vasize);
> > > +		return 64;
> > 
> > Why check and limit it like this? 
> > 
> 
> I’ll replace this with a macro and send that in v3. If you have other suggestions,
> I’m happy to incorporate.
> 
> > > -	cfg.common.hw_max_vasz_lg2 =
> > > -		min(64, (amd_iommu_hpt_level - 1) * 9 + 21);
> > > +	cfg.common.hw_max_vasz_lg2 = amd_iommu_hpt_vasize;
> > 
> > This has no restriction, you can send it whatever size you want.
> > 
> 
> The intent is for the kernel to respect what the VM advertises in IVINFO.
> If we ignore IVINFO[VASIZE] and use a larger limit (i.e. from EFR only),
> driver can exceed vasize what the VM allows and break the guest.

I mean if FIELD_GET(IOMMU_IVINFO_VASIZE, amd_iommu_ivinfo) is 35 why
not just pass it to hw_max_vasz_lg2 and be done with it? What is the
point of limiting to only a few values?

Jason
