Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA00D1CDFCE
	for <iommu@lists.linux.dev>; Mon, 30 Jun 2025 08:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751273333; cv=none; b=qyX9a6HcujFHp4mEHYR8v/2VSDLSYudXU1CqmUOj+NefMJpmM7vS/Z+T6Ahj+G157UxluqnrYSWh7sHu50gzG5oE7aiPcJfNXbLjSqe1wWqWnet/sSLIBEuANF9FWNz9F3UJuUvbWC479fLNwvio7Ls3IqPSZF9zvQHMrheYa18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751273333; c=relaxed/simple;
	bh=9LX9av9yvxOClo7gCs52aPEZGCecg5/87QicfzfhCEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbCzKQruGytWt5BJh2DUMGRf2G+KRl7iQA+4TNX65gASIekm9we1oSVsOQSMqQ2zm/MpmtLiUEztUIILMWwJSZgGxfwMlAt0M8XaTZ/nK75TXgYFh6wG9qKhcA12vB55Lf7U5gVyBlzXtJXBFusZg22wX2AaTJL6PHVLoyxHZH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=S0v+o+rT; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="S0v+o+rT"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a582e09144so1349177f8f.1
        for <iommu@lists.linux.dev>; Mon, 30 Jun 2025 01:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751273329; x=1751878129; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e0MFmQYTIhwQaPU7YK/VjsEzsIiL6rLtVHCSHLdz344=;
        b=S0v+o+rT9KmCa7N90uYASe3SjmXIt7R0tCSvej1PLlV5sQTS2N2oJ7tQSbCoyXJC0W
         /YsFE60NHufIDJ/WGLxSxE8YJx5XCtopWZhkTjf5llCxSQUur/6V5KTVW+yr+XDsE06t
         iWMcG43zKYn/5daSAoWpgNtmpElI3ZvkLHrc1tIbEETqjjjA5tHvp5KYvjt/ARdTHbAy
         2ai214I1IhK7aw5encojt+Z9ew551ygIw5Q1vIwtwcT/ZgPyh7rBM/Vh4tR5LkJpxbV/
         PO9mNn71TBRFR0Rs9IMQWtcRTNRV9E0NB411XnkkNfW0gjmPFlxekwkofqO5uYa/kAAz
         nRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751273329; x=1751878129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0MFmQYTIhwQaPU7YK/VjsEzsIiL6rLtVHCSHLdz344=;
        b=TDI8mQiGVxWSFKJ9odMG9j5nren4FrSD6llb336+wIo23EyhZVd8SstRTrVujE7ZJy
         vHFNhwHxl3YF8xAyjSfmbR/O9Mluf5CggdRjmDVO2X7RX+Oa6sUTAGdbIRFwL5y5+Xeb
         TfNwWOrSLIBwmTCOhU35MR9eAxYVY6tAaZQEcG+769zZ9ieZ4CK7B5vMFIQGC3mmZONv
         5QRTRQcs95CJBuZbU22sNzSCUtCpILJpw9sMoEnbtOZDw3utS3uHWQMPdqGjDJcqnv82
         SJH1iO9t9SR7PzPI+Btk/Wfe4FZAWvp0PGKW/AcNJbP3jiXmLJZddh1iBAq+D/xe3z1V
         OY1w==
X-Forwarded-Encrypted: i=1; AJvYcCVFSrAYiuITTiSTB2RhYkTKC0/Jc/341yh2tnagsyi+lLGtQT/3FJmWOf98pPPfoiyFnEkVng==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/lTVrvVurmCsYcHQUo17p/3OO9YXjcKMQ4D+/b8Rsi5vZ2uKq
	YAAMfp3mCg6epJHuicJkpuLp31fHFViK8HY0RgDD3TDvN7LDrdd3kO6nQ8XOjI4v5lk=
X-Gm-Gg: ASbGncvvPIh0PvPuFQ8G0DdW4usUgKhtQpqaxMmvVnQQMqO2cWKEeZyEMnP5Hwz0Ctf
	ogafZTfiNkWOzCwonnT/igQ2i579Isy1y7tYkFM8Qqu5+Kk28+3lTga/VklnUbJjaHSw0Qz5E5+
	atOlgFdNP3rQihiG/9/mqZM/3AYe7ovMYGq7+udXT9bcGJAwU9Yc6Kf9xrPPjVgrYCUr/jFNVp7
	XOBUK9P1CjJwIgy7ccGmsy9XlzvSfuy4i1a8Ts2uxACOlyfYg6e8GavV45kojxJnTI0H4BVcAyj
	AVzmbk+o9eVtwK1LmgMgOD++YSlSK+Jd6EB/ny6LIawImhvJpw==
X-Google-Smtp-Source: AGHT+IFkP2IxHQSzwTBSX2V8J3HFEeGEU2UchiOHVWbWGfVFsEoSfKrpjADgwPpJXxhXznoj1gfTMA==
X-Received: by 2002:a05:6000:4b0d:b0:3a4:f435:5801 with SMTP id ffacd0b85a97d-3a8fdb2a190mr10032131f8f.17.1751273329044;
        Mon, 30 Jun 2025 01:48:49 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::5485])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7e7386sm9698288f8f.20.2025.06.30.01.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 01:48:48 -0700 (PDT)
Date: Mon, 30 Jun 2025 10:48:47 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-acpi@vger.kernel.org, iommu@lists.linux.dev, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Tomasz Jeznach <tjeznach@rivosinc.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Anup Patel <apatel@ventanamicro.com>, 
	Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v3 3/3] iommu/riscv: Add ACPI support
Message-ID: <20250630-43f937dcdcd84599d28169cd@orel>
References: <20250630034803.1611262-1-sunilvl@ventanamicro.com>
 <20250630034803.1611262-4-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630034803.1611262-4-sunilvl@ventanamicro.com>

On Mon, Jun 30, 2025 at 09:18:03AM +0530, Sunil V L wrote:
> RISC-V IO Mapping Table (RIMT) provides the information about the IOMMU
> to the OS in ACPI. Add support for ACPI in RISC-V IOMMU drivers by using
> RIMT data.
> 
> The changes at high level are,
> 
> a) Register the IOMMU with RIMT data structures.
> b) Enable probing of platform IOMMU in ACPI way using the ACPIID defined
>    for the RISC-V IOMMU in the BRS spec [1]. Configure the MSI domain if
>    the platform IOMMU uses MSIs.
> 
> [1] - https://github.com/riscv-non-isa/riscv-brs/blob/main/acpi-id.adoc
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  drivers/iommu/riscv/iommu-platform.c | 17 ++++++++++++++++-
>  drivers/iommu/riscv/iommu.c          | 10 ++++++++++
>  2 files changed, 26 insertions(+), 1 deletion(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
