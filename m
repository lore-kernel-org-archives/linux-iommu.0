Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8212517AA
	for <iommu@lists.linux.dev>; Thu,  2 Oct 2025 14:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759416265; cv=none; b=Bxydl2C/4Ruld5T9fBQNRWxrP/bZdwdkOWmUUyAjQibc/TutkjVGwVb/TmHLBZrVSmSV3DrsCNMa+/Z9QhV//6uGUJs+CAtpMWvys5oe4FDVoq/NUGYE8DEhO3+bQaENgPSVdsE19B4DaBJjLrYHH4zX5xaPAE3MxvGRGpb/J8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759416265; c=relaxed/simple;
	bh=aFsyykfKdVfUZ6OYSkvanTpq9T0/ktCIc35j5HZJV2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ez0CZ7A3ut+u9DymptjuQuM/TxWrjnLZFpTTalrSxE4CRQDYfr3BTgJCEEBktF5wq9kKkKDUyijdQzV3KTwqIXDqDmr/h+OX9JCQJEQowAHjRG16jz2IcK33SXFlcbI/dINgnkZyBx2xRGtSZTZ16HgiGXMOINlnvhpT18rNaNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=GWiIEIYC; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="GWiIEIYC"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-86420079b01so106542185a.1
        for <iommu@lists.linux.dev>; Thu, 02 Oct 2025 07:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759416263; x=1760021063; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUdgvpTLhvmJ1bP4tagSyz2Yjbg3ABuiWON3GAUGKAI=;
        b=GWiIEIYCILaHdrLQyo/4VjsDNuyZpAszrf01ZicHlT2c4fQjWH98HQoCj7/Wv8j8D7
         eIrI40daht6woQTfYS0Tfn7yPXfSLT1ZAQlbjgXgg8vI1ESIBRv1GKZ2amEeANl8QXmo
         7H3ZaUafVwhSyL028rPkkWkPpgVwRe49g2pNZiubgMXpFKzniEX9UfI0dCtEL/fgWw4N
         FRYxUVcGqmT/HZZkZIs8r4WJw0G8RlI3yzOhMHdW8bKZRHjNO5lvWnJa59FKWZZoqAo/
         Spyl1Gypxzd7/IKAHrNESawD+y4s/YXYxMR4fRRoRSHEjonAyjcf9MXLH7w4RJlFuKay
         JDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759416263; x=1760021063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cUdgvpTLhvmJ1bP4tagSyz2Yjbg3ABuiWON3GAUGKAI=;
        b=OzFFaHfu0eCfiY6Hj/s8Y8RbokH/0T3JXflIVxsc724aqWNJdTpW9w6crCtKPh3796
         iSjS15Z/JUEGQuSxGTQImBlkyAIDd75zckYMkbKvtdyB1N6NdIMNxrteWMZm+JnrqhTA
         pQExonQkyOMWqwdFJk/WecHNCb7Z3RD/0XrOiEqsSu5zfLkifeqK7w2aN5Aj7R4L8JZa
         e85L2Ux/fnHO9HX7bt080QOnzRbCRxZ6nLoJxtgfdQoT6JFadtSOSYTJ1+xDMc+ALk0T
         TnLOslvMwRASdL1oSxiPcURG4kuh4vbJifZsPp0tX3Pvrbpz3HInDABEcHAwg/osOKUP
         JaIw==
X-Forwarded-Encrypted: i=1; AJvYcCW4GHbpSWSEeyFwrVUKUy+PG4Yg6dQxcDMQjbsDavRJ0bAa62/oHzz+1fy8nAM+k87du3exeQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1uQPGADi/f3j6gc2o3XRNMdhGGXkgkbhrYpPlIjRNtMb32bgq
	8deuCJzCb6nyD7DVi0mK8DO9zmSpD1Q2iWIwY3sa2KkfpPAUgyLN3fqDPLQkYg3+guhJtd5129/
	jqE/GwJBJRjh2iJ7yIQVmsSRbl+tES3uB3X2pNCqtIQ==
X-Gm-Gg: ASbGncuwFo1BkvDvxQXr/WTENmKqq6IxO9QccUE7RWJkzNhiSmLfWUwCVVYyWUEN8MI
	yZicAFzrzmMxjFQLu7g6BuqkjzKevhNCeZB109q2fMsyara7SycgJXnjaiW9GPofg+8EjIhGX0N
	/ZGkw8HFG8AkL8jrtTl6ggQcw/ekVcbqPvQei8+MNZBilQQmFrlQML1ghMzqkvCb+cOkSBJf6cV
	enZr+3Eb1dhTSs8PY6cHtMAAMSYy3jXQ1FIbXk=
X-Google-Smtp-Source: AGHT+IGVMGKUNvEytPBUBiSRA0mE9OlqXs6dKRKkwtnlotBZX7A4sJ1yzYAuoM2EkNHdvMa26nVXJxT3V5vw3So//6c=
X-Received: by 2002:a05:620a:1a96:b0:851:cb50:c5d0 with SMTP id
 af79cd13be357-8737021afc9mr974017485a.12.1759416262594; Thu, 02 Oct 2025
 07:44:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com> <20250928190624.3735830-14-skhawaja@google.com>
 <20250929160034.GG2695987@ziepe.ca> <CA+CK2bDqDz3k0gXamJEbKUL7RPBLVjaA5=Jum=CF84wR+50izA@mail.gmail.com>
 <20250930135916.GN2695987@ziepe.ca> <CAAywjhRGrGjZK3jQptieVWmdzvjfNtTYrp2ChTZJSmFyrBaRqw@mail.gmail.com>
 <20250930210504.GU2695987@ziepe.ca> <CAAywjhRQONuHsxTGQZ5R=EJbOHUD+xOF_CYjkNRbUyCQkORwig@mail.gmail.com>
 <20251001114742.GV2695987@ziepe.ca> <CA+CK2bAvnTTz+vPg7v38_1dajRZQHyPQ8iDmziiW8GFUqy6=Ag@mail.gmail.com>
 <20251002115712.GA3195829@ziepe.ca>
In-Reply-To: <20251002115712.GA3195829@ziepe.ca>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 2 Oct 2025 10:43:45 -0400
X-Gm-Features: AS18NWDqwdwuRxoZh_uXq08M5BHLz0U3xt0O7Y5fWskUwNH0ZUclyFnSzqq54qE
Message-ID: <CA+CK2bAudSHq2t5NZPBKDC2wfzsF6SSxTF7aZ2kxueOTzWYcfg@mail.gmail.com>
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev, YiFei Zhu <zhuyifei@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, Chris Li <chrisl@kernel.org>, 
	praan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 7:57=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Wed, Oct 01, 2025 at 03:28:56PM -0400, Pasha Tatashin wrote:
> > > > 3. On FINISH, the IOMMU core updates the context entries of preserv=
ed
> > > > devices to point to the new domain.
> > >
> > > No, finish should never do anything on the restore path, IMHO. User
> > > should directly attach the newly created HWPT when it is ready.
> >
> > But, finish is our indicator that a particular session (VM) is out of
> > blackout, and now we are free to do slow things, such as
> > re-allocating/recreating page tables. Why start it before a VM is out
> > of blackout?
>
> Things should be paired.. The suspend side is
>
>  start luo - "brown out" - kernel does basically nothing as the luo is em=
pty
>  add all sorts of things to sessions
>  finish - kernel does last minute things
>
> While the resume is the symmetric opposite:
>
>  kexec boot - kernel restores the critical stuff it needs to boot to
>                userspace
>  userspace does all sorts of stuff and gets things out of the sessions
>  finish - luo should be empty now as everything was taken out by
>           userspace

I see, so you are proposing that finish() is basically a no-op for
IOMMU as long as everything was properly reclaimed by userspace.

> I think when things come out of luo they should be fully operational
> immediately.

I agree. Once we are in "normal" mode, we should be done with all
live-update specifics. In this state, the kernel must be fully
operational without limitations or pending background work that could
reduce VM performance. Also, any session was not reclaimed before
finish(), it and all resources associated with it should be terminated
during finish.

> Finish on resume shouldn't indicate anything specific beyond the luo
> should be empty and everything should have been restored. It isn't
> like finish on pre-kexec.
>
> Userspace decides how it sequences things and what steps it takes
> before ending blackout and resuming the VM.

This is a fair statement: userspace knows when vCPUs are resumed and
can decide when to do the HWPT swap. Following that logic, what if we
provide a specific ioctl() to perform the swap? Userspace could then
call that ioctl() prior to finish(), and during the finish() callback,
we would only need to do a quick sanity check that everything is in
order (i.e., resources were retrieved and the HWPTs were swapped).

What do we do if the user reclaimed iommufd but did not swap HWPT or
did not perform some other ioctl() before finish(), simply print a
kernel warnings and let it be, or force swapping during finish before
going into normal mode?

Pasha
