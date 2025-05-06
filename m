Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA3F217727
	for <iommu@lists.linux.dev>; Tue,  6 May 2025 17:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746552577; cv=none; b=scSRE5/y3UXqBk3uVA6m09ckUuh+sRmhqyRt1UDvD53l6+9kfeK8kUQ33DE0vaDmht0MUuZ1ife+YKMD7QcQvDSEDkv9MTUopx0USjwkEOkXeeqthmakJj2iRa+eGEobsb35IWQ0emGjY8/NcRL5uterjAl//u7hXZw/D4rvqh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746552577; c=relaxed/simple;
	bh=i4e7G7xw+wz0sgchsoY3CUzITAN56WMwZ67/B/5MgNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AiccRkFMIXIsCgGVxJlmKcSQ4fG3Yo0e1b6CEPQex3uJobV7vznQEU1AbYOl6kkk9ar4laIGFf3wkqOo5a+STJkqQY/DvojSD6zqVw4LvFAyYuSoEaRKskP/3ftK+u6oEboUqFycLw3BIajBl/8XiVc3c/L2v0QAbPuu26zGyaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=l9Y6P4/l; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="l9Y6P4/l"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c5e1b40f68so691029485a.1
        for <iommu@lists.linux.dev>; Tue, 06 May 2025 10:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1746552574; x=1747157374; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lzw/NpSpLJ013Llh+NLWNGNiT0GNflI59y1+tAq7i9w=;
        b=l9Y6P4/lKhEiiw6VG5I6mCCOsHaqNn0ofPia/CWp1lQxZE4FmSH3CD7/sa4TQUTE6g
         Ai2/GIifanL167C6A32O8idcCxqqBmNQzDBLkEvJq+Tge7tl60ETDpN1xi2Dp7dIU3mo
         /MV5UBNGDj08hvgiCgiL1wqsIc6rq0rMS+Nj7HSh/w0rd/uupP2wTbkBsqkNCBv9IDxt
         PdgBgipHxJAfeB3qajGaemx62y/4xFrXPbn5UKqmjSWBfpVEvBWQi9ZwKhZtu7IRgWKU
         l0UX5TGPhBtB+ldzskNwyxiKB+MshooETOYEiBazYTCznhlpdO0dGb0dbUVjFwz2yMQn
         FCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746552574; x=1747157374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lzw/NpSpLJ013Llh+NLWNGNiT0GNflI59y1+tAq7i9w=;
        b=PNgNysgIXwmUCosFl9V2L2nH950niBzSgXvdZ6ov45AGkka77Igau+jqvyEesOawzK
         AnZzM/sJmt74vH9InVc/LiIM2YHzC5LEBAto85GjkWeQNugDnnda0MmztcB1Pi2jVklp
         c+HlC6V4ffO+1Ax00EvTrDqZVxuk5Rg1HS/9+CD5OpiJxrd8CF8EDb/wJhHyWNvkv77t
         zBAmzth7BGNCGA6tRtWT1DGeZEJCiumOmX5SXLV+DSRz3RieVHzB+CMQKmqFoZqeIoQy
         6lYhyGUGneRtyL20UPZLkWu2WdetMVRDt2o85A7wo+L3hNOF8IUIxBqCzK3gULdJMUiF
         L+Qg==
X-Forwarded-Encrypted: i=1; AJvYcCVCWbIu65HCEXiY+9GZCMwlB/Mn5fiGGxp8uipgXm8u47S5BPjFaakWONdWnNYN8CFBZBwUTQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwlbOVMDUYl2wLeONzXKzTaEUFk9erJK4ZCIZ2vXqxrgaXqA5W0
	2FJjr3Wg/f1ppXcZlq0DJvv/AZuvpsdFPbIKA9b6fKPbdHUOQPMtgLso5EYR3NQ=
X-Gm-Gg: ASbGncvg7p7GVADBSTZbPre5Xvud4p8BYkdDMRRf2CCcJ+xDPl/gs/BRDcOaJNZGMY5
	dWXq7iVacitFvFZ1LO+Mfp3D1iQYmxRda+6mWlixIXah9BomxLDxrAHcj5JV4f308ke6WqPraWQ
	sp5pLvXiRMXWbWMdLcTo8rQdjB6xfXRVDedjbESJGO8r3E+fMNEnflWOYIusn7P8AGSXmfP8k8c
	zHvUfDUGLBEmZwDNEmxzM0ut+hbbSVbWNnE6+/0VT8CIBQJGd6DKVmSKNaXeTh1Q7QatlithSHm
	KWeNqE7vhsHvCxUR6EyYUC1vDGWb+Iqk4/NgWTPv4o+dUrRxH86WWwD9+cS+lyPFbiYhUXy2GTm
	r5CULKifC8NKHRPHga8U=
X-Google-Smtp-Source: AGHT+IHsQ8juIlpShZZzkUdMDq7xB5U8B/5m+eZbdsl8X4APoHP6XCwe0ty4ChmcMRK06w7rXiGzUA==
X-Received: by 2002:a05:620a:44c9:b0:7c9:2612:32d6 with SMTP id af79cd13be357-7caf74129demr26939485a.48.1746552574201;
        Tue, 06 May 2025 10:29:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49222f8b1c0sm121101cf.52.2025.05.06.10.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 10:29:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uCM6m-00000000LG8-3Doe;
	Tue, 06 May 2025 14:29:32 -0300
Date: Tue, 6 May 2025 14:29:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iommu/vt-d: Use ida to manage domain id
Message-ID: <20250506172932.GA33739@ziepe.ca>
References: <20250430021135.2370244-1-baolu.lu@linux.intel.com>
 <20250430021135.2370244-2-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430021135.2370244-2-baolu.lu@linux.intel.com>

On Wed, Apr 30, 2025 at 10:11:34AM +0800, Lu Baolu wrote:
> Switch the intel iommu driver to use the ida mechanism for managing domain
> IDs, replacing the previous fixed-size bitmap.
> 
> The previous approach allocated a bitmap large enough to cover the maximum
> number of domain IDs supported by the hardware, regardless of the actual
> number of domains in use. This led to unnecessary memory consumption,
> especially on systems supporting a large number of iommu units but only
> utilizing a small number of domain IDs.
> 
> The ida allocator dynamically manages the allocation and freeing of integer
> IDs, only consuming memory for the IDs that are currently in use. This
> significantly optimizes memory usage compared to the fixed-size bitmap.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> ---
>  drivers/iommu/intel/dmar.c  |  3 ++
>  drivers/iommu/intel/iommu.c | 80 ++++++++-----------------------------
>  drivers/iommu/intel/iommu.h | 19 +++++++--
>  3 files changed, 34 insertions(+), 68 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
