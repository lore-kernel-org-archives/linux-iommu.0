Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEB41AF0B2
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729009248; cv=none; b=nokqviS8Oy+zedGpfsHIVbChW6g8MT0OPO1G8CT4CZTaQuwKm+jdIIQCI/yeUbLwFLDWOEAa3xTHnzZMG+kDP1hPHE4BSdffwrngl3QbYVtPOJjYloCDo/rVj/MHtmfTpMmJyVp1r399i1dKxPf03r977DCNFR6pK6pAVwv4vxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729009248; c=relaxed/simple;
	bh=GKD35OEDDKtMzVLFMvSyT8zat97kb+O+cKvE4YkLIpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQDX0b7becFihtfgtv91LifQ1a8dc93ySgjh+yjMMdT48aTe1/HIYWPR2M9F8IJI4oXKv+2YfnFqzvB4V+raDryYMWOsCseId8eWbsF47MY2Ldz+l7H7L8ujzlMstJyiprO+SatyTKcPo0UD+R3LrLR11hNv/cQcHvrqotGwkNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RBVCPqoY; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RBVCPqoY"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6cbcc2bd7fcso35648566d6.1
        for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 09:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729009246; x=1729614046; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DtJ+WCcZlnqJEtBJ5ahUedtheIBoZsN5YCfn7xZAGeE=;
        b=RBVCPqoY+G1MzLcP5Tn3vSCKyS3hgM/A2ESUpFFw3teHwrlpXdJjwUA7hnyHkcBKvR
         86exN2Zq7fV2WN3U8g+U3OSp1EYPa9N68eA49NkcSi3Yl0pefOdqnQG7bHr8Vm7rU0xz
         jdRR/XQQ5JmazVAs/p/PTs/4TIezeYcAbNGaxIJSL9Oa3iJIcal1WRddSaLx39hJfe4V
         jvef8s6T3knRXbT9VbmodItp+5pxLv/TXMQ3pTLZTptBuWBrZeAEekimblJ19cUpW28Q
         1zXFsic91Bemp/aEdmNEMgjE45cJnTWTCrzZ1sm5i3akZs7eIDjawJUufKukwv6fVr+O
         BE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729009246; x=1729614046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtJ+WCcZlnqJEtBJ5ahUedtheIBoZsN5YCfn7xZAGeE=;
        b=kz3RpAUw20Bq6GmXrNjkU3tftxhATn4UK0aVabRHt1HVHpEc+nqK9kro75ge5oxBi7
         YKwe+/G1TXUqghmRBEeAsBeJM+72AI4jPziYw6mPrtukfVJX5g2JspZbxBTsHhE5zxBp
         0K9c0shxLbfnoo6GBqBt8zsJIYSAJCzhuOUE2ezmEvteKH3eqYOhTCjUoEJLJ4O9fNwK
         jxM/Djz+6W/+Gm2kfadRg0z9hroNplXHuDMr8jpulGGjsiEJSaFuNDkF+NP4E1DqAMwD
         ozCzNnGp6YBgEQZkNe5SSE69sSbm9miOT2O64p5Ns4qy8BTGHqHAB3FQJdor8lqfacsD
         0RkA==
X-Forwarded-Encrypted: i=1; AJvYcCUFN0wehr9C2O1mp/y0eA7YZ8NXhIHpBMZJbN7ArW/1wVoZJqB+jZ0IVdy4rjFcutYTZQ5BZg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyptOXyAB8ZhAvPkfwR/s8NvPU79QUP+0FTVgtU6ga19j0kvOxU
	MOEQfl+3IgO8NqqAULBp02fwO8+7ibkuKOjSPqGcDGsXwZ8CaZNecd2IPSYvL+A=
X-Google-Smtp-Source: AGHT+IEOm3RZ0qr3XQeoZ584E3gMolo8dla+rxJiMl2IgTVjvh9zKfMlP0bSl5xGgTacD1zRpQZ8Zg==
X-Received: by 2002:a05:6214:4345:b0:6cb:ead8:c53b with SMTP id 6a1803df08f44-6cbf009b929mr198694786d6.31.1729009246110;
        Tue, 15 Oct 2024 09:20:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc2291da47sm8321016d6.48.2024.10.15.09.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 09:20:45 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t0kHt-00Dw7g-4A;
	Tue, 15 Oct 2024 13:20:45 -0300
Date: Tue, 15 Oct 2024 13:20:45 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux@rivosinc.com,
	Lu Baolu <baolu.lu@linux.intel.com>, Zong Li <zong.li@sifive.com>
Subject: Re: [PATCH v9 7/7] iommu/riscv: Paging domain support
Message-ID: <20241015162045.GO1825128@ziepe.ca>
References: <cover.1728579958.git.tjeznach@rivosinc.com>
 <3d0f71ee9178c9fcb9d62db135776895a91c3d70.1728579958.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d0f71ee9178c9fcb9d62db135776895a91c3d70.1728579958.git.tjeznach@rivosinc.com>

On Thu, Oct 10, 2024 at 12:48:10PM -0700, Tomasz Jeznach wrote:

> @@ -856,7 +1445,7 @@ static struct iommu_domain riscv_iommu_identity_domain = {
>  
>  static int riscv_iommu_device_domain_type(struct device *dev)
>  {
> -	return IOMMU_DOMAIN_IDENTITY;
> +	return 0;
>  }

Remove the function please instead of returning 0

> +static void riscv_iommu_release_device(struct device *dev)
> +{
> +	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
> +
> +	synchronize_rcu();
> +	kfree(info);
> +}

Just call kfree_rcu() ? We have a variation that doesn't require the
rcu_head now.

Jason
