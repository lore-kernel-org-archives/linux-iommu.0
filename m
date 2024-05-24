Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA93112C475
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 14:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716560221; cv=none; b=TlVNHTTXnxfptmnrF8FFMKm8MhoUnjyfGrHX8Zo0MIpqrRp/m5b7zjDz4L4cLUY+SFxYJyfKRGRgJHT8M0WNVf7/NT82qyJOr4l7j/f718UB8z2bsTDrSlBRne+S+4YrjhVNQc1+g/EMdcoEbdKH4X8neGJn8+ykkgltIyzEvNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716560221; c=relaxed/simple;
	bh=801tCOV5OAv0DZm2X9cQ9Ugasii44hxsZOXOquLuSwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdU9N7YG7LUdbvRx0UqlHwsV8zHX2ZEJhE+veVtOgNrBDmprOxNl9fhcfWQ2r50B3BtsiAGZS3Z3f34H/ZYFAyA3taFtPq8NRV7s/8mn8rUu5R5bT83l/NuFVo2EGy+HdDzler+0Us+3pMlSQ2FRLEhp/O039apDLwEdOcd6aVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YA7cj4Sl; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YA7cj4Sl"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6ab9d9ad0c0so4669286d6.2
        for <iommu@lists.linux.dev>; Fri, 24 May 2024 07:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1716560218; x=1717165018; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=suZw9oB6HBTqRgA6OrNMLSYpruM3XqODKPk/UHtyCxE=;
        b=YA7cj4SlAdoo3EjztBUGbGfWyyl3vVeziqttAo4YaGhkTjLQWdwu6eO/t/SpcqYnqe
         ot7AQo7P5x5COoe7ieHUPZk5928G5miNXpFTM9ZhFYQzeQmxhVJH4PfH0UTAcQfnihgH
         SSk35SZOflrS+oemkqvCouvMALElMAkE83YYnGtvQzQtAAHXa3QeuM1E3oZgizAvlbal
         gd2r0CMRBtDnBJ1abI/Ea0AYWDP3YjEqlIj8YCuwhRxLSqt7VW59POZY3o3GyzxEDgVw
         V0JwuPHH4wo1lkKR/oy7bjEY7qJkfJbsSmOJS3j4UwnOi7QazCFliE9fDh4Ox1Y0V7Zb
         EOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716560218; x=1717165018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=suZw9oB6HBTqRgA6OrNMLSYpruM3XqODKPk/UHtyCxE=;
        b=Mf8XWgz4YeLXwfXx7HBtaOYLtOH3cHEDiQD9iSppRun2PVifNf1cpmvLSExZZnsvJu
         YemGf0nADaHHLZuUmDS9NWJescpfecajioKFqy1eNzxvq1SQi9KwFLcr9Iw3vCMCs/5W
         lpHFnJ9Y2sXOxuIiZF8fMiBLjVHjyllV0Z3DSx7cXuUXjmyDIVoB0hhPvv4TSO9hu6UI
         boDozL518yjxRqoeP0NM4g/Irez+kLvVRo1LBs13sN08xEeFxiZsT9jvGTv68tg6EwNw
         y6jywJHHONNi5QcVUkJuhJddUgOeDQsId4o2nGqm4uQNo9cA/0he07FM5dit/ATpW+mM
         a8rg==
X-Forwarded-Encrypted: i=1; AJvYcCWRwn3oKf+kqnPLGy5b4DSZjhKDZjfBhy2z7Fus9zCzpnDEsiQLmnjI3u1HWCBlSPjl7x3gkz8PL0Di9WmXpI7L/xrj0cg=
X-Gm-Message-State: AOJu0YxTeUjVRB7TTfv4GkZW1YfCH9gCb9rathBVvnAB9l41Hbz2+p5c
	stbV2cP9xWwVlX0JZtcl7v1+4jtHexGUP0w4KB/lmtp8eC3YhKyjnW9dA+N4MyY=
X-Google-Smtp-Source: AGHT+IGJz8qoEDJMKsE3K/mi44tccE8zp05AFCzKA8aB112w+RpaAl9TlJZS6IYNjZCyNnjlwMPUfw==
X-Received: by 2002:a05:6214:2f09:b0:6ab:86fe:514c with SMTP id 6a1803df08f44-6abcd0b1f1cmr32057116d6.38.1716560218580;
        Fri, 24 May 2024 07:16:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac070dab0dsm7645576d6.34.2024.05.24.07.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 07:16:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sAVj7-001Jqp-Hy;
	Fri, 24 May 2024 11:16:57 -0300
Date: Fri, 24 May 2024 11:16:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 5/9] iommufd: Add iommufd fault object
Message-ID: <20240524141657.GO69273@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-6-baolu.lu@linux.intel.com>
 <BN9PR11MB52769AC595B6BDA8FB4639258CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <79bacf16-dfa6-42c7-b02d-117985e38472@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79bacf16-dfa6-42c7-b02d-117985e38472@linux.intel.com>

On Mon, May 20, 2024 at 09:24:09AM +0800, Baolu Lu wrote:
> On 5/15/24 4:37 PM, Tian, Kevin wrote:
> > > +static ssize_t iommufd_fault_fops_write(struct file *filep, const char __user
> > > *buf,
> > > +					size_t count, loff_t *ppos)
> > > +{
> > > +	size_t response_size = sizeof(struct iommu_hwpt_page_response);
> > > +	struct iommufd_fault *fault = filep->private_data;
> > > +	struct iommu_hwpt_page_response response;
> > > +	struct iommufd_device *idev = NULL;
> > > +	struct iopf_group *group;
> > > +	size_t done = 0;
> > > +	int rc;
> > > +
> > > +	if (*ppos || count % response_size)
> > > +		return -ESPIPE;
> > > +
> > > +	mutex_lock(&fault->mutex);
> > > +	while (count > done) {
> > > +		rc = copy_from_user(&response, buf + done, response_size);
> > > +		if (rc)
> > > +			break;
> > > +
> > > +		if (!idev || idev->obj.id != response.dev_id)
> > > +			idev = container_of(iommufd_get_object(fault->ictx,
> > > +							       response.dev_id,
> > > +
> > > IOMMUFD_OBJ_DEVICE),
> > > +					    struct iommufd_device, obj);
> > > +		if (IS_ERR(idev))
> > > +			break;
> > > +
> > > +		group = xa_erase(&idev->faults, response.cookie);
> > > +		if (!group)
> > > +			break;
> > is 'continue' better?
> 
> If we can't find a matched iopf group here, it means userspace provided
> something wrong. The current logic is that we stop here and tell
> userspace that only part of the faults have been responded to and it
> should retry the remaining responses with the right message.

The usual fd-ish error handling here should be to return a short write
(success) and then userspace will retry with the failing entry at the
start of the buffer and collect the errno.

Jason
