Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A1BD53B
	for <iommu@lists.linux.dev>; Wed, 26 Jun 2024 01:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719364921; cv=none; b=epYsVXb1oQLf8S8o/30ST9q8ojt3VXLSE12huk8G+M6BQ4yV1QaLaS4xhlaoNBXUKJpfSb9HlZtzgxeTU9zFlzZf3a9ISIgYIHB6hfDVnGJRYr1AKaGpdNJ2DJm4uahKsnyfgBO4Zi0fP2ayuX+4AEy3zvQ9JKvgkGYihc2b7N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719364921; c=relaxed/simple;
	bh=UFZ9PY+GDSA9BNrYdHIS8Xjr5b2tAoCZFEY+1AZ/7t0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IUOsjh40bklkprwFEFSy2NG6xrHQNfzmisCSY1K/eP7pltdTq9MVi7iW5qk5RkcBNWwfIFVMEDeYzDZmuTnZkjSMyL/iFxVP99uK7llQgL8cncn6uwOGpr4icT0bJ6ikYrco/bq/MEL74IC2R2TOInaFWMs/1jY4kcicN5YE1ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AE3O0toE; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AE3O0toE"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso4230a12.0
        for <iommu@lists.linux.dev>; Tue, 25 Jun 2024 18:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719364918; x=1719969718; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDXzXy/x3VAMGE4telAkJ0AkS3Dvfn3YkfUIsKfqDwQ=;
        b=AE3O0toEhG2nSf1jaNH07AX8ByLbDxAqH4A6BP1TlNHipNaHZs6I8AkzkI8t4GeCZI
         uSl+iQGSCOdV/lmw+R/FuCKPwh69Wo2Tv6dzyqXRj4CHomj+48cU2SIcww61sP2PYqfT
         RmuijaYB3Gi46gVJofo+fOyoFE8uoWlvz36Abr/T2JEXtooW1s6NkOe2s5lj5cZTH8mo
         3JV2x6BA4FqRlGRuVNsUNSlUG6jSvJ6NlAD4o1fRTRNy8FrO9eEEuUMHPMdxYcN4Jpy7
         bGcz5VsbUpQPPSzkd4iBvSPpWiEm6GWKUXgSZ4cfF7FQjFMfsHeLqqZBSG00v7Ic8MqV
         uwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719364918; x=1719969718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MDXzXy/x3VAMGE4telAkJ0AkS3Dvfn3YkfUIsKfqDwQ=;
        b=ds4kGX2j2+guJCIprnzE9AVnyB0j8oY3pR6rVgoxbl0GRbpvh/kl6WjrMOgbvzzFSa
         6JXXU9v4IREcrcqoCj4jc+rAHccstQivwfN5KE+soR24m1Vgpe50pYWDmeQmAPqoVyOo
         IMS4WnHTcL1uI9Ne4H5E5oec4F/hIJAz7VkJlwWT0MlB4ojfeE+DB2gbPMV+fJKgZgfW
         g/k0rCMQiRBTCm8suSqWsFpRYSJIjIt9F7SW8zVaeQi9FVLTq1zesYldE5qrMx0BcHue
         5sMldIIYttBt7Dd+oXmZu58rlgRW2DByflWSJ6rKzheL0uBhfv1n5BF3601CEkXo/evZ
         0bjA==
X-Forwarded-Encrypted: i=1; AJvYcCWm2s3C1QsHDgU2N/4HFNVQY5Et7P1fgwXlByIn2kTvCFyqWAwXcW28D6IvHbSf0x5mzZXPiM2w1dTx3riU4TCz9A6icBE=
X-Gm-Message-State: AOJu0YzVsBZZhefKmmHeFN74G0nd0FfoScdl5GP2cW2OqYvdI8hZYxKI
	Pam63Ogz78ryg/bYDT4bLJTIUcUSlLeIr8QkHU7q8+wB5sCA7SFIgSIf4Qw8ko7/mTFQQpisjI9
	Gh9zD9PiWELw2nFOcVeg437VufeG5W8zzBXNf
X-Google-Smtp-Source: AGHT+IHX6Dw13lvp9tA5r1Nr3EDVBrqZjzt46+AZrMqkD9VDrFcqyfsc9zQwLVqS3nH7c8fc7LBij/O5GqbVZ/GRwBU=
X-Received: by 2002:a05:6402:350c:b0:582:f117:548e with SMTP id
 4fb4d7f45d1cf-5832c353bf0mr116598a12.0.1719364915083; Tue, 25 Jun 2024
 18:21:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240624232718.1154427-1-edliaw@google.com> <20240625135234.d52ef77c0d84cb19d37dc44f@linux-foundation.org>
 <f975fe76-92f4-4af0-a91d-0f3d8938f6b2@linuxfoundation.org> <CAG4es9V0XAqe-eqPgjU+sdRS00VOEr0Xda1Dv-gtfEvqsODjiw@mail.gmail.com>
In-Reply-To: <CAG4es9V0XAqe-eqPgjU+sdRS00VOEr0Xda1Dv-gtfEvqsODjiw@mail.gmail.com>
From: Edward Liaw <edliaw@google.com>
Date: Tue, 25 Jun 2024 18:21:27 -0700
Message-ID: <CAG4es9WHUSC7qm_6fJjQm5nM_iYEjXO75DWC8e5tzqc7fLEtfw@mail.gmail.com>
Subject: Re: [PATCH v6 00/13] Centralize _GNU_SOURCE definition into lib.mk
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kselftest@vger.kernel.org, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	linux-kernel@vger.kernel.org, usama.anjum@collabora.com, seanjc@google.com, 
	kernel-team@android.com, linux-mm@kvack.org, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-sgx@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 5:41=E2=80=AFPM Edward Liaw <edliaw@google.com> wro=
te:
>
> On Tue, Jun 25, 2024 at 4:34=E2=80=AFPM Shuah Khan <skhan@linuxfoundation=
.org> wrote:
> >
> > On 6/25/24 14:52, Andrew Morton wrote:
> > > On Mon, 24 Jun 2024 23:26:09 +0000 Edward Liaw <edliaw@google.com> wr=
ote:
> > >
> > >> Centralizes the definition of _GNU_SOURCE into lib.mk and addresses =
all
> > >> resulting macro redefinition warnings.
> > >>
> > >> These patches will need to be merged in one shot to avoid redefiniti=
on
> > >> warnings.
> > >
> > > Yes, please do this as a single patch and resend?
> >
> > Since the change is limited to makefiles and one source file
> > we can manage it with one patch.
> >
> > Please send single patch and I will apply to next and we can resolve
> > conflicts if any before the merge window rolls around.
>
> Sounds good, I sent:
> https://lore.kernel.org/linux-kselftest/20240625223454.1586259-1-edliaw@g=
oogle.com

I realized that in this v6 patch, I had accidentally sent it in the
middle of a rebase, so it's missing the last change to
selftests/tmpfs.  I've fixed it in v7.

>
> >
> > thanks,
> > -- Shuah
