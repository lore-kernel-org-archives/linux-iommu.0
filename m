Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA20130AD3
	for <iommu@lists.linux.dev>; Wed,  8 May 2024 20:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715200091; cv=none; b=XV/WH/zqjdRCXc3O+6HxlkPWulZUs+Lb1nDbVyQdT4DMEA5rfFGbcn1gmf35xW6dbEdQnvHty1L09F7j0WkOEuuRvoBF//BR9O8uL7k5aCcnShQTfZqnFuheCKoTeFgWY9wKhsEUARxOVm1r/bX0kdDmCt79PfnYoVSVqFbTx3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715200091; c=relaxed/simple;
	bh=o2NLQhPztuDZ4rTiTDFMEINRFzrqOs93EXYAp0RXtiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gBybwW/d/McYnv0EpgHzwB+dDWEFzhydnnrPJxZuG7w+HNR1BeuoTfTOtPcD78Hm7wDM4h7HRyyr5shseImNCr3mPGfFqeYWt1llDblvJ6aUYzKrnkRkRNehulE8k4G3J2C4SiSfQ442FVihzsFENys+X6+iifAfzh+QNIZ6RGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l9L0o634; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l9L0o634"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-572aad902baso3803a12.0
        for <iommu@lists.linux.dev>; Wed, 08 May 2024 13:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715200088; x=1715804888; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxBCT1ZV/EGWLKjxVs7FXcKu7sqjJfkKsVJ1w+mU1+0=;
        b=l9L0o634ZZ0AIbzUJOMAtGiMmmN6Ea99wGnV/61aEyL+dKmz3A0mzoAT7duU0V0YdP
         TI1ON2+6fYTx+1IrFts47FntfMVRfGAz6Z7ariIW6RXfhVsPU3qli3KjmpEzmh+DKM1c
         xfpUf5aNcoixSYM/w4D0mblvjEHVW690TJm4aBBjaA2xnkWgcjmjYd8CplfswhK5Eftm
         ZvETc6ZhBVjvJKMEiSFPB/1DluHrREBv3ff+S5rv+Ourb8uusZ+MgQCRycidu5w+SSjd
         Vs1LKE4YWVM+8OZwSe60BcIDFS25SwmcVF625dCR7g5qlJuXARE51quQKUAwTQDo1IHp
         MJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715200088; x=1715804888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxBCT1ZV/EGWLKjxVs7FXcKu7sqjJfkKsVJ1w+mU1+0=;
        b=p6q6z6K9j7gK3KGIFpY46HBLKDr2ssC10PjzM0G3dBaxwS0o+OsTy8lifDRWAC1+2R
         e/KEGHOnLDH1fdz0v2tn6rM5gVLc1QuF3GUYTw5aotRxDSEhFzXFb2B3SMp+anDXoSxD
         +62gDB6Oxu7C69Os0oRrmYV3WVm1CAZKzY7DnbA6yyeD9CtnOc/qN3SpQYdljs23eq8C
         3qhOBZsnYk8UO9sh9X/mWerfVdi2cjO/Nw1NkZVjZYBFM9dm61Vb+/uapriAQ/xd5Hcz
         rYrpouMJ3i+PFIShWVrXG/jxc3V2zLPOwFnae3ZxDPl9rdts35sUCdpyS/n/ImRZp88M
         W/tg==
X-Forwarded-Encrypted: i=1; AJvYcCW9QOeV6RaJlng6FCs3fH7OU/DnYjJaLhBD6C5jyJS8B5XafhEr2xQ6/6EDUBkM2k5kj9nRzg9Afx/FvRXxkxU33K91mkI=
X-Gm-Message-State: AOJu0YyrEXxlAjsVsk2hxNvjFznSkUPH0qksSAadR2qpoil0fyMKbSti
	6Z4AybyUnqER/qv05PyveXMfwaZdz6BhfOTrUzmBilSb6mjKarqyQTVhdA8B9yp9ZaLHkv2heeb
	W+LSuXorS0nHacplKKcIfV29D63iacHQ7jQ8H
X-Google-Smtp-Source: AGHT+IG0Nkg3RjjAAyj+n+Ew0xyy8RnKsH20og6+OrFEWYycNhxXEo9VK176FECewK/2EQxZ5XFepnMJQqWDZY6gYdE=
X-Received: by 2002:a05:6402:228b:b0:572:a33d:437f with SMTP id
 4fb4d7f45d1cf-573341614e1mr44879a12.2.1715200087751; Wed, 08 May 2024
 13:28:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240507214254.2787305-1-edliaw@google.com> <20240507214254.2787305-5-edliaw@google.com>
 <ZjuEILj0SZRuTL9I@google.com>
In-Reply-To: <ZjuEILj0SZRuTL9I@google.com>
From: Edward Liaw <edliaw@google.com>
Date: Wed, 8 May 2024 13:27:39 -0700
Message-ID: <CAG4es9VWuY4Z5HoU_SQCDaSrDC0s1knDfGvLNEa1YxhC0RZ2ZQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] selftests: Drop define _GNU_SOURCE
To: Sean Christopherson <seanjc@google.com>
Cc: shuah@kernel.org, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Christian Brauner <brauner@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <keescook@chromium.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kevin Tian <kevin.tian@intel.com>, Andy Lutomirski <luto@amacapital.net>, 
	Will Drewry <wad@chromium.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	David Hildenbrand <david@redhat.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Seth Forshee <sforshee@kernel.org>, Bongsu Jeon <bongsu.jeon@samsung.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	=?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mm@kvack.org, linux-input@vger.kernel.org, iommu@lists.linux.dev, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-actions@lists.infradead.org, mptcp@lists.linux.dev, 
	linux-rtc@vger.kernel.org, linux-sgx@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 6:54=E2=80=AFAM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Tue, May 07, 2024, Edward Liaw wrote:
> > _GNU_SOURCE is provided by KHDR_INCLUDES, so it should be dropped to
> > prevent _GNU_SOURCE redefined warnings.
>
> ...
>
> > diff --git a/tools/testing/selftests/x86/test_syscall_vdso.c b/tools/te=
sting/selftests/x86/test_syscall_vdso.c
> > index 8965c311bd65..5cd13279bba5 100644
> > --- a/tools/testing/selftests/x86/test_syscall_vdso.c
> > +++ b/tools/testing/selftests/x86/test_syscall_vdso.c
> > @@ -8,10 +8,6 @@
> >   * Can be built statically:
> >   * gcc -Os -Wall -static -m32 test_syscall_vdso.c thunks_32.S
> >   */
> > -#undef _GNU_SOURCE
> > -#define _GNU_SOURCE 1
> > -#undef __USE_GNU
> > -#define __USE_GNU 1
>
> AFAICT, manually defining __USE_GNU is frowned upon, so I'm guessing the =
__USE_GNU
> stuff is just the result of misguided copy+paste.  But it would be nice t=
o get
> confirmation that this test isn't doing something clever.  Or at the very=
 least,
> explain the removal of __USE_GNU in the changelog.

It looks like test_syscall_vdso, test_FCMOV, test_FCOMI, and
test_FISTTP don't actually use any GNU extensions.  I'll add that to
the commit message.


>
> >  #include <unistd.h>
> >  #include <stdlib.h>
> >  #include <string.h>
