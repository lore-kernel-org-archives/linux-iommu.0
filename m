Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8E11DDC10
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 13:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729170848; cv=none; b=TytOX5qNwyxDF65PZxEjkhtvtBBRCVW3+5QJC5nmBdmWxcqg432HRub/29VTaVx1k8x62d2z40WCfjM/B7RzY/m64gq1iyTyUv2h5MgGZIqY72+kDiCfwfl+/xNro5q88gplnAfzrFfXuV+GblszJX/WXSdr+mhndAJcfpGvA2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729170848; c=relaxed/simple;
	bh=YqFFNKQzFabICq8WH4k8wiSaOTaILkTwTng3nulCmx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bw1BxwLBa/lJUwP7yNofRd9cR1Jh/XsdLbA/NriUctkAZ3jCBjcSaIfm5JM+rxLPD/OSpdn/i/CNd4urHGHZitA44dAUMT3db7X5eZyn+xY+ZT482hYsRePCEMANwSkzxjJXw7n+LR1kpMAH1aIZC+Np1CsIiKcMPwljoD2wAdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=l+2xAADO; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="l+2xAADO"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-460a23ad00eso4646121cf.0
        for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 06:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729170845; x=1729775645; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hDdIQVy3V0KISy55GnsTC8qCrPccGASFBRGSvXvdYNo=;
        b=l+2xAADOrRz7Ij/F6Cf8yv4jo02hTopgI+Uua8CPS40la3KnbLrC57ZfQ6+oiAtGH1
         Xm0HPiGhBmIdqQuY5rWadKfGiHvKAReZQzLCvwNSPtDjOMoD30NtLjTyiGv+ZlxjprTs
         YtaPVk7iNFIhbdV4eJo7YdNr/EiRjniOw5B4tbA+l+myQU6M14rDSKEfUyJyjE6Wx73c
         fxsQ/TR0TGIu5piLIROFFO8ejBe63+5rPoejzCUfHJdKneNIcUN1tj/reuFwyE7cKgzA
         zkN6CCllSLnggU3kuaNUkcPJS42szFjkEnaBd5Gb1ZEyILY/7bvIHFRms/9dUAsupHKq
         b/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729170845; x=1729775645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDdIQVy3V0KISy55GnsTC8qCrPccGASFBRGSvXvdYNo=;
        b=O2up8n3igUslVBjwLxjpSYQStHrBc3NcwrCiePq+xFedwcvYrf3BobVPvWWn29E+Qw
         yigBU4ErHP7o1kdny1gf+2V7AGLNSJNkl+O974TiFZCHLSRHYg81/DsAAvjUXj2i5O+U
         1bxGJoZ+3D2bAZau9k5ACVeZgg2GCglA7uTspR9NeDhKokqkIUkgLwi4K+LEl+J8cEhp
         SX8mIAqzNadQc21k9/9icimXVB1d5ABKujSRk5/2GxH3JdQmhTMf3vIFhnMbWvy6MWov
         4TLnoVHUCvVsYfW7hbevX385Y2SvpzxTABg1a/uv2EiFODHbasJxU9X6wVFi1SL9HZag
         YYHQ==
X-Gm-Message-State: AOJu0YwB197kugoDkWuHl5Jds6ZRfHufLKpiq1Y7KwIfbksnh9XB1TX5
	OxjNkJuvHlw0Ajqiy7dkYG8HPqIgF/5XkhJ62m99t6mAeZ3yfHczE1CFtTUQa+g=
X-Google-Smtp-Source: AGHT+IF/0yBwYHG47ObR2Hjg4LaXuifH+FsSW/9Hyn6GBA34nCU0uoVlFroTViINXNlwqa9CqFBXoQ==
X-Received: by 2002:ac8:7f49:0:b0:458:2aaf:5abb with SMTP id d75a77b69052e-4609b33b7d4mr41068191cf.0.1729170845090;
        Thu, 17 Oct 2024 06:14:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460a9129c85sm1622031cf.44.2024.10.17.06.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 06:14:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t1QKJ-003uOD-TH;
	Thu, 17 Oct 2024 10:14:03 -0300
Date: Thu, 17 Oct 2024 10:14:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v3 01/10] iommu/amd: Use ida interface to manage
 protection domain ID
Message-ID: <20241017131403.GK4020792@ziepe.ca>
References: <20241016053501.97497-1-vasant.hegde@amd.com>
 <20241016053501.97497-2-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016053501.97497-2-vasant.hegde@amd.com>

On Wed, Oct 16, 2024 at 05:34:52AM +0000, Vasant Hegde wrote:
>  	/*
>  	 * never allocate domain 0 because its used as the non-allocated and
>  	 * error value placeholder
>  	 */
> -	__set_bit(0, amd_iommu_pd_alloc_bitmap);
> +	if (amd_iommu_pdom_id_alloc(0, 0) != 0) {

The IDA interfaces have a min, so you don't need to reserve 0, just
make min 1 in all calls, which is being done anyhow:

> +	domid = amd_iommu_pdom_id_alloc(1, MAX_DOMAIN_ID - 1);

Suggest to just drop allocating 0 and redo amd_iommu_pdom_id_alloc()
to have no arguments and set the min/max correctly internally to the
function.

Open code the special ida manipulation in __copy_device_table().

Jason
