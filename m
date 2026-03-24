Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A603DB657
	for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 09:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774343563; cv=pass; b=RQdn3iwRhZUd4Vh/Pbc6ivvzRrrzqfkb/+/n1eJMA/HFXdhJGbQAKuJDEh36qsnmliIAdM0YGKep2jxRYD5xkfNuffXZy8heoP+iIML88W5JsvVZ/AcKuMAbajmrKN8q2JgIj+k+7p2IoopPX7bEo6TXRPH8VT6aHrNwQoJaTD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774343563; c=relaxed/simple;
	bh=po0GgTJdVB9QB9NPjwdcp7bWtiuP/AIBoTKiY3wESRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gPkOR7dd82N+xpRvdJ5eMbMAwfFnSCvNWcA8u8siOz7kUP4oY4Te+2o2AtkwSzk6VJvKcOW3dxun0itl55FAhk297YuaG8SXygOR01wpxOuCmqqQcwbI+HUTtAg9fUbgWcR32azkyzhrn4kLatoIxX44IxqhgogSfh6nm8Yrv8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=e349NCP1; arc=pass smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="e349NCP1"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-40f1ffba6a0so622931fac.0
        for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 02:12:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774343558; cv=none;
        d=google.com; s=arc-20240605;
        b=dCBpQ/mtVDIT31shSBKXBfIv72sLFKqAae6UWuw3vWcSHoWAYCabDrqouqGrOw4WVU
         OJC0q70p4rMxq+CnVsXXSH4rkPyZWqC858qfH4MEhW+XZC+M4MQZTfL9exGLuLvlky75
         uZLLFBolkLOgfyj8UOtIQTMPL0h0J53FMjX4g9LWU4p5BxK+Ijd15tWCSqh8QYLjoYom
         7oi9HR/YNOGWDm9q6PYcOKLBzdfoeuc8UFc/vxYTbMrQ7ZzSashykLqT42Jg39Iprxn9
         yhqhEWIrrjJyOPXaKSDc59vvCTgGoU76a449p1c0FhfQkQvKH1m3biW9k928QlZNcA1q
         p/4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=po0GgTJdVB9QB9NPjwdcp7bWtiuP/AIBoTKiY3wESRA=;
        fh=TLSQ9Nr0SumkvqcgqaQpd+XRdSqeOZyaPOWPFwRlmmI=;
        b=H4xB/aF5s973Vff8c/ctoSGJNpYOFjZAgEWiPa8B5JQ9cYcAHYl9IkgSdolf0LEieY
         jwxsxccYRzQayQZTsT1us12hwDqKtofKYYx4tETzIoIkIZB/EK8QvwGq3fxzsocDuqKn
         e1eSz5x9WxTX1Hw/OIZsF0HIg86BQc4U/Qmi3sYTij/eMAeInzYzsRUBlcsHW2t0hu4q
         o+OuK4LbdO64HNKO9Gla5wGvACOXuRRyEzIBxaDxDHf1Tzazx695ndRLjJp3deVLe9WL
         +GgAL8ZWRzfG0rp8mTUi87djAr6K24aC8m87YJIvzXCp2EQUdNdvXfxFGpNtuObrPLbb
         /wDQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1774343558; x=1774948358; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=po0GgTJdVB9QB9NPjwdcp7bWtiuP/AIBoTKiY3wESRA=;
        b=e349NCP1bTMrzA+MFsy9oQsY3jadilyuyb7ruUlpJzd+ZibwioI0Bn6jA/J2x3tUSA
         0fImMuMLz2lHyoP2dB/vXR4jFrqU9w5gGetdOb6wjdgTxUq3aSDAa153GJe0M0IMX+Kw
         9wrerj0AJPXFYHXXecVkV6QPUPTageWPKEvm74qlUzQkFDIeIStJMjeUh0Ws/S4RNgLx
         8UFI+rJ/XwXlsiiwUr66hOhhFLP8kKGCXt63O4ix7ZO5m3hJoYHCnJqI3H3ax3KIQegz
         WVwgDL/dEnJgJG3pyBqZXXdu5qnF6T027uIV61OoQhbhOgqdrVXr9Ybj7y4M5tYeq/O0
         39hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774343558; x=1774948358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=po0GgTJdVB9QB9NPjwdcp7bWtiuP/AIBoTKiY3wESRA=;
        b=ghWsMc5drp9hSYIM/MuA7aL7h3K6vSiNRSEft6BTsLJzuCYK+4FpL9JZTS8m+9gaIb
         JDMcQkRB3cbuXSZqSO0xuHqe4x9cDY3i50ov/aL8E9KC6HS8igg5Y9CHbzmXBbdCpdE9
         bBEZ7lijrEsEXwE1bYo2kXDobXmJgx97mQYTzqpabUDAb9Pfknfte1njbPQMIwW5JZ+Q
         LjxdaK3ocQEnoTatfWPsAuS60XvifrFTQaVHOxpjqAJSyOA1/zYprpln2jjO+b1TGax0
         liDZ98nN7DYPm6gVS0MyR0mhtwRVEQw3cSOknEYeRIozpVLXj8nUbq7+aHmeYrTGvkE7
         dUZg==
X-Forwarded-Encrypted: i=1; AJvYcCWeCINQZAKr3T2uNcv5a8mhJOrcXiZzWZO5l4NBMyxVC7Vm/nIMafP+WfScIo5/VzGriUqMHg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXNviFnw/1E68x7KuGGaczTKFbuLIhLcV93XumQJ9r3HSDWz0B
	p3yZgNR01l/+ZbZsyAob/27pILrC8TKsuMxatcb5U9TL4MZN0HmU3d8KdZZVb/2sPjaJpysgwcs
	LNgBPV2Bhy3561Wc7qhdTaCS1MHKv3JEQGKPdEcrm0w==
X-Gm-Gg: ATEYQzxBXJRgL7op3l4M+138uWQmenAhBD2/YobZGIS2xnsIhlYVlbcC69KnBLXKxIt
	r5asGLw622Ran082hrDLgqnj38X10VzybO+EfpitwOO76/xONZuoxDtmLnRrXQ6Yqqh+7CsVS5U
	t6/0A7Ub0FZuIQeT/8P4GvUCly+UR1+2fADbtsPCv92dIDOsGPCd2T9us2Nf+z9L8aFRGvRvNW1
	J3bAuB7ecvIQ5fgrwb8dgwJ77NlsUrEOUlsFJr1fq1YYr8c6o2Ur+EhumZCoRTYMcCfiEBS4dDP
	kNk8FSKWOg==
X-Received: by 2002:a05:6870:e8d:b0:404:1250:1c1f with SMTP id
 586e51a60fabf-41c10f8df08mr9671520fac.5.1774343557584; Tue, 24 Mar 2026
 02:12:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250920203851.2205115-28-ajones@ventanamicro.com>
 <20250922184336.GD1391379@nvidia.com> <20250922-50372a07397db3155fec49c9@orel>
 <20250922235651.GG1391379@nvidia.com> <87ecrx4guz.ffs@tglx>
 <20250923140646.GM1391379@nvidia.com> <20250923-b85e3309c54eaff1cdfddcf9@orel>
 <20250923152702.GB2608121@nvidia.com> <20250923-e459316700c55d661c060b08@orel>
 <20250923162302.GC2608121@nvidia.com> <20250923-b2caf55f4f87f05aaa619e0b@orel>
In-Reply-To: <20250923-b2caf55f4f87f05aaa619e0b@orel>
From: Vincent Chen <vincent.chen@sifive.com>
Date: Tue, 24 Mar 2026 17:12:26 +0800
X-Gm-Features: AaiRm51YfU_yNPx_PEn26PHbdMYezrFLe21xvA7oPwXPoXNN6d2xjsb4N-4LCyk
Message-ID: <CABvJ_xjnVJjV2GnYr=1WuXqo9VivNXniq8BJ39LQNwaT6vUiQQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 08/18] iommu/riscv: Use MSI table to enable IMSIC access
To: Andrew Jones <andrew.jones@oss.qualcomm.com>, Andrew Jones <ajones@ventanamicro.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>, iommu@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	zong.li@sifive.com, tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, anup@brainfault.org, atish.patra@linux.dev, 
	alex.williamson@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	alex@ghiti.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 12:34=E2=80=AFAM Andrew Jones <ajones@ventanamicro.=
com> wrote:
>
> On Tue, Sep 23, 2025 at 01:23:02PM -0300, Jason Gunthorpe wrote:
> > On Tue, Sep 23, 2025 at 10:50:56AM -0500, Andrew Jones wrote:
> > > Yes, this is the part that I'd like to lean on you for, since I under=
stand
> > > we want to avoid too much KVM/virt special casing for VFIO/IOMMUFD. I=
 was
> > > thinking that if I bit the bullet and implemented nested support than=
 when
> > > nesting was selected it would be apparent we're in virt context. Howe=
ver,
> > > I was hoping to pull together a solution that works with current QEMU=
 and
> > > VFIO too.
> >
> > You probably do have to make nested part of this, but I don't have a
> > clear picture how you'd tie all the parts together through the nested
> > API..
> >
> > Somehow you have to load a msiptp that is effectively linked to the
> > KVM reliably into the DC for the iommufd controlled devices that are
> > linked to that KVM. Then synchronize with VFIO that this is done and
> > it can setup KVM only interrupts somehow. This kvm entanglement is the
> > "virt" you have mentioned many times.
>
> Yes, the VFIO+KVM irqbypass framework currently provides much of this
> support (which patches 10-17 of this series leverage). But, if using
> nested is necessary in order to "signal" to the relevant subsystems that
> the device's irqs will truly be isolated, then I'll need to start figurin=
g
> out how iommufd can fit into the mix (or if we'll need an iommufd-specifi=
c
> implementation for a new mix).
>

Hi Andrew and Jason,

I just noticed this thread, so apologies if I missed any prior context
or if this has already been discussed.

If I understand correctly, the current discussion revolves around
using nested translation to identify a safe "Virt Context" for VFIO,
largely because the base RISC-V IOMMU/IMSIC doesn't validate MSI data,
leaving non-virt cases vulnerable to MSI spoofing.

I'd like to share an alternative idea and see if it might be a viable
direction for this scenario.

As Andrew mentioned, sharing the same IMSIC file without data
validation makes it difficult to prevent spoofing. However, what if we
consider utilizing the MRIF (Message Request Interface File) feature
for VFIO passthrough devices?

While MRIF is primarily designed to extend the number of guest IMSICs,
the specification doesn't seem to limit its usage strictly to the Virt
Context. If we assign a dedicated MRIF to a passthrough device (even
for non-virt/userspace cases), the device would only be able to send
MSIs to its own isolated MRIF via the IOMMU MSI table.

In this setup, the actual interrupt delivered to the physical CPU
would be the Notice MSI generated by the IOMMU hardware itself. Since
the address and data of this Notice MSI are strictly configured by the
Host OS, the device wouldn't be able to spoof MSIs to the Host or
other devices.

If my understanding is correct, this approach might naturally provide
the isolation needed for IRQ_DOMAIN_FLAG_ISOLATED_MSI across both virt
and non-virt contexts, potentially simplifying the need for KVM/VFIO
special casing.

I wonder if this approach would be acceptable, or if there are any
hardware/software constraints I might have overlooked?

> >
> > The direct injection interrupt path is already quite a confusing
> > thing..
>
> No argument there :-)
>
> Thanks,
> drew
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
