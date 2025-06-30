Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16D217C220
	for <iommu@lists.linux.dev>; Mon, 30 Jun 2025 08:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751270578; cv=none; b=FSXa/atPNxgI4PVcqA4H+PqXbQKZmTCJfsjj5NCSHx+9LgJXsaPDlom9Ehl4PsyQfi79PCqTq2v3ORTfYHE7Y3hxly2zzajvATRXz+aGSeg9ji+Zs+YDf0dtd/jJ5zJkhp1XiiCCY3ugqjh1NPUOVnltapPC1eCPRxnYQC1G+rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751270578; c=relaxed/simple;
	bh=zgMSdYUK9yNCJ2s3hpP0j/gTKnVm2enHM9w454p24n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fk3vATxGGpCWCIgnjHAJMSoq2xu9y5iw5xgLvu+h8O6x49XiPXr06fBM9F72sGyOIHmHwwIOgi/kMwJCmqtzhqKNJOe8CjX9ewxsor+pI+bVJ5VlPwPAHHoNq0Oe7pGH9Au3oFmbpDo5WLljaw3oTpJgbJ9aLqX7pEOst0mmgJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=f2R2I1rB; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="f2R2I1rB"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4537edf2c3cso39829375e9.3
        for <iommu@lists.linux.dev>; Mon, 30 Jun 2025 01:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751270575; x=1751875375; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ska9I3Y1aB1MGchq/+g1Gg5HtDvHRWWCZw8erAwmjVs=;
        b=f2R2I1rBPEca9laCS1QRv/XT8k7jVBIvmwD23FxJ0gBXXC+hA9AFI+zrY30D3NDgY8
         fpzX6Mn81dlRqV6lm0w0piYtFr1XWl5ceJ1Kgc7fZDNyTrKaLfvK/GclFs/UzgpNY6PR
         LASa7x/VElmwnbX0oBPzEF3w2byVkIHfI1Zv1uxsavPXMC8nCvUiQW98X0X82Eb9M5ah
         bkS69PJafM4lQgnqOKXFGFSmw9jU3H51F/8nhZ7XWi6ZjM5OMTB1g360arSai7VrUYeW
         tuOwLYZo57xRznTlZUEZhUjabidpteEYzZvGgm4z9sK4IcP1fl6uvFTBfbkZ4YK+Cakg
         mYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751270575; x=1751875375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ska9I3Y1aB1MGchq/+g1Gg5HtDvHRWWCZw8erAwmjVs=;
        b=pOEzm0OfbaVRU6BnBigsHv84wT+hA6Px2NPyJqzcDlGxRcJtc9nxY3n9pYHLJYmZUa
         MeiJjCO+sHx6xlTA++Il8WSArBAPypO8rd4c1cHex6P/89YShNPty3ONcaw32hlrDDE4
         AsK3mRJ835qTmjm0GspK89FXmfWD/5i4GKspXfRAiWDxl+iRfaLkm4aJsDAOCMvBlFq2
         r1CtB0rsh6KwEatjiIZCnNfHdGZbHHE1E83Y0/dH0ZdTeGYtsY+H2JAc+ObdOc1ZqZzs
         3qIMvfySsUOByx+CqBoMH2JrU29/PNDT0vQtekYXpZ03ZOQXZHPxfNnJTt32KjaI7Ayj
         LC9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVvX0CGdyFVPnPD91nQFOjt/zQ/nr4dpvP+kJWo480ytFMMZAJummcrnKpWonwdGtIOzpKiww==@lists.linux.dev
X-Gm-Message-State: AOJu0YzhLpw1sn4UI3+UU9mDzQcqVhA3+xdCYlBfa8IAVuQCCeR7jr+L
	scpO8DS+kMzPoj4NMU7/QosS2nctVILRDjappfU4wNHMYTTpspq4bGA4kQ8YFZsk1Ik=
X-Gm-Gg: ASbGncv2R9mYeOR5ByOaO0GyhSOiShuvbCMPh+RFu24zZ9dn1Xzo5xV0EgVtCFILAWp
	CWlSf/mV5MoElEB4Nm7F8yGMatl3nyWsueunP0EW/lP7gyAA8SMCVc0jMbTPc5CoCtfA2fVXJx9
	wG0siRTZoGo71eRgnEI3nx/OJvru01PCUeUt324uhaqoOKPezKCtZ29I6xULvtjLv9zCLuEnLU9
	gu1AH9uc9CsoCkVOezhFqvFn7QnIt+uzcgqLY4VntyHSdht0COHJsdSSQxQbfvrQGmf9+qBmXZl
	OLn8BRDniYc7JcVSLakCCTkjzUDJXaG7xAuuOCmOtkl+KXTeFWb7XnUIpnQQ
X-Google-Smtp-Source: AGHT+IF9DvJJg0skDidkDsih4Ch3HhJLBIarQJZKBHX8xHPqB+4mHwpjYWK0XFUsByASmkbm+oOmbg==
X-Received: by 2002:a05:6000:dcb:b0:3a5:8977:e10f with SMTP id ffacd0b85a97d-3a917603b5cmr7981361f8f.28.1751270574863;
        Mon, 30 Jun 2025 01:02:54 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::5485])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5f842sm9499471f8f.86.2025.06.30.01.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 01:02:54 -0700 (PDT)
Date: Mon, 30 Jun 2025 10:02:53 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-acpi@vger.kernel.org, iommu@lists.linux.dev, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Tomasz Jeznach <tjeznach@rivosinc.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Anup Patel <apatel@ventanamicro.com>, 
	Atish Patra <atishp@rivosinc.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v3 2/3] ACPI: scan: Add support for RISC-V in
 acpi_iommu_configure_id()
Message-ID: <20250630-c479c6607cf8c1430f11336f@orel>
References: <20250630034803.1611262-1-sunilvl@ventanamicro.com>
 <20250630034803.1611262-3-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630034803.1611262-3-sunilvl@ventanamicro.com>

On Mon, Jun 30, 2025 at 09:18:02AM +0530, Sunil V L wrote:
> acpi_iommu_configure_id() currently supports only IORT (ARM) and VIOT.
> Add support for RISC-V as well.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/scan.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index fb1fe9f3b1a3..70f57d58fd61 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -11,6 +11,7 @@
>  #include <linux/kernel.h>
>  #include <linux/acpi.h>
>  #include <linux/acpi_iort.h>
> +#include <linux/acpi_rimt.h>
>  #include <linux/acpi_viot.h>
>  #include <linux/iommu.h>
>  #include <linux/signal.h>
> @@ -1628,8 +1629,12 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
>  	}
>  
>  	err = iort_iommu_configure_id(dev, id_in);
> -	if (err && err != -EPROBE_DEFER)
> -		err = viot_iommu_configure(dev);
> +	if (err && err != -EPROBE_DEFER) {
> +		err = rimt_iommu_configure_id(dev, id_in);
> +		if (err && err != -EPROBE_DEFER)
> +			err = viot_iommu_configure(dev);
> +	}

This can just be

  err = iort_iommu_configure_id(dev, id_in);
  if (err...
     err = rimt_iommu_configure_id(dev, id_in);
  if (err...
     err = viot_iommu_configure(dev);

Thanks,
drew

> +
>  	mutex_unlock(&iommu_probe_device_lock);
>  
>  	return err;
> -- 
> 2.43.0
> 
