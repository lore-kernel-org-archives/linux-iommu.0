Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463C7347DD
	for <iommu@lists.linux.dev>; Sat, 14 Mar 2026 18:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773512665; cv=pass; b=OpblnwGc6OzVABRYU5LYiXVhOSBt6KxrijFWKuhabjgQ25GsH9Qi5mvD+B4gY91k8hBW1ftNIB4of3ylXK3G0nJivuf8YugOXf+WmyA/POIOBNwESJFy6C59hM5BSbfTW14tBhLYF2W3S18POUUZUtxUVY8M0QjnXtgl2Al6f3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773512665; c=relaxed/simple;
	bh=RGueu44f3311svWUAZ3Nm2CC7jiHSV/Gihk1oWbAqXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=claDPePn09NO8HAFZtPAmji1UzT+GBUGwCi4JX7enI8aNbFv+bT9irvt0GkD0k4LmFE2vwkjzA/P9qZfyvXa6B+bYkX/OqLHQ+l3y67Am1teO543XRLBq5DtCk1hf9X9g45jzHIHNJXsSuQcvilPsx3AfBJh/cnIwyEP5pOSFic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=qjfG2iwE; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="qjfG2iwE"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1273349c56bso4855877c88.0
        for <iommu@lists.linux.dev>; Sat, 14 Mar 2026 11:24:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773512663; cv=none;
        d=google.com; s=arc-20240605;
        b=gUCtL9OUJjtus0PN7elIdkPU+WwbsD7ld5GvLnTE2U8irmf77ROCDPn18dQmBXZ1Ax
         uU6sGpJhoZ2nrYaLiwm+1gRHYmMFaIxDGjDAf/h7F6n3VWTcR9JMMOf40qAE/jXthY3z
         7vBe0+TYqnCbG2PI/CZ6/XwxJsGQzla2WVgIGU6m2xmsgs8A63jxm/Tm4W/+xXxzrdBO
         6V+PYHQRHMR/A22dNlCK/kaf8dLbfdUoJmyFb8JXHC7LG7Wx6Mx6BpoSugKB7DLS/mDg
         jwIvIh1E9kMqMcLpLWPXl2EoJb9qLzQsCnpKiv72Oooj9PhJ4SoX+FZdxLjdYPkxSHpi
         bxsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fvNl2IYSFSlpzaWdwoGLoNSu2ighwO6e4fTkkZTILus=;
        fh=UVKm+rF3oo3r2wHS4GqFCro30A855bJ6wzLxQdeVKVI=;
        b=Uy/DxZZFdpcLR+rak+lNIfy16MejO9doo0QZd0PySPDICCdM9MtP51ogklvZRtMB2O
         GTzTfgre+wKJQ+x32qAS7AVEv/l8Agv9HyMpFgtIHWUqXNzYOFy8CAvUSExrp4BSKMca
         FusqZ1JW3FwXkXPuGLoYW2Qp45Q47Z4wH7v739RELh38bIgml6vJUCbBbagsomNEvcF4
         XuFaU1OznRMNo8owt692qS7cX8LWeLU/72ZNracna2tBB4Db2vRolzqJ9WKNYVB96eZC
         9bN6zafovEpKTLgXmc5YJEnWw9PiprgXHbUF/1DX0AX95dT1zTs0mpw8eYeVwJfL/zZF
         jBpA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1773512663; x=1774117463; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvNl2IYSFSlpzaWdwoGLoNSu2ighwO6e4fTkkZTILus=;
        b=qjfG2iwE0D2mmnFg+4qPGrXWbES2KBUm48IdbDpTRIh9J1PJOxuG8jdvXyAez5gPwY
         STjSdG7HiGrqrQkT7JpLxZe5PyDmFVHFYGgZ34u3QUJMxU2q2IUkHlQxiijgLa5NQLcL
         GvbYVcpHuuRMRTez19qNqXIf9Y3ty/Yr7fc3ZLtsgkkodmUTSxONft7P1G3ggLsR1AWK
         Lo7x/gp/hYQVyzQ40ZbC6uKtEyd/+r98VYo8eXc5z4D19rxOxQbUALSu6Dw8h4XWeZXk
         YLlysBgSuExsRNjwdbuwhkSnvIELpST5wyBJKCd/XjSKgJEfwExzVIm6nv8rzuPSYNjt
         uNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773512663; x=1774117463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fvNl2IYSFSlpzaWdwoGLoNSu2ighwO6e4fTkkZTILus=;
        b=mAUpUqtwEoIOUnNPpdULXtVGCFs1YJhGFFIZpcpN8mTeTxOwlblLyC5IX08I0ojvSs
         S9HYWvD+P0a1cmuUMSARuYLQRZ9bK4EQyx8k6SK/ZvQxB+BocNq6V6j+8DBXI9+kkRGW
         MfxehEeT3NQsSM/PtPNKDaR2n0tdRjd7Ed6EhcpLZ7/LZI4v/L1MWOMoi8+n/oCiSRVx
         3diS3NcG8LLcw9skfDXCaDoOPMMwi0/qfUOJKxlg+FohQL5ysDiXZ1vxwOqch8QaTTeQ
         ypTEMFrtXJdaqQWExZVD0bcPgHWjZukX8MrJ7WIcCb51G+lF7YhCr9iDFRgTMP9wY7fD
         zJmA==
X-Forwarded-Encrypted: i=1; AJvYcCUu5Ct5CKQ9CKA74ogleC7l7/G6itusDYmG1VhzTeiy3ADqNQ6qrEF8Nouoj96bzjhZdqZaDw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxpra9WAO47dEIrg/soZOYnBZ9z2A4eFXS/upeQ9sB3XNkfRjOm
	85CP/60M1e7ZNAl70+sbEEOJrFrWwAvKNHdWhpxK2JB8gfwNWX9BHwT3waTKPpl2dLNEogErD8H
	xVT4FIUnOy1tG4xPwYFXHIWc50xgeO3337RR0sc+5dQ==
X-Gm-Gg: ATEYQzytApIr0qvWnef9f3nxg+LGuAJhILmKwhK0YSd50b3wmcm7GL83Zt/aNqkoam8
	/w7dk+C8YJhyNAG2hryEfq1Cv8OdJH2ceI4szI4HCnh9F021xBh/aA4DHmcjC9LypwQPCuzkIpo
	2o+cvtAQAlVUg2pKX2GPR6H2D2kkr6+u1bRtRjAKbfUpb7A9kD4QbeMdjY6tVr8eEs7UI228YMw
	eCELb20asLsjjsRKRUifBSAdECPDtL+tqFD6mcrDElKev83HgDOaTV2PR5laQ8RVBLBjEJFDyz6
	ToJh4SAT3Bvig5C2Q24Z1AHW+OwCdvL0l/wPOX//fQ==
X-Received: by 2002:a05:7022:4186:b0:128:cea1:7e3b with SMTP id
 a92af1059eb24-128f3dd13a3mr2716046c88.23.1773512662881; Sat, 14 Mar 2026
 11:24:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ad8652c5e9f8aeee05e2103f4987589cdd4a3fd0.1772659768.git.josef@toxicpanda.com>
 <20260312134025.GJ1469476@ziepe.ca>
In-Reply-To: <20260312134025.GJ1469476@ziepe.ca>
From: Josef Bacik <josef@toxicpanda.com>
Date: Sat, 14 Mar 2026 14:24:11 -0400
X-Gm-Features: AaiRm52ccBWuyu-tZMzjnnT5VJAWfzUfSpPntwRU0mPlzJvdhZLstFUq8yI2JNo
Message-ID: <CAEzrpqeO68eg1dFr2fm8FNXSodJWSxT_9Gk0EHSK=hzRAQgJHQ@mail.gmail.com>
Subject: Re: [PATCH] amd/iommu: do not split domain flushes when flushing the
 entire range
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: joro@8bytes.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 9:40=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Wed, Mar 04, 2026 at 04:30:03PM -0500, Josef Bacik wrote:
> > We are hitting the following soft lockup in production on v6.6 and
> > v6.12, but the bug exists in all versions
> >
> > watchdog: BUG: soft lockup - CPU#24 stuck for 31s! [tokio-runtime-w:127=
4919]
> > CPU: 24 PID: 1274919 Comm: tokio-runtime-w Not tainted 6.6.105+ #1
> > Hardware name: Google Google Compute Engine/Google Comput Engine, BIOS =
Google 10/25/2025
> > RIP: 0010:__raw_spin_unlock_irqrestore+0x21/0x30
> > Call Trace:
> >  <TASK>
> >  amd_iommu_attach_device+0x69/0x450
> >  __iommu_device_set_domain+0x7b/0x190
> >  __iommu_group_set_core_domain+0x61/0xd0
> >  iommu_detatch_group+0x27/0x40
> >  vfio_iommu_type1_detach_group+0x157/0x780 [vfio_iommu_type1]
> >  vfio_group_detach_container+0x59/0x160 [vfio]
> >  vfio_group_fops_release+0x4d/0x90 [vfio]
> >  __fput+0x95/0x2a0
> >  task_work_run+0x93/0xc0
> >  do_exit+0x321/0x950
> >  do_group_exit+0x7f/0xa0
> >  get_signal_0x77d/0x780
> >  </TASK>
> >
> > This occurs because we're a VM and we're splitting up the size
> > CMD_INV_IOMMU_ALL_PAGES_ADDRESS we get from
> > amd_iommu_domain_flush_tlb_pde() into a bunch of smaller flushes.
>
> This function doesn't exist in the upstream kernel anymore, and the
> new code doesn't generate CMD_INV_IOMMU_ALL_PAGES_ADDRESS flushes at
> all, AFAIK.

This was based on linus/master as of March 4th, and we get here via
amd_iommu_flush_tlb_all, which definitely still exists, so what
specifically are you talking about? Thanks,

Josef
