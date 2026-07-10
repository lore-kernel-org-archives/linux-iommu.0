Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACBE29994B
	for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 04:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783656392; cv=pass; b=QrCWJSGzJd+tNeXHZ5V+pVDe4Tcj5z0Jg0NSEFlA1f+1P2UFiUjSoAa0zbGBhsdlFeZlZNqGOyjBTxN1BK268AQ3uoC3Pm/EcBdnNPrE/qKU8QfWxxbW+/gHwO8KLZl6KJHGM9grl22VIXS2a0EcXqVEdQXVSrQOnJCxAtn7xb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783656392; c=relaxed/simple;
	bh=/f3DO0mVTKcQxWqrUcC1tFMCSzAJMDqBKHk9ZxmESxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UF8zkBBI29jne+ixx8dY6nIYX3EnKfYPojZHfCL7aYLCn3DlZ69c7ZP8/BWWmSL6EWsANbJOUNR4ahSYt6+1Rss5iHE74cU7FKY5oMHA+CtAIfFT5LsqoLdR6SHY5gjxGz0e49WtT9ojLJvt7ZxkX2FiCsZPGgAWOiKIUNvoFDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n/VPSbNC; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n/VPSbNC"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c10e86e52so117651cf.1
        for <iommu@lists.linux.dev>; Thu, 09 Jul 2026 21:06:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783656390; cv=none;
        d=google.com; s=arc-20260327;
        b=IM56fE8W1xlrLXsngMQipK3T93bOLfm2AApTaJq8Kt2tAyK7llG/ZLKfJVX21BDdfa
         RhF2Wi9mOhpQTIDMc8mH4sD3KlLxA+ghX9067SZ7pK3IeKUzWfDgk9xlahVa5/vUp+Jw
         /+Ck0tQqD57uSXV78MnPa4zzFsXVimLZOsSFOxBEP2mlHTt2iU3Yz3senl3Tf/kcBJFP
         2jEz97fKjcm7bd+D3FC9CTyRtIzACumHwceYhAFG/yOaBTf1WLY0TgEqXkPVQUmYAD75
         99XTVCtILbQ/Nh7ke2qhGkcT4CqDWuvzjdNtHXiGGpuM/VKzUZDS+P3l6KW5sVqhATe9
         GUsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ne9mmmnso31HUDrewqJxkxCVMCk7imP2313orFRMFIk=;
        fh=Mr48kZjVS8OYJa2p495HssGw9OMWoJzKDCziAI5MQgY=;
        b=gnQoAgU/bLqpIi2R/wv5iUv1ookRlFco2onxwpsL26kFnQIv1JTv357oWhiseWU+P3
         hx3uXPMSfoiXVk8YKi3f4J/8pqIWuxDTRnDM49qR/75wKDMt/OYT1lYeu9UOq2YhpvKF
         bhOnKNMqTP9600tr35d/Hx9dfMSxHZUO8mL8TKaPD0u7pMm35h5e7SmU9lv4brxmHnrp
         DSs0RdxXZLm2g78snrynidh0+nRP/rx0eYa42rAaOvXs8q9tx4ijZX1Ps1rG+QAP2Uda
         H/mtazzap2rXcK0oBXQypfHfQedE19EJYrKJkwhDmOLLAkfj8HwuNldXGJt6BOw/ufr4
         jDAw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783656390; x=1784261190; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ne9mmmnso31HUDrewqJxkxCVMCk7imP2313orFRMFIk=;
        b=n/VPSbNCCU/XoiuMlr3NDf8B0Kf4klqRLUJYrepHqJL2WECgpImsPhp4uxpqkL7Hbr
         cv3SPeGyWUJHewlpO1MWyC2FhfAX/ZzmFUoxzkZfSqoKrX7l9Qe82710dgXf+xRCfi/X
         2ZMQmFfMens1mqFZxEW9iZL2y2FUp3ABsi8PXHFAcuPggxa/d3dZNPoNua06xXx/TpBu
         gLzdD6O2D/sWkZys8XOEZIUvEVNp79n7X0YHkorJrEGSIWIgamDBOS4P7ICJqKCB8wyz
         iJUnIgMBPzeYnsUrJpOkblpQvhD7iJKuBUH8it2bnwNlGumAFGvcF5N3stJlgKYf2O0l
         2pMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783656390; x=1784261190;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ne9mmmnso31HUDrewqJxkxCVMCk7imP2313orFRMFIk=;
        b=MGFqSp3xKi5B+fJf7L7SUCpxlP1LB9zDAponWqhIol7pkJysZoCvOlmP0REjF9E6Kl
         ewf+JOI0ql50vZ4x/vUhb7igscv1iOMXg0L0u1hGfp+zjcV8L8RwQ+bibUgSZgcJteCZ
         FzBgUPvErBx5pVi9db+iSrNaYjwtu3zE5lqb4xJ4TGZb+fv67ImMMXfwPNSCLjD+pkzl
         gFMgC1Ki6QbuhhELGb8cfp8RhHSvme0fJr4KfKEC9jg1gzFWd8qZrzWEbYbjt1W1zr6e
         vnqdUA2lHPSSbVFfNPPQ0+MHRiZKvXNiljjz6hL7EzOjDnetzoYKIynLNpOLXwtsa7nN
         6FzQ==
X-Gm-Message-State: AOJu0YyG7sBBztaynzW0LLUMWCpZibTVGXUzhwZ1uUmfR89BTdUjw5Hs
	SPLIB5Em+YrNV20elCqtRzgryZVd5t8r1znujjsAJWVlvs7nz5inuh6agVoXJ7Zeg2DQ+VB9/ab
	+shCwEt9nWiFP6NIN/UfrN9cAKb7CZjlbrFS+UM/4
X-Gm-Gg: AfdE7cny9OQRZSs/fzuvVAAG5Sb5h1dZiGYHxyFvh7GLLmoQPnU14gV+aPxWIW9mXoy
	sev64Zjt7iNrz01X0x+s2eyw7Axb7At0Y7IWngOXiw+6gwAP6gRxeEZrG9+oN1/LFzJtOmSfiIW
	rME7KhAoeTUucsRcmhs6N6BAyrHQjq5CFhBqFPy3pZs+8hTbBVPnnYkspNqvNgWqXZ+NF7iymwr
	YwyUuqx5xchjSKaV8CYD23YEY8VF9PEQEkuHkP/KM8nJLjwuXBONpUmIttOz+Kax4Y9RrSOlEdY
	HIgq
X-Received: by 2002:a05:622a:1e91:b0:516:ccc0:ee38 with SMTP id
 d75a77b69052e-51cac51dacemr3969541cf.9.1783656389860; Thu, 09 Jul 2026
 21:06:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v2-43074a57a53a+fb95-smmu_tlbi_jgg@nvidia.com> <2-v2-43074a57a53a+fb95-smmu_tlbi_jgg@nvidia.com>
In-Reply-To: <2-v2-43074a57a53a+fb95-smmu_tlbi_jgg@nvidia.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Thu, 9 Jul 2026 21:06:18 -0700
X-Gm-Features: AUfX_myK7XQF1CZJv4vRx8UhENoIWryYI2BA_R5s-T_CavtrIu_usQmLmDIBaUg
Message-ID: <CAE2F3rCh8U-gULjvS_8xsVo7YWN0=K2d8DC0eHwDOfgwB7bvCA@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] iommu/arm-smmu-v3: Move pgsize out of arm_smmu_inv
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Jean-Philippe Brucker <jpb@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, 
	David Matlack <dmatlack@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 9:29=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> pgsize is a constant property of the domain, it is the base translation
> granule of the page table (4k, 16k, 64k) in log2.

> +       u8                              tgsz_lg2;

In struct pt_iommu_armv8_cfg, this is called granule_lg2sz. Should we
align on a common name?
