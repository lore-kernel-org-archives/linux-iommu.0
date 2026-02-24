Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FB92F3620
	for <iommu@lists.linux.dev>; Tue, 24 Feb 2026 19:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771961018; cv=none; b=HyMhiCM5udbMc4oc1Rapzi8Et+0uafCxsFiNLptx04kKF6aQqcWwJ+5aZ28p0DQ57vBt6lUsmBjX31UxUOXwJpanXgRYa1RivSCmDx1w1Z50zj3Pk4lUvy2D727+v3rYWmBIFBR/Q3XSOXOKVBEfNHK60C5bXMfarbJMACnWUPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771961018; c=relaxed/simple;
	bh=8W1FHTmSZLvxiYvmbXSxc9vFio4oR+3HdpOr56UCHAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFfdz99wpDUBkVEuws6XzDV05Gz9WeZRQzeuT5Tz7F766YrdvarWkOxeD5kNS+BNOOSYhHkbwKFDl1i6WofxrdKhm4Xm0AlCxrXFHDtgY3Up3Ki/KFA8golS+1zUFKJEL/SNelb/Rjp571pgAsYWET1V2IPEZQ5vhYSZxZPY3MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=elb1Rllx; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="elb1Rllx"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8cb3dfb3461so600364585a.3
        for <iommu@lists.linux.dev>; Tue, 24 Feb 2026 11:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1771961014; x=1772565814; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kH3+s8+YV7Jxhg+0pWecX+ujJZRfi9cUlSTEhsPv7+E=;
        b=elb1Rllx5u0iFLaiU1uVt7CvkjLGHqXxAb0R3UXwVu09GG+cWi9fCQwCGfKBdYuHQC
         OHTKq9Ds1fXESWPwWdtpA04Xj9aoJNVokFowzdLbfAgUXRxed6HbVw96RUVKhuLPemWr
         UFeqn4PA0gdHEAdwpgW6DMuWYemj77I8MlPboJmQ7uWYv7ZsnGpFw1tefS77qQn/Z6Or
         wL9JjMSqBFXCYUi0dflWRJwl1jEJJqTsbvTC8naQGTD0e5qSMu7cDxWo6tzKVBRZtx1z
         10QQ/e38ZZSvWhB1qo0FRArp8ZqisoJVzg+NvdfizsgNQUDskWq9XUO3B+vkywCbMakq
         CFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771961014; x=1772565814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kH3+s8+YV7Jxhg+0pWecX+ujJZRfi9cUlSTEhsPv7+E=;
        b=Rzov7geN2G/ROMhQINCJreLS0wDbQ6WuCfxbyXn4GNWZ0H7jQHWtPK84GecCSuwHL9
         ApQ7PUukkglEgOJzlUrWig6sYiTGSOkDR2Znq9gY7YKtIjSMlWQYiYkSSnaOkhoC3FeA
         XptW9enGshfeq3lRLPApAMuxFsjuGPifQ67MGrJQUP2qCRu1Gd1BIx5utYcdhzCyimWf
         gWyCjPNCRbbFMFeaGrymOnSk8TtbFPxSqWomtamXQfh+WXJESCgk2F0oAtdq3dDq7Jon
         h3losHeaTgU3MG9JgDj2U6afSVxPB9oc1NG5yDC5pmeHRt/XPOZRqlfRDrO4YAkMxmTB
         JgPw==
X-Gm-Message-State: AOJu0YxDL0TnoIuoIxsW8jC734hhyNodByMs3iFK95CIJf6aInZGCmgR
	MdzGojAV23uTizwwv/7L5dpFPKdNE8YXxJc1tvm3SlSYN34Uhaz5XxKV3exHcC6L68A=
X-Gm-Gg: AZuq6aL9gJnyHyKXuxbiMnuvQWrfDNtI34IeNOi1jRvvLWkcssOMmMt2mhbM6UEmc48
	hNviijKDTtmUq7DlFfVNq3PwURvu9bXrqPSeKmWVF8QG6g1BOjc50QHOBFdBYfzATz6HG+AWJv7
	o7fCZCRQFYL+EO9gSnbaOV0hB86tuxZDG+tbWlVFN7pNE5Sx9PeL4XOpat3ITe9oeEHtnO9BlW8
	10HN7101phgtn2ZNbs9VIyGK/5NIcIM1SyPHt/Gh3LMqfY5hUyqfXlMZ7ffYEQF/SJqkUvoRi4m
	VWBCeFfgAPQDQU9t3LOz6kDPR4t4/45aJtqj41UDmsTEMc4/7lI9k6DuZiRuUpuXQ1/REXFL434
	lVEDsuYyIS52iDkOkXoUwG3JeBkN2udAeog6yWSXA7Mlt1oe1fGwMKBXZov5E8Bdbj3QhE82cCV
	M=
X-Received: by 2002:a05:620a:46a6:b0:8c7:115a:d0e3 with SMTP id af79cd13be357-8cb8ca640f0mr1663473085a.37.1771961014357;
        Tue, 24 Feb 2026 11:23:34 -0800 (PST)
Received: from ziepe.ca ([173.231.112.170])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d0eb32dsm1204908085a.31.2026.02.24.11.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 11:23:33 -0800 (PST)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1vuy0L-0009No-Ej;
	Tue, 24 Feb 2026 15:23:33 -0400
Date: Tue, 24 Feb 2026 15:23:33 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	dnaim@cachyos.org, Mario.Limonciello@amd.com
Subject: Re: [PATCH v1] iommu: Skip mapping at address 0x0 if it already
 exists
Message-ID: <aZ36tRwNP8cRRX1l@ziepe.ca>
References: <20260221235050.2558321-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221235050.2558321-1-lkml@antheas.dev>

On Sun, Feb 22, 2026 at 12:50:50AM +0100, Antheas Kapenekakis wrote:
> Commit 789a5913b29c ("iommu/amd: Use the generic iommu page table")
> introduces the shared iommu page table for AMD IOMMU. Some bioses
> contain an identity mapping for address 0x0, which is not parsed
> properly (e.g., certain Strix Halo devices). This causes the DMA
> components of the device to fail to initialize (e.g., the NVMe SSD
> controller), leading to a failed post.

I'm trying to understand the issue here, is it that the old AMD code
incorrectly succeeded iommu_map() on top of an existing mapping while
the new code returns -EADDRINUSE?

Then the existing guard for double mapping doesn't work since 0 is an
ambiguous return?

> @@ -1224,6 +1224,11 @@ static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
>  				ret = iommu_map(domain, addr - map_size,
>  						addr - map_size, map_size,
>  						entry->prot, GFP_KERNEL);
> +				if (ret == -EADDRINUSE && addr - map_size == 0) {
> +					dev_warn_once(dev,
> +						"iommu: identity mapping at addr 0x0 already exists, skipping\n");
> +					ret = 0;
> +				}

Nothing else prints here, so I wouldn't print either..

Apparently we just silently ignore if the BIOS creates conflicting
mappings for some reason..

I think it is OK to just ignore EADDRINUSE always, it unambigously
means a mapping is present and the intention of this logic is to
ignore double mappings to the same IOVA.

The cleaner fix is to correct the return code of iommu_iova_to_phys()
or to make EADDRINUSE reliable and remove the iommu_iova_to_phys(),
those are both a lot of trouble so I think this proposed single if is
reasonabe. Just please clean up the commit message to be a bit clearer
on what caused this regression and add a short comment above the new if:

 0 return from iommu_iova_to_phys() is ambiguous, it could mean a
 present mapping. EADDRINUSE is reliable when supported, it means the
 IOVA is already mapped, so ignore it to resolve the ambiguity.

Thanks,
Jason
