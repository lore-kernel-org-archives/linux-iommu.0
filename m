Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDCD3E3C5A
	for <iommu@lists.linux.dev>; Mon,  4 May 2026 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777915457; cv=pass; b=NLg2vpomV3xWpMc0WK5xtnWpv//TXqSaq/b2dgetfkwhRySOYzEEGosSyCt6C7wZxmt/VPo97yMFNeIiyneXQXV4T3Wm4eU09BItUZXxUsNSsL1iRvFI6QyRrJHbSCtSa+VNcYicGRmFi50H4Hw/lL2sXPcsT6c7KEmMOeLr9Zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777915457; c=relaxed/simple;
	bh=GyTv8qCOVeKZc1v9heh9q2u8oTrZt8SPcXhTl05cfUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oMg6WYfSKNEprm7okvmcsjKb6IgiuvTFg/Wq3kA/oQ9v3vcqRPeZdoonXCZj580aqzp8FUvsWxRNCxxuqrhNE08PWwMeNGdiWMqnjt1LoyoZHL82SqcWmpwvb9RgthtA35a7ZMDV2awzR1SQhBcgM1h2JjS1CR480R/PVIgLedE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bvglQq4x; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bvglQq4x"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12c8cc7a77eso3596774c88.1
        for <iommu@lists.linux.dev>; Mon, 04 May 2026 10:24:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777915455; cv=none;
        d=google.com; s=arc-20240605;
        b=PNQtMSPPESDSeiQXPKxWRGfntyf0QLTzpBClHWMUMiPi8hJIUX06IK6Hx0+j3p5e0+
         mQf1zcvFwg0w0P9/L4Jg+7MkpPUDtM8OKKLgusaxvc+0sayN/u+/j5xgjUgIp0qkLPMI
         nZPeXFO5EFs+UdxpTqnNM+2MZ4L3rdF7nq/FUduG6470PJYsWSWECsaWsYfX8/F57ZQt
         bmbUIoAlKmb7Cnw29s7G+/6+VeeCHWWhEN2Cj/1fhE+v13m5nMUJhNtZ59QLYJdr+qrp
         AnudMfhAHEVfjxZg3BGYjuEo/SfnV5zMenX8KszM/Z9mLQ2Ek5QTiawZpj3BNUgCJsvu
         hQ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8DRIGBANyTxbRVKczgT9uBMklmvWRVuW0duqUNmLE+k=;
        fh=LPgMkiZUAYyiL3iHnBTuyrx2kwBVwXCsj7awObA1ePk=;
        b=BFIuXBMqyNb2cWTidjP4s+cmBPkDM2jp+orKykieLR0Xbo0BGHZu/q9fEfI9HdVT+N
         7hFXxa56klsUUH/9eNPHynBo+MgTu7YLBY+4WruSjbV6oT26O7rkD3qaU8cn6hQJaF/4
         yjF9M1dzX6no/OY1VR7mp6+t1qztu9bxbhuS7HG1ZytYwV22lCjuesNKgi1yYAsChQbV
         wwIWmLyNrfR7B0DpMrXYFz++PE2aVBsyCWC/efhCmpNp1m5dZmVTcig7bqmqk3ax7thI
         NQuBh/ppP7UW9PmsAhmMWGpSjc9KYWod6BJjZ9L+guYjcjUFoQNZznclILP6TuKF+11R
         AggA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777915455; x=1778520255; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DRIGBANyTxbRVKczgT9uBMklmvWRVuW0duqUNmLE+k=;
        b=bvglQq4x+Yrc47XA6wEfMK5H1ZDlisEnmNhAWhVtMI6pE8iBrWHYgCH1HLkGTbG44L
         +oRRwbW6oSQCfNA8BMyrCj6fOsxrrzglh2as8D+wBtAc8QC7LKMKsLj8IB1UvYmlz4DU
         zIv8dbsTrUD6crl9FtACrAd9490tQ7CwUYg/5joVTHfzGH1RPGlhlg8zTtjjtA70mE7y
         nVaQsBdAWd9JceuTnr9Db0SD5bEhtcwpxPhXsnJDFqW0POeoBrS0Z/MyBjb+1uCWcmwb
         7wvtcqjcJmz7QVkE4rVF+j5jy/Wy3MwGfdG/acCLwXB0tJkBMWBri4jCSRaOl5KG6IAx
         Amkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777915455; x=1778520255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8DRIGBANyTxbRVKczgT9uBMklmvWRVuW0duqUNmLE+k=;
        b=JhMKteKcVP4m7x72DIkqkwsw5fehz5ARleyUSFGNxFfwRegETyIRwCDCQU6ebVjcxF
         Pxj/WQLLxumB6j7AfroNTbMw66e9RhStcHpRrRh/resniJSlyW/7Morzf5Jme+2En0O7
         SJ5f9uFzHK+6jUoLesM2nCw7351R8BCWlk2QAujtSQB5dldw3dxjW8N9tewwCP0fA/Qu
         E/hX7jt0tfJBdKnakWREggqQY+tCPkADhF7mmx3PssffWiV4Ah/SRqOE/Syrmx4k55Ca
         TEPbr1gDxZubUv/Ww8sGfmekTqL+ccCCkqhioNiN03Tfr6CP3LNdvZRQnYdjOBcLHwOT
         Uimg==
X-Gm-Message-State: AOJu0YzGrZlRy2XUXvNgq6gq8vZAdfTJprgW2YKVOcD6uTOV4Fs6fThG
	Ig523u2HSPQwujBpz8bI20ELyuL8Jj8MhT+0wSEQglCsq6iQXEbnMMWS1o64Fg3GXfWdE6R/p1/
	9hYZErIhQdgZ61raO8Y9PsETfFju4eWF6SCCWMybs0jInoi4KhvjQwi/knuw=
X-Gm-Gg: AeBDietVLlPCefr270iYX8PQ2BOXtcTG+Y3YBhkOa3Lw9jyh9s3q26E9E5L5krYoS1P
	M8J22rUCclIJtvUthld0Z09LhOmrMAl2HiGeRe2+lmgEmfqk3zVj7mJMZxssuIMo3O0yyUmM2Fp
	UkxNEnBKAECZFU3ImwErsnGCwEat/+8nUAjZW3FWJEoT7g6/WBaDBXKSLl5qDPhvhXhd54vKrVx
	IVTlVBmDwQaEosIkuab9EEC1TEyU3yzwHTQ5K8Or8sVmspy3Gg3UHUuUVqAMZabiDcnzE+m+nPk
	X2AFsqyX31GF7Hqq9oaShw2JCcUc7A==
X-Received: by 2002:a05:7022:497:b0:12d:de3e:86af with SMTP id
 a92af1059eb24-130a9fec67emr177647c88.18.1777915454575; Mon, 04 May 2026
 10:24:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com> <20260423212316.3431746-8-dmatlack@google.com>
In-Reply-To: <20260423212316.3431746-8-dmatlack@google.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 4 May 2026 10:23:48 -0700
X-Gm-Features: AVHnY4KOWy2Xw7Jao5yCErgbS2iXWpg2-ZhNYfKSnvLQBaJlNVGZseag5k_UOKw
Message-ID: <CALzav=cmZzNetCqWjQaG=VO+Fs=TTL3izU01vDUFd-=mRnDAuw@mail.gmail.com>
Subject: Re: [PATCH v4 07/11] PCI: liveupdate: Inherit ACS flags in incoming
 preserved devices
To: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Will Deacon <will@kernel.org>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 2:23=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> Inherit Access Control Services (ACS) flags on all incoming preserved
> devices (endpoints and upstream bridges) during a Live Update.
>
> Inheriting ACS flags avoids changing routing rules while memory
> transactions are in flight from preserved devices. This is also strictly
> necessary to ensure that IOMMU group assignments do not change across
> a Live Update for preserved devices, as changing ACS configurations can
> split or merge IOMMU groups.
>
> Signed-off-by: David Matlack <dmatlack@google.com>

> @@ -1017,6 +1017,15 @@ void pci_enable_acs(struct pci_dev *dev)
>         bool enable_acs =3D false;
>         int pos;
>
> +       /*
> +        * ACS flags must be inherited from the previous kernel during a =
Live
> +        * Update for preserved devices (which includes endpoints and any
> +        * upstream bridges) to avoid changing routing while memory trans=
actions
> +        * are in flight.
> +        */
> +       if (pci_liveupdate_incoming(dev))
> +               return;

Sashiko caught that pci_enable_acs() is also called from
pci_restore_state() so this patch needs a fix to ensure that ACS flags
do not change or get lost after a save+reset+restore.
