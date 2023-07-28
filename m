Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA7712B7E
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 14:00:48 +0000 (UTC)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-63cef62a944so14069536d6.1
        for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 07:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690552848; x=1691157648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fv/aIxldOQ3flpxNwF3k5IAzP1oP/cflqFNmUu6aUkc=;
        b=AgkPfuroX+KCdqk5BQ4lUC4FfaAqo5c29Tas2r1EcEHwrhok4IT+jiFDxYhFgToc/J
         265f1MOlGpxPb0Xf6KOTzA/mCLQUMdnCyEESJGCGSpEhcLYLRYBtp6fs2zUAb9QEklpJ
         DyGc19IwAs7X48YGFD3lyIWH6Zn0486MaxMPtu7I1xh6GtSsQ1Ejwn+sLSu3KmRsMfkq
         xZ6tggP/U/YxPXKqutKlC6dWTB+kCxY+DYNC5MipHzse+4sprmvK+xoBU13U/KuRtFp6
         6HMvkSGiNvHOtA6feX9mg3vZnwlldFqAcKFrVWNi4VwmuZKvqnVH8oW2JDj+OU4ly5Se
         GuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690552848; x=1691157648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fv/aIxldOQ3flpxNwF3k5IAzP1oP/cflqFNmUu6aUkc=;
        b=AiXert2Hw0Plgin7/eK7W3GRhTLtfcB27ckAm3aP7b6jBzamGHpuHLxMtP5259N9YO
         1xQ99UuAVaDvzH5d72HhlqgB0yCjcZDZYmy72+pwio+TdfWK2nbfe8z4KXoU2IeWUphW
         nrCsDB9+3K5LxvehH98J2pjQzoimZikkPBuGWqih85xIezlpxHszCexHD8N7FaBX5fvB
         w8GoxXXOz5OHfcd4Msnc03m6lTp719E4eYLtpb+BxDIwNrwqntAhiQDHMH3jVhsoSVSB
         p+99x5mBhoeiUG2+7/Lagn6FKpJ04MziRx+WWQhSRlRBAtHAT39u7fYoF2JF4CSWGi58
         rIJQ==
X-Gm-Message-State: ABy/qLaqcxKBn3dOJ9QBuDf3cTTnSAfybGmbpDZdhRnrxoQHd4EqKdza
	AIQ1nknQAbsh5prnFNtXJU1p1A==
X-Google-Smtp-Source: APBJJlELGYBz+w+VyHjdc82lirpv6uNehkjJFARQzPh2FknbtsBqsUHP2knbN3NUQVGlpGta4x8E2g==
X-Received: by 2002:a0c:f002:0:b0:62d:ef66:ff1c with SMTP id z2-20020a0cf002000000b0062def66ff1cmr2863835qvk.24.1690552847825;
        Fri, 28 Jul 2023 07:00:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id y13-20020a0ce04d000000b0063d032e1619sm1263470qvk.4.2023.07.28.07.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 07:00:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qPO1O-001bUc-Ja;
	Fri, 28 Jul 2023 11:00:46 -0300
Date: Fri, 28 Jul 2023 11:00:46 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v2 05/16] iommu/amd/iommu_v2: Use protection_domain in
 struct device_state
Message-ID: <ZMPKDsrgLa0H1Mkr@ziepe.ca>
References: <20230728053609.165183-1-vasant.hegde@amd.com>
 <20230728053609.165183-6-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728053609.165183-6-vasant.hegde@amd.com>

On Fri, Jul 28, 2023 at 05:35:58AM +0000, Vasant Hegde wrote:
> Replace struct iommu_domain with struct protection_domain to simplify code
> since the protection_domain contains AMD IOMMU specific information.
> 
> No functional changes intended.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu_v2.c | 38 ++++++++++++++++++++----------------
>  1 file changed, 21 insertions(+), 17 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
