Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A2F12CDBE
	for <iommu@lists.linux.dev>; Mon,  3 Jun 2024 12:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419563; cv=none; b=OloGv+AozL5S6GHYkhbVhdpXRYtkFEsKen2f1R0ZG5Q3UBv1ZTZn0W3qDri63U8LBobOulEhHjgLu7f7iJSHS3MuZ4h5C/oegyoJZpUsXxFfsG1UFqzZRnReLmqXGjMCfGqHiGkmilmpVlMKI5anFcRfWCRVxftT+0FHyhSiUP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419563; c=relaxed/simple;
	bh=FyBQj0hG8ss9ZEv8V0JnRplnqLFC/O3chXUnsMv0bk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRUQdqGTFXmSVKSd8Dp9snIs23nSGD9NqFZwA9naUuAswWuIE5mGF115xH4fJrsO71g1SWovBLTXsNvWZMw7J1B4in5kVXJABUQCKZ03jx+ZnZq9s7D1MYUMmOxjYjRYASbk/Avwjh9uE6oyT401bTURANGnycYn55GyhE15/5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=LmwTa/zD; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="LmwTa/zD"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a63359aaacaso565907966b.1
        for <iommu@lists.linux.dev>; Mon, 03 Jun 2024 05:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1717419560; x=1718024360; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IcEqjvHDHPrKWRNXO1NAMZemLV5LQ0B+lnFn7VKosBA=;
        b=LmwTa/zDmhbN2dBFTPQkMECbDGmYsxq7K5AwfZrL0/h+U5UKxqkBAw1P5jJTlatrpj
         Zu7+GSF3CIQeznqHuVgijR5FAIoStZeiFD8EW5aplS8IK0+kkfwGgDXdRMS1UkGF46/A
         vfp3837yTvcPb9XH4tN++TqNyC8VEsIgbaKj9K7PeRr9GHnKn03CgKonCU+KoC9Tw8za
         LZXI2P8ADHXZkNZs7dxCsVOvU+I5CVjrrKR1qMXnZy590SElgwnWmFdXcgIsbs0bF4rB
         g9MtzdTeK97SIJBF5h60EiAwG6x/+doSkNh7crUF21qG89bjdkLMP5NmmhCHXuxLpQ6o
         NI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717419560; x=1718024360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcEqjvHDHPrKWRNXO1NAMZemLV5LQ0B+lnFn7VKosBA=;
        b=I8Ra3INsmkow4wUVik8ofxSTF8+6mJvFWIvTxbmSR2K6NxIjvLu3TlaWHPWtvQ9aHM
         9FPOIEBWnbruMjYwS5Nzp3+mKfMpD/8Jea0yoKxsqrLNtsSBz78esT1IsfNjNSQ6M0HO
         n7V1MkyyXaQ8qm5uZWJBSbeA03rfDJQ2HcGsW9AikyD3j3gGcvnyDIon3dPbUcSHoyOl
         QiXc8LA4ENFwSzqdg6kRBMB+e5MKVZvzCwx8banfxfpusXDB1F6gvlDJpLgMGb9PF5Fy
         X2YJib3OJ0y4an2mLAd0po4y7UuFYr9won8tc7wH99I6AsbaKxsj+WcVCR64RSDq6c4W
         UGAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1IWtkambB0BQ1lxx600k3Q9YBzixWpitITBmpKxA0fEL9GYAsv7uZQ9TaFNEUnysseB3EGMQ3T54WJhED4LsC2clP8wA=
X-Gm-Message-State: AOJu0Yzqw8Nd35vdC/xS2q2qVPynnpSvCjAaMbWrz0tgGM7mP5e0nDWX
	jwm5CfF0RsqIbueLRi1/jUckZSIVcEGJxOtKMnib/Ar3EZ/sKVnXqllUFyOMWxc=
X-Google-Smtp-Source: AGHT+IHqmXxSxhfsZ5QLcPFpeXSzCRtTW99BPDOeKz6AZRkFkj434iSsteZACpuRGmGnksN+E2iRiA==
X-Received: by 2002:a17:906:d7ac:b0:a68:bae4:d66f with SMTP id a640c23a62f3a-a68bae4e717mr359112966b.30.1717419560024;
        Mon, 03 Jun 2024 05:59:20 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68b66c0c87sm347330266b.73.2024.06.03.05.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 05:59:19 -0700 (PDT)
Date: Mon, 3 Jun 2024 14:59:18 +0200
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
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v6 2/7] iommu/riscv: Add RISC-V IOMMU platform device
 driver
Message-ID: <20240603-d622cdac0016f1f854bf2b4c@orel>
References: <cover.1716578450.git.tjeznach@rivosinc.com>
 <7dcd9a154625704cbf9adc4b4ac07ca0b9753b31.1716578450.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dcd9a154625704cbf9adc4b4ac07ca0b9753b31.1716578450.git.tjeznach@rivosinc.com>

On Fri, May 24, 2024 at 12:34:42PM GMT, Tomasz Jeznach wrote:
...
> +static struct platform_driver riscv_iommu_platform_driver = {
> +	.probe = riscv_iommu_platform_probe,
> +	.remove_new = riscv_iommu_platform_remove,

Hi Tomasz,

I think we should also support .shutdown (just turn the IOMMU off?),
otherwise the IOMMU driver reports EBUSY and fails to initialize when
rebooting.

Same comment for the PCI driver.

Thanks,
drew
