Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B8E189F36
	for <iommu@lists.linux.dev>; Fri, 22 Nov 2024 23:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732318438; cv=none; b=AgHLQAaBZVcmSDrQcYNp7xOpgxyG/6itYG2IkbTEqKKI1ow63TvYC1SCZavIuRM7gFgzaRe5Q9uDVeCxFvmv2lF25AhBHIhEEBvqw5eBaXMieQIepnBieKdsB4WSUgHmzkmjykuyQPcjPy/sOdkfZZQyusb4zmmhHR4mNvKFx6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732318438; c=relaxed/simple;
	bh=tT7WDCI8ligQZAYkc1ZJ7/akrV2kO93xh6EGWd/HSDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MditEyStf5E8j6EAK75kFyzYibAGfpf09zMEH5cOrFwYPtdBOkiJhwjbGGtnZTvZRYbZTW7NaBOhPkSJjPCCDZtWJPjUT87ieKIwgmH8cv8nDfg0eq/7UEk9P8LAGF6X3Si3D50yWBpIsTlDOOAWvrNGJFM8/5yL03n3kHzE4O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tkUbeVVh; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tkUbeVVh"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5cfb81a0af9so1450a12.0
        for <iommu@lists.linux.dev>; Fri, 22 Nov 2024 15:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732318434; x=1732923234; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWm267dGZGtjDG+TqIez8D5Yo5y5v/NScAZSyn9WRGI=;
        b=tkUbeVVh++k9aq0YO3v4GS3Pvs/ms1PEX2FDkeIKxc0f39CNopopjPkfDvNGIk5jOL
         Mu8aHSG3/sT4YIzaQIxQ6q1/JowHSQki9N95z4fRrJv+f7O1t9vVtftvCKeo8ho3mZy1
         RPS0B+L3ooGsi76hcd6gORNdaWL2MAQVjFt9AqaubKmOe9zHcAPHjgEnCkJzjZtVaGEa
         /X5rjfC+w08K83ZjBM6JXUznMOIfP21vHdCy38IHa3xh9MAIpYOCKoDmEOu07tz08yRZ
         c1vHwCDH+cNV0H8+gqHN9i9s1UbfHF31e7xceN97wKKoKZ/UR5Hzll+39rtJ+o/q0MY6
         HvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732318434; x=1732923234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWm267dGZGtjDG+TqIez8D5Yo5y5v/NScAZSyn9WRGI=;
        b=wVnXaO81YBf9ESTKTvsH28WHSy/IXukyN3ExWsu//ZkB5nib0rsgeNrV9kMlWqf6jM
         f0gWfWB7hu9cwam4yZqOENQLXrJnR6BYaHmwpGHS8wCid7HZq63jFBWAmNlNTY7uDNPh
         HNnNBM9gyLI60hGpHFSSQZ6cOivSj2c4js/PADx2VD+LntguxPP4++WX+IBk/+53eIaO
         g65KUUpR2uC6KoGCMmpbccXR8ex8uqKSn1/oyShCllxU5u3Y61sFZsVx4l2r99ZlrzCs
         tltIm7vQqILaalQdh3OxKT70kHBt8jZu6fu/meLDhJgfgfihsFpyHQiwK7WYHzSRPPXG
         BU6g==
X-Forwarded-Encrypted: i=1; AJvYcCUH4Rh7PkdNRKxCwpF02zdaYYwIJg8kQyn2eEHcu1B7k13NfYrCq1dszxTCo7jFB/hDe6hHyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz2hQpUOsvSLOBvNDceYWANUBZ8q+s5BhqAF8aXaFBH/AHLLIAT
	w29yXPcAIzwTiPMSapMUiuw8rswGJXYEhPZG8OaX3OLimt3XNoYZAIjzy9cPNM7iuZpTBRL46YU
	dEFqDxpJqts4VYKvkNSsiFvyZvxRlYkhQKz+m
X-Gm-Gg: ASbGncvuw9JPmHKQn+4RlwQ4E+pwU1jspfKYNQwTP41Lm47zbe+7Z22eu1SDIynpygm
	Ib82bQ4LmmqyXTvw2eqzsT4N2xjnfyBeb2py8QHbyeUxlb2vJHuJp+/CwtmZP
X-Google-Smtp-Source: AGHT+IFNu41D3pBXLxClaPFn5RCfWNwWnPwL7Kt8iZVAgsv3Ta6dj8QsIsIpwZqAstm5kq4SAJivexFt/RO/HlDUqnI=
X-Received: by 2002:aa7:d607:0:b0:5cf:c93f:36f3 with SMTP id
 4fb4d7f45d1cf-5d03803e742mr9131a12.7.1732318434203; Fri, 22 Nov 2024 15:33:54
 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241112083018.1662104-1-praan@google.com> <CAE2F3rBqPF_POHSdeRahgd+ew9tD37iq6S8M=9Sj0Br6pe5e5Q@mail.gmail.com>
 <CAN6iL-SwmwgiyhvCkGV__Q4D_K4TRD+6ZD1O4YJS2qtamW1k_g@mail.gmail.com> <Zz3LZaYh_-Ut-mMQ@google.com>
In-Reply-To: <Zz3LZaYh_-Ut-mMQ@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Fri, 22 Nov 2024 15:33:42 -0800
Message-ID: <CAE2F3rDd3MGJGc6FDx6+OsQYecm1HPUb6BgZ0oUWjtCow1Jkew@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] iommu/arm-smmu-v3: Parse out event records
To: Pranjal Shrivastava <praan@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev, 
	Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 3:43=E2=80=AFAM Pranjal Shrivastava <praan@google.c=
om> wrote:
>
> On Wed, Nov 20, 2024 at 12:24:43PM +0530, Pranjal Shrivastava wrote:
> > Hi Daniel,
> >
> > On Wed, Nov 20, 2024 at 10:15=E2=80=AFAM Daniel Mentz <danielmentz@goog=
le.com> wrote:
> > >
> > > On Tue, Nov 12, 2024 at 12:30=E2=80=AFAM Pranjal Shrivastava <praan@g=
oogle.com> wrote:
> > > >
> > > > Enhance the arm-smmu-v3 driver to parse out useful information from
> > > > event records into a structure for better event handling & logging.
> > >
> > > Hi Pranjal,
> > >
> > > Thank you for putting this together.
> > >
> > > >
> > > > Some sample events, powered by QEMU:
> > >
> > > > 4. Translation Fault:
> > > >
> > > > [    7.586428] arm-smmu-v3 arm-smmu-v3.0.auto: event 0x10 received:
> > > > [    7.587012] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000800000010
> > > > [    7.587504] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000020000000000
> > > > [    7.587986] arm-smmu-v3 arm-smmu-v3.0.auto:  0x00000000fffff040
> > > > [    7.588745] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000000000000
> > > > [    7.589219] arm-smmu-v3 arm-smmu-v3.0.auto: Event 0x10 received:=
 F_TRANSLATION
> > > > [    7.589219]  client: 0000:00:01.0 sid: 0x8 ssid: 0x0
> > > > [    7.589219]  iova 0xfffff040 ipa 0x0
> > > > [    7.589219]  Unpriv | Data | Write | S1 | Input address caused f=
ault
> > > > [    7.589219]  STAG: 0x0
> > >
> > > I find that "Event 0x10" is redundant and recommend removing it. Mayb=
e
> > > print just "Event F_TRANSLATION"
> >
>
> I agree, however, in the past reviews [1] we've been asked to keep the
> existing log "as is" unless there's a particularly compelling reason.

I believe that feedback was about changing "event 0x%02x received:\n"
to "event 0x%02x received: master %s:\n" on the line that immediately
precedes the raw dump, but we're not changing that. What I am
suggesting is to remove "Event 0x10 received:" from "Event 0x10
received: F_TRANSLATION" and replace it with "event F_TRANSLATION"

>
> >
> > >
> > > Not printing the prefix "arm-smmu-v3 arm-smmu-v3.0.auto:" on
> > > subsequent lines appears to be inconsistent with how the raw event
> > > bits are dumped. Also, I typically run a command like "grep
> > > 'arm-smmu-v3 arm-smmu-v3.0.auto' uart.log" while I'm developing smmu
> > > driver code, and with the proposed change, the grep command wouldn't
> > > print most of the event details, because they are not prefixed by
> > > "arm-smmu-v3 arm-smmu-v3.0.auto"
> >
> > I see. The prefix isn't getting picked up because I'm trying to print
> > all the lines in
> > a single `dev_err` in order to avoid other logs inter-mingling with
> > these ones. I can add
> > that if we are okay with using multiple `dev_err` calls (i.e.
> > potentially allowing other logs
> > to mix-in).  Otherwise, let me see how we can manually add the dev_fmt
> > string in the log.
> >
> > >
> > > The words "client", "sid" and "ssid" are followed by a colon (":") bu=
t
> > > iova and ipa are not.
> > >
> >
> > Ack. Will fix that.
> >
> > > Can you put everything up to and including iova on the first line and
> > > the rest on the second line?
>
> Finally my email client is fine.
> Did you mean something like the following:
> [    7.589219] arm-smmu-v3 arm-smmu-v3.0.auto: Event 0x10 received: F_TRA=
NSLATION
> [    7.589219] arm-smmu-v3 arm-smmu-v3.0.auto: client: 0000:00:01.0 sid: =
0x8 ssid: 0x0 iova: 0xfffff040 ipa: 0x0
> [    7.589219] arm-smmu-v3 arm-smmu-v3.0.auto: Unpriv | Data | Write | S1=
 | Input address caused fault | STAG: 0x0
>

I was thinking about something like the following:

[    7.589219] arm-smmu-v3 arm-smmu-v3.0.auto: event F_TRANSLATION
client: 0000:00:01.0 sid: 0x8 ssid: 0x0 iova: 0xfffff040 ipa: 0x0
[    7.589219] arm-smmu-v3 arm-smmu-v3.0.auto: unpriv data write s1
"Input address caused fault" stag: 0x0

For sid, ssid, iova and ipa, you used all lowercase. I suggest
extending this rule to Unpriv, Data, Write etc. and use lower case
there as well. I'd remove the "|" characters to save space. I'm not
sure how to represent the "Input address caused fault" part without
the "|" characters to separate it from the rest. Maybe we can put it
in double quotes.

> Thanks.
> Praan
>
> [1] https://lore.kernel.org/all/08498356-d892-4756-89e1-45b2654faa42@arm.=
com/#:~:text=3Dsafest%20to%20leave%20any%20existing%20%0Amessages%20exactly
