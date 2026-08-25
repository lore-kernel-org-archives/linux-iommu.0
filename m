Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232DC3F6619
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 10:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787653559; cv=none; b=b+U8UuC4aJ8aN/KICldz6AYCQndU9zcQpFopy6pXX2f5nVjHKmSSs89AxXsgpxVCS1xehKgaetah1dBcR+qZB3NE9l9m5xC4Gy3YUXJstiMcUoiu1ZWZQRNNFGpfY+5pecgKTwJvf8HihA8BDlScudVyiLvVCmNPqNmRjT6iQOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787653559; c=relaxed/simple;
	bh=us+W/l34bjTqb6E5LUJYAddeXA9sIpUgX+mtnAqikO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsQiQbdEf1scG+kKNjvyDd2GqiIjHviT8158qXeMMcEX7qHpLt8M5KY4qmqrZTk4A9LdNpPQuh/hevJjmXtWxcZEa0cBtS7AbnnFHY1n+942YceUDrQAPSUnPFvK8aKtQtWYzE4sC6kFexg5G5gGYhpaOV4jmmEzqWxOL7ifm2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lOEKt6/b; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lOEKt6/b"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ccdf36f63dso101065ad.0
        for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 03:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787653556; x=1788258356; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E0guju7I7mkEmUSt1DIdoTBJV8Ed/bpyGw6FfhSmD8Y=;
        b=lOEKt6/bBY/R03WIuQyWLfEcHcIdj8JCRCoR5prWqbH0zG4iv5AEW426S02H3UCS9u
         jk9k3ttiqDjXuX2d3yefzLEbrAqElZxztjZO8wMRZNlFXtlHNgaIf+MeySigt4zW9RGx
         51DVsAfpggwaB1yW8QXPAbVaJBP73vX3tSWVBv1On/JkvvbPsm1/s461jpMqyWIZiCSA
         oe5ULWDw2eBtWmFMz3El+x/x6Wk5r2od7rEJWbFuC9lLDvyP4pEDjwyTmqq9RxuchuEP
         X64bin0JTBcnSe7wBb92eCBPQhJj873js/7VLWB0hzU+YQeAzCauu6+6FptTY2Wn3GVG
         J+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787653556; x=1788258356;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E0guju7I7mkEmUSt1DIdoTBJV8Ed/bpyGw6FfhSmD8Y=;
        b=rXQtjAMAV/9rFh35o6OpIWEqqc15RN/NsTCWi1NGYSI8XkAmLNors29RghRDS8ymv/
         VRnvfvSoYqCTxkxf0XVonOkNIAoeP3DKyxNca5OXbSGAmEp6FPjLUYjeSwQIJwHfSmdA
         fzfjpHklgzOMXqV/Qq72vnJEcIqS5yJYV6j+ec4LqDUcFYQWi1jhJE+y7cqvb59/ZKC0
         LxPyUt6vmdxUOIksiZqD7Y11v/yagSYSQC9yc6ld0Bktj5wtAyydBzkdCT18WgeGTB/e
         IWNScqHCyyENnTmcBwjXX7xyr3PE+Rc+fSr4R1QZmLMrRIxkHkSd3wqsVbnkRfkX0XXE
         No9Q==
X-Gm-Message-State: AFuF++mzhVmQfH1Xc00ySujNSUBCzZt+o+pkEAjRXOq44lRxL578Q0Xh
	WlajfjpM/+66L8pi5O+e/C5YK4jtINVjQIOdqItmfRKlr7U36S6FYi6tCjqIuug28g==
X-Gm-Gg: AR+sD12G0fMZHDLo5dFP00wfJkN+FLS03T5cq5lHrNZVJI2rLqbmlg12hm2PS4bR3yL
	2JAtiUkMv+BczxSO8S3ExRvr1T5TR6yYZdAIBsUQxVuaJk/Gweb4U43RiO4cc22R+v9MXW7n8PS
	F8LGU7zkZQknp/nH1H5ZP9fK22BTdlEJ957GX+GbWRbGJlFSC+adlrFi8NW66qdYqDH0QPcfsfK
	WLSpkvX5bbSZGpQ3mYQGVzuY0+cHPZOsYSJ+cj3C0+0voTXlWhCAeuelNhmmc33NJinBrbu2dMZ
	rGb/iPalsAOnPRdDFe/MJFHeHG7E9uR9MQIKWFci07ZCq6sFrtPRc+9jRcGvlTwQc10Smnl5e5Y
	b0jSmUZfx3h4c5UTN/K1Ejm/F/CkO2Vhrd4o7TjYmYSzOoGThesAqMayutHPIZEgheQVRLbFG1s
	FauAzaYZi67PzSoz1b5DbcKo5hfjsXmxkbycgzqMiwIfqJAUghFv8qDFemmBzZOYZB2D/Zr4+1t
	fj2CuzxsT7hK1l8WCt7ve1ruA==
X-Received: by 2002:a17:902:f705:b0:2c9:b404:b55 with SMTP id d9443c01a7336-2d6e05187ecmr6241535ad.6.1787653555477;
        Tue, 25 Aug 2026 03:25:55 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520f03b243sm2791227b3a.31.2026.08.25.03.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:25:54 -0700 (PDT)
Date: Tue, 25 Aug 2026 10:25:49 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Ankit Soni <ankit.soni@amd.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v3 1/5] iommu/amd: Refactor device probe and capability
 initialization
Message-ID: <ao1trSkUzlko5E1T@google.com>
References: <20260824122347.1588592-1-praan@google.com>
 <20260824122347.1588592-2-praan@google.com>
 <a3279e43-5875-4165-8754-022a6cb2fb54@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3279e43-5875-4165-8754-022a6cb2fb54@amd.com>

On Tue, Aug 25, 2026 at 12:29:35PM +0530, Vasant Hegde wrote:
> 
> 
> On 8/24/2026 5:53 PM, Pranjal Shrivastava wrote:
> > Restructure the device probe path to improve readability and prepare for
> > cleaner error handling. Refactor check_device() into iommu_lookup_device
> > to explicitly validate and return the amd_iommu ptr & devid. Refactor
> > iommu_init_device() to return the allocated dev_data. Consolidate all
> > PCI cap inits (MSI domains, PASID, ATS) into a new helper:
> > iommu_init_device_caps().
> > 
> > Suggested-by: Vasant Hegde <vasant.hegde@amd.com>
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> 
> One minor nit. Otherwise patch looks good.
> 
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> 
> 
> 
> > ---
> >  drivers/iommu/amd/iommu.c | 117 +++++++++++++++++++-------------------
> >  1 file changed, 60 insertions(+), 57 deletions(-)
> > 
> > diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> > index 4c31294fabc5..e1f9fbb63837 100644
> > --- a/drivers/iommu/amd/iommu.c
> > +++ b/drivers/iommu/amd/iommu.c
> > @@ -675,7 +675,8 @@ static void pdev_disable_caps(struct pci_dev *pdev)
> 
> 
> .../...
> 
> >  static struct iommu_device *amd_iommu_probe_device(struct device *dev)
> >  {
> >  	struct iommu_device *iommu_dev;
> >  	struct amd_iommu *iommu;
> >  	struct iommu_dev_data *dev_data;
> >  	int ret;
> > +	u16 devid;
> >  
> > -	if (!check_device(dev))
> > -		return ERR_PTR(-ENODEV);
> > -
> > -	iommu = rlookup_amd_iommu(dev);
> > -	if (!iommu)
> > -		return ERR_PTR(-ENODEV);
> > -
> > -	/* Not registered yet? */
> > -	if (!iommu->iommu.ops)
> > +	if (!iommu_lookup_device(dev, &iommu, &devid))
> >  		return ERR_PTR(-ENODEV);
> >  
> >  	if (dev_iommu_priv_get(dev))
> >  		return &iommu->iommu;
> >  
> > -	ret = iommu_init_device(iommu, dev);
> > -	if (ret) {
> > +	dev_data = iommu_init_device(iommu, dev, devid);
> > +	if (IS_ERR(dev_data)) {
> > +		ret = PTR_ERR(dev_data);
> 
> Instead of this, you can change below iommu_Dev assignment directly.

Ack, I'll change iommu_dev assignment directly.

> 
> -Vasant
> 
> >  		dev_err(dev, "Failed to initialize - trying to proceed anyway\n");
> >  		iommu_dev = ERR_PTR(ret);
> >  		iommu_ignore_device(iommu, dev);
> >  		goto out_err;
> >  	}
> >  

Thanks,
Praan
