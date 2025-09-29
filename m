Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC602EAB66
	for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 15:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161513; cv=none; b=ucY6eZzMULorxzG2yp3TuUSUQDYdQP5KIe1maYPF39lA/81G2MxmO671UxjbOFuTByQPY3C1BttjPcx9z3zOiPSyKPLtwkws+LRbWocal4TgeRoWoO4zIkC7+d8TmUgxBsw5vrwKSRRsSb8/eKoSWFwZSs5IKzc88op9tJgguAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161513; c=relaxed/simple;
	bh=P6iSZrEA/YPYWO+UCPUFvza9CXfBeI+xdProSqT8BsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwD5Atwi56bmVUySZlMsL9z9uOZzkmfAmpID9KK/SS1YR/15qX39rvxYaNpDjDti3Q+S8Jo1H8EJF7wCnTjZVchbrrwX0jMacyYZ/VDdmWJpev50fRerjCo0Zco9DcDG+Wg/r8ITRmu6cih/ocpK9spALCPFPVe0/n+WvxCCIMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NpnXHn+y; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NpnXHn+y"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4da7a3d0402so59689441cf.0
        for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 08:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759161511; x=1759766311; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dxJ0qKWOx+cSASEP9w2+fK7+laPa94t64M7wh97we1o=;
        b=NpnXHn+y/nZw+cGFhILZHa1YdIlN2JDgOAT4UR97o69imNBXGHJLhimUSBNTwd9S02
         Fd/fE0q9dD4Fa89cfFkmV599oN5ByWeEOyAb4G+8xRvi2IZarPiVw/0yEY0zBDtA6veh
         z7ew9WgDmI3LiyiOvzyhFjprFWWnHdn+v5VfSEQ2/W57W8Oui0woffUSRSAHiUk+ejOi
         B4enI/l6qmtkPmrL+sHGlluinBk/YMhjunoqc3UAmzDVqv7kIdFW+ppRCZnz0yiAatF9
         7r4tYBngeIYZ5jpo0E6WfotpVp7bG5VkGpY25XnVPtX+2TtCKtXTMTHNu6AmWBlcrTGz
         UyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759161511; x=1759766311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxJ0qKWOx+cSASEP9w2+fK7+laPa94t64M7wh97we1o=;
        b=AN42mJZgEWdPX5XbB8K3FnNXsg1Sw5aVRh1lneDhZtsUVcjDDZuunmGziATiufE3Ok
         ivMbWgGSn5x8X3AixESAH0bGiSm5RwfmJY6ChLBph2WamdzudUgF4eUg6VkBwJISJDHk
         u0pSnCQbXRS3wcKkcNiVtz+P2RwOdLbnETGOAum63QApc3VvYJNfJkUbGyleYT8r4y1z
         RhoUh7rPYFnC3zAAe+TzRD1zbrqH9uIKeTwbng+L3ySuEpeU+CuMmt4HfanzqCuuEnmn
         RDYH2hht7bQx9ZX3WMfCyyJSRVHeOGJunNR4S50WpdRDMNQHnUUH16xPwNVsXDHZCs/J
         gC/g==
X-Forwarded-Encrypted: i=1; AJvYcCUC8660n/z/C4mLy1eayLLCpmtMctmXX5Rf1sQlOJ1mP6NNl/HbR27zQ0Du+AfJGY5ad+QPKQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJnJo/LSlrJ0uEY+MeYHcctuSB/jDu8wPI3s3ZQnj0cckfosn4
	fBrnMfZ2tz4tF9ZNla12kXDuUgSR3F4NkQxVoeJRP/Ueog+eHPQsId9xQChE1ptZjzrxC917lZo
	2LV3nen4=
X-Gm-Gg: ASbGncv0+quD4BkD5+LtMqJGpMhicDr65kOr/WtUPpZuyzgs5RkK77FuMcg//fdu0Rt
	rdV/s/BbsblXWep8zi1PWwLuy0wg/h619ElRvAlqvwTRNwM/PdZCDFSQat7IhvxU9PVjIVrS7Sj
	CqvYGa6Q4YWuIGMzgzo65TwERJB3ig5NxOXFI5pbYI0hifBuQPBGFLPEle9MgrVyWMN93rNy2s6
	j90vt57vsprum8etxIwpwCydJfW4TwHJej7Qzdr42mAXrpqDypWgI/S76itHyP4zhc5X/Gn6Yv2
	/CvoFIMsjN2xvMyTqLqNDS2ny+y3Uue31g1hUYdm9Pai7wAlka/McuXtyHXHu00rSRoLRARu
X-Google-Smtp-Source: AGHT+IHNnZXawXbmz8noNW8yGj4C8jUeWu/3D7WDH7w6uaVVY5Fc3SwyDdgjyOZjCL0TmpCccKGgKw==
X-Received: by 2002:ac8:574a:0:b0:4d1:3dcc:ad36 with SMTP id d75a77b69052e-4e2800bf8f7mr13336021cf.40.1759161511025;
        Mon, 29 Sep 2025 08:58:31 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85e95e91765sm779413685a.46.2025.09.29.08.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 08:58:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3GGj-0000000CM6Z-3Hag;
	Mon, 29 Sep 2025 12:58:29 -0300
Date: Mon, 29 Sep 2025 12:58:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, iommu@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com,
	zhuyifei@google.com, Chris Li <chrisl@kernel.org>, praan@google.com
Subject: Re: [RFC PATCH 09/15] iommu/vt-d: Add live update freeze callback
Message-ID: <20250929155829.GF2695987@ziepe.ca>
References: <20250928190624.3735830-1-skhawaja@google.com>
 <20250928190624.3735830-10-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928190624.3735830-10-skhawaja@google.com>

On Sun, Sep 28, 2025 at 07:06:17PM +0000, Samiullah Khawaja wrote:

> +static int intel_liveupdate_freeze(struct liveupdate_subsystem *handle, u64 *data)
> +{
> +	struct iommu_ser *ser = __va(*data);
> +
> +	ser->iommu_units_phys = __pa(ser->iommu_units);
> +	ser->devices_phys = __pa(ser->devices);

Why didn't this happen at an earlier stage? It makes no sense to some
hacky naked __pa

Jason
