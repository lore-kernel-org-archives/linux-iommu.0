Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4202ED872
	for <iommu@lists.linux.dev>; Sun,  7 Jun 2026 21:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780869219; cv=pass; b=oUNeYBOp0twAxi6RqEeeYAurwoH782TUoYGVFF5RgPq7aIlsohzMAjz0msF2kpvFEx9P2fn8Wdda6Gnh2aEZP8rdTYdYf3xyBsLAGhw8BPXxjc7AE83M7aPNvvOE+Wj3ldQDPZLSMwh4ikrSygJP2D4Sus67yQlRQjPomS5sm8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780869219; c=relaxed/simple;
	bh=f38cbOkprW1X4UAzzesaDGCadmiew+r/u5ewjbLXAus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=okX24B7iJ0UyIyWA8CAzlt7vea/wPQPX6fFUpBYJJeuv8QTLJ/5761+Xg4JVPeFsxGtL6CymIWL7aqFQBls30bOVE5m0jjAea+mk+FvWVH0wceVizLzcsXmWS1meFN4OuE+aXih20+jzIrYvcC+BpGOXAD+WbwLfWnmrPk0DH1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ITONbVu+; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ITONbVu+"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5177d1ff061so1236501cf.1
        for <iommu@lists.linux.dev>; Sun, 07 Jun 2026 14:53:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780869217; cv=none;
        d=google.com; s=arc-20240605;
        b=Jpn39S2AYd9hfcTQA1jKkj6i55u8s+rOiBCIupdj1e4PreVjY/rlYPWIuD/1aABr2K
         PcqVv93H/r4ez2ncv6ziW7dGH4Ns5wJjdEjDRwyMFIni7EGdGQs3MvLdWC8HX4a5Qed0
         CVFOoFKTQ6lMNfB7F1J3CiaEq++z5Uss6jaQCT0hDwdv4dIEl/uprbAhE5e8bQULWGsL
         b6ygA8LkUJyxqPyVRfnvzNjsZXxqYcOlL2VTFRIF81EYMIJnKBz5az0iA9M3ohW81jm2
         MV7zjXGKdkSjF2m/Udi3S82cJ13Wp/41HJa80eTAlLEf4wFA6yj2ZNZ4IzRjeUNDOI1p
         bIhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vGjAiDQ5DI7hn7GSz64TnaLn5mVnu5JIIykSk0z4IsY=;
        fh=0u6trxL0zZwA0/1Sge/7uQQnOlSSVTu7AIo0GAZRpig=;
        b=QoRPGQ9fRSmM9kzoOLXfVvAfHz5Ge5emUeK2zd08gftB0n3UlwRW/bkPF8K33iBeaD
         F4aIu5RpqLzUkJ0e+LCyy95F/l0OfL7mNPEqz7GhN93Eu38b/UhcdMzJTKJ08hvfRT4L
         oxmjV10ORoxiv6W+owcd6gttAgJSAa6DK5BSheDVdmcqzVCYjVm8OLTR3wQosHde39bH
         RtWCPkIIqkV5U1L0URXGxR1Jk0VjJoW4dSLPpGnvQkmMUxnYAwWNBWyj3WIFP2Pbk4lx
         P9OxCFY6N7Vuevh10C1QwfeafWcQIFwEFKkDB1Nmlkrr3TTu6Z50YWPPHDc3dKPPZEFH
         jESQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780869217; x=1781474017; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGjAiDQ5DI7hn7GSz64TnaLn5mVnu5JIIykSk0z4IsY=;
        b=ITONbVu+cDC5cox5hv2efcFqUe509uCOtcVm5QCz9oH63v0yfG7uq8mEM37ZXQas6V
         pIBxpgYLb0I4G5JSVsnxmpl8uKRr9LQmR1tRNAaj4Zp+FdXpMOVDY1Frh5FqQoRCY1Jw
         95aRP/w6KbEAvpHvuSMGmnpj9pZSvL952ca/LhjSHF4AYBNGWOOHDY6OfJ/wTpX0eiJS
         SuhCDePYIfBKkb3gXzmyCHbmEKbwuol7mT3Fcd+oZ6B12HUhe57aEsCKBhkoZUjDZCAs
         O1MSyudUVc/qW9Zahl6mXlkfAfXE9/SpvpKHQ8d59wtZpt11WsztktWAccBhVBCi70A+
         LaBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780869217; x=1781474017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vGjAiDQ5DI7hn7GSz64TnaLn5mVnu5JIIykSk0z4IsY=;
        b=VY4iKY+qC1iPlK0nHXjW9/uwHAO+Reo99ZfWf+bXYQeGY8rddcHN2whAvvXWKRfdrF
         liY2loxsl1GzPC7WZe6is1PrRo3xKFe8ouiq62eSNyLHerKBU6S7JDd4n95Z4Ne/Uue2
         BV+56kdrDPNDdNtGDhhS4c9Fr3aHtx16kTTZMEABMaGQzv4qyiyIVUibe9PRAO0kkQk6
         3YePVLSYdCOc3NUMS/zXf4IbwV2DVzTy1euA5yhAkVCwd07WYUEVmev5RyFfCbUo0IfP
         qBdWiJgFSyIjxC9LdLt74wGYAsMDyY9q2v9gLF5aqG4TKQm3uWtWgExrtkwJOaMaPt04
         m8kg==
X-Gm-Message-State: AOJu0Yy/fYwZXcI4Bvq1vMA6PghyNAFZaQxGsSHgVzm3wzvTg+0QZA0L
	vrbZ8rw4Ysiq44yHjZPst1xQfkcTSM80iFkilJBqPybmPs0LgKGVAc1Ci9+Sd44ShF9JLF24qYA
	8EyCykKcyWLFA5FZSlrAiq3X2bspNrWmmqnOFPADp
X-Gm-Gg: Acq92OFpXgqG9AyFs9gl7uhwUC/PAoNSYlDogtqLnUH1qgngc0Fi+Q0/fiPJnRmlhZZ
	BsoGfsLfqegYSkmlxwcU2xiYGO8lXdcCoZB5WR+2BP4KiFVfhVxU7vgZoqxpOe8CcSZtb35vkgv
	waR+BTWbKeN7HKlkmA9BGOZ6C76j+dL4pvdfA4oC54ZT2saiDE9Cda0Z5gaQTni7gHdZpkzYaK/
	E3PQFm/v45EUROfBBoFu/x5zCqrlJbkId2bL14jzzgKbPYcNEALqry5ZZEm+SiRq0AsV2zYg25S
	oB4YFu6eMsxqDDkOjXBgov6Qsg==
X-Received: by 2002:ac8:5995:0:b0:4ff:bfd9:dd31 with SMTP id
 d75a77b69052e-5179802dae2mr21524831cf.5.1780869216488; Sun, 07 Jun 2026
 14:53:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260601215909.3958732-1-praan@google.com> <20260601215909.3958732-10-praan@google.com>
In-Reply-To: <20260601215909.3958732-10-praan@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Sun, 7 Jun 2026 14:53:24 -0700
X-Gm-Features: AVVi8CfKncyI9LHnnKvLugy3BBPqZyYdVRq04rL-R-rQhbyBNf0ZfYmtc_38gXU
Message-ID: <CAE2F3rDjFwacP0_TA8tv5_p7ZJejsXAKEb=juNaXgPcMPag+Eg@mail.gmail.com>
Subject: Re: [PATCH v8 09/12] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Ashish Mhetre <amhetre@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 2:59=E2=80=AFPM Pranjal Shrivastava <praan@google.co=
m> wrote:
> @@ -4898,6 +4939,21 @@ static int arm_smmu_device_reset(struct arm_smmu_d=
evice *smmu)
>         if (is_kdump_kernel())
>                 enables &=3D ~(CR0_EVTQEN | CR0_PRIQEN);
>
> +       /*
> +        * While the SMMU was suspended, concurrent CPU threads may have
> +        * updated in-memory structures (such as STEs, CDs, and PTEs).
> +        * Any invalidations corresponding to those updates were safely
> +        * elided because the command queue was stopped (STOP_FLAG =3D=3D=
 1).
> +        *
> +        * Since the reset invalidate-all commands above have fully clear=
ed
> +        * the HW TLBs and config caches, the SMMU will fetch these descr=
iptors
> +        * directly from RAM as soon as translation is enabled.
> +        *
> +        * Add a memory barrier to collect all prior RAM writes to ensure=
 the
> +        * SMMU sees a consistent view of memory before translation is en=
abled.
> +        */
> +       smp_mb();

I'm not convinced that this is necessary. I understand that the write
to smmu->cmdq.q.llq.atomic.prod needs to be ordered before setting
CR0_SMMUEN in ARM_SMMU_CR0. However, this ordering requirement appears
to already be met by the dma_wmb() in arm_smmu_cmdq_issue_cmdlist.
Could you provide an example of a scenario that might fail if this
smp_mb() were removed?

> +
>         /* Enable the SMMU interface */
>         enables |=3D CR0_SMMUEN;
>         ret =3D arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
