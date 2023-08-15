Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1569A134CE
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 14:48:00 +0000 (UTC)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6418db141fcso29877736d6.0
        for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 07:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1692110879; x=1692715679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U8v07XRIVlxQW0PLLrQTtoF4u4zoS3Velypu6LpXZJM=;
        b=h6Ow1Qbmq7lPBOYj6gZ+is3fGcLPmbhYQM/18sNVDkqqj8zRMqLXeYzIKv4kD62JZA
         e9AYu+8gJBfpCSr5PybqYwybBvqbEKr1YgdwZ/zsQdKofhYef3XioR8hvS0cnOxenrTA
         7Aib0Amdx+Py7YI2kgeN3LfNrNdjEMhmlVKmrtreCT/mD3B2AwDN4+VVg8xYu2znFZAJ
         P8e53RcJdX8dPJBfa8oe8LN6DEkPkqch+rFV/HQx/g87K33aGabykbvulFRjS1g9tULp
         22KV70OH+JEZStkb2Z1EF6vGc+yaw6c7Zh2rs061cusXwAvAEP4gLQOoLva5yW3i1DA4
         WszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692110879; x=1692715679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8v07XRIVlxQW0PLLrQTtoF4u4zoS3Velypu6LpXZJM=;
        b=Nhtbma6XO5YGAPsTt93ya3TnkRTAl3cq/FFZuqVDGbqAkIiKAKIzJ7b6XSHeVy3/Nm
         e4Rk+eebnt+WsrjMOCakAQ4u3YZIGnrhH55JtS/P/meHb3DhBYL0gO1oi+yVRmeE3+Uz
         PBOsQkVFJUt+3VBJrvCShdYhOADI02Aj+A+JQmoyxfsP++JMQhLT3lbbYDot78RVWHdX
         JZfzZcE/S6bH+HAniBIXlTXlTx30m+qx6Twnbf5EqNz8axc2axwyeEyLciIeQ356QXJI
         NBe2k8d5vZ3Gjp80ciLRPFZs4WG4TgwxcydXsJ8mU60TfzMlB/M08mKhU9WaMD2yX1AH
         KPLQ==
X-Gm-Message-State: AOJu0YxFalkpOiYRy5AedKBN8lOaSDZKXoGSdeP3X2czYjIdBeRTMNkX
	gZUwCSA/gMxFrA945fIMXP5+2w==
X-Google-Smtp-Source: AGHT+IE12eM7ZWNKA8eMpURG9QcdJ0VFtnyzWZN5vOwIOt1oaDop5+thiprSCY08gcPw0/O3NUNgNA==
X-Received: by 2002:a0c:b299:0:b0:63c:f0a7:cef2 with SMTP id r25-20020a0cb299000000b0063cf0a7cef2mr14469294qve.25.1692110879737;
        Tue, 15 Aug 2023 07:47:59 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id b10-20020a0ccd0a000000b0063d14bfa5absm4173103qvm.36.2023.08.15.07.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 07:47:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qVvKw-007c3I-3S;
	Tue, 15 Aug 2023 11:47:58 -0300
Date: Tue, 15 Aug 2023 11:47:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v4 05/14] iommu/amd: Introduce helper functions for
 managing GCR3 table
Message-ID: <ZNuQHtpuFJA49Y24@ziepe.ca>
References: <20230815102202.565012-1-vasant.hegde@amd.com>
 <20230815102202.565012-6-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815102202.565012-6-vasant.hegde@amd.com>

On Tue, Aug 15, 2023 at 10:21:53AM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> Refactor domain_enable_v2() into helper functions for managing GCR3 table
> (i.e. setup_gcr3_table() and get_gcr3_levels()), which will be used in
> subsequent patches. Also re-arrange code and remove forward declaration.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 65 +++++++++++++++++++++++----------------
>  1 file changed, 38 insertions(+), 27 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
