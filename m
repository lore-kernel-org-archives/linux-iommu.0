Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4531F11CA9
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 14:11:42 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-68706b39c4cso978376b3a.2
        for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 07:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690553501; x=1691158301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U4YjKvrjqyLm2xBjzTEs3wb7lqWG9Dw+w1ELy5umAlE=;
        b=jV/3yiNRA5jV5+/NI8zZG9k3BrknguOvtkIQTgSSOpuF/YBZ3gJy7RMD2QNpHokqTU
         3WC7RQCyDHC1GYovnjlsWkVlUZe64AzaPyjyFXpA0EgnVrf9Q7lYJjpsGK0A9TybXbBj
         00uTizWS1CC9lxdwQzlYt2Rai3/KOvXlK2OBOPQV72Aob7gT0rXuomNxZPo+ZjNNBlZF
         XmxUdY9XX2qRc2D7gJkt8fHFeM63hU4F4Pxu0KDfJP+N0mEyXh61wHlZ9bRUvcc2sW8u
         I/3LgPyJP8RvWakT68cVrsaBONxbJ8/tJ4NTv6oaDSOLVAIFcZKsBz+5Zu14zxRxjYIj
         cxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690553501; x=1691158301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4YjKvrjqyLm2xBjzTEs3wb7lqWG9Dw+w1ELy5umAlE=;
        b=DjnpeF24BGgHHagJrYZgvangXoJ/JyM/7+ayPiXb9vkYwFngXuAankcmB+fLi4Htm2
         uP0fKkF/cgaFZLe9jdURwJHrYrKpElT4bqpWHoGXcNCNkFn8BAFMAZmYcklV1PE8n8hg
         1rkQtLnfIgQIafCZxUmkJlXiqC6JkVAOvd1qb7oLxbfB8gVFJcn7jq23tYffCV1A5mfd
         zKXZLf3HqrSxDGyQwBVBisEg1+MCTXGqQWd6lMgTemPk6EqpdcBNR58+Zd/VCDLDUHY+
         ROq+MH3mvhqePW1OKeIsjhYRkGgH7Rtm3Q+9f0dIindVCH32cTkMphApa4FJTl9rqlz2
         +IMA==
X-Gm-Message-State: ABy/qLaNOrU9paygmJrYMM/nLokZvsVNEkSjMbJFWZtBexKyfBg8SxkG
	N4zamBmOFx0QYuclroEsQT7tIQ==
X-Google-Smtp-Source: APBJJlEGubLf9d7OVKjWTi6GezHBLG46NABVGpLfDE9UN1GK9eMWtKPwasaX4veOxz5OElm/ErX0UA==
X-Received: by 2002:a05:6a00:ad3:b0:680:fa5f:4ed6 with SMTP id c19-20020a056a000ad300b00680fa5f4ed6mr2137646pfl.27.1690553501585;
        Fri, 28 Jul 2023 07:11:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id y21-20020a62b515000000b00663ab37ff74sm3267066pfe.72.2023.07.28.07.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 07:11:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qPOBv-001bcD-U5;
	Fri, 28 Jul 2023 11:11:39 -0300
Date: Fri, 28 Jul 2023 11:11:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v2 08/16] iommu/amd: Do not set amd_iommu_pgtable in
 pass-through mode
Message-ID: <ZMPMm4QYPKRqO9mj@ziepe.ca>
References: <20230728053609.165183-1-vasant.hegde@amd.com>
 <20230728053609.165183-9-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728053609.165183-9-vasant.hegde@amd.com>

On Fri, Jul 28, 2023 at 05:36:01AM +0000, Vasant Hegde wrote:
> Since AMD IOMMU page table is not used in passthrough mode, switching to
> v1 page table is not required.
> 
> Therefore, remove redundant amd_iommu_pgtable update and misleading
> warning message.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/init.c | 3 ---
>  1 file changed, 3 deletions(-)

I never understood what this code was for, happy to see it go

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
