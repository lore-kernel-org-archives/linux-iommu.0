Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622BB36093
	for <iommu@lists.linux.dev>; Fri,  5 Jan 2024 19:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QFwwn5ad"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-783045e88a6so117096085a.0
        for <iommu@lists.linux.dev>; Fri, 05 Jan 2024 11:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1704482545; x=1705087345; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eFYxPznrYDwPFeTL0EyC0fltoDSqr70+c91hOTw5kkw=;
        b=QFwwn5adMFRIS5E1cSRELiY3uvC8RPVIG3Fj99v267fJMZeAJAkkFkA3q73ewy6xNS
         TZEhtuZ+tT3SOdPQ8oNUqedgwcMDdbTrdnrx0pwC7sGNlsYM8tQZAs/aC3Y6snZZ7ATm
         oImGIeA77cAjNvS14EPM6i5WqoRWbOiQ9s/POdHvIQ/XCuN5FOJ78l/ZWmaOA8kZDiB7
         VbMULbuIFxlnbxHVlmcHxxqWfRXQUqLuOsOpFSoD8m/1lddFK5X1ai+sMHxExjcbUa7h
         8uWugSv3igMB6SKmenZD39K1mubnLmZ/5IDszRPbwJI7NBm+bhdnD4nzhCEXDrDQPN05
         NN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704482545; x=1705087345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFYxPznrYDwPFeTL0EyC0fltoDSqr70+c91hOTw5kkw=;
        b=nVeGUvT6I3Xblax8VegQro4ggr8t8NF+TMg29gCI4n0EAYkPTNqnQg/Za1jmlPo12P
         UBZ4ezcPOt5LBc/CSmPjbqUzVoM2BzZxxjltZlXUSUMaW7fFx2GZ+NUq0+he5LeHpoX3
         a/H7HZi0SBcM1Ov3IPDgBpPO3CwBz1AwOcHEYDMir79ruKGs6PZ9RuTEsczy2Tq8RN9b
         G4qCvqZUJ1PPSZcyocvrOFate2ddOg1IYfdJkib7Vn+9DUICxfxdWZnHQzxgT9Z6tjfx
         wCWhfPXTdhfyRSAlD6cUH5z01N7PYVLYA53nbTGaglzFCntfxU1rBBVRXYu57WscZldp
         LEtA==
X-Gm-Message-State: AOJu0YxUr5E2/zSdBToSnEXLjzZrC1dNjw4gnnwrHhPZZH+Yi+emCNIm
	7ffy+2GmBa1FiO6in2t6l7HrSc7oZeD23A==
X-Google-Smtp-Source: AGHT+IGOlM/awXt0sdNQv2O6OOQ3NukkUTtzI8DMH3kd9arocU2FRSpBTakTmmvy3zuQVh/7xaB8rQ==
X-Received: by 2002:a05:620a:190b:b0:77b:d5d4:a105 with SMTP id bj11-20020a05620a190b00b0077bd5d4a105mr3302686qkb.38.1704482545287;
        Fri, 05 Jan 2024 11:22:25 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id c10-20020a37e10a000000b007815a43d297sm800697qkm.40.2024.01.05.11.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 11:22:24 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rLplw-001Vdv-Cz;
	Fri, 05 Jan 2024 15:22:24 -0400
Date: Fri, 5 Jan 2024 15:22:24 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v4 15/16] iommu/amd: Rearrange device flush code
Message-ID: <20240105192224.GT50608@ziepe.ca>
References: <20231212085224.6985-1-vasant.hegde@amd.com>
 <20231212085224.6985-16-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212085224.6985-16-vasant.hegde@amd.com>

On Tue, Dec 12, 2023 at 08:52:23AM +0000, Vasant Hegde wrote:
> Consolidate all flush related code in one place so that its easy
> to maintain.
> 
> No functional changes intended.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 92 ++++++++++++++++++---------------------
>  1 file changed, 43 insertions(+), 49 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Usual remark about not moving code without good reason..

Jason
