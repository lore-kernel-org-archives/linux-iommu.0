Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430583DA7CD
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 08:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779177802; cv=pass; b=cZM8F+J+5LrACjNcxygW70A6KHknCYXrDS534Ik2i0DranLW8qTm5gMZo1RC3C1OgZbz3iREPtLmDidqEKluJOPHFYSBg1vkbSqUI4CspGa5bGrCL5RQM7RC2D1PVXfb+BTfsT+MYSW6F4Dxyt6JNpVCc1WpJsKyoneqThnwNX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779177802; c=relaxed/simple;
	bh=K8dQnSD6WWaNaI0jk53u0fTtQE/jAooiTdvUuxwfkUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mlaIlrnnwsQ5Zu4zlunRJqWCi6jo5kNH85qsAG4KMG/uAQQOUfa6FYrs8ZpkmCgAVlSCtNDYctnOXrJQtl7LMJ/KR0adQtWJLppv85o3K4KfuuBbDp/G0/EDdQfrMjDeDptWXfyreWB5L8EW/UJZTbD05C6xVRdEE5TtKs1vMGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHCn7I64; arc=pass smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHCn7I64"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7dca00c1591so837161a34.3
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 01:03:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779177800; cv=none;
        d=google.com; s=arc-20240605;
        b=ZaEbi8SO+FjViyNrBxXpMM6zuFlKxiTNrP/ZGrlODej96dpaK+d0LbvbIMZO7RJLJv
         NAPfATvrBhE7KvaeVzv6t0pej+o6OQhEPef6X2r3p6zKWxvZknZtdcZzp+glfZE7bYq6
         cMTDlvISU3anVv5a9nctbxrZdIv6yZucdnS32aj9GDIn0I45/BbvwrX/x2mmz9JTkjEG
         xbUGXFcSeB1PA2sqOoYvPv9t88f56YfnUNc4RF5qdX0Hg8c/maTgge7LzBqn6eQZuLEm
         BeCDiVDuCErOcCqvjZlV2oyaJuCyBo5CCEtDMWSS/6IYGs0j4clFARIFWvIuvmlIIO7q
         ZV5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qd05AQ/Ebl+fCaojezMCrfifepauyMI3Ag+H+iuan5g=;
        fh=Ne/hpCXs/bT4On1F397JhoiVgcVv/uSflf3jSxUBvDI=;
        b=c04xapMqYhuFzWduRPW/BYwDU3PZs1zO1tzKAdeEoiKyh/SEE0x39Louu3+ke53QGz
         zUcWME8gxRYF/gTPt3EOuOOMt0mTRIzrehGvsrVtSVddb7sE3UcPOhos8TaZVpXBYnRt
         g8cupbr4yJkbXmPkcPc7Hi4u3CQ2DmrVmjmOfP6B8bOT4pfiLOtgaPLK/eOvJLlg+1zl
         6wtBWcFOpd8JKETgmtP5H5ADqQRKOLYY1fWkHMc+xTDtpASrlF23RmDEQUzhnQ5+Ct99
         I/FabGYMvZ+WNalrnHqdOBDyW0FuhJz4QtyrBaBukrYcUDCzc8cJ34Njgz508R4b6aw3
         glkA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779177800; x=1779782600; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qd05AQ/Ebl+fCaojezMCrfifepauyMI3Ag+H+iuan5g=;
        b=HHCn7I64yG7ylkJBMCzLoZjM9f49Ihd8Gl9ajPyxlzysydKvpNlwrP4FCmq8ngLNHe
         xIKoeB7xXSUbrb0nidQCEZyVCdN8IccW6muwUChahEndmq8MkGwiJzCz9neA8fvnUTuU
         cb0JxKsEGwZBfs4Sp5QM2RfxD/r2PnM5ORN2mqi4SSLZ718koWwZkeWwiWCnUxeEP57r
         DvxgFxN+DOSGoP886ywdrz82CjZtIYfR7jWfgciHgX0kty5Lz8YFyjLcyzUJCcXRloOH
         31nAivp9FPHRvd1L+auVrn1/ZFVZ3BeyDboz0LD16ArEvQ5gNFB1uGowAojzGDn0fyLp
         m00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779177800; x=1779782600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qd05AQ/Ebl+fCaojezMCrfifepauyMI3Ag+H+iuan5g=;
        b=EE8hsWPvr4yx3ey3pvVIEYypSjySPHbmojiB8yDICfRlz9QyH7Brykc6riASnzPEAW
         WrDtCuwbkpmDezD2IEb14RHSUeMeWQR083Z1HWyt7ohVFpPl0GtFPvJlobgZEWplipv+
         ORqmqXIN6E2Kp70v5f83Iq+sVPgMVaHP/10tTROemoRYghWSAyM0b87+cBcjkN1TX6Rv
         wTWERrKQ1SefWkzq4J6eDkbRhjHai/rfRXdbmEoiDH1jorGyb8gr4c+LYH5seSZJMpNX
         Bz9gSmL9rEG2t2Ua6Bh6414AFng1ud2rJ0E4sLqfhM3UMNE5PPhFU8YzUmSzOSZsHvR9
         Upbw==
X-Forwarded-Encrypted: i=1; AFNElJ/80rMcKeFOGJa0iL8V9sdGG00Zc3qniD5GfNqKXtuN2ktT/uKD1D/3Tn+u+D11ERLPpr8MYg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzE5uVem8ccwBt747X0DaMFjTGefD7pNpAL3f7CyvM4IEQoBeTG
	XHJPU0PZtNfnmHP/cIRL/acaU/0kAfqdhLS311bjTeCd66U0p0EKhmLYbccaPfoLM5SM6XbLboV
	/qOtVt9s5Q25NKJv4LJZ7pDGiowjlImI=
X-Gm-Gg: Acq92OEB3hTmrkHU7C5NxCi299QfsQ81t6tMVdOebrox+mpmt+MLYgQstRQCPzU2Lof
	Zj/rabQYZuR5keN+Beq3RKT6vJsyBohUzs3Vu6rTpRC1sg8p9jvsEOQ5wF6Dy28nXQVBwLoExb2
	KAx6byo9/tGsNEUM+LIO8sO3f+8+jVhsn8K96FOoQsYXQ4X6isOQYSmJWA8rNZgPP1zAJpbqMJk
	kV8uxCzXuvLiUUZboai6OFKMf+hiM4O0MrpqFyAGeU3hdPpyfCpDuS+vW62cb7/dhcXiXXAwiEb
	VR4BzWB5mw==
X-Received: by 2002:a05:6830:83b9:b0:7e4:de59:41fd with SMTP id
 46e09a7af769-7e4ea080469mr12422315a34.7.1779177800117; Tue, 19 May 2026
 01:03:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260518113251.64844-1-mikhail.v.gavrilov@gmail.com>
 <20260518121047.GR33515@unreal> <CABXGCsMxZ7VieyzWEmpGdxohdbTJ_qf_1ZOw0eF5g9i0YeOc3w@mail.gmail.com>
 <20260518125330.GT33515@unreal> <CABXGCsMA+uZtoup+QtGsPQcyF6TZimxYFOR2sDQksNkLpJq+2g@mail.gmail.com>
 <20260519071758.GB10037@lst.de>
In-Reply-To: <20260519071758.GB10037@lst.de>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 19 May 2026 13:03:08 +0500
X-Gm-Features: AVHnY4Ja3gLC8ALmotexfJDUefPt-0oJZaDwUkBCdicQ0kv5qNCc18I95Rq9i-w
Message-ID: <CABXGCsNg6NUefejbqGBpH1iff9H6mJ-3Zamb0A54ay1zrfuJeQ@mail.gmail.com>
Subject: Re: [PATCH] dma-debug: skip cacheline overlap tracking on
 cache-coherent architectures
To: Christoph Hellwig <hch@lst.de>
Cc: Leon Romanovsky <leon@kernel.org>, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	djbw@kernel.org, akpm@linux-foundation.org, catalin.marinas@arm.com, 
	harry@kernel.org, ming.lei@redhat.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 12:18=E2=80=AFPM Christoph Hellwig <hch@lst.de> wro=
te:
>
> It is not.  We could require direct I/O to/from devices that are
> attached without DMA coherence to require cache line alignment.
>
> Now that Keith pushed down the checking into the driver that's even
> fairly easily doable.
>

Good to hear. Is there a posted series or branch I could look at?
If non-coherent DIO gets the alignment requirement, that addresses the
corruption case at the source rather than papering over it in debug,
which would be the cleaner outcome.

Happy to test on x86_64 when something is in flight (no non-coherent
hardware here, but at least the no-regression side is covered).

--=20
Best Regards,
Mike Gavrilov.
