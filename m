Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1809127E25
	for <iommu@lists.linux.dev>; Fri, 10 May 2024 13:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715348309; cv=none; b=AFD8qAJX9w2EBCiuzT87SDzcgq87tVDarM59C6D6i7Olw1MKQGMwNgoKGgF5Nfr3O8DIwOt0vq191A7QJtIPL+LS5ZoZmv3elXVgSUTAxLIYyt2D7186t9s1lFbQdRcPXGsA4f7TS535cQJI243kXKzFo/9Ih+eP50bKPRbtiYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715348309; c=relaxed/simple;
	bh=GuvcFxhdmtaNUDGSQDu70t55Wy23Cyg3MTeGcgF4JWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7fNvLGE1Zm/UwWCNSBK6kDaha5RUkt8D5ZqdFFcaLEmK3l8vSOqzGQgB76tvqH6H1AWhuErCUKUxW9JXVR3fCKbi3ErXjZqzXmt38CZHN07CyPChvqTX+P3kAYviKgw9URgFyIVM9Nvrakg3Y08vIvJVd/jjdMw+1chDLNMBTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NXm2nsAc; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NXm2nsAc"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-792bdf626beso164552985a.1
        for <iommu@lists.linux.dev>; Fri, 10 May 2024 06:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715348306; x=1715953106; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N2TPwUYTwQy180L7Bu2zvSbEuQFm58Caq7Z0JSBbXKk=;
        b=NXm2nsAcPqvEesX/ptQiN9JesaStCzHLzmJ3zIni8flKrLjv6K9pc9zOR6BJftsVwj
         DmUDpHDXTzsktmXTzepbLgQpySoecpVvPSMVDc1sg0ZAZR7W1z0KsSmT/1cxeflhc19r
         c6vyTYsqdhriWPTRtuVmw35ANAz/CRS8F3BB9Isi8Rqn74AUbw5SvJUjThckKuEL/i9E
         YN8S+1kfoEnSOiA3eNhdJDLUuTE29WHs2FnQLvuCmrKpPAehaYDo9JS3yUzzNZUX9RV3
         3i33J7K63cQNr31btSYooRG9gKArMv6Lm/V8UQr8bbClBhjptdhrcUKrfTf6MgUBMCjG
         9K2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715348306; x=1715953106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2TPwUYTwQy180L7Bu2zvSbEuQFm58Caq7Z0JSBbXKk=;
        b=JJt0Rt1jdS8vVS+NfZl0WAy795ihLZBlqYPalmJMO7U9iCiStEofiAExcB2IFBxa+F
         aFmKHZVsDQDujrcAoAjkCeVv8dbZA1ZzwuofWH3V2OD60cNbeSXhlSdh+xMCp6rGmg78
         OyaWIXx6lPeeG12isKywx85mDvocKyjr83jxjUvSNkhSrH3UQdn2TT19lB5wERGJxnWr
         wvAWnov9yulEylTE1oaEljmrWITrAhfZDg9g/9VhfdcxWTEEBGcdJ1m2rRblMMMYZcXO
         DQkduAV7U4Esgax7bZYf+92LogfKPZdwPJP87mxLZnaOsw9rKtbx9JEjecI95YsWKlpv
         PGuw==
X-Forwarded-Encrypted: i=1; AJvYcCXkEhI3rf20/o2QTqT5TFN8FqzhixvJcpr8aINyKKqPgOCSJbr02CPoYpDENA7QdGhabLd00gQTjr+2yNq5avYRcl+g6nI=
X-Gm-Message-State: AOJu0YwF2fLrU7QOidcHcShVH3A8qH1451PQjWQi469KHDREPwL9UDrh
	ngGmdeagMIqRcZLTSoT377ybYyAiNQYTk0fVxy9D5tYhvnIc0XkPymhhCgzVOWM=
X-Google-Smtp-Source: AGHT+IH5GaGqzPheLxeZXdVies/UvcsF26XJUeHy3VXdO06NNUavLRZ+kOijshY6CSz7b+YpPsI2ug==
X-Received: by 2002:a05:620a:201c:b0:790:c67c:f53b with SMTP id af79cd13be357-792c6c59cacmr450700085a.18.1715348306561;
        Fri, 10 May 2024 06:38:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf310848sm180141585a.110.2024.05.10.06.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 06:38:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s5QS8-006Co1-94;
	Fri, 10 May 2024 10:38:24 -0300
Date: Fri, 10 May 2024 10:38:24 -0300
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
Subject: Re: [PATCH v5 3/9] iommu: Add attachment handle to struct iopf_group
Message-ID: <20240510133824.GW4718@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-4-baolu.lu@linux.intel.com>
 <20240508000454.GM4718@ziepe.ca>
 <21ffbcc7-1103-4481-af14-5ee8856b9625@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21ffbcc7-1103-4481-af14-5ee8856b9625@linux.intel.com>

On Fri, May 10, 2024 at 11:14:20AM +0800, Baolu Lu wrote:
> On 5/8/24 8:04 AM, Jason Gunthorpe wrote:
> > On Tue, Apr 30, 2024 at 10:57:04PM +0800, Lu Baolu wrote:
> > > @@ -206,8 +197,11 @@ void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
> > >   	if (group == &abort_group)
> > >   		goto err_abort;
> > > -	group->domain = get_domain_for_iopf(dev, fault);
> > > -	if (!group->domain)
> > > +	if (!(fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) ||
> > > +	    get_attach_handle_for_iopf(dev, fault->prm.pasid, group))
> > > +		get_attach_handle_for_iopf(dev, IOMMU_NO_PASID, group);
> > That seems a bit weird looking?
> 
> Agreed.
> 
> > get_attach_handle_for_iopf(dev,
> >     (fault->prm.flags &
> >     IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) ? fault->prm.pasid : IOMMU_NO_PASID,
> >     group);
> 
> The logic here is that it tries the PASID domain and if it doesn't
> exist, then tries the RID domain as well. I explained this in the commit
> message:
> 
> "
> ... if the pasid table of a device is wholly managed by user space,
> there is no domain attached to the PASID of the device ...
> "

Okay, it needs a comment in the code, and the RID fallback should be
based aroudn checking for a NESTING domain type which includes the
PASID table. (ie ARM and AMD not Intel)

We shouldn't just elevate a random PASID to the RID if it isn't
approprite..

Jason
