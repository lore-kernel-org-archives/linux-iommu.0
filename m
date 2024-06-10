Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230681879
	for <iommu@lists.linux.dev>; Mon, 10 Jun 2024 21:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718053896; cv=none; b=RBYTfckEQmgbpfjAX0+5louYefyFCNrLOZxbBTx06scxzI6Xihd3O5SMeJr49STikpGc8wa2sTdHc51JV/GK1LzLoaxSqKheW/ChPIuh+M/SpA3V3s6q/HNZ0K6BOn/XXd9srHafhQCbsHFeyP5nMT9c7PYdCAYKmioLIJFNQ5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718053896; c=relaxed/simple;
	bh=dHfq/Y8UJm8GbkHmEQXODyizeDi9XIeLkMTzcTcIpkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NTtJfykMejv+OIm9jwhXrP1Wm/+C+A44YbMRtFAukzn33T4AsNSQAFDHo/G1wP+IW2zMdLo25Z2WHrJqNnx+AIB+l0FA8Lgi0m4KntajWXRVpYTrU17Jo7EoX2otGATifSyVWg8BhIeWjSqpfkv8WTgChKge5BBeHdeL0oICnmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=YCetgToY; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="YCetgToY"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-6bfd4b88608so276766a12.1
        for <iommu@lists.linux.dev>; Mon, 10 Jun 2024 14:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718053894; x=1718658694; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atjVVvhqJGVBGQeQC15VPPq3ZmuONR7VOIjSThozUfs=;
        b=YCetgToYQZeFUtTb4f1Cf3NF6n1C0yDw/LZqJBlcxPUg75FyrA77/eiN8/qi83mFOF
         Xlr21WKGrCD9uI3dV/v+DJygySJXTp64nNzIvbMoIHE1xCiAgA0zL4Pca9RJbQwKYXax
         d54pJdIgrqO5zuMgCcezNVOj85LZWg58IsBRU5A9cn7vK4RA5PutXP0wYWe9Tg1C4i6S
         B5yiDyTJgiqmxXmGa2BNx0V5Pj14XuGR3xIXGhcEawCd442tti8hguKiS+eoPhci2jgW
         CpeZb6+gyDc6xXEdRQtj57km1ej9OU+fEhHaYW53s6J0aJNwu/gYwq5AqcNCMLkwD5iN
         V63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718053894; x=1718658694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=atjVVvhqJGVBGQeQC15VPPq3ZmuONR7VOIjSThozUfs=;
        b=iFwFxoucLomFLONdH4D8N9uAyQP1UFrlsZRzdx9PFLXyy8dF24SzZdSCy5BS/7hduf
         izhHUg4ao3q7YrJB4TnCVLX2mWXOSvOnnrGgwIjFXjvaOsrijtGO82VM1Sk42lZzu/eF
         e5FCUs39FMVjyDN1GF56d++xZkEvrEZBEEGFrud2sGKR2+XAnoi/wnjj+N72kXweZ2p8
         WGSMkPapiAnptDxI9Lqo1f46/YWecgr6Mrw9B1cs8cMgEih0T4fNhrcGC6AOuk33PS6+
         l8ta1h5vdhtqvknEesSrDUqLXGvFZRtbr9K61LEafPJpImiHj2O7ADv03hHXukhqaHi0
         j+Eg==
X-Forwarded-Encrypted: i=1; AJvYcCU3yuCO8Y2uoL2I9hqzdiXN6RX7hwo9KHbGEt/zrrG0WwxAmOJXfL8yT7mjPMi2N0AC0yLY5Z2ycwviDU+2QXQAkLvOPxc=
X-Gm-Message-State: AOJu0Yx3y7zctIQ0kuHzQAQwDRtCAynP9qE46ErSbIFZuq4HJg8/ZDyR
	epcmljef6fOrBQg45UPrfmQfi0FXH6S4YX+FqvP8yeGKZ6gVySH13XaNWXBK0k2AO1iEipQiuQE
	Q3AM/C7LEkTmOsNa9+eWo89DsQUCfwK/eoPnzUw==
X-Google-Smtp-Source: AGHT+IGchpbaicHoHxCHYTOkBWbMZo1yhnrL8jazakPLDq3AVxHuApmXC5MJskUmy1m+m4dJ2ZJiSm2/UdJlr5SLmnI=
X-Received: by 2002:a17:90a:5785:b0:2c2:9591:342c with SMTP id
 98e67ed59e1d1-2c2bcac2c65mr9210122a91.3.1718053894451; Mon, 10 Jun 2024
 14:11:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1717612298.git.tjeznach@rivosinc.com> <422f66285da1b164466b223f83d7f06564968f09.1717612299.git.tjeznach@rivosinc.com>
 <20240610-3cd1ba07c1b488a451dd7ddd@orel>
In-Reply-To: <20240610-3cd1ba07c1b488a451dd7ddd@orel>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Mon, 10 Jun 2024 14:11:23 -0700
Message-ID: <CAH2o1u6Yav1i=EUX-a4XY4OLtU5RvshHU5ffGE99mgSTrqmN2w@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] iommu/riscv: Command and fault queue support
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Anup Patel <apatel@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Nick Kossifidis <mick@ics.forth.gr>, Sebastien Boeuf <seb@rivosinc.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux@rivosinc.com, 
	Lu Baolu <baolu.lu@linux.intel.com>, Zong Li <zong.li@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 4:06=E2=80=AFAM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Wed, Jun 05, 2024 at 12:57:48PM GMT, Tomasz Jeznach wrote:
> ...
> > +static int riscv_iommu_queue_alloc(struct riscv_iommu_device *iommu,
> > +                                struct riscv_iommu_queue *queue,
> > +                                size_t entry_size)
> > +{
> > +     unsigned int logsz;
> > +     u64 qb, rb;
> > +
> > +     /*
> > +      * Use WARL base register property to discover maximum allowed
> > +      * number of entries and optional fixed IO address for queue loca=
tion.
> > +      */
> > +     riscv_iommu_writeq(iommu, queue->qbr, RISCV_IOMMU_QUEUE_LOG2SZ_FI=
ELD);
> > +     qb =3D riscv_iommu_readq(iommu, queue->qbr);
> > +
> > +     /*
> > +      * Calculate and verify hardware supported queue length, as repor=
ted
> > +      * by the field LOG2SZ, where max queue length is equal to 2^(LOG=
2SZ + 1).
> > +      * Update queue size based on hardware supported value.
> > +      */
> > +     logsz =3D ilog2(queue->mask);
> > +     if (logsz > FIELD_GET(RISCV_IOMMU_QUEUE_LOG2SZ_FIELD, qb))
> > +             logsz =3D FIELD_GET(RISCV_IOMMU_QUEUE_LOG2SZ_FIELD, qb);
> > +
> > +     /*
> > +      * Use WARL base register property to discover an optional fixed =
IO
> > +      * address for queue ring buffer location. Otherwise allocate con=
tiguous
> > +      * system memory.
> > +      */
> > +     if (FIELD_GET(RISCV_IOMMU_PPN_FIELD, qb)) {
> > +             const size_t queue_size =3D entry_size << (logsz + 1);
> > +
> > +             queue->phys =3D ppn_to_phys(FIELD_GET(RISCV_IOMMU_PPN_FIE=
LD, qb));
>
> Shouldn't this be something like
>
>   FIELD_GET(RISCV_IOMMU_PPN_FIELD, qb) << PAGE_SHIFT
>
> ppn_to_phys() assumes the ppn it's converting to be shifted up by 10, but
> FIELD_GET has shifted it down to zero.
>

Good catch. It should be pfn_to_phys(). Fixed & verified on IOMMU with
queue ring buffers in fixed memory location.

Thanks,
- Tomasz

> Thanks,
> drew
