Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97357220F58
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 21:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750110450; cv=none; b=o1Y+iFC4vLV5a3+qWTj8/6lG6WqOmSnLtZKttT7Dm2g5KbXbZTu6lIklXMh1n18jM+1vpOrHe7kcDzPyfCVGCb3iQiubIx/BP7CZOJJ418G8jbX/aZXNrJp7ArvcRVV0vsfk5LN14JOhf3uF+AluDDDvahnGybxK728owICx1Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750110450; c=relaxed/simple;
	bh=z2qeyaEDa8QvsVY4HmYmJ2h1mEKFu6Hb5NQ1IlDbbqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DrBnqwWdhNVYvzDQ+QHIEoTOV1zCX9NcwQ8rsaBnJVlPRQCCeHgpYYRKG3JwDTnc5xJpzNE/NXghHwcR7WhoTC6sXeuL6ysaz74cgsydC7QeyCE339ZEGzlRF7GOUQFV/8NIzGJV4Wu0qJYup4zpxmJ+BMkVXwTzNI0COs/3Gnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VLysaXlM; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VLysaXlM"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-235ca5eba8cso58235ad.0
        for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 14:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750110447; x=1750715247; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b+7yTuFOYw/+OFN7i63Es/kgRcKQFjeHwd4HaCwCrWY=;
        b=VLysaXlM/WrX8CiV3CW74jaoyuBzF7+qPMxq+eFUnAt84PHumrSN9RWFdsfwzCezrn
         hQkMdSDsQlGP5XOkFauOTbIumpwrbSgG+9DfwIngjLQNdWYCYiBFbiT9e7PeJOKSmr+R
         cN4xH0/nMG//PQ28LPffbBsyZMjv8/QbCR2bVTgrgnriO/d6VA0LRS00l8zM/fXmuFwr
         L3G6tmWnU/A7erSSalgxpdBvZxuMGHRdOOzY48YiRKSdKhsSY1ml/FOLA1IXgcw/bXf2
         GstXnpWRrSLd18rqe5nOpBROjHCEaZqLP1veJ/IHjm/slHkCQq6OGiZqQTpW4xaohshl
         CFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750110447; x=1750715247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+7yTuFOYw/+OFN7i63Es/kgRcKQFjeHwd4HaCwCrWY=;
        b=L7U+4zQ4MVUlktbXX7l6jbzie4XXmYNV4czXjPyfuQ9A1tPXNhC+IT5aczZJUCan/K
         AyzB7QATCJK0csX4zQ6kwsNO9Cq5x143qKZfrw+/0fvtRvR51m3s/xzBXCjl8qdNOLMV
         u9kzjNKTa+mAxmnplS4tX4aXH1PpocRi0c6i6PDeK+jqtVL9GZCM8f3wZxLRA4QPtXPV
         XHaCcYqJYP7Q7Kf4WKFrK3lxUqLOL4Z58iMW2VQxS06yXRiG9N45SMEsaTRIUymr6xb6
         ree6LuZ9l8KYk7E5JQfwIdazYrAINC3Rn7m8MSV3f4Z6q6eDR2CwsBFaPipLr0jvJfvZ
         oVUQ==
X-Forwarded-Encrypted: i=1; AJvYcCURYgSdA8tXbxPryu6xKhB1bnzwv7N9bGHdDYwYguG1paw1C7Z1ZbpVdZ/ZnL8M35HBy94Wfg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw38Gchtf1H43lMsLmSJRm43yl7+J/9tlLXArWNnVjDy1NPMyDy
	ZhjNbzaESONhby95B5+79Y7qn7oBV6/hg+XGJPzwhAxt7pa+DAbjVIl545KP7PHvpA==
X-Gm-Gg: ASbGncsrl9Iibm0pigCtVt1BfHYR3ekSkfQdb+TT4TyKsyqyPc+RodwsYO+PtwhCWcU
	GiSVYKXX94ROnLAepKzJZMOkoyMc55ZRy2HWqbSYkD5zx6TmWVJW4NItyTojrXqA1qc/mgJvdWp
	FMrH3zXB+b7oPc452IVxfC6z9bbdiEYFSpgnSLITJXL9bGueBHfRoPchpvIi3Q6i+PK5bIEpTeB
	hOyL1x3SdOHd0toM2ud2MMTdM/YyqYTAiHHFiseUmtFpFtB4ikkzYXk9FZfqxrUzeSaBgyxEZvH
	M1YaUVR62Ov1MEnXg2nrWxsj0VAnSiCx/3oGb0rh4l8ofVcUsFJ5z4Lo6y9jumVV9XTkQeALScj
	J0p/gQEk8i9TvOw7fHA1k4WOWasYoHjU=
X-Google-Smtp-Source: AGHT+IHag3rw8aX4ZKoeizjYKIh5qE5BVC5WmHX9g+TIQMgoMav4KZZJKeYmD/v1LvZQLFwcJimtlg==
X-Received: by 2002:a17:903:1a27:b0:234:bf4:98ba with SMTP id d9443c01a7336-2366c5bf768mr6069465ad.6.1750110446641;
        Mon, 16 Jun 2025 14:47:26 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe1680c1esm6263160a12.48.2025.06.16.14.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 14:47:26 -0700 (PDT)
Date: Mon, 16 Jun 2025 21:47:17 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, yi.l.liu@intel.com,
	peterz@infradead.org, jsnitsel@redhat.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	baolu.lu@linux.intel.com
Subject: Re: [PATCH v2 04/14] iommufd: Use enum iommu_veventq_type for type
 in struct iommufd_veventq
Message-ID: <aFCQ5fAn4FYXUr0G@google.com>
References: <cover.1749882255.git.nicolinc@nvidia.com>
 <208a260c100a00667d3799feaad1260745f96c6b.1749882255.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <208a260c100a00667d3799feaad1260745f96c6b.1749882255.git.nicolinc@nvidia.com>

On Fri, Jun 13, 2025 at 11:35:16PM -0700, Nicolin Chen wrote:
> Replace unsigned init, to make it clear. No functional changes.

Nit: s/init/int

> 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/iommufd_private.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 4619285c09b7..32f0631368e1 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -526,7 +526,7 @@ struct iommufd_veventq {
>  	struct list_head node; /* for iommufd_viommu::veventqs */
>  	struct iommufd_vevent lost_events_header;
>  
> -	unsigned int type;
> +	enum iommu_veventq_type type;
>  	unsigned int depth;
>  
>  	/* Use common.lock for protection */
> @@ -581,7 +581,8 @@ iommufd_get_viommu(struct iommufd_ucmd *ucmd, u32 id)
>  }
>  
>  static inline struct iommufd_veventq *
> -iommufd_viommu_find_veventq(struct iommufd_viommu *viommu, u32 type)
> +iommufd_viommu_find_veventq(struct iommufd_viommu *viommu,
> +			    enum iommu_veventq_type type)
>  {
>  	struct iommufd_veventq *veventq, *next;
>  
> -- 
> 2.43.0
> 
