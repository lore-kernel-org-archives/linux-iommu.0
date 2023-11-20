Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0181B282
	for <iommu@lists.linux.dev>; Mon, 20 Nov 2023 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Zehqc1vJ"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3b6ccaf0516so2669421b6e.0
        for <iommu@lists.linux.dev>; Mon, 20 Nov 2023 06:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1700489242; x=1701094042; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dtTFOxKWbZfwNolFiplUiXEYr9h+c2cIVO+Z2ob7Zak=;
        b=Zehqc1vJO/XpGqGE6Hli3d0cEZOQmnBD0/NTF0IHTOd51onQAf9E8weT7FExobfUYo
         /wVhZjvni5FSYSFtpcaSDocVkfuXzRjKgsgdiC1zmOnqtd+tsnycAUwLAb/OYVhHzgdk
         EJ5ZB6KLpGomLtaU4EMuWuDF/6ltbi7kIBsYg2AcwtCxaeudjcmLztsGjMSFeAi1yAJg
         yDgDtZvKecuVFsOMH8MzWAhon+6EwaasNFzooZLQUsqDBzAB5bFkijjO1d0biE0R6PMf
         pEWnhXPJA/NyAJ10bVP3EDkGWLPrLtFJB+ZElJKgD7epki0MSKbq1LusBeK6lznd/T2z
         47zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700489242; x=1701094042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtTFOxKWbZfwNolFiplUiXEYr9h+c2cIVO+Z2ob7Zak=;
        b=BBw3NQnaATDTqd3Ofa9jRGfDV7RLOuEvYi3dwy4iIpEshCDfgLzadwEZ15MdBDGPAJ
         lKrvb+CX4z6Ja60J5ndGnQl3UuCqsw0TCtr+Oz6DTaV5imaslnV0tmDSWrWy+HPwxTjd
         Z5HmSVLGw46LLW4hqgQLgb59gRajS3l4IcrE+wyxrf+bwjj+x5MESlMHH9avumXI0EKW
         hEkDwcL7qJmt/lHuHoGY1yE8sqdvE2R75wot9bnchBsn6PnN+xU1jh5L7S2ndhh8SK3G
         oMC1CWu7YVyZkyCN09JU9++aYHFPRUgX/aGS55nRikXwPgrUti0vQWtkLAhzX5fI2ptZ
         a+0w==
X-Gm-Message-State: AOJu0Yxo6ck9TYB5oFRO6dGFxUG1+GUgapLQ3HYqkjVYDQqv3nictAQA
	iibPcbemJs2KuS8eihJoutSzWQ==
X-Google-Smtp-Source: AGHT+IGKsTGLM718ckD3rnBPLZlMZ9DtHCfdorOXO342ru0cGWgBCz3/aJihfBC2iGk2diECJZvEYw==
X-Received: by 2002:a05:6808:2123:b0:3b2:f344:3a41 with SMTP id r35-20020a056808212300b003b2f3443a41mr3189406oiw.2.1700489241828;
        Mon, 20 Nov 2023 06:07:21 -0800 (PST)
Received: from ziepe.ca ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id dd1-20020a056808604100b003a747ea96a8sm1262478oib.43.2023.11.20.06.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 06:07:21 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r54vo-000Hxj-A2;
	Mon, 20 Nov 2023 10:07:20 -0400
Date: Mon, 20 Nov 2023 10:07:20 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
	robin.murphy@arm.com, kunwu.chan@hotmail.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Set variable amd_dirty_ops to static
Message-ID: <20231120140720.GB10140@ziepe.ca>
References: <20231120095342.1102999-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120095342.1102999-1-chentao@kylinos.cn>

On Mon, Nov 20, 2023 at 05:53:42PM +0800, Kunwu Chan wrote:
> Fix the followng warning:
> drivers/iommu/amd/iommu.c:67:30: warning: symbol
>  'amd_dirty_ops' was not declared. Should it be static?
> 
> This variable is only used in its defining file, so it should be static.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  drivers/iommu/amd/iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
