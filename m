Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2667C178CE2
	for <iommu@lists.linux.dev>; Wed, 12 Jun 2024 13:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718198643; cv=none; b=S4kgcsmaG32dH1ZlOfXnkLgTS/ObKeC/iopRvFvvmO18ze31WUuuTXpVzUPESCmoYVc7KGVAIjEmWLdK66TslFvYBe9PdHqRxEQHmIQAzOfznyrXFjVCxNmTCD5AHBaFH7B2MsiB+hTbwvokwE49owFTugeXeXYjJ+ImJF1clNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718198643; c=relaxed/simple;
	bh=ZzY3qCMPDQaQOhhG+Cblq6ulH8qDjUPPFb/f9zNHOOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSLyX2PuNozKzpmpSKz28EIFeR+tNVQDUN84t6GacIO1T8KvU2tMteCwFbzxB9iB2N2GkEFHVyICf+inMTvt2FS7WMTMwtLSgU8QhADIZXe39KolC5/pmMG6w4VhLKEcVUfmx+IJS5qBXa+6SMz///JoGtEZTZBE1fJE1QFWzLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NT4uw6jT; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NT4uw6jT"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-43fecdecd32so36149201cf.1
        for <iommu@lists.linux.dev>; Wed, 12 Jun 2024 06:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718198641; x=1718803441; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uXrU57CQXz06V3OC089KtN6n0lzdkX95OHg+FjYAde0=;
        b=NT4uw6jT9Y6Vga+VdyyZvmqjsf7oC6/4HNLDl/W2X+bbddppKG4+uaEkPX6SIhsAr9
         roVOVHZqz+5kWrIn14JOKT5PP5KwL/THU1iXLRaUQtCEva+YD9vkkg9HYgE/x5hfDFW0
         5g6GmU6Ap3MIWplIv+jnSd+7mZpQVseD7L0AmWqH2LFaASC2eeOEnqvYor6LRvs2bQcq
         JDBOZKEmedol6/lkMOUasu52ZrcWEE9RXAQZ3IDvQ/7dYev5jytu8xfMm/iCIOTmzXix
         Wgh4m3069hPGiI9pqw+YeebwmL63dZWXoXsSIkau27bJBo3afrg+oQAlQIA6tJ2QuWNQ
         dDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718198641; x=1718803441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXrU57CQXz06V3OC089KtN6n0lzdkX95OHg+FjYAde0=;
        b=KTomo+4I7cYuryGPl4jd0rsjwT0ntKMVIOIlW4m9DcrtyIJDRg9esAIYJ7mSMAT27b
         dnI1PUh3pW1n7J++etAxDSldWHicsCDYM42k9fVvUOrervB7oDIXVFhQTPFrQm5ZYzOk
         VH9Ei6OMdF/nI4JaCsenNL0r+E8l7lhoPZyicRqb7jbtl7WhcD2SFlZFSxnPOh2Y/VDn
         GEPqEudPRG9htYz8nmKYvYS9pJDAC80gnTgZMJDG97x+pn1uwg0vZwZFjklUd1d6BFFX
         TWKsKqQsJMl5J+I71sz55rMJ3K02uBR/l6s1yo2WavxRSYjMtQCAzAIJOxJgJWeDLytw
         l19g==
X-Forwarded-Encrypted: i=1; AJvYcCX6zVnwSCCixDoydMD+sU1O1vwB7vBM86iXI1Fgc5O2AaiTs7fB3DLaWh5HB1D5QyPyK9nDhVnIPn+UkolmtXSE8UWwYiU=
X-Gm-Message-State: AOJu0YzeTqKA5ivmSc+wRQZwP5dSlNPjn1lz0UmAZz7BeUPG2e4hjn7s
	FpNmGewP3VrL7IhQ8G7RjMXcNd6CUaDMjScg6OLw5uJ0mtTe45hOfdwgE1zjbCs=
X-Google-Smtp-Source: AGHT+IFCgwK6nkMac+bbLrNRTZhR+zW7VHze00Gv6obmMLZnfPVZUTNFdOzpdXn2ab5aoZ07hd2k1g==
X-Received: by 2002:ac8:7f4a:0:b0:440:1c5a:5c9b with SMTP id d75a77b69052e-4415ac0ecbcmr16496121cf.7.1718198641035;
        Wed, 12 Jun 2024 06:24:01 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4403895aa9asm55436811cf.7.2024.06.12.06.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:24:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sHNxG-008t4f-Ig;
	Wed, 12 Jun 2024 10:23:58 -0300
Date: Wed, 12 Jun 2024 10:23:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 06/10] iommufd: Add iommufd fault object
Message-ID: <20240612132358.GU791043@ziepe.ca>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-7-baolu.lu@linux.intel.com>
 <BN9PR11MB527615EC664698C340A0CA878CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527615EC664698C340A0CA878CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>

On Fri, Jun 07, 2024 at 09:17:28AM +0000, Tian, Kevin wrote:
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> > Sent: Monday, May 27, 2024 12:05 PM
> > 
> > +static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
> > +				       size_t count, loff_t *ppos)
> > +{
> > +	size_t fault_size = sizeof(struct iommu_hwpt_pgfault);
> > +	struct iommufd_fault *fault = filep->private_data;
> > +	struct iommu_hwpt_pgfault data;
> > +	struct iommufd_device *idev;
> > +	struct iopf_group *group;
> > +	struct iopf_fault *iopf;
> > +	size_t done = 0;
> > +	int rc = 0;
> > +
> > +	if (*ppos || count % fault_size)
> > +		return -ESPIPE;
> 
> the man page says:
> 
> "If count is zero, read() returns zero and has no  other  results."

The above does that? 0 % X == 0

> > +
> > +	mutex_lock(&fault->mutex);
> > +	while (!list_empty(&fault->deliver) && count > done) {
> > +		group = list_first_entry(&fault->deliver,
> > +					 struct iopf_group, node);
> > +
> > +		if (group->fault_count * fault_size > count - done)
> > +			break;
> > +
> > +		rc = xa_alloc(&fault->response, &group->cookie, group,
> > +			      xa_limit_32b, GFP_KERNEL);
> > +		if (rc)
> > +			break;
> > +
> > +		idev = to_iommufd_handle(group->attach_handle)->idev;
> > +		list_for_each_entry(iopf, &group->faults, list) {
> > +			iommufd_compose_fault_message(&iopf->fault,
> > +						      &data, idev,
> > +						      group->cookie);
> > +			rc = copy_to_user(buf + done, &data, fault_size);
> > +			if (rc) {
> 
> 'rc' should be converted to -EFAULT.

Yes


> > +				xa_erase(&fault->response, group->cookie);
> > +				break;
> > +			}
> > +			done += fault_size;
> > +		}
> > +
> > +		list_del(&group->node);
> > +	}
> > +	mutex_unlock(&fault->mutex);
> > +
> > +	return done == 0 ? rc : done;
> 
> again this doesn't match the manual:
> 
> "On error, -1 is returned, and errno is set appropriately. "
> 
> it doesn't matter whether 'done' is 0.

It is setup so that once the list_del() below happens it is guarenteed
that the system call will return a positive result so that the
list_del'd items are always returned to userspace.

If we hit any fault here on the Nth item we should still return the
prior items and ignore the fault.

If we hit a fault on the first item then we should return the fault.

Jason
