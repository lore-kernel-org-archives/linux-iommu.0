Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEAE7641E
	for <iommu@lists.linux.dev>; Tue, 27 Aug 2024 08:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724747348; cv=none; b=ZC4/Z32i3Wz+BzWtddp6BHw7xijh8yLpc9RH4lC4tOCv5DdZQkoP6zIzXqTGs7eAUndWxDSXRGXwuEaKikY0fEU0Ra+4t94wFx1rKIKEYnCBSIfh8YB1CALDmf8hpl8eqiVutzbNKHqTE8/nngPC3EgoA5VcaXF2LK+GiWnIHsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724747348; c=relaxed/simple;
	bh=iIPwUGV13p5fZmrE79+8bArYc/Op+nqsbUDhnMje5eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uU3Gfo02uz2BiS2AyOQLJJ9uLD5JQVHoehVp/tLIEf2rsZd4ojJBgMm9rWnNeyqqzqyyUCIcBdQqVF8ftW2EJUtAWF56vL9xpKQD5Oo1MueZXR+OJWcJE1tUm6/yjlv0qJ5A5HH6JmgPPAwBIGeu5PvJF55Ls3MqMRHvTTaEEaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DFCwyGry; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DFCwyGry"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3718706cf8aso2968565f8f.3
        for <iommu@lists.linux.dev>; Tue, 27 Aug 2024 01:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724747345; x=1725352145; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VbxaF6U83ZdL2HnmpUCTIZfonMJcEng76YSUWc2fuwc=;
        b=DFCwyGryn1/EMu0tNJkAqnKp81awnsOhZ2Ta+aXdqqqUl5nSKBpSKTg3yFsZHmSCng
         PxdBA+77xYSvDD2pizAsIcWci8WzdZqfbT0VVYklT9HRHKwPJn051Ra37AMYwR1Q7T7U
         sUbLukcn9XRiyJvAMhQJMt1VG6z1GCdO+Li7vYh+YVEXI+ZFl6NEgQ/IYcT0EEVLUbyR
         l39vbTLcubrLqRiq44GC6gJTe+g/v1UYKl80vWLLPaLfr5zeUJxCwNr06HlSTUfAGSI3
         G0BCU/d9WvohbLxvxFgq0Tk5Eg26sU4+9LN+Cw8Fj45+VtD43lotO6/pPMiZ4ZiQ1gxm
         KqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724747345; x=1725352145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbxaF6U83ZdL2HnmpUCTIZfonMJcEng76YSUWc2fuwc=;
        b=PO2nPIeFz0bWnf3O1TP8Q803ddHfPBhcwSTKp/ROg60ZEFqH5rC5KUczNvpzg0qgzq
         SAUcZs3RGomI8+aH+xVfWonPY21jgHh0ernE77X+wqzdmvv7ngWyWtYjO7etwREMp3ju
         gWRhqYHP4MaAJ8p+HjF1f3IM8ecPnIwcEndc8P7dMYDvZWdveHJiNh+ddXebGf7ypQR0
         xOJYV9r6ZrBeOZKRV5maPRtXk6FrdPuYKlBlTBIrQjqMuHjPG9JFEIE7srVslexh/49J
         fZe365qLFaq/qEMSUsF1I34e3px/YWqXFuvdBrnnLDN58ARw55M6fneW0dWJvsdVKlmA
         SB0w==
X-Gm-Message-State: AOJu0YxPeZIxpj/dUM52jz/GSvEW1oU86QE6dcOqQH2z0iMj9uHoGOao
	7RAg07GxNoUDRC1VAhI9vpRRtJa9WelsMUsAAMfW+XKJx7uvIHG411BemUWYdF8=
X-Google-Smtp-Source: AGHT+IGJ/dd/QgZrCPHBBiLONZMEH52GGVDrVO6RVgbGne+O9ozbjHPyuFvNYlBcosHvn9x8ZSQ+0w==
X-Received: by 2002:adf:b309:0:b0:367:4e05:bb7b with SMTP id ffacd0b85a97d-373118e3c8emr7174074f8f.53.1724747344529;
        Tue, 27 Aug 2024 01:29:04 -0700 (PDT)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730826196bsm12491738f8f.102.2024.08.27.01.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 01:29:04 -0700 (PDT)
Date: Tue, 27 Aug 2024 09:29:24 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, joro@8bytes.org,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH] MAINTAINERS: Add Jean-Philippe as SMMUv3 SVA reviewer
Message-ID: <20240827082924.GB424579@myrica>
References: <20240823165454.1064-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823165454.1064-1-will@kernel.org>

On Fri, Aug 23, 2024 at 05:54:54PM +0100, Will Deacon wrote:
> Add Jean-Philippe as a reviewer for the Arm SMMUv3 SVA support, since
> he's been a consistent contributor to that code over the years and
> understands the relevant parts of the architecture much better than me.
> 
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Will Deacon <will@kernel.org>

Acked-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  MAINTAINERS | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f328373463b0..445cec2ae4ed 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1880,6 +1880,10 @@ F:	Documentation/devicetree/bindings/iommu/arm,smmu*
>  F:	drivers/iommu/arm/
>  F:	drivers/iommu/io-pgtable-arm*
>  
> +ARM SMMU SVA SUPPORT
> +R:	Jean-Philippe Brucker <jean-philippe@linaro.org>
> +F:	drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +
>  ARM SUB-ARCHITECTURES
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
> -- 
> 2.46.0.184.g6999bdac58-goog
> 
