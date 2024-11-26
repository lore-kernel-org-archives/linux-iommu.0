Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121BA1AC44C
	for <iommu@lists.linux.dev>; Tue, 26 Nov 2024 09:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732613444; cv=none; b=ZiGTG/ZBYUnAoc6yXYo1h4Hww6L94/C5hpny7Fmns0KG7QerR7HOOrkx80yjpITLrPGMMaw0rr+DQlQ6w70ol4lu4J6vdV+1aD9LJ+rWZmCJDyo9W1CFy/HZS+ZbsKRxHS3qDD7sCUSKYz7Nj+ADoxnc34H7KPIwO5gKGnSqQN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732613444; c=relaxed/simple;
	bh=sSQ6LDjzDusR6IDZqzHBBKb4U2BJZGeXXBh0OXaBUY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHhQJNSK/j5XUp4+zIDWnjMG5EYLmlijrkSfpD05W5TqbMwpssTMMvzMcrbHql2WNkjQ4TCTVCL8JeG+ygknGKByiymEuH3fKNWFaglA/nDKwDs/+Ky4ElmlAdE/AhIFxWgc4HclguQPf9nWryqQ+H0j7hNjJAs9daociquhSXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rxi9nTXr; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rxi9nTXr"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-211f1b2bf2bso98275ad.1
        for <iommu@lists.linux.dev>; Tue, 26 Nov 2024 01:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732613442; x=1733218242; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wYLsyR2FyalhiEOl2kx+PSXHeRJDxZG6QJK9S58pFbw=;
        b=Rxi9nTXrI6I+wV00/mp8Io1/LhIITooXdH5hv8ZygUuGCt79Ae4/qCfJmmz1Vz2Azd
         XuC0mOXQoL5euKKzEFlIrywOfmE7CEDKE73x/LM5qpHtIoe41ZuoLGSALl7MdkE8Inqo
         zhUThpveonZX8RNTled31U/cryJAjFTNOrKXpNSTpv5AWwMZyEiVmsJ11K5pD41DthGa
         q0TDQKdlCgqepLjOqikTNdqVh8EiDdUMFQqBDNQYKnUfZud3gd2P6nhxpd24DZgMilVh
         6NCyT9+8uG+qr/wX8CfKGqaSjyYbEFrMJWBepJRtFTk+myYrjwVlJeXdoZtQaxT3G4Sl
         lcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732613442; x=1733218242;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wYLsyR2FyalhiEOl2kx+PSXHeRJDxZG6QJK9S58pFbw=;
        b=hKm91oQB5hz801rayuxg6qFVIFEgTuaoV9g3QZe01k0bMZIyzoJl/tvwbJHdxokUMv
         sNClrdNbEddrtSscZBCOq7slYms44c6RJ2OsoYWOvmMtrtqRI6IaxfkAsjANCex7gg7G
         TOwOQX2qYE6S4C7W1TXTrYp14Eg5TU36nyFhDmNnAuncy2c3veBfLS5GkENxxilVtZ1F
         R031dKJuYm1IcIk2jne5t/IU9KEpXh/v6KfGu8HyEXuKTu1WswygxmqRs4RYXz5i8R8D
         rO53+J0WBXHDv+jTP1dUlDxSMx2W5CdJ6jEdzuej5rbsplA52IH0Qx1VCn1IVoxOA8BA
         bQUg==
X-Forwarded-Encrypted: i=1; AJvYcCUJBQkRhwdYLyGqXtUw5zqV8vX6FIVWBftFbJVXzrIYwQbon/mKxccoL4NB73GiLNsYd9SMHA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyldgZI64f79KFSCLq6WMmulh5SRxemcEQe0Bvs3BdQCL3NNQyT
	DsXMyVQQ8v6pAU1apApsI9u/ynaC9LVBHijOkVcX5BVvQq+0Podgxr9ehN87Cw==
X-Gm-Gg: ASbGncsLPrtQskpMlbKceGmhuMPPApRk49cbBkWxF6np8OkfV9md3Ir992et9rFaCDB
	bpAXND8Nv39jk/S81RZvpXWOJPoOlwAJ32PUDJ2M1BpEqb1waL5+uXCilk1iq3BB7M3Gxaj6ggK
	VTUZQ2kscfhYB2/UKVvmOZZ0tFn55ZXFCVIitkku+3UBh6uA6y6oRCrrAtarYH3DiVlQwKoCjSA
	M3Uqb8BAtiHQeMDGH5zJq26IhdIeyXmkzh2iUZ7TwSDsKDO7Wr38ILTRxmMhG6LaJ3B1BK2Q8wZ
	x+S+1LG7I30=
X-Google-Smtp-Source: AGHT+IGqal35vAm3mZAvm6Bv170nPjDrNed6JP1DTVBOGUsqH8MAD3UXK1aZoKfF3YU2ar7NB8PrZg==
X-Received: by 2002:a17:903:1744:b0:20b:a2b8:1850 with SMTP id d9443c01a7336-214ea82e811mr1385035ad.15.1732613441984;
        Tue, 26 Nov 2024 01:30:41 -0800 (PST)
Received: from google.com (104.132.143.34.bc.googleusercontent.com. [34.143.132.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de532da6sm8166662b3a.105.2024.11.26.01.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 01:30:40 -0800 (PST)
Date: Tue, 26 Nov 2024 09:30:31 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v5 0/3] iommu/arm-smmu-v3: Parse out event records
Message-ID: <Z0WVN9vEqsfw7-wP@google.com>
References: <20241112083018.1662104-1-praan@google.com>
 <CAE2F3rBqPF_POHSdeRahgd+ew9tD37iq6S8M=9Sj0Br6pe5e5Q@mail.gmail.com>
 <CAN6iL-SwmwgiyhvCkGV__Q4D_K4TRD+6ZD1O4YJS2qtamW1k_g@mail.gmail.com>
 <Zz3LZaYh_-Ut-mMQ@google.com>
 <CAE2F3rDd3MGJGc6FDx6+OsQYecm1HPUb6BgZ0oUWjtCow1Jkew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rDd3MGJGc6FDx6+OsQYecm1HPUb6BgZ0oUWjtCow1Jkew@mail.gmail.com>

On Fri, Nov 22, 2024 at 03:33:42PM -0800, Daniel Mentz wrote:
> On Wed, Nov 20, 2024 at 3:43 AM Pranjal Shrivastava <praan@google.com> wrote:
> >
> > On Wed, Nov 20, 2024 at 12:24:43PM +0530, Pranjal Shrivastava wrote:
> > > Hi Daniel,
> > >
> > > On Wed, Nov 20, 2024 at 10:15 AM Daniel Mentz <danielmentz@google.com> wrote:
> > > >
> > > > On Tue, Nov 12, 2024 at 12:30 AM Pranjal Shrivastava <praan@google.com> wrote:
> > > > >
> > > > > Enhance the arm-smmu-v3 driver to parse out useful information from
> > > > > event records into a structure for better event handling & logging.
> > > >
> > > > Hi Pranjal,
> > > >
> > > > Thank you for putting this together.
> > > >
> > > > >
> > > > > Some sample events, powered by QEMU:
> > > >
> > > > > 4. Translation Fault:
> > > > >
> > > > > [    7.586428] arm-smmu-v3 arm-smmu-v3.0.auto: event 0x10 received:
> > > > > [    7.587012] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000800000010
> > > > > [    7.587504] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000020000000000
> > > > > [    7.587986] arm-smmu-v3 arm-smmu-v3.0.auto:  0x00000000fffff040
> > > > > [    7.588745] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000000000000
> > > > > [    7.589219] arm-smmu-v3 arm-smmu-v3.0.auto: Event 0x10 received: F_TRANSLATION
> > > > > [    7.589219]  client: 0000:00:01.0 sid: 0x8 ssid: 0x0
> > > > > [    7.589219]  iova 0xfffff040 ipa 0x0
> > > > > [    7.589219]  Unpriv | Data | Write | S1 | Input address caused fault
> > > > > [    7.589219]  STAG: 0x0
> > > >
> > > > I find that "Event 0x10" is redundant and recommend removing it. Maybe
> > > > print just "Event F_TRANSLATION"
> > >
> >
> > I agree, however, in the past reviews [1] we've been asked to keep the
> > existing log "as is" unless there's a particularly compelling reason.
> 
> I believe that feedback was about changing "event 0x%02x received:\n"
> to "event 0x%02x received: master %s:\n" on the line that immediately
> precedes the raw dump, but we're not changing that. What I am
> suggesting is to remove "Event 0x10 received:" from "Event 0x10
> received: F_TRANSLATION" and replace it with "event F_TRANSLATION"
> 

Ahh, apologies. I'll remove the event code from the pretty print.

> >
> > >
> > > >
> > > > Not printing the prefix "arm-smmu-v3 arm-smmu-v3.0.auto:" on
> > > > subsequent lines appears to be inconsistent with how the raw event
> > > > bits are dumped. Also, I typically run a command like "grep
> > > > 'arm-smmu-v3 arm-smmu-v3.0.auto' uart.log" while I'm developing smmu
> > > > driver code, and with the proposed change, the grep command wouldn't
> > > > print most of the event details, because they are not prefixed by
> > > > "arm-smmu-v3 arm-smmu-v3.0.auto"
> > >
> > > I see. The prefix isn't getting picked up because I'm trying to print
> > > all the lines in
> > > a single `dev_err` in order to avoid other logs inter-mingling with
> > > these ones. I can add
> > > that if we are okay with using multiple `dev_err` calls (i.e.
> > > potentially allowing other logs
> > > to mix-in).  Otherwise, let me see how we can manually add the dev_fmt
> > > string in the log.
> > >
> > > >
> > > > The words "client", "sid" and "ssid" are followed by a colon (":") but
> > > > iova and ipa are not.
> > > >
> > >
> > > Ack. Will fix that.
> > >
> > > > Can you put everything up to and including iova on the first line and
> > > > the rest on the second line?
> >
> > Finally my email client is fine.
> > Did you mean something like the following:
> > [    7.589219] arm-smmu-v3 arm-smmu-v3.0.auto: Event 0x10 received: F_TRANSLATION
> > [    7.589219] arm-smmu-v3 arm-smmu-v3.0.auto: client: 0000:00:01.0 sid: 0x8 ssid: 0x0 iova: 0xfffff040 ipa: 0x0
> > [    7.589219] arm-smmu-v3 arm-smmu-v3.0.auto: Unpriv | Data | Write | S1 | Input address caused fault | STAG: 0x0
> >
> 
> I was thinking about something like the following:
> 
> [    7.589219] arm-smmu-v3 arm-smmu-v3.0.auto: event F_TRANSLATION
> client: 0000:00:01.0 sid: 0x8 ssid: 0x0 iova: 0xfffff040 ipa: 0x0
> [    7.589219] arm-smmu-v3 arm-smmu-v3.0.auto: unpriv data write s1
> "Input address caused fault" stag: 0x0
> 

Ack. This might make the 1st line longer (the following is 133 columns):

[    7.589219] arm-smmu-v3 arm-smmu-v3.0.auto: event: F_TRANSLATION client: 0000:00:01.0 sid: 0x8 ssid: 0x0 iova: 0xfffff040 ipa: 0x0
[    7.589219] arm-smmu-v3 arm-smmu-v3.0.auto: unpriv data write s1 "Input address caused fault" stag: 0x0

Though, the worst case length would be something like:

[    7.589219] arm-smmu-v3 arm-smmu-v3.0.auto: event: F_TRANSLATION client: 0000:00:01.0 sid: 0x8 ssid: 0x0 iova: 0xfffff040 ipa: 0x0
[    7.589219] arm-smmu-v3 arm-smmu-v3.0.auto: unpriv data write s2 "Stage 1 translation table fetch" ttd_write stall stag: 0x0

I like this as well, provided the length would be fine?

> For sid, ssid, iova and ipa, you used all lowercase. I suggest
> extending this rule to Unpriv, Data, Write etc. and use lower case
> there as well. I'd remove the "|" characters to save space. I'm not
> sure how to represent the "Input address caused fault" part without
> the "|" characters to separate it from the rest. Maybe we can put it
> in double quotes.
> 

Also, if we wanna print everything in 2 lines along with the dev prefix,
I think we can do away with all the complex macro logic and have simply
two `dev_err`logs? Something like the attached below.

Thanks
Praan

------------------------------------------------->8------------------------------------------------

dev_err(smmu->dev, "Event received: %s client: %s sid: %#x ssid: %#x iova: %#x ipa: %#x",
	ARM_SMMU_EVT_NAME(evt), dev_name(evt->dev), evt->sid, evt->ssid, evt->iova, evt->ipa);

dev_err(smmu->dev, "%s %s %s %s %s %s %sSTAG: %#x",
	evt->privileged ? "priv" : "unpriv",
	evt->instruction ? "inst" : "data",
	evt->read ? "read" : "write",
	evt->s2 ? "s2" : "s1", event_class_str[evt->class],
	evt->class_tt ? (evt->ttrnw ? "ttd_read" : "ttd_write") : "",
	evt->stall ? "stall " : "", evt->stag);


