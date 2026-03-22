Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF30D303A35
	for <iommu@lists.linux.dev>; Sun, 22 Mar 2026 10:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774173883; cv=none; b=ocO/BTKcNYozff6kfyxRZvLg2rZtAt8YjiHrd4EK9vdZ6dd9wqdtjCukYwgJpMjAauIJyslTevDa3m0FkfYEFU3l5kvIG7AZ1PMnpcwLTW1H1io9BRgFjjcG6tncthdTAyy69soJh6ESM/oR9DaxvRDwgBLOBuozV1QKnI8U3aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774173883; c=relaxed/simple;
	bh=JXFpcOId5hljyBMRvIswXJUP7F5f7sVrUNNkeou1UIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MfT+DjC5XhAmlvC6Cpo9/bewrBesrydb6mVni+qwgwO1BpuOqP+wgkvEvaFUg0KGXMQgt6gsHZ6SL/2DZhg/L4+EiRyWpXYnO9qPEeVN4fFZU2a3IhRaQbCpqzcCIeovidWLx0jL1EAtyMS5gN8r8cxh3Ot6qGT/xuj2Wegc6HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aNQVypNd; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aNQVypNd"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-486fb990b9eso88795e9.0
        for <iommu@lists.linux.dev>; Sun, 22 Mar 2026 03:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774173880; x=1774778680; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=08waK1gpp0C9CvdH4Hrzkz/c2JUiId3dhgzoaIlZ0mg=;
        b=aNQVypNdnzifq+bnREbkxL33dAk5swW9QeJpTkCpXL4yP4wjSUA2bByM6W37R7OGpd
         t8nMeacbo1vcwXayEZtOZlCSx0s/1lnt0IlS/My3TonVdTX2SzhDzN7kbfczvLiU9pcj
         c8i1dO/birSmrDXRJqh4Uc7m1UVW5FUS6gWTNn4KSPK0p9DGQNbXJF8dMssqPvn0iO3u
         BSagVLwqQIQRSW9TDkPS8yyg7NWZyOO/Yh7z39qIh/cNk0fSSArjuu3CUUaf/9M9hyPp
         XQEjlEui6CmWzlAPjwzFsKLcxCGQgc6ArbzIZFcrEF3kz85IWdPFTRJz6BDtU1AUN9kD
         VU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774173880; x=1774778680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=08waK1gpp0C9CvdH4Hrzkz/c2JUiId3dhgzoaIlZ0mg=;
        b=CNgG/pkEzaA8w2STxoBDvXbVcTUmpi1RVfD5L2f4kOJzYNn4gpQvv3RWV2Zuk6QraS
         6CMZ63uDheFpGf496LwKZpyjfImyvTl8yJ+1CyYl8RxfNBFdh3MqZlrFDzok1v6DzCdK
         NESDaFAaLn/TPhoN+ohkooArEhb+zWPxgS7CymVf3UoIiIXHISXVr55S6SsWyjixqLwd
         USa7XreQSpud2TfBNiRgafUNVXHG6olE/oG0Nu2lusA+kNroD3Hjsz9joIdwS49Yy0ZT
         Iur3G7OCy4xTwc3LBOho1qyjUTB3tGLeBqpwoFWJ9f9qCkD49NssaG78GXdOXmiR7CoL
         eKAg==
X-Forwarded-Encrypted: i=1; AJvYcCWSROOAwbNInnB7neqljfQ/yfhkgmNowoEtWE2jHCgFDM7A85msXVYZDF44p+7F/h8WcrYHyw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwdpgMP245kr9zXXa6eLASKdFlTw78dvEie7QoYptnTn+czandY
	R5GlZ6zNhkmBDKGk7etwl5TIB7ci/Vd94NP1Og117zsSBZjtppKC/nOYb+yL1X/XQw==
X-Gm-Gg: ATEYQzycDdsIebDa5qA/SZ9Fli8/jSNjRKpoRSkLXwOihP8/MBIldrrBlTPZgDZG4Ma
	lkrNWRd3vmrVB7Imb1f9mYpwdLhAlZVXPnNcfQVWsMF/RJ4nHgA1aScuXR50Ia/g8sEpC0PJofj
	YgUICdlf3z1mxvyi0dm30BR+zPQlNXw7wEiHFVf4ETLZ2arpc+hOUQC1fViDsYcUIiO6QO1Eu7a
	8Na+K57eqwktFzMszzQdWOwewK2ccyT2PH8OtiHgBjnijazo/yBy45ni9eMf0tV1GHc2JDyRcsA
	mQj0rlHa+jWEye2mIxHFJV57ahwxdBxliBnKqYfUiAChsVkgXiCiINs4aIivFWx8OrKbzcpDmzq
	ulmm/EFMRUvAI2ysvSkkKqQfp0vVYfuywHLTuD48uaRe0UF+h+0joyojFmUDdC0PV4kesBk7i+c
	xsbnOPIRRTeo11CdU2XW7pd8JdZAogojVisnQyw6VkjvBE9ZxpcZhkqADhqmiIZd/MhBM=
X-Received: by 2002:a05:600c:c1c8:20b0:475:d905:9f12 with SMTP id 5b1f17b1804b1-487034332b2mr810295e9.4.1774173879710;
        Sun, 22 Mar 2026 03:04:39 -0700 (PDT)
Received: from google.com (54.95.38.34.bc.googleusercontent.com. [34.38.95.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae37dsm20239291f8f.2.2026.03.22.03.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 03:04:39 -0700 (PDT)
Date: Sun, 22 Mar 2026 10:04:35 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	skhawaja@google.com, pasha.tatashin@soleen.com,
	Will Deacon <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH V2 07/11] vfio: Update noiommu device detection logic for
 cdev
Message-ID: <ab--s13iPc6X8jIx@google.com>
References: <20260312155637.376854-1-jacob.pan@linux.microsoft.com>
 <20260312155637.376854-8-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312155637.376854-8-jacob.pan@linux.microsoft.com>

On Thu, Mar 12, 2026 at 08:56:33AM -0700, Jacob Pan wrote:
> Rework vfio_device_is_noiommu() to derive noiommu mode based on device,
> group type, and configurations.
> 
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
>  drivers/vfio/vfio.h | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index 838c08077ce2..c5541967ef9b 100644
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h
> @@ -127,8 +127,13 @@ static inline bool vfio_null_group_allowed(void)
>  
>  static inline bool vfio_device_is_noiommu(struct vfio_device *vdev)
>  {
> -	return IS_ENABLED(CONFIG_VFIO_NOIOMMU) &&
> -	       vdev->group->type == VFIO_NO_IOMMU;
> +	if (!IS_ENABLED(CONFIG_VFIO_NOIOMMU))
> +		return false;
> +
> +	if (vfio_null_group_allowed())
> +		return vdev->noiommu;
> +
> +	return vdev->group->type == VFIO_NO_IOMMU;

I see that noiommu is set for both, can this just be simplified to:

	return IS_ENABLED(CONFIG_VFIO_NOIOMMU) && vdev->noiommu;

Thanks,
Mostafa

>  }
>  #else
>  struct vfio_group;
> -- 
> 2.34.1
> 
