Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FE1D27D
	for <iommu@lists.linux.dev>; Mon, 17 Jun 2024 02:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718590589; cv=none; b=ZOFYMqnqIIdGehllhOYh22jAaE0nAq1a7WkAMHWTNWHhwSev2vX8ICxtbrCENgY92zVZe3flxmjY10SdjGgxNQ7m3iW2k5O+vT4ugPbC+GAC763+oCQCr3mu7Jo5+/GMpS0OqoOVezQSCcxbQE7lgxpZCE0r5fumQUbZKp7o90E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718590589; c=relaxed/simple;
	bh=UBe1Lv7+yYIPYv/ejR+qRz6o9xgdFmnLxhO1bvac0Ys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jxBTahNuF0lLVWusZqCqgI8e0ZRZto7WHu2pJycDnk0jWblXL4BwnssgM1w/NlP1+Uj17quccuz8igUjRuJPCwh3oWqzDVuRfqMA8bxUlICT60zRizjllFwHhjXI5YXCEsmpazO4zJ8CjzNgiCX6GZJCvN9Z7rmqdHlP2TH7zME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=C7GcDl/6; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="C7GcDl/6"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7ebe019b9cdso126868939f.0
        for <iommu@lists.linux.dev>; Sun, 16 Jun 2024 19:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718590587; x=1719195387; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBe1Lv7+yYIPYv/ejR+qRz6o9xgdFmnLxhO1bvac0Ys=;
        b=C7GcDl/6LRrh1LkGJWkDGQXmmYbSU/4cMtmoQwi5bn0rbdZxEqzbnWXZ0dv4QZOXTb
         6LX/UjUk+st61a32Q1tNexRxt6v2IYsinX5Ouio3+2KoAv+JVjlakxHUti8hJrQ1SU9t
         f9t4d9baEzmHGgQyPcGFxNiPgdXzVldTv+Ydd5oO5suFfCehcBM0zyL8Uk0tHKrM40m1
         b/qbDKXEXZRWYS8SI7tBkQjUdp3kK8f5fL8sqnp9EYxyn5bkq89E2pW/1x+W70u/CZZW
         rREQ0Zz/9E8ArCSYEnrArHAlsrNRZq9vAN47L1kBMaqjGgq3NNzPrI9cWATAzc8L01V6
         lOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718590587; x=1719195387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UBe1Lv7+yYIPYv/ejR+qRz6o9xgdFmnLxhO1bvac0Ys=;
        b=HbOAYUrEQu+SlOKb+dbQJ3fBy6UCuQqOSUbFuO06ETF+Tg9aTEHOR4z//64kldq0+U
         45Gq5HaXKcvC4NsN/ZW7pO3gEHRZ18LbyvdCOGpxIN1XtW+XEkTB2/ahe8/E76M2cVix
         VvG2BRhrB0gwdw6/sHZifHTPDMy5MEJYaPlCY+KWBCW15+1Y/FFozeJSNRScoKbzhO+T
         HxtCZv/YQSS1Towm0KmBo2zkAablfX2im0U9nGR1gEX+SwV8L/Y3T72uKnPQZcsypheB
         TAflBcDT8I7GtMMtYg+nhC1WRngl7+xWiJGPkX+nu96mfOecF6XnRhC6WT9s8owhIEdB
         b+8w==
X-Forwarded-Encrypted: i=1; AJvYcCVoORXIfcTJF7Zfpf6oqdDoiu2duojjQ7SuuclafY8veFMgNmm2m0yls10k0jhPcRDg1srBfeHJZsTZr8VPll1rHw0exyw=
X-Gm-Message-State: AOJu0YynoQgurkLa2I2Mu3hhWDiVwUV/gkF+JxProQDwbs3tBH+86+p9
	74OLeTlAEw74SUSH9rPpsxhE4X3h8svJQrVTAzk8nZoNiPEl5OFUVV8I7aUwwETKLbK6Ng0oVkf
	NPxgC9/k8dR7aGai0OLTkL9uJQNBABX4WQ/JZ5Q==
X-Google-Smtp-Source: AGHT+IGjqStvPzq4eQHVMVjSkHpNaFIElfvbz63p0MeN0p8pMu3otddGU/WtwKbFVYh2nVlV+RVSIco/aX28xZYpEKg=
X-Received: by 2002:a05:6602:3f95:b0:7eb:9697:95c9 with SMTP id
 ca18e2360f4ac-7ebeaef3ee1mr937068239f.0.1718590587407; Sun, 16 Jun 2024
 19:16:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240614142156.29420-1-zong.li@sifive.com> <20240614142156.29420-9-zong.li@sifive.com>
 <fb252e35-46e1-48ba-b236-a3296922ffdb@linux.intel.com>
In-Reply-To: <fb252e35-46e1-48ba-b236-a3296922ffdb@linux.intel.com>
From: Zong Li <zong.li@sifive.com>
Date: Mon, 17 Jun 2024 10:16:16 +0800
Message-ID: <CANXhq0pukeeAEde2i2UDOAU3fhwxf4zx6dzbugU=XGrT7kj+3Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 08/10] iommu/riscv: support nested iommu for
 flushing cache
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, jgg@ziepe.ca, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 15, 2024 at 11:24=E2=80=AFAM Baolu Lu <baolu.lu@linux.intel.com=
> wrote:
>
> On 6/14/24 10:21 PM, Zong Li wrote:
> > This patch implements cache_invalidate_user operation for the userspace
> > to flush the hardware caches for a nested domain through iommufd.
>
> $ grep "This patch" Documentation/process/submitting-patches.rst
>
> Same to other commit messages.
>

Thank you for your tips. I will modify them in the next version.

> Best regards,
> baolu
