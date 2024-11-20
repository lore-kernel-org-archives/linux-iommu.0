Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D123342048
	for <iommu@lists.linux.dev>; Wed, 20 Nov 2024 07:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732086773; cv=none; b=WeFT6JovPr6qRsLwPPDivMVprhcwJT3F+ZA89yS7sDxGFJl0aI4ZwvGqQYa+jFfpEK/iudR7KvvOTPADPImEFZONkQ6ZaRtBG5cNFamfFBFjJfYCCJMQxqOXs399b0S5ATw+jIIkmwm18kSz2yUtSgPUyll1dHaR/laOnkRMF+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732086773; c=relaxed/simple;
	bh=sRMHmXD/QINkMK8H2zSISg9mvhJRMxfq5ka7zqLd1/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gDQ9pnedNpl0D+pqAR7Yo9j16LduE3KZnTYUEvOVjfHYeHsr2e80KgubW9Nsdw5vFJGdjMcW8kfWYhK5gcWyokP0j04Ptv25Zq42CshGgIVP/wDob9JgxYue0bEJ3yfMHA77rwI3lXaJjw1Ru0wVawLz0TS1ZDo1osA8vk3VjUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i25EYPzf; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i25EYPzf"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-460a8d1a9b7so528421cf.1
        for <iommu@lists.linux.dev>; Tue, 19 Nov 2024 23:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732086771; x=1732691571; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0W3lFFMyiLxkNJ/1/ctxUq9W4dsXyHIMyotjES2Qk8=;
        b=i25EYPzfGsbTZwqQfW58pL6chBtPMIGqPlrirC5tr1ASZQFIGXgo+nrW7h2EPOtHvs
         jJcAKu3JpQ4LOFAzGRos7WOXhZ2EcaeqAiHFdqzviE5Ue2gE2G0DilJZ4HA4VjJWoo+x
         AuPvsrvuY7yuqhTkUzyRZ1g68aCEHdyrTgHhnX1nXfYu5awLhcffmhvVivgeVRAlXeIE
         rCqY6cxa4YSswLibbm15rfLoMkQJXMiGC78ignB4ov0VETd7WNJxMnBltrlvxxGnBpgI
         ZlvQQ9VYr78lsNpIDHZuS/2aeKzfesi1ZaSAWkO3Ff3/yYqq06DisrjNb5xtaZAo5/vc
         Y8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732086771; x=1732691571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0W3lFFMyiLxkNJ/1/ctxUq9W4dsXyHIMyotjES2Qk8=;
        b=HIhj6JUXTJf5XSX7O29XfMFUJy5NSFZrVJMPAGSdW9roIvJG68q3dWeHS3tILe/vgc
         Cf+5d4La87HO24goUfob/2yaYs2M6yooJ9GOoy0d7GntqnUJ7IweQYLyt/fu5RXzR61R
         NjZ07WPqiik6uetuYmQdwYyFStWzbBpcpkL1N7Fzfwqp22W9WzNUtWr2ah9vv2XIn+TY
         daPz2oyWHVFHWIyIIqaKQolG04sv+9M/0sDJf1hsgFW/KHtcvcxDW2AJJJIXMW1TbPfc
         5zCYUH2Af7wy+/t+0yPFqBm5F5zz8PG+3JnTKZPE719gprfJ+Q3MXyaJcZfik+sy2/DH
         VP+g==
X-Forwarded-Encrypted: i=1; AJvYcCWw+AJJNA/VdW7w0HbVFvn611hvrJZn0GCSjHrz2M38j1AgkzhKFXI1yYPWxFKjh8mKtY+NEw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy63Cy+ue4eI/T17c8YhJB+f+uke5VZRUTvwq2S5OUK+KM2WTB4
	pEZGgE75YJEw05hGm47o6AQNUoS7c9Bg9Z5xhEYbCKCXMWjSqPw31T9AkWkRstF8qqWxbXwNkEt
	8cwHAa4IYHfe21bwfFFEAZprFnAt4f/5uue4dISngJt3UUbfOWxFWgh0=
X-Gm-Gg: ASbGnctAzKnHnSOh9tIv+jx1Gz52jx+vvn8BrLojnxqJ7J5d9jqvU+aFg2LPqegbc9H
	K+5imLv8HV4+3wSaXrDyyg53O/Fa+rviQ
X-Google-Smtp-Source: AGHT+IFIi3A2s9VhgJCMMYL53sxA6R04s7e/3c4i4PWxxkJd/ggHXcDWqLxHIuubTgTff7z/ggkiQAug+mnDj3fexk0=
X-Received: by 2002:ac8:5a47:0:b0:462:c8ad:dcbe with SMTP id
 d75a77b69052e-464d2e225f3mr1454391cf.7.1732086770477; Tue, 19 Nov 2024
 23:12:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241112083018.1662104-1-praan@google.com> <CAE2F3rBqPF_POHSdeRahgd+ew9tD37iq6S8M=9Sj0Br6pe5e5Q@mail.gmail.com>
 <CAN6iL-SwmwgiyhvCkGV__Q4D_K4TRD+6ZD1O4YJS2qtamW1k_g@mail.gmail.com>
In-Reply-To: <CAN6iL-SwmwgiyhvCkGV__Q4D_K4TRD+6ZD1O4YJS2qtamW1k_g@mail.gmail.com>
From: Pranjal Shrivastava <praan@google.com>
Date: Wed, 20 Nov 2024 12:42:39 +0530
Message-ID: <CAN6iL-TUtnxogbiJyLcLejObiZdbiVbr_S2aBBKC4=seMiwA1A@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] iommu/arm-smmu-v3: Parse out event records
To: Daniel Mentz <danielmentz@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev, 
	Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,
On Wed, Nov 20, 2024 at 12:24=E2=80=AFPM Pranjal Shrivastava <praan@google.=
com> wrote:
>
> Hi Daniel,
>
> On Wed, Nov 20, 2024 at 10:15=E2=80=AFAM Daniel Mentz <danielmentz@google=
.com> wrote:
> >
> > On Tue, Nov 12, 2024 at 12:30=E2=80=AFAM Pranjal Shrivastava <praan@goo=
gle.com> wrote:
> > >
> > > Enhance the arm-smmu-v3 driver to parse out useful information from
> > > event records into a structure for better event handling & logging.
> >
> > Hi Pranjal,
> >
> > Thank you for putting this together.
> >
> > >
> > > Some sample events, powered by QEMU:
> >
> > > 4. Translation Fault:
> > >
> > > [    7.586428] arm-smmu-v3 arm-smmu-v3.0.auto: event 0x10 received:
> > > [    7.587012] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000800000010
> > > [    7.587504] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000020000000000
> > > [    7.587986] arm-smmu-v3 arm-smmu-v3.0.auto:  0x00000000fffff040
> > > [    7.588745] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000000000000
> > > [    7.589219] arm-smmu-v3 arm-smmu-v3.0.auto: Event 0x10 received: F=
_TRANSLATION
> > > [    7.589219]  client: 0000:00:01.0 sid: 0x8 ssid: 0x0
> > > [    7.589219]  iova 0xfffff040 ipa 0x0
> > > [    7.589219]  Unpriv | Data | Write | S1 | Input address caused fau=
lt
> > > [    7.589219]  STAG: 0x0
> >
> > I find that "Event 0x10" is redundant and recommend removing it. Maybe
> > print just "Event F_TRANSLATION"
>
> I agree, however, in the past reviews [1] we've been asked to keep the
> existing log
> "as is" unless there's a particularly compelling reason to change them.
>
> >
> > Not printing the prefix "arm-smmu-v3 arm-smmu-v3.0.auto:" on
> > subsequent lines appears to be inconsistent with how the raw event
> > bits are dumped. Also, I typically run a command like "grep
> > 'arm-smmu-v3 arm-smmu-v3.0.auto' uart.log" while I'm developing smmu
> > driver code, and with the proposed change, the grep command wouldn't
> > print most of the event details, because they are not prefixed by
> > "arm-smmu-v3 arm-smmu-v3.0.auto"
>
> I see. The prefix isn't getting picked up because I'm trying to print
> all the lines in
> a single `dev_err` in order to avoid other logs inter-mingling with
> these ones. I can add
> that if we are okay with using multiple `dev_err` calls (i.e.
> potentially allowing other logs
> to mix-in).  Otherwise, let me see how we can manually add the dev_fmt
> string in the log.
>
> >
> > The words "client", "sid" and "ssid" are followed by a colon (":") but
> > iova and ipa are not.
> >
>
> Ack. Will fix that.
>
> > Can you put everything up to and including iova on the first line and
> > the rest on the second line?
>

Apologies, I'm not able to use my regular mail client due to corp mail issu=
es.
I'll try again. Do you mean something like the following:

[    7.589219] arm-smmu-v3 arm-smmu-v3.0.auto: Event 0x10 received:
F_TRANSLATION
[    7.589219] arm-smmu-v3 arm-smmu-v3.0.auto: client: 0000:00:01.0
sid: 0x8 ssid: 0x0 iova: 0xfffff040 ipa: 0x0
[    7.589219] arm-smmu-v3 arm-smmu-v3.0.auto: Unpriv | Data | Write |
S1 | Input address caused fault | STAG: 0x0


> Thanks.
> Praan
>
> [1] https://lore.kernel.org/all/08498356-d892-4756-89e1-45b2654faa42@arm.=
com/#:~:text=3Dsafest%20to%20leave%20any%20existing%20%0Amessages%20exactly
