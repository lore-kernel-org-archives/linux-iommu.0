Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE3E1494D2
	for <iommu@lists.linux.dev>; Thu,  9 May 2024 06:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715235263; cv=none; b=VJXgu7Hy/ptm3uLHhOHHKMMj//7bfLpw3rN2ywoEB8F81iySIXFCwb0gcUncux3I1MKtDmjweEmo99+q+79HukDIjTfDSng/+87jZNjTdgRRKjBD8DZWeL+Y+JpMNcqx3ZwQHLxTeNq0qD3bikKCJiDRj7yqZIqKFUrdUCzJ9jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715235263; c=relaxed/simple;
	bh=EL59YAvQ+NejbE+MgsQ0pGcYE6qA6HsEuHDusaEk0N4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g80+BH94R5mKdOLBVH5hhHhMrWybYyKKti6DonXp06A3y+9/2pvraPmxyuADvmsOX2FKmmso2WF9T7+o6qntwzMxTpNf/8BXJJs39YHu2q+FiLfIQiYJLegkpX+1LMnD9uNLYcBTEtsjgEanFxsQ6veIc+0xSxjJEDKx14tT290=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zitMz4/y; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zitMz4/y"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso4826a12.1
        for <iommu@lists.linux.dev>; Wed, 08 May 2024 23:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715235259; x=1715840059; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72bWBwjQodIuSi8MsUtQvKNvKwdUWjXGREUei480Xwo=;
        b=zitMz4/y3MOj4Im473TNWv5wurvZHk2NQyfPQBloFm6mP0Q/sFm7wrqZaPYdtzqT1t
         3HUSpajy1SuC0DeXKK2y6kfM/H1lN6X53jw5tayJvWzkEsCib/4KPR/LTjE8QufT85jv
         j2/ukR+GZvAwjCM/Ced7r/PerdGSPyLoHkcQaJ0Y3aoe39Cq6NSCaclQ01eJvWp67gbZ
         d5fTDaAxde60SXxvRnwRcFqI3BfhWC4YOoPcJ1f9+HgX+VvqNo6FmoPJ8VlDjgpOoCL+
         Qs5il8NcCZOCZszG2yxKKYzsMMmkePiCfGSK1pijlZ6I3htO3zis3tVKpiXNMjnnfg5K
         /DWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715235259; x=1715840059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=72bWBwjQodIuSi8MsUtQvKNvKwdUWjXGREUei480Xwo=;
        b=ijCPhVVoBlBowfwcb/zqca95S28M1N5CY5kro3uhk/9sy92BEdwBhFP99t0rkMxEfb
         8ntR1UmfoDiyvbYmWP31GdbBjPhjSsRk9PvMrOVn7oGk1Tf0CVo8EvF2invPVQ2Z6fUH
         iS+CX4lAp/BFZ7nHWFN/o4S8A8RT15Imxp6jBnBP2ocjBjydeZI+ZuBsn0XVl2Krn8k/
         PfaE5VAL9ABslkj9Byrs6F7RwJ7TqLz1pUAcF+v5y6qdz7Rf2GjaemB0BEQuU+v3b1s5
         aEZ1HTKJRQ2HGWpttHNl89dooEe2dA8OwgRZlgs0q+eEtRpjsXxKpElc3Rp0WVaPmcMK
         vQ7A==
X-Forwarded-Encrypted: i=1; AJvYcCX9Pv8+TxYhWo0aISiX8n0bEuZmqznWk0U34A2dAu0K1qJYfwlh/PISN+AC3NGQzpDn2VEC30D5Zd14ty5cC4vjTD8KEk4=
X-Gm-Message-State: AOJu0YztBJnueVBZuAzKJSLmWoUJRQDSZzrjofn3YnpkdzPU2+AZ9GG5
	RUE/Kz7EmCsHAy+JKgHd5p9qwkM4o3xC7mngQaO0JL0mlBU/MbwFwGOM2AK/SMcec62E91UcXf+
	dQCnJIuC31PfYFIQn3UhC0EhZEPPvEiDm3O2F
X-Google-Smtp-Source: AGHT+IHsPAG0LEeM4cJXnAxgH06RrdZlxemOxK5bdPXtb66jyshH3jVsPNC7i5pX8kAB1x6smMgaq3eKTmHMEonCtFw=
X-Received: by 2002:a05:6402:5206:b0:572:a23b:1d81 with SMTP id
 4fb4d7f45d1cf-5733b9d3b3emr79412a12.5.1715235258767; Wed, 08 May 2024
 23:14:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240507214254.2787305-1-edliaw@google.com> <f4e45604-86b0-4be6-9bea-36edf301df33@linuxfoundation.org>
In-Reply-To: <f4e45604-86b0-4be6-9bea-36edf301df33@linuxfoundation.org>
From: Edward Liaw <edliaw@google.com>
Date: Wed, 8 May 2024 23:13:51 -0700
Message-ID: <CAG4es9XE2D94BNboRSf607NbJVW7OW4xkVq4jZ8pDZ_AZsb3nQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Define _GNU_SOURCE for sources using
To: Shuah Khan <skhan@linuxfoundation.org>
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
	Sean Christopherson <seanjc@google.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@redhat.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
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

On Wed, May 8, 2024 at 4:10=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.or=
g> wrote:
>
> On 5/7/24 15:38, Edward Liaw wrote:
> > 809216233555 ("selftests/harness: remove use of LINE_MAX") introduced
> > asprintf into kselftest_harness.h, which is a GNU extension and needs
> > _GNU_SOURCE to either be defined prior to including headers or with the
> > -D_GNU_SOURCE flag passed to the compiler.
> >
> > v1: https://lore.kernel.org/linux-kselftest/20240430235057.1351993-1-ed=
liaw@google.com/
> > v2: add -D_GNU_SOURCE to KHDR_INCLUDES so that it is in a single
> > location.  Remove #define _GNU_SOURCE from source code to resolve
> > redefinition warnings.
> >
> > Edward Liaw (5):
> >    selftests: Compile kselftest headers with -D_GNU_SOURCE
> >    selftests/sgx: Include KHDR_INCLUDES in Makefile
>
> I appled patches 1/5 and 2.5 - The rest need to be split up.
>
> >    selftests: Include KHDR_INCLUDES in Makefile
> >    selftests: Drop define _GNU_SOURCE
> >    selftests: Drop duplicate -D_GNU_SOURCE
> >
>
> Please split these patches pwe test directory. Otherwise it will
> cause merge conflicts which can be hard to resolve.

Hi Shuah,
Sean asked that I rebase the patches on linux-next, and I will need to
remove additional _GNU_SOURCE defines.  Should I send an unsplit v3 to
be reviewed, then split it afterwards?  I'm concerned that it will be
difficult to review with ~70 patches once split.
