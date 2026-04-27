Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562433ED114
	for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777316242; cv=pass; b=rdBr8FCikKse9HKiQ/opVjRhEOcQGwHgPc5n52L2Tzis7tdQNqjHHhizew6ah6u/tyhndp+9kDjLW2VhLEolNuiyvsLie4iRQhVukEUxwa06nHlmuxVxGWV4dSegW8omAodfWDBQCH1FH+31lVnP9TZ0BWaE0NirWnoAI0vbSww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777316242; c=relaxed/simple;
	bh=DDNNIqkIGd79GFDvWgXKCnKvFpN60AdJ3nOosKMNMyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oGMQZCk7Fn6i1EQO0XlHPQ8BaqPsF0gCSOltvtIGK7qaKrXLc34vejVYCtdOrfHTNNTqfr4wOqLs3UtLU0F7uRAO/NQR2yaEzPq47UN2A8g/GsCn5OiK3OPe2t/Ve8qqlAOWBemYD11fO1RgFKqFF9e7VS4nDe61LBbvVDmV+IQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sGI+yMS0; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sGI+yMS0"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38a01c80c34so103474281fa.0
        for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 11:57:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777316239; cv=none;
        d=google.com; s=arc-20240605;
        b=aR/85xi5X3I+/qH77yaqnpOODndB8Jl3sun2tBbCvmBiJ8YXKqDMooDnGDnu0Fokji
         G71nZd4ipll/EBhDrRofSYqlAgC73K9Bpltc8T/PYlepyvrOnDYvQBp+sAUxumac+I0K
         9OSDcGpB6CPLXP8Z+v03aQAo8rh3KOeaAi2a4aRadaIrpvYFb7QE4SKt8RI6Tt3OEVHI
         WABceRJ1Rz9NEGp85CnadwEu8HJU4Z2XP86v7C4XW7tgUeKn0P3lJ8ytSo0p4DQWuGpb
         GiFWWTl9Wl3osEWfr98dbQL8yXPjePn+qO3bTjcqSyVsM1xdgQhudxGohXk80e4JX+hU
         YjEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wr02yN3/yZBXI2xon5jDCKdawxJYqqpUq3piVXy5yYI=;
        fh=zE72JYYHfHvIr+K0Cow/capIv5Dymc9dqiI/QeMgCDE=;
        b=CpCCkKGB9L+PuyBxECukMvkbS4KP9+GD7bhSbM2mV2Ba5xHrx1PySXFKdxwxz5pC0p
         MI2joFS9H4E7LyTYhjNhNNDS6nOp8Re5sAvqDEUnK87xLFdwMageaBReslX5yASLjuYL
         z/lVq8Odp9FfSO5RPhj/rWpmDttipQk7EKpmdS78c49oGvHTREvozte3vdMCaiwKlD4g
         L4sBjqR89DBWvObCUjLvgMmlAY+jTUSgHva9sGMPjyVp3Sq3ky6JjpReYAJ7gH9ZR2ht
         G+OrBRa75ipZqwWOpbFs7NXCQ8YfaI2DgowrSDA5y6Lu/FrgBTjlXR535waMdLoOI+mW
         x8kg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777316239; x=1777921039; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wr02yN3/yZBXI2xon5jDCKdawxJYqqpUq3piVXy5yYI=;
        b=sGI+yMS0bClzM1UIzWX01RIMGR7RhoLuf1MJ+AbaVvNtIr/v+zgicvArOPPGdjZUjD
         ti9pTwmBYtTmtFGp4ktv+5JOE1rBXkxg1OTv+shlBWXLrj4ZTMGIqfM+uIz1R0kjPFRi
         x6MIivdQ1SbZVsv0TAQ9wRSGiIFMuQR6biXLQ8Gc/O9bXY5WaGIlBX49kMbR5s3rSXlu
         TGxgSKI/IvbJERS+hO3eBq0IRWGgaq4fJZhgfj0+3/JJ4rSa/GGT4um9ZVmTe9Cz69QJ
         JuGPEQipTrgUc4pFiw0Zgp+gnHV3tRwWCHK3SKZp7G6m1M94OS9zi1Dv0+Uz/0ILvmcf
         Ly3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777316239; x=1777921039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wr02yN3/yZBXI2xon5jDCKdawxJYqqpUq3piVXy5yYI=;
        b=T/Pd17Tzop7zLqpreOeMMCTdF3lvIhce+nWUbW6Za//631yqDh+XqQJQz0+Rf6W2aH
         G1vx0hvtlOLqjD0y4eE+wbGS9Yj5BWSQKmDWqJ3rnK3atHdD8YDe+XIpTcYg0wpgyvdj
         c4jC90BtxP7SFDT+lw4bjcc+e95B9XSTJyZiy6oJb7UCv5hA03NCzcdHhSVeh4eBLHe4
         cYBl+j791EflUOExuomFn3jjLUHhW5j8i9GVULI36sGNyg4jPm81sO021+E00cIqhacH
         4LYnBU4pJQQ8ykwy/VN5r9GbvT/iLREua0aKEMutcj17oIQjIOpVKli+6kHyl9M9sFUt
         5BvQ==
X-Gm-Message-State: AOJu0Yy1CT4JmWMxDFrOQcZPdI+Az8W7880LBw04y9C/bAKVeaFQo5tE
	lkp7YawagZsqkQ8nYwNVKh4UP5gChgOhfLaWG+HU3d6he1Ab7OiCUkE7UVUjOz347LI1OiFtkEV
	F2wAEr0PQmznUn/RgbV/V/ShXGLQ6SevF4a0rZh+U
X-Gm-Gg: AeBDiesS62HEPR9OJ7+oyfxhMiC/5WxZdi/US6/aF1LBhDCkdj5PYetZ6F3NkGWf3G8
	bDtt8ElprxESfDD5smDtajbuLU48sFYo8+nmiK5EPc5jc6IfKtIIIlB6unG24DBR98kFESdUtEi
	tYr7cfcr1dTa1dHqy8eYR9fMwhztj/3Y5I+EU3y5bmKOFgrQFHYdBfm4wfKMARIZKsk7ac9XS9a
	/Wi+BqRGrDBTYJA9dCvJvQ77HFwCzp0/vw3t5SyQnbyxhkdjK5aIp5w/AMOBwqF1NktM7bK0GDr
	S7cMOm2tQWtZ2jonTr2twkxR3Lg/VQ==
X-Received: by 2002:a05:6512:3c98:b0:5a4:b18:427e with SMTP id
 2adb3069b0e04-5a7466047eemr34628e87.1.1777316239065; Mon, 27 Apr 2026
 11:57:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com> <20260423212316.3431746-3-dmatlack@google.com>
 <20260427085725.00005283@linux.microsoft.com>
In-Reply-To: <20260427085725.00005283@linux.microsoft.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 27 Apr 2026 11:56:51 -0700
X-Gm-Features: AVHnY4IwEsFxMBzAHVS8KxW2Zq56dU7ADRcx7gdZfScIG7qn-IMwc1DMcXI8nOc
Message-ID: <CALzav=di-fMMPgTEzfWagRgXCWox9CB4XiRhZcVAzc3dUzzfHg@mail.gmail.com>
Subject: Re: [PATCH v4 02/11] PCI: liveupdate: Track outgoing preserved PCI devices
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
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

On Mon, Apr 27, 2026 at 8:57=E2=80=AFAM Jacob Pan <jacob.pan@linux.microsof=
t.com> wrote:

> > +int pci_liveupdate_preserve(struct pci_dev *dev)
> > +{
> > +     struct pci_ser *ser;
> > +     int i, ret;
> > +
> > +     guard(mutex)(&pci_flb_outgoing_lock);
> > +
> > +     ret =3D liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void
> > **)&ser);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (!ser)
> > +             return -ENOENT;
> > +
> > +     if (dev->is_virtfn)
> > +             return -EINVAL;
> This can be left outside the mutex?

Yes indeed. I will move it out in v5. Thanks!
