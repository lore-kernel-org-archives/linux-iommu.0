Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1E0176AC8
	for <iommu@lists.linux.dev>; Thu, 30 May 2024 08:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717057222; cv=none; b=G/JQVAf81zg97RF+mvjbtj9AiRAmp86S1Zj7b9KaTx2tw9r2ncL1Rq0okNZ7nRSi1oiJ6DNuawErxOhQhO2R4S5wiitwvj2vFpFAnKA01Ahz0Gakid49GlVDyoDk74aSqTFesd5dUP/L/4eDgSpxy9OEhGHO+F/RFsYPVyjQH1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717057222; c=relaxed/simple;
	bh=9hQvbxkraGoQByyfnB/SKIQRAxtxMniFpbudb4R8J+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJbsK4Oi7Wv71mKLx3rgERROoSPTD5IC5ZCYjG/9KTXELZISNjlbO49bAYcRukb4H7bdpIWVR/UNYjMnimI0tBsy7jddNdEJSS7rSuE2C/cJ/QCdxoY1kho+yiF1gul2+KnpynKzCf6cbguCIEQJFY6EEU0MJpG3bkYtO6lQIww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=DPZmW6Zd; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="DPZmW6Zd"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-420180b5838so3398945e9.2
        for <iommu@lists.linux.dev>; Thu, 30 May 2024 01:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1717057219; x=1717662019; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xAFqwlnprskdijXg0+qVMxiHshvm9v4VwBvMivw4hqg=;
        b=DPZmW6Zd8slKTaqmb9zFDWDsrFgrYr/YvhiNJAXKNrga39j+recwIJCoqztrVXqpij
         z+Yak1t7Sn9J7tYXmSlaSQiQveZ4xSFyyJVXYn63HeBItmCpbCaq27THGLZpPwyY3ZdB
         gwGro7JjkKxC8AhA+U0aBqLz0TJ9ZX+lsS1707jq/DdR/on7qZ4adc4gK11O1K8YX2dp
         0TJa717mQVUpzudXhhKcMuPDfBZ2ab/pzfEDubVyUktk0JW/eqgdkHLBKwCQHfPxPy0v
         /yxq0MEbkC7+Qm/Bqnj2W89CZkyPH7jDFx/N3VC47/dBiMwk/PBMwV/LQoIXhCw+hKsh
         r1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717057219; x=1717662019;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xAFqwlnprskdijXg0+qVMxiHshvm9v4VwBvMivw4hqg=;
        b=TTLfhJsOmOzC2OZazjz3+Qwa1GMnXiU+dbNIHxz0gU/mA3U0O78dHz+4HylxtILvWm
         8OaEO0A11vTTf2DDf5L2VP2JPilAgtBD0V0UweYca3hBTq+mQZvJM30D9xJ0CNOaiS8+
         cF6AIZEP/Sq2CSjypJbcq9KWJjFO0YzrDoKgZd3Yjte/ZgWF3qAj4AZgzuJv9owcbpvr
         KPLY4OvBtD9H7N7vGwrlVYJR++7Z9qo46HhESOz7WQbqbKtMZ48QQnfRAPva6q+900LQ
         JaBJxM7ocJf8dWQ3McsWBvh7j3Gr+0RRaUmUcXKIH2wDVAUVf10xfolazbfsVuy/o83P
         gzLw==
X-Forwarded-Encrypted: i=1; AJvYcCWRloPlla8dgj0IsZsZUwfPRWHTfUnp74C8+V1P3NRWzgF7r9o36B5q33BqTGv4BzJcPUA2DGuBu93f+lzs1JWZiE8HTnE=
X-Gm-Message-State: AOJu0Yz8QzklAhCgtzraykIteZ2zw2YVznAvggjDehWQtiqyheAL73+t
	DE3ntkZ9xz/wCePIgWxq6xnjFBfmmNznov+Zar64llrD7yZfGx/d72LBht/EJxE=
X-Google-Smtp-Source: AGHT+IG1keazYzeuDlTEJWYo0DNz5z0le/1L4QF2tlIZz4H3UjAuU4J130ihkcGjOo2htfDSVAmo6A==
X-Received: by 2002:a05:600c:45d4:b0:421:2241:5be3 with SMTP id 5b1f17b1804b1-4212780a865mr16402325e9.5.1717057219466;
        Thu, 30 May 2024 01:20:19 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212708a6fbsm17283305e9.44.2024.05.30.01.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 01:20:19 -0700 (PDT)
Date: Thu, 30 May 2024 10:20:18 +0200
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
Message-ID: <20240530-af20943d2b372faa7b11ed41@orel>
References: <cover.1716578450.git.tjeznach@rivosinc.com>
 <7dcd9a154625704cbf9adc4b4ac07ca0b9753b31.1716578450.git.tjeznach@rivosinc.com>
 <20240529-08fd52a8e703418142bdfa84@orel>
 <CAH2o1u7DmywajQWRnQEW2Zjw95EzruM3_Mb5Z-K4zJChh8pGLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH2o1u7DmywajQWRnQEW2Zjw95EzruM3_Mb5Z-K4zJChh8pGLQ@mail.gmail.com>

On Wed, May 29, 2024 at 10:59:58AM GMT, Tomasz Jeznach wrote:
> On Wed, May 29, 2024 at 8:15 AM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > Hi Tomasz,
> >
> > I reviewed iommu-bits.h to the spec. Most naming matches exactly, which
> > is nice, but I've pointed out a few which don't.
> >
> > Thanks,
> > drew
> >
> 
> Thanks for looking into this a bit boring file.

No problem. I also meant to point out that I checked all bits/offsets as
well. They all looked good to me.

...
> > > +enum riscv_iommu_fq_ttypes {
> > > +     RISCV_IOMMU_FQ_TTYPE_NONE = 0,
> > > +     RISCV_IOMMU_FQ_TTYPE_UADDR_INST_FETCH = 1,
> > > +     RISCV_IOMMU_FQ_TTYPE_UADDR_RD = 2,
> > > +     RISCV_IOMMU_FQ_TTYPE_UADDR_WR = 3,
> > > +     RISCV_IOMMU_FQ_TTYPE_TADDR_INST_FETCH = 5,
> > > +     RISCV_IOMMU_FQ_TTYPE_TADDR_RD = 6,
> > > +     RISCV_IOMMU_FQ_TTYPE_TADDR_WR = 7,
> > > +     RISCV_IOMMU_FQ_TTYPE_PCIE_ATS_REQ = 8,
> > > +     RISCV_IOMMU_FW_TTYPE_PCIE_MSG_REQ = 9,
> > > +};
> >
> > RISCV_IOMMU_FW_TTYP_* for all above
> >
> 
> I guess RISCV_IOMMU_FQ_TTYP_* to match _FQ_ acronym.

Oh yeah. I guess my eyes had glazed over at this point because I didn't
notice the 'FW' vs. 'FQ'. So, yeah, we want RISCV_IOMMU_FQ_TTYP_* for all
above, including RISCV_IOMMU_FQ_TTYP_PCIE_MSG_REQ.

Thanks,
drew
