Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7FE1BC58
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 12:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742475265; cv=none; b=CtNFYytZDzlPMVHokAHKiAP0lzZMyyE4Hliqysx4OOz7Dfzz6ksnA3MGsX40QxDNU1cq1AIyq8HhPeMAyKvZj6+0k0csUzcgScgGsYqlyhRlNhp3IixoX//Q1ivJYnlBB3VVBrGDVyfdZ/tNOkN3+93JH//QagDawX7/Po7yj8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742475265; c=relaxed/simple;
	bh=zJoDNsM73sSlcLdrAup28H7aw5Ipj42xWgMdjyj/oJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNSlt+LAG93StUAhTaDWfjtkDci0YKlPdl9mDe2+67zhYC5aFXfSGHI1lwZJhXHztak6ScXin9yOpSnQbRWqcTvwfR2RwpwG43p727h/86CUiK1UVyIkj5VOcPgFLxXzX2jmGYBbbF+1MO/MSUnnO9Ivc0tzBY9TmnxpZ4pg18k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PBrWKq/w; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PBrWKq/w"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c0155af484so122002085a.0
        for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 05:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1742475262; x=1743080062; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zJoDNsM73sSlcLdrAup28H7aw5Ipj42xWgMdjyj/oJM=;
        b=PBrWKq/wdeuYo+uMPDkDkjGKqADvpiAO5nZ1SQFcUXKlI/JOaefvwLZJ7at31+tQyP
         zcqaPVZ/uypeA5JjAjxWw5UWbux30JnXrYxfYa6QbXJPzS9crrBR2DXBt3ZbHZUOT8tY
         oVE7MT/fppnGEo6TO/9hdiWn06rFwKSdZzSGlGVU21hPMVZaUZBUr7VNVfp0y5tW9MqS
         HrONznv6UDVIZg9fmefr2BdBq7E2ox5U13uFdCGqZEdYXie+lNdMLpq1YYU8Ux6ZsX8m
         G8tXYR7JdN0tNc7W71/TF6oEyh9K8JMBxB9eIx8PJN5db+JvXW4eDt5hCDb0UqEO1jwC
         2VcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742475262; x=1743080062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJoDNsM73sSlcLdrAup28H7aw5Ipj42xWgMdjyj/oJM=;
        b=XAem1h047G/pFkCEgo+cAbq5HLrjoQ3ic5TE47eG8xioYHxjODhOL4WjUrJXks7YT8
         0F93WNShqXDA3HspXHmWDPEhwzhlTRVDZwddjk7rNcZJQCJtUtvUsBvVn2ZzhY+hsB56
         8Ue0M7zP+ulnhp1i5LSf//E5WN13ft5tIQr/5gkdjr24Ic2Jnz1l/SXoUhKS9hiDgh3x
         /9E+ZZvs9r9yIPUpoH2yGXqYCSjOvT1utVRXtX4eLuD3HJEnZ+B5HtuSXNb4CuhH3lli
         r3AFwNBptGK8Nf4pnonyznfU5CblFdT51IiMVMXhyNjRoPYRqekkDklDwrtzhVvwQMff
         7ZFA==
X-Forwarded-Encrypted: i=1; AJvYcCUqBtIOjpnMlwxaloqbGdQWli5Pkh8dlCRDcAUqI7um00/g+tyO9brypS5I0eXdulPYBLHeTg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxYj5hATTqW1SNS6NoPPzwVcl6T+zCSutn6RGqh/MFUpZt6BKGT
	5VlHuvsn2vs6EZLWT7UdfzzzOIX9T2h80YR4UWf2uc+F8+XcOvUwHEG0VSnotwt1z9l/8qm3OXq
	L
X-Gm-Gg: ASbGnctjV6FopneINYHsSpwi7dU//ujgmfYxrXacazZ7eQfX9Kzw5FtjpS5wdvHQ0uN
	Ald1awkS5qCyBbYHz7QQ9MNOf2oSiLOIwYgrF1dTW1FVabUSRCijRh9KE8iLhAd+4xuewh+5JpW
	YWiSed9USFtX2xrvfrU7jO/pAvahZJyAJUc6hs53bLbDSXVDufc+nSZzhzusqC6b6TfUTwagpq5
	N+6peQfDf54Gm65OSJAUgw5XlET8TZWS0/j+UXBfu1tz2QBOfJJ9YMTBiigv3rIOUlQZr6+7cP4
	MdenhqEurUuUpHuglPxBbDoJzn01nc961EwS3Ij2yBHl7VNpioBMMi2ilZZTb9XQTL7+gpdMa/A
	8cgIgRJaf0kc9uLACsQ==
X-Google-Smtp-Source: AGHT+IE4H8xMDDa12odz/sOysUymX5LHJeRFWGFLJmMLllUnp9xLb3Zyl3ftg7j/xeLpwXq7jA49PA==
X-Received: by 2002:a05:620a:1a88:b0:7c5:9a10:7824 with SMTP id af79cd13be357-7c5a839188cmr865975185a.24.1742475262608;
        Thu, 20 Mar 2025 05:54:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c4f731sm1005606485a.13.2025.03.20.05.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 05:54:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tvFPh-00000000hgO-0T1d;
	Thu, 20 Mar 2025 09:54:21 -0300
Date: Thu, 20 Mar 2025 09:54:21 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 5/5] iommu/arm-smmu-v3: Invoke pm_runtime before hw
 access
Message-ID: <20250320125421.GJ126678@ziepe.ca>
References: <20250319004254.2547950-1-praan@google.com>
 <20250319004254.2547950-6-praan@google.com>
 <20250319120404.GD10600@ziepe.ca>
 <Z9vCwLbwwjn-gVJ9@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9vCwLbwwjn-gVJ9@google.com>

On Thu, Mar 20, 2025 at 07:25:20AM +0000, Pranjal Shrivastava wrote:

> I agree, that we can elide TLBIs if the smmu is asleep (powered-off),
> the main reason to wake up the hw is because `arm_smmu_write_ste` issues
> a prefetch CMD. Again, it is possible that the smmu sleeps after this op
> and the prefetch has no real benefit.

Does any HW caching survive the power off? I was assuming no.

So it is pointless to issue a prefetch and then immediately power off
the SMMU and throw away the STE cache.

IOW if you don't know that the SMMU will stay powered up after the
attach there is no reason to do a prefetch.

> Anyway, having *any* rpm implementation that causes us to lose TLB
> content, will cause a hit on the performance, so maybe this
> micro-optimization isn't worth at all?

Right, it was my assumption that you loose the caches. I would guess
keeping all the cache SRAM powered is a big part of the power budget...

> Also, while we're at it, should we have a feature switch for users who'd
> like to disable runtime PM for performance reasons? I don't think that
> relying on the `power-domain` being present alone is sufficient.

I'm worried about how much this will hurt server workloads. Optimizing
invalidation is a worry and you've gone and put in some more atomic
write traffic on shared cache lines. Not great :\

Jason
