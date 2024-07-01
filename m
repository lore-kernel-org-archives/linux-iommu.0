Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED7F1F937
	for <iommu@lists.linux.dev>; Mon,  1 Jul 2024 09:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719825972; cv=none; b=sHuPnCDZh22BjPM/SihtI4TDlxNDPeCRjEySaYxPYTWfYi7fqmW6Dz0TOAoSxNPgtW/yRgkQiipLVrZUvWw4Yt4COOhDzRGtDyez15D1KNqyAvvl0Q5MbzHxvWjpNO0aeZhs3V7ZkleCPVlAxhkIAYQUIeWjGI2W3vvXMSk2JYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719825972; c=relaxed/simple;
	bh=CLxBYT6lZAnsn3LJAv/RrK+X+sYbyfslVENO8igDdxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZuqp39SrH2iejpJH9PWrNoZ/70EyC53kg5okEfTakJCL9U1aInXkNctyDCb/ejetvYnJ6T8tjGrbx1eurI6LD+fx5ngBd3w6Fdl5wvsSXZ2IouLe3iQzywSUthh57X7Zr3fn9Jn8NOriUCoO0k2KDi2SgmxwiW04/YWFVt+IXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=mKYFxHhv; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="mKYFxHhv"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f64ecb1766so13411985ad.1
        for <iommu@lists.linux.dev>; Mon, 01 Jul 2024 02:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719825970; x=1720430770; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLxBYT6lZAnsn3LJAv/RrK+X+sYbyfslVENO8igDdxM=;
        b=mKYFxHhvQPLxoSqt60MRkdywHpYpFxpGRGNjFlHLmZQCXA9d5G4RHURPm1r/sURVxB
         x8OTiTn0IBlB8kVj4ocOGAVlWdB3Z8bJz82R1TpyARilirW/ma5Ei5XcpDZZK4DCJyjw
         oPUnHrMTwYOLPQso7XwcyDMZeWkUthymWuwk5yW73mebsJlRFPdka0SF/9ZAQ5zQD40Q
         0YlmuEF7uK2Oh9RyUiSTWFiVGoHItjC2q+/WomVL3kWJ5e2P/wU2jJnjEVFZIo+FUW+O
         CImSkJacfCg8h9aiI/yV+hMNI1UR4ykv3hB/pdyI06hYhHSu8p+aJ6hqbkFePrGpBKYu
         LUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719825970; x=1720430770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CLxBYT6lZAnsn3LJAv/RrK+X+sYbyfslVENO8igDdxM=;
        b=d7BLFqKY9eszg1RPvifkWtO2Lz/ckOw+Rj6t2bQvCGhuoxVmtQxgvJFCgzqWi8yeDs
         d9AhHvXB87lPIhvifFoUfZq6/AsHcEbF2Q1a+wtE8OSUJ0dtulQ8Cc36stCQrdGoMtNT
         JaaIT2WECbTX6BoKDQ8X8KmrdICgDur+aN5ArYKj2navVlrCjY9R1neg5OK/U/GO3tvJ
         /Q7ItrAD27pI2n3WYmwl7/8THKBEjgeUC1jtZft0Ci2CFsw4dswleSt4wVVGgNedri7K
         XlNYp5uSbM0E8cswrB9RJS6ihmZd2yvnyWp6jZzN8mLZDqwuTRPI8Nzj4QHjEL1OJ/u2
         yHrg==
X-Forwarded-Encrypted: i=1; AJvYcCX1i2+L4jCFkSgM0gRy5UVKtD8DcHnSZGHge/3TT5BQsYVtPLE/MhXunkcSL3XhDHPDOBzNT1MUUqgevh/JipOW49jqEoQ=
X-Gm-Message-State: AOJu0YyQGGfCywh8+FIfQyT925QTQlM25W37ILskM0Vp/ghnCsbDrKCG
	bGCwg52Kigo8hhgc3AIUBDCauqpG64/ZDz7P12WBWZLatc3IQCH/720vF/BVI4OZWbjrXN9U9xk
	o/LgssISUAhqud0B/kws9x65S8jDtQZcGlmxZpg==
X-Google-Smtp-Source: AGHT+IFDGkhs/Uqx9rZKsJJeig7rjQkCf5zVJ9PGVd7JKGl0xn5A1rWbgKarqOMg3F9Uak5en6PJWXoJTcb9RkZko7I=
X-Received: by 2002:a05:6a21:3288:b0:1bd:23c7:ebfb with SMTP id
 adf61e73a8af0-1bef6277352mr4231085637.62.1719825970649; Mon, 01 Jul 2024
 02:26:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240701072908.25503-1-luxu.kernel@bytedance.com>
 <20240701072908.25503-2-luxu.kernel@bytedance.com> <CAH2o1u7j6pXhWHL2rBZak6LeXxn_KUbQHjygRGQKuEfS_vmtkQ@mail.gmail.com>
 <CAPYmKFtCzQOOsN7vutoY0MrthtvcGxBqRsbr4ZgMQsaY1CrXHQ@mail.gmail.com> <CAPYmKFs-R4SfjZOMyV5wxjrkV+Eawc-zRWKgAZNFpOezZ6JQDA@mail.gmail.com>
In-Reply-To: <CAPYmKFs-R4SfjZOMyV5wxjrkV+Eawc-zRWKgAZNFpOezZ6JQDA@mail.gmail.com>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Mon, 1 Jul 2024 11:25:59 +0200
Message-ID: <CAH2o1u7u3G0NDj_SjPPasNo9pJ2xDpBAE13=aqSG1EhVQyup6Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/1] iommu/riscv: Support sharing irq lines
 between iommu queues
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	apatel@ventanamicro.com, sunilvl@ventanamicro.com, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux@rivosinc.com, baolu.lu@linux.intel.com, lihangjing@bytedance.com, 
	xieyongji@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 11:14=E2=80=AFAM Xu Lu <luxu.kernel@bytedance.com> w=
rote:
>
> Oh, I think I understand what you mean now after checking the
> implementation of riscv_iommu_queue_vec(). I apologize for not
> understanding the meaning of the code before, please ignore my
> disturbance.
>
> Best Regards,
>
> Xu Lu

No worries, thanks for checking that path. LMK if there are any other
problems with the driver.

Best,
- Tomasz
