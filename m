Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8D02E65A
	for <iommu@lists.linux.dev>; Thu,  5 Oct 2023 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jxo3qqNV"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-d8195078f69so1482215276.3
        for <iommu@lists.linux.dev>; Thu, 05 Oct 2023 11:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1696531229; x=1697136029; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GA7m8rwe0k1pFYhUoJZj68DQDssw+4ZBgs2lOlxIr1I=;
        b=jxo3qqNVry67z/PSn2TnFwCcwxzq/lhnEYxzq6gPUd5vJkPCDmUHXnUIloqxK/hSz5
         KtAQbVdpP+1VJfTqivau3ZWPae+qi0+gFa/1wwWSk5KoNY0Fu+vv3EsovfVfPZB/p669
         bp7wwNVcMYEa/hN+AEP+hkI5p3gIIfJY+KIyeRGtUWDGieZ8Q5BTZ16VjgsN7+DSfSZa
         ecmZP2TTDVOAcQF13clWbF02JYZmdAjXOQV7bl99dqTI4t8SdnifVo9DRZqQs/xW/YvJ
         MewERffVQx2rzdiLgqT1RcsgCwtdDeax873Sa0QLiy4kQ8I7PR9Dh6bbeOuFlAQf3h4I
         wmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696531229; x=1697136029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GA7m8rwe0k1pFYhUoJZj68DQDssw+4ZBgs2lOlxIr1I=;
        b=Z275e/XZv2yMoh1RT6qSY7ZDExhf2HO7I0QPWk8/H6tMYlKYoPTE3jB3v9JApHQksV
         AqfoGR04s7EDknqUkNU0Sw4YpmtAzRH/0s3ey7g1R+RjTo/lnukGAVkgYXA+gYrKLo5v
         0EmX6THc80QOnqhchpOjsYUjgcOlyszt5cxVE7Tr7vtAbM3ScOC7v95naF0PPn5UxX4C
         lxTKyHWQrCkTVsSvx0XKCiT3eKlzneCavzPrWVfIBx8cptXkOEjxLYCzP9Idiya+INAX
         croWqnuL3mRgRTan4TuNnG7EqbnMvurGPKmj5ebl95kclESp8i+uuaQJ8yDXJRwxm/Fz
         FOjw==
X-Gm-Message-State: AOJu0YwUNxdH0fjuJgSdGyi+J0SuaSP21RA8mFdESjbQEmR4JpXPphpH
	SDvkmE42Hk2Xy3885GdTqm9CbA==
X-Google-Smtp-Source: AGHT+IFSdPnLfyqRjiwDBgMR0Mn4eMujqBf/xiPgg8OR5KohHrBUwIBC0U8szG5MhEvW2qYa7uM/JQ==
X-Received: by 2002:a05:6902:1896:b0:d7f:362:1d9a with SMTP id cj22-20020a056902189600b00d7f03621d9amr7698100ybb.2.1696531227223;
        Thu, 05 Oct 2023 11:40:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id u14-20020a0cf1ce000000b006560eea8a7esm692821qvl.132.2023.10.05.11.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 11:40:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qoTGr-004Z3U-Nt;
	Thu, 05 Oct 2023 15:40:25 -0300
Date: Thu, 5 Oct 2023 15:40:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tina Zhang <tina.zhang@intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
	Michael Shavit <mshavit@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/6] iommu: Add mm_get_enqcmd_pasid() helper function
Message-ID: <20231005184025.GS13795@ziepe.ca>
References: <20230925023813.575016-1-tina.zhang@intel.com>
 <20230925023813.575016-3-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925023813.575016-3-tina.zhang@intel.com>

On Mon, Sep 25, 2023 at 10:38:09AM +0800, Tina Zhang wrote:
> mm_get_enqcmd_pasid() is for getting enqcmd pasid value.
> 
> The motivation is to replace mm->pasid with an iommu private data
> structure that is introduced in a later patch.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
> 
> Change in v2:
> - Change mm_get_pasid() to mm_get_enqcmd_pasid()
> 
>  arch/x86/kernel/traps.c | 2 +-
>  include/linux/iommu.h   | 8 ++++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
