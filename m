Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16641E8825
	for <iommu@lists.linux.dev>; Mon, 18 Nov 2024 18:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731955421; cv=none; b=uTi53S2G/jHOmnCYXL+DWVx9k87RmM/HiE254Tl4ScZyDSbWSJ8a3VdNNcmIAyBx50wEFDf/XcouyQGSBp+9R5vSMGrPVTPe2Kifa6Az/Hcm5yZcOg+Wh+Yh4tYSGtp++b1UT5Vibj2Tpp3RP+LZif7bBpVrFmgVlrDGbyQmufw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731955421; c=relaxed/simple;
	bh=2Ct+B8awPnldFMpopuvJ0mHQdWAvzuiku4XskzT+NJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRQ090nF4+cvpfwnkzPDOa+b5/SQzGnqEsoZJW211LKIopVCbsv3kJYA6Fk2C79h302cunIGIf1RzED4Zf07zqz1iMI37kFyTyYzZ6cCKhpGlQRzLsXSiDM67wtHqv1zwdnM/61o5xkh/hpuV04PA7u3P+uQgcmC5DkUhPcU3WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ZUVUvXcz; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZUVUvXcz"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b1488fde46so4751385a.2
        for <iommu@lists.linux.dev>; Mon, 18 Nov 2024 10:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1731955417; x=1732560217; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aiGoxS9y5bO8WAr6g5LjnG9Zf3/IZMgtxFJaSmFRzL8=;
        b=ZUVUvXczYM7MG3b/P/PF8gsvb65//Q5ZVOcRS+UxvOK216eEp0ggEHB1DspP9GUL7K
         51yCWPTzgZ6Owsl+Z+TkS0A85b8vzjRDrXC8P0EYmSxNupMoCL8wjDKgIkbDSMQ90FST
         QnC9UYd1tW1gt6jJUVBJJg/2IyTWfSI4u1v+ofGT78IySgUemy4R474qH3oXavLULYt7
         WG1HxjePFKuBoRbv+W5FjjZZ58q20iRHn1xOsbbSZbZXchd6q8N/qq+hjbQDe1Rsc609
         /xsV6hMmFIxjKFJUadHb7jTm4oAaE/zxAYcreBu58P1ey0cuurR0ScI3DzDL8QrcEq3I
         SMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731955417; x=1732560217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiGoxS9y5bO8WAr6g5LjnG9Zf3/IZMgtxFJaSmFRzL8=;
        b=FNDAPkCCFTzNhsaTZwHxLes22//Qg1bSFIYRDJW+bMmL6tyr66K6thfV/Nb4KWRJN/
         6sxYZudeBQfw6Imrh5Bk7TYSmdIdq2MkHvyiK1zWfQRKKbHLDKzqxUAgEVeFVJqd9dPQ
         6mEYdAjQxRWDMVaVv+//mmh77OMgAyS+xt4CDYR9QRdiVq7ZSGv6udCslwQNT5jvXQUc
         QGvgvVfiUzYK0+oG+I2SoVdPfzrReFaDoT6mwcRT+2YCCGIR+Kf1Fv/KZm/fjIx2w6fM
         P/uyeU/Jz50vzhVHNaahx37I35BRvsZCuhATgMHnr0JefUD8OcSny+YFPRdbCqVXts4b
         rmLA==
X-Gm-Message-State: AOJu0YxpvGDigZmN2VOoaGxIpK1r5L4o4nRu6+pJkjQpsV0FZuaybaC+
	7/7gSSsZrBnDioXBTzLpPEkG1oexbli20a6i0Y7Bw7pU8izXuVPAQ+W8mYNxa0g=
X-Google-Smtp-Source: AGHT+IGAvD7jve9I99GoT/BKI80P6y8fMglPCbeBoUgHhPAkZfkRJUQQV//W1VAPjwl3J6cuHo9G2g==
X-Received: by 2002:ad4:5cef:0:b0:6d4:12c:c6cc with SMTP id 6a1803df08f44-6d4012ccda3mr213242956d6.25.1731955417599;
        Mon, 18 Nov 2024 10:43:37 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d40dc41b4fsm38829916d6.59.2024.11.18.10.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 10:43:36 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tD6im-000000037qC-1a8F;
	Mon, 18 Nov 2024 14:43:36 -0400
Date: Mon, 18 Nov 2024 14:43:36 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: iommu@lists.linux.dev, kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, tjeznach@rivosinc.com,
	zong.li@sifive.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, anup@brainfault.org, atishp@atishpatra.org,
	tglx@linutronix.de, alex.williamson@redhat.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Subject: Re: [RFC PATCH 08/15] iommu/riscv: Add IRQ domain for interrupt
 remapping
Message-ID: <20241118184336.GB559636@ziepe.ca>
References: <20241114161845.502027-17-ajones@ventanamicro.com>
 <20241114161845.502027-25-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114161845.502027-25-ajones@ventanamicro.com>

On Thu, Nov 14, 2024 at 05:18:53PM +0100, Andrew Jones wrote:
> @@ -1276,10 +1279,30 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
>  	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
>  	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
>  	struct riscv_iommu_dc dc = {0};
> +	int ret;
>  
>  	if (!riscv_iommu_pt_supported(iommu, domain->pgd_mode))
>  		return -ENODEV;
>  
> +	if (riscv_iommu_bond_link(domain, dev))
> +		return -ENOMEM;
> +
> +	if (iommu_domain->type == IOMMU_DOMAIN_UNMANAGED) {

Drivers should not be making tests like this.

> +		domain->gscid = ida_alloc_range(&riscv_iommu_gscids, 1,
> +						RISCV_IOMMU_MAX_GSCID, GFP_KERNEL);
> +		if (domain->gscid < 0) {
> +			riscv_iommu_bond_unlink(domain, dev);
> +			return -ENOMEM;
> +		}
> +
> +		ret = riscv_iommu_irq_domain_create(domain, dev);
> +		if (ret) {
> +			riscv_iommu_bond_unlink(domain, dev);
> +			ida_free(&riscv_iommu_gscids, domain->gscid);
> +			return ret;
> +		}
> +	}

What are you trying to do? Make something behave different for VFIO?
That isn't OK, we are trying to remove all the hacky VFIO special
cases in drivers.

What is the HW issue here? It is very very strange (and probably not
going to work right) that the irq domains change when domain
attachment changes.

The IRQ setup should really be fixed before any device drivers probe
onto the device.

Jason
