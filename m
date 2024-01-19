Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D55755C28
	for <iommu@lists.linux.dev>; Fri, 19 Jan 2024 19:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705691399; cv=none; b=lQPVFn8+BC+crgFIudJFxSJNLP413QMro6jdepZat2NqNqLqi8FFzHWsqB1Tz3rZcDaX/GSJz2iwoi6ukYpQQXJp7l4GoQUIE5Zl2O8fdFcfk2f+puMgmLkDIv8XnnamOFyOAN9SjZnDrDAtmExAhYZLHUJtV2+rxefFDfOd1I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705691399; c=relaxed/simple;
	bh=bKKBC5wdMxBNzea0NnMCKuzGRQ4ZcEovhaSYRRA5XWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DilFNt5GzQMCDS1PDYjZ+gM46zabOwiyKfU4Pd4E35I6iaV70YvlIzaBvscnUwQGDWWDFgP8pWd1Kn9Rpgd9tkF6V8ab0/lBnBy6Ew0j8f2QabzNmQmr6kDHmVzuBbFV5vAQNr+4k2aIk+TRCQ3JJvKY+GdL4+h3SbV4UtlEN24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TI1W75NM; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TI1W75NM"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5994f6a4a2cso523619eaf.0
        for <iommu@lists.linux.dev>; Fri, 19 Jan 2024 11:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1705691397; x=1706296197; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8P42EY+LAYXxboTeapemooWprrxPwjhbzbjthT/dHLI=;
        b=TI1W75NMwb1ed0pELp7di957aSbfbSq1o4xc4sekaqOXUJ1eU5D5YiFCpnUnkB22U7
         NA4VElHQe+JZ2hpKaSL0QbR/NUyVsRjcw6iq/KgAkAUDY6s3VKjOUCD9U7DSFPYVTn28
         hk67fAgfr84/m3ZgpIe+SGgV+9Hx32iHflwLDxnCwyB2uuPbZrU2ofiFXwElfbWA8NpC
         RkodY945rD+8wUp2jv0snhgoJ3mAGcJsvmcKMyb1h3ui+IpgRooUmdT0G/F6L9/8hpfB
         r7GaF7Nz00RgJg3cgWkQuWNtHh/zw6BA9ik+MNiQNESMS7C9gKXrhIvvCEQMSjnZTjrX
         KtAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705691397; x=1706296197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8P42EY+LAYXxboTeapemooWprrxPwjhbzbjthT/dHLI=;
        b=Y7acS6SvhHauddC8rzxubheob8x7/m+WWpnhVGTjXrcl6esVLxa/sUsdI69ce0BA+O
         aRo18g9VIhvQvDQRe6reICLaumsj67gzNXmWTs/P9aVBoANgc/GnReQLJI5Lv82NdzjX
         p+kanXUciOPuuPnmq2pxRQ9UH2by86jo0fdgwvYiRxzcXGi9Ae3M9z4jiczyF8hwx6Nk
         iJVor2DFklPUPLIKb6bN8kaHuWzm5t8w0RkKz8lnrm9JkUMSXMltPUUqrarSANmC8+OD
         JieD8luO8oIqO9e6n/UcmlXHMkW1VnHsBHTHl4Nf9sfmwncBSvwhuwj1gKGS8j4F0aAx
         pBcQ==
X-Gm-Message-State: AOJu0YxEaLAwc/JqIWTFkDtunXhqU3Cl2l4yuSDoW4q2K3rwZj5wHZ4v
	i/PYbCfHfLWeeqDAZur1LV1+SVOPePkMR5sETQ6TbdZ+9zLvMIUJBB4//0G/A5Q=
X-Google-Smtp-Source: AGHT+IEp4bUl2sup4u8cBx90qzZgAhBGJ47pc2icULix/QheH11lwl1aPHmqUOq8JNCV5LDxX3n33Q==
X-Received: by 2002:a4a:e0d9:0:b0:595:5276:5b1 with SMTP id e25-20020a4ae0d9000000b00595527605b1mr132007oot.19.1705691397252;
        Fri, 19 Jan 2024 11:09:57 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id r124-20020a4a4e82000000b0058df6ae23fdsm3267166ooa.33.2024.01.19.11.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 11:09:56 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rQuFX-005lb6-Qg;
	Fri, 19 Jan 2024 15:09:55 -0400
Date: Fri, 19 Jan 2024 15:09:55 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v5 10/17] iommu: Introduce iommu_group_mutex_assert()
Message-ID: <20240119190955.GM50608@ziepe.ca>
References: <20240116165335.6043-1-vasant.hegde@amd.com>
 <20240116165335.6043-11-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116165335.6043-11-vasant.hegde@amd.com>

On Tue, Jan 16, 2024 at 04:53:28PM +0000, Vasant Hegde wrote:

> +/**
> + * iommu_group_mutex_assert - Check device group mutex lock
> + * @dev: the device that has group param set
> + *
> + * This function is called by an iommu driver to check whether it holds
> + * group mutex lock for the given device or not.
> + *
> + * Note that this function must be called after device group param is set.
> + */
> +void iommu_group_mutex_assert(struct device *dev)
> +{
> +	struct iommu_group *group = dev->iommu_group;
> +
> +	lockdep_assert_held(&group->mutex);
> +}
> +EXPORT_SYMBOL_GPL(iommu_group_mutex_assert);
> +
>  static struct device *iommu_group_first_dev(struct iommu_group *group)
>  {
>  	lockdep_assert_held(&group->mutex);
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 7f6342bc71c3..c983b6a1ebce 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -751,6 +751,7 @@ extern int iommu_group_set_name(struct iommu_group *group, const char *name);
>  extern int iommu_group_add_device(struct iommu_group *group,
>  				  struct device *dev);
>  extern void iommu_group_remove_device(struct device *dev);
> +extern void iommu_group_mutex_assert(struct device *dev);

This shouldn't be unconditional. Like this outside the other ifdefs:

#if IS_ENABLED(CONFIG_LOCKDEP) && IS_ENABLED(CONFIG_IOMMU)
void iommu_group_mutex_assert(struct device *dev);
#else
static inline void iommu_group_mutex_assert(struct device *dev)
{
}
#endif

And a similar ifdef around the implementation I suppose.

Jason
