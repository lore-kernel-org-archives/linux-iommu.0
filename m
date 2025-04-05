Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5617C1A0BF3;
	Sat,  5 Apr 2025 18:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743877193; cv=none; b=IQn95lzrvu3NaokI/Rc0kOOcJ28bs7Y53Sltmo5RnI6lvZjWU2/ACbaoXlS/LGp/SqBCq7qh3gZFiSj5W6GHCcXokgbyDHX8u0OOjw57Dlc1ghrYyU/V861UWYrmL95kHKkO5hKLZBZ6HUsDddzXOjqnwX0ff0yoNserZ/UzmOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743877193; c=relaxed/simple;
	bh=UuKpmCc29izBRMeN6jegH6OMMWvy55AsNWWT5DJwIi4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:Content-Type:
	 MIME-Version; b=B04w/h5EKjR2kSzOgI6SPyWMSoFDAZb4sKBiqMQPugNDOvuiAiIzZbI3NBxOoq1UvC6cIetmb2l/GUVzXfKxti8+3jvKNGmO/tdmsMNLiaMH/6r+ODLRCSZU1pawQUGu/wCpljbeddyjpVxFMjRdxpY3yjZh46lpi5jgGGI7Iao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsUK+lbg; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsUK+lbg"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e61d91a087so5004143a12.0;
        Sat, 05 Apr 2025 11:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743877189; x=1744481989; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JzDPIcjxpueJWPt8ubJyJmHV+G2m+1GMdqn6UOzKG/Q=;
        b=EsUK+lbgcH/7V3YecXfX1C7vFJfxtgDPHAcDCGVOr3mxMQhNdE4FJ+BlyT0VPYQ2bu
         gFtJJLfUGo0AKTiTfKY744x40iiJwYcrpIqNEWuknwSwMnMYQRcedQEJ6cPXNqovMxLe
         aw9P+l5dWvvdJCjueL1u3WZN2L+OmuYq9rru/hOoG7rUtT0G+bOMV6rLSWNT9DoLIldD
         QvQseJFH12Y5IRbgnmnRm8l/ODVgGrgEVanqtFPUG9YIb/qOqYyhIPQjhkYU1gX//AUO
         6LnW0pzIIgDI3980Z1u/LE3DnXHnYDGbsWwVY4ccAjOERTCwPfPmOhrJyRVhdrgaBwKg
         4J5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743877189; x=1744481989;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JzDPIcjxpueJWPt8ubJyJmHV+G2m+1GMdqn6UOzKG/Q=;
        b=WjiezvEaMjnzkxq7dbghSqn/Wila4kPdACS4SjLTAJ7pz1pAriWlouu2lXgnpMDPHC
         rW6HamWN7P9zFA5Khy9HcVjcyhCduMFgA0xwkzX23mjovp13oFi/udLDHhFb0bpgan7K
         wr0WOjsY3DEFwDbOeE1CeV3DUOlqXAxvXyKnIFii2CVNRRTi4liRABUOhhJaS/FGvUSn
         OBiywXIKa9upDe1kUg+qe2BAw5+jZkoxI7sfzDQ6EBf3phso+Tm//5XV7RcuYkkXasVx
         AzqXZYGDaQ9NMaxmh/pS5hVwgBY8Ur8e0qPLfrM9H9m465f7cIdr7uaOewbjt1vgaxJY
         85IA==
X-Forwarded-Encrypted: i=1; AJvYcCX0nDZQ0m0RJhG+A4chek9pbeEnWFYtuZC1Qjs+HFdFHbz4YMoPYLUiN6hIgoXhx3yxlNuiMI6rPbeOMQ==@lists.linux.dev, AJvYcCXfOHUvfZFH8AxycTsvMxINMs8HQP+MM2wEuprOWMYBWzjEhgM4fGMeNhwAGptLUkKpDl4hnA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrCd7siusLSQc7/CsE7z4dnZ7RKoFnYZrw8+6Ujm+481J/qPK3
	+PW/dzm8JHW2cKVdZTyp+IcMViRavfva2S4G7ysv9e3X9HNtB7a6
X-Gm-Gg: ASbGncutUUQKWn+9EVeCZO51Sml4880ybt2vdbNFwyAlDmzLPzCD+xn78USttL7Xaii
	DBUxo1HWYrOsdKUT14xt23hDXXcuZxib+XKgJPg8Bcag68eCYAweMh73JvwQhkOQOSe6H1ySg+y
	zSloG18w+zc76zdXgGo2/HLVBhXsrlfN8PuaQK/bgduhUasY/zNQogcDBAzfjGKy+/0bDQTRFhs
	ESxg+DjvfzCRa/kjJIWU9XLTCDC8gBFxwSzq7RbaP6x5Drwf/ilNqcKtHzffCNZdC+pqSEWScbC
	fFO1P5nc43UyRMWDERkfamBwY6NJ4YzdZxQGYalRXwYEjKTSPE+YPw0cXnnOVSdr8bL28pje4Q1
	tcwUEgvzQAWyP8OhY4Z1EvgvaDA==
X-Google-Smtp-Source: AGHT+IHjWd15bJFnLvYIPJuTi7FnhI2p3c/aAJQJSPYd5K7f8WVJvfxyJpynzpZjmDExmCZGqw22yQ==
X-Received: by 2002:a05:6402:2350:b0:5de:dfde:c8b1 with SMTP id 4fb4d7f45d1cf-5f0b3b62b55mr5957465a12.4.1743877189229;
        Sat, 05 Apr 2025 11:19:49 -0700 (PDT)
Received: from ?IPv6:2001:b07:5d29:f42d:f4b6:62bc:3e10:c9d4? ([2001:b07:5d29:f42d:f4b6:62bc:3e10:c9d4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f088084eddsm4160377a12.62.2025.04.05.11.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 11:19:48 -0700 (PDT)
Message-ID: <3f450f215435d39b5376a83c42fd1da186d774c3.camel@gmail.com>
Subject: Re: [RFC PATCH v2 17/22] resource: Mark encrypted MMIO resource on
 validation
From: Francesco Lavra <francescolavra.fl@gmail.com>
To: aik@amd.com
Cc: Jonathan.Cameron@huawei.com, aneesh.kumar@kernel.org,
 ashish.kalra@amd.com,  baolu.lu@linux.intel.com, bhelgaas@google.com,
 dan.j.williams@intel.com,  dionnaglaze@google.com, hch@lst.de,
 iommu@lists.linux.dev, jgg@ziepe.ca,  joao.m.martins@oracle.com,
 joro@8bytes.org, kevin.tian@intel.com,  kvm@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-coco@lists.linux.dev, 
 linux-crypto@vger.kernel.org, linux-pci@vger.kernel.org, lukas@wunner.de, 
 michael.roth@amd.com, nicolinc@nvidia.com, nikunj@amd.com,
 pbonzini@redhat.com,  robin.murphy@arm.com, seanjc@google.com,
 steven.sistare@oracle.com,  suravee.suthikulpanit@amd.com,
 suzuki.poulose@arm.com, thomas.lendacky@amd.com,  vasant.hegde@amd.com,
 x86@kernel.org, yi.l.liu@intel.com, yilun.xu@linux.intel.com, 
 zhiw@nvidia.com
Date: Sat, 05 Apr 2025 20:19:46 +0200
In-Reply-To: <20250218111017.491719-18-aik@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On 2025-02-18 at 11:10, Alexey Kardashevskiy wrote:
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 5385349f0b8a..f2e0b9f02373 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -55,6 +55,7 @@ struct resource {
>  #define IORESOURCE_MEM_64	0x00100000
>  #define IORESOURCE_WINDOW	0x00200000	/* forwarded by
> bridge */
>  #define IORESOURCE_MUXED	0x00400000	/* Resource is
> software muxed */
> +#define IORESOURCE_VALIDATED	0x00800000	/* TDISP validated
> */

You may want to remove the reference to TDISP, as this flag could be
reused for non-PCI devices in the future.

> @@ -1085,6 +1092,47 @@ int adjust_resource(struct resource *res,
> resource_size_t start,
>  }
>  EXPORT_SYMBOL(adjust_resource);
> =20
> +int encrypt_resource(struct resource *res, unsigned int flags)
> +{
> +	struct resource *p;
> +	int result =3D 0;
> +
> +	if (!res)
> +		return -EINVAL;
> +
> +	write_lock(&resource_lock);
> +
> +	for_each_resource(&iomem_resource, p, false) {

I don't think this function should walk the iomem_resource list, it can
simply modify res->flags, which is consistent with what is done by the
other *_resource() functions that take a pointer to a resource that is
expected to be in the list.
Also, the name of this function is unrelated to the name of the
affected flag, you may want to make these names more consistent.
