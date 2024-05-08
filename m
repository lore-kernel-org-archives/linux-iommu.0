Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C3AAD51
	for <iommu@lists.linux.dev>; Wed,  8 May 2024 00:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715127086; cv=none; b=k3ttEDoxw7N5dk6dSowAUeocFljhNgyPdBLSILH1VliQf/VQCms09m8MwdKJd0ns5fQRQlw7P2z1FuzNtcK106Ev+Hj6A325tVk1y1dIqc13PVaKb+2+AjBBmFChacpsD+5eSH7OI0vna3AgMywUTDDM6Lk+6QPZ8n8jJzJOYMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715127086; c=relaxed/simple;
	bh=uBM6JM2ZTgWImlBMh9qZnnFVCD7oJnWjagsz3xFxGHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNcSWRYGWV9X+p0O3jrqlyIicHuAoCxE/tYAKy9BJj0USju233PiJCZ4mkSp/LAw4u/ckIvmXt9MtgTL1GInhOIo3VQPZn9zyYV40eu89BPJamRGWSetplFbZB+AMyY3YO6v70A29tDZlt5fPo6JJHqLFMuTJUuNxZbqFdVt+r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=VFHJyDWP; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VFHJyDWP"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c97a485733so913795b6e.2
        for <iommu@lists.linux.dev>; Tue, 07 May 2024 17:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715127083; x=1715731883; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bjfjkkVg/cpW+PObSNC5kJwblm845FpifEdrDmGUGho=;
        b=VFHJyDWP4+2+l1NLaYEX57Zn9L7iEjuf1T7tf4U7EAPNYB9RdTs7hz6Ry5+dIr7tko
         gTL16srihhXtIwtoUTIM65Nauq7ZxR8X9kIY5UksSldq1DTf6iQ0Z77hY4ib/iZtewpl
         ANtkdfyNjuLzzlrDe+KNJgoKbE41KW+IiivJBTve98Vqfv/efDkkKnhZYJ8p5ABSR+0y
         +debpNV5l2rmzph3LdVn1pdBuUpCPm+xwSmwTR6QMYAVACz7W9aV7+Y7OeqC17ImMVT8
         HU6PJHzwc8exWd2CM9Mgm5aqOJOgwU/XS26/nYMeCenc3QGHbQpMmOPcj6PyCul/qO55
         QfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715127083; x=1715731883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjfjkkVg/cpW+PObSNC5kJwblm845FpifEdrDmGUGho=;
        b=OSBZe73VAI986J1z9Mg6AB3hVsD0fOFguGadUP9TQ+IL1duUf5AhH5m5jbWhgdFdM2
         Pv/cajS/6zGpoC42RrwK1qi9dJBBUGgPA94Xnd+/f3oqeDhwTOH1ZkWnluigfOXOR1GO
         K5I3YY6cEUX4/ba4UiQ27egGxN8aSb60hmqqKHbL8jVcy22MSUurl9tY6+uxfiWZpRjY
         iKMPLfV6yLP5mUuyC7yKMRUmqRCl7NHiBsz6E6an+GiJ3Ze2m/grZUttkh76mByLp7xc
         /IoofeKhjtnbM87lrEA9Q0dMpYZdDWYVEcKH/gfOBtH2lWrFBNbuB/avM5ne/T5vzJq2
         uIMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWdTGu6e7dgJPWOPe2Ot1PFYN5bzX87r00GQpjW64ZJuUwlK64cRvYn37DCOJJLWOqc1bu1uyPu4YdrrkJKOV7FuJFmxA=
X-Gm-Message-State: AOJu0Yx+G75Oug5AnPHWwsZ/Vl+dcft3QH06xf+eXx1zlabephkeGCe9
	jyl2EKJzBWnI3qkfK9r27X61JeqOQXnDmjB8JmvF8k9S3A80Xs2hoDDNMwL/c2U=
X-Google-Smtp-Source: AGHT+IG3+7w7f2p3irDmhGGNwkdvL9xcGar5FA005YCMCjPsSm14lX0tCqyBYbPWhopBlbU40pavfg==
X-Received: by 2002:a05:6808:30a6:b0:3c9:7717:713a with SMTP id 5614622812f47-3c9852fa4e6mr1310067b6e.38.1715127082991;
        Tue, 07 May 2024 17:11:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id f14-20020a0cf7ce000000b006a0e5626f67sm5081832qvo.50.2024.05.07.17.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 17:11:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s4Uu1-0004QL-RV;
	Tue, 07 May 2024 21:11:21 -0300
Date: Tue, 7 May 2024 21:11:21 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/9] iommufd: Add iommufd fault object
Message-ID: <20240508001121.GN4718@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-6-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430145710.68112-6-baolu.lu@linux.intel.com>

On Tue, Apr 30, 2024 at 10:57:06PM +0800, Lu Baolu wrote:
> diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
> index ae65e0b85d69..1a0450a83bd0 100644
> --- a/drivers/iommu/iommu-priv.h
> +++ b/drivers/iommu/iommu-priv.h
> @@ -36,6 +36,10 @@ struct iommu_attach_handle {
>  			struct device	*dev;
>  			refcount_t	users;
>  		};
> +		/* attach data for IOMMUFD */
> +		struct {
> +			void		*idev;
> +		};

We can use a proper type here, just forward declare it.

But this sequence in the other patch:

+       ret = iommu_attach_group(hwpt->domain, idev->igroup->group);
+       if (ret) {
+               iommufd_fault_iopf_disable(idev);
+               return ret;
+       }
+
+       handle = iommu_attach_handle_get(idev->igroup->group, IOMMU_NO_PASID, 0);
+       handle->idev = idev;

Is why I was imagining the caller would allocate, because now we have
the issue that a fault capable domain was installed into the IOMMU
before it's handle could be fully setup, so we have a race where a
fault could come in right between those things. Then what happens?
I suppose we can retry the fault and by the time it comes back the
race should resolve. A bit ugly I suppose.

> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 83b45dce94a4..1819b28e9e6b 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -50,6 +50,7 @@ enum {
>  	IOMMUFD_CMD_HWPT_SET_DIRTY_TRACKING,
>  	IOMMUFD_CMD_HWPT_GET_DIRTY_BITMAP,
>  	IOMMUFD_CMD_HWPT_INVALIDATE,
> +	IOMMUFD_CMD_FAULT_ALLOC,
>  };

I think I'd call this a CMD_FAULT_QUEUE_ALLOC - does that make sense?

Jason
