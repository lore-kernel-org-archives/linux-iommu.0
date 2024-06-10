Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6251878C7B
	for <iommu@lists.linux.dev>; Mon, 10 Jun 2024 11:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718017573; cv=none; b=YgtOMij+2jNcAEvgBdBq36sq/7KCrxzlxWSf8+yw7VJ2S4PPAuhFfSATlVmzpneqaAjtzCnRh1Bp0+8/E7AhbQ/OmzaOxUgotZxlpPvH66FKuY8123VEKBN88Pq9qVru3PCki0DAD4Nk2/uIC2kOKfhmFtGEHUyoEztCyYWj+d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718017573; c=relaxed/simple;
	bh=UHAN2MQAwy4F3MaHAlvjKZuTSk8SgdbiqOaACYFrup8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibEYSus7Jrm11xSZ+XNOE35o2U0yJLYb9vKrmFt8JX8TcvBvHurx8BmWYQy8n58mXKYhl6ApWRgppiQy04i8WVjt2oAPtmi4Qc/ZkBFjfvSlXIs2B/mesxSbUKlu5qkQIXwek0Cb4kZGbyrkyB5rCN4J9M5EbEf8R9Gr3sx6LP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=EhDaljBu; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="EhDaljBu"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57a1fe63a96so5343999a12.0
        for <iommu@lists.linux.dev>; Mon, 10 Jun 2024 04:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1718017571; x=1718622371; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKRDnT36YiO5NHWmifxOcGKSpN9i3QJZvUnqhc0HlYc=;
        b=EhDaljBurwt3infSBu3AwcwiXgYfKwSzzPjMjn4ZXBd6ZLFj2GxICACkVHhaddeYag
         h3zMm1t2U05CbZ7gfi8pgqUCfoS0v1YNk8F3Fi7t9UtFy6Ze7jCv9M/hus9nVx/zXrGO
         HLpMeqMkYHicoDIZ58d2COP6tJ0k2PCjJZoT4pPamgvjTw+XOzSGgFZm8StfyggpSC8w
         f38E5IJA42WU6i4s1sogMaBPWj0KKN+ORD+ewJr1kGqKzpJNIrSSaAOXconCJ3POIlSb
         iO4CvcYIOloBX2VDFwXL376teQcVuse2JZJscx1au9/1/fdXcZrc8jwFv2DS+Y5UcMsN
         Ji1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718017571; x=1718622371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKRDnT36YiO5NHWmifxOcGKSpN9i3QJZvUnqhc0HlYc=;
        b=oqKUSI7I6W4D5yc/i9mxgQTk49cQrySjwgPsZklAOPzGrgSWtTw7PhvwXDyesbgrmq
         za37IcQCyl7tf3K9xRqfZP/U7X1e42aCgqj/pNmrupO4q3QiHO9nQVdwKCKEyDOtTcD+
         L+QcvRhTOIRWhuISHzLZQ6iwpUR5PaIToupI4IUJ9F3J94zrmd6MkNsVIrX7JIvY7cyH
         s4xFe58DP6moYbXxxM6eGYmj2jBBvZRTq0OcResIGLoGbCTuaMehopl45upgJBdvB+dj
         XabgNR2HCPk7mjd5/dYF5+XDvJuj+1EJD2NVCN6wENSxgD4jBGJ3UgsvXSztNEXgi1zg
         B9rg==
X-Forwarded-Encrypted: i=1; AJvYcCX8JEBGPX1ZqGluZ6BWHkfysmntJ5o5yT+m6Bo984D7LS3UV+gNYxBmx9eWY4icOT2Xfuawr5Mh9+KlaXq9oYpMvFRerb8=
X-Gm-Message-State: AOJu0Ywutg58xZ+0PrD8TIie/L/WCJSnP2WX9VooMSbzPNEEf0oRtswo
	EkWdABtU2Bi8zRtUADnvfi8vnOoMCY5fDH+pNkYnX9ZQYmKeLU5y8e1O7QkbURvsf/sWsJdyoF8
	K
X-Google-Smtp-Source: AGHT+IHo0tOX7ZoqFEj30qNwq0kZf+ky7YJbEiSPIgRIvjy2gNXCneqdIFwRINKKmlx0kL4JUlY/jw==
X-Received: by 2002:a50:8d43:0:b0:57c:6d89:eaf0 with SMTP id 4fb4d7f45d1cf-57c6d89f06cmr3373682a12.14.1718017570481;
        Mon, 10 Jun 2024 04:06:10 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aadf9e093sm7201840a12.13.2024.06.10.04.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 04:06:10 -0700 (PDT)
Date: Mon, 10 Jun 2024 13:06:09 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Anup Patel <apatel@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Nick Kossifidis <mick@ics.forth.gr>, Sebastien Boeuf <seb@rivosinc.com>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux@rivosinc.com, 
	Lu Baolu <baolu.lu@linux.intel.com>, Zong Li <zong.li@sifive.com>
Subject: Re: [PATCH v7 6/7] iommu/riscv: Command and fault queue support
Message-ID: <20240610-3cd1ba07c1b488a451dd7ddd@orel>
References: <cover.1717612298.git.tjeznach@rivosinc.com>
 <422f66285da1b164466b223f83d7f06564968f09.1717612299.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422f66285da1b164466b223f83d7f06564968f09.1717612299.git.tjeznach@rivosinc.com>

On Wed, Jun 05, 2024 at 12:57:48PM GMT, Tomasz Jeznach wrote:
...
> +static int riscv_iommu_queue_alloc(struct riscv_iommu_device *iommu,
> +				   struct riscv_iommu_queue *queue,
> +				   size_t entry_size)
> +{
> +	unsigned int logsz;
> +	u64 qb, rb;
> +
> +	/*
> +	 * Use WARL base register property to discover maximum allowed
> +	 * number of entries and optional fixed IO address for queue location.
> +	 */
> +	riscv_iommu_writeq(iommu, queue->qbr, RISCV_IOMMU_QUEUE_LOG2SZ_FIELD);
> +	qb = riscv_iommu_readq(iommu, queue->qbr);
> +
> +	/*
> +	 * Calculate and verify hardware supported queue length, as reported
> +	 * by the field LOG2SZ, where max queue length is equal to 2^(LOG2SZ + 1).
> +	 * Update queue size based on hardware supported value.
> +	 */
> +	logsz = ilog2(queue->mask);
> +	if (logsz > FIELD_GET(RISCV_IOMMU_QUEUE_LOG2SZ_FIELD, qb))
> +		logsz = FIELD_GET(RISCV_IOMMU_QUEUE_LOG2SZ_FIELD, qb);
> +
> +	/*
> +	 * Use WARL base register property to discover an optional fixed IO
> +	 * address for queue ring buffer location. Otherwise allocate contiguous
> +	 * system memory.
> +	 */
> +	if (FIELD_GET(RISCV_IOMMU_PPN_FIELD, qb)) {
> +		const size_t queue_size = entry_size << (logsz + 1);
> +
> +		queue->phys = ppn_to_phys(FIELD_GET(RISCV_IOMMU_PPN_FIELD, qb));

Shouldn't this be something like

  FIELD_GET(RISCV_IOMMU_PPN_FIELD, qb) << PAGE_SHIFT

ppn_to_phys() assumes the ppn it's converting to be shifted up by 10, but
FIELD_GET has shifted it down to zero.

Thanks,
drew
