Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57827481A3
	for <iommu@lists.linux.dev>; Tue,  6 Aug 2024 17:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722965554; cv=none; b=AWbluBW9RHgBGPHHQkwgd9a+16wR+4y8kDwQkmofASEGZMuX4ms3ef2hZkMU1HWlw05LJAtlu3tYUwGYTn5cU6n7wfPisfWHyIBBjxMjBdPTpp8tBriOrGwArEGTQ+PDhSh2vpqI2UdwBJzEIqWkvSMBLx9RI0+REvj8D+c2Wbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722965554; c=relaxed/simple;
	bh=4l5Vwuhp50bBsWgAx2i5YXP7frWgFa5SeyD6OW1tjXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukynuBiTC2kt5cGAX6L1gOBRtI7lcLZErCCI9lhcbpmdGNhqEKudJ0qm9rQmit6yZ6fI7PY4k1Cktb8ihvi3cfF5q8Bi0cRng6HIbsBa+w8uZgSUpY5Z9JsawRg1Qa9nUuRIZ1xFVQLEV9Urw5rBLehLQeMsrJP4ugyyL+At0b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gE8j/PHR; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gE8j/PHR"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a1e0ff6871so56490985a.2
        for <iommu@lists.linux.dev>; Tue, 06 Aug 2024 10:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1722965551; x=1723570351; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sJ49aS7/Ro92dIdDrQN5v4G9eqn5rAWn+7tUJbURFnE=;
        b=gE8j/PHRsXP0WI101Asqn1XvAU6dkX75NCmHPeiTPI6FQu5h4cwW4niPTwdPi13xAj
         gOmkgigxFEkuNY+3sMkg5S/e859lF9HZO6KOP+7r9JgGxU93y06VEC5V7exAUH8x/L3R
         8rrdBcVUp648us62B2A7vv+NO9UKGMZpLrrWVCrloN59upxRC2tYJVIGrJplGgS9tLBM
         PJCJ7t3D0CLjoiq5NqMWD53ahh8fCE7oHkphtJDkO1rWB80KZTCKvun9lFisV7RDhN2o
         9s1VnRAjjhKAnB9H8Wc80uo6phHbNd4UEVLaiYyl6JQwUwMqio85Ufepb7ENd7DL38y7
         C2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722965551; x=1723570351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJ49aS7/Ro92dIdDrQN5v4G9eqn5rAWn+7tUJbURFnE=;
        b=CubRAxeZKxxpycqhQRZYmeIBKLC5qCyfZHtWGEuXPdiOYNuVKjJ8taGyk1fQ6b4O3p
         jGWmHNsKuk3tgsIo2KNiln8OEenCnvvIWZ7ZCM6EzOTaPKjylx/gxOcy4Yu4lps7dPKG
         RgYA6u9mGh2B44izjNov2l3UIU1uVc7YExOpxMtL60VgUuCVoJJpnxBiEvgRroxU1u2e
         TfRs3fr51v0S5QLWSIuOPoir9G4Htx1C/88X3xfTWdcTsHtECA2JB99kLwPPumdRvJ+Y
         Ul0DrfbAipIDjKwZ4f+qwON1UVS6P3jPQBm5w1xDklPEyWok0WhS4lLr8FbvBsdgKylG
         ZA9Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4iv4Q810keFWzZtqxgMXU6BFwS8oCftajSFO8DBqHIcMVcCVkscDxuVcBePJkyosBg4+jtyJVdm/buMRh3t8MgkX/SCg=
X-Gm-Message-State: AOJu0YxLCWZbHBJEJl2YEJyzph3Q6aVF+MMu+Qk/ZEVOZpLPI/wwYuOa
	m8cupKzvFu/IKF8pE7ELOirrI0onxB4cBmqlLZHbJIWNCzm3zu3gStv7vtJzdxw=
X-Google-Smtp-Source: AGHT+IHm2pn0QvDE1qp+9cW2mUtrUBM+bidSFl1r7ofyGPo/JgpGgxCWxSSzfv2f5kOL0PoI0EsB+w==
X-Received: by 2002:a05:620a:d82:b0:79d:6039:783c with SMTP id af79cd13be357-7a34ef457e0mr1798197985a.41.1722965551224;
        Tue, 06 Aug 2024 10:32:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f772db1sm474172785a.86.2024.08.06.10.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 10:32:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sbO2w-00Faks-Ab;
	Tue, 06 Aug 2024 14:32:30 -0300
Date: Tue, 6 Aug 2024 14:32:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com, yi.l.liu@intel.com
Subject: Re: [PATCH RFCv2] iommu: Add domain type and flag to
 domain_alloc_paging()
Message-ID: <20240806173230.GS676757@ziepe.ca>
References: <20240801144523.11803-1-vasant.hegde@amd.com>
 <8e531f39-9d14-4d3b-8a52-c2e8ca026f9e@linux.intel.com>
 <098008f7-2b3e-405a-a096-947e5df560e6@amd.com>
 <20240806123452.GE676757@ziepe.ca>
 <6b197aac-c38f-4e6e-9d32-d74e1a5b3968@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b197aac-c38f-4e6e-9d32-d74e1a5b3968@amd.com>

On Tue, Aug 06, 2024 at 08:11:19PM +0530, Vasant Hegde wrote:

> I only have issue with allocating right page table for UNMANAGED domain. In this
> case just 'dev' param is not sufficient. Ops should send some sort of indication
> that its UNMANAGED domain (like its non DMA API domain). Otherwise AMD driver
> cannot allocate right page table.

Be specific, you mean when VFIO allocates it because VFIO is almost
the exclusive user of UNMANAGED domains on x86 hardware.

> My understanding is we essentially have two modes for device passthrough.
>   1 - Existing interface where vfio driver manages page table (call
> iommu_paging_domain_alloc()). No PASID support in this mode.

>   With this RFC I am trying to solve this scenario.

Honestly I'd prefer you change VFIO type 1 to call domain_alloc_user()
instead of hacking domain_alloc_paging().

This is a lot more explicit than trying to push new meaning onto
UNMANAGED which is trying to get itself removed.

>   2 - via iommufd - It will use domain_alloc_user() ops. This is the interface
> where we want to support PASID w/ passthrough device.
> 
>    This is where you/Yi suggested to start discussing with Alex on Yi's PASID
> support series. I am running behind. I will start looking into Yi's thread soon.
> 
> Is my understanding correct?

Broadly, but I'd rather VFIO exclusively use domain_alloc_user() and
it can accomodate both cases. So add a flag to indicate if PASID
should be enabled.

It makes sense to me that type 1 would just always disable PASID
support, it should just be done explicitly without the word
"UNMANAGED".

Jason
