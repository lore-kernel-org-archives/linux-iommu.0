Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A419348791
	for <iommu@lists.linux.dev>; Fri,  1 Dec 2023 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NBFmGZA2"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-77d8d1b7952so115528185a.2
        for <iommu@lists.linux.dev>; Fri, 01 Dec 2023 07:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701444300; x=1702049100; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NIctRRSn0vwGQpdvNDPNBUzRbr3mcV06BO064VqiQvE=;
        b=NBFmGZA2/DHBIoCdz2dJZC+LeKRIKNnqX2smF75vA2VfXSfyRTEDIaZMJYU2w3RUPW
         5GRlxpwcseN2pr80g6PBb7KmeOE5d8hxRCnlbHfmr7LaxMJaEmTVzIYEWbqehMQ7bGYZ
         rrU8+ys9C3o6KfbOMFimc+3cS/Ro4yewUYtVx4mXy0Jb1H+QKlqVRxSJlZOT3EiZ4jLg
         VYhCUnQ0A6pNY/Iso7r3jVURl4m71/oJB1yg9zkg05wLwOW8iLywkIZ7WfWORLphidEC
         KyPJalkOs4Sc5Jp4clYoIi2YkmGlAHSUXQXHunnsUKmQPh16cQu6wMzv0qgdGhnEv0OU
         FpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701444300; x=1702049100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIctRRSn0vwGQpdvNDPNBUzRbr3mcV06BO064VqiQvE=;
        b=gg7HU8tyM9nggxmTpJ6TgVhxBYcEs561xUwoIIzJlYHoqFV+CyR1rv7gDhlJQ8ygTZ
         0ODrq5QYLe6vqLOSeehNKApPaRGI0BBrH8t/FptkrAHV/798OThg+U1JKs6aJASzGzSa
         8SSh+/zNz13+zH1nkIbphJ0Zfod6fEi+o6/IS5IDXS1r58odzG7PXNFbLrh4mEhYLjRC
         /KbnjEYU1nRsJajj+Hl1VWJjcvEH/oOIWUXgadsjEEF/KxddPhH8AaoETrmGV83S5YFR
         P/g23wyY3vyMCzxM6bwr2ltXqoHBwd1szXDWIP6T3wfxU6/Yv1wgyunMVjgRdRMuOjBc
         KKHA==
X-Gm-Message-State: AOJu0YzI5dPTJNlhcs8lkQ6H8HRag0idaywfXdPcXVjAKljiNZ2i7qbi
	0cQZLUXkyu1WEFcQ0L1UlQEZUQ==
X-Google-Smtp-Source: AGHT+IH9aQsdojUrYLvHxO5KK9009RG0u9DrfU1zkCcGPgQMNQH05O1B5rZ99KIPwto9uIZJVs6JwQ==
X-Received: by 2002:a05:620a:6507:b0:76d:aa3b:ac9c with SMTP id qb7-20020a05620a650700b0076daa3bac9cmr30406177qkn.46.1701444300373;
        Fri, 01 Dec 2023 07:25:00 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id n17-20020a05620a295100b007676f3859fasm1572386qkp.30.2023.12.01.07.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 07:24:59 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r95Nz-006G1Y-DA;
	Fri, 01 Dec 2023 11:24:59 -0400
Date: Fri, 1 Dec 2023 11:24:59 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] iommufd: Deliver fault messages to user space
Message-ID: <20231201152459.GB1489931@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231026024930.382898-5-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026024930.382898-5-baolu.lu@linux.intel.com>

On Thu, Oct 26, 2023 at 10:49:28AM +0800, Lu Baolu wrote:

> +static ssize_t hwpt_fault_fops_write(struct file *filep,
> +				     const char __user *buf,
> +				     size_t count, loff_t *ppos)
> +{
> +	size_t response_size = sizeof(struct iommu_hwpt_page_response);
> +	struct hw_pgtable_fault *fault = filep->private_data;
> +	struct iommu_hwpt_page_response response;
> +	struct iommufd_hw_pagetable *hwpt;
> +	struct iopf_group *iter, *group;
> +	struct iommufd_device *idev;
> +	size_t done = 0;
> +	int rc = 0;
> +
> +	if (*ppos || count % response_size)
> +		return -ESPIPE;
> +
> +	mutex_lock(&fault->mutex);
> +	while (!list_empty(&fault->response) && count > done) {
> +		rc = copy_from_user(&response, buf + done, response_size);
> +		if (rc)
> +			break;
> +
> +		/* Get the device that this response targets at. */
> +		idev = container_of(iommufd_get_object(fault->ictx,
> +						       response.dev_id,
> +						       IOMMUFD_OBJ_DEVICE),
> +				    struct iommufd_device, obj);
> +		if (IS_ERR(idev)) {
> +			rc = PTR_ERR(idev);
> +			break;
> +		}

See here it might be better to have a per-fd list of outstanding
faults per-fd and then the cookie would just index that list, then you
get everything in one shot instead of having to do a xarray looking
and then a linear list search

> +static const struct file_operations hwpt_fault_fops = {
> +	.owner		= THIS_MODULE,
> +	.read		= hwpt_fault_fops_read,
> +	.write		= hwpt_fault_fops_write,
> +};

nonseekable_open() behavior should be integrated into this

> +static int hw_pagetable_get_fault_fd(struct hw_pgtable_fault *fault)
> +{
> +	struct file *filep;
> +	int fdno;
> +
> +	fdno = get_unused_fd_flags(O_CLOEXEC);
> +	if (fdno < 0)
> +		return fdno;
> +
> +	filep = anon_inode_getfile("[iommufd-pgfault]", &hwpt_fault_fops,
> +				   fault, O_RDWR);
> +	if (IS_ERR(filep)) {
> +		put_unused_fd(fdno);
> +		return PTR_ERR(filep);
> +	}
> +
> +	fd_install(fdno, filep);
> +	fault->fault_file = filep;
> +	fault->fault_fd = fdno;

fd_install must be the very last thing before returning success from a
system call because we cannot undo it.

There are other failure paths before here and the final return

Jason
