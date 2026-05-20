Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B663403F3
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 19:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779306892; cv=none; b=dE3b4P3xiT4SnbayzuR0uyPolgMPr+6Ju7GRBmUalVaGTenH+r5HQ4AMmA8nNjvufn+6pPIiSOM8RPHdQ9S8Mbef6XEzbakoxhB8ivI2XARt0N0yzUYblizUTVSv3AxZFqIoh2zRmpbf6sgAQ6i1VTwnre0F9XTLAWeNBX/2SW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779306892; c=relaxed/simple;
	bh=DwoLvHtBsMr6cFX0X2XMLQenBS2lTQpE+ExMxyFn8EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ga9rbQi3dnSyeu8xiCdVWkdDKnZKPOOxmFbDyk856Txy9YV8VM1yFO6gY3hmrVu28Yi213KDY0Vm+N6KAq4UdVUz+aaS9RV6OmgwjAs2ajsYgonXTdZXLIdaWUkaTwHnE3Rck+g0diAJcw+/QLJ/+dCG/sdkqPlbTx3k218f8+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dNQag2Tw; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dNQag2Tw"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso1675ad.0
        for <iommu@lists.linux.dev>; Wed, 20 May 2026 12:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779306890; x=1779911690; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=odGUqTyiw+s+ktOv1sVN6kVyJPFqIH1UoIVnjwejXQY=;
        b=dNQag2Tw4086dwdnZCjyT5vaUdFMOfS2newPR2fLvCzXyYqNW6GXu3Wuh2i6aqsRBm
         avGKCJYyHue9UNulsxkOr1T5IVPmL/hAsA7VjTJDZQ25dqdApJteyqCCebTJBsKN3NaC
         Z7Ggss7mgB+JOY9CV5jk6nL/AmsslMMn9bSoThUuHJu1TWEkdLIEQVMqKWE8s8oCNA+S
         TpLOX08V9ry5srTi+byOJ0h4nuY2f51d8+rL2PE5c00L3ts3x4VgNtK2KR2pMW3SiECM
         VKf0r2MJfS2v/1nBNe5uWTNAxXVp2U1HRJaOPxxlqtyb7Av7MNUwsjK5hyIJEU+qFSyf
         TSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779306890; x=1779911690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odGUqTyiw+s+ktOv1sVN6kVyJPFqIH1UoIVnjwejXQY=;
        b=L6WM+26BCRA+JX1t1EMPITHH4323Dda798fGAj3b5Mno9RFWiCCS41dueY+Q/eJ2n2
         NAocugtT79vaKxgZ9nE+GLc6chONL0gDHj6ghP27luSN6p5zvqLAD/8PXG4w1IYcNZYh
         abYtDC4UWQmY0IAQSvz54kqRznbd6Ug8I7Tz/wVVMsQVD96P9YjJW7FjDf+buMnmog6j
         T54kYz9w4XsxhpxH45DTWLpzqdytv/X4Xu03gRyOHdbfWwRE8uX9ZIgBHiNDCOe3ipZJ
         fhl60h8iiIs/lCqIVfYq0RHD6+PXwPofB2zLe0QjvWJ3XmpfFp5IuQ5sm9cjhFhkHj3C
         yf5g==
X-Forwarded-Encrypted: i=1; AFNElJ/rWnnQisgd1ixDEPCpdjQ51z2Yd3BOoktHE0KfhvjINcvYQwBCKnkJnkp7kc9uHO0+9i1VUQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMBsvIVEms1zX1mtFs94H2PGUQVp36HTVNoNUcdyebbAavoCG8
	pAlt2fPWl55rYhn4gXdnk1IHfoLXYAES5qzjnHM7skjYZn8WttN4BD9Hax8uxoIYWg==
X-Gm-Gg: Acq92OG0jyk13zPtxHdwZ5cGukXn/NvdRU/cCXQwE0zIZyJwNxD0HwYT5DY79fAGZRP
	2i+ZK6k93GfP85u5SWa5WenUIl62jO6ZaxvS0SDn4pbML0a4FHZrKFHjHNVaeYTPa3orsExDOSc
	CjbDxBp6tiyTSEltUaZeqjjqAQjFMJTWT5LrGR3vxKBc06qvt4iPjSOVUNdHpMddYCBHWEINx/v
	HY9C4niFiWTf0YwRh5IeNs1Dkrvhv0P/OyNIFWHUtMj0OxrxSLro5yA16JfC91+XvEpwKgmSrFp
	L14TLFxu1lwAsbE5N/I31VpO4Pn+baS9EIkmYuCDBHBZrRRyy+VrCcY/CpONtUA8GwieM1H/b9C
	DZ4NmgR4A3MY+IsmGx4Kv0+zh+XTpXNbhzMWQOU7EfVGK3uUG1oYDnxzB0K2aV901BkqXYUZ5qK
	IbFxO5T7SwVtJlKeHN3eket8Ds09piGPp9akDzFDCWK7JL53kpQQWF/jPysfJMd09stB3FIfO3I
	Md4Db8y
X-Received: by 2002:a17:903:1a84:b0:2bd:6dad:7ccd with SMTP id d9443c01a7336-2be9f6f3fb7mr619555ad.25.1779306889241;
        Wed, 20 May 2026 12:54:49 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a3f4ddc23sm206344a91.15.2026.05.20.12.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 12:54:48 -0700 (PDT)
Date: Wed, 20 May 2026 19:54:45 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 15/16] vfio/pci: Preserve the iommufd state of the
 vfio cdev
Message-ID: <ag4RchzcJkIlRbbR@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-16-skhawaja@google.com>
 <ag0HBChHOn_czixb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ag0HBChHOn_czixb@google.com>

On Wed, May 20, 2026 at 12:57:40AM +0000, Pranjal Shrivastava wrote:
>On Mon, Apr 27, 2026 at 05:56:32PM +0000, Samiullah Khawaja wrote:
>> If the vfio cdev is attached to an iommufd, preserve the state of the
>> attached iommufd also. Basically preserve the iommu specific state of
>> the device and also the attach iommu HW unit.
>>
>> Once the device and its iommufd attachment is preserved, it cannot be
>> detached or attached to another IOAS until it is unpreserved.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  drivers/vfio/device_cdev.c             | 10 ++++++++
>>  drivers/vfio/pci/vfio_pci_liveupdate.c | 33 +++++++++++++++++++++++++-
>>  2 files changed, 42 insertions(+), 1 deletion(-)
>>
>
>[...]
>
>> diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
>> index 976ef17e6103..b56d80379ffc 100644
>> --- a/drivers/vfio/pci/vfio_pci_liveupdate.c
>> +++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
>> @@ -108,10 +108,13 @@
>>  #include <linux/kho/abi/vfio_pci.h>
>>  #include <linux/liveupdate.h>
>>  #include <linux/errno.h>
>> +#include <linux/iommufd.h>
>>  #include <linux/vfio.h>
>>
>>  #include "vfio_pci_priv.h"
>>
>> +MODULE_IMPORT_NS("IOMMUFD");
>> +
>>  static bool vfio_pci_liveupdate_can_preserve(struct liveupdate_file_handler *handler,
>>  					     struct file *file)
>>  {
>> @@ -153,9 +156,26 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
>>  	vdev = container_of(device, struct vfio_pci_core_device, vdev);
>>  	pdev = vdev->pdev;
>>
>> +#ifdef CONFIG_IOMMU_LIVEUPDATE
>> +	/* If iommufd is attached, preserve the underlying domain */
>> +	mutex_lock(&device->dev_set->lock);
>> +	if (device->iommufd_attached) {
>> +		u64 token, preserved_state;
>> +
>> +		ret = iommufd_device_preserve(args->session,
>> +					      device->iommufd_device,
>> +					      &token, &preserved_state);
>> +		if (ret) {
>> +			mutex_unlock(&device->dev_set->lock);
>> +			return ret;
>> +		}
>> +	}
>> +	mutex_unlock(&device->dev_set->lock);
>> +#endif
>> +
>>  	ret = pci_liveupdate_preserve(pdev);
>>  	if (ret)
>> -		return ret;
>> +		goto err_iommufd_unpreserve;
>
>Nit: Would we hit the WARN in patch 14 if (device->iommufd_attached) was
>false here? Should we check if (device->iommufd_attached) below before
>calling unpreserve?

Agreed. I will update this.
>
>>
>>  	ser = kho_alloc_preserve(sizeof(*ser));
>>  	if (IS_ERR(ser)) {
>> @@ -170,6 +190,9 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
>>  	args->serialized_data = virt_to_phys(ser);
>>  	return 0;
>>
>> +err_iommufd_unpreserve:
>> +	iommufd_device_unpreserve(args->session, device->iommufd_device);
>> +
>>  err_unpreserve:
>>  	pci_liveupdate_unpreserve(pdev);
>>  	return ret;
>
>With that nit:
>
>Reviewed-by: Pranjal Shrivastava <praan@google.com>
>
>Thanks,
>Praan

Thanks,
Sami
