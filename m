Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0634B7E105
	for <iommu@lists.linux.dev>; Mon, 22 Sep 2025 13:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546145; cv=none; b=R6GYGZnqPLigZuGYGpWWGEfVQfbyKfaTGNrGoVNUyVoURAIJJ65pgcFTu0FY+433Yh5/Q2/XTSKa5xBFHxY4D0RIkGIzloq62qldJ8Q0CdNNS+4q91NdltQVmLyUO0ZqwbiQshygU7FxSIav2poUGk/ljswmCsxqJ/zNN1LQJQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546145; c=relaxed/simple;
	bh=zCJZQaGMV7DeUHFgiP5VUvTeBc76Osl5IXFpblnovgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjEYNq+hTSboy09NtCOyEaeEo5jsGj52TKfB8JvsnWINJosnw9AfbGuKyAZT10clp+KkQUV6zYRFG1OSs4GsVSnfr8xgyDRZfwIPoI4IXISM00VB/p3Xx1/H9sWdWkgxvTLi7+v85AO5VNVyKF4fUwoy1sCtgMuhde6vq45HkZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UjTTgCLF; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UjTTgCLF"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24457f581aeso43001925ad.0
        for <iommu@lists.linux.dev>; Mon, 22 Sep 2025 06:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758546143; x=1759150943; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hsl2ly4me8UmHDMkRt9NyvebrtmZ4APkli4pzDgp5iY=;
        b=UjTTgCLFxHMmATQ356Bukv1ZEc3gO2VFfM+DU13vV56NbWMy/BG1uT5cAI1iP4WN+f
         GX5kFYZml7qFzpJr3tjTzC/XIS7e6KOX9rqZlrH5L3hsnmX+6/XAEjq6VJFgoyVSnuB7
         74AhH27H/ANmPOPuBGFVqcco6nR1vY2+irh8opqQ0TmDnT8YIHH1qtJtxNNVmHSMdAUo
         vZcYCrzqsvDuXsNw3ofEpFm3s+qopN6DBj9azvMzlKVCLPeqKyp5MrRwMi6dMgtvULaS
         gXg8A5D9q/xqA9HXAZFW2ImMHcUfmrMJZPi2kHbXOL8XSlmhRhIWy6y7VCK7e3k0gDQP
         QAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758546143; x=1759150943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hsl2ly4me8UmHDMkRt9NyvebrtmZ4APkli4pzDgp5iY=;
        b=wZPBZrUyvvxzEcsXPRhlTfJENOimogzzQ1l2YxBG7e2A9reO2osRmKroXwGBU8NcUg
         ev82Icw9Pp//DGGS/oZMhRUYnFLPvgq822jW/smwpL0Ukqsz/9GOwPt1TNZhEkOx1DoV
         xsXBLKax8bGB1Fa1mqbS3ZeXzedbvSfgWvNgkKzyIt6cpA55sdMojG61F5lBIxxL1We/
         jC/aFCddhsbk9u9The07AQIZKNn2kRgQmuT4mwmK1ZTJmfkUbAaB/vqNSsHmd0gnoS7H
         FP8vJ6HBNv3e696/L3II+Cqyzd+hrttQJAco+ZVBsmW7RZhRKLROHuKWzteezNzfV9J+
         wa1A==
X-Gm-Message-State: AOJu0YzAxJfiTJKJSxH+gLvBm0ZCoIy75P9njmY4jOsWW2r6jV/MdJ3U
	8dged74bzBHc6+PPZGoBwHkwLeTTcmXoQCsYSmMmbQUiwSiuZH6LoQ1ibxem7J0FKMY=
X-Gm-Gg: ASbGnctV5X08jS98hojMniUoxTMu1PUOI255VSbBixOGT6bujs999noGDKf3DoOitpV
	Q86GoDa0Hj3P/6bNmNedHg1q0tdJEX9PKFbzN0rVShNyKshXEz0ixY2XBhJ/GUm+qnXv6zBxvBz
	BK0xRORbI/R3qMeBZXzMpEay1vHxphhzSnkbmSKL6t2q2ne5cTuTZsWVBWeDIPPLxwR+MlsM6Jt
	YS+Mlk4K/3Hi/7nr16IQ3TSZ9wSlPrx/80/BmjPtdcZANppD/kTJ+t/tmf6cxbYHJmk+f4pZ/3j
	6IIa1F0FFcsRYTz6MLRTJ32Ut/HZVqpUOJdoion6YPadFkZiD5pavg+fLlJMKCJ/K+TDtL0K
X-Google-Smtp-Source: AGHT+IEwv94cgMdvdUliR3uxXVS/A4nFW/1Uk+w9E+kVZKrcO7lHiL9BEZgyiij4H8dwtTrp7ERipw==
X-Received: by 2002:a17:902:dac4:b0:275:c1e7:c7e with SMTP id d9443c01a7336-275c1e70ff3mr55507925ad.4.1758546141378;
        Mon, 22 Sep 2025 06:02:21 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802deb3dsm132892235ad.93.2025.09.22.06.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 06:02:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v0gBP-0000000ALNw-0bkc;
	Mon, 22 Sep 2025 10:02:19 -0300
Date: Mon, 22 Sep 2025 10:02:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	stable@vger.kernel.org, Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH] iommu/amd/pgtbl: Fix possible race while increase page
 table level
Message-ID: <20250922130219.GX1326709@ziepe.ca>
References: <20250911121416.633216-1-vasant.hegde@amd.com>
 <20250918141737.GP1326709@ziepe.ca>
 <c09b3679-00f9-43e8-a620-1a6051cc6db3@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c09b3679-00f9-43e8-a620-1a6051cc6db3@amd.com>

On Mon, Sep 22, 2025 at 03:35:07PM +0530, Vasant Hegde wrote:
> > IMHO unless someone is actually hitting this I'd leave it and focus on
> > merging iomupt which fully fixes this without adding any locks to the
> > fast path.
> 
> Unfortunately yes. We had customer reporting this issue.

If a customer is actually hitting this then you definately need to
solve the whole problem including the mmap race.

I guess adding a lock makes it easer to deal with, but this:

+	write_seqcount_begin(&pgtable->seqcount);
 	pgtable->root  = pte;
 	pgtable->mode += 1;
+	write_seqcount_end(&pgtable->seqcount);
+
 	amd_iommu_update_and_flush_device_table(domain);

Is out of order.

The DTE has to be updated and caches flushed *before* writing the new
information to the pgtable for other threads to observe.

You can look at what I did, but broadly you have to feed the new top
as a function argument through to set_dte:
 
 static void set_dte_entry(struct amd_iommu *iommu,
-			  struct iommu_dev_data *dev_data)
+			  struct iommu_dev_data *dev_data,
+			  phys_addr_t top_paddr, unsigned int top_level)
 {
 	u16 domid;

So the above can be ordered correctly.

You may also want to think about just disabling this optimization,
always start with a 6 level table.

Jason
