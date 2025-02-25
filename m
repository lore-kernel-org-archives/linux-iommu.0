Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0159269AE6
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493641; cv=none; b=TiHkl382bTV8F5eHwhqgf4SEg+Fa50QZHCZ7jVfCSVh9/Rti48HMmPBxPCaIJduppm5gcNsLeWswZDXz+3V80o26Dtv1hnzBYWTmfFO7emtPJDYUSeXdfL/njKYWkzRlgFmkEcORTobeY5iTnUoi5uVcvxqJ73mYho56sots8I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493641; c=relaxed/simple;
	bh=1xV2jf05BYHHJb+OE+WFtNmw64wG2xXtTRq1m5Pv5rA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrJokUkUmodxdPeS7cBsvcFRbFlU8WjjPvF+eoOP09cnFB+nJYaEKoCzSOvpXEXDAHig9E9GA9D+lcI2m6Ey73qNni43Jyat0WJi97DnzzoSGsfe62vaU7n088E03zc4amsowdH5E9hDUs3a1QvMHiA5P0q6Chqq8hX1J8o67L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ivIDgT53; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ivIDgT53"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-471ede4b8e5so28859701cf.2
        for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 06:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740493638; x=1741098438; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9KtHcWDBw9w2PfBEESbI5F2MpjJJ4qx1ld5UvYhe6i4=;
        b=ivIDgT53gi0lm/l1Kbdn/FbfpFzUQwupYTvE4EAifTSmf8cmaVWiIgKDIQPGNgm6XT
         gcA+OKl00mREADL51hG1nIUjTNSeuxV8uQFaMJGRl/vGwbwKH+K5hZGTxBB6+bafoUFM
         l001Ul5WX0OzWnKk19dYspF10nqVmUG+CtKH7LG7EqWc8B5TS0k9prHJz9YDRIoS1Bvk
         8m2iTIMDqn1PES1FAgysypYXFrZ0XZK4AZv9JC09nib4NASKWExMGb1s0defW5tg4fFf
         nE23gadU+YsG2a0ZBCLvWv6ZgC+Msl8w6fAAj6L+FGIl8K1M88Ngr0iJHsQZT9tzIrxL
         lLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740493638; x=1741098438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KtHcWDBw9w2PfBEESbI5F2MpjJJ4qx1ld5UvYhe6i4=;
        b=RoTLznp9EfEDtxcPSgJtiFgTYMRDcavOyHAuRoQVKkbyQ2qJMykrcNcqjAumkacS42
         Fl2hJrRNT9I4KPBpbqmqzAXf3vs3IRduoQ4lWatwRSfOKGPPH9sTajHBEhmbsCrhYe0B
         zmXZK4mVfS00wN2T9L0KvefkLcYSm7qworGOqwKuo/x6+6Lq16FyvlHmJEBDmaOKqeKr
         bUQBjnMh83ZK+BqWS/ejNwp4xsD/bcM9BNnu33OTno7FPwH+Go5hZ8JKeQSmi2Oks6+Q
         XwhgUhmP6Qxb+trDVco3s1WyJdgSYg32aD98X+W1Q8aqvlU2ltYAsU4liXn4QQQVAcNP
         p3gQ==
X-Gm-Message-State: AOJu0YyTmTLmXQhPZDQR4b88pmK3TWcyNB+u1PRqxzWfTmIEEWPnv60g
	FgsAUUcjRWz5eSQjzNcYSUBDri7FpGhjRCP+IaJfQXsj/inOlqoYgn88aetNlH4=
X-Gm-Gg: ASbGnctGoauyL7eapZ+RFYi+n8vQ3rBZoAIG8FXb67EmQSAohP6wQquMIb641bLJuMq
	+zrfXT4+l04FQU10yLPEgPzOce2ZsQMm8LZE6LxKFfRj8JnYZINIBl+4+P9eRLEQd5TmzjXz8Mn
	f4CTJ83ZVdw0YYnpC53f5N8iqInNtVDi5GJQAhd9Zy0+tWeuLvxNBSNqOqGgfCdnUOlNcpE28jZ
	BeakfzjMfDd5axynkZlsqw7TNvPkaVNm0/Za249Lrs8Xav+GLdYO/8YsxkOD9uPRHi/cNu043FX
X-Google-Smtp-Source: AGHT+IFFrC/FZADYxrglHCrQ8FNH4iWdCuZgXdEaaOAjOlbhoXxq7p4wIoNznPk728SdxS0XctxM/A==
X-Received: by 2002:a05:622a:1a88:b0:471:9721:db91 with SMTP id d75a77b69052e-4722295d9dcmr193345281cf.51.1740493638530;
        Tue, 25 Feb 2025 06:27:18 -0800 (PST)
Received: from ziepe.ca ([130.41.10.206])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4737806a627sm10353031cf.58.2025.02.25.06.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 06:27:18 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tmvu1-00000002T45-28zn;
	Tue, 25 Feb 2025 10:27:17 -0400
Date: Tue, 25 Feb 2025 10:27:17 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH 4/7] iommu/amd: Remove outdated comment
Message-ID: <20250225142717.GF545008@ziepe.ca>
References: <20250225105345.52143-1-vasant.hegde@amd.com>
 <20250225105345.52143-5-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225105345.52143-5-vasant.hegde@amd.com>

On Tue, Feb 25, 2025 at 10:53:42AM +0000, Vasant Hegde wrote:
> Remove outdated comment.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/io_pgtable.c | 7 -------
>  1 file changed, 7 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
