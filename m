Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644893E46F
	for <iommu@lists.linux.dev>; Fri,  1 Dec 2023 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HLB9dIkz"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-77d84f8808dso118534685a.2
        for <iommu@lists.linux.dev>; Fri, 01 Dec 2023 07:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701443647; x=1702048447; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pVJUq6suPpiRp09p/ZEgMXSUtvlWnaDkWeaaG3LqGnA=;
        b=HLB9dIkzLCzP65HdzBc6Qtht4Xxr9Zprr9ZAYyFC/WcV5X/GQuTmCH0dXEAuyn6YNJ
         tRGRXh+9UZ9hzEwHWmUAuzioV7hyLlXLmEBJPskDqLqWtXsSCU6IBR6J1flWcy4kWwwh
         iYPXsCS8bRgRDCQTU/M9+F9P4Qh1LkuEPuIS8ZBNDBHPaArI2gKDGq9w6qUVrFqO0mZG
         r5XlQTFgome1W8i0PWYUx6ZBl8HcRAV7nQoMpbSM0C3ceuwNZMDhVvEegMt5nrbqz6B3
         NhaktmPan28g6CvXcQ9hpvdOsOejFrD3AAqDZPElzJaZAFobnDQAFllJhreVPBF/O6Jr
         KV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701443647; x=1702048447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVJUq6suPpiRp09p/ZEgMXSUtvlWnaDkWeaaG3LqGnA=;
        b=uoOn912+WU7O2vLSFZcA1+R1rZIUCjFyKgUTe60N8Svwe342YWPNLYOxdBj/p5oXsf
         /9pmO+MXXym+sDDKb4je+0OsxqzepoL4drF3pIjehoVpSzJOEFejYn/WCHo40mAkx1pS
         /IUTuvE2ee7sreeeFYtpJ757PtcVPXEjQvTYOEaZM41frXcZ5zZWO9k48z6iTFTJYeIr
         QcPLWQ4H4OTM+AtY28BtH0hLKvLUJpOhzks+fbiA6hUXbxxJClyIXDv5xwk5C+X4z2jb
         gw01Ys71QLwYR9kECAuj15IkCXfGh1QuPix4si/DVs6koeqVq9iFaa4KeG9CSz1uc0X8
         Gi0A==
X-Gm-Message-State: AOJu0YxFR3UpAz8y+Lhe0QMhZym1O1ApaIAeTxnAetSKrtTVcn4u2nvI
	4aMFeNvxRghyswFrtndh8wkMIA==
X-Google-Smtp-Source: AGHT+IFojjBiYAyjB0qLsDw0/NdOZZDHh2j3CXMufmKOLt2sxpuBu/20ksASH3BMi0Fs2c9I9Tu+9Q==
X-Received: by 2002:a05:620a:1256:b0:77b:bf2e:c082 with SMTP id a22-20020a05620a125600b0077bbf2ec082mr27411255qkl.75.1701443647075;
        Fri, 01 Dec 2023 07:14:07 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id i9-20020a05620a27c900b007788c1a81b6sm1567869qkp.46.2023.12.01.07.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 07:14:06 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r95DR-006Fy6-Or;
	Fri, 01 Dec 2023 11:14:05 -0400
Date: Fri, 1 Dec 2023 11:14:05 -0400
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
Subject: Re: [PATCH v2 2/6] iommufd: Add iommu page fault uapi data
Message-ID: <20231201151405.GA1489931@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231026024930.382898-3-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026024930.382898-3-baolu.lu@linux.intel.com>

On Thu, Oct 26, 2023 at 10:49:26AM +0800, Lu Baolu wrote:

> + * @IOMMU_HWPT_ALLOC_IOPF_CAPABLE: User is capable of handling IO page faults.

This does not seem like the best name?

Probably like this given my remark in the cover letter:

--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -359,6 +359,7 @@ struct iommu_vfio_ioas {
 enum iommufd_hwpt_alloc_flags {
        IOMMU_HWPT_ALLOC_NEST_PARENT = 1 << 0,
        IOMMU_HWPT_ALLOC_DIRTY_TRACKING = 1 << 1,
+       IOMMU_HWPT_IOPFD_FD_VALID = 1 << 2,
 };
 
 /**
@@ -440,6 +441,7 @@ struct iommu_hwpt_alloc {
        __u32 data_type;
        __u32 data_len;
        __aligned_u64 data_uptr;
+       __s32 iopf_fd;
 };
 #define IOMMU_HWPT_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_ALLOC)



> @@ -679,6 +688,62 @@ struct iommu_dev_data_arm_smmuv3 {
>  	__u32 sid;
>  };
>  
> +/**
> + * struct iommu_hwpt_pgfault - iommu page fault data
> + * @size: sizeof(struct iommu_hwpt_pgfault)
> + * @flags: Combination of IOMMU_PGFAULT_FLAGS_ flags.
> + *  - PASID_VALID: @pasid field is valid
> + *  - LAST_PAGE: the last page fault in a group
> + *  - PRIV_DATA: @private_data field is valid
> + *  - RESP_NEEDS_PASID: the page response must have the same
> + *                      PASID value as the page request.
> + * @dev_id: id of the originated device
> + * @pasid: Process Address Space ID
> + * @grpid: Page Request Group Index
> + * @perm: requested page permissions (IOMMU_PGFAULT_PERM_* values)
> + * @addr: page address
> + * @private_data: device-specific private information
> + */
> +struct iommu_hwpt_pgfault {
> +	__u32 size;
> +	__u32 flags;
> +#define IOMMU_PGFAULT_FLAGS_PASID_VALID		(1 << 0)
> +#define IOMMU_PGFAULT_FLAGS_LAST_PAGE		(1 << 1)
> +#define IOMMU_PGFAULT_FLAGS_PRIV_DATA		(1 << 2)
> +#define IOMMU_PGFAULT_FLAGS_RESP_NEEDS_PASID	(1 << 3)
> +	__u32 dev_id;
> +	__u32 pasid;
> +	__u32 grpid;
> +	__u32 perm;
> +#define IOMMU_PGFAULT_PERM_READ			(1 << 0)
> +#define IOMMU_PGFAULT_PERM_WRITE		(1 << 1)
> +#define IOMMU_PGFAULT_PERM_EXEC			(1 << 2)
> +#define IOMMU_PGFAULT_PERM_PRIV			(1 << 3)
> +	__u64 addr;
> +	__u64 private_data[2];
> +};

This mixed #define is not the style, these should be in enums,
possibly with kdocs

Use __aligned_u64 also

> +
> +/**
> + * struct iommu_hwpt_response - IOMMU page fault response
> + * @size: sizeof(struct iommu_hwpt_response)
> + * @flags: Must be set to 0
> + * @hwpt_id: hwpt ID of target hardware page table for the response
> + * @dev_id: device ID of target device for the response
> + * @pasid: Process Address Space ID
> + * @grpid: Page Request Group Index
> + * @code: response code. The supported codes include:
> + *        0: Successful; 1: Response Failure; 2: Invalid Request.
> + */
> +struct iommu_hwpt_page_response {
> +	__u32 size;
> +	__u32 flags;
> +	__u32 hwpt_id;
> +	__u32 dev_id;
> +	__u32 pasid;
> +	__u32 grpid;
> +	__u32 code;
> +};

Is it OK to have the user pass in all this detailed information? Is it
a security problem if the user lies? Ie shouldn't we only ack page
faults we actually have outstanding?

IOW should iommu_hwpt_pgfault just have a 'response_cookie' generated
by the kernel that should be placed here? The kernel would keep track
of all this internal stuff?

Jason
