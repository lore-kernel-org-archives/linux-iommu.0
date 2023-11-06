Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C98629CFF
	for <iommu@lists.linux.dev>; Mon,  6 Nov 2023 17:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KC15Xez0"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-d9fe0a598d8so4620610276.2
        for <iommu@lists.linux.dev>; Mon, 06 Nov 2023 09:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1699293026; x=1699897826; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0b+vpysC2i86pwY1O3uJVA86JhJ5i1oL+sXugUdHEYU=;
        b=KC15Xez0Z/J/r4FnELxJciAWkqweEzntDm6ZBWcSX2UhJ8kjXqqUJPj5LLI2fevj2O
         XXHiX1HLP0Ug68tVBSD7Evi+iuB0bHFyL2UEXTO4B169iLXrGyWUbTf1UThDQhN6Ii/Q
         rVd7DwcljC431ZgVwqTnuZ68S+L/p9uvBOa7Nr9Ae667nRPG6ZFUultlMcR3m74KPLJE
         FNmdDbUnN61VZIpdE/fEfXZzZELnglg02JI0CkcUvYoW+iptijkHCL9MPa3rwDBk6teu
         HzIlH7o4Jf+jQBQClwGBQNQf9yAXr3hnSfJL16/x7+OmQfvy5JNPUTOWUY7BPnh5HQ4A
         eXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699293026; x=1699897826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0b+vpysC2i86pwY1O3uJVA86JhJ5i1oL+sXugUdHEYU=;
        b=TwUifvO4Gx6WKwR1LATdaDEcWYEKSNnpPENaQSUmKsYJGvSoNwqtIFUS8DvGoeHj8a
         MUzaYkeDiIPMuZKgajVoi7bV5H0eXYWCxAzqGqvt4dcovbB3LYcPL9oYM8BP+mIfK6tD
         czbNifqjnHLnJM5EW7c+a6cizVrb2Se77LZ2X48KPRYzePdLci9g9dhgifS/2xic5B2h
         T4zvTBTBI7I///pmcn/+D1NPZ8WT6X6EET9xtueGNtLuo8FppVy1byv4qgXxifYg3JnE
         uL9crKCURAQtN+kpNUz5rQGrr/aIiWxG9V8Qp71+ZP5K8ZLb7ER0FaCHICAVg7M4CY6H
         DH2g==
X-Gm-Message-State: AOJu0Yw7Q0Nf4eq8qtt46/hOhrsp3mC89/w7OKOO4Nae06rU89MVFcNH
	byVfj22pSOc5LiwItK6jf7EWuw==
X-Google-Smtp-Source: AGHT+IHLsJyjpTBniD/AuGbwodGgzCiw2mIwdzdN4JTa9i2aq0xL6xjmE2PE5+P8L0+mAR2t3sxwDQ==
X-Received: by 2002:a25:aa26:0:b0:da0:338f:794c with SMTP id s35-20020a25aa26000000b00da0338f794cmr25743618ybi.60.1699293025956;
        Mon, 06 Nov 2023 09:50:25 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id dc7-20020a056214174700b00670e0f71ff7sm3656277qvb.90.2023.11.06.09.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 09:50:25 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r03k0-001PJw-In;
	Mon, 06 Nov 2023 13:50:24 -0400
Date: Mon, 6 Nov 2023 13:50:24 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 01/12] iommu/amd: Rename amd_iommu_v2_supported() as
 amd_iommu_pasid_supported()
Message-ID: <20231106175024.GQ4634@ziepe.ca>
References: <20231016104351.5749-1-vasant.hegde@amd.com>
 <20231016104351.5749-2-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016104351.5749-2-vasant.hegde@amd.com>

On Mon, Oct 16, 2023 at 10:43:40AM +0000, Vasant Hegde wrote:
> To reflect its usage. No functional changes intended.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h | 2 +-
>  drivers/iommu/amd/init.c      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
