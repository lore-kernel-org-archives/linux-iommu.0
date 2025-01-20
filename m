Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AAF1E1C32
	for <iommu@lists.linux.dev>; Mon, 20 Jan 2025 14:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737383844; cv=none; b=d5a3y0RtSw/C+bZ7AXjJgxvCk51Tk3G7hb8jPNQLo21xqbXnEgZgLmIidCi6lheLMi05hW/owFCxe7nw+vV0vE4/LpFsEB3qV78K9eBhRdr2C5BoaOhDpq/lZrmnrqWKuZay6k8qTvVJXTs/i96QBhnNMZa8XOB0KmIIVyMQLCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737383844; c=relaxed/simple;
	bh=cXU5V/2WJDeCMj4f2Z+CEthVLysyhNn8PPKeA9e1TKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWhLkTVmhth/Ph2cV1dR0L42SAgiZqebDSBeJ4wjEhoYj6unKecnM4ZH+JmM7QhSo4knC9kUTyFVfmH/GgFlH2gCBI8M1tvCFLtQ7b9u5EHdMmZI+DBqsLtz7FS0K2hl5c1dKB9xGy8h4CoyafepIVXtu8ann6dpMzPqW2li60Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TkOV8JfQ; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TkOV8JfQ"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4679eacf25cso27073061cf.3
        for <iommu@lists.linux.dev>; Mon, 20 Jan 2025 06:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1737383840; x=1737988640; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mckVOATALnmNoc0f+W1ZPyChsHaJAgd0wNZeDQf2OnQ=;
        b=TkOV8JfQm9jQnGeen9c87dSZPG6m4qG2dqdPs6l6DfW/ZNKb9vT4A+sxiHvxjvjc32
         75Xo/UrUmmCRTQ54e/+BHg0uBwzxbTRXdN4Tf69RfDmSSPq8Mdzr3HQEpIohGzcAOP9F
         y0SpZ1O1gJsr+L1D5KVyJxNFe7LhiReSEJSNL5IMeV/wTlSu6rtL7KauV6U22F5dKa16
         h46OmUI696UMKj5tk2ebM9LuJhuTnNDb3/6TQ+10ybsyjW05FMva1wDRAulMb/t2zr9b
         l5GmcpL1lyOq8PRx7fvAKkRGMBp3zv1ukGtuP8j7IM4Q4eAiCnG+xDZqSVGGYuKtkNG9
         AGHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737383840; x=1737988640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mckVOATALnmNoc0f+W1ZPyChsHaJAgd0wNZeDQf2OnQ=;
        b=Xz9lZwJp0HTpDaMRQ4+IqmawgDxUMVLEKEi+/UYDJ+27R2LiIoYVfbZfnZSWvbRxoU
         egQ0i+oOEG7ThfOXXiZBsR6eLPfXaSJIjv1X7ynDZH1V6eQmyuJx7qygamBXQxdiFzpa
         H1bgdujr6wkNg13/Fv76IRWRwMftCEBd3T7GsIfHwJfvNAF+GPoFf/eFW/izif49af3p
         2AeXV50AdHknOQMwg5LNl7s3lngaPsnYAfILGWUM7uvgQJP5naE9eTNHCilVP2K1xv9W
         WAFtYh0SDXIyK7+PAJapM6fS3PAwzYuWyrs/35phXJvtW+QyPgB3W5W9SPCL1CgZyrt2
         HMNw==
X-Forwarded-Encrypted: i=1; AJvYcCUHmCZOtppWqUlU1XdcL6vLNFMceVYtERMZeDY86VuAxZiJnw/9b+qxeQkuKjFjCiEBleNC7A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+tw4NK1TZ/m6WQgc1l+nv8KHj2iIpC0couV/BS3eKccf7VALk
	Bskh5m92cyjvSCyc6yt3lk4LpI+h5g2rdAYLGZ2TjvEYcsDHhjeDBZ3T/r3V+1o=
X-Gm-Gg: ASbGnct8RLge6u0LYec51cyckd/JYXZyRzDqGA9BmYl3oBYNjJxQpoeW/a6ANs2N2T/
	z7r/ljVFccF6tbQDPKi6T1zuLLFxwanhuw8VNjvfzBT7IAPFKfw3mQ9Rbh/QfxIeLJLM+RIMhm6
	4eygzGrMJV1MpDp0sNKnnv7taKjIO/tcCe8MbliVQmBmgVqNphaGeMpApwlS/LGz8tVz2R02QTv
	9rGt9O/OtS43hNMrurA17fEJRB/VVAi+EWvwibcv3D1EgCEdvCRpXf8ZdojIFnu1zZQI858eqdS
	rGnG2F6MnzvBnq3UdpFugCARP7y2KDg0HnSeQ1+b1tc=
X-Google-Smtp-Source: AGHT+IH9UA5uEcr0yCCioD0S9ouxRRVzUUpeRCSgsjTK63Df0SJ1g+bOhnRREVaOFEkUCJJI14UX+Q==
X-Received: by 2002:a05:622a:4c:b0:463:6bc4:2a23 with SMTP id d75a77b69052e-46e12861f3emr191291281cf.0.1737383840593;
        Mon, 20 Jan 2025 06:37:20 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e104026c3sm42918831cf.60.2025.01.20.06.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 06:37:20 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tZstz-00000003PsB-2WHL;
	Mon, 20 Jan 2025 10:37:19 -0400
Date: Mon, 20 Jan 2025 10:37:19 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, baolu.lu@linux.intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rc v2] iommufd: Explicitize struct iommu_hwpt_pgfault
 padding
Message-ID: <20250120143719.GN674319@ziepe.ca>
References: <20250120062411.1589-1-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120062411.1589-1-nicolinc@nvidia.com>

On Sun, Jan 19, 2025 at 10:24:11PM -0800, Nicolin Chen wrote:
> --- a/drivers/iommu/iommufd/fault.c
> +++ b/drivers/iommu/iommufd/fault.c
> @@ -253,6 +253,7 @@ static void iommufd_compose_fault_message(struct iommu_fault *fault,
>  	hwpt_fault->pasid = fault->prm.pasid;
>  	hwpt_fault->grpid = fault->prm.grpid;
>  	hwpt_fault->perm = fault->prm.perm;
> +	hwpt_fault->__reserved = 0;
>  	hwpt_fault->addr = fault->prm.addr;
>  	hwpt_fault->length = 0;
>  	hwpt_fault->cookie = cookie;

Yikes, so it was leaking kernel stack memory through the padding too.

We should zero init the stack struct to be safe:

@@ -247,7 +247,7 @@ static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
 {
        size_t fault_size = sizeof(struct iommu_hwpt_pgfault);
        struct iommufd_fault *fault = filep->private_data;
-       struct iommu_hwpt_pgfault data;
+       struct iommu_hwpt_pgfault data = {};
        struct iommufd_device *idev;
        struct iopf_group *group;
        struct iopf_fault *iopf;

I can fix it up if that is the only change

Jason
