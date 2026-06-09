Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E65A48B38A
	for <iommu@lists.linux.dev>; Tue,  9 Jun 2026 17:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781024837; cv=none; b=Fwk+1R4GScbP2TBD0Feo05X8NugSUc/Q5su40eTxRgTuTAw9wPgMHktHMtH5smK4SmcqHJzD2PeQdSwbBK13SUnv5zKCnTMpOtmuVH9X1HrkBMrboKJvpFolW9DHQwZpM7vhjdOgJY0g97d7WPsyorKAlDiH2Jhb8PmJFQ/W9DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781024837; c=relaxed/simple;
	bh=RFvWghnlKdtFZoSnaeTAwrwguE/F1fpnRlI47Dca2n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhtl7iuI0cUKbG2ENspf0JNgUGpL7SFER4FJGrOX9n8DjkoI0lpgUgkzo+1AYC+5ji7GSf16BPZlHz3dKzjc9fUSghtGyBIjEhkCMfFP5PXQyAUPee74742NE76vWloN0A2UiFflEcv7DrBXLaGHa1dQNs58i+O5LrZBitI7nSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Q6W5Vw6M; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Q6W5Vw6M"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-517dc520840so1275391cf.3
        for <iommu@lists.linux.dev>; Tue, 09 Jun 2026 10:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781024834; x=1781629634; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/g68/vwtxQJn0VXkFA+3HliWO9dvMA4L/BKpylMlbCs=;
        b=Q6W5Vw6Mu0ZAUdzBOmfyEHnM2SETSO7OqDS0avE9Ruu0da2yYDAtdBqmtKO/61Kuko
         60gAeJSF+Y9Z9M2cjU6lehU7G/gLL8H2eUkX5a1GVBnSUk+ibCU3R7ciqYm1IL6X81Qf
         3zjNYba7KZXOygE4IT8KbPGFMA+7E4OTu5GEpL4r2oMMyWw+Rb5NQLipGismNh/biSF0
         5x7HYn8F5kELL4j+1bW1EPERS6oHea/1dnf4Tgk5vkD2VCqqbSunQziftso8Lk5zRC5+
         RxHBm/6AFFXozM4qpM8B5uQphMVwzK0nUmH8PuoUKX3vHvDCrGFWN3ZqZIkQ6xpI3Hlh
         qxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781024834; x=1781629634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/g68/vwtxQJn0VXkFA+3HliWO9dvMA4L/BKpylMlbCs=;
        b=gxGzEYv8SxCceUeWI6uv1oB3rdRswJAUGP741OHldftoxp2G0HyPE7ftv9eKLDJwLJ
         f8j6BjnZ/WK+RajK2+mphOFXmmpEP4rhnKZ1yiPTQTx+tOUNPrULmUhrJTcy+Mh9uqfF
         PpXIiX/fm5Jq7c0+2MP+4ki4nocTujGj4OthWZ/Y/sZjxhc8VKMWwHksgmINmgwS8Cdt
         QnsepymNSqQMK9U1NB8eOCO5Cylg+/2oWOWRg+arUxXrPv34/+9Y6JwxnGz9ZIDgmXX6
         qJ/0IJwhy/C5ewj0XlKt6mVzlyF2pEBpweX+jla2fqdC4/uSke4IefzK6pg3isEtE+8o
         bcdQ==
X-Forwarded-Encrypted: i=1; AFNElJ/3Lt7tQA9sK75/pAn5e3XlWBKkSJSOELV6p3idi/rIZesMVniI9lcGlDzFXRCVLg4BpDqqLg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzxjcENBm0fTQw1S/S5xKsj5JaykP0a3SQzvROllHT7WgpOlLZN
	6VLn+Cy+p6+nvFumvAlFK79bdoSigDxjjp/DihIA4pOqU1YHApj441cNTXoyGbYumps=
X-Gm-Gg: Acq92OHG5MGN5SrG8s5nYt5HfJYjCq7ExHi2p/RKPadcAJ4LaJNkhB0ITV7xMFVZ0ss
	Pe7/Ccv6IVWHxDsVZiViyi74N/fXCsasuyy4YEIevtACYOkDfYc6pb57opyJkBJE08PLb+RbDI+
	2uVU9tVzpEk7t6Hp4FyDLWNKJr/+xnnj8D3bBZcw3Nuxb4e5DklvVTUIp8lDVuAMHGy0w8TpbaT
	5Qy3vYsvfzh4VBxwwIUH5svpO/v6mfmSTImyqryLz9B+VACxmZwTW4nQHb0yKoY18zjRNyblIO7
	lO8Z7ZYyadJVdULmZleEGDheC+cUEYt2JgiRv06Aq02TH3vvivi2Nv9pNi+j3/tfOOvURZd9jaj
	ykWMHLhs3UF/klXLPAr95O5GKUMC+aGi1IkPbDlaKKLUGX6+nZRkcJHGLup4bmC758ozTRWfQcn
	Hit3h+KzOke1w3yJXSdF3hyRBDa/ZDHZNKW0UlogwGKhRlOW1B4Y1XOJCzcANP6jRPmEthkLye0
	FG97qhcFdekETd8
X-Received: by 2002:a05:622a:114c:b0:517:1481:54a with SMTP id d75a77b69052e-51795ca0588mr328689211cf.53.1781024834216;
        Tue, 09 Jun 2026 10:07:14 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51789407da8sm162209711cf.19.2026.06.09.10.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 10:07:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wWzuz-00000002IEI-0OsB;
	Tue, 09 Jun 2026 14:07:13 -0300
Date: Tue, 9 Jun 2026 14:07:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iommufd: fix refcount leak in iommufd_object_remove()
Message-ID: <20260609170713.GM2764304@ziepe.ca>
References: <20260609032243.182433-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609032243.182433-1-vulab@iscas.ac.cn>

On Tue, Jun 09, 2026 at 03:22:43AM +0000, Wentao Liang wrote:

> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index 8c6d43601afb..2fe790c2c69e 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -266,8 +266,10 @@ int iommufd_object_remove(struct iommufd_ctx *ictx,
>  	 */
>  	if (!zerod_wait_cnt) {
>  		ret = iommufd_object_dec_wait(ictx, obj);
> -		if (WARN_ON(ret))
> +		if (WARN_ON(ret)) {
> +			refcount_dec(&obj->wait_cnt);
>  			return ret;
> +		}

The WARN_ON is a big clue here that the leak was intentional. If we
free the memory we know is still in use something worse will happen.

Jason
