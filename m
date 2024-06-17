Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59453D27D
	for <iommu@lists.linux.dev>; Mon, 17 Jun 2024 02:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718590527; cv=none; b=h18GYK6mmVIRzjnLTiRybEYc/Ld7mWuUrfh0ZtF1+/gAeWyIzAi7eZGJwvWBwUJ75Mf2Soo1LA2yr38VRXsrFrfqm9bw55yLKo4EoNI2nD0+Kx95RjBmu0sEY8J2L01tKAICXy7drjlqt5eYweufoln5fXbZWIjuvAYYnAtex50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718590527; c=relaxed/simple;
	bh=33+gUd0BUh5twg7E+FkXYihWtxidn7jwrrmJRG8qvzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQ7uvzBtGvtf9GW1QLud+gKYppLNLdHMdSlmPE8AGOA5ZHZ5u4OG+b//hUh9yrU6VQAbcPMnbVLxpYLKLKqfIqX5znAF6BHwF6AuNLMyac1ZIBAQ+mq+V4csIBT7dwxPASPk2X/dOTX5sBC2g/e/wU1TUFbn4g60nhTFHVQYByY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=KtXdvD4p; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KtXdvD4p"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7eb7a2f062cso159524239f.0
        for <iommu@lists.linux.dev>; Sun, 16 Jun 2024 19:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718590523; x=1719195323; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33+gUd0BUh5twg7E+FkXYihWtxidn7jwrrmJRG8qvzY=;
        b=KtXdvD4pb6nLomhwNqfNLEkMD56HTcB0Y44suNQoQCVlmLxJTvBawVFDz553YdqKjd
         VLGTFI3v8tmgbOel2DeqT+8sNjNZGwSv3EuveIP2eDomsn597yO6csKKviICxau+iwLA
         HA1DoJXyshqmVcEzGH4CT1cdBsCSw1hM3hVDuPAWH1ZflTBmRGz60Ne3FZA1z38suCGp
         stTYUVnxoBdmGa3w3mtDhZUyFzVbPLpZ4UyQE+hKfyuusTIUgJE8LRBdElvO3tnxPI79
         gIwGciJro48WQZLVeshh26XwnSMJ2EKLbmk6VKpNGYwC8ahKfXfx4k1KffTXtR5KQQu5
         B/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718590523; x=1719195323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33+gUd0BUh5twg7E+FkXYihWtxidn7jwrrmJRG8qvzY=;
        b=aXmITRcBB8q/DJIkcIjBDT8RXkyxMvwdbb3ofJj1Fv76TizxOwP20gk1+wRNSwZBlJ
         kVyKAip5oCYSNVXxNH2GPZix3gDOfmPdGw9mOAwHconwgSdafqk8Ur/Sge6/OtlqnPeM
         WOXp42MCDEymqWdryAbVfPkDhR487HzAeOdLTNeX1bp/OPsUi/AhoYvMsQD8YWHHOgUS
         Sk5ZvhOxXlrH1sIXga/uZEpVeoA0GyzdqaVbdXYIum5Zi46AIsHc5f4i8lh+7tyXBLAM
         X43f/4SkwaAI6ao47MgVC0EpLTT86Dp4UFExEI6HvlJsnA1HSDP4GRKeXbCXvNBY21CC
         Zv/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUO5z5ne55HKHA8Ipn5+vNcxAN8RkD0+5dDVNbarlCM2A/RJme/JkXZR+1SACiyITH7lrZvL5ag//Ib4V0DMmc5V/PZggc=
X-Gm-Message-State: AOJu0YyKAH8OUbsjs/3Aw0ggqa4xMfA2HgKq0Tk0zZFsg3vOYBpa0Uxl
	sAm4zqvp6UKOMpq0UZSfypKx3eB/CIBNdpKIteO/UUWvF2Knv0tv3hHJ9aJPE386Mz0NDUrEih5
	jRWiCmAM0Rg8zprFQz6iueD+rLE6rP9/JPm9fWg==
X-Google-Smtp-Source: AGHT+IEXfvyKaGcOxkCTeIcxMYWxqVnan6HZPo3dOL51Q5uIxGPz0RzQEZinChIpjeGp349yqoA/StIWD6aWJiVwPU8=
X-Received: by 2002:a05:6602:1549:b0:7eb:c972:dee2 with SMTP id
 ca18e2360f4ac-7ebeb4923c5mr971786539f.3.1718590523416; Sun, 16 Jun 2024
 19:15:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240614142156.29420-1-zong.li@sifive.com> <20240614142156.29420-10-zong.li@sifive.com>
 <ZmyIASyk5pfm8hwa@Asurada-Nvidia>
In-Reply-To: <ZmyIASyk5pfm8hwa@Asurada-Nvidia>
From: Zong Li <zong.li@sifive.com>
Date: Mon, 17 Jun 2024 10:15:12 +0800
Message-ID: <CANXhq0psbMY7B=wBL_K8b5rnsfWaBJk+Ea49BpvLO8Sfwwyz7g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/10] iommu/dma: Support MSIs through nested domains
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, jgg@ziepe.ca, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 15, 2024 at 2:12=E2=80=AFAM Nicolin Chen <nicolinc@nvidia.com> =
wrote:
>
> On Fri, Jun 14, 2024 at 10:21:55PM +0800, Zong Li wrote:
> > From: Robin Murphy <robin.murphy@arm.com>
> >
> > Currently, iommu-dma is the only place outside of IOMMUFD and drivers
> > which might need to be aware of the stage 2 domain encapsulated within
> > a nested domain. This would be in the legacy-VFIO-style case where we'r=
e
> > using host-managed MSIs with an identity mapping at stage 1, where it i=
s
> > the underlying stage 2 domain which owns an MSI cookie and holds the
> > corresponding dynamic mappings. Hook up the new op to resolve what we
> > need from a nested domain.
> >
> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>
> I think there should be your Signed-off line at the end since you
> act as a submitter :)

Got it, add it in the next version, thanks.

>
> Thanks
> Nicolin
