Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB561FBC91
	for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161648; cv=none; b=Yh93jolRk+1m84Or4NTUG12RVoDplqs3QbY+wl4NYcE0eorkJOnj7MI0UvIZp7VnX7dXIPTZ/470ntLiiCfpimUdtJsBals0uKSY1KnAodkMtn2mxuHijw0Cj+ictWOhJK8Vtv/UqCIeL3fYXEhCY+VOk2IGLE52vxNNStjM/Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161648; c=relaxed/simple;
	bh=U6AnvjRGp3O1qm/RyZLo8C0gFo1427DERoRZSdj0BTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcnUWtN7gNhde77WLvXTBZ9m60dCNByTRQhG1QYUwmwSL6yGlfYPEVmbxXrtcGL0R07uKabF848nYbEz0/KHpSi6STTIJfc0kYTJanqGnSMjmU8lZXR/cEeaPi+DnDh5TFx+CWv7SJ/udwmhmvrEpzjG+JuL1lLDqy0eCS2GnUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=aF5Qn95Y; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aF5Qn95Y"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-7960d69f14bso26344406d6.2
        for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 09:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759161646; x=1759766446; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xLG2JR9bcUzJhF49OBS0iB78RdPUmnc4lDRxtw6BiAE=;
        b=aF5Qn95YYpUgBIx3afOHyJKgZrVN3LdWcz0JPmqqyihFmBslxsuOh4007s1YoY015X
         OK/X27vtnThui62sNTclxXOXjXa34vrCi9mcV83DNNU5Wzt+5NtvTjvasNICXs7HzRTn
         HIZ03zrnjHPmkoVr2eIgoGlTidqyMiMfSN2zAmzYSn2jN9Vpk4+GQoAdKJa/0Hts2ouX
         qooQCKqzxYN712RTvUQo4BQOol2QZJ5Xov6KBbz16TJTwevmG9RpGGvbGVD+pWHIc6S0
         8qO0V1vBx3DMUpaaB+rhebPrwlKo14+QODufuyx3Yz/rsrEmUylFjba6jSScuxCHyytU
         Ahow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759161646; x=1759766446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLG2JR9bcUzJhF49OBS0iB78RdPUmnc4lDRxtw6BiAE=;
        b=qYRtARGgJQU0qXQE0ZRlCuor05K7hRvMDfHEn2kNwVqWZsh6Nt+Ex8pgG0PyDeLuMa
         rVU9RJQHXR1FmjEmz242FuRFrHjP1plfU+fqGxC+1TEgaMlRTy4x8FuM+fNVD/7Pw+v7
         kUHtzw4rYvxNhcQd3/k/Gd8wrwm09DXPwrzgbY0G8wLIMBPso+hZISBe4QtoBCQ2Tzyx
         SvbQ97bO5HFCocuIzTq7+qJDbSOvB1R7HytDSxwROnI2lMVtlfBPAuccS5zYsHf9Mmvf
         YJQnbhWhHR9SiPt6iG8f0sqJEFRTlkuvXRdXdIVkOMuP1tk15jLxrPl2grg7ZjcqlK2Y
         kxjw==
X-Forwarded-Encrypted: i=1; AJvYcCWxwqTpztxRri1zoF+WuKVvHP2Y2cLbenvJhM5mnPYa0AjxDCXrwbQdiqMIMQyM1awkTGUfFg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwrRqLYLnAZMAVV+xkiWejdbDAaxoUaYbSumuUqhUS4kOgxiUJA
	ME0dMaQQz+y8ylilE1MweB7ah2bwcUD1m4FfuUjzhBj0aKHD4Rkhjko6u9Ncd72NHmA=
X-Gm-Gg: ASbGncvG2uAzqNKDxYf39US1UW7Ac1omO0PNH8LpRJ51Tvr2v1gTkG9hmjRxV2n/sSV
	pEXXAKO/Dp5GOJnygKKlYIFT2f3JruslfqzBruqmPKGCkumD3rnoNtVFFDy7qW8nK+TIoVW/qvX
	swJQUB8VmEJWmd8eoVSfQLM7T01yybtKm+TXjo3B7j/+GCrRFMv2Lqe5J8m85kMJZbOs75wMJyr
	EhRu1K05RQqWHUROH/5AtZLESAgyWPdbf8ODc4O/bJMteFY4pR4vLi4k1b1gmOEYwarV53ya2q+
	0l0vSJSWaVZSSpboTaq5/am+T8lW14m7pEdtl/UVkgZSJ9l61Q/UL7dE/SybaCQvvGVNLqj+MIF
	huH0gKX4=
X-Google-Smtp-Source: AGHT+IHz2Vje0PqzhbQ26O+lHr4KWI+mNgBaMfoJbiwF/Viar3gDMaG7u6LkyDnLmmdBy1asKxIVKw==
X-Received: by 2002:ad4:5dc3:0:b0:7f7:ee24:9048 with SMTP id 6a1803df08f44-7fc2b7661ffmr266870906d6.16.1759161636381;
        Mon, 29 Sep 2025 09:00:36 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8016ce9a3c0sm76267316d6.53.2025.09.29.09.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 09:00:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3GIl-0000000CM7I-00iD;
	Mon, 29 Sep 2025 13:00:35 -0300
Date: Mon, 29 Sep 2025 13:00:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, iommu@lists.linux.dev,
	YiFei Zhu <zhuyifei@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com,
	Chris Li <chrisl@kernel.org>, praan@google.com
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
Message-ID: <20250929160034.GG2695987@ziepe.ca>
References: <20250928190624.3735830-1-skhawaja@google.com>
 <20250928190624.3735830-14-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928190624.3735830-14-skhawaja@google.com>

On Sun, Sep 28, 2025 at 07:06:21PM +0000, Samiullah Khawaja wrote:
> +static int iommufd_save_ioas(struct iommufd_ctx *ictx,
> +			     struct iommufd_lu *iommufd_lu)
> +{
> +	struct iommufd_hwpt_paging *hwpt_paging;
> +	struct iommufd_ioas *ioas = NULL;
> +	struct iommufd_object *obj;
> +	unsigned long index;
> +	int rc;
> +
> +	/* Iterate each ioas. */
> +	xa_for_each(&ictx->objects, index, obj) {
> +		if (obj->type != IOMMUFD_OBJ_IOAS)
> +			continue;

Wrong locking

> +
> +		ioas = (struct iommufd_ioas *)obj;
> +		mutex_lock(&ioas->mutex);
> +
> +		/*
> +		 * TODO: Iterate over each device of this iommufd and only save
> +		 * hwpt/domain if the device is persisted.
> +		 */
> +		list_for_each_entry(hwpt_paging, &ioas->hwpt_list, hwpt_item) {
> +			if (!hwpt_paging->common.domain)
> +				continue;

I don't think this should be automatic. The user should directly
serialize/unserialize HWPTs by ID.

Jason
