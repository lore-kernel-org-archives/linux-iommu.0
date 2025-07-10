Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BDE2EFDA2
	for <iommu@lists.linux.dev>; Thu, 10 Jul 2025 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752165807; cv=none; b=WIyMpcISjb96XRSgG/liFEN6kdb2fblLI/QF2XqsdKahxMuc2nMVMTZOOoTV96DWKgzsvRU59e7atbClEyvEGuFtV9uQnJTTQfI/soRXu/cwtCaBFLCsJtIHOEfgzT7kSlPP7BF4qkTEVrlBd2pbK3aRR3l1l6w4Kb2Ekkpp2xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752165807; c=relaxed/simple;
	bh=FL1g7AAqZse2G2GgfyKga3py6hCil3qJCjBWU6lZuGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BScnswGOqCVvFW7+UVK2i4KqjGfrJ10FOSEzHjb7UhzNrAp8MFdoQjUU++1dBxYYgGrWfQZADiWJFKveVZMTBhkJbF+jjn/fUVL3Gd45YEDUz0ulTYs9mQGNyQnbHAMj3IesexNIPR/YbdCggGAbq4iwJ9yA5BdemFFO76+3kK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uuktmy9m; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uuktmy9m"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-237f18108d2so3935ad.0
        for <iommu@lists.linux.dev>; Thu, 10 Jul 2025 09:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752165804; x=1752770604; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C2eyvzlKuLCQH5Cuh9KFE8Y+QAaptwkDzMvAXLYmk8E=;
        b=uuktmy9mSpVFr6T3xSCXF1CeLiV+SJN+kefx6OEeh7yA0MCxWcS6SPYAN5H97/9pVe
         02+vBv19PtXGSvFKN9Nv1JEMpSnYhdDYpiUgoegnT68jNjRhvgyJ1wmb+cjcsX56Rly+
         6JY1LKc9mtVZcGkG/NaA8vDhVgpCw7WNTo4JGTJhUYXNp1TmXNr+DQjzxmbljoG5YxID
         q6K7qqXqJwzNlvBU5HA19vFySIkell42jO98188YrEwu0LnTh9iJ4Y65k8MQtRafmK6N
         0QhVYSHpCZW9gxNysGNPnkw2VlnI3gn4z7ijIzCKJEotbYbZpCg3GmfzRFtItR9x1/FN
         LoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752165804; x=1752770604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2eyvzlKuLCQH5Cuh9KFE8Y+QAaptwkDzMvAXLYmk8E=;
        b=MkQ+H5Y10Jmue53I8D9XrXIe89hZaIBCgUr6AtXiRJTCHf0lCKh3s5sxMBjXvyM4o3
         OfZKCoKdgXHctX+aHIyR2FrYJjuUES0YbvZapTOGVbnm+P1z9WZClUgG5N+WxVS+/xk5
         Vze3r52en0rVefSMfId1+mQwq2ajJXoIm2KaQvp9Qc0K8uWxzBzASMqtgx3KwvhWn2OQ
         1O577zb7PNsvR5UOzm4kYFIgRNy0kzWpdcZz+0HXhI3NaUim4id5yiOG88w3VhPz+jBF
         eBBHj8uuRbozddhwUqQrsgJQ7ftC8oWPQ1GqaMkL1e2UKF3Z81ygLgwi7+65O22WcEjK
         un/A==
X-Forwarded-Encrypted: i=1; AJvYcCXjY4uYZ44Ktv6D/NE8S7jcyUFaU5r22J8IEIpBdMfrHhu87jznLXc3FrUAM9w/hQQsC7suog==@lists.linux.dev
X-Gm-Message-State: AOJu0YzH/fwtuT+QwuffafNs9u+rao9lj4TnxPAhbj8ePzdVVyrkSAKT
	uBku6oZ21dmUjX4zQGV0ZIOW5Xi/h/eCGp2hk/1KuBCrmz0frZjfEgEDzo0D1utdzg==
X-Gm-Gg: ASbGncvvAuhUWP3y7fumXjvwRJEsCitK0i9QmbkS1sIvM8voMfKM/+s0JtMHmcputPT
	EmdRjdXQ1fCvAIQuzlQzeEsH56y6kR8NjFidXXhyroPjHwAScyhdkf8dUnv65rCfJwUMR9DMbDl
	T32hQVUDOlIGg9Ffe4y++TdoahYpzNOBR1f0OGBlLG38gZdC7/c9BrATzgSQwNVljuV17w1xucd
	Jq2kIMAvbCjGU6LHca6rvMQuAiBJWbb2DHReNZN7tfd11xEPWBf91BitWxmGFS9SDtdFr+lXVHQ
	QG6pf8mgNOM8jkhmiUyCdMdAMS2GNH+Eb7DhTSL9x44izQPOUluzOcMunpmlajl/ZDQM+9z3VYb
	X3TTRFQnJ7B4bMB7QNJ3O/qx7zHIcKPA=
X-Google-Smtp-Source: AGHT+IEFm5EK2K+aFRgM2luBkKYZSMINjT3NZbf79E/WEwhVEuFkFUby27jaM+gbx9d+ftRkB3XZMQ==
X-Received: by 2002:a17:902:e94c:b0:234:9fd6:9796 with SMTP id d9443c01a7336-23de43702c4mr3052595ad.19.1752165804369;
        Thu, 10 Jul 2025 09:43:24 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de435c2e3sm24897415ad.226.2025.07.10.09.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 09:43:23 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:43:14 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	corbet@lwn.net, bagasdotme@gmail.com, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, thierry.reding@gmail.com,
	vdumpa@nvidia.com, jonathanh@nvidia.com, shuah@kernel.org,
	jsnitsel@redhat.com, nathan@kernel.org, peterz@infradead.org,
	yi.l.liu@intel.com, mshavit@google.com, zhangzekun11@huawei.com,
	iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org, linux-kselftest@vger.kernel.org,
	patches@lists.linux.dev, mochs@nvidia.com, alok.a.tiwari@oracle.com,
	vasant.hegde@amd.com, dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v9 22/29] iommufd/selftest: Update hw_info coverage for
 an input data_type
Message-ID: <aG_togvop53dLSZM@google.com>
References: <cover.1752126748.git.nicolinc@nvidia.com>
 <f01a1e50cd7366f217cbf192ad0b2b79e0eb89f0.1752126748.git.nicolinc@nvidia.com>
 <aG-fZv39ci6yip3z@google.com>
 <20250710153202.GO1599700@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710153202.GO1599700@nvidia.com>

On Thu, Jul 10, 2025 at 12:32:02PM -0300, Jason Gunthorpe wrote:
> On Thu, Jul 10, 2025 at 11:09:26AM +0000, Pranjal Shrivastava wrote:
> > On Wed, Jul 09, 2025 at 10:59:14PM -0700, Nicolin Chen wrote:
> > > Test both IOMMU_HW_INFO_TYPE_DEFAULT and IOMMU_HW_INFO_TYPE_SELFTEST, and
> > > add a negative test for an unsupported type.
> > > 
> > > Also drop the unused mask in test_cmd_get_hw_capabilities() as checkpatch
> > > is complaining.
> > > 
> > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > 
> > Reviewed-by: Pranjal Shrivastava <praan@google.com>
> > 
> > Note: I see a couple of warnings while building the selftests on Jason's
> > tree, but these seem unrelated to this series:
> 
> This is fixed in v6.16-rc5
> 

Alright, this was on the `for-next` branch when the head was at:
3e2a9811f6a9cefd310cc33cab73d5435b4a4caa
iommufd: Apply the new iommufd_object_alloc_ucmd helper

But I see that on `for-rc` [1] the fixes are merged.

> Jason

Thanks
Praan

[1] https://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git/commit/?h=for-rc
