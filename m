Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC06C2EB1F
	for <iommu@lists.linux.dev>; Mon,  6 Nov 2023 23:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Zu5/hzD4"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-45db499e2faso922594137.1
        for <iommu@lists.linux.dev>; Mon, 06 Nov 2023 15:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1699312860; x=1699917660; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VRyAzJJOswEJHybV5YKhah0pwAZfcPETkQNhN7yfvnA=;
        b=Zu5/hzD4/2HfPbDE/O7cPP2YLh6Ly7AxOzXhCudDv7gfbEbOhngYbka89FAx09XWpp
         0rZymhqNOaxTbGDNZOk4PmlV6s3Mb/Gis6lSZeeYYlZhcE4RgwtZevfDaywKfwWftal/
         ntcUn/VKmt5o83J7XHzbTuG0H4kzJshTWOjcRMgxRY1t4txhtBeXHkcOVgsWuMovrJ99
         grJgFoikuA3yP4agGAoS0j3HgKZ+t1vcJkvXOuyvsUDNJUWhM/vBY9fa4zbzv2tky3E+
         rgI7/Si46fIMQrZQecWzN5mhWF8HaMwLiirSoPAELec/SkNu1N8opJiYJ+B2nusLMnQW
         hdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699312860; x=1699917660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRyAzJJOswEJHybV5YKhah0pwAZfcPETkQNhN7yfvnA=;
        b=qkx6ZcNQjxk25joQU3F2PcNxq/qfBosC0K3KQade/e2OYrgf1gtl/rMEKe4RCAkUWV
         JtXs6ptvxIG5oLFcS2y07G9tlkZkakcek1FRmyEnxfozuVk1FoYBXjsaiEijycjCIPXK
         PqYtUEGz9N4rrMzMLuuz0iEdt74oe+YcVd1VfiWUschOc/OrmVkgs2RSLtKHirN50REa
         1N6plvHBLCu5qawYrWo+3IKW/LFTJymch13vyk0hVXpFp+ofgBu/tqisjSLmFJMjYllN
         HSyUm/N4ji9R22gjGsJ8IfUgbwkbYoHtmhCt9rkITn64rMuMgSsW3l40m1FxQxgFowmp
         /c4Q==
X-Gm-Message-State: AOJu0Ywj9+5wwnZAD8kqtnaNfPGZjOAPMVF3DAIr3EaJi5WG2uPrfE9U
	zjQa6sNTDorIlEqnszvC0MnW2g==
X-Google-Smtp-Source: AGHT+IFk8bRrFrVxVByyjJpJ6OZ7I0ibMJsap8oOABaFk8sDXaTlbIMiMrJBRx2w4mohEFbI3UdpnA==
X-Received: by 2002:a67:c384:0:b0:45d:9c41:ba93 with SMTP id s4-20020a67c384000000b0045d9c41ba93mr5963502vsj.28.1699312860430;
        Mon, 06 Nov 2023 15:21:00 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id i4-20020a056214030400b0066da90f0c19sm3834114qvu.24.2023.11.06.15.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 15:21:00 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r08tv-001Rr1-Do;
	Mon, 06 Nov 2023 19:20:59 -0400
Date: Mon, 6 Nov 2023 19:20:59 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 11/12] iommu/amd: Add IO page fault notifier handler
Message-ID: <20231106232059.GW4634@ziepe.ca>
References: <20231016104351.5749-1-vasant.hegde@amd.com>
 <20231016104351.5749-12-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016104351.5749-12-vasant.hegde@amd.com>

On Mon, Oct 16, 2023 at 10:43:50AM +0000, Vasant Hegde wrote:
> From: Wei Huang <wei.huang2@amd.com>
> 
> Whenever there is a page fault IOMMU logs entry to ppr log and sends
> interrupt to host. We have to handle the page fault and respond to IOMMU.
> 
> Add support to validate page fault request and hook it to core iommu
> page fault handler.
> 
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h |   8 +++
>  drivers/iommu/amd/ppr.c             | 100 +++++++++++++++++++++++++++-
>  2 files changed, 107 insertions(+), 1 deletion(-)

These patches don't seem ordered quite right, the patch creating the
SVA domain should be last, it should be organized so the SVA domain
doesn't work then following patches fix it.

Jason
