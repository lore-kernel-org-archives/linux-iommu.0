Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A287F394
	for <iommu@lists.linux.dev>; Wed, 12 Jun 2024 00:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718152270; cv=none; b=GMlYcuLBDH4z/3IugtBfJLf+C4RBZ+ia8MY4cIJmgT0k728qtwRnaooGXrWcf2rnb4dKMcoh1BlolkfghlD/lo7QElCGUCEBcG17tCSwV0ftmyZRIlXrqIUfkcV27Uhfsg3YOAMORXDZILT+lllwutpf0W4F9sh3pN+zR6H3Y38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718152270; c=relaxed/simple;
	bh=eDEh/Oen7DAJWK7uRkISNRf9YcAHO+uOwB2Trnusrys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fw4IRMyV5pHsBHPIBEOsoQ/onCYXR62MO8lQoD74AEjWnHSztQxr7r7ucuKFOmW5lhW+AR9kSbgqGWH0tZXL6oy8CDdarK6/ojetDXdbZ/yfemJZiFqFQEX0I+zuKTq73FYnDX4wpS3U+vC0f3qyoqc/iOJOH5aKO8vzqn3nXe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NsPxSc4W; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NsPxSc4W"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso7940a12.0
        for <iommu@lists.linux.dev>; Tue, 11 Jun 2024 17:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718152267; x=1718757067; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oP9KKIbLoya/+52h4fep3MAtzpYBaRZzspTiBl2594Y=;
        b=NsPxSc4WMR9YNLBT7yq0TKVwHRp6GRafeQkZJZtrzp4fcYrMlg3rJ/Y8gE1kln1Zu2
         3/sijW8H1T0IPyrpCfqgVg1i5XrR7el9w/LtjKU/P1rBSLWCKns60pywch9bea9y54Jf
         h747rDQjymhUEda8F3vM8RSYxxv803POaAHIeyCIbXL90QTGCsRrW6KZ9JFSICFmTSF7
         WAq1UCQ6IaSuwfPO9Zq6wTFInEpm+9tiZ1QShi1o+n4GvlUELZTJnBPoh0wf3zHhlOzs
         6dqGYw2G9uRl4mwyvhJaiT04BjydllbHSTMiBTK6V6DUmeMMziWlfDilO2vEay8+xdY2
         xEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718152267; x=1718757067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oP9KKIbLoya/+52h4fep3MAtzpYBaRZzspTiBl2594Y=;
        b=KjuAWW+hRWpQn5M9iMlK5/169RzYps1Uklow3SkadtTUrzf0jgna0uhiJaoU03WFW8
         vKI4W36gGeubCrsXvBGgmuEigwB6fV5Q1iOSrbyg7k8VZpavbgDr4DM3Q+M2cz/OswJc
         8scsFeCn3BmjlaH102rna1GuLox5QKXaFhkRjXqozdzUee86AMOEvPCIB6IcADVMi4/O
         XxTPmesslB2Onb1OkXKpB9rqw6vgjdhlwC4mzWMLHzhTzu/ChhOpMe/HRXijUO9DiwiY
         Wdi+m7L43aq2EMyxB77ldHL4ErJ2jMfq/akJSR0iMClVqEhpQpKWciql2adQf9RNkc0b
         aO8Q==
X-Gm-Message-State: AOJu0YyunzUdLZi3mMicNYji8fUdWUfb2o1q7yJBJaeGsrRZgUXlHY4x
	20Z2wFVRx+r8jiK1ck8rfcW9ozOBIJAeQW6YuEUQp/4NVOkgyVDUB+ahO0CFRir1Uy3EWXxZES4
	k23VNJrNIfkSmqptXjKrvYwqVjkwxuemGS3+Y
X-Google-Smtp-Source: AGHT+IFhK3nW1s3vFpcSBj0EEbCcEV49HXRnLV+cBns1nx9+LAzI5Pcqddd/N6HdlI63NBcazatyNT9RnekZ/uQQocc=
X-Received: by 2002:a05:6402:1d17:b0:57c:57b3:6bb3 with SMTP id
 4fb4d7f45d1cf-57ca84b8036mr93464a12.6.1718152266688; Tue, 11 Jun 2024
 17:31:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v2-318ed5f6983b+198f-smmuv3_tidy_jgg@nvidia.com> <3-v2-318ed5f6983b+198f-smmuv3_tidy_jgg@nvidia.com>
In-Reply-To: <3-v2-318ed5f6983b+198f-smmuv3_tidy_jgg@nvidia.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Tue, 11 Jun 2024 17:30:53 -0700
Message-ID: <CAE2F3rBJxj=zFmtdGddMdPy9HXVP-cu+MtjaJhrJpjux_GZ6KQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] iommu/arm-smmu-v3: Add arm_smmu_strtab_l1/2_idx()
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Michael Shavit <mshavit@google.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	patches@lists.linux.dev, Ryan Roberts <ryan.roberts@arm.com>, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 5:31=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>                 dev_warn(smmu->dev,
> -                        "2-level strtab only covers %u/%u bits of SID\n"=
,
> -                        size, smmu->sid_bits);
> +                        "2-level strtab only covers %u/%u of SIDs\n",
> +                        cfg->num_l1_ents * STRTAB_NUM_L2_STES,
> +                        1 << smmu->sid_bits);

Does this mean it'll change from printing

"2-level strtab only covers 25/32 bits of SID"

to

"2-level strtab only covers 33554432/4294967296 of SIDs"?

I think that's less helpful. I would prefer printing the values in bits.

> +#define STRTAB_NUM_L2_STES (1 << STRTAB_SPLIT)
> +#define STRTAB_MAX_L1_ENTRIES (1 << 17)

Consider adding some extra white space to nicely align these #defines
with the rest of this .h file.
