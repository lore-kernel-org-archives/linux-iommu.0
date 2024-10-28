Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8616812F585
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 15:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730129648; cv=none; b=RX49E62FiaBeWRTCB0jt9uRb/JD7wjahd73q0kBXLFcPIXx/iisN1QbBpB41/OSODKtEz9OqHVkEJT5uswkWK/uLb8DZeCCz7fTEddy27H/5aU3Mflo3+P0aWcVVm182LVkcOTkHHdU2TjTlIcjAXlVTDFvfRr8Xu91W7qukrIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730129648; c=relaxed/simple;
	bh=wZEKx/DXAHuHKdfjnHhUYx5Hp4m97S9OxnbeUMqmJyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGf/ODWWydK1hMyf5DUO3aBuYxACsfqehZ5DreOzNp8p36H0dP2w/q1xpAd9ztDj5rJbQ1JkGU7UnEb8lYhrYXVbhGqz6q33MPhEUojHQgqml0AZDZ9C442gftAYWkaVi3ktt4aia6QO/X4+kf2ydvLY9bPq2HipvJaD4qMPT0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CEQ+HjPN; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CEQ+HjPN"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b157c9ad12so280319785a.1
        for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 08:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1730129645; x=1730734445; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MqUiKrCKE1w9UCunO7A8gBkZumb5Ws2zks0itfGYWjA=;
        b=CEQ+HjPNzwl8xr9O2VnP4TQHU/OOOTNH5YQu88PxKxSjsNP1ouUmOiK7AuX88FrSOl
         3SF5San7o4dNgrdeF3QLecP1OJ+jKlE09MJD3LEFrMGtsCplVsAeJlAbODdx5QIgg9Zc
         X9pYuV3pw0HYhssPEw56oJTyrIbfHtZHYD4N8y4H8cQsKujwOTaacEHM6HZqk61wGSeW
         S8jzgXsFJzItXqBLHCsQRyT6JHOQsOPCtQOMJsYxY91ayeLjp8T3/WSoAyHy+Pju6FGE
         aLSf7uKkyZ9UGY/e0UeNasorS/Q25obJKmE+r9capTuPj9RE6JrIKXCUHCSDTs/6VWo2
         wVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730129645; x=1730734445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqUiKrCKE1w9UCunO7A8gBkZumb5Ws2zks0itfGYWjA=;
        b=C5Zz5Weq9WPOQEEDfWZK9RkRXozpb8AW/Fh3H1UrIxJZQOfsceOHzcuRlYTOef9lYy
         apYrPiYb4BWQm8pIIb0vduokMYkJo2XaIs9jRS0Vc/N81zAQZ39a/aAtGmOezWrxrzDt
         8GYKxv6vBhriz7wG54G8ObvGjLr6kjHG3YT1vqe8UC2LnDL77VGEZ5uA/cFnQG3ru/aQ
         XlUqQ0cYbB5gOkVj9rin8jp94N0yh3hr0mHcmAa4/aIAuKTWaJ3Cwfo/POL9OWu50Yts
         llNHOxkCfLYfduixSmoocIqmWpXJZujtuyNBXWhqPa7Tgw4XfYVYW3S594fcC9tREUlb
         I+rQ==
X-Gm-Message-State: AOJu0YyMCBPFYxU6KOW4oF5DQ+4rjlu//01+EP1aDLwNsALSkyraryy2
	9TFr5iLq/auonsd6fwqh6Hr8MWRfxMNr4yLPKIDQ5ShDXnuKFVtFSxVX2YpX3KU=
X-Google-Smtp-Source: AGHT+IFJqJBbMaLfHxWw7wXlmmzicfP5mz0nEIhtb6dVyeQSXXdGod2pYlJhgAHFALMxfufRMDFAjA==
X-Received: by 2002:a05:620a:4108:b0:7ac:b213:36f3 with SMTP id af79cd13be357-7b193eeaf37mr1494669685a.14.1730129645321;
        Mon, 28 Oct 2024 08:34:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d326206sm327616185a.93.2024.10.28.08.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 08:34:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1t5Rkp-00000000QpU-1otD;
	Mon, 28 Oct 2024 12:34:03 -0300
Date: Mon, 28 Oct 2024 12:34:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v4 07/12] iommu/amd: Reduce domain lock scope in attach
 device path
Message-ID: <20241028153403.GE20281@ziepe.ca>
References: <20241028113148.5774-1-vasant.hegde@amd.com>
 <20241028113148.5774-8-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028113148.5774-8-vasant.hegde@amd.com>

On Mon, Oct 28, 2024 at 11:31:43AM +0000, Vasant Hegde wrote:
> Currently attach device path takes protection domain lock followed by
> dev_data lock. Most of the operations in this function is specific to
> device data except pdom_attach_iommu() where it updates protection
> domain structure. Hence reduce the scope of protection domain lock.
> 
> Note that this changes the locking order. Now it takes device lock
> before taking doamin lock (group->mutex -> dev_data->lock ->
> pdom->lock). dev_data->lock is used only in device attachment path.
> So changing order is fine. It will not create any issue.
> 
> Finally move numa node assignment to pdom_attach_iommu().
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 52 ++++++++++++++++++++++-----------------
>  1 file changed, 30 insertions(+), 22 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
