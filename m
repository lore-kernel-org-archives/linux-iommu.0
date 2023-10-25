Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F126F2D616
	for <iommu@lists.linux.dev>; Wed, 25 Oct 2023 13:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kpT7peeK"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3b512dd7d5bso1215787b6e.1
        for <iommu@lists.linux.dev>; Wed, 25 Oct 2023 06:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1698240878; x=1698845678; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yWRrV8TrzcGhn3y1mwcKlcTnHxjvKLZ2v/fGWRYHR+Y=;
        b=kpT7peeKFKCumY3+Q+GRpKg3bO6nnu12AQiN+bSQpVI+3QfVFRzgM+gzfYu+fek/Ha
         e3HIVkb4w3UZbd1dAV+9fjoWnfE6rI37ltHwLMg1J221GqOmmdQM2v2dKTSnx6WoaRGO
         pceqc5xUD5oH8SFdFly1z+pO0En0FoCk+Fe4cZlRW3K0UJeNWukFZawnoMu2z5WFZ0gz
         sqoQRICUiCII1xcTOvgr8gNPEZmkrtbP3ieS/4DEEv0nnLwOo1v78QOP82lHYjMPNYyA
         UFpTIMWA4K0QfsS+sGTjyLtz/2qvjiWMbY7+moiDrlYWS9bv9CDpWlxD2mfLJxXp/tTT
         LoTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698240878; x=1698845678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWRrV8TrzcGhn3y1mwcKlcTnHxjvKLZ2v/fGWRYHR+Y=;
        b=hpNId+KadkNYDjQ3B9bGBYyq/V3Zdm7YsqWmZCQdSYT6aZhqDOtyTeXZQJHvY+puOc
         imOfS47Drca7qx1HvFlrm0fUVPW1m/Zw0ESGfdC+GQgBNnn2+Wv2tOVu8efnVUefcCWX
         XERChBI6577+sbblKKJjPpiBr7ySprnZAVUBRGqFlF+5XhNcZk7k+KeI9zTAB5R65JnV
         7ERFlcSE2Hhtls654b8JG2euTL1S3esPH1BKuMVC52ZSuJWC6FNpbt0i+Q+L71x3eKve
         qLv69QQE0Z4lWfjSJ7xT0kYz4nPO2SPQahY8JvPVU7c9m4EdW2v/xNpnDyi1VKWDjG2B
         KpVw==
X-Gm-Message-State: AOJu0Ywxy2voV/ruzSp8sXBVVrfOl1DI0KwsUj9GNE85721hQklkz7vS
	54M4GI6o+dHH9TET6DqzWTj99Q==
X-Google-Smtp-Source: AGHT+IF2TgXBS3eDpm+PeKpS/zyKzW+Q8bERmNhr7qjghP/HnyXpWPs8Xo07ycy873fwfyVKg1IAww==
X-Received: by 2002:a05:6808:b29:b0:3b2:f576:3f97 with SMTP id t9-20020a0568080b2900b003b2f5763f97mr15973522oij.12.1698240877826;
        Wed, 25 Oct 2023 06:34:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id a26-20020a05680802da00b003ae0e57874fsm2370339oid.21.2023.10.25.06.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 06:34:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qve1s-004gmc-4f;
	Wed, 25 Oct 2023 10:34:36 -0300
Date: Wed, 25 Oct 2023 10:34:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Revert "iommu/vt-d: Remove unused function"
Message-ID: <20231025133436.GP691768@ziepe.ca>
References: <20231025131854.375388-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025131854.375388-1-baolu.lu@linux.intel.com>

On Wed, Oct 25, 2023 at 09:18:54PM +0800, Lu Baolu wrote:
> This reverts commit c61c255e114c52682546447ed44d3470b5708134.
> 
> The pasid_set_wpe() helper, which was removed by the reverted commit,
> is still used by the nesting translation support in the iommufd tree.
> To avoid a merge conflict, revert the commit.
> 
> Link: https://lore.kernel.org/linux-kernel/20231025153455.283c5b12@canb.auug.org.au/
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/pasid.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Needed to avoid ugly conflicts with iommufd, Joerg please take it

Jason
