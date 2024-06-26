Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD3979E5
	for <iommu@lists.linux.dev>; Wed, 26 Jun 2024 00:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719362533; cv=none; b=aEK5nkvXHFsSt0Fe0WLJ6mvjpNCM8HFOq5bne45uzXkNXSqAMNVZyt/nzI8np/B/RwvlKt3l2W70dZTXPMrYkicpjO9+6L70rZYPzh+FjGayz0cyVT0btBdH9UGdCAh9/f+nCBsKSIF0u95JI6RMTeQU6TNo9GHXCfJL3om3SZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719362533; c=relaxed/simple;
	bh=3rsZiF+YKH21/TXG3S46bL21vyEJD44mnnURl//ORSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ghhHrfpSfeBqv7NdPar+8uAskxVeseWw5cBGxNeOkSRFQ8A8xf8vB5yfTiJMiQKs+8oBaieJYa/ZWCisXlRmzUeFgMDcwQ8Vc+RzfR4VmO+h5VYdRH2xD3Pou5nC2AD0jrDivO5NuCz5Yv0plCgb2cdo/NxVxbSFwuMNfjI08z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ySeGmDuS; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ySeGmDuS"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57d16251a07so3817a12.1
        for <iommu@lists.linux.dev>; Tue, 25 Jun 2024 17:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719362530; x=1719967330; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rsZiF+YKH21/TXG3S46bL21vyEJD44mnnURl//ORSg=;
        b=ySeGmDuSZZn75Lst5s9BpTLW8d3hJrDvjWepLN/K0+++60hWQSu96m3hGPW1GWE91k
         hCTKiE9I89A4J+9rHqCjrjRw2rg30VGCx2e6G+G+MC0c7mz45d4CjoU/haBLV2ufeJTy
         ZK98mfGibInhVaKy4gpORpYezQ6XsteMAtUtBNBYY5a97Mq4IylcKzKw4m9UDu9yFPGk
         GkDVa1BBbLOkmvAhp3f6aOb8X6ykoi6bWCAQItBP2E98b47jzE1JTXp6IRjMDz0DTDa7
         Zh9zfep6SNmIZWzEhvEgHAvSalegGZj3/EW7QohcoPqkw/l2rZINiKrS5gUnEIe5wNJC
         8Zqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719362530; x=1719967330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rsZiF+YKH21/TXG3S46bL21vyEJD44mnnURl//ORSg=;
        b=UUHTt2IdPKcQJZT37rdTDykSedD5Tq7uTBCGZKDIkt/s7cSI19qJlZBZoPnozB6d4D
         qaEQnoWp+Ms02p0kgFMYZ2hPKd6EcbrltJ5D0hf9QQ0QA89yASuirO5JxJdEdSYF7Eu0
         AaUMZqr7qBBigtqVuj0CJT298iLvu47D1QjH0PcIyiqeZ44h4F4e3adH3EfaE1lPM3DY
         MvRTwYu7Z1q3wdMISzHh3l5G9e89LqlAtxpcrXzvP0G44eF+viLKvXUquCQ0JCI1HL7M
         Lbyhp9P3ePHwcDGzyuBwglsqyNlNywPXWCX9bXnUlDtRsosw6Gog4K48w6yPmMzJDWBh
         Y0rQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXjzPaDYEJGg5rdvTWUUnEBmqnkGnuP044FeDhpi6WRBFT6ygvrrtfhtxHpFytgv6mFQaI9QJkMtv+bU+Ey6KnRYj5u5k=
X-Gm-Message-State: AOJu0YyXTF975nGT4SEwScvjkiaOsYD/EqGYOhAouBvYFMWXC99jOPPJ
	Jk2v7duJfFuKyoTOYkeVakkGINqZLj/hNL4pM+ehGtH3CoPEusHz3AIlylNeFccaTQ8U7hycVBn
	7vMp4+1XdAFlg3rQOg1ADLfzEZgmckkcHuIBP
X-Google-Smtp-Source: AGHT+IGUXAlcvcMko36NsFRWvk/yokhIRPBWv9q08BRYzOrubTf08XRl+aiyThoXu6xpKOFOPHi5N+LFI2IN9m/bLcI=
X-Received: by 2002:a05:6402:26c7:b0:57c:b712:47b5 with SMTP id
 4fb4d7f45d1cf-583311be705mr113643a12.4.1719362530203; Tue, 25 Jun 2024
 17:42:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240624232718.1154427-1-edliaw@google.com> <20240625135234.d52ef77c0d84cb19d37dc44f@linux-foundation.org>
 <f975fe76-92f4-4af0-a91d-0f3d8938f6b2@linuxfoundation.org>
In-Reply-To: <f975fe76-92f4-4af0-a91d-0f3d8938f6b2@linuxfoundation.org>
From: Edward Liaw <edliaw@google.com>
Date: Tue, 25 Jun 2024 17:41:42 -0700
Message-ID: <CAG4es9V0XAqe-eqPgjU+sdRS00VOEr0Xda1Dv-gtfEvqsODjiw@mail.gmail.com>
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

On Tue, Jun 25, 2024 at 4:34=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> On 6/25/24 14:52, Andrew Morton wrote:
> > On Mon, 24 Jun 2024 23:26:09 +0000 Edward Liaw <edliaw@google.com> wrot=
e:
> >
> >> Centralizes the definition of _GNU_SOURCE into lib.mk and addresses al=
l
> >> resulting macro redefinition warnings.
> >>
> >> These patches will need to be merged in one shot to avoid redefinition
> >> warnings.
> >
> > Yes, please do this as a single patch and resend?
>
> Since the change is limited to makefiles and one source file
> we can manage it with one patch.
>
> Please send single patch and I will apply to next and we can resolve
> conflicts if any before the merge window rolls around.

Sounds good, I sent:
https://lore.kernel.org/linux-kselftest/20240625223454.1586259-1-edliaw@goo=
gle.com

>
> thanks,
> -- Shuah
