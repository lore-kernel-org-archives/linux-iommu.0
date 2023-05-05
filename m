Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A70156C6
	for <iommu@lists.linux.dev>; Fri,  5 May 2023 11:55:54 +0000 (UTC)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-75178b082a5so72851385a.1
        for <iommu@lists.linux.dev>; Fri, 05 May 2023 04:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1683287753; x=1685879753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=szBFeTXcgnKYLfPLuIFAzxMkaRZs5CSgukFz3sIyjig=;
        b=LO4Ii7MgCvK/t2TPTAL8KiO7PhbSdsIaoZBbJ+xhyOrIVLxwoIqJGJl5w84X8jdPJB
         oBM33DX3maempOGCvb++YQQp83kdRUnThnhIhMezWs2bNfIuq01iEtQiJJThfkwsnSpB
         gYvHP8r8dKLUX7vW0rps/C6tckT4Z4XlObmjZMDjDLFw7CH6YD/2n9/vDPl3Z42p7/Sf
         uF1PpAoBMdequAialZvyW42PhHv2Io94OGsWEz/M/TOxiRkAWkVcUTVz8s1eS2/pXOJe
         whvvzSfjVCDxGMgVUt/kIQI+tG89B1Mcp4N7PfR0G/LowFqxKc1rmkQEq8FJ5fnetdcV
         qMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683287753; x=1685879753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szBFeTXcgnKYLfPLuIFAzxMkaRZs5CSgukFz3sIyjig=;
        b=Gybv18glPEsTG59IstUYp/FxsvY7U/NJ2aCDGV+JBJj7FbKpL5ehmyY+5UbOMAhUnX
         K27ePyrKQIg6EuOOYxga1CmJIA2P0jxBDJPrEqR1/5Kfjrv446Iwdi+ETzKUvHy9kZ0l
         56eqZucdk50Yq/WF7OXktImXbvDHkEq8tGzw3BjUaerPKi5C9J5cpe53uYmeHLACkjXo
         j74NhsRE1QJR3VWDtzLBIuzsgqokW+CibFaviqeFEUACMFuGsO3VCk69R+nqkTIixUZ/
         Q4DOktctG9EdunmrXIa75VIfftDdYRBxlbSR37t0H59dI5nkRPCE6NX9c3k0nD6bOx66
         zwyQ==
X-Gm-Message-State: AC+VfDw1ng03P9uFXtfwpIGYX9Ti5G/aTX7ndH4CyG4q+eiFYacJawNK
	SUJR4LVfmSnVoQugErFEKV97hQ==
X-Google-Smtp-Source: ACHHUZ45H4WDO9Ldo40z/BRMFJTWhg3fJeKIgwJk54ONxr1FMldx7OBn6Rs+XtGWqe+LV1CcStgXOQ==
X-Received: by 2002:a05:622a:15d5:b0:3f1:f8fa:11cd with SMTP id d21-20020a05622a15d500b003f1f8fa11cdmr1799671qty.49.1683287753192;
        Fri, 05 May 2023 04:55:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id fa4-20020a05622a4cc400b003ef311b39d7sm513354qtb.96.2023.05.05.04.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 04:55:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1puu2R-007s7x-Nb;
	Fri, 05 May 2023 08:55:51 -0300
Date: Fri, 5 May 2023 08:55:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: ye.xingchen@zte.com.cn
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommufd/selftest: Use fdget() and fdput()
Message-ID: <ZFTux7dKpV5zrQwc@ziepe.ca>
References: <202305051412396252364@zte.com.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202305051412396252364@zte.com.cn>

On Fri, May 05, 2023 at 02:12:39PM +0800, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> convert the fget()/fput() uses to fdget()/fdput().
> 
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/iommu/iommufd/selftest.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
> index 74c2076105d4..d3512fa673a5 100644
> --- a/drivers/iommu/iommufd/selftest.c
> +++ b/drivers/iommu/iommufd/selftest.c
> @@ -583,17 +583,16 @@ static const struct file_operations iommfd_test_staccess_fops;
> 
>  static struct selftest_access *iommufd_access_get(int fd)
>  {
> -	struct file *file;
> +	struct fd f = fdget(fd);
> 
> -	file = fget(fd);
> -	if (!file)
> +	if (!f.file)
>  		return ERR_PTR(-EBADFD);

Why are you doing these conversions? This is wrong, fdget has to be
paired with fdput(), since the struct fd doesn't leave the stack frame
it cannot be correct.

I see your other patches have the same problem.

Jason
