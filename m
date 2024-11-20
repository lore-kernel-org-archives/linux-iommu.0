Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E261876
	for <iommu@lists.linux.dev>; Wed, 20 Nov 2024 06:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732085697; cv=none; b=Y1AxMuB9POijOCh9e+0568bEAlpVgy7wLzYhFZ6ALhWGMtbQxmmYztOvO6E7Dm/bvpw2dTfQNTslnQoMs4I22dToW+cfukXZe4K3Z8ktaYawYUMNeusu/kxzNXmiZ9GiVMcItTWaCxl6hHH3Bo5W53KMe6RfXL8QxPoPSn4+Tms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732085697; c=relaxed/simple;
	bh=JZyWz06htZMNMWoll1HNFBrmcaMzq4LAklhH5pOj24M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJnSO+Tf3McpA8GFMlxX2OdoGv1BcHIR4NNqqTZgM0QyDl8ag71BMGcHEQ/gBcdWAO9iFfWdx5rSKcCiKdj6F28R/sqF9CAdWf6kAwwH6icoMAwVO1cOzkzHAj+LmW+4tv0Y0vLhUqHPQfregU2YMxeH3a9FgFStYCWVBs2enUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UCInQ7vg; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UCInQ7vg"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-460a8d1a9b7so525171cf.1
        for <iommu@lists.linux.dev>; Tue, 19 Nov 2024 22:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732085694; x=1732690494; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wOaTA0GBByehEzK9sx7VtJ0n8Sl36sghTL86MMa4LM=;
        b=UCInQ7vgLi5mhOXzTwAH0YbxU3Ij7wbNZbvfokAriQB4FF1VufsgnXicch+lseGart
         Lf5hwHZCrRVAP14v/waAcwD5UzyN9Gb+1eNSeJNIAcHffthPdAM65uZLtozc96rkSMZ7
         4oTSeYirLvU2rToOsnmcnBl9BNjxK56YEJHN02AK6Og9GFwvfqdt+uB4ju3ZZ2VA6skK
         4wf1Y8lKQCDLlgUcib5qEZVNnfqHVq1g3G3zbcJ4U3PyrB0TSspJpSPw7rwyMRtEtvL8
         A8TSgxFxDEOkWf2ZEi7eTO1ti1g+58KAyphbJu/gdv0RMWWpcofdgJ/otabE+NQHwQP5
         lruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732085694; x=1732690494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wOaTA0GBByehEzK9sx7VtJ0n8Sl36sghTL86MMa4LM=;
        b=CF5un0HjNgwazeEJ8UJ3U8he0tLgkieZkSI44UbqkSXM3npxP/NQdS99eNw4zk/SzC
         2Q14tcGPRPSr49HGqZrc82lJxYx8aZwZwG3BAp+Lrg+Dy7AFQfK0xxKinKAk+uhJzZdH
         UzjDiQ2kDaDwV5dAZDITSKSKKYvXwmBCeqC2WBYU3PsT5gJttMAtr3vXTxRBQhYwzcyl
         uV4G9uVWEf3Hby4KSnrRbuWv4PLlGOUumVWk0Ap61DmqOaQsTtaW8sRWrPGiWXyMXcOM
         SD2fLSmV5WJ6OMi4O/0eD75Sx0jtUpuIovI6+92fPM3k5Mn93e8qEHhM4OiDELnNU0Xj
         HibQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsL2XGoPCUmwoldkThJsCAid2vS5yQMXf6xexSs/e7gEGxV6RAHO7JZ+biV71ksH4K2i0kKA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxXDl7wbi+fe51xmoiJyjYcRmulypsf8BI8wZT9+82i+ARm5KIL
	GP/vGf4+8zkDbMZMdAY8xH44SHrs6kQCo1gJX5xEr3p8J0u4qKO6V1zJjhR0gssjKIjVwgZBhZD
	1KCQ9zzWkvyj1BrC6TIbt0ahvvL32J3EkK6Gg
X-Gm-Gg: ASbGncuboL8heywvSORwtPkWQNcFnlLm3R/2F0aj4wfSv1n52YKIRZ+Noc0KWyUgIAC
	o0xQPy6+tYGBapCha1S8NSSm3sccngGal
X-Google-Smtp-Source: AGHT+IEgxqKpUOtSX0T187TTAZdiGyWkH+sfTilI0fbAVpEvsTlHrhobTo7Rra1N5jqTDbDAAcrjX2ssm02dFBX5YDw=
X-Received: by 2002:a05:622a:406:b0:462:eb1a:89e7 with SMTP id
 d75a77b69052e-464268f9ff6mr2542871cf.2.1732085694261; Tue, 19 Nov 2024
 22:54:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241112083018.1662104-1-praan@google.com> <CAE2F3rBqPF_POHSdeRahgd+ew9tD37iq6S8M=9Sj0Br6pe5e5Q@mail.gmail.com>
In-Reply-To: <CAE2F3rBqPF_POHSdeRahgd+ew9tD37iq6S8M=9Sj0Br6pe5e5Q@mail.gmail.com>
From: Pranjal Shrivastava <praan@google.com>
Date: Wed, 20 Nov 2024 12:24:43 +0530
Message-ID: <CAN6iL-SwmwgiyhvCkGV__Q4D_K4TRD+6ZD1O4YJS2qtamW1k_g@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] iommu/arm-smmu-v3: Parse out event records
To: Daniel Mentz <danielmentz@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev, 
	Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Wed, Nov 20, 2024 at 10:15=E2=80=AFAM Daniel Mentz <danielmentz@google.c=
om> wrote:
>
> On Tue, Nov 12, 2024 at 12:30=E2=80=AFAM Pranjal Shrivastava <praan@googl=
e.com> wrote:
> >
> > Enhance the arm-smmu-v3 driver to parse out useful information from
> > event records into a structure for better event handling & logging.
>
> Hi Pranjal,
>
> Thank you for putting this together.
>
> >
> > Some sample events, powered by QEMU:
>
> > 4. Translation Fault:
> >
> > [    7.586428] arm-smmu-v3 arm-smmu-v3.0.auto: event 0x10 received:
> > [    7.587012] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000800000010
> > [    7.587504] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000020000000000
> > [    7.587986] arm-smmu-v3 arm-smmu-v3.0.auto:  0x00000000fffff040
> > [    7.588745] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000000000000
> > [    7.589219] arm-smmu-v3 arm-smmu-v3.0.auto: Event 0x10 received: F_T=
RANSLATION
> > [    7.589219]  client: 0000:00:01.0 sid: 0x8 ssid: 0x0
> > [    7.589219]  iova 0xfffff040 ipa 0x0
> > [    7.589219]  Unpriv | Data | Write | S1 | Input address caused fault
> > [    7.589219]  STAG: 0x0
>
> I find that "Event 0x10" is redundant and recommend removing it. Maybe
> print just "Event F_TRANSLATION"

I agree, however, in the past reviews [1] we've been asked to keep the
existing log
"as is" unless there's a particularly compelling reason to change them.

>
> Not printing the prefix "arm-smmu-v3 arm-smmu-v3.0.auto:" on
> subsequent lines appears to be inconsistent with how the raw event
> bits are dumped. Also, I typically run a command like "grep
> 'arm-smmu-v3 arm-smmu-v3.0.auto' uart.log" while I'm developing smmu
> driver code, and with the proposed change, the grep command wouldn't
> print most of the event details, because they are not prefixed by
> "arm-smmu-v3 arm-smmu-v3.0.auto"

I see. The prefix isn't getting picked up because I'm trying to print
all the lines in
a single `dev_err` in order to avoid other logs inter-mingling with
these ones. I can add
that if we are okay with using multiple `dev_err` calls (i.e.
potentially allowing other logs
to mix-in).  Otherwise, let me see how we can manually add the dev_fmt
string in the log.

>
> The words "client", "sid" and "ssid" are followed by a colon (":") but
> iova and ipa are not.
>

Ack. Will fix that.

> Can you put everything up to and including iova on the first line and
> the rest on the second line?

Do you mean something like the following:
[    7.589219] arm-smmu-v3 arm-smmu-v3.0.auto: Event 0x10 received:
F_TRANSLATION
[    7.589219] arm-smmu-v3 arm-smmu-v3.0.auto: client: 0000:00:01.0
sid: 0x8 ssid: 0x0 iova: 0xfffff040 ipa: 0x0
[    7.589219] arm-smmu-v3 arm-smmu-v3.0.auto: Unpriv | Data | Write |
S1 | Input address caused fault | STAG: 0x0

Thanks.
Praan

[1] https://lore.kernel.org/all/08498356-d892-4756-89e1-45b2654faa42@arm.co=
m/#:~:text=3Dsafest%20to%20leave%20any%20existing%20%0Amessages%20exactly
