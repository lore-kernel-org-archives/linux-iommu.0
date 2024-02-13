Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A955DF3E
	for <iommu@lists.linux.dev>; Tue, 13 Feb 2024 15:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839028; cv=none; b=Jpy9nApCHN8ct5RxixuRlOx6CgeXAouLy7kzEMjAMjLN+6pWbdQ+jiVwg9KKWKzSah6HV40qI8G6yfIQlz1YRMOGVEts7fS9MfJdiru8lZD49ZdEnd3xFY2l+xtvgOws84CiNiDyxU0qtBLnBM0+EdmI1LT9KekiJqzlM1B6jno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839028; c=relaxed/simple;
	bh=bN+UFcCRIa0kfUCiLiY2xtENcHp50d8itZZssn4tSBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHikmJ6xm2MYXjMCXEShhAXMnx1zpZtkUObtvjOdX+uDZXYFDLgcHsaXSw9PYGqS4d3/icBpLFSZPrIYddPGn5Ioo23OlNDTcaNu3KbkDUJzmiqrRgkKwyjudo36jHJd9vhBnVvqFuhHeYQMoKd71b2p3dUzVb/sloa0sJ4DMbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=moZ7DClF; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="moZ7DClF"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-560530f4e21so11205a12.1
        for <iommu@lists.linux.dev>; Tue, 13 Feb 2024 07:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707839025; x=1708443825; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bk1NS0qtruMcjKHBcgzBmeFEQhZuiLsEvlLQjVfdIzQ=;
        b=moZ7DClFiDmYXz0GNWLwhKPfD845H/pG6ZGkBRT8zSI1PEFuCc0NLZtKHw/DraGU/9
         vFDN+WeZFJlYWRff8ax6eoETQR3UStw2SWTqKaf1YJLYpqIV7CekUfgTb9xjRs0KDd93
         kSOwtJ78TQ04l2UcXcN2MrN8zqj91PoLu4O1UQHjf7/PFRSZtW4WmwQPjfDesyPmJZNo
         JgM4yHzW79d3mMXb+1iNRJF9Q/lIK8hG0DBk6hPVduI7WDsRe4QfwV1bVgJhGQ5X0Zqe
         +AF0K6qPI4NdZ7feUb2bgD4b6FeP3V6y464OH2vgvIqo3kFr6iPfj9PVA2qhstcAD92B
         9yQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707839025; x=1708443825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bk1NS0qtruMcjKHBcgzBmeFEQhZuiLsEvlLQjVfdIzQ=;
        b=buirzlYJG5TGzyrsv/RO+p7bmGJdc245TqZJHuqxGhawttK82vPga4XVMe0ozvHJdG
         600Bpk0TLMmGyX9Im+PXK5ku+r+RlhPNW4j9aVfQ2dKccywk1d/jxpDwT0toubJASsjK
         6/TJG+pU2vUgHgj1/ONx+P4wTV0RY/Ex3fi+4N6XOrqbNtETxqFMiW59ZybF7akBmVe0
         KMiiHO2JDAK49XGBQXADLvlWql4SFAf8vLtn5iVNnZJja2CHxk42rEL5GMCsyNL7ykFq
         bqE/2IkangSPBI+fHYUGMaYF0geqZHV6K2ffXuLBsTdnh3p1BvJxSU4D/NsxeYQGYdxo
         Zr7Q==
X-Gm-Message-State: AOJu0YxIXkJ/TC7mJ6b8IDPGQIkKokpHlJ+qRpB9vkBo82oXx1QN/dbn
	RrCxZtLL/Ooe57TJPN/FyiQkFM1is9PPkJmahgOhiH5ZWu4qlpOWjfNE9m3gDw==
X-Google-Smtp-Source: AGHT+IEDuFFGUViGZf1sivuihjVwzz8vwZE2+7laoVfrhpOcs8/51AaEx5/z7DwuCk9g7hiBMa6/Ow==
X-Received: by 2002:a50:f61e:0:b0:562:b30:fc90 with SMTP id c30-20020a50f61e000000b005620b30fc90mr85478edn.3.1707839024972;
        Tue, 13 Feb 2024 07:43:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXkyeXKE7DKbH/TjbebFN18vb0CDgNTI8e+gyC5f/BREAF8H1ZkgvYFZmTLWWse+vAq5OhqP5L7sSMKWKSivXZS5ryVxvgCxgQK2vTy/UlMuSyCssNfdfuVAMA+xA24FpE3mG/kh4LnPYCthi3LrlOYarLKZWecppbJHLPus+On4RnZplKsvfLrGKz+9y9HGQrKXkYXMzocs897epeaLvlfuLnmX7Z0Y4P5tbvHRyGevaR0XuAqz26daTzMOcBcOy085KdYMfc4+3t7qY/71xh/zjzjQYi0Rij4YaYYrPk8bzvw7F4Q3emWb6NDhd5L2wNe28MJKlnEJwRDA3bsxigSMnAjNVNulVzE0WQX/1H0k1pp1JCCXNhnAjR+DEDk2qU5G1s8tkA79I7PT054CfY488F+r4OtQDqtkAo0tG2y3TWHbusyPPfvbfHW8kq7AqsDjlmbcKVXrLAKfP2izQIjZjho6xP5wCINi1/1YqxrAzJSx525mg==
Received: from google.com (185.83.140.34.bc.googleusercontent.com. [34.140.83.185])
        by smtp.gmail.com with ESMTPSA id un6-20020a170907cb8600b00a3cfb02c12bsm829998ejc.79.2024.02.13.07.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 07:43:44 -0800 (PST)
Date: Tue, 13 Feb 2024 15:43:40 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Joerg Roedel <jroedel@suse.de>, Moritz Fischer <mdf@kernel.org>,
	Moritz Fischer <moritzf@google.com>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, patches@lists.linux.dev,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v5 10/17] iommu/arm-smmu-v3: Pass smmu_domain to
 arm_enable/disable_ats()
Message-ID: <ZcuOLGOqArUzUOfv@google.com>
References: <0-v5-cd1be8dd9c71+3fa-smmuv3_newapi_p1_jgg@nvidia.com>
 <10-v5-cd1be8dd9c71+3fa-smmuv3_newapi_p1_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10-v5-cd1be8dd9c71+3fa-smmuv3_newapi_p1_jgg@nvidia.com>

On Tue, Feb 06, 2024 at 11:12:47AM -0400, Jason Gunthorpe wrote:
> The caller already has the domain, just pass it in. A following patch will
> remove master->domain.
> 
> Tested-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Tested-by: Moritz Fischer <moritzf@google.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 2a6ac0af932c54..133f13f33df124 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2474,12 +2474,12 @@ static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
>  	return dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev));
>  }
>  
> -static void arm_smmu_enable_ats(struct arm_smmu_master *master)
> +static void arm_smmu_enable_ats(struct arm_smmu_master *master,
> +				struct arm_smmu_domain *smmu_domain)
>  {
>  	size_t stu;
>  	struct pci_dev *pdev;
>  	struct arm_smmu_device *smmu = master->smmu;
> -	struct arm_smmu_domain *smmu_domain = master->domain;
>  
>  	/* Don't enable ATS at the endpoint if it's not enabled in the STE */
>  	if (!master->ats_enabled)
> @@ -2495,10 +2495,9 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master)
>  		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
>  }
>  
> -static void arm_smmu_disable_ats(struct arm_smmu_master *master)
> +static void arm_smmu_disable_ats(struct arm_smmu_master *master,
> +				 struct arm_smmu_domain *smmu_domain)
>  {
> -	struct arm_smmu_domain *smmu_domain = master->domain;
> -
>  	if (!master->ats_enabled)
>  		return;
>  
> @@ -2567,7 +2566,7 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
>  	if (!smmu_domain)
>  		return;
>  
> -	arm_smmu_disable_ats(master);
> +	arm_smmu_disable_ats(master, smmu_domain);
>  
>  	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
>  	list_del(&master->domain_head);
> @@ -2689,7 +2688,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  		break;
>  	}
>  
> -	arm_smmu_enable_ats(master);
> +	arm_smmu_enable_ats(master, smmu_domain);
>  	goto out_unlock;
>  
>  out_list_del:
> -- 
> 2.43.0
>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa
