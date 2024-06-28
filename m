Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E201111A8
	for <iommu@lists.linux.dev>; Sat, 29 Jun 2024 01:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719623513; cv=none; b=SO67cbOmIoMOtPhUAi/oxvAxbtcJRqLGbV1S5KAkDLi8fbA3NpsiaLiNELdjY2EzJ5LYstHt0Y0Bld3NPeBPNq8nQ0zYIQg72d5P7oTVy5QMg7Dx5MyuPloqO4EkzYxFUFMB5rqhwzyNcM4a6rJrzx/8MZORxATlOsE1H+UGJLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719623513; c=relaxed/simple;
	bh=4J+wv41/qTOW/XeXcWFye1zeMVG+o14N+SygBRQYWno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYD1a+Ve9GdGDs+txGsbdpSNaXtWj6Z8AJv426oNmXUpSr1GN1cLHajtoqbx4K8sGH1YVwjWCfX/4+es/j9ZIWKvpJNFPp7jBj5kIXpp9ZCTlovvhyWn5/YJCMy4+3bLE4mHVEI8FtN4WY26kya9oVvvfIfd+CYEWNtZ4u+zLiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=latB1p5v; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="latB1p5v"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d5611cdc52so574574b6e.0
        for <iommu@lists.linux.dev>; Fri, 28 Jun 2024 18:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1719623510; x=1720228310; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CxuCmnV0ZWEWENto9tfINCmCrw1xBxkvM+e/Do3ps+0=;
        b=latB1p5v1ZyauhC185N6NupWtXiWnhjIZEL5MGGMfsUhX80njl4XO+yJlqFRFwQ3Nx
         Unq1tD9If/5PC3f9s1m4esc5maKbV2gwPfmGMm6eKuq/D0PEEl7K8A8OpHaXAlkrnvmZ
         M8Hm0wSmHlZH9WPhuIOgVbzKn1DNL8Mql1LPGcll0yiGCu9rTYKxJzmb12HlyLG8MEj7
         oPIFmDm/osdzM6okwEWNWLJ1hGoTZpFPxJR6MEQbYMOvNcOYRULXu5o/h7JFP/4OAkBk
         AN8dDbjYykW3ZYZ4Ojs1NeQ/nAX/+JmFLaWvMX1kJY/0TY9b+LKyX7i87JrUKg0hfNGj
         b9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719623510; x=1720228310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CxuCmnV0ZWEWENto9tfINCmCrw1xBxkvM+e/Do3ps+0=;
        b=GxFfD7L4VmqlkAkZnld48arG/Hjz4HwG5Tf16Y3scihf4t8SKBPxWHz4O17Xbd4kgV
         5w/ltyXwZVLSZLk/ENkjCl08PEHzeJYpT9t0kgmqLLrqAlmfOe1uHpYx0je/gHn7GiKr
         VhHbBX44C3+Cjhq2V+AGiO0Lkg5xIBIuDPFLQp2HTPmrp5VWu+/zyZj8++E+8WPZrySS
         jPHTSHDbrNIrAnz0jO1bhx8/3Jr3e6FsE2dR8EJhMcQew1xXt8bHHQZEo5ljpUnGqJNU
         /brD+EH1KyZVi8g2APPBZH44c4As46n96jTz637jCgH26yi24a3V/ca1u5ndem3WoylB
         n7ag==
X-Forwarded-Encrypted: i=1; AJvYcCVdB9Jq99XzvpR7HwngsCke6jW4sVI1XAzIoFU3YLairo9EiVW/nD4qtnz32kz82ZEoc/Z7BUQxGNYa8T3WKXl+VJf3BfA=
X-Gm-Message-State: AOJu0YzeH+yJfJDFiAVaD/qQj/fUDIDrd0Zxd8BYrqBsnHhRPRGDrfvE
	+C8HiHxhGq31cfn23TJwezGt/DsYyKOpH25ChPIL9i/NE0z8xOl0o2iyfaZpn0Y=
X-Google-Smtp-Source: AGHT+IE5gW6TwhDu3dVXkufILwe5Riqxu4x8VUh+MyIJSeF3+uS0xeub7USzPp5b3oOGLO8VOeb/KQ==
X-Received: by 2002:a05:6808:1783:b0:3d6:7726:a4c6 with SMTP id 5614622812f47-3d67726a926mr283479b6e.10.1719623510666;
        Fri, 28 Jun 2024 18:11:50 -0700 (PDT)
Received: from ziepe.ca ([24.114.37.55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c69b53be5sm1784142a12.16.2024.06.28.18.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 18:11:50 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sNJqL-0004ne-OK;
	Fri, 28 Jun 2024 19:13:21 -0300
Date: Fri, 28 Jun 2024 19:13:21 -0300
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
Subject: Re: [PATCH v7 08/10] iommufd: Associate fault object with
 iommufd_hw_pgtable
Message-ID: <Zn81gdjwJBfjXekJ@ziepe.ca>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
 <20240616061155.169343-9-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616061155.169343-9-baolu.lu@linux.intel.com>

On Sun, Jun 16, 2024 at 02:11:53PM +0800, Lu Baolu wrote:

> @@ -308,13 +315,29 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
>  		goto out_put_pt;
>  	}
>  
> +	if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID) {
> +		struct iommufd_fault *fault;
> +
> +		fault = iommufd_get_fault(ucmd, cmd->fault_id);
> +		if (IS_ERR(fault)) {
> +			rc = PTR_ERR(fault);
> +			goto out_hwpt;
> +		}
> +		hwpt->fault = fault;
> +		hwpt->domain->iopf_handler = iommufd_fault_iopf_handler;
> +		hwpt->domain->fault_data = hwpt;

This is not the right refcounting for a longterm reference... The PT
above shows the pattern:

	pt_obj = iommufd_get_object(ucmd->ictx, cmd->pt_id, IOMMUFD_OBJ_ANY);
	hwpt_paging = iommufd_hwpt_paging_alloc()
            	refcount_inc(&ioas->obj.users);

	iommufd_put_object(ucmd->ictx, pt_obj);

Which is to say you need to incr users and then do the put object. And
iommufd_object_abort_and_destroy() will always destroy the ref on the
fault if the fault is non-null so the error handling will double free.

fail_nth is intended to catch this, but you have to add enough inputs
to cover the new cases when you add them, it seems like that is
missing in this series. ie add a fault object and hwpt alloc to a
fail_nth test and see we execute the iommufd_ucmd_respond() failure
path.

--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -14,7 +14,7 @@ static void __iommufd_hwpt_destroy(struct iommufd_hw_pagetable *hwpt)
                iommu_domain_free(hwpt->domain);
 
        if (hwpt->fault)
-               iommufd_put_object(hwpt->fault->ictx, &hwpt->fault->obj);
+               refcount_dec(&hwpt->fault->obj.users);
 }
 
 void iommufd_hwpt_paging_destroy(struct iommufd_object *obj)
@@ -326,18 +326,17 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
                hwpt->fault = fault;
                hwpt->domain->iopf_handler = iommufd_fault_iopf_handler;
                hwpt->domain->fault_data = hwpt;
+               refcount_inc(&fault->obj.users);
+               iommufd_put_object(ucmd->ictx, &fault->obj);
        }
 
        cmd->out_hwpt_id = hwpt->obj.id;
        rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
        if (rc)
-               goto out_put_fault;
+               goto out_hwpt;
        iommufd_object_finalize(ucmd->ictx, &hwpt->obj);
        goto out_unlock;
 
-out_put_fault:
-       if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID)
-               iommufd_put_object(ucmd->ictx, &hwpt->fault->obj);
 out_hwpt:
        iommufd_object_abort_and_destroy(ucmd->ictx, &hwpt->obj);
 out_unlock:
