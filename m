Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CC330AD13
	for <iommu@lists.linux.dev>; Wed, 18 Feb 2026 20:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771446855; cv=pass; b=iW1P7NG5TtPV880MXBJ2K3fZwixqkLrlD+9Ucgrm/4SHfveOroMD8PlMxbtu10bgle/TKt9Qp3iUzajWTIZG3dq14tQl2q9iV64jwiQNHvW//WKzS5QqKs1eNnM4WBddNfl9BYlLV9p9rnrsiZP1ViNIcu+viruZbiA82d2g6V4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771446855; c=relaxed/simple;
	bh=7C5a/FWuVnB5cGwTAOV2Br2wE+JlZH1M0yzztc2OQnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNss5VHtDkcLWQXZJVCfzpVy9IgxRehbvH1Ix/bgM0SjXPG/xOEyctdGIY/P4Q99ipfE0Bpk6IOpcb2c2DAPkC2k0GWkf6LWreMzI1nGBbqpsGCd3vec8K7CXP6C/AGvkwFq77+ItBKBhgaBnmseEtIVxfqV1E2EPGQziBHdJoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=1gxCVf4B; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="1gxCVf4B"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3870778358aso2286681fa.1
        for <iommu@lists.linux.dev>; Wed, 18 Feb 2026 12:34:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771446852; cv=none;
        d=google.com; s=arc-20240605;
        b=Y0djbpcb8v3gOtsSn6iyhRb4pqaaEZWq2Y3nnr7xvzHrozTgMrGEXPkLgKXnmiwl9P
         oSqW7Bkw/LdxBSjJfwf1PMOdoM0ThAph6htUQYaCyXvPn0wrE4I0xocILhRVGSW31MJd
         o5zlNd/vuFBA5M/EAQIarBWd6Ei8v8pF1I0WgDt8dsy8NmUh91M7zqM/oeaHnoYMvSvz
         adKgEu0/D87E9OIYmcSbqxbgJxaVTTs/gNnjsCnEMJrGYoOmwSvhNQIhVfMqoK43yfLE
         +lmxNpbZS7icYbAGbJzC/Ndpa2+fRD+R5YuN/Iy1ryXAeuyn6/r9DONMLBxtdliZwsEf
         tc2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6AtdZqt2ARoYJJMPe919rNdJ3JohEndwFbHKNaMS4Pw=;
        fh=DKDt96Up88PQ7qyrKxus+mQUcB23kpvPefNk3TeBPaE=;
        b=PP81o24/brongxqxhXhBNHh/FluqdVv53Ty0n5JkEF4oensSi/trGmcHWWBqeOEHNl
         Lebsi5YbvF7JEW15/DZA4zQRt5nKbQeN6Mi6o0sLpaxph7CZWu9h/PuvdM6H64pg7yk7
         z3kzqEWpTZuosTampqhsUMYo5D7A37pEVtBgYxDIofWVH1wLM2rlo2jHOY5Rdlq2eUYZ
         z0bdIJnwkh8JqI6N/fo+WadN32kb1ExVE+43BAKMLCPlIIvSsxPZuOaeDPMmp0GmPVS/
         XNCddahv/lY4VppuloP3enZRrPC0T/321qkUPgtz4+9Kfe9w0ClD9TWw/7Zr+mC6CtpB
         Vj/g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1771446852; x=1772051652; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6AtdZqt2ARoYJJMPe919rNdJ3JohEndwFbHKNaMS4Pw=;
        b=1gxCVf4BKkfJ1FFRLayn7IA2BVtddlETJlUf1iHfLDiWD6MEECWJLdalk+spj7dasP
         xcMTNIPyrYMwGcsJKej1VbOn/q1vN+IWUhp/lNAcsV97zicZVACx9uhetTCh4urmqt7j
         Z7zDhm2YT6w7ZA6LepkFmNK8Bf5Uf7HFpDfVihi4gt7iSyd6HU923R9fq6bjZnq8l1ui
         C/u4JRf2jGnwqJKBMnBhe8s/jYW+OB3ilOrfzK4b9Vwp168D5Gs71pIVgCQNSKjyxGa1
         dsEvOOCoEbtk4jMc7x8SIBIULIN4SDikpui6BCguKC7pXuwLMzFpYXFeZUJqzRKQHjoh
         6LgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771446852; x=1772051652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6AtdZqt2ARoYJJMPe919rNdJ3JohEndwFbHKNaMS4Pw=;
        b=jHGZ71Pj/kJPgwuTbI5tlUUdZksMDzmL/fnIGAUHePC8YKywu8XiOWjJAlyEenIMDP
         V2kCL+J2PCapWQm5TA/KBi8gUc+iYSk8txdo+cbgvLB7G5ZPcdxkFvsRkFRe+rdtTyeV
         injT+06B+VBXZnVsBUY+N1xhU74kV/Swm8hqnlMejRAJb9nN82JhMpVnA0cXX9vzoxfG
         yX+4Z57ixV1JNqwh4Fv6AwFM6M9tXuO5zUg1QSkgkovO2ccZtkD69+DBaKiqZqXIOTKq
         B/zN1ubhWJc8MuMEwGr0s4Q7ZCatYBnvjD+42HAfF8fl6lUvAi30tr0qXuMk7G/9L3DF
         vkJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7M8iherCiSrulF182ryWve2VsDTg5nU1/16w4NIaq537uOHdLifYQY7geM5+/IRMRqrxP2g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxoMIiRRnQ+cygGuCKpu3o2jyFM4Dfv6ROcqElDfI9nudV7bQkz
	lTeOXPqPYUA5oDoepwdIzbIJZO3umKWiRCZkraq5Cqba3vdkWsORx1yjxo7RB31SKj2zdah0R8B
	4L3TBCy2IBb0vhkYr8U/GbfRRaVOsz1Ljjykw2kTW
X-Gm-Gg: AZuq6aICsCR4+n+wQAElINdw1sWvgOk4EvlUVOZ83sWCyKigRTpP27ZRoXmLlF4TIDG
	sOhfcXH843ZI2c6XdEVHQfqdS1Otcra7lZ+VZiayNPoYSmRxrkCtDwOdq5nRe8DaUCOXPMQmGA8
	nHxpN3GOn44tDJ6TLRvnqb0M5raFQRO8Lm0ScJeiVaI+xSjLfRdlE7fIuSxchHvQlfCY+M6PnW9
	FLkvWXyk9XfKwRSlRph51xvR/sk1gp2e7ExZzugqjcI3cZhfDz/OWkRCunuSPPRNHCJCtLcVZ7H
	MX3h
X-Received: by 2002:a05:6512:1284:b0:59e:63b7:585e with SMTP id
 2adb3069b0e04-59f69c68122mr5099221e87.36.1771446852112; Wed, 18 Feb 2026
 12:34:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <b5f2b5a5-b984-4ed3-a023-c06d634f9146@app.fastmail.com> <1ffd3cb5-2c76-4371-a067-3e4849907d80@apertussolutions.com>
 <49d169bf-0ad2-49be-b7d7-fceb9e7f831a@app.fastmail.com> <CALCETrUE8c-dxRWhtHKz_PojwZuWMXJSzOsFQf2vt5LS3ATwpA@mail.gmail.com>
 <1BBD7449-8420-43FD-930B-A4E1BA38FFC6@zytor.com>
In-Reply-To: <1BBD7449-8420-43FD-930B-A4E1BA38FFC6@zytor.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 18 Feb 2026 12:34:00 -0800
X-Gm-Features: AaiRm52O5CUthtEuekouveR3oQDy41lsj_ZjT1TsYC4xSgI6Vkc6OZxoV-XcGok
Message-ID: <CALCETrWzG1Mjb-RcwLQ5-tGFZ15WKHjZbqtLvyif+UPuVKJ_5g@mail.gmail.com>
Subject: Re: [PATCH v15 00/28] x86: Secure Launch support for Intel TXT
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, "Daniel P. Smith" <dpsmith@apertussolutions.com>, 
	Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, iommu@lists.linux.dev, dave.hansen@linux.intel.com, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, 
	Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca, nivedita@alum.mit.edu, 
	Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net, corbet@lwn.net, 
	ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com, 
	trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2026 at 12:29=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wro=
te:
>
> On February 18, 2026 12:03:27 PM PST, Andy Lutomirski <luto@amacapital.ne=
t> wrote:
> >On Thu, Feb 12, 2026 at 12:40=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org=
> wrote:
> >>
> >> On Thu, 12 Feb 2026, at 20:49, Daniel P. Smith wrote:
> >> > On 2/9/26 09:04, Ard Biesheuvel wrote:
> >> ...
> >> >> Surprisingly, even when doing a secure launch, the EFI runtime serv=
ices still work happily, which means (AIUI) that code that was excluded fro=
m the D-RTM TCB is still being executed at ring 0? Doesn't this defeat D-RT=
M entirely in the case some exploit is hidden in the EFI runtime code? Shou=
ld we measure the contents of EfiRuntimeServicesCode regions too?
> >> >
> >> > Yes, in fact in the early days I specifically stated that we should
> >> > provide for the ability to measure the RS blocks. Particularly if yo=
u
> >> > are not in an environment where you can isolate the calls to RS from=
 the
> >> > TCB. While the RS can pose runtime corruption risks, the larger conc=
ern
> >> > is integrating the D-RTM validation of the Intel System Resources
> >> > Defense (ISRD), aka SMI isolation/SMM Supervisor, provided by the In=
tel
> >> > System Security Report (ISSR). Within the ISSR is a list of memory
> >> > regions which the SMM Policy Shim (SPS) restricts a SMI handler's ac=
cess
> >> > when running. This allows a kernel to restrict what access a SMI han=
dler
> >> > are able to reach, thus allowing them to be removed from the TCB whe=
n
> >> > the appropriate guards are put in place.
> >> >
> >> > If you are interested in understanding these further, Satoshi Tanda =
has
> >> > probably the best technical explanation without Intel market speak.
> >> >
> >> > ISRD: https://tandasat.github.io/blog/2024/02/29/ISRD.html
> >> > ISSR: https://tandasat.github.io/blog/2024/03/18/ISSR.html
> >> >
> >>
> >> Thanks, I'll take a look at those.
> >>
> >> But would it be better to disable the runtime services by default when=
 doing a secure launch? PREEMPT_RT already does the same.
> >
> >So I have a possible way to disable EFI runtime service without losing
> >the ability to write EFI vars.  We come up with a simple file format
> >to store deferred EFI var updates and we come up with a place to put
> >it so that we find it early-ish in boot the next time around.  (This
> >could be done via integration with systemd-boot or shim some other
> >boot loader or it could actually be part of the kernel.)  And then,
> >instead of writing variables directly, we write them to the deferred
> >list and then update them on reboot (before TXT launch, etc).  [0]
> >This would be a distincly nontrivial project and would not work for
> >all configurations.
> >
> >As a maybe less painful option, we could disable EFI runtime services
> >but have a root-writable thing in sysfs that (a) turns them back on
> >but (b) first extends a PCR to say that they're turned back on.
> >
> >(Or someone could try running runtime services at CPL3...)
> >
> >[0] I have thought for years that Intel and AMD should do this on
> >their end, too.  Keep the sensitive part of SMI flash entirely locked
> >after boot and, instead of using magic SMM stuff to validate that
> >write attempts have the appropriate permissions and signatures, queue
> >them up as deferred upates and validate the signatures on the next
> >boot before locking flash.
> >
>
> *If* a physical EFI partition exists there is a lot to be said for this a=
pproach.
>
> The only issue with this that I can see is for things like network or CD/=
DVD booting where there isn't necessarily any EFI boot partition, it might =
not be writable, or it might not be persistent (e.g. http booting typically=
 uses a ramdisk, like the old Linux initrd.)

Hmm, I guess my approach is a 100% complete nonstarter for installing
Linux from a CD, and it's really not awesome for installing Linux from
a USB stick.
