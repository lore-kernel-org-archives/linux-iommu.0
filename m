Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB4E8F77
	for <iommu@lists.linux.dev>; Sun,  5 Nov 2023 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Z+stHxKY"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-41cbf8e1f77so21628181cf.0
        for <iommu@lists.linux.dev>; Sun, 05 Nov 2023 10:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1699208220; x=1699813020; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uJ/4ly8I4Lzcl+B1iGhd5bwx1qXxyhHEC1tRizsoUUI=;
        b=Z+stHxKY+5K0q5pt6RxYluEnzFa0UVG7pRZSS17xgfqoGvBVSuKIVYjpHezCuNWo8w
         YHQzVODgrFNqop9T5UF7gfs5zNfl9CDvMWeTS0MjUPd4EyAkMfNTtEKLNBsKgFUSQBSn
         Esxm0YmK9cmniQNHrVgQgoFSiwefW3uXluDASfAHr2QGbq0z4A+LkRMl2FAlXJPSaTSG
         IFLoB3wIyLYDUxMcRHulypUyfGGDQFVUowTeX3z2zUzVXZmCATNqCLi4AnxPjkgTiMph
         +yD/cMMDb3C83aW4iW0Iu6uyNfGVpO1gzrMJJ+93YsS+wXzRSkG2xxBXdb0LeeSJzZFo
         LHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699208220; x=1699813020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJ/4ly8I4Lzcl+B1iGhd5bwx1qXxyhHEC1tRizsoUUI=;
        b=KVAhC9ZsBmifFqhh+ro0D4yxWxpUFdbIavmqjwW37nrYmSTtA8XNHO8kU2I0DMPMg4
         ymCK6v/dkXACaCvderF82gtsk1KsyCXiGYIidx+UzYvedf/kj9Lf8qzBA3Ftj5epbQoN
         vOX6rGtlssJQKK+y1Bkr5MbVao+CxOKjecrg13Wj85KqjebI6JCXzzV0SN8GWlRQsgxz
         82i5AsRdMMabS77WXcb1YfAVt9pHYHzVN+cAMYKcKvZiYm4OUh//I1CsgwC0O9d5Ovqy
         couRx8QHoCjsaLrTW16H4/uA88MzcLv9ROJEqtVLqFo1FrBFoyMv51g7U5eNuu5Go53I
         AzxQ==
X-Gm-Message-State: AOJu0YzSx7DUoYHYraf4Lv6kfy/YPgkw+CpRBrpu+s3x0EIXxP5VeunA
	g0tvPFWzPYwqan4ffj5qKdAIFw==
X-Google-Smtp-Source: AGHT+IGUIYvWoIkVA+ArZ/oWFMmhkFTqlffURf/eAx3bnwWr39dzZFIYDbbZ0d5xzZJkKsUL2zxaVg==
X-Received: by 2002:ac8:7d0c:0:b0:412:1fd7:dfa1 with SMTP id g12-20020ac87d0c000000b004121fd7dfa1mr26432238qtb.8.1699208219827;
        Sun, 05 Nov 2023 10:16:59 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id ki23-20020a05622a771700b004166ab2e509sm2680150qtb.92.2023.11.05.10.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 10:16:59 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qzhgA-001FfV-Tx;
	Sun, 05 Nov 2023 14:16:58 -0400
Date: Sun, 5 Nov 2023 14:16:58 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 08/13] iommu/amd: Rearrange GCR3 table setup code
Message-ID: <20231105181658.GI4634@ziepe.ca>
References: <20231013151652.6008-1-vasant.hegde@amd.com>
 <20231013151652.6008-9-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013151652.6008-9-vasant.hegde@amd.com>

On Fri, Oct 13, 2023 at 03:16:47PM +0000, Vasant Hegde wrote:
> Consolidate GCR3 table related code in one place so that its easy
> to maintain.
> 
> Note that this patch doesn't move __set_gcr3/__clear_gcr3. We are moving
> GCR3 table from per domain to per device. Following series will rework
> these functions. During that time I will move these functions as well.
> 
> No functional changes intended.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 64 +++++++++++++++++++--------------------
>  1 file changed, 32 insertions(+), 32 deletions(-)

Same remark as before about just moving code..

Jason
