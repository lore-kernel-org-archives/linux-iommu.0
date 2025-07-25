Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EB52D028A
	for <iommu@lists.linux.dev>; Fri, 25 Jul 2025 09:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753435122; cv=none; b=ndxOmNaURJJD5IXJZArsxnes+aeVjo42L2rAIZPZemjb3SZ1lE9XTfB4nND2L8ruuIFOtc6bmye1zyjPupSJQKnGEmUyWLL8R9ieUpDm3ZyySC+f/NT+p0l4JpAjhTPxSDtpA2OSSJxMKus3G53cFzWP5Orm6SQmMSxrDaLI6Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753435122; c=relaxed/simple;
	bh=xpef2y2maBnIdrYwyhOyyrKOl5EEcqRqvsYz90m6gd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FClbnPFBm0IOGbHg/SralcLL5uIXb8Ug/mYyuWb6P5X60lFgtu6VcI2qvJUzmEn+yc0bFLYI4ucMpHVrCWe8HvJJFT4QAjwvAGpNN/cOr2qGiXuQ1SWdv3ecoERq29nuKJLw4xUvbD/Xy8j5cnb3VvbrHvDfEgjItQBOFAAD4MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BNTMFdAf; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BNTMFdAf"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4561b43de62so68345e9.0
        for <iommu@lists.linux.dev>; Fri, 25 Jul 2025 02:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753435119; x=1754039919; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rx1cvWLmG31uLnbCDZX1np35fkcLxkLr007ob70MLnA=;
        b=BNTMFdAfCChbNLVLk89jTcWrVV4DeQ6Z+TyJd8M9iIDI6ZQKW8wI3VlhRTdg7HX9LI
         11sqzIXS1o/A453UL0cQqsyHIfi9bCfIKcAaTP0etNbzw5iJZoV1V7k2xto3w7MhkyUM
         qb0fdNXdN9NW9bzZYsWjqDisRuAwKq4qzK/vBHgXNY8UoeD57gGVWn/bJGYhY/j4tCNI
         jEReduQv9g7qh+i/6x/580IyslQSkJ+EuwAftfbxBhX+RS2CRDFriouqIBwuOCW5Bw/1
         31vRuhgWjLR3Z13JjUHjBnl4U6cXqt2zgTB/ZeQ2ReWMtvwfYRF2RaAJKPXqb3lB3BzJ
         aZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753435119; x=1754039919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rx1cvWLmG31uLnbCDZX1np35fkcLxkLr007ob70MLnA=;
        b=aL9rBCyqtt+dp4fJZgjPM/krz0Nmtz3ryz83uV6S7NehF7HWk8BdiE3fGMWSQ7+BaV
         Sokz1RzNS0J7up0EA7Ad4YREQT0FBRNxdebyGCSWE8FPmZhh1U0V6Y99uoZEcJ99Cm4Y
         LN7dQVqgjkWoJhSvQRybbonYS+uD0freDZIAX+RSOh4dPoI4MKbCCY0W7nB0P7KyrxjO
         /B08Rw+pUqGEU38PTSYD7tDgvWgjYSx3NYaDkw4RfytlNnfCiIuGoy3V7wBqZnvwKuRV
         z46kr+0dM0XB6f+PjKngB7YRznqGRwxzbrTTp0+yCJBss8NPKD7fnXXsOTekU/93Scgf
         7nzw==
X-Forwarded-Encrypted: i=1; AJvYcCWNBcLyQnqoCw5B5NzVH8KdQBPdSQrOQ8HaHhYGHyEL02mNA4Uq+1UWA57iTw/A7qgmoIzh7g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyMGdU8bT1Po22g+zZJSpB/gAX4wwBXPr41sBHd+dtMMVkIq41h
	eP3XF5NcqYH9imJeXyLTFyNZgiEqgNlUpn2k8u2D+To/N3m6mtiPcFsalp1xn40g0w==
X-Gm-Gg: ASbGncvZiXGcDuWKycXXLL2qmtBQtbKFDMLoBIiHHCjew5RSUu8ykTqGZBqkgCCcAqx
	TCM0W/ruYfrEOviyqAEqfD1vzybzE+/iKo8lU8mXlUsfJ7kwcqgZO3kS2/t2Vq3uzDCsHPb8zX6
	Q/DflIontYuYXvLNEEClfjrGyElSXVRjEZLJVYZM+N72ouhl9B6ccJBSKxdWqsMDALnDdaYfpXv
	bsNw6lBDYRUuVLbYQNwSs8va71KIW8MPxgy24xeM6olVS0TuIRBVot0lyXLiqjNjQFMOnuFR5gq
	oraVdIkr6qPyxbXsEB2R3RUU1M82nVfHF8ia1YMM90AJQ9+vEeOAhKUQK2tJ6EA9rCyQf0ArBZh
	ohIP4hCsHL+AADnycmg0BwbRQDqW888db16chMeCFaevDnC2oojW/XKweRJP1VyJO2fNg
X-Google-Smtp-Source: AGHT+IG/k0Q54xhpN2oIpbKY4vSeV5TCdZSBuTuoauwrucxpglZQHZulK/b5JzyYYm2oFY7AoMBuLw==
X-Received: by 2002:a05:600c:548b:b0:455:fb2e:95e9 with SMTP id 5b1f17b1804b1-458730cfd06mr1447805e9.6.1753435119066;
        Fri, 25 Jul 2025 02:18:39 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705c4dbdsm49065635e9.25.2025.07.25.02.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 02:18:38 -0700 (PDT)
Date: Fri, 25 Jul 2025 09:18:35 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Pranjal Shrivastava <praan@google.com>, jgg@nvidia.com, will@kernel.org,
	joro@8bytes.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iommu/arm-smmu-v3: Replace vsmmu_size/type with
 get_viommu_size
Message-ID: <aINL66r_1NO3Nx-f@google.com>
References: <20250721200444.1740461-1-nicolinc@nvidia.com>
 <20250721200444.1740461-3-nicolinc@nvidia.com>
 <aIDlsUvF2Xbdelvx@google.com>
 <aIEkZoTOSlQ0nMKd@Asurada-Nvidia>
 <aIEwzM7mKUI8-h9U@google.com>
 <aIKd1owebUNQeN1-@google.com>
 <aIKqaGMMpsIuAVab@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIKqaGMMpsIuAVab@Asurada-Nvidia>

Hi Nicolin,

On Thu, Jul 24, 2025 at 02:49:28PM -0700, Nicolin Chen wrote:
> On Thu, Jul 24, 2025 at 08:55:50PM +0000, Pranjal Shrivastava wrote:
> > On Wed, Jul 23, 2025 at 06:58:20PM +0000, Pranjal Shrivastava wrote:
> > > On Wed, Jul 23, 2025 at 11:05:26AM -0700, Nicolin Chen wrote:
> > > > On Wed, Jul 23, 2025 at 01:37:53PM +0000, Pranjal Shrivastava wrote:
> > > > > On Mon, Jul 21, 2025 at 01:04:44PM -0700, Nicolin Chen wrote:
> > > > > > @@ -1273,6 +1279,10 @@ tegra241_cmdqv_init_vintf_user(struct arm_vsmmu *vsmmu,
> > > > > >  	phys_addr_t page0_base;
> > > > > >  	int ret;
> > > > > >  
> > > > > > +	/* Unsupported type was rejected in tegra241_cmdqv_get_vintf_size() */
> > 
> > Sorry, if this wasn't clear in the previous comment. I meant this
> > comment must be updated, the "unsupported type" wasn't rejected in
> > vintf_size, rather the type got corrupted which brought us here.
> 
> Any unsupported type would be indeed rejected by the init op
> callback. There is nothing wrong with that statement.
> 
> It indicates that we shouldn't see an unsupported type here,
> unless some serious kernel bug like data corruption happens,
> which is implied by the WARN_ON itself.
> 
> > Had the
> > vintf_size rejected it, we wouldn't be calling the init op.
> 
> A data corruption could happen any time, not related to the
> init op. A concurrent buggy thread can overwrite the vIOMMU
> object when a write access to its adjacent memory overflows.

Can you please elaborate on that, as memory corruption can happen
any time event after the next check and there is no way to defend
against that?

Thanks,
Mostafa

> 
> Nicolin
