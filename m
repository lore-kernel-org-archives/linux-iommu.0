Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF72329E53
	for <iommu@lists.linux.dev>; Wed, 18 Feb 2026 21:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771451708; cv=pass; b=CLBnfC3OCrsXGAYUf3a+PDwJOm0CUoY+dkDeTUbMxBWAIux+bpJnoyf16uKyXWBgZXAl9o0SRswdMfi5yPwUnIMFhQKZhE6fqwwbaPxIetfW8Hc6aWndx+ZbqRfVlI7PaDV1UOYqRss+SJQWpcsMPzwvlYYG4ZXuPsvyEGjObG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771451708; c=relaxed/simple;
	bh=DtMCBbJ603M+9lFH3b7cqRU6jOZc0GNXvqZDaNm0YIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oeiWyr4nitjWiQl5Ef4+CnM8qVBfVKpzwMTIoDzkeDoEZ8AgplJd9C8BVRdS4Z7/CwWqLJGL9JVPCE7hkW/2cA0shMpOwBzVtO6XT9zBM047HPxNiUh+hm7NfWfvq/Fu0vaZGP9vlpJZIs4tgkcaqV66wyF7Azncmu5F/IYMbzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=HxhUAFbh; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="HxhUAFbh"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59e60925251so342631e87.3
        for <iommu@lists.linux.dev>; Wed, 18 Feb 2026 13:55:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771451705; cv=none;
        d=google.com; s=arc-20240605;
        b=jlubZFHmm3gLX0CpKw2hgd4g+/E6YjzRH6NmbIQiEl3CSrdhYER/03rbvYnVtlAPpS
         qta/pFO7wsARTiGWdaVa6Ooaq5HhGqiu612o4xnztd1q54Rk2s7Jia6X7IwsaPlie7CA
         F8M/5ZNIFccoLlbW7ethVZufBBmw5GfiWs8zPcQwwyzBlfbQ2wvjL5Apltz9Z70O3P3K
         NjL+1cS6gbZC/H+2fJ7+KTE/WOqg2s5sxGogYeGBcOJw872SM5TBSDHFDMJn1sYY2n31
         UxkH1kw30D9EWuVGmOqcQ81k+X/ZpgZKzCVTRs4uEpYmZ6YFc02RZJR3wSSlFj9+BQCQ
         rnqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K6id67RYm+WkjGu//HTup/gkJF0wPsfSPDN/OaX8LFM=;
        fh=IS/utHqyiX/yhqHyienyoh4C7W7xqe2SiJEJMIYqWlY=;
        b=jHgVJiUfq2mcWAXB/KqhiPblnYxJjmjjw+jPXJAZcd5y4Fs4r9cRunfKbNqSVJJxts
         4jf0C+3gShnOJpbb9ttm7pwxATMIMaOV+efvj1FvukDp60onn75BIfzBpEqpZcHDSzX5
         tzqXFE/tA/jDPvZhjitAFhlHjNZcSdFw1WQNGVsz1CVnwlJmw5iJlAWodTA9FE8nuwhE
         Py8i4UmKf3asgu60K3F9ed2bUnJU692dIB5FZeRzR6GRNJ7MF0c6jOCZI20RLOz8Ln4Y
         /MoP/OPKMouWDrB/Lc0s1dYJiO4VVu1ttiiq3EWG/XYw4cJPT+M+LFzjKmwyH3mGckX3
         8lvQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1771451705; x=1772056505; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6id67RYm+WkjGu//HTup/gkJF0wPsfSPDN/OaX8LFM=;
        b=HxhUAFbhW5q6cIuzInbXBDc644hvthO4Nt47t/u2+66poe9MqKBFhGo4AjsgWbn60B
         Er3y0T2b9Ui0+5qGPo3qXX7luoF4mQ8/90RL/6gduZn0VnCvvJlm5IorX4aAAjk2qc4w
         qJjnSTE/rQCYEiTBKn1EVMPOKHu9y50TMhOCZ/KV2yRxft84nYUY6e/g+Py5nMBtjehh
         68mR6E2tTVqWQnw6BL2lzpvkeb94EeWcFEdTWF76PLzqAybttbNMwdlQpCMXCtQxhEps
         2W1rZkBBCxlg4V4ztQXupPA60gFS6ZlTYeLKKKbBrh36G75CV1rDGAS1r8Jv2LrBwiM+
         3Mgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771451705; x=1772056505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K6id67RYm+WkjGu//HTup/gkJF0wPsfSPDN/OaX8LFM=;
        b=ssbuVGRkKvrWPNlVuC+Fk+715vWIief5ejQmmulIpHRxNRzeRrWNoNfw+wWlmgC7mg
         3nn8mM5YGCgRaIPHi5qmTCkHSjy8FHcTPwb7q24rtOH57gJHof9oWNA9tQu07ta85ngV
         qWuPp10k3xJpxsFsLfdqHyFqyuAHGNv+rhL7N0Oy2UPXZTzUUpMITxmJ1u7zdJ2OVeHr
         tSoRvQ8KK95W257ChUMbQjjdUIWzea04NcDn3EL5b9YhajsN5us3Z7BVGT2DL3w5FFnX
         iFfP/h3jTWRDe9OSWXta3knE1FjXpVU6xZXJfPWcZrpSBzd/kXIY1hX1JHA8m99VOb8W
         gFuw==
X-Forwarded-Encrypted: i=1; AJvYcCX2X32Q/4dIZXr6w7Iegp6qpzWRvlMBpf9M/Y6njnNVkn5WDzLYrEVbE2W2ApBqzXR8/ubN2Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyIdA+lXZAaXc9j+E6qyviwfekg8Vbq58/AQ3xlGJ9DpbNvDffZ
	61sQ4oaR7tlZN+20UYWNYAmwNUgUhEl8FNKxJys6SocdaLCPvC9rUP1f21JX+xIP+SfnUHapkVP
	xOh2q2p1cHKU5F26SDJTcqcHrn5JTV4s1cbmJSxZJ
X-Gm-Gg: AZuq6aIduCZPxZPdW8iMKmR5yhEO+AyX9TV4WEL11R7e2hXjLeLxP2LnEpAydeGkzqB
	TKtmK1julycc3JG99ozz48Nmjnd2D+E6ZrnjA5G7tHb7RvxbNm07iUfMUS4gZkPYgyiFJlK+oX0
	7PyZvrnEQ4pBgCTxNcMYEPOqHFqxCpVYPij5w9gGvCPzvlXb+N2nbyBzOF/qI9Gr/R4ryJfU9A1
	XQ/AcWfnAvKwlG8JI1t2sQNq7Gw1imVF9gUgGzvBJhZJo9C6Os5+xXSq3KIFE9RWfXcj1AvJDfv
	0DWp
X-Received: by 2002:a05:6512:304d:b0:59e:1880:2ef6 with SMTP id
 2adb3069b0e04-59f69c0f33dmr5396130e87.10.1771451704704; Wed, 18 Feb 2026
 13:55:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <b5f2b5a5-b984-4ed3-a023-c06d634f9146@app.fastmail.com> <1ffd3cb5-2c76-4371-a067-3e4849907d80@apertussolutions.com>
 <49d169bf-0ad2-49be-b7d7-fceb9e7f831a@app.fastmail.com> <CALCETrUE8c-dxRWhtHKz_PojwZuWMXJSzOsFQf2vt5LS3ATwpA@mail.gmail.com>
 <1BBD7449-8420-43FD-930B-A4E1BA38FFC6@zytor.com> <CALCETrWzG1Mjb-RcwLQ5-tGFZ15WKHjZbqtLvyif+UPuVKJ_5g@mail.gmail.com>
 <32e62cef7b89d9691bdd4120388ce752fd041230.camel@redhat.com>
In-Reply-To: <32e62cef7b89d9691bdd4120388ce752fd041230.camel@redhat.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 18 Feb 2026 13:54:53 -0800
X-Gm-Features: AaiRm50_oD7OC0ANa5Bzl9PQloeEGVtFI0Bz_O-wbD80wJJi63Y8TTUsLaV64pE
Message-ID: <CALCETrUMR0RvOFXGzL7=F4c-3veL+1Sm2xf-BprHTK4=UKw8yA@mail.gmail.com>
Subject: Re: [PATCH v15 00/28] x86: Secure Launch support for Intel TXT
To: Simo Sorce <simo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>, 
	"Daniel P. Smith" <dpsmith@apertussolutions.com>, Ross Philipson <ross.philipson@oracle.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, linux-integrity@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	kexec@lists.infradead.org, linux-efi@vger.kernel.org, iommu@lists.linux.dev, 
	dave.hansen@linux.intel.com, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, mjg59@srcf.ucam.org, 
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, 
	Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca, nivedita@alum.mit.edu, 
	Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net, corbet@lwn.net, 
	ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com, 
	trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2026 at 1:04=E2=80=AFPM Simo Sorce <simo@redhat.com> wrote:
>
> On Wed, 2026-02-18 at 12:34 -0800, Andy Lutomirski wrote:
> > On Wed, Feb 18, 2026 at 12:29=E2=80=AFPM H. Peter Anvin <hpa@zytor.com>=
 wrote:
> > >
> > > On February 18, 2026 12:03:27 PM PST, Andy Lutomirski <luto@amacapita=
l.net> wrote:
> > > > On Thu, Feb 12, 2026 at 12:40=E2=80=AFPM Ard Biesheuvel <ardb@kerne=
l.org> wrote:
> > > > >
> > > > > On Thu, 12 Feb 2026, at 20:49, Daniel P. Smith wrote:
> > > > > > On 2/9/26 09:04, Ard Biesheuvel wrote:
> > > > > ...
> > > > > > > Surprisingly, even when doing a secure launch, the EFI runtim=
e services still work happily, which means (AIUI) that code that was exclud=
ed from the D-RTM TCB is still being executed at ring 0? Doesn't this defea=
t D-RTM entirely in the case some exploit is hidden in the EFI runtime code=
? Should we measure the contents of EfiRuntimeServicesCode regions too?
> > > > > >
> > > > > > Yes, in fact in the early days I specifically stated that we sh=
ould
> > > > > > provide for the ability to measure the RS blocks. Particularly =
if you
> > > > > > are not in an environment where you can isolate the calls to RS=
 from the
> > > > > > TCB. While the RS can pose runtime corruption risks, the larger=
 concern
> > > > > > is integrating the D-RTM validation of the Intel System Resourc=
es
> > > > > > Defense (ISRD), aka SMI isolation/SMM Supervisor, provided by t=
he Intel
> > > > > > System Security Report (ISSR). Within the ISSR is a list of mem=
ory
> > > > > > regions which the SMM Policy Shim (SPS) restricts a SMI handler=
's access
> > > > > > when running. This allows a kernel to restrict what access a SM=
I handler
> > > > > > are able to reach, thus allowing them to be removed from the TC=
B when
> > > > > > the appropriate guards are put in place.
> > > > > >
> > > > > > If you are interested in understanding these further, Satoshi T=
anda has
> > > > > > probably the best technical explanation without Intel market sp=
eak.
> > > > > >
> > > > > > ISRD: https://tandasat.github.io/blog/2024/02/29/ISRD.html
> > > > > > ISSR: https://tandasat.github.io/blog/2024/03/18/ISSR.html
> > > > > >
> > > > >
> > > > > Thanks, I'll take a look at those.
> > > > >
> > > > > But would it be better to disable the runtime services by default=
 when doing a secure launch? PREEMPT_RT already does the same.
> > > >
> > > > So I have a possible way to disable EFI runtime service without los=
ing
> > > > the ability to write EFI vars.  We come up with a simple file forma=
t
> > > > to store deferred EFI var updates and we come up with a place to pu=
t
> > > > it so that we find it early-ish in boot the next time around.  (Thi=
s
> > > > could be done via integration with systemd-boot or shim some other
> > > > boot loader or it could actually be part of the kernel.)  And then,
> > > > instead of writing variables directly, we write them to the deferre=
d
> > > > list and then update them on reboot (before TXT launch, etc).  [0]
> > > > This would be a distincly nontrivial project and would not work for
> > > > all configurations.
> > > >
> > > > As a maybe less painful option, we could disable EFI runtime servic=
es
> > > > but have a root-writable thing in sysfs that (a) turns them back on
> > > > but (b) first extends a PCR to say that they're turned back on.
> > > >
> > > > (Or someone could try running runtime services at CPL3...)
> > > >
> > > > [0] I have thought for years that Intel and AMD should do this on
> > > > their end, too.  Keep the sensitive part of SMI flash entirely lock=
ed
> > > > after boot and, instead of using magic SMM stuff to validate that
> > > > write attempts have the appropriate permissions and signatures, que=
ue
> > > > them up as deferred upates and validate the signatures on the next
> > > > boot before locking flash.
> > > >
> > >
> > > *If* a physical EFI partition exists there is a lot to be said for th=
is approach.
> > >
> > > The only issue with this that I can see is for things like network or=
 CD/DVD booting where there isn't necessarily any EFI boot partition, it mi=
ght not be writable, or it might not be persistent (e.g. http booting typic=
ally uses a ramdisk, like the old Linux initrd.)
> >
> > Hmm, I guess my approach is a 100% complete nonstarter for installing
> > Linux from a CD, and it's really not awesome for installing Linux from
> > a USB stick.
>
> Doing any of this on a removable device feels generally like a trap.
> You get your USB disk in, try to boot, and it saves vars, but reboot
> fails for whatever reason, you plug it in another machine ... and it
> tries to "continue" from there? The amount of validation needed and
> testing for failure modes across reboots sounds really painful.

I kind of stand by my other previous suggestion, though:

As a maybe less painful option, we could disable EFI runtime services
but have a root-writable thing in sysfs that (a) turns them back on
but (b) first extends a PCR to say that they're turned back on.

--Andy
