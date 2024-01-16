Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03211C2AE
	for <iommu@lists.linux.dev>; Tue, 16 Jan 2024 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mv05wFXB"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7833a51a1aaso559644985a.0
        for <iommu@lists.linux.dev>; Tue, 16 Jan 2024 06:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1705413651; x=1706018451; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KOuNVOVXORCvY2aDTKNJEXN0vs/stvoH39eXEuacNQ0=;
        b=mv05wFXBvFTkEYFqdMgmGe2AbUIpKCiYTtuDmpc/tW7yzCSmFcVK4zrA2TuwSp3pHd
         lxgyzR6YjvR35Yr+oGMyr1gEX8ailRN78MRrTODslIJcuHI0iSe/40XtF8hNGcStxbTH
         ut1Vzcv4dEt9PddZ9Kd4spREMulhvc3Kv9RYRRxrZFER4L/GMs8usH0dqG9yPtKYoqDM
         pCPwChIKSU7tamK+GIPDPwzd3G+jzRL+UvmusfhQBWELzDs1IhAc3iZcAbNZbOBC0X1E
         EhcVWnwsDoJQRlB8GkVwS7Z3UlBzRihgLpy02zyxBlt0Hp8XpACS8fuqIZaATdhmj47/
         rRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705413651; x=1706018451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOuNVOVXORCvY2aDTKNJEXN0vs/stvoH39eXEuacNQ0=;
        b=HkfWdZ3jzN+T8pE1sprbyp6l32PgXroG6p/1/uZox8StWWqUcfgH1uWULCwdvWZc+s
         uXiJmeq2beEkfb5oCpGGorbBWuRGByRnxAo9ZKjBt8Y+nEwfIekaGEcJKTLA+4xka4CI
         r4N6i7h1YknrISJGhv8StiqnsDTTeMKqlpfhwK6MfAduqtXdm53DEY811tFYA3wQv0f+
         UYnOVYY9JIjBmxt5/ra58c8xnTTODKbZvCrKXare3KpvcEfsu5xhTG7a8dRP6smrZB5c
         CQxtUFxAjJ8XcvarVbwjtY4K1xxLGZ+k5YnQdlpyN6TOv7mr3MZ4WJHX9ypCTcBlXdiv
         WXqA==
X-Gm-Message-State: AOJu0YzkYIRdONyQb1ZXSdbo7M2Ukei1OZb7CwMGEV07Zwir78XNn6KS
	q/u6P9Hk31NWF9/fHBfZ7ICHX8H1edJFuQ==
X-Google-Smtp-Source: AGHT+IGqsYr6wdBWfdWtAB5ISaZXuJ6fkFIV3c5VV02zqNT6k6aF3E8/hH2gFZCkIsCFamzDNDBIBg==
X-Received: by 2002:ad4:5de2:0:b0:681:55c1:3bd5 with SMTP id jn2-20020ad45de2000000b0068155c13bd5mr5533229qvb.93.1705413651529;
        Tue, 16 Jan 2024 06:00:51 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id jh23-20020a0562141fd700b00681645ec98fsm1247560qvb.15.2024.01.16.06.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 06:00:50 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rPjzl-0044xi-11;
	Tue, 16 Jan 2024 10:00:49 -0400
Date: Tue, 16 Jan 2024 10:00:49 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com,
	Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 07/16] iommu/amd: Introduce per-device domain ID to
 workaround potential TLB aliasing issue
Message-ID: <20240116140049.GD50608@ziepe.ca>
References: <20231212085224.6985-1-vasant.hegde@amd.com>
 <20231212085224.6985-8-vasant.hegde@amd.com>
 <20240105185549.GM50608@ziepe.ca>
 <d71a2bc0-ed07-53eb-faf1-bd36b6ff6ffb@amd.com>
 <20240111135952.GV50608@ziepe.ca>
 <0215990a-dff1-c6c3-bfa1-c90fa63b0c7b@amd.com>
 <20240112145934.GY50608@ziepe.ca>
 <5d0f4146-fb57-d700-1263-881e2ec3ded7@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d0f4146-fb57-d700-1263-881e2ec3ded7@amd.com>

On Tue, Jan 16, 2024 at 04:22:16PM +0530, Vasant Hegde wrote:

> > The *device* has a list of PASID's that point to iommu_domains. This
> > is stored in an xarray inside the iommu_group.
> > 
> > The *iommu_domain* has a list of *devices & PASIDs* that can use this
> > domain for translation (ie that it was attached to)
> 
> IIUC domain will be having device/PASID combination something like below:
> 
> UNMANAGED_DOMAIN_A with IO Page table :
>   - DevA + PASID zero (say non PASID capable device)
>   - devB + PASID <M>
>   - devC + PASID <N>
> 
> We will *not* have same device with different PASID in same domain like
>   - DevB + PASID M
>   - DevB + PASID N
> 
> Is that correct?

No, all combinations are allowed in the API.

Jason
