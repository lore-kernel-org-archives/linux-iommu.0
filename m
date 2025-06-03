Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F8E23D2B2
	for <iommu@lists.linux.dev>; Tue,  3 Jun 2025 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748963222; cv=none; b=gpK7urI19Utwlr9QYUrtwDj7aGUop37rXNwLDKnBJWitJw/AhN8T0hyQSRSugMADz+jlu1x/Vq0l5wKU3UcDgAGtHreK013cm91EysEnTY0HiZWxfazr8PQbMHEUOve80FkGO/q6UqUpeCu4tcQv/H2Af1FYtJmS/213vjduJWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748963222; c=relaxed/simple;
	bh=4IZ5oKC84SpAytK+/YroVFmKZEVsGLuTlwAkjUMiYWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ou6xtCxxR/gpWmNYR3WPKw2Tw8/nbaqaVpWUQhnm7FL4ZdTdjeJETVl2kTEedet65GOUIkaqZcJvTuGnt8YYA6fxeHI4eAEkOoUKWtK/TViUjnQwkbZ+/zu10CGUOkm/lgCpoNrxusWYRl1yrG6Q/LwB0GBYI+irApHspLhXiyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WCrYARHz; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WCrYARHz"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a43d2d5569so72019181cf.0
        for <iommu@lists.linux.dev>; Tue, 03 Jun 2025 08:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1748963219; x=1749568019; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sBcw9pAxeIim4PFbO0EsYyzCi4VNpAby8oYVEtJWvZY=;
        b=WCrYARHzfA6TfV2v6rHNoGO5uQXox9jGF1dJnY8lhV12jofZY6P4pcovUmZv9Z1QlZ
         inPR3jgLOjB3BkZIq0ZKrdpmrMtrd/UBxlxH8UT7+wT3O6/pjnthgPLwAf5D45wO+t22
         9G6/4dpj8bxS+AAoDb9Bt6ceidzU4+RiKyeGKH9f+hriwaCr4MlN7g/t7DCa7F0PoUVE
         u/SyvwhSe9YXs2Suq8klGo3yJZClHQ6LOgdINlMrbxy+uMPjZmDuxolEbYX0Nnif7838
         Pi1Dvez4KrapZ/QESrCEV7q4D9kV5Op6O3yasYANQmMyrmxBSSBqX6L4u+UfCOdAmaJ1
         3a9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748963219; x=1749568019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sBcw9pAxeIim4PFbO0EsYyzCi4VNpAby8oYVEtJWvZY=;
        b=V/azOo0r3iEELJ6OblPcxccX5klSjAZPmd9mhS9etDwRbh3PJ1Dybjsg4XTGDiYaMr
         rvjZYD1bJH/Tcx4PT8i5LbpoianhWQYrTk/554CaPp7IwI4uaLVWnaMbxh86BuTf0ryp
         8r8cVfnNuX1nWrAuhaCNAQ9voEO0C9wZSLKfzCJnGsTto7LsT8wfz0INqtiVcqIA7Yy4
         93Qrc0fvt20723294JhQalxvHWwxnpCJtzEw9R/Xo3ZVNwnkRt2LbD4R4iGN33Ox3sM0
         8Vsr0hRJprTNbjKWdN9zPSWMJZWcXUtlQ1dgc7uSdNIzegsbeHeQ5HxBNBJl1mipWyWC
         RDPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN9yyTxbF9IbFrjjCDbhHQNPY4lDlARmw/fsZbVAyrVfW98ym5W6EIyfrK62/uRJ6R1J0l/g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxDICk4rOz4OAZ4lzbapvKs4UVC6W+tRZkzsa9ehVIC8/z6OG+R
	LFmlAtVpdC6A4BAA8AtTIaD+QVBlV6bd10gUiFSq/XxOF6VsolT1hIz00wLViMOJWHY=
X-Gm-Gg: ASbGnctUthxEWi4QVNQXySEOuqbMGQd1c8Tv17wI/wcegLt0GIKcaW2WpJ2Q2VeBLDh
	dH4d+nvkDdYcx94ucEG3cj99qBGFEH4OtbRHqfxh27z+NbIUlRcZKYINprBCqWJWm2JJMQwU3Dg
	wfsNq7/mmtAvyXwOqsJvlr9Q/m4dXRWabK7LMe8nolET5hbIj4ARFte45IOPSppLvmc2R6/KaQn
	8niQjxsx8gWOiEmFu/CK9M1mHBv9XIFsf34eCfWzYQQDxbSK4c7EUhKIotpDfWgxxw7AAAW6bjD
	sTeA6k/TRXLHJiZHW5mKeImjloihSGqncPnSnqOnv61uU+x7ZIOgi46Ci2e0PTO0H7e3O4EyIEC
	QwIbV1wVbFjZSUXUPzqb1yL7FVc0=
X-Google-Smtp-Source: AGHT+IHhqCppZOqzSDLECb61u7AtZD5CcJCcyFWN2hijSJ8HSCck7H8cbHGZnWZ5+BV2Y7fY8nJzRw==
X-Received: by 2002:a05:622a:4c8c:b0:4a4:3fc0:6df5 with SMTP id d75a77b69052e-4a443dc4efcmr210075641cf.10.1748963217999;
        Tue, 03 Jun 2025 08:06:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a435a8435esm74774761cf.78.2025.06.03.08.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 08:06:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uMTE9-00000001ipJ-03XW;
	Tue, 03 Jun 2025 12:06:57 -0300
Date: Tue, 3 Jun 2025 12:06:56 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Wei Wang <wei.w.wang@intel.com>
Cc: baolu.lu@linux.intel.com, kevin.tian@intel.com, yi.l.liu@intel.com,
	dwmw2@infradead.org, jroedel@suse.de, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v1] iommu/vt-d: Remove dead code in
 intel_iommu_domain_alloc_paging_flags()
Message-ID: <20250603150656.GA407166@ziepe.ca>
References: <20250530091325.694456-1-wei.w.wang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530091325.694456-1-wei.w.wang@intel.com>

On Fri, May 30, 2025 at 05:13:25PM +0800, Wei Wang wrote:
> When dirty_tracking is enabled, first_stage is set to false to use the
> second stage translation table. dmar_domain->use_first_level, which is
> assigned from first_page, is guaranteed to be false when the execution
> reaches the location of the code to be removed by this patch. So the
> handling for dmar_domain->use_first_level being true there will never
> be executed.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

I noticed this too

Jason
