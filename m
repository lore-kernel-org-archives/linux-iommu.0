Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900AA25A347
	for <iommu@lists.linux.dev>; Wed, 20 Aug 2025 18:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755713044; cv=none; b=DlAliK443AWpW3aTkaBR2M23qkbpFKyIMsxh82S6v7XRpYuRcCAsB1VWP7YdlYogARq3z0a9+c3m8kVq08kohDBawdgoTmDFFO5JYCQfiR8V8/ogUSBNtaJeI+IrKHr34Oy0PNXLL2uFBXo4+nkabiusSrOks7PBtbugAaPuQLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755713044; c=relaxed/simple;
	bh=Jg/VgEyT42KWxvINZCjMHCZ/of+8bVvbbQhxPcXjl3s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mOhlgHaZfTs3oqP1M+/TA+/rn19l0VnOSaM6Q71ZTGBwNZv0Q0XoYMxFUbCvp5RArT3yboWsWyzF+YzPKhdfCfXKFz0Inu+2L5ew/J9LxkO6iI6JzQdUSElIyZ4ZD3YH5emuBEKAzc/hAkoO4goGxvWiG82bZPDoUZvTdYCstkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuD+aExq; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuD+aExq"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b9d41bea3cso147811f8f.0
        for <iommu@lists.linux.dev>; Wed, 20 Aug 2025 11:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755713041; x=1756317841; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+aQKiEZF89L/ytwh8BhBuwbvy8+KDU2LqHLLeKh/Ywk=;
        b=KuD+aExqDZZfJuJTyiuEafyUnv2z/yiqpV3zIH6kcEq2v1Y0NYz+4H2sKimQZv5pER
         FzQ0WA09MX7UG3873hW5baX6qLokX0ejY16JBpiMjPvlV8uJxqyq2Ez5YRCHpIN52BfK
         Drf3hs6/gN+Z6oQnA4RkvgqjzKkPaR9F81uJzJvJ+piXjk/IRg4kHirxbR5W9TBoXlKi
         ahYgOeLGul2xap0pHNBFuQxnH3ZE7C9eFew8NxP2D256wkmp/3Qa28o6E5BJSjwBiaAb
         39Rj1U4xSt9kaE44/oKzWzfes/RavRF48qb9MvHShdDv28rJlOCYfBMEHyvwVkU8NHSu
         AjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755713041; x=1756317841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+aQKiEZF89L/ytwh8BhBuwbvy8+KDU2LqHLLeKh/Ywk=;
        b=OC0f76+qph36RaBwhQ3NLTLJx3Pe+o2Hffk0W1wFTxlhC3zIEfGgMZZRB8XZq96IPb
         I1SYh6riVstUOpBXTdLmzZB86dlmSnZZ7TrJnraYEjEJMm9Bo4+skA23vHvVRHv5TqrX
         GN0KvcEjsj/aV44yILyEGMKTIXYnroSIxI6rZ79hZ5GGVmMxScuT/SwRutTMA+RH3Mp+
         gQ1bM7ienS/WAA4qfUSM6V4w/e/ELPJwO2Kpptn42D6tTqzny75kALswRZB2mHFq9L7B
         O05YFuf10cOvJiDrqVjhCCJUy1RXl5H/AQ7wDlESS2tPqV/O32drZ2/Uqvta18Z0IRp4
         onHw==
X-Forwarded-Encrypted: i=1; AJvYcCUzTSUoIShwmDBTiY00SB85oDDkxwq9BhDd9kpNGv2Y3EQeh9h0EDpWIFNtsakR13NkeK62NQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDOatvjSZIpvrRovJoxfYnIzHAWEwxtPubb0Bzfn/yif4bfPIs
	kAADG2m/iF00gZv7PCk67NZZ/xW+PZ/1zJDyvSKKZnjpvKuudc1XRGuu
X-Gm-Gg: ASbGncvHa5CMzhiAjRvXCvapP/vDbtIm4WmxFKe0ZoIv6Mjx9zOftVBrhF/pzmbG5x8
	W61mg6Is3vksRCeyK8UO3cADmDcCTe4xRYxSefOVnSWutdYeYejwGSBYyenMXbXl45fI0TgvvlL
	KBTl8BBK9J33Mt5bW3w7X0U5TOWqESQzYwHIV+xPkz16563KG3jCWwrZLbVRZxl/oluscspkfKf
	gs3JzRGYYxnxOCPlLTmwCMyvenavRsUFt+ZcrosewhYlbx04DkQLDqQYKeCIUP1fA4EFB3ouyLz
	YchrlA4kw3AEXe/T5RtxzLzm8eLNIX6vgPi4ESRUYxSPF2NUi/xgVuHAb9E5lxy/1hgDxourEiQ
	S76gr9Sbv4LQl2rKQQdLbQo79G0rHRcKv7MK59ZiAKa/1QZES63OAHW3AgEDHbv04
X-Google-Smtp-Source: AGHT+IG0u+MKLOgxtPHNTftiOrn8pO4TB5j9mVCfFWAyE7O/jO53VFoQY77Hmc5dH5GpR5IIdXrpBQ==
X-Received: by 2002:a05:6000:4b0c:b0:3c3:5406:12b9 with SMTP id ffacd0b85a97d-3c35406171cmr2539818f8f.61.1755713040657;
        Wed, 20 Aug 2025 11:04:00 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c074e38d7dsm8490589f8f.26.2025.08.20.11.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 11:04:00 -0700 (PDT)
Date: Wed, 20 Aug 2025 19:03:59 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: joro@8bytes.org, will@kernel.org, suravee.suthikulpanit@amd.com,
 robin.murphy@arm.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: use str_plural() to simplify the code
Message-ID: <20250820190359.2680af50@pumpkin>
In-Reply-To: <20250818035331.393560-1-zhao.xichao@vivo.com>
References: <20250818035331.393560-1-zhao.xichao@vivo.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Aug 2025 11:53:31 +0800
Xichao Zhao <zhao.xichao@vivo.com> wrote:

> Use the string choice helper function str_plural() to simplify the code.

This also changes (maybe fixes) the code my adding "s" for zero.

Although I'd define it as ("s" + !!count) - almost certainly generates
better code.

	David

> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  drivers/iommu/amd/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index eb348c63a8d0..b5c829f89544 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -265,7 +265,7 @@ static inline int get_acpihid_device_id(struct device *dev,
>  		return -EINVAL;
>  	if (fw_bug)
>  		dev_err_once(dev, FW_BUG "No ACPI device matched UID, but %d device%s matched HID.\n",
> -			     hid_count, hid_count > 1 ? "s" : "");
> +			     hid_count,  str_plural(hid_count));
>  	if (hid_count > 1)
>  		return -EINVAL;
>  	if (entry)

