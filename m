Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2CB35977
	for <iommu@lists.linux.dev>; Mon,  5 Jan 2026 18:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767636139; cv=none; b=QTolTAnlv7+WTl76jkmexP8XS15MmxjrMDjUBQ4ho3ZBaS2i2PsrRm5+GnpW7X0/58HOrSs7QEhmr2Dnu6lqHJO+5HCcNwAbQ/HzQ9AD/5Mk/oUm1BHsBojGLqXCEAPT6dCzcioYBL4ChL91vat2mxiBC4da6AkLr0hpdicHHiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767636139; c=relaxed/simple;
	bh=J2ifw4ZRsQ9TrX3pkMbT12XKImaFrB1+bL172ft1MMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzhejjCKeW7Jyh3Urxbn3HzwUCvOau7nzXq4gH3tAScJwcbXgFSJhPMda8yNfqO45WmckGLkbKuZtrUeBQmVhsQeDkOhM5eHt07wi/Vt4/5/ARW4f+xIJL3XEhOY8+CyQIy4nSobTHEgz9DIQfN/uda21IvA2Fo8TvRLvdPsTp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TYfWVMlq; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TYfWVMlq"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8b2d32b9777so20842885a.2
        for <iommu@lists.linux.dev>; Mon, 05 Jan 2026 10:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767636135; x=1768240935; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W3nbp59mhgTws0br3p+6wkvcLWwbjOWOkhKphzo8jIA=;
        b=TYfWVMlq/DRBo9Kchks1stmtzabJU7UWudV+XMMtyi+JOajtDp4tlWZ9brv1H9dw5c
         70vZ7dmQEBFj8QcH0SdQsPN2cbLxSnCB6wMBZqSZK40jnkrcd8cDQ01bCX9scd7LVNz5
         4ZUCwP4UYscfhe2V0DiA0mUVPIerdyPSGk/m0pO9aL+shyncEP5NtiIOgYN4PCSuERh0
         82uewCMiGnO1NYOWUYGyZ7SE7U+i0gQyYswvJU+yXZbmGifxUdTbQJW7fSDM70r5rdpJ
         IqYTSewA9A+BAGwvQKMeWYW546vKOol0JELlm6urLXjM3K3DdInbx5zr9qQP4WsgHzyX
         j3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767636135; x=1768240935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3nbp59mhgTws0br3p+6wkvcLWwbjOWOkhKphzo8jIA=;
        b=i7NXOWV3A5ypPLwW2VqC1ZuZGXYlIT7XdkJuxnjkT8fGKgysgNa2L4DzfVgH60V2YZ
         /W1ibjWr7jej1B4TguxUJQI/70gB9rqLqEFzrogw4C46ZDWR4J+q3kQsGu9Kz/stiNNG
         pCizlghpaBVpREOP978HX7g6mYJg9zvEe88kUjoqT7L/iavUlbCVRe4l2YGSvzQ2v0rx
         ho3BDXi0jw1KxOZuJewjNSs1EidAIdpOx/YUUThkUrKhTrLoGmrpjhkD+QC0tjnzt1Am
         429UjYBo4xpqq2OZioscTHaDM3JqELD71CyGLmM2Rregh64EPuIXxfE5eIQpfgTZJRPn
         HGQA==
X-Forwarded-Encrypted: i=1; AJvYcCWI8krMRRmU4jFU/6PsAOSPaeIq+dDX6y8rsHmIOjfRw1S39M4Ny9Ne2wrVH0dJJ7ccSZ/H6g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxVDTWo8vVPQ8G9CbuWQRAoPzdO+D5PPp8ueFGlokxVZnbLGsig
	2bxyj8B16BOqCmWX3snmyW+XSStXgajsuO56wLrdnUg6PRr0jPR73yVLQdVFMRtHMBc=
X-Gm-Gg: AY/fxX6uKVSbO2SZJbbFL4aNLS2fgSFB6yIUWdcEHlD0W3QqW9Ctq/yq7pBKcVn0DbA
	xEGmi/W7Ik1MfPqMsqYIGUoCtWfDZh2AqY/Peu0pETuY1t7DTTUr6G5fk1EI3OjTdYWgJ6Upyv5
	L3T6djlNHc7ZDL+JKxv37hScslSnKxNtaGzQhjxInufLDy1H6r729F9DPkOZisYhoab3M96E5Ke
	xZGwqc1bvJ9EwdiUkMZMSwdbDmRfKE6A1bpeJiudnPAo9DeisTtK1tvZmAhCmDz1KctRuI1w6wG
	Iz5zdiqbhqEwf451KTHrj+JWasr1anI0OI3ZfICoZ/h61hnLe9j5uyiO6BKCUB4JY3C3hZvysja
	akENk3N3vvQ5Gj35vAyiSBw2eFZTn8ZoOvXlJc/voFHOpzji9tt8rbiFL/X8gbmGZQ/jmTIio3W
	/Sw7O0B3J9cZD3KPRaroxS0IA8mweIr/M7ALN9+pUGvIbSwBLN1bDmUk7Zmy28LVKXo/A=
X-Google-Smtp-Source: AGHT+IHRi2JeGLgddwIBbL3/jFiLlbsJ9ZkBik0QV2GMfdv4mRpNXrWXsxjaLvNVDtTIrWyY23IT9Q==
X-Received: by 2002:a05:620a:1a07:b0:8b2:e7d8:d630 with SMTP id af79cd13be357-8c37ebcd17cmr60238785a.72.1767636135387;
        Mon, 05 Jan 2026 10:02:15 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f51bf8csm677385a.28.2026.01.05.10.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 10:02:14 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vcouD-00000001Bdl-0wbb;
	Mon, 05 Jan 2026 14:02:13 -0400
Date: Mon, 5 Jan 2026 14:02:13 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian Schrefl <chrisi.schrefl@gmail.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, Rudraksha Gupta <guptarud@gmail.com>
Subject: Re: [REGRESSION] qcom: iommu: nullpointer dereference on boot on
 apq8064
Message-ID: <20260105180213.GG125261@ziepe.ca>
References: <569d7de2-cfcd-4d28-8bbf-14a0179f665e@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <569d7de2-cfcd-4d28-8bbf-14a0179f665e@gmail.com>

On Mon, Dec 29, 2025 at 11:26:42PM +0100, Christian Schrefl wrote:
> Hi everyone,
> 
> I've found a panic on boot with v6.19-rc3 on the asus-nexus7-flo tablet with a APQ8064 CPU.
> 
> I've bisected it down to commit bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper 
> probe path"). Reverting the drivers/iommu/iommu.c changes (removing the added if block)
> fixes the crash, but that presumably exists for a reason.
> The diff for the fix:
> ```
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 2ca990dfbb88..9f32d70b207d 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -453,14 +453,6 @@ static int iommu_init_device(struct device *dev)
>          * already having a driver bound means dma_configure has already run and
>          * found no IOMMU to wait for, so there's no point calling it again.
>          */
> -       if (!dev->iommu->fwspec && !dev->driver && dev->bus->dma_configure) {
> -               mutex_unlock(&iommu_probe_device_lock);
> -               dev->bus->dma_configure(dev);
> -               mutex_lock(&iommu_probe_device_lock);
> -               /* If another instance finished the job for us, skip it */
> -               if (!dev->iommu || dev->iommu_group)
> -                       return -ENODEV;
> -       }
>         /*
>          * At this point, relevant devices either now have a fwspec which will
>          * match ops registered with a non-NULL fwnode, or we can reasonably
> ```

> [    5.900971] Call trace:
> [    5.900999]  qcom_iommu_of_xlate from of_iommu_xlate+0x7c/0x9c

Did you look at what line in qcom_iommu_of_xlate() is crashing with
NULL pointer?

It wasn't so obvious to me what it could be..

Though this looks really weird:

        struct msm_iommu_ctx_dev *master = dev_iommu_priv_get(dev);
        int sid;

        if (list_empty(&(*iommu)->ctx_list)) {
                master = kzalloc(sizeof(*master), GFP_ATOMIC);

So maybe master is NULL and !list_empty()? It is really confused, it
looks like it only adds exactly one entry to the ctx_list? Why have
the list?

Jason
