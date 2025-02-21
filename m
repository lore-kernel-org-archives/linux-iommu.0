Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE50820409F
	for <iommu@lists.linux.dev>; Fri, 21 Feb 2025 09:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740131202; cv=none; b=ZEjDpuie+TRmprkeWqY4KlXhwJLYbWN4CTmWfuYPWjrP8Au6SHIdh9vd+sgZpvt25BUSomxqH3SYfSHefHig6BFuNo+NKHbM3qeiGAAQ/mNWrPAkx2hWCqkEfZmpW/saI1WG6RYWf+yOCYJf0WIVpRc7R0w7NDh7rPJ5vNimNmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740131202; c=relaxed/simple;
	bh=eQJL+meMUpiM4NI7kP2j/MMgufqHNxN/rIC7ZWyqMl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W9J/tRcdUd6Vi77H8JUFhEiMDKDkA9dlqCZ892fzwTpjOCJBhfkH1cjGBQuBe4hk5iRvsI0ohxARTBDPPpPEdVavgxPTTlRUWERDBKtu8O4fmgZ9hLobEG7AMsbyQ4qDSSJdxxOppOgSXp7iER2xzMoV41tStKeDU7kZA/vjm88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PiOWwb/U; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PiOWwb/U"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3f40a38cb6bso849414b6e.1
        for <iommu@lists.linux.dev>; Fri, 21 Feb 2025 01:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740131199; x=1740735999; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FK9YWaslx6HNqwJPESJVhu2TqR0s7ppmYvVLNX5onZk=;
        b=PiOWwb/UDVQbnAHLEfSfbss7h92DoAY/IuAasysCmYQUd2QIBvLhs/In5GuVJ7TKXV
         AyYH6k3gM+mDO0KWv5/oJWk6HWtVcfI7xriX7vu+zZWwOIHLjCT15zL+rvOwUE2TjYPV
         hPEbhb0qrVvh5Ha2Q1Z5de4PgHe9CWVZhsYqc41WbZUJmoyi6E3TTK47hrwnCZjvfuLD
         SKg/u0ebszhQUWsEr2wH6nIKD6+adW4YvJu0xhYUrTz7Sqm+RYnb4AXvE6WCaZzkTXTJ
         aYUQD5omxEFi5AIzntgqtvj6hlTJWcQZSO5rdvV8zYaqLL7xRpiYhe4c8DA25DdXIvT9
         j1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740131199; x=1740735999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FK9YWaslx6HNqwJPESJVhu2TqR0s7ppmYvVLNX5onZk=;
        b=RlGszGBuSr0e5Iha1c8KR6axJ5bbUsJwuLXAzv3X3vIRUcNOE8S3npMYisGz8fWAUR
         Y3E5fbrdrb5kcwMTodf6vhnnhhdvfHtgqdhhd9zjFCsAHmqrJZVGG7G8npdsRjM1tM4+
         kWBQwtTBMeSNVstJVPvsYCxXo38zauXMxFVuL/L87vgtpmUKSSOcLd95yK/8wMmC0FKM
         Mb6h4Q2vtdN8TIQhOtNKeP+hURAAJvOE2myIF2rIhhAw+4C/obWCIeDsFP55mfOj4oRB
         3vVsbAAjuedO8mjvHbsa0scsuLqcV9w6PnyqJQlffPKavakoyTxxIqAz/aoLdK4HpABW
         XWVw==
X-Forwarded-Encrypted: i=1; AJvYcCU1XVMoKQDo+/JL+cdRsw9TFbHpOG2ofYLf4jiglbsC6uFdtbf+rQlW7OLdvGyu/KW0VXByHQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzIFzOS+coIQ+HzwLqojF9cpjepO8AocjighUgjeBzHGqYnGr+N
	Nm2aDPTIwElcxZtQ7b905aUJqge/EH6zHWwPzLwB8Hr4JlDuJ4TYrejppOSwCg8R7tgeUI+05E5
	uwOQFLIAtL11srUKOfLE8+fzmyGUdDiiJ+pLoMA==
X-Gm-Gg: ASbGnctI3hz3FLZA/66NO7Yur8FYDmDZZAwXQSEgo3zVCBwJKXr/twWeppgUGYaOpkE
	UEgBRjaz9gFcUE2PTDkTIIwU0qiGK+inOWv5VP1srpCN5m3YROZurkgqxQ1AIxJmd8MwbkCL1CH
	bVywd3JDUBhA==
X-Google-Smtp-Source: AGHT+IGKyiCnfDfAcOf96/Pz2fYUxZ2ya298ZCqluJV66qLCCSHa32SRsS9lfGx93hGxLg3TS7OQXnUDo/JPgXH6CeY=
X-Received: by 2002:a05:6808:15a8:b0:3f4:ed9:d4c1 with SMTP id
 5614622812f47-3f4246e1bfbmr2178808b6e.22.1740131198879; Fri, 21 Feb 2025
 01:46:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250220101511.37602-1-cuiyunhui@bytedance.com> <ba2a6295-7983-4701-8c42-797efe22ecb7@linux.intel.com>
In-Reply-To: <ba2a6295-7983-4701-8c42-797efe22ecb7@linux.intel.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 21 Feb 2025 17:46:27 +0800
X-Gm-Features: AWEUYZkJqSgMY7u4dhOrvQExbs4Qf6MpItdHGfjihq8Thi_KuEFs--dsdZv-1_4
Message-ID: <CAEEQ3wkygXexsu9x16Q+6yMtmtM+9aD=-DH1tMVNq1yuyZ7Dcg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] iommu/vt-d: fix system hang on reboot -f
To: Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc: dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org, 
	will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ethan,

On Fri, Feb 21, 2025 at 4:40=E2=80=AFPM Ethan Zhao <haifeng.zhao@linux.inte=
l.com> wrote:
>
>
> =E5=9C=A8 2025/2/20 18:15, Yunhui Cui =E5=86=99=E9=81=93:
> > When entering intel_iommu_shutdown, system interrupts are disabled,
>
> System interrupts were disabled ? you mean all interrupts were disabled
> when entering intel_iommu_shutdown(), perhaps it is not true, at least
> for upstream latest code.
>
> > and the reboot process might be scheduled out by down_write(). If the
> > scheduled process does not yield (e.g., while(1)), the system will hang=
.
>
> No NMI lockup watchdog jumping out here ?

Steps to reproduce:

1. Avoid return in:
if (no_iommu || dmar_disabled)
    return;

2. Write a.out with while(1).

3. ./a.out &; reboot -f.

4. Observe. Send NMI via BIOS to check system response.

5. Add console=3DttyS0,115200 to cmdline to increase reproduction chance.

Let's continue discussing based on the above.

>
> Thanks,
> Ethan
>
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >   drivers/iommu/intel/iommu.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index cc46098f875b..76a1d83b46bf 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -2871,7 +2871,8 @@ void intel_iommu_shutdown(void)
> >       if (no_iommu || dmar_disabled)
> >               return;
> >
> > -     down_write(&dmar_global_lock);
> > +     if (!down_write_trylock(&dmar_global_lock))
> > +             return;
> >
> >       /* Disable PMRs explicitly here. */
> >       for_each_iommu(iommu, drhd)
>
> --
> "firm, enduring, strong, and long-lived"
>

Thanks,
Yunhui
