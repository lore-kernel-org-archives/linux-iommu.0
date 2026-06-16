Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC5B37AA64
	for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 19:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781639513; cv=none; b=nPhsOikUWhMETMIq1KKIrAPQCQ3MwMPq1d+nP/4+ukFLq1fKNqmKH5C9gWb+mLggA6G1RcCW9i6rU/rsirK8s3pBYSPNOTlSLzGSMX5NuOx5wIuBTKOLfo99psKEdmab5ZIzsP99ApW4fbYj4xSb+7fOYRBSaULDsJIF2bRqIuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781639513; c=relaxed/simple;
	bh=DnPGynuAcDBjqgYuYiqIJ/6gosF6RXzkPZWMPRbrPjE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l/DURATmPwft07S2YFcuVPYTlKQwkwFwcK2scJymoeogI3zqJpbwTV5fz9eh+kWQdtiao6Yd7Fv23Nj2iFrnMsICTYNM9xYFSvzaiCmMgJpoFSUKKjkuCMta7Q1+7QsH1CpIGuOZLKiGWCJBGDSnkX29CtS9pZ3rYM42iQl120A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJM+gS/4; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJM+gS/4"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4624a44e152so163516f8f.2
        for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 12:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781639510; x=1782244310; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oopXsR4ZloQpsMUe2KpHNKd/hTq06Y8sLkgS8GBE8k8=;
        b=NJM+gS/4oBBZS24mRc8SMyZKNgBdtEcCh24NPlR7WkWsUXwqjkATYJ/n7sP5LqnruS
         C7YpUckqV16Yv4rTSi0339c36BKBFNu0UA14W5IaN+Zn8NtzvBcLsoDzOSESH2Aat1Hb
         3acZj655SaLKzx5aFh2bsYWSk5+Fpq3HqFoBw6yFIm6zcHNRLmFZX+dUY+5iFwdO3tuZ
         Gi1UVUmSoG7mPoVY0NObxJnx7xoQ25OoxWbgObSPTk8+3SMveeexZ8TvUQuFI8QOvHFE
         5PBPhp4hJ5dha0OBk4a+nTKzR8H/jjVlVJVNkJI9RLtrfTojiknAhhTO0cWRBGYG4cSi
         S70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781639510; x=1782244310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oopXsR4ZloQpsMUe2KpHNKd/hTq06Y8sLkgS8GBE8k8=;
        b=XyzyNqrB57YxMrpWbLkmwKI11gk5Ag8b5p6W+icYOkl32Kt6BWcaz7hs6am8fPy0uM
         ic5QkUsQBXZLNLc+yQXrKMXUfNxmA7qdSDR8Giqstc0HxOgAyuhRbuvUacgG2Fk9lFm8
         ubWgcH0BKeO5apVoIXfxK+97rVsqtpX7NTS5S8s1m2EG7dUUeevnrMnIwOWsDOj9DX1e
         ypc3GJ13XOBn6KvoyiOlWAZsrPCv8kUEeLsinSc3LrKvWaelplMzOoWMQQMzvBTAjl52
         PM+LldmqL+hj+alDjA8i1qy2G9RSOcDMeMvyR2bAmuXWCKGqYqeQ6LpmZZgWNldYgYu4
         R3iQ==
X-Forwarded-Encrypted: i=1; AFNElJ+VSG2SZDV7UNB1JAjpraqRfosuBV+CaxvYXxwfNLJ41K7O76fSD6MDr6u3+UbdfvPt9jQQ+A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxqW8UqGoHwT12N4lkW0y7pGtkfSnMzMvcLBalhQhrj8dX0NAGw
	OxZpPZsu7rbIjmYduISdR0uHyECeEht5tIrGQMlzCCrtQJWhpkdEepCI
X-Gm-Gg: Acq92OHwsLOblMoZunNIrorSHwxsV/1swUeaiomZ3WXob9eYs9xkYAxFh1XUZYQgwM5
	pFF+wc74mQ3vRJp1t3RFb+T//BAJZpFhgiYgOEhlxRgjPiNXnp0SXaHLoUrFckKsMptMtXEcidS
	i4QoF3LGWNZCvedIY9xWtPcpjqaw7QeZDtuxkwZRmDaHc00mnEKEVw+vL1DCMj90zMh+RVQnD2a
	q/+NQ3x95gpnlXGdxt31pxuRBwehNgZPHV8Rs/uD93+wYmgqA/T+rvOLACENXmNbzY6tuGYJvnk
	exk3fgLBMjzskmrvGZrf5vJxFrmFwbJJ15LuO5rti9fFStSEpUoNINt4XyAZzWgpI7h78PJ/uOe
	w2/ziZQN4pa0JaMlngJ1R3AbHSP/jkhGDktHHpmmj2+iNseb0sMd7/vlQuYXMb+6PqdVNZdjZ1x
	yvxErHhEm5mJ/EEEFIIF5mQ/c7i8WtozSqRPfJqbbT0r/m6llQPDGMoEND1q+r
X-Received: by 2002:a5d:6d44:0:b0:460:3234:293f with SMTP id ffacd0b85a97d-4623983b959mr1183937f8f.42.1781639510142;
        Tue, 16 Jun 2026 12:51:50 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4619a041986sm22952948f8f.23.2026.06.16.12.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 12:51:49 -0700 (PDT)
Date: Tue, 16 Jun 2026 20:51:47 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Guo Ren <guoren@kernel.org>
Cc: zhangzhanpeng.jasper@bytedance.com, alex@ghiti.fr,
 aou@eecs.berkeley.edu, cuiyunhui@bytedance.com, iommu@lists.linux.dev,
 joro@8bytes.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, luxu.kernel@bytedance.com,
 palmer@dabbelt.com, pjw@kernel.org, robin.murphy@arm.com,
 tjeznach@rivosinc.com, will@kernel.org, yuanzhu@bytedance.com
Subject: Re: [PATCH v1] iommu/riscv: Support 32-bit register accesses
Message-ID: <20260616205147.6aa7df98@pumpkin>
In-Reply-To: <CAJF2gTTh1zyAZkKt7AQNZptG_H=-8xSum6PVTyxEmw23pN6-9g@mail.gmail.com>
References: <20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com>
	<20260615123821.373248-1-guoren@kernel.org>
	<20260616113651.1048a19a@pumpkin>
	<CAJF2gTTh1zyAZkKt7AQNZptG_H=-8xSum6PVTyxEmw23pN6-9g@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Jun 2026 23:47:05 +0800
Guo Ren <guoren@kernel.org> wrote:

> On Tue, Jun 16, 2026 at 6:36=E2=80=AFPM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Mon, 15 Jun 2026 12:38:17 +0000
> > Guo Ren <guoren@kernel.org> wrote:
> > =20
> > > Hi Zhanpeng Zhang, =20
> > .. =20
> > > 3. Only performance-monitoring counters require 64-bit IO access or t=
he
> > > high-low-high do-while retry strategy. For ordinary status and control
> > > MMIO registers, a single read is sufficient. =20
> >
> > Actually this sequence should be enough for a counter:
> >         hi =3D read_hi();
> >         lo =3D read_lo();
> >         if (hi !=3D read_hi()) {
> >                 // Pick a value that happened while doing the reads.
> >                 hi++;
> >                 lo =3D 0;
> >         } =20
> This is not a free optimization =E2=80=94 it does not preserve the same
> semantics as an atomic 64-bit read. There are at least two correctness
> issues:
>=20
> 1. Loss of precision: If hi changed during the read, setting lo =3D 0
> discards the actual lo value. The correct approach is to re-read lo
> after detecting the change, not fabricate a value.
>=20
> 2. Multiple overflows: This assumes at most one overflow occurs
> between reads. If two overflows happen (e.g., due to interrupt
> injection), hi++ will produce an incorrect result, silently corrupting
> the counter value.
>=20
> Negligible benefit: hi changing between reads is an extremely rare
> event. Optimizing away the retry loop for such a rare case provides no
> meaningful performance gain. And if hi never stabilizes, that
> indicates a hardware failure =E2=80=94 in which case hanging in the retry=
 loop
> is actually the more appropriate behavior, as it makes the failure
> visible rather than silently producing garbage values.
>=20
> The high-low-high do-while retry strategy exists precisely to handle
> these cases correctly. I don't think this proposed sequence is a valid
> replacement.
>=20

The point is that if the value is an incrementing counter (of some form)
then the value is stale by the time the reading sequence completes.
So all the code can be assumed to do is return a value the counter had
sometime between when the code started and when it finished.
If hi changes then hi+1:0 must have happened while the code was running
so it is a safe return value.

It is likely that the reads are also much slower than memory reads.
If hi changes relatively infrequently (compared to the number of reads)
it may be worth saving the previously read value and avoiding the second
read of hi if it is the same as the previous read hi and lo has got larger.

	David

