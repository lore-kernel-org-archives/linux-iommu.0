Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FF16BB2F
	for <iommu@lists.linux.dev>; Tue,  7 May 2024 14:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715092289; cv=none; b=XOCdX8PZCqZ95zQHe/zs/I/T8hg1BIxk5eUenrzksol1JcXhRwB5Z/8ZaAgVB5acaDk950yA5/HOBbSTgTE7U5IKXlO9DHvV4DuyEHVjK0QRX7P8ABn0/eyTFEhAimKEorXsHevszrAtBcDckUWzUcj9g1B38Lp9AEFiW2kTCDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715092289; c=relaxed/simple;
	bh=pXSdvU0OK8lYHajFVrns2qE/es0E1ZSyzQNWhrEYMKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Biiwzsz4PQYvm9U2EYtLg9gjo3gUETkhWkOqQctA/gD2109xx2T4vhsbrmdtSdrdWWMzAnnpYbPoq/PCfAdkGSrLEByEFZvW2VdAgKWLpWVAiekmi2hStgz/TKiX3QT0XUlUrULdaPC3tjC397kgkpYtLtZbTSnCxk09EVy9KKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=RCQOxrsm; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RCQOxrsm"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7e17b4357a6so66130239f.3
        for <iommu@lists.linux.dev>; Tue, 07 May 2024 07:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715092287; x=1715697087; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52KNTDLC+obpAk96hd5D+rzNIt3oW/ikIeIzud7iogo=;
        b=RCQOxrsmK6ELiVl3bYg2VNYk8YDYwDVOV1EIec2oQ8iQHYAgeOdONdQ2XzQOkQH2FD
         /yN3jrszZqglhtC86J2WyvLAS8wieUh7WR2mwMXf6oQ/mfn6QZso2xxrg+EVoPegqICV
         mh3DnXW2yd8XkeKSz7egfVKhI0unRy108qLR3rnp25Tmy6mKcTj3lQFu8bgNszM/qzpY
         cHn/4PyGlH7/Bv98zJx99xsg216AQbdGDkAsN79SofE2acj64+nYCFBbVPdDa2Gf/DWj
         myJNGhfKO+Ihx+QchFyYU1crl4uz/JoBsOqsy+cJuA78extdcs0l8QfrEcOV0M92f+Q7
         /8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715092287; x=1715697087;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=52KNTDLC+obpAk96hd5D+rzNIt3oW/ikIeIzud7iogo=;
        b=l3X67ULd5e9X8lOAfm9oevGKlK168bQdPCB0UU84N7RM5i+/KOn/UQ/5JPkuTHDYd0
         +ubo6CAisd3mD+rRZ+hOvfYBVz/Cmu0JJGL0Auu/3brq1WPUQbiO403N9zpJFKm/4XLA
         0/ZqWmtdMuEg8eBNgGmO3U8TAsSd0K1mm9gosEM9xioupZ655hVJn6mi5W3HQ1glr1fy
         3Dyqfjbv117Pg6PdmLgZE78ZK9UwbHHO71HSeef8LOMaPOlJEB8QCiFcazWuvouAQzuR
         hmM7c4ytQQsEQkfAHXGEzobpuXSuKe3s3TlcIy7PVPAdMapUD/6nSNI1Zz7mfUm5ywLC
         Z2ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6MvKc9QOjrjUVhnpW81ngc3nfH/yIYon6BDM/k0nbxM/h2ehjRETrsltxBhZQDLq0bAsB+Zn2kSFEyk/MDV6xzLeOfE8=
X-Gm-Message-State: AOJu0YzhSUGZEFxsmEga8CJE07BseYXHT8BBh4vwtxjcvSBRyXS0SPvH
	EHV73qcbLXooHDG1vwpcLSoC7T0HTeAyQdIilIjgkAIK8wN7Ve0VWepe0rnhscrgO95gbsLekod
	a/TaYU2N+yOTt22A5Et8Ourb+UVrzMX1NrXloXw==
X-Google-Smtp-Source: AGHT+IEU8/ZDsdl/a7pEUPUlhakyqhjOEDxLMywsFoH1yLJG3Zk35gTxil1EaJWuOYewmxGhIrFPsYoBYaM/+RK6ekE=
X-Received: by 2002:a6b:ea02:0:b0:7e1:7d63:887 with SMTP id
 m2-20020a6bea02000000b007e17d630887mr3645808ioc.18.1715092287669; Tue, 07 May
 2024 07:31:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1715072254.git.zong.li@sifive.com>
In-Reply-To: <cover.1715072254.git.zong.li@sifive.com>
From: Zong Li <zong.li@sifive.com>
Date: Tue, 7 May 2024 22:31:16 +0800
Message-ID: <CANXhq0rmSpDrZji7de7iz4TSJ-6Fp6_e1ZagsGYRcHAo6n9THg@mail.gmail.com>
Subject: Re: [RFC 0/6] RISC-V IOMMU HPM and nested IOMMU support
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, jgg@ziepe.ca, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 10:07=E2=80=AFPM Zong Li <zong.li@sifive.com> wrote:
>
> This series includes RISC-V IOMMU hardware performance monitor and
> nested IOMMU support. It also introduces operations for the g-stage
> table, which are required for nested IOMMU.
>
> This patch set is implemented on top of the RISC-V IOMMU v4 series [1],
> and it will be submitted as an RFC until the RISC-V IOMMU has been
> merged. Additionally, it will be updated as needed when a new version
> of the RISC-V IOMMU series is posted.
>
> [1] link: https://lists.infradead.org/pipermail/linux-riscv/2024-May/0537=
08.html
>
> Zong Li (6):
>   iommu/riscv: Add RISC-V IOMMU PMU support
>   iommu/riscv: Support HPM and interrupt handling
>   iommu/riscv: support GSCID
>   iommu/riscv: support nested iommu for getting iommu hardware
>     information
>   iommu/riscv: support nested iommu for creating domains owned by
>     userspace
>   iommu/riscv: support nested iommu for flushing cache
>
>  drivers/iommu/riscv/Makefile     |   4 +-
>  drivers/iommu/riscv/iommu-bits.h |  22 ++
>  drivers/iommu/riscv/iommu-pmu.c  | 477 ++++++++++++++++++++++++++++++
>  drivers/iommu/riscv/iommu.c      | 481 +++++++++++++++++++++++++++++--
>  drivers/iommu/riscv/iommu.h      |   8 +
>  include/uapi/linux/iommufd.h     |  39 +++
>  6 files changed, 1002 insertions(+), 29 deletions(-)
>  create mode 100644 drivers/iommu/riscv/iommu-pmu.c
>
> --
> 2.17.1
>

Please drop this one, I have resent this series by removing the
'--thread=3Dshadow' option from format-patch, as it causes RFC 5322
compliance issues, and also correct the subject of the series.
Thanks.
