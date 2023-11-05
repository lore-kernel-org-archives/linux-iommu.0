Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0629C16424
	for <iommu@lists.linux.dev>; Sun,  5 Nov 2023 18:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eszlpWN9"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-41cda69486eso25253121cf.3
        for <iommu@lists.linux.dev>; Sun, 05 Nov 2023 10:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1699207638; x=1699812438; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/+9xh+lKfavFC70jk1+AZh3XuK04oLoTgytZlUJCpHQ=;
        b=eszlpWN9GWDV+Oa0XwcLLAmny/ce0PtanQCxp9FVaF+oUOcnNbQBLKYc6WE3E2X/EL
         Z/MhIPeOk8ELiY52u0sYfjp/0DF6n1GRuC1J00OWgze1sqjeGtDg/EULFVV1MAEAYoCE
         2nsiP5UxaQraJ6buD/LTJTWY4zzTKlS4JPHreZoqzdbMjbCA7DCEWAf5u+ZNf8TPQq1g
         SVsgkttEDdt8oFGAIu5NqOzLYgD1BgbWR6Bn6VgqYQ+zPu5o391Kjk+6Wh0sK90Cg29E
         1CsBMej5krKfd0vdd6vqt2Xn30SmAjR0HMRmseei+dw9XrEwvx+QydQR39JVc4T4AxKX
         Ptww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699207638; x=1699812438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+9xh+lKfavFC70jk1+AZh3XuK04oLoTgytZlUJCpHQ=;
        b=F6xHzs+Jxe1KxT7h8WSexjio5qYPLzhqzr+l073IBSL7+PzcwJuPsXQVrxJtxxQZJA
         SAJkR17CPMe1u5W6W2c9X2pSFPz/BD5ctFMEepCW4/nCyW2IzxnHjZ38xmi9HSgrq59M
         KwYYzBElWeD0YI6Rn/n65fuxw2wllatP5+AAiqbFWi5g4qmKBgesDkdhkE0e12bxHDsy
         BG+YZuz6b/hE+Yjgp2kv3BTmyt5LuAjxK9EpeA5mMrgMaQlFnFuQtwHkQGSfHkDtu/kn
         kVh5l5xZbR5QZ1fIQjKl30ZN3RDpJBg9Hoboi3pMzaxxTGt5/8FUJY3IPAXELdVE8CSk
         Fv0w==
X-Gm-Message-State: AOJu0YzwusBY5cnaE96WFUN12n8MbyusHi/ialJAuB0ANroSXeEmx4Mk
	UEApYlPm1X3Pa1cdW4pCmuqOVQ==
X-Google-Smtp-Source: AGHT+IFl3IQxvLZELTq3kE308zizMEsc4NuvXnDoLqody1xDcYbj9N2J2BKpeHEEoYFvFpZ+d4l2TQ==
X-Received: by 2002:ac8:5c4a:0:b0:41c:baed:2941 with SMTP id j10-20020ac85c4a000000b0041cbaed2941mr31136800qtj.15.1699207637766;
        Sun, 05 Nov 2023 10:07:17 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id g4-20020ac81244000000b004197d6d97c4sm2661909qtj.24.2023.11.05.10.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 10:07:17 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qzhWm-001Fcr-R7;
	Sun, 05 Nov 2023 14:07:16 -0400
Date: Sun, 5 Nov 2023 14:07:16 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 03/13] iommu/amd: Introduce struct
 protection_domain.pd_mode
Message-ID: <20231105180716.GG4634@ziepe.ca>
References: <20231013151652.6008-1-vasant.hegde@amd.com>
 <20231013151652.6008-4-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013151652.6008-4-vasant.hegde@amd.com>

On Fri, Oct 13, 2023 at 03:16:42PM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> This enum variable is used to track the type of page table used by the
> protection domain. It will replace the protection_domain.flags in
> subsequent series.
> 
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 6 ++++++
>  drivers/iommu/amd/iommu.c           | 2 ++
>  2 files changed, 8 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

At least in smmuv3 it is very close to not needing kind of indication
at all, the only remaining tests are under ops which could be replaced
by per-mode ops.

It seems like a saner design to start a the very top of call chains
knowing what is required below.

Jason
