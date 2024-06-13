Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E560143C50
	for <iommu@lists.linux.dev>; Thu, 13 Jun 2024 11:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279394; cv=none; b=ilfxjYIXy/5vY7eQeSCrwY+T28V0t9Hc+EgrVFn9oYeNZUegIdhfJOTTDuPMVcyzQJcvD7JnweE1WLYB93ai2+WVQdwSk95fWyPkneS8lxBvNitnm2Yr+htHVGho3CDR5AtGlF4aRFM3PTY505SPf9KoqR+Z1rZJrAmpMEWCoyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279394; c=relaxed/simple;
	bh=JMH7aegv+MnUlyAhiAM0CDdTw+aBY3IivqXYt0vaVMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M39a7mm/yIOsgNwd7OB15bbUtmCUW5xF6wGZSvRGUkTAPOYSULWLGD4qMsKkbfnwYggcEwTNg+Zz2w7Qf+ErKXxYjbrntwifkmTkgPbUSu9eDJFwCU+unY9x5fkgU55pfYT2n7jfpfYDDP2M3Aoq1ZkI9xPsOBetSV0q/x1WmW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XN9piA6p; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XN9piA6p"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-797a7f9b52eso57060285a.2
        for <iommu@lists.linux.dev>; Thu, 13 Jun 2024 04:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718279391; x=1718884191; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jK9pHfBGXfQm/UiByYtEUABvVZaPCm/AtIE7LocooA8=;
        b=XN9piA6p/le3WDKQwIj2D2uFzv9Cz8QJ1GYieffbraGcgp/xARHQz0MFE9dpU999MN
         pNKGzMUCwjJvVqYOW2xflHglWdKW0Vgmjs+5kLGxDz218b4AWmCzyqhvllfUo+E1DSMf
         Q6YjuV8caJWWy+8gbO0z45rJMQQfdIORlkapFTFmtb+jWEbp0+y6SbId+bMyKmsjarRV
         6MRXZWECz/ys3iP5ZXjecsgL6ozw+dt2prwykzgyRbZO6/azH36a2g7p62sYh4hVfJhq
         x/PcPA0MHEB7nAZ8t/n0YdEFOUdrW7eJfHKuCk8Ir/XwXX5pauPTNX2ZNP9fkptOBsxO
         E3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718279391; x=1718884191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jK9pHfBGXfQm/UiByYtEUABvVZaPCm/AtIE7LocooA8=;
        b=v2v3uj9ysz1PRTk010bbMzUPNNIUnEId9mRw2mKNNTlG4HVkipl3WOLwWWT33nrIyK
         6c9Ao+JFchP57kznZE/9GQuRIYtK1xWExfqjGo+Hhl8bnX0pOfcokdLj/uNuWxuYxaw2
         lGuFCpqHBBTOA6cxtqhE7HEQd/SWBZuezAmSMEhtbgtR8zyFTBTkmwWDWcXix6xJ5S8R
         Mi8Kr+Fjmk7iYDf/M5IhY/nARYV9s2AJwli2XDWRCllITsfQJIe3w0L5Rz2NaRQIE/hh
         rEjkhuolVW7QM+1hW8EzNAdwpGFXhV58pdbHi52O0S84U4dLVANq8xGEc0qEDXOzxKGc
         EquQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDnLOarC4H2UwL8AtT+bGa8EGVTrPQVmBstpdJwGh0NXwKxGp4tcHy76BTrE5mm/JlE22amhKJsvY998tU0kpqOTfZ/XY=
X-Gm-Message-State: AOJu0YwFlOrV3eU5yssdasozM2ysKMUjn+7wysb9XLHE8dTUf373FbIY
	PGboNp66u9qhZka2mqqev3+2TY5vYPELDeRMc79ImH0W8tnht67ff6xY5PDc+tE=
X-Google-Smtp-Source: AGHT+IFWK9h3YEybm6BIGLMJNixPvA73NV4oZYSszQRCqVG7+H7HxqTpkqRohcPjaEg2JALqIvr1Ug==
X-Received: by 2002:a05:620a:4482:b0:794:d988:521a with SMTP id af79cd13be357-797f6006419mr521195085a.7.1718279390820;
        Thu, 13 Jun 2024 04:49:50 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798b73fb4dcsm40891385a.100.2024.06.13.04.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:49:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sHixg-00FW6s-Sj;
	Thu, 13 Jun 2024 08:49:48 -0300
Date: Thu, 13 Jun 2024 08:49:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 03/10] iommu: Add attach handle to struct iopf_group
Message-ID: <20240613114948.GA791043@ziepe.ca>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-4-baolu.lu@linux.intel.com>
 <20240612133732.GW791043@ziepe.ca>
 <013afe9a-756f-4c85-baa1-977bea6be395@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <013afe9a-756f-4c85-baa1-977bea6be395@linux.intel.com>

On Thu, Jun 13, 2024 at 12:23:17PM +0800, Baolu Lu wrote:

>  struct iommu_ops {
>         bool (*capable)(struct device *dev, enum iommu_cap);
> @@ -600,6 +598,7 @@ struct iommu_ops {
>         struct iommu_domain *blocked_domain;
>         struct iommu_domain *release_domain;
>         struct iommu_domain *default_domain;
> +       bool user_pasid_table;
>  };

Yeah, maybe spell it 

  u8 user_pasid_table : 1;

Jason
