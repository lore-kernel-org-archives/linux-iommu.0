Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F8B383999
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 17:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779383187; cv=pass; b=PlxLRlFFFJKBwrFSgDq7kFGRqdmx5c8Nof8eXDbMEvKo8TNFlHYtd0M0lKVV+iWrLe1hZVqUYieQyo5y8P0dkOHBVIAomyJdL0aRFSOgXWSFgvU4umyyBwl6J7Eg7+qWfL4A8dR7eYZdJcvs3WrxdZAllD4Hmtx3mUpIuLAG0nA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779383187; c=relaxed/simple;
	bh=6ScDZWa+hTLOkHKii79L+YYLthbYhtQWZThvRzyqBN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BU3ewXSJ5tXSMZCERWgtqywp/RuWt6GXnm5H9Tq0H0TAFlk8vxxaW0CGHnlwAqM4yyRQ2O7hOjL01q6e90Je4S67KXLj81MGR8PiGAqE5Cs9vn7eRFp/Kc6Q/x3A9RHnDdb+SyIGPkPFLeRbhjkLgDeJUW5e9/YbfK9yvxkI8Cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WdB5K6RR; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WdB5K6RR"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50e61648f10so15591cf.1
        for <iommu@lists.linux.dev>; Thu, 21 May 2026 10:06:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779383185; cv=none;
        d=google.com; s=arc-20240605;
        b=jnXBL8gvenlUPLh1CCmE+hGCn7wALyimeXMCeoVqBuhyJEWlwTAUobvysJMlGYmeSN
         cEhnTYHGq1fE7Ho7/GxfyEB5fwK6NND0/6J2gLw+b+XU5Ca6dHguuwsiV6TFxLPa4O+8
         PcTJchDrrSOAceDOCxOqjgjPBMZgty7WDTgCsIAPG5uTn10Z1pLQpD6enEPgdp/pVnb8
         KsNJsNY9lJilRLklf19lpk676nBbWtjOKS0AK3/3Vc0Nt3C5HfwDeXWvMKyEPTjqzJn4
         xuSZTk3QfMPqcsN1cr9yyJFirdT8bxa3aVyqBU27C/pKjreUnuJJTTCk0DQUJSVWdttw
         ZExg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mhUoyYsFnF9za8i7wBF/DE6TJUENWY+2L07rfya+Q9g=;
        fh=/pCOAHhYgoSlSbvqqoudBR+qjRVSSzIESXqkJ6L1ZKE=;
        b=bVAZASRatxR0P53Q43qQ515yg9MQ3LokCeKPi+o7AeFBppb2smpX1vd2QL5vuF6WYp
         2dHGUIYiqNZAqHKJNVYsj01S9v0YCM5xlvoWMWezPc2Xim8x9zteIS+qhsBgF9Nskvx8
         uw485BuKKpnB+vExPxGOrALu6oB2bpWk/zYGSmL6diRJvHS27pNAx5hZiRHJCGykBR8F
         vzV7ztwOUJG2vJG2MMba0N/s/rjwXINeD9alEs70NEVZHBbi1c9WWrSkS30/heo5Sq9k
         Pso9LzV7runyjpAhD+AEDutts1tO3mSGGAnNpvZCD0NIS058dSh5JDG0QSxZIX5vIUCs
         Z2SA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779383185; x=1779987985; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhUoyYsFnF9za8i7wBF/DE6TJUENWY+2L07rfya+Q9g=;
        b=WdB5K6RR4RNrPWHHViJrO9kOcOYmVXhO79WMu7s4BOT3zpytaDTNEmG5hoaIBJpKV0
         oDa5cmBrpUs+E146fwlhW+DJREKDyfwytdA/X2eRa8/qk5/apBWRUIy71+Ea71J6yYi6
         Pa9zDBp/qpzSE/RxAxWaXwBIvV8z2+Ki0QYLSn9aCvjiBKvVpDX4Wtuy0HPzC1IVbG0r
         bQ9NdCIaMvxvPGRBHXJtI5UStOFk7yYZhgK8YIT+DrXOAEM9FL3IqudpdEoebCLxxtSF
         yBTXVEYiL0awE9KuhtMptX3kxPDwvpCE7GW/BVedLFBMCcw5NLn/1QPWMVt2v7QGBI7K
         enUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779383185; x=1779987985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mhUoyYsFnF9za8i7wBF/DE6TJUENWY+2L07rfya+Q9g=;
        b=dzjinrPufxxiGppkUpI8hD6nUqhhiem28lcvJRksNPOJ0uvLxV5io2R1xjQbFMHKCd
         9YxwMbA5Pwbm3maTgz1Ih/VBRez/BA6atTKSgDM6r//MDBF+hvwY2mX06lhQMSrDQJwG
         pnbkZfM+zZQC7tiun3kBwBFTAHM2D2XHhBeC2lAC3KLt+x+shlIhhQW0AryfaC4nm+sr
         7hikAIUWVHNSvvSNV1CgWn7ukJPLU4pa4xSGC/XoDL4QHFKlx7f8fyofrVhq0AVe8Cmc
         45SY88Rn/7n5lxL6sa8ifxw9T5gsXKF6PA7B4v/Tk+E9EsoxUDf1MAcsSZEpzQo12d5D
         8uoQ==
X-Gm-Message-State: AOJu0YyBn07AekhNaBkmVr/WWwmGY+hF84lKPQxSDzy3fLwRMzHgRFOB
	hsKRPOwMYr6ZydkuY8pn0vCw1AUyJhYD2h+6tg5qfDSx8OgTLkF9lVOSR0rp+SMMjMRX/BC6scr
	mcXEn0XzhycwRiS+fQoXYxmLpYdmrA466c6ndhrhU
X-Gm-Gg: Acq92OHr02RA3Ojohg+fPgdejtI2277mjseb1+TKm9+wDvWYUKuS/HB3+j6N3sUVItj
	5xx+y/gY6y9q7QLEwoaUvVDUQMJoGfzqJ8gI+XGyXztj39VZj40ani78E7hyQ8W2DNj9rMXuD89
	ikaxL1x6U1oI2UjUBkmlz0VZTPzw0iJ+fmifBESwaPFntEBw60iOBpU6n5MYzKvzBY9RKC9O/mm
	X6m+rCvWYAhuVP6jUEqpDYx8tGD7obHL/USoBAIOjpql9m0JHhtYJNxZvxAZO0Xho3YfmLgITSQ
	+22uXPG3NABnmUnOhD7Z4UyowABuTmIrLoGJcCu352mYO6FHZROC
X-Received: by 2002:a05:622a:130d:b0:516:3def:1cf4 with SMTP id
 d75a77b69052e-516c52f91damr11257861cf.1.1779383184387; Thu, 21 May 2026
 10:06:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260512090408.794195-1-aneesh.kumar@kernel.org> <20260512090408.794195-5-aneesh.kumar@kernel.org>
In-Reply-To: <20260512090408.794195-5-aneesh.kumar@kernel.org>
From: Mostafa Saleh <smostafa@google.com>
Date: Thu, 21 May 2026 18:06:09 +0100
X-Gm-Features: AVHnY4ISudxxSxVvcLPDn4R1NI9d_Ojyz-0XSa_zA0I3j6uTkfH8ncuvoLHXOtc
Message-ID: <CAFgf54o4ZnvnJ3369bHb10tvJJVP+5YWq=ec4Jh5K6S6U9uNEA@mail.gmail.com>
Subject: Re: [PATCH v4 04/13] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>, 
	Suzuki K Poulose <Suzuki.Poulose@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>, Petr Tesarik <ptesarik@suse.com>, 
	Alexey Kardashevskiy <aik@amd.com>, Dan Williams <dan.j.williams@intel.com>, 
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 10:05=E2=80=AFAM Aneesh Kumar K.V (Arm)
<aneesh.kumar@kernel.org> wrote:
> @@ -1411,6 +1436,16 @@ phys_addr_t swiotlb_tbl_map_single(struct device *=
dev, phys_addr_t orig_addr,
>         if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
>                 pr_warn_once("Memory encryption is active and system is u=
sing DMA bounce buffers\n");
>
> +       /*
> +        * if we are trying to swiotlb map a decrypted paddr or the paddr=
 is encrypted
> +        * but the device is forcing decryption, use decrypted io_tlb_mem
> +        */
> +       if ((attrs & DMA_ATTR_CC_SHARED) || force_dma_unencrypted(dev))

I don't think swiotlb needs to know about force_dma_unencrypted(), the
dma/direct caller should have all the information to pass the
appropriate flags.

Thanks.
Mostafa

> +               require_decrypted =3D true;
> +
> +       if (require_decrypted !=3D mem->unencrypted)
> +               return (phys_addr_t)DMA_MAPPING_ERROR;
> +
