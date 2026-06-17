Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE0A388E45
	for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 21:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781733262; cv=none; b=mxqNrWcrj3bOM4OzxKEJUrniD+kXje07zqSTrcFsz0GZnoVl+Mg07IgsAtdd9EOgcUJ1wGBdaSJ+UbB8BAB79OkSpc8NTeVLUxUAGtnm1g/uAyJOlyBt9Y4y9NDg53n9jOZXno9rCTWdMI8ME2e73DOYtY+g4u6fk5ZVLNjKotg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781733262; c=relaxed/simple;
	bh=nvcPmDvsElnPmEhJYZPmpO3fuH22AcsVcx2tYSSlU6s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JCehEUz/QWD+kV2gZ3eo+AX90e6TqqhDh77YZykc4EH2OhC4h4lvWmua5klb2e9VsTLv/tt8nXv7q0uNIUq6wv7+GH8OMVqD3RbjdeAWXVWdJLQHK6J6ewzeqt1I0S1oURw3VhN0OChSXVBnR+kBtRPUgvfxs6tN55g6qv1FB5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdvEocKN; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdvEocKN"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490aebf33e9so810755e9.3
        for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 14:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781733259; x=1782338059; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRo7rRtyFnw8rThFCSxCEWpqAPzGeBGOtHfIm/LouJ4=;
        b=FdvEocKNih74z/C+QXwCM8Ayk2aSAu6G38CgNYdWXQC3xlTtECsEI7yTsQrSjVseph
         qwa2HT8KTEwGYcGQA08IbVIyJOGU5KpmEibyeJJz8Wh+sCkmhHl9xLmeNsql1Vb6IJaV
         uX76xDZnho2LkaASiTWR4CvYUD3x01oF1gTBriHzPNqyTiG/LDn8EIj6JBpC/8T2QKXs
         Qq7wvaVZiwAn/pnvYJVxlGFJddNPf0QVfNSI6OAiMWL+4xPc3Y+4/ik9nC/yo0qXLfV5
         NMYlr8mvwbHkN8esYV6hxYEml5H7HUwfJ2Dlr3pzn4PD2ezukowRFzXfaRYBSdz7BXp8
         yCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781733259; x=1782338059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qRo7rRtyFnw8rThFCSxCEWpqAPzGeBGOtHfIm/LouJ4=;
        b=KLadXXda5tePmkcGPquDjAPi7QryyL120s3RC7XWhWdfiToD+lXf9fD7aKcj1eR+30
         mUejH4AMvpgvTHc361KNnnByPtlxkSkAql6kaFE6FeKUf84208HA55b1rWY6BHUL0dY2
         eJ6+/52cCUZmYYVfZXvi7WplZHHYbYZVIMCkSlwfDrunRZMPThXfdNfQsYGndetCege5
         823XsvEln1gS3OPUvSsmGaUWIuvFb6vRloeqZHOheGRDF4spW+iZ1FpyICZmLUcT7rdw
         iC3Y1ZsL8+BPFUjWsOzTtsTFF5t/Qsril8B+kvDphOJ3HNr7ucFV0H066MxTsZhtuQ1s
         Hr9g==
X-Forwarded-Encrypted: i=1; AFNElJ9IG5jL8xy0gl+SCDuIqrf6lFbOCFA+E4mv+CP5+DVt0SYizbbhxCeipEt5ifPW6LX5x4zocQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwWvnJKxmLHgokY+eUzL1ng4DBUXLWWRembKUrEvhLzUobQNn9P
	8glOdS8awqEQ8/It3RcQTEjbSN4lUBrJzHDHFk8t6TjZwIZU6wR22IdU
X-Gm-Gg: Acq92OHUj2z8e/b60Ht4uKisE9sMZkYCskH5Ri4pCoyBvaMkMAQ80K1VX1YKF+o0UC+
	UtNTQOzbAYTDcnL6Zs+93NMotFv3GLfhYc9kATkieUVSUW80NArGW85IMfji2sWoQuYAxkp2d/E
	brtjdvrg+E4E9pPY9qsOKrAtJkhq1H4cLdQ6xzIx+pyl0AT64gXMwInhDOIxjq7fB9P7lU4O+Yy
	LknwKOeKbISMWcl8XoPJvph+QMiK4/UExodZoq4CqHMuoODJNFo7iunyHzWvDHvRIieoVdK8fi/
	1QRxr6sPPUFObwhwjUaZpkScNN0dhHO/jqnoJwPdanyDaPPwgfBgq37ePLRoDWn4nO4ZeOGWDA4
	K8HxOo25WBaHvJKeJD6xxMDMLVvGXR28m+IAkw2gTVU/hfRoQiqSWBmhlAkJNrOQO2K/bf5DivY
	N0t4PAp6ypk4rxlFg0wOiG02VdJpUnlF+e4zjizP0/cyu1rQgp/a9vF5Lpdy8j
X-Received: by 2002:a05:600c:848e:b0:490:b3e7:4614 with SMTP id 5b1f17b1804b1-4923342785fmr92261345e9.25.1781733259101;
        Wed, 17 Jun 2026 14:54:19 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a4f8d7sm188031235e9.5.2026.06.17.14.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 14:54:18 -0700 (PDT)
Date: Wed, 17 Jun 2026 22:54:16 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Guo Ren <guoren@kernel.org>
Cc: zhangzhanpeng.jasper@bytedance.com, alex@ghiti.fr,
 aou@eecs.berkeley.edu, cuiyunhui@bytedance.com, iommu@lists.linux.dev,
 joro@8bytes.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, luxu.kernel@bytedance.com,
 palmer@dabbelt.com, pjw@kernel.org, robin.murphy@arm.com,
 tjeznach@rivosinc.com, will@kernel.org, yuanzhu@bytedance.com
Subject: Re: [PATCH v1] iommu/riscv: Support 32-bit register accesses
Message-ID: <20260617225416.0c5a79b0@pumpkin>
In-Reply-To: <CAJF2gTTCLKCnTcY=K9hsepRgKwDRXqg5eqJBPxBPqTp98zqFKw@mail.gmail.com>
References: <20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com>
	<20260615123821.373248-1-guoren@kernel.org>
	<20260616113651.1048a19a@pumpkin>
	<CAJF2gTTh1zyAZkKt7AQNZptG_H=-8xSum6PVTyxEmw23pN6-9g@mail.gmail.com>
	<20260616205147.6aa7df98@pumpkin>
	<CAJF2gTTCLKCnTcY=K9hsepRgKwDRXqg5eqJBPxBPqTp98zqFKw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Jun 2026 00:24:12 +0800
Guo Ren <guoren@kernel.org> wrote:

> On Wed, Jun 17, 2026 at 3:51=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Tue, 16 Jun 2026 23:47:05 +0800
> > Guo Ren <guoren@kernel.org> wrote:
> > =20
> > > On Tue, Jun 16, 2026 at 6:36=E2=80=AFPM David Laight
> > > <david.laight.linux@gmail.com> wrote: =20
> > > >
> > > > On Mon, 15 Jun 2026 12:38:17 +0000
> > > > Guo Ren <guoren@kernel.org> wrote:
> > > > =20
> > > > > Hi Zhanpeng Zhang, =20
> > > > .. =20
> > > > > 3. Only performance-monitoring counters require 64-bit IO access =
or the
> > > > > high-low-high do-while retry strategy. For ordinary status and co=
ntrol
> > > > > MMIO registers, a single read is sufficient. =20
> > > >
> > > > Actually this sequence should be enough for a counter:
> > > >         hi =3D read_hi();
> > > >         lo =3D read_lo();
> > > >         if (hi !=3D read_hi()) {
> > > >                 // Pick a value that happened while doing the reads.
> > > >                 hi++;
> > > >                 lo =3D 0;
> > > >         } =20
> > > This is not a free optimization =E2=80=94 it does not preserve the sa=
me
> > > semantics as an atomic 64-bit read. There are at least two correctness
> > > issues:
> > >
> > > 1. Loss of precision: If hi changed during the read, setting lo =3D 0
> > > discards the actual lo value. The correct approach is to re-read lo
> > > after detecting the change, not fabricate a value.
> > >
> > > 2. Multiple overflows: This assumes at most one overflow occurs
> > > between reads. If two overflows happen (e.g., due to interrupt
> > > injection), hi++ will produce an incorrect result, silently corrupting
> > > the counter value.
> > >
> > > Negligible benefit: hi changing between reads is an extremely rare
> > > event. Optimizing away the retry loop for such a rare case provides no
> > > meaningful performance gain. And if hi never stabilizes, that
> > > indicates a hardware failure =E2=80=94 in which case hanging in the r=
etry loop
> > > is actually the more appropriate behavior, as it makes the failure
> > > visible rather than silently producing garbage values.
> > >
> > > The high-low-high do-while retry strategy exists precisely to handle
> > > these cases correctly. I don't think this proposed sequence is a valid
> > > replacement.
> > > =20
> >
> > The point is that if the value is an incrementing counter (of some form)
> > then the value is stale by the time the reading sequence completes.
> > So all the code can be assumed to do is return a value the counter had
> > sometime between when the code started and when it finished.
> > If hi changes then hi+1:0 must have happened while the code was running
> > so it is a safe return value. =20
> You're right =E2=80=94 (hi + 1):0 is enough for hi-lo-hi. Thank you for
> sticking to your point; it helped me think more carefully and
> understand the subtlety.

Don't worry, I'll have written the loop in the past.
Probably best is read old_hi-lo-hi then if (hi !=3D old_hi) lo =3D 0

	David

>=20
> >
> > It is likely that the reads are also much slower than memory reads.
> > If hi changes relatively infrequently (compared to the number of reads)
> > it may be worth saving the previously read value and avoiding the second
> > read of hi if it is the same as the previous read hi and lo has got lar=
ger. =20
>=20
>=20
> --
> Best Regards
>  Guo Ren

