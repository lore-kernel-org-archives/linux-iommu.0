Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4851B1A7044
	for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 03:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740368586; cv=none; b=XTwSCxev97IlpSFc+1AYNR1PiltiMPSVVtr2dIkPb0+OtOFIzvJTdEvbspJranmqhAqZFnfeC1h+DwQIJkc8A8LQjLrW6lSjhlias3zyEV9gORXBFLSqIjzeuQxg0sRTc9AZ5VcEuA4Qx5gBGlzZrSnbpISt5TGscrPjTfxVIIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740368586; c=relaxed/simple;
	bh=2brXvbSRhDKTumjWNgVlgfbHMSBx/NsSwwhkUiBUAi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RMPS3j7RVCEGUTb+j6mxAo3LXgcPrUaKAx26sCZXoSSG21cw3JIo4R9HUpiHiZBVI+8y3cOBNuCa6gO8ejWH+lxPuYcsDfccO8t3tM99C5p1yABXXQlyVX58CXRcpf+ZpIGELwqbwBIam/XxfMqNM6TEntp5YVkSPX8lwVO1e+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ylbd7Onb; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ylbd7Onb"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2bc66e26179so561632fac.2
        for <iommu@lists.linux.dev>; Sun, 23 Feb 2025 19:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740368583; x=1740973383; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWmyrx22D4RyR4VCDSIk++RqfnUE4ZQz7ryWsBjsG1U=;
        b=Ylbd7OnbUaaogS/fX4Xux3dwq+Qpxd+XgsR1MebMAWuDsJPUMjxkvDWUp/zWXs0abs
         rrMiirDDDJz4hYBE5d/l+wz+R+R6UEEIZjzULwh72F52jjTeLZCbiRODk1mynYxGBkrd
         4xX2EHrSTc3j7veKYTKNHbnhQ1pkmV08GRRNQtEj7psj9Sk5X+kv37uoixQ8j3BlMh+X
         cUi3WbRIcIvCP+E/FvLUhOp/TjRjuzQR7ilhoq9O7guB8y+s8IDP6OAL6IIo0NJfsUdN
         c+2Tkkf9RumuvF9WjLA+OILp28apmZsWHpT8o0Ona7RheBZzwYlNU/+Q2iRblhSCAZVM
         rUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740368583; x=1740973383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWmyrx22D4RyR4VCDSIk++RqfnUE4ZQz7ryWsBjsG1U=;
        b=S+rD9C0oQ+hMEEI5SCgyrYKorgVhAMR5i3tsN9zx69IzillusSbQhWwkVB4RyPUGQC
         ZBzBLmJ/tl+oKz3Onc+59YrP6I1G9xUHMaXIensEpgbb9EUAEBvYweiT8Cj9YFmiYw7q
         cQBpxZ0hFW0+zlm2tJSdN6J/F/if+/a7v6OKe1zRNtdDhJRdKVh3jIVQ79z6PKOcPoZC
         N+Syfd6ohOfbnV97NemeLHAKWvwEahzKkRbMiNlRsL5H1TF701QmXyz4tPHxoz+P8PXx
         s++EKoEi4lG0i0hBVtKejFwpE/DEldGIGfBT9apKYXMB7OzZk+IyNUZTlpE+WTsWkn72
         EhXg==
X-Forwarded-Encrypted: i=1; AJvYcCUypdMLPppa8VsZUHk03znc12k19C57IHjVA22455I7EhByDlDm5df7D2z5BDSPa5dHpiJ2wQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyyZPVPgxvf010KotBKy4Mmxy4zaYYBdxalv+VvWH2OPLsYCVoX
	pcurk/7xVeGJkUtUWFjdrwYPpKxtxMc1Hx108ErVWSMJYEl5ycYibosXDT263/p75Iu65Cio29n
	qAM+E8nN7fmn08+0aHscR0s2+ubQvRT2Z0tFZTQ==
X-Gm-Gg: ASbGncuIX6lNvgmUQmrdbKp+8rch7uod/0xVftuPftlP+F+SMPLcPfVFqv15ocUnAJv
	A6l3BNEk4UmpACrfgnwCV5xCM1pDvm2Gn0ydzY4+QVyKzYiZH6pZnnV9/ebHslfEdoCUWDnDu+z
	e3Yb+vbf1SEA==
X-Google-Smtp-Source: AGHT+IGv99EkJ7MMHfoGHA1P2RRAdF3geIY8k8jLdJmdUqKUmwxzj8cPjmtTfekpYtzSV93z/z3S2U1jmWSLvf+eA2Q=
X-Received: by 2002:a05:6871:d104:b0:29e:5c94:5b10 with SMTP id
 586e51a60fabf-2bd50fa5b9cmr9369042fac.34.1740368583214; Sun, 23 Feb 2025
 19:43:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250220101511.37602-1-cuiyunhui@bytedance.com> <622aa790-6560-4be9-bfb4-736809a249bc@linux.intel.com>
In-Reply-To: <622aa790-6560-4be9-bfb4-736809a249bc@linux.intel.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 24 Feb 2025 11:42:52 +0800
X-Gm-Features: AWEUYZnZAgZWgpT1jq430siBo66BfD-b8aN1SXFV2Q6cuPz2z7re5pNq-FV4LMY
Message-ID: <CAEEQ3wm019hEGK=2i+2KF7LVcWr8y9N2uGzF65pfQLurroa+YA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] iommu/vt-d: fix system hang on reboot -f
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: dwmw2@infradead.org, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Baolu,

On Mon, Feb 24, 2025 at 9:06=E2=80=AFAM Baolu Lu <baolu.lu@linux.intel.com>=
 wrote:
>
> On 2/20/25 18:15, Yunhui Cui wrote:
> > When entering intel_iommu_shutdown, system interrupts are disabled,
> > and the reboot process might be scheduled out by down_write(). If the
> > scheduled process does not yield (e.g., while(1)), the system will hang=
.
> >
> > Signed-off-by: Yunhui Cui<cuiyunhui@bytedance.com>
> > ---
> >   drivers/iommu/intel/iommu.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index cc46098f875b..76a1d83b46bf 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -2871,7 +2871,8 @@ void intel_iommu_shutdown(void)
> >       if (no_iommu || dmar_disabled)
> >               return;
> >
> > -     down_write(&dmar_global_lock);
> > +     if (!down_write_trylock(&dmar_global_lock))
> > +             return;
>
> If system interrupts are disabled here, locking is unnecessary. Hotplug
> operations depend on interrupt events, so it's better to remove the
> lock. The shutdown helper then appears like this:

Currently, intel_iommu_shutdown() is only called by
native_machine_shutdown(). The down_write/up operations can be
removed. Even if there's a hardware access error, IOMMU_WAIT_OP() will
trigger a panic().

>
> void intel_iommu_shutdown(void)
> {
>          struct dmar_drhd_unit *drhd;
>          struct intel_iommu *iommu =3D NULL;
>
>          if (no_iommu || dmar_disabled)
>                  return;
>
>          /*
>           * System interrupts are disabled when it reaches here. Locking
>           * is unnecessary when iterating the IOMMU list.
>           */
>          list_for_each_entry(drhd, &dmar_drhd_units, list) {
>                  if (drhd->ignored)
>                          continue;
>
>                  iommu =3D drhd->iommu;
>                  /* Disable PMRs explicitly here. */
>                  iommu_disable_protect_mem_regions(iommu);
>                  iommu_disable_translation(iommu);
>          }
> }
>
> Does it work for you?
Yes.

>
> Thanks,
> baolu

Thanks,
Yunhui
