Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBA71272C7
	for <iommu@lists.linux.dev>; Mon,  8 Apr 2024 14:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585991; cv=none; b=FTVHzPtGnWBTBkOxeLTNDETzMAQddgsDdhZfhO+hz4lS2uiPA7yimUJDfNzHEt8ZmzC8rN8Pc6VQdQ5yjRhx32WzfFqz53t/eW7U5AQer8j5Qgq9DPyy5ZvgKbgLGnLqkaFVeTd8EC5plB/ufCBVqLz8nZ+2xpRCCB1tkFtfSmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585991; c=relaxed/simple;
	bh=aOckf8npwbeO73onf1zvZsoS3mECBJj89vWb1uXTPPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAhbfpZbRydtW8xTJVYgo1Zf7kawuoeUyYo5CP4FDv4nJU5saqvl3PiUNinWvYKfGVesyvRq4FmOFor6+CLphXl+J8cXbxHkZyvjpn/D7ADcthyXfj+L8afM3lQbyWXFYN/UruE7GtJWFadBy2o5YS8jo73v+g/Pq10slBG2vog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=afIc284D; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="afIc284D"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-69629b4ae2bso36451046d6.3
        for <iommu@lists.linux.dev>; Mon, 08 Apr 2024 07:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1712585988; x=1713190788; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8/gkgj06mHoGEBTKOjzdrcRyFw1djs3fy2Wv1GZpCOs=;
        b=afIc284DqChhxMLJWJoBAreDJzaa+LJl8Bp+hl7kJmTAfu2KDxyYo7wNknCfA/htST
         OyB2nsOjWv5NhkDfaPggtQWOr45HF4px+gcaok+mAlA25Rbl7TQo3X0AIB8iQJnmaeg0
         szCnthj5U13EaAmA0NuB5b/MkuUYMHVxMa5u9asvndS7QZ8GhwteEb0EoaBjPLiiwtZt
         Q+bO+vIR7q0COP8I6/P5N18AjgthBpG50EjNvv/YA2y+7a6+XqIUaO8fYKMK9xAmDC4k
         HUdLwvvCuSVwL119ZT0eESN/miHiGMgc6AdAeGO/jmQqtutLh0oQaVi9fUhjY1PGyKkN
         xNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712585988; x=1713190788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/gkgj06mHoGEBTKOjzdrcRyFw1djs3fy2Wv1GZpCOs=;
        b=tRLmaOPqlXGqK7zcMgQCxA9D3WBiw2jdO6m2kcVs1awqP1TvH1lkFca2xWbpFsS6ne
         hbiHiZXNMsFlTflatUTQCmc6y+XjAHlfovu1HugWVCcS3KRsf9ML4rB5SGllPCBuHzfH
         uUiJ7C3J6nVbdQ5ZkHXd4sI4iXsFhwWKgww9CGFe6jH/iHR2El7fxBdpp6VkcJgJDUQ1
         /eKUlqrSK0ug4FkD+Z5jU1nd7QBHRAoxTsAQNTjO2w7tUiJaY5x45UhMrdbo7nvScgTL
         264AbZ8mupfWodslCIbXFTPTdoYJO21MbHqhFgcVMfcOfnnnG2lrZiEEI+LiUO3vpXof
         Q5hA==
X-Forwarded-Encrypted: i=1; AJvYcCWXBFcsk4sbNqz7jClWCkxgx27t9YUOcytdiQk6iKANtLSQYZYp5drEoOIEN+K8Sb8Cp/6fFYX1f7opbQU/pDadStYRuAM=
X-Gm-Message-State: AOJu0YwZJ1O/PBLwsAqg2Ijefpg6iBnayEAsS5S7Id8cDe2bzWJLKc63
	DYsTaOlWvDVMLWQbpJkCMaSnyLTvH5wQhqZ2IP+PHveRLmv+4E1VBew+LL36Jkw=
X-Google-Smtp-Source: AGHT+IE8Gxhq268X4xisT4dmVwJbupLs0jwAwPMQeWGGRMXB87HiENKFwyhJYlQDe1J23nu23fbpaw==
X-Received: by 2002:ad4:5763:0:b0:696:9df4:58e5 with SMTP id r3-20020ad45763000000b006969df458e5mr10787694qvx.1.1712585988440;
        Mon, 08 Apr 2024 07:19:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id p4-20020a0cf684000000b0069b215adb5csm410376qvn.25.2024.04.08.07.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 07:19:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rtpqc-005GwN-7j;
	Mon, 08 Apr 2024 11:19:46 -0300
Date: Mon, 8 Apr 2024 11:19:46 -0300
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
Subject: Re: [PATCH v4 2/9] iommu: Replace sva_iommu with iommu_attach_handle
Message-ID: <20240408141946.GB223006@ziepe.ca>
References: <20240403011519.78512-1-baolu.lu@linux.intel.com>
 <20240403011519.78512-3-baolu.lu@linux.intel.com>
 <20240403115913.GC1363414@ziepe.ca>
 <e3f526e3-6474-49ff-b8d6-995aaf1c1830@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3f526e3-6474-49ff-b8d6-995aaf1c1830@linux.intel.com>

On Sat, Apr 06, 2024 at 02:09:34PM +0800, Baolu Lu wrote:
> On 4/3/24 7:59 PM, Jason Gunthorpe wrote:
> > On Wed, Apr 03, 2024 at 09:15:12AM +0800, Lu Baolu wrote:
> > > +	/* A bond already exists, just take a reference`. */
> > > +	handle = iommu_attach_handle_get(group, iommu_mm->pasid);
> > > +	if (handle) {
> > > +		mutex_unlock(&iommu_sva_lock);
> > > +		return handle;
> > >   	}
> > At least in this context this is not enough we need to ensure that the
> > domain on the PASID is actually an SVA domain and it was installed by
> > this mechanism, not an iommufd domain for instance.
> > 
> > ie you probably need a type field in the iommu_attach_handle to tell
> > what the priv is.
> > 
> > Otherwise this seems like a great idea!
> 
> Yes, you are right. For the SVA case, I will add the following changes.
> The IOMMUFD path will also need such enhancement. I will update it in
> the next version.

The only use for this is the PRI callbacks right? Maybe instead of
adding a handle type let's just check domain->iopf_handler  ?

Ie SVA will pass &ommu_sva_iopf_handler as its "type"

Jason
