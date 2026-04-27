Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1750126056C
	for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777298496; cv=none; b=tJhv28DV4OhnYfHW4+hTv7x1WA78eeioN0UcPuwC3KFERQqWG5qKK5cSBhrd2MqffkjeJIEUIFvagUNqGQJn7tzmEEcVVQd/Jkp6SVae6T/OHg8dYuKcITt1jz9N/i0glvfT6dT71TyxI8LGQu+x9cZIiTH0M8eh7RlvL7Prqlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777298496; c=relaxed/simple;
	bh=5PI/ao4ytbR9mycyoVEGfWKOdOA/DliBZUhadzk03gY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7/60OOXgJZDtSK9oOFSmvEDHq9od7C2qWD/mvzg+LmZhnlIlruON+RYRt94n8idfzaHbrcsHWqYYowh7LC3OwG/BPCU5TzTH1VVOD55bKWtx5l4RBaAdF8OlYbgsY6OH/hDCg4GOUbEGQ+RedoUXxetIyozUvdo3BApQFGy1UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dfInEJzc; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dfInEJzc"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-67e09232daeso6220024eaf.2
        for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 07:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777298494; x=1777903294; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lgUNKfNY8+yoJgK0OqFgiPxqaEoZN1l+NcbbBxRWsEs=;
        b=dfInEJzcgKPs67a9zd7uJ8bk7vn8r3WNKy+bN8YMyJSQf38d8yi/VB9spa9PtN2iak
         SnSwlNj2x0j4ONEYYMUCo2uxE1ZanNo13KkAd6RJqb9u/lpn2i3QeFSp4MgKr6ZhzxYF
         P9m1MzxGfgDuKttdDwRb2TmPifs1k93DV9i4qgxyorJ144mkRBo0uq9QarbEAdWSk8rG
         RGkPxycJvwOqNvdg2MKGGu19r4lt9Ang8zHF6NZIF/a0+T6limi82LjGvDUM6BNG1nxP
         ogu29cOmPskWkh2HDfP2bs6fDGprtwSz35teK1+6/W/8oKRPqzXL652wPO/B0MwOvr8T
         0FEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777298494; x=1777903294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgUNKfNY8+yoJgK0OqFgiPxqaEoZN1l+NcbbBxRWsEs=;
        b=X8ijViWuIi1a/pV+4bGopisgrZsUzW1CIUpUkAqKlhn560wNcDqiJjSOfWVPBWxo2I
         xav1Dth8Quk3mDvaAyvHVJKfc1S4+bhyuzTPmW6/A8EZYZSgIFerpaL8a3UHWw6kpYPw
         UaV7wgtEo1zyaJegA1zv1F033jC5a3tiq+g8qYb1VZp74fw7Q7moCPyk3hi0gVlulAhP
         Qsk08qOrvBRvbzQJBmsS6f8cxjlGTan4l5aeHyBvgnMIZ9gVsoejjwE7pjBUpJKQSi96
         r7G4uU94y04tK8VLTj+fMJzyDZuePm9g+VFgaf+qD6EFKXL9EwZhTJLXqQi6m83IpTOn
         Y5zg==
X-Forwarded-Encrypted: i=1; AFNElJ8LvX7zLI4/ywfi2unHepoRqn9iI/0ZEvhXGJDc9GBpP71MRdzH9ZMCV+sB46WVsbs9KalgwA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwICgWzBmlm125QVQf/QgUQ09d2+ZUFrviMm1MDJcRB0Rf78duc
	vVIj4/rSCVzi2gvW3XgZihr6RluyxEsnoOWx7BTFFoQ/QdMJdrr4lHIUD+7vr7kc5Rg=
X-Gm-Gg: AeBDieua8JQWag1GlqQ2N3c7bpb0P4scKa3vqTF70Wuk3QPOVil4LG8aiUeij3l2PAc
	UngqoVDvt3KUGOuxSgl3hE9OZsmT8w+h5n+E0eZPCCD079fDdZuwMUXzlwQiR3QvAtJQ1v5CbPm
	RJbxd6ZyCkcCrTSBBmznrzXUwaBMlVsv5O7sIFMzgfiYI3xxZZRHAprwgJEeGnAv2o3mPc3aKKz
	mCTKrbqEKJl2eiaYLMUN3FU1vb5dcQbokieZ283r4G6EsbWn+9eDMqHHkJrpJfA/lbekR/qoKqm
	apk6cJPE6m3cpbGqWfN82ZcikprjH04mXKZQ9xLzMr2HRwDeMd7VIL3OoU8okJlQcmJIkoneKJT
	oJQmSNs5i0ZVfXQOv2IDz7IUEvCPL6ClFYQDBUVV0OqyKd03jWYxXz3tBkYQOSHsRY/NJLZPcYG
	WghxNRpWguWWcwc4sW94diQcgqLGg9Uj1TrGK5s7QUE1B3WwEH0p5pEa2waWUhxTE2nF88fEmla
	6k6iOgfjOnWJPgeW4RewvRmi0Q=
X-Received: by 2002:a05:6820:1904:b0:685:3561:8926 with SMTP id 006d021491bc7-69462f07de2mr22724093eaf.45.1777298493949;
        Mon, 27 Apr 2026 07:01:33 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e61c191basm249642351cf.16.2026.04.27.07.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 07:01:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wHMWh-00000003XIx-3yuA;
	Mon, 27 Apr 2026 11:01:31 -0300
Date: Mon, 27 Apr 2026 11:01:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v4 1/4] iommufd/device: Associate a kvm pointer to
 iommufd_device
Message-ID: <20260427140131.GC740385@ziepe.ca>
References: <20260427061005.901854-1-aneesh.kumar@kernel.org>
 <20260427061005.901854-2-aneesh.kumar@kernel.org>
 <f5f2bd86-4cde-4efe-b824-d9f1c82357ac@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5f2bd86-4cde-4efe-b824-d9f1c82357ac@linux.intel.com>

On Mon, Apr 27, 2026 at 05:07:52PM +0800, Baolu Lu wrote:
> iommufd_device_unbind() is an asynchronous teardown operation. Is it
> possible for idev->kvm to persist or be accessed within the iommufd
> subsystem after iommufd_device_unbind() has returned? Should we add the
> change below to prevent this potential UAF case?
>
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 170a7005f0bc..dac39cb5e7cc 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -333,6 +333,7 @@ EXPORT_SYMBOL_NS_GPL(iommufd_ctx_has_group, "IOMMUFD");
>   */
>  void iommufd_device_unbind(struct iommufd_device *idev)
>  {
> +       idev->kvm = NULL;
>         iommufd_object_destroy_user(idev->ictx, &idev->obj);
>  }
>  EXPORT_SYMBOL_NS_GPL(iommufd_device_unbind, "IOMMUFD");

iommufd_object_destroy_user() frees the memory of idev, it is not
useful to null before free.

Jason
