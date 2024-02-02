Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF567145B3D
	for <iommu@lists.linux.dev>; Fri,  2 Feb 2024 15:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706887775; cv=none; b=cGKnKY8LaHTw0l1l+xxgdqpoA9kworYl2ppQJ+0pus9hPmZq1Cb8nN7WZvmahZBGYe04Rkd7EhIoj6BKHUnPEe89bQy3Jo+pmnSf4o/op5bt5rY52uGvKi5ccRLwhyTecsAKPLVhVv1NqarAhgGELmPKwZFxj9aSpkYFNe32cs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706887775; c=relaxed/simple;
	bh=M9VqQ5gGKQrznsfA3cNVUzrb3XvwWsoIpMq7b4FkB8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLQHiJyCRilo9/0RYLcU3Gbdc3m8ZghqNWf0HKxaCoi1z55qEdQrH8uByk127AIBfKBr52ENh3fUC4L4U4IjxplVurwo7KpgK6tH9B4ctBQIGVQeB7pumdJ3YTH2Ns+giswyNwsIYS3Ks7/7BjbUL4/cPn0Yoo0tVPVseT2ukIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=j1jBapk7; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="j1jBapk7"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-42a4516ec46so8863181cf.0
        for <iommu@lists.linux.dev>; Fri, 02 Feb 2024 07:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706887772; x=1707492572; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PT17dAi7fLmsuzKNFiIHHuDtwHZh96x7nsb0pZia/qM=;
        b=j1jBapk7uPnMENQ/KwuRsJczXldDJhcGvAz6J2yHHUmgN1MtH9ld0e6epE8Ab+xh/u
         7U1cdhgbYKlUorEewryRhXSOFS2FdGhtOjfijeqG59Un3ngLSUbPLGNXJBnJ4SburWJ7
         OnoPZIHVXBvJiuWVdug9n2tnTE2giWBMLi5g7N1z+qr0p6TvsGCohqSA4b09fGxvcq+u
         hqdfqQK00Nvof9Uxpd5NWysMrClsmJ6B+O5q8c/Vr6exVWASyBfSgOms55xk3bW0czVS
         Hh3Q+XKJ2gPQIB8P8LKNG8mr4sCaphNDLm67Wtd/aEgErT/FIbh0M49tVM2fJJojKryz
         Clpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706887772; x=1707492572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PT17dAi7fLmsuzKNFiIHHuDtwHZh96x7nsb0pZia/qM=;
        b=uRgPT86XiO/I8NXRlG73JZ+LBNL8RLSMEDTrrETSLN0uCZ9njxidIFNDRMtsy09y4s
         YR8yLVEdDxX4BOVV2Ji9hxG3T9L8zlJOEUUagLZDMbmsDm9TIwy2Nbn64GsjUixqUpmp
         d4pmBf90D65t0BwdDMg52iXbzcyB+v/4pIZKjtQi5T+6eoPAZbxCqDRKODvA1wLyNOaA
         rkmY92X3/5NfmfnfuJKw619x5gowJ2+3m5cBHVuVHBQl/6x7PsRmd5nAL4Se2ZP8IKxP
         fjsAFb1U+JKPdOtuuuBE2FwJ5l6780tEPiXreCYXRRzi9tHIneySfZo09Z9AA3ti9tDh
         nGAQ==
X-Gm-Message-State: AOJu0YwudBo/F0wSheRt7RgYFeV18lyHJMnJBYKcY1ThHnZKOi4SoEON
	RIfm+7sP0YP958SZJwQdEf01RKbQZe/jbpyicZ0yoI4Y8af08FGfHeNMO8ynKnQ=
X-Google-Smtp-Source: AGHT+IFmNqYmfthuH7HydhhCWHYPGsjKIeqeArVvSK8FzV4Jlh171+rOircdUJYEfc+VCAVsJdg4/A==
X-Received: by 2002:a05:622a:1113:b0:42b:f207:9fdc with SMTP id e19-20020a05622a111300b0042bf2079fdcmr4047407qty.32.1706887772622;
        Fri, 02 Feb 2024 07:29:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVNmZO/gy9h3MtIPyVfttWRypcIF1yu1BnV5miT0fNugwjXWiW1s9QiRD5Df15nqNZA9au1nqzqSCpad9MBSavg/+97n/48huf6BE2KH8xr5kR5/uFy/qpyB1bCxu1AA95ZF+vl06qndXkBkEf3ZSKmOCGmHxaJfmY4kLKpl89lvlGldocG7lk=
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id h7-20020ac81387000000b0042a41b27d3fsm893210qtj.90.2024.02.02.07.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 07:29:32 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rVvTv-00AwDu-F5;
	Fri, 02 Feb 2024 11:29:31 -0400
Date: Fri, 2 Feb 2024 11:29:31 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v5 02/14] iommu/amd: Introduce per device DTE update
 function
Message-ID: <20240202152931.GW50608@ziepe.ca>
References: <20240118073339.6978-1-vasant.hegde@amd.com>
 <20240118073339.6978-3-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118073339.6978-3-vasant.hegde@amd.com>

On Thu, Jan 18, 2024 at 07:33:27AM +0000, Vasant Hegde wrote:
> Consolidate per device update and flush logic into separate function.
> Also make it as global function as it will be used in subsequent series
> to update the DTE.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h |  1 +
>  drivers/iommu/amd/iommu.c     | 26 ++++++++++++++++++--------
>  2 files changed, 19 insertions(+), 8 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
