Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B01A481D5
	for <iommu@lists.linux.dev>; Tue,  6 Aug 2024 17:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722964016; cv=none; b=XlDTp5J4PmZ7KVRTuqKEbBi35qp3EymvUCck9zRQoEzxf+WUBWfRfo4H4rIC6viSmJmX2OUYZmMETcpYmk/ZAvksrp/ewlqWNtp600PvhjXP8rRE6yHsNuyfkAKE2eneqlACyn5b11MvqQmNGyzr25mqwRU2o3bYXOQPuKTWNXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722964016; c=relaxed/simple;
	bh=pYXWVAixb0TGzW0+4z41mcpkWJcYtHb79k2+mXUZ5kY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDo2UKzX6vQI9GXnuh/1w93YrwCrz+m/hlDUmqysvtGGbVG32qhLykiI1AC5Ap72HhBbCqFcHDFuqE1vPN7t1okQhihBm59dcf64TJFooQPtaXP4PpKmVwGSg9R2DAPdX4Fn5X88OWmwu+KFjfloEJXB18oWBxr3dt+XVLP69cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iY5tFPnn; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iY5tFPnn"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6bb687c3cceso4323236d6.0
        for <iommu@lists.linux.dev>; Tue, 06 Aug 2024 10:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1722964014; x=1723568814; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZupS7pfQdW0meLSGlAB6m+Zc0i+CePa5pRy6YLAKXQ4=;
        b=iY5tFPnnMqwsALcKWh7lbmlqXFSFiAKh7kttpxqfVTEifQfGCBLJZAiy+yQConn03N
         sWenYvli/TXPzXpIrYdH6iJAOmB6OKEeC4plyUKJZFUmn38oqHX4Bei/qh/7FQyTMw9W
         +4zvsC00HSZi6cHRBIqiSWZZELT4y/kEEQF1xW42MWBnTug7+ljtUwz0Pnkurm85ASgg
         aJc2ZkXlYJ0Zu9Nr91Qe+VeOYWP7VBgfNbPWpBJwajIBBkryc0QhnVw8zF8vSern0N9Q
         OVkXgrTNZvbX2mBk61+pcARn+HWn5Ul7Sgd+0CRLWC3NTXdq1gO835HziuK4773kJceN
         5HJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722964014; x=1723568814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZupS7pfQdW0meLSGlAB6m+Zc0i+CePa5pRy6YLAKXQ4=;
        b=qgXpQ2cEQGN01kjtDUj5AUahm7tKONF71inaYJ/pwPT9dHd74Jg37pN3sNon/kopiJ
         vs3RnPWVpyZkvft+IB7OGD28lFC7s1wOA4ibvmIbHVxTMUNZSOFjyxuOtrYFlBHSMRP8
         zXqFnHBPVDcOCbR13qyFED3Z9dgY5btYnI3YwlPdOewXBK+U7Gk3Vo237Jj7+QLSgdL0
         Z79R6Cj86KcbH1RZszB5JuTgdB05im5VNKl2lVYysvvM3qGzfHpnUHvcwMFlDaUjfIDD
         pZkt183NUP/E9gvGRLU5Ncz3D5+laHXJ2zVOJTJuCnPSN0czxkD3/zfI5RricINL6oCK
         /6AA==
X-Forwarded-Encrypted: i=1; AJvYcCWq5YalliHmnMoTQVSsb9TLzL/d/UrhNk0xU2LSGDxgN+jaFDtsjMB7evlRGjlRk0b3/q8LMaQzUEy0yWNZlN5HXzNc/qI=
X-Gm-Message-State: AOJu0YxpDNq5DC5pNACNhqmqDNzMOvRwyO0n62zfdUjtJ1/avo6qMzeX
	PfynzFRfAzODIcHIWk7ipyGRDxOx5Q5XwzpBMsM3c3bgR5D453sdaxut0CaXifm6uPNdiHViEHW
	i
X-Google-Smtp-Source: AGHT+IFmWGNv3wd4KVGiX2u4W4ZqwihouWJ7Lf6SWUySvG5saWPfrszb6atjhcfd6w1r+BLQVZDajA==
X-Received: by 2002:a05:6214:4985:b0:6b5:e1fb:68ee with SMTP id 6a1803df08f44-6bb983b8d74mr214316966d6.25.1722964014192;
        Tue, 06 Aug 2024 10:06:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c76f8ccsm48546856d6.4.2024.08.06.10.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 10:06:53 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sbNe9-00FTrp-6p;
	Tue, 06 Aug 2024 14:06:53 -0300
Date: Tue, 6 Aug 2024 14:06:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] iommu/vt-d: Always reserve a domain ID for
 identity setup
Message-ID: <20240806170653.GL676757@ziepe.ca>
References: <20240806023941.93454-1-baolu.lu@linux.intel.com>
 <20240806023941.93454-4-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806023941.93454-4-baolu.lu@linux.intel.com>

On Tue, Aug 06, 2024 at 10:39:37AM +0800, Lu Baolu wrote:
> We will use a global static identity domain. Reserve a static domain ID
> for it.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 723ea9f3f501..c019fb3b3e78 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1440,10 +1440,10 @@ static int iommu_init_domains(struct intel_iommu *iommu)
>  	 * entry for first-level or pass-through translation modes should
>  	 * be programmed with a domain id different from those used for
>  	 * second-level or nested translation. We reserve a domain id for
> -	 * this purpose.
> +	 * this purpose. This domain id is also used for identity domain
> +	 * in legacy mode.
>  	 */
> -	if (sm_supported(iommu))
> -		set_bit(FLPT_DEFAULT_DID, iommu->domain_ids);
> +	set_bit(FLPT_DEFAULT_DID, iommu->domain_ids);

That should probablyturn into an IDA someday, it would likely be more
memory efficient than bitmap_zalloc()

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
