Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C71BE64
	for <iommu@lists.linux.dev>; Fri,  4 Aug 2023 13:19:03 +0000 (UTC)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-63cff46ddb8so15129016d6.1
        for <iommu@lists.linux.dev>; Fri, 04 Aug 2023 06:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691155142; x=1691759942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NQnhrEopY4ZfqnnrX2qCYm1RFQ0GzpHAI03zdoZIqTs=;
        b=pHwqUN7qXysSPyLbRad1ZEZO1VyDssHwbIIp3TUX2DsjoT9MVxG33BHh6rCvpLmj2O
         Og4Gsz4Nt71DNvUQPvrmy0sRQZBLG7bu09ML+qIttz3lvjkPPGONOgTQbVRtOM13+cvF
         5QQ03GjE6vgRXxoCXa8Yrwy54hH+J7okHm4huzMh//x4JUcp47b3oq5ux/IJiCEa2ARf
         ayMGp+21tYIZ25C8tblzVzOoyHoNL/MxeK0wwKiQryI6HDvPt25Sn5k9Z8NezGw/dzPW
         GKcLqjkEguRq+RKvFRCGGlRjyr0fAwfex+Wq0q66uouLkLuHl3uiNQAenoH7/Nm4yjCv
         VHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691155142; x=1691759942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQnhrEopY4ZfqnnrX2qCYm1RFQ0GzpHAI03zdoZIqTs=;
        b=N0pHKciArKgnmyyuHQ3cDi6QI7CgZ1cGY44+3bQdUTrehi6kR/SNuK5tYazNkIcOJF
         9Qw5FFVb3XOSlFAgSw988lVN6gfnOcnf+3Rxt6VIqmdoO3NrWE9zZagWnr1MBOUTwMq/
         AYjCeTFjgHviINsKTkb3MYV9/YQGx5kQ8314TX29QUvQwx8vKhP7GXTOi71x5hgluJns
         yNUO/ZKUYqJQE10hqrAjEdlMjiAwS1h3p+tS3o/w0Sw1y3S9MeE5GAAqRtAerGXdZ+GK
         iG5ZZiIIxtTxfUEbYuOmW4yy2Akzd4FAeNskQmLeYRmkiQRzo/oAZZgOt4nGH+73hK9Q
         wJ5Q==
X-Gm-Message-State: AOJu0YxU1LdtHzWEYETFMO4fFfJONmz1qx/E7fzd5aFJEZAtPoF0UPZe
	wM1zr+BFPSHdY/FgmWypkX157A==
X-Google-Smtp-Source: AGHT+IE64FK4n2wJ1KyODg3m3LHhsWCcy674I2/x5XPwqgSg4sft4fxDPKC8kWvFrCaOZBlj3ocP2Q==
X-Received: by 2002:a0c:f248:0:b0:63f:50c8:3fa5 with SMTP id z8-20020a0cf248000000b0063f50c83fa5mr1963509qvl.23.1691155142294;
        Fri, 04 Aug 2023 06:19:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id a2-20020a0c8bc2000000b0063d06946b2bsm650689qvc.100.2023.08.04.06.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 06:19:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qRuhp-003igJ-7c;
	Fri, 04 Aug 2023 10:19:01 -0300
Date: Fri, 4 Aug 2023 10:19:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 09/16] iommu/amd: Miscellaneous clean up when free
 domain
Message-ID: <ZMz6xahZgKILqlfK@ziepe.ca>
References: <20230804064216.835544-1-vasant.hegde@amd.com>
 <20230804064216.835544-10-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804064216.835544-10-vasant.hegde@amd.com>

On Fri, Aug 04, 2023 at 06:42:09AM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> * Use the protection_domain_free() helper function to free domain.
>   The function has been modified to also free memory used for the v1 and v2
>   page tables. Also clear gcr3 table in v2 page table free path.
> 
> * Refactor code into cleanup_domain() for reusability. Change BUG_ON to
>   WARN_ON in cleanup path.
> 
> * Protection domain dev_cnt should be read when the domain is locked.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/io_pgtable_v2.c |  8 +++---
>  drivers/iommu/amd/iommu.c         | 44 +++++++++++++++----------------
>  2 files changed, 26 insertions(+), 26 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
