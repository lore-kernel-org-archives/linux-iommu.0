Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73678481A3
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 18:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723745677; cv=none; b=B6M4cKjO1RlqpZoGsWvv5AhEL1li4ZsH23zgrYbYA7RJVcZVzrpItTFaX2py7HFZjC/+qS0amYD29ErLgZv3AZ+qqTFNHvbwMRztf/rbPgvuCDXg1ZIkniABrqtx6G0Gxmd2DeZtBYgkfDhTgyN5IiWg6uuSgZGUpgvkaaZejaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723745677; c=relaxed/simple;
	bh=gPyi0Ft7Zk4LM+lvCd5TY8m0D0voFGUJ7xPDd0k61ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbNmBREElr2gbfLHXDbiNh24oVqG2uT1W6iCcOg3S6VVk1YHtJlwKumRi0VO3GT6QqcTKg8Mh+rVR3PZqtULDxtXfsli0cD9JUkMIIe4bt1g7WOzsBI2sv3yQH9GbVpkTe7v7A9xHFnWCEwL5aw4fGeCHRu5kI8esRoDvhykQaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OjQjdTFD; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OjQjdTFD"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-202018541afso12895ad.1
        for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 11:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723745675; x=1724350475; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nehYUibFeoZTeuosLsdIIbOM4kAZsfXRAjU8jbFhtZQ=;
        b=OjQjdTFDBSxaZRBTwoVhAdMwhE53E6E4ZK3ZYUFDruX1zlG99CIN+8MgCCf8rRLTPq
         C5805NR0FtUAHbTzwuc682uyQkjJzbEA5GYXq2e0AsPnUKtfPtay0weXwhP6nZ+zaDJi
         A/jmOsZEaE8dR7/ESmVYYudJGSy8MGEDixC8pKoOC7VDLZoFFNEUwywlX5uuEtBeTpO4
         hrhiEY7sc0uQOfhSv0f54VvRIZAbciSyS5J+aAXx6PnZgxbwNkXzcd947tT+JGgIgLzQ
         PwsutOFTdY7MZnMfWgs+Kx3pKjfbpST5VSNB9UjJErcA1r5GCeIyyOZLYNCa2ea94Tgd
         zlkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723745675; x=1724350475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nehYUibFeoZTeuosLsdIIbOM4kAZsfXRAjU8jbFhtZQ=;
        b=AeB7JlHt8VvRbG4pCuj6++/wHD6+XvXQfAQmBj/LxpYGX0vC4Fif/m9Rd7Z/kHP5Mt
         aw1qop5X8C8QmGdQFiolzJGiCJafb/ow3Gd6Uxch9GTS1DldqliIRHsmMwOVunu2dHHU
         X3Oh0N0utovt2ORyEijx9G4+aLgWeqNB/6D/odLF/pf2FJ+b1UTXyHana38yli4n1qBb
         HejKd+ANkm9zg216dfCJ2kce95lM4brsQecLLzjKscWfluMuqZF1vqjYB7iaBam1pqiI
         ki0j52vlLA5UmbVlcAtiDF0ak7gAOfUEfKT7E7nqe1IZQQbvutPB8uH6XKpyIGLy+J8K
         WNTg==
X-Forwarded-Encrypted: i=1; AJvYcCXvaNQVZ7fmahIxawVIbwDd7yZsytE8zI9uxfTn5DjIpkDq/Cf4Tozb/8xySW4fQX/NN55YOomZI47j98krbD7nisslGBI=
X-Gm-Message-State: AOJu0Yw2TtCTR+7WuJ3Fed110kTAiz6aAx1tD/Ctw1bMe8OkUgCl3cha
	BnXzctGyWtOo+eTu4JcT5ILjYWoc1HzyCywIOuxX7RJawObzcPWOB4bMWRH8cw==
X-Google-Smtp-Source: AGHT+IEF5wpUZERMXDkhOozKyBqICYJOXHyqTp+LYNCJJmvbvl46EGAMmsT81C3QCNQCILtyNN1eYA==
X-Received: by 2002:a17:902:e80b:b0:1e0:c571:d652 with SMTP id d9443c01a7336-202061fc369mr70605ad.1.1723745675292;
        Thu, 15 Aug 2024 11:14:35 -0700 (PDT)
Received: from google.com (202.141.197.35.bc.googleusercontent.com. [35.197.141.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef44d6sm1272562b3a.130.2024.08.15.11.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 11:14:34 -0700 (PDT)
Date: Thu, 15 Aug 2024 18:14:26 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Will Deacon <will@kernel.org>, Mostafa Saleh <smostafa@google.com>,
	iommu@lists.linux.dev, Kunkun Jiang <jiangkunkun@huawei.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2] iommu: Handle iommu faults for a bad iopf setup
Message-ID: <Zr5Fgl3v_sp8Ei0g@google.com>
References: <20240815124602.65439-1-praan@google.com>
 <13778702-717d-4b7e-8ead-3ba86bfe55bd@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13778702-717d-4b7e-8ead-3ba86bfe55bd@arm.com>

On Thu, Aug 15, 2024 at 03:03:07PM +0100, Robin Murphy wrote:
> On 15/08/2024 1:46 pm, Pranjal Shrivastava wrote:
> [...]> @@ -155,22 +208,37 @@ static struct iopf_group
> *iopf_group_alloc(struct iommu_fault_param *iopf_param,
> >    * hardware has been set to block the page faults) and the pending page faults
> >    * have been flushed.
> >    */
> > -void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
> > +int iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
> >   {
> > +	struct iommu_attach_handle *attach_handle;
> >   	struct iommu_fault *fault = &evt->fault;
> >   	struct iommu_fault_param *iopf_param;
> >   	struct iopf_group abort_group = {};
> >   	struct iopf_group *group;
> > +	int ret = 0;
> > +	attach_handle = find_fault_handler(dev, evt);
> > +	if (!attach_handle) {
> > +		ret = -EINVAL;
> > +		goto err_bad_iopf;
> > +	}
> > +
> > +	/*
> > +	 * Something has gone wrong if a fault capable domain is attached but no
> > +	 * iopf_param is setup
> > +	 */
> >   	iopf_param = iopf_get_dev_fault_param(dev);
> > -	if (WARN_ON(!iopf_param))
> > -		return;
> > +	if (WARN_ON(!iopf_param)) {
> > +		ret = -EINVAL;
> > +		goto err_bad_iopf;
> 
> Nit: the err_bad_iopf path is only ever returning -EINVAL, so you could
> simply hard-code that there...
> 
> > +	}
> >   	if (!(fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE)) {
> > -		report_partial_fault(iopf_param, fault);
> > +		ret = report_partial_fault(iopf_param, fault);
> 
> ...and declare "ret" here in the one scope it's actually needed.

Sure, will refactor this in the next version. Let me also swap the
signed-off-bys and prefix with rc as suggested by Jason in v3.

> 
> Thanks,
> Robin.
> 
> >   		iopf_put_dev_fault_param(iopf_param);
> >   		/* A request that is not the last does not need to be ack'd */
> > -		return;
> > +
> > +		return ret;
> >   	}
> >   	/*

Thanks,
Pranjal
