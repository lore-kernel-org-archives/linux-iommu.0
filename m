Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657C535EF3
	for <iommu@lists.linux.dev>; Fri,  5 Jan 2024 19:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cc0Ebb/V"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-680285e7ce8so9059466d6.0
        for <iommu@lists.linux.dev>; Fri, 05 Jan 2024 11:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1704481928; x=1705086728; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CBfLMMiu7bBqL7keej9m8IhENVvrpxr9qD/MLPmxy80=;
        b=cc0Ebb/V23mG2iVWWH15aXv0J610xfkvdjXjS/Zb7RwPrJ8UxGFrxkeFqsuejgCErd
         DJ4nd92bvqhLjHspR6vIMqwqSgh89upvZ8CuJo4nEr6qIhJj80ouRsLD2eWyvk0MKTKU
         6SMgbsoAaQrFkci+zmgULMxhNc5gOFgXDlzHcYMzl/JnY2wm5g5QbudTfUHDoJHalSPI
         d290mGuZDh8lz3NOTL36yJGx9EXR/Ff9OQOo5qg0zVLPOkQc88m/z2dv49S4n2q2m6vr
         D/QrYeygJ30ln2W8YnI+/tpMALMAyEmPh+xn2SGjMFDwwNLQJ+sbOglmWgPAvUwSsMEA
         TtrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704481928; x=1705086728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBfLMMiu7bBqL7keej9m8IhENVvrpxr9qD/MLPmxy80=;
        b=ncMab/uTr9Q36ponrCs9TrmGtnAqU1jSPWwerl/WfW8RBEOOXE9g1zwWBjYspCCYWq
         LrIhFSEl9RDBnEInaNbsMqFHeVFiZhmAaCYPKNHCARnYNz+5j0wo4v2bP7N2s+czhIYH
         zrp0yRLC9/eaoAaWXI9L95a8jG+bkUrpaiCMdUUEd/E6+kT1MMygRf1l0Ssi5E1gd1JT
         UjBxaR1r1sFpG6prU+5koTlAikljAjOg9u1uBlbDuz3BfJe9AzdksRkvvEoNFbhVnANf
         su74RCulTlLbzXthmO5XcZkvg+KVpojI+MzDcXVX3x+f4YR66xwBVE8W4wd0L9RxFNqH
         a1Bw==
X-Gm-Message-State: AOJu0YwKRVsXm2uV+5ZA+42IecXISyeOTgNeIi1bSTFpkynZiTaWND1+
	J8cJ8wgbNs1w7+r8KKbhrmrDapXovRSJ1w==
X-Google-Smtp-Source: AGHT+IHoDc3sYqXH9hSoRlgS++Ckrxgmr25UrimPIdpX3bCmP8EsInzt+5LgYEUGhdgXboGgJGNkSA==
X-Received: by 2002:a05:6214:48d:b0:680:c898:ff9d with SMTP id pt13-20020a056214048d00b00680c898ff9dmr3443625qvb.128.1704481928340;
        Fri, 05 Jan 2024 11:12:08 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id pr26-20020a056214141a00b0067a2c201c95sm824793qvb.51.2024.01.05.11.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 11:12:07 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rLpbz-001VZs-Am;
	Fri, 05 Jan 2024 15:12:07 -0400
Date: Fri, 5 Jan 2024 15:12:07 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v4 10/16] iommu/amd: Refactor helper function for setting
 / clearing GCR3
Message-ID: <20240105191207.GP50608@ziepe.ca>
References: <20231212085224.6985-1-vasant.hegde@amd.com>
 <20231212085224.6985-11-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212085224.6985-11-vasant.hegde@amd.com>

On Tue, Dec 12, 2023 at 08:52:18AM +0000, Vasant Hegde wrote:
> +static int __set_gcr3(struct iommu_dev_data *dev_data,
> +		      ioasid_t pasid, unsigned long gcr3)
> +{

IMHO you've got the ATS layering wrong here.. The ATS invalidation
should be pushed out by attach/detach functions and has to be
carefully sequenced with the ATS disable bit in the PCI control
register. I don't think you can do all of this right with things
organized like this. Indeed this looks like it over invalidates the
ATS quite a bit.

You should only need to invalidate prior to doing the enable and when
a GCR3 value is changed while ATS is turned on, which is something
that the attach op can caculate.

So, these functions should have a signature of:

(struct amd_iommu *iommu, struct struct gcr3_tbl_info *gcr3_info, ...)

[and the locking can implicitly rely on the core's group lock, don't
need more locks]

> +static int __clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
> +{
> +	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
> +	u64 *pte;
> +
> +	lockdep_assert_held(&dev_data->lock);
> +
> +	pte = __get_gcr3_pte(gcr3_info, pasid, false);
> +	if (pte == NULL)
> +		return -EINVAL;
> +
> +	*pte = 0;
> +	amd_iommu_dev_flush_pasid_all(dev_data, pasid);
> +
> +	return 0;
> +}

What is the point of clear? By the time the attach ops will want to do
clear it is already certain that a non-zero value was installed in
pasid, and this doesn't free any memory, so what is the point of
'alloc=false'?

Just do set with a 0 value?

Jason
