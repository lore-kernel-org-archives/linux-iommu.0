Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781B87E
	for <iommu@lists.linux.dev>; Thu, 24 Aug 2023 22:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692917144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l0UGEhHZBAwQwvXBq5/IecgIretttOLgRO+Eo3+MDqc=;
	b=H2cz93R4R2kCS33Y5bklMeqOOFESRScJ3LpCnGg1c24w/QIBiNsxkuF040Pv7ryv3J39xj
	/3R4VtigHCaEJyrN9SI+iD5Tg2Y6z73anJhLtHG39YaqI5apRU8TmII1iUXn7d+Qx6j10F
	JOXHfmK4LzQdUBQH+fKZgDQyzpR7uU0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-rQ9JSWO7MaGKIrFLi4hXxg-1; Thu, 24 Aug 2023 18:45:43 -0400
X-MC-Unique: rQ9JSWO7MaGKIrFLi4hXxg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-76e26652e6fso35100885a.2
        for <iommu@lists.linux.dev>; Thu, 24 Aug 2023 15:45:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692917142; x=1693521942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0UGEhHZBAwQwvXBq5/IecgIretttOLgRO+Eo3+MDqc=;
        b=iDKrRxOhoO8/DzggBs1Xr+FGI/+DcCIOUtpmbg8czlvmtGdlYDRzVPfzNyI/PnYAJv
         nlWWEHnjA0YFKEqEnbcNsw8MLHExYeRlxqnbsr72N87pUvGsGMxb94g4ivZ2veARJlbu
         yxonQZekexrtjnWHkBYYJsrZiFNs6isR1uKMtwSlsJHJ53eSuhaX3ntPICyy9q0SqwNQ
         je59BLEI57QdevGImOCBZn18kSVfer8TeM+9jRE4soOVPZNEiUurp2zsqd5PhOufOT0V
         odFCCkY92cTjFdx/86MLimMfsPxZrpNdqSTBNCogVLQ6Lag6Sj9MgpbeGTE71FTTkKWS
         COEg==
X-Gm-Message-State: AOJu0YylfhN3DF8SaVCn8CGgPYpnwzShWRaUxSQWFGhXBA5WB8Py8GS/
	d9J3T4/tadmbM1zWG2zjdhHo0mEdODSJzGFP3/CpOu+NlyNXFJ/2WApi3tITv3jcqSOKMY33GGQ
	x5obOhJTshtbnIdc=
X-Received: by 2002:a05:620a:29c7:b0:76e:f3e6:99b1 with SMTP id s7-20020a05620a29c700b0076ef3e699b1mr2730555qkp.19.1692917142843;
        Thu, 24 Aug 2023 15:45:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdutysKef0sMGZ0YunLosKN4ALo0adP2lqgt335Roq6KPoeR6WfEGlnGoxunSDPuskjtAaZA==
X-Received: by 2002:a05:620a:29c7:b0:76e:f3e6:99b1 with SMTP id s7-20020a05620a29c700b0076ef3e699b1mr2730537qkp.19.1692917142586;
        Thu, 24 Aug 2023 15:45:42 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id x8-20020ae9f808000000b00767cfb1e859sm132381qkh.47.2023.08.24.15.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 15:45:42 -0700 (PDT)
Date: Thu, 24 Aug 2023 15:45:40 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com, 
	wei.huang2@amd.com, jgg@ziepe.ca
Subject: Re: [PATCH v2 2/5] iommu/amd: Remove PPR support
Message-ID: <ysopadf5shv3mesr2ra5ipuzktpcogbimu366hyrakr4z76wr7@563uzb63uydv>
References: <20230821104956.707235-1-vasant.hegde@amd.com>
 <20230821104956.707235-3-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230821104956.707235-3-vasant.hegde@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 21, 2023 at 10:49:53AM +0000, Vasant Hegde wrote:
> Remove PPR handler and notifier related functions as its not used
> anymore. Note that we are retaining PPR interrupt handler support
> as it will be re-used when we introduce IOPF support.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h       |  2 --
>  drivers/iommu/amd/amd_iommu_types.h | 13 ---------
>  drivers/iommu/amd/iommu.c           | 45 +----------------------------
>  3 files changed, 1 insertion(+), 59 deletions(-)
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

