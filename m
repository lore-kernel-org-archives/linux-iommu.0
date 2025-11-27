Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6FB224AF2
	for <iommu@lists.linux.dev>; Thu, 27 Nov 2025 18:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764268340; cv=none; b=lrLpt+h+YVjFoZDnWZMVQ8G98f0mY4hTghe6jDCaqrmrrlqVBIvz4zj8oLDEY7cNgeQI2Cq9mEH2PlcGnXGwgv2TmPzTeX5zGGzBwCtbitx9Mtj3foq6QzajWpK3lOtCzwNsQa9jA6z53lLVkezF/WIGtV03D5LQqcKqk7R/+9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764268340; c=relaxed/simple;
	bh=WHk1uo17dVjWacWV7hwPy8vRoDSse51wzHHLUZidgw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xqjr7X3e0CYavcgEEapzCu4pjD5BsGZzFIr8GcpDJ8mLu/9MSxrtIfckGB+fDLAm9d3DjPPs+vbJn6pren9RqUY1O0keieVz7avVTktqIVjAr2ffjE+G5fPsMd0rVDa0ttJQB+yq0bybvOUTXLcr8lqeboM2JrDmDtFM5BJUTrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=FmNw3JQP; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FmNw3JQP"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b21fa7b91bso89195385a.1
        for <iommu@lists.linux.dev>; Thu, 27 Nov 2025 10:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1764268336; x=1764873136; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HCiMjql0Ln9mtMkZZ6N5PUzOpoCpzuDx3Hfi9xQODmk=;
        b=FmNw3JQP7lsR1P+25IANQ0FLUWyfm7pw/kS8N+cAitZ/3l3kUmXt8Ol0AhelKSrm0U
         X5CSZlGcSEJEOv40zWkKr2EE/y2wbMXxed1SK6dnAMJq1CdhvyHNpohVVtkuJU8XoNdC
         KOvkptQU04jzU6xFaCqYoFYEUfCQyNGEGzcEM0FvsHcP1PcPfejPDV9grSK1teMYmedi
         ZflHsbl5J3PG1znfbJwB6Mbac3AK1JnCWLr+77vCgbpy9hI01o0/p0TSSCTLq/O9LtBY
         2q05gSq+XzNTIHnVlj58XpleenpZ7iNBDcjcEmtYEFvlPtz5RdYdAVF7Ok0jf3K9cPKc
         qbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764268336; x=1764873136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HCiMjql0Ln9mtMkZZ6N5PUzOpoCpzuDx3Hfi9xQODmk=;
        b=bDkruOCi9v/l7SjHu2Q41t7x9buGV5fJuG4eYjQM6qVBub5Ar4gvCjI7nwZa4l+okB
         2w8/kRzacGSK0U3VqUyWfKd00AV4Up0bIS9xxTngkvlPTw3kC8bwxELsv/ijnwFGrKZh
         3zALFxLeYaAR6Ot2cRfz+sZsglig4WetXJtYSLnP3CUw+X0BpSqysHF/0CBeYc/PgH+Q
         FhvBrHPR8g5FuVOpOBiXFpMwPez1qQNXy8cZjjmz5+OXOCm4Z7glJe67aWTAvbu8MFXr
         hB6OTrNacRaY3JAPm9LYSd3T6iwx2OkFIa8RVuwnI5KtVSQJSHfhLpPelOP09BwnyaMX
         3x+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbCC1pkc9zPWZc3YwlPN5s3TvHtFZkacne6L7cMnZ6CdH2iT0qbqSEjWSeBpgX7jiGzixxFQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzEQsb58sHcGZxvfzHEvSAZAxOnUeW0uwFE5tLlOPurwPfr3Nu4
	v8XQAl38SBkICfcK+RAWk+li2PfouNEm5bREWAtUnFIskN66EeCVynVpE213pNlwHmU=
X-Gm-Gg: ASbGncv8/irfxYFXyzxd6MR57VaDd7cZDSMfWdN588e5mK9jP4PB57eSOcVJl/rNRhy
	xeY7UsdYjlxkJdys6lMwMmOW6FXWeStTHmMtcaxuIoN9mmyCShnvq3GmNugCl1lWWWYWFgORgYG
	b7TxRkZKO7A7j9TYT7K9Rm34o12y0o7UpURLxe6DoxE7NC+9trS0u07txb3O5HV6nw5NLokHVR7
	AaPJ5kKg2uniWSyTVxW7vMvDqGGh7kHPZ128RD9yxVfgx97jH/gqMpEySgpuCDzPxHD9QxWeDtn
	eODmth2fi9yaeO72eaM3MOcJV0dHd7wgUL/WfpQ1FMWE2KXG86xVBnVOm7vaaXx8V7lGAVf7dtA
	uihaJu90Hhi3JRRbEZQ4sYNqEzdwbFHnF8kzl9zaJdy7WQeOclME2vaJvuKaT3hFUR3PIZ9Agxl
	2idXvWJyBmeddAWRPG0m2yUkXpUulSf6PCD7AOgm02DIQn1mQ4T5wmjo+9
X-Google-Smtp-Source: AGHT+IHGJGM6eOtBtWFxNi17xfgkx9F8mVzn1S+VAFr6nzN3No9wjuTWWyomn7f/Lvh3KZ37YjI31A==
X-Received: by 2002:a05:620a:17a1:b0:8a4:e7f6:bf57 with SMTP id af79cd13be357-8b4ebd51368mr1670540185a.5.1764268336563;
        Thu, 27 Nov 2025 10:32:16 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b52a1b8123sm152040685a.27.2025.11.27.10.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 10:32:13 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vOgmo-00000003GyI-3BgM;
	Thu, 27 Nov 2025 14:32:10 -0400
Date: Thu, 27 Nov 2025 14:32:10 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Calvin Owens <calvin@wbinvd.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH next] iommu/vt-d: Use shallowest supported table depth in
 sagaw
Message-ID: <20251127183210.GC738503@ziepe.ca>
References: <8f257d2651eb8a4358fcbd47b0145002e5f1d638.1764237717.git.calvin@wbinvd.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f257d2651eb8a4358fcbd47b0145002e5f1d638.1764237717.git.calvin@wbinvd.org>

On Thu, Nov 27, 2025 at 09:06:35AM -0800, Calvin Owens wrote:
> The failing condition in paging_domain_compatible_second_stage() is:
> 
>     /* Page table level is supported. */
>     if (!(cap_sagaw(iommu->cap) & BIT(pt_info.aw)))
>         return -EINVAL;
> 
> This happens because, for many domains on this machine, MGAW=39 but
> SAGAW=0x04: that claims a 39-bit maximum address width, but also claims
> to only support 48-bit/4-level paging, which seems odd.

This logic was intended to deal with this:

static int compute_vasz_lg2_ss(struct intel_iommu *iommu)
{
	unsigned int sagaw = cap_sagaw(iommu->cap);
	unsigned int mgaw = cap_mgaw(iommu->cap);

	/*
	 * Find the largest table size that both the mgaw and sagaw support.
	 * This sets both the number of table levels and the valid range of
	 * IOVA.
	 */
	if (mgaw >= 48 && (sagaw & BIT(3)))
		return min(57, mgaw);
	else if (mgaw >= 39 && (sagaw & BIT(2)))
		return min(48, mgaw);
	else if (mgaw >= 30 && (sagaw & BIT(1)))
		return min(39, mgaw);

Though it is not right..

I didn't consider that this would come up, the only way to solve it is
to pass in more information so the tree can be higher than the vasz
requires..

Can you try these two commits?

https://github.com/jgunthorpe/linux/commits/iommu_pt_vtd/

Thanks,
Jason
