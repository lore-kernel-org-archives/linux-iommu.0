Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638732D9EC8
	for <iommu@lists.linux.dev>; Wed, 18 Feb 2026 20:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771445022; cv=pass; b=jGpyqblbcgCVTs9ofYVxBj6NDvJHsZgD2igCScy+bmeA4MqrRGaQGjEfAlZTucYYhcbYcmusEVZ2/msJyzdDsSU5rIFERsbxfRQHllCe1w8cMYLPa0nJdRC75e3NY+B9ZMyzTre7L+7QH8GiHigVt32bnMQEEv1ZeQepjSCsqx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771445022; c=relaxed/simple;
	bh=A9RFDZyZgqlQJkBPPEH0bt0olncW7jJuhWCZ9JoO/s8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mp75ljHIVJ52kEn7xS68wE5JuBqwirY9lm+I/3qZ1BGa/6l9tFhr3vanCf/oefOT6jFPxTZ+cjo+CpKPHPU4C+SsFqMQeuOWeaa4St3xHR3gOz4E6/sig+KGCwA3XSpr/T3nUgnGF3AHpQRFC+nQ0s6GpqoBw/p1zqujbSMeiv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=EGdBSo6O; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="EGdBSo6O"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59e64657f0cso289952e87.2
        for <iommu@lists.linux.dev>; Wed, 18 Feb 2026 12:03:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771445020; cv=none;
        d=google.com; s=arc-20240605;
        b=ZptKd0JVDqnyZQ7qHTjQtA/6+T9hu7fo/3+HjvdqB2Qy9Llzts7k5W7DfXIJbajMcW
         dmtZmmE19apipIvt0fidillV4e2uvwlIvqsrovgdJInm5yvQiHPJFCJydBiz7IOuCOme
         rAZqKGHF7CHlHVEjC26fPeJSTd/MEZR1cY0Quti9U2cb4sUTuDYvbOpjDN4O4K0SHJ/2
         Fr4w3XodEPb35U3DSD1i7a/d7G9Kb7JirKlmLVdZLsNRw9dUBsCVooiFQmbUcEQnmA5W
         jkRqVLc8Owlb3P53fjr0mi20bl1z4app09+AJiUaOKftf+2MBRc/KUUwXcgsg6fx9KlZ
         Xhkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vcy7R/11wcjfKOQI7WogUozCzX0mH6u0BCoPreJyb8U=;
        fh=YaiTPztoLRcXlTl1jtNNvVxzSnbuS5sy/unjnQd0RxY=;
        b=HJUpfWiWxlZ5innwhhyPTnTTbgffnmkZ6UWRcrB1lWjkM1GmNme0CglOYEvvumfquP
         KT+NQ3mUa9XxhDJ92ltQXbb12e5X9hWBdgdxrOz0arFc2jO23CdTr5k5PimStDhF5g0q
         /8V8RRWiSHsZg48IjWkY6Y39Pox7v+puCGq2cSYpMf8gSwyG/BF5ok17lFKrgheesm4X
         Y4zyYfXJG9gCVNM7IIXyqjtuZ8lDacfgWDBdFcnmnikMuHZpAxBKaIIi0OVWfJ2Q7EkX
         XtIMO8OSaalqnbVHXY9A/rteMGNBKhe8duIVVqhZ2jfcFTuc8+kGZ3rVVURbRKF6fapb
         nKug==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1771445020; x=1772049820; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vcy7R/11wcjfKOQI7WogUozCzX0mH6u0BCoPreJyb8U=;
        b=EGdBSo6O94sXcB4krutQRIVGa961mPnymjNsnOfhYzkiNw8ot+Q/IRfzksI29P/vr7
         p4vsgnZkyxG/z2kMR0VM89OnrjJRH//s843CzQ/r1FY26hLsfW6tfEYv4fimQlw8ScyP
         kAb21Ih4TBRn0Zca6Vupkp6F0Uim8Xox4fdtyA7jDjchNVONUOsYuwiDr8Qan9Fl/EzU
         lLb/DUfK9/UxF6p/H2knuTRjKlE/r2reKwS7AaNwljjwEB61Li+nGiMHDPlJ7+2ewyxy
         bFQq5lRjzqNb9qkXbBB34uD3+mDILVzpFX7ALfOzidYbFfgweqiGAjODqGsytVPAbDJD
         7PYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771445020; x=1772049820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vcy7R/11wcjfKOQI7WogUozCzX0mH6u0BCoPreJyb8U=;
        b=oEJuSvgnZFTPq/HiBfHZZUJHM8J3qkqNWoP/b02fJ5f4qrLVYtSlArSDZNGEUJFIxO
         iWLeKL64f/tM14k9UiabxfpeAeWxTxQIDxaKALetDqCPkyjQXO97L5o2D/4ULhkngft3
         s/MigG4NCPMTfpcaY76X9aQaR50eEOrwaaC1VPC/pcAXxS0MleeASd3Ck+/hm9E35quP
         yl5RwPXkGMPFR34a5Xmfog/QjJr3lJjzRyhaiwZXBhmZ+TJj3Vf0MXydzqmY8xioo6sS
         U3c1++VudBA31riPXjkzlRCwH0ul+rMe1Gzdoobrjw/X8mFFvW2ASBO95KzYOw7Iy6RO
         eL9A==
X-Forwarded-Encrypted: i=1; AJvYcCXLIbWeN1a4lCIU1/7GZvqq2PX/WuZ1OXTpcGip+iT0PRe67kRYUrr19QnabwM/BC2g+H5u4g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyhldreBqxSyucbsCTn9B0J5L1kPnl8qCaT7m0H9rH+WGFSvSU1
	kNJJqQpLo0Mvi22RcaUgeSikHjvDUXqTCXqip5kZmvSkpX2X1EKcJ70opW2tTbu53WiQlGDdBRo
	qzGSzDACV+0Gw4AIGFtQEpJBI1/NRWcppirWnQWT9
X-Gm-Gg: AZuq6aIfNtvvXfoOyVVjdinVh/z8EeIqPvj3Su1XIdoDVOibD5NzweFL6BEy8pxFzNq
	pVAiEnxd0AYl3sqNIbUAhzuZSH8D++oX2L+bYyRBGimRWQl8/Lby2uC/XJat10wy9CL3hAkfPSw
	xFSODahMe4T3TR1sadtiBysD7+6Q+FOn4lFudo6DBBi015T4HFSeN0bxp5HaGqAkbApxmgwqbIv
	KAvP7WN7+F11wiY6S00ZH03RXcMf3vQVyIYL/tp0Q073n5brZgv2zWwOpmuwn2tVecCbNV2ps3W
	2sb1ntHjHSWpxlc=
X-Received: by 2002:a05:6512:3992:b0:59f:6edb:b7ea with SMTP id
 2adb3069b0e04-59f6edbb86bmr4081097e87.42.1771445019417; Wed, 18 Feb 2026
 12:03:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <b5f2b5a5-b984-4ed3-a023-c06d634f9146@app.fastmail.com> <1ffd3cb5-2c76-4371-a067-3e4849907d80@apertussolutions.com>
 <49d169bf-0ad2-49be-b7d7-fceb9e7f831a@app.fastmail.com>
In-Reply-To: <49d169bf-0ad2-49be-b7d7-fceb9e7f831a@app.fastmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 18 Feb 2026 12:03:27 -0800
X-Gm-Features: AaiRm50K0AfYUHogK4D4rjv3z3w5Xga5sdt_IpbZg6dO6uXxKWdtAoPp16KXxJI
Message-ID: <CALCETrUE8c-dxRWhtHKz_PojwZuWMXJSzOsFQf2vt5LS3ATwpA@mail.gmail.com>
Subject: Re: [PATCH v15 00/28] x86: Secure Launch support for Intel TXT
To: Ard Biesheuvel <ardb@kernel.org>
Cc: "Daniel P. Smith" <dpsmith@apertussolutions.com>, 
	Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, iommu@lists.linux.dev, dave.hansen@linux.intel.com, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"H . Peter Anvin" <hpa@zytor.com>, mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, 
	peterhuewe@gmx.de, Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca, nivedita@alum.mit.edu, 
	Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net, corbet@lwn.net, 
	ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com, 
	trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 12, 2026 at 12:40=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> w=
rote:
>
> On Thu, 12 Feb 2026, at 20:49, Daniel P. Smith wrote:
> > On 2/9/26 09:04, Ard Biesheuvel wrote:
> ...
> >> Surprisingly, even when doing a secure launch, the EFI runtime service=
s still work happily, which means (AIUI) that code that was excluded from t=
he D-RTM TCB is still being executed at ring 0? Doesn't this defeat D-RTM e=
ntirely in the case some exploit is hidden in the EFI runtime code? Should =
we measure the contents of EfiRuntimeServicesCode regions too?
> >
> > Yes, in fact in the early days I specifically stated that we should
> > provide for the ability to measure the RS blocks. Particularly if you
> > are not in an environment where you can isolate the calls to RS from th=
e
> > TCB. While the RS can pose runtime corruption risks, the larger concern
> > is integrating the D-RTM validation of the Intel System Resources
> > Defense (ISRD), aka SMI isolation/SMM Supervisor, provided by the Intel
> > System Security Report (ISSR). Within the ISSR is a list of memory
> > regions which the SMM Policy Shim (SPS) restricts a SMI handler's acces=
s
> > when running. This allows a kernel to restrict what access a SMI handle=
r
> > are able to reach, thus allowing them to be removed from the TCB when
> > the appropriate guards are put in place.
> >
> > If you are interested in understanding these further, Satoshi Tanda has
> > probably the best technical explanation without Intel market speak.
> >
> > ISRD: https://tandasat.github.io/blog/2024/02/29/ISRD.html
> > ISSR: https://tandasat.github.io/blog/2024/03/18/ISSR.html
> >
>
> Thanks, I'll take a look at those.
>
> But would it be better to disable the runtime services by default when do=
ing a secure launch? PREEMPT_RT already does the same.

So I have a possible way to disable EFI runtime service without losing
the ability to write EFI vars.  We come up with a simple file format
to store deferred EFI var updates and we come up with a place to put
it so that we find it early-ish in boot the next time around.  (This
could be done via integration with systemd-boot or shim some other
boot loader or it could actually be part of the kernel.)  And then,
instead of writing variables directly, we write them to the deferred
list and then update them on reboot (before TXT launch, etc).  [0]
This would be a distincly nontrivial project and would not work for
all configurations.

As a maybe less painful option, we could disable EFI runtime services
but have a root-writable thing in sysfs that (a) turns them back on
but (b) first extends a PCR to say that they're turned back on.

(Or someone could try running runtime services at CPL3...)

[0] I have thought for years that Intel and AMD should do this on
their end, too.  Keep the sensitive part of SMI flash entirely locked
after boot and, instead of using magic SMM stuff to validate that
write attempts have the appropriate permissions and signatures, queue
them up as deferred upates and validate the signatures on the next
boot before locking flash.
