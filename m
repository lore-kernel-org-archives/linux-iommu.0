Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFFD4AEF5
	for <iommu@lists.linux.dev>; Thu,  5 Sep 2024 16:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725552404; cv=none; b=sDTP8YRoM6xbZyiEWLTGi+hr1mGOcBE/LLUS1SSkIyHlpOkmErtCWerIqk072qSuRzBNkKcvNmQiISRYqP8tRKR/LrNELdV9Rxgx+lmEe6M9RkqLRkkdnXQH7A083NThmyU9w87O1SsbwPMhXbT58967TQFVWTPXxOdvs9x13fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725552404; c=relaxed/simple;
	bh=06f2z3YWOXnCV6KDNAI1EHdlH88PSFaLdb30+6TtAKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/6fFDO39qcMjRM3eluE4YoH/ACG/nIoH8l4YiND+Eb2SKvQyQ/Jo5dhsdPKMhDoMs8XaJrb3SxD5NxZVbVBRE70iElisOLKifnxHg74feoMp0MaJ8VaYXXwzTMqO0k8SoxZeTbBYkCA79QVrNIHfHeJ91vGxXJKQ4jxlhmWG9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F9oR0amf; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F9oR0amf"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20546b8e754so248995ad.1
        for <iommu@lists.linux.dev>; Thu, 05 Sep 2024 09:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725552401; x=1726157201; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Uuf1DXGf38xZCtdCxBraq1atf4CT+75BadBjIhqd5w=;
        b=F9oR0amfRFLSshc7yrOOJeg7Q2aKed4VsL/VEmw/ysZ+14yOPrQbWCjaHo0fvNxI3N
         zWFxqxp94s66inHC3CTEhM0UOrpLHRnBUVM1rEyB5/ex1JnHvkYRYbDXlF0iuUsJ2iwZ
         9bDA4CpCY5hmPP93k42myjlff/qbIOmb+xhOQ/om/HSjpl7BvyFj0WSpc5IHjmrULJDT
         vOkVTWHFCOF4d0Iw5b4yn0rQpqFri7961Mr/BwK+pb76Q4aOvKzBYxz97Lr06FKyDjxE
         +2IjPegG/GnJ8N7HmnqlivbVVHhOkpah4pxP8TtMvlca9v2kbSwsxv6PZXp72uGQcBCG
         kTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725552401; x=1726157201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Uuf1DXGf38xZCtdCxBraq1atf4CT+75BadBjIhqd5w=;
        b=deInyuH43evDW326O5WEXCmjKEH9N/pJvxcL5p7Wp9GNm5w8ztBMSragQg4AKZUq4B
         xW9znJbIa4+BLuoQt9Aiq0Jv6uEvsVxgAFGfPlA5mrLY026YkTG1UbUXE0B/obP0C8tg
         Jaqmam1djVS0eqCiICjasv5rN+m4v4oILGV779mGWwnUeasdNw5LNT209W2VDW89ajCw
         glJ/cKSpS7bz/wXjYghyREVB62dl980NT2NSnnPIr8MitrkzsBeqGtgB5L8MmFHpNDWn
         8dq4Z8FtYpDMkprvGZ1DtmhtoFBhwHE86LxMa4Ak7fVklbNNhB7doh/PUksQlC7tXBz7
         bjcw==
X-Forwarded-Encrypted: i=1; AJvYcCWfpSt5zgBB2CFje6CPZsk8Qa0FPYMcCDBtfbIWVAEf/LgIEe7jIdj6OSbR5U8mOYzSUUGLaA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxNl2hRcYJG+ktj2LAUffG9fxkjGhe9nJzrTHtE3HCUzZrhCKl2
	bKlV7QAhsc2xgWob5n6NElWGrjPhkRbDgxtAcKJrce+JScPQQHhJ/K0ccKjs765oA4nqynTF3mr
	OWA==
X-Google-Smtp-Source: AGHT+IGWy13DxvLS8K17pmxDGUBkxFXcjzvU8RO/2RKiwpAO7/OxStb99Fys+L7g5ZVeJZqwWhsmEQ==
X-Received: by 2002:a17:903:234d:b0:206:bf6e:6001 with SMTP id d9443c01a7336-206d37adc8bmr3157705ad.17.1725552399349;
        Thu, 05 Sep 2024 09:06:39 -0700 (PDT)
Received: from google.com (202.141.197.35.bc.googleusercontent.com. [35.197.141.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-717785b4b4bsm3389215b3a.199.2024.09.05.09.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 09:06:38 -0700 (PDT)
Date: Thu, 5 Sep 2024 16:06:24 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH v2 1/2] iommu/arm-smmu-v3: Print better events records
Message-ID: <ZtnXADX3b6qdqVs0@google.com>
References: <20240827193026.3993039-1-praan@google.com>
 <20240827193026.3993039-2-praan@google.com>
 <ZtAW0hVPFD6JbLTL@Asurada-Nvidia>
 <ZtEKMknbGaD9q170@google.com>
 <ZtEkUQ7tI3Nb0NOc@Asurada-Nvidia>
 <ZtV1-IL8AZu--jGp@google.com>
 <ZtZEFKnKasX6433r@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtZEFKnKasX6433r@Asurada-Nvidia>

On Mon, Sep 02, 2024 at 04:02:44PM -0700, Nicolin Chen wrote:
> On Mon, Sep 02, 2024 at 08:23:20AM +0000, Pranjal Shrivastava wrote:
> 
> > On Thu, Aug 29, 2024 at 06:45:53PM -0700, Nicolin Chen wrote:
> > > On Thu, Aug 29, 2024 at 11:54:26PM +0000, Pranjal Shrivastava wrote:
> > >
> > > > > > +static const char * const class_str[] = {
> > > > > > +       [0] = "CD",
> > > > > > +       [1] = "TTD",
> > > > > > +       [2] = "IN",
> > > > > > +       [3] = "RES",
> > > > > > +};
> > > > >
> > > > > Unlike the event IDs, these class code names are still uneasy to
> > > > > read. Though it'd result in a print-format change, yet could we
> > > > > simply dump full strings instead?
> > > > >
> > > >
> > > > By "full strings" do you mean "CD => CD Fetch" as mentioned in the spec?
> > >
> > > Yes.
> > 
> > Ack. So, just for confirmation we want the following 4 class strings:
> > "CD Fetch"
> > "Stage 1 translation table fetch"
> > "Input address caused fault"
> > "Reserved"
> > 
> > Right?
> 
> Yes. I know they are longer, but more readable. So, you might want
> to arrange the output format to present them nicely.
> 

Ack, thanks for confirming!

> > > > Also, the printing would become
> > > > more complicated as we'd have to log different fields for different
> > > > events. Additionally, I don't see that many unions being defined
> > > > elsewhere in the kernel.
> > >
> > > OK. That's a fair point. I think we could have just one common
> > > union for the "good stuff" fields. Then, if something isn't in
> > > the common union, do a FIELD_GET(raw)?
> > >
> > 
> > I'm not sure if I get this right, but are you suggesting something like:
> > 
> > +struct arm_smmu_event {
> > +       union {
> > +       u64 raw_evt[4];
> > +       struct {
> > +               /* "Good stuff" fields */
> > +       };
> > +};
> > 
> > and then based on the fault type we can use the "good stuff" or raw_evt?
> > So, basically just add a union between raw_evt and the other fields to
> > improve struct arm_smmu_event present in v2?
> 
> Yea, I attached a test code at the EOM for your reference. Please
> feel free to drop fields if they aren't common enough, and confirm
> those bits are correctly written too.
> 

Hmm, so you're suggesting to make the event a union instead of a struct
thus, making reading event fields easy.

The only thing I'm slightly worried about is if the bitfields don't
remain constant if more events are added in the future.

For example, the "IPA" field is in dword[3] for now, but if it changes
in the future, it may get difficult to scale the union for future events
If we can guarantee that it doesn't happen then I think union is better.

Will, do you have any suggestions here?

> > > > > > +       mutex_lock(&smmu->streams_mutex);
> > > > > > +       event->master = arm_smmu_find_master(smmu, event->sid);
> > > > > > +       mutex_unlock(&smmu->streams_mutex);
> > > > >
> > > > > Same as I pointed out at the other patch, "master" is unprotected
> > > > > after the unlock. It can unlikely-yet-still-possibly race against
> > > > > arm_smmu_release_device.
> > > > >
> > > >
> > > > Hmm.. are you suggesting that the `master` could've been removed by the
> > > > arm_smmu_release_device while we access it in an event handler?
> > > >
> > > > As in, something like the following situation:
> > > >
> > > > 1. The evtq_thread gets scheduled
> > > > 2. arm_smmu_release_device removes the `master` & its streams
> > > > 3. In the `handle_evt` we dereference `master` which has been `kfree`ed
> > > >    (also, we don't return -EINVAL like we ideally should)
> > > >
> > > > In that case, I think I should add back the `arm_smmu_find_master` to
> > > > the `arm_smmu_handle_evt` along with the locks. Nice catch! :)
> > >
> > > Probably could lock the entire iteration, master pointer could
> > > be then passed in safely between the helper functions.
> > 
> > I'm just wondering if that'd be too much to print the "master_name", I
> > mean what if we simply save the master_name in `struct arm_smmu_event`?
> > That way, we can keep the locking as is in `arm_smmu_handle_evt` and
> > simply print the stored "master_name".
> > 
> > Note: I'm suggesting to store the entire string and not just the ptr
> > returned by dev_name(master->dev)), something like:
> > 
> > `strcpy(event->master_name, dev_name(master->dev))`
> 
> I'd probably move the dump() call inside arm_smmu_handle_evt(), and
> within the lock to avoid strcpy. And eventually it would be located
> at "else { /* Unhandled events should be pinned */ ret = -EFAULT; }:
> https://lore.kernel.org/linux-iommu/8b93be1d913f9e227748de2d07e8540ddc2372ab.1724777091.git.nicolinc@nvidia.com/
> 

I think we'll still need to dump the event for other cases, such as the
case where the master wasn't found, we return `-EINVAL` and the case
where EVTQ_1_S2 is set. I guess, we should have a case under the label
`out_unlock` we can call the dump function based on the ret value. E.g.:

out_unlock:
+	if (ret)
+		arm_smmu_dump_event(smmu, evt);
 	mutex_unlock(&smmu->streams_mutex);
 	return ret;

> > > > > Actually, the "Fault", "Bad fetch", and "Bad smmu config" doesn't
> > > > > feel very necessary, since we prints the event string already.
> > > > >
> > > >
> > > > That makes sense, I'll remove those in a follow up patch.
> > > > Although, I guess we should still say "fault" somewhere to hint folks
> > > > without arm-smmu-v3 knowledge that the event wasn't normal operation.
> > > >
> > > > LMK what you think? I've had a few interactions where clients tend to
> > > > ignore the current "event received" dump considering that to be a part
> > > > of normal SMMU operation.
> > >
> > > Well, we could improve the event_str with human-readable ones:
> > >       s/F_TRANSLATION/Translation\ Fault
> > >
> > 
> > Yea, but I'd still want to see a "spec searchable" name for the fault.
> > Maybe we can have "Unexpected event recieved:<spec_fault_name>" in the
> > "title" string?
> 
> That looks good to me.
> 

Ack.

> > > > Although, we can dump the raw event only in the `default` case, i.e.
> > > > when we don't have a dumper function for that particular event ID but
> > > > that might still avoid printing the IMPL_DEFINED fields in fetch faults
> > >
> > > Makes sense to me by having a different title for the default case.
> > >
> > 
> > Ack, we can have a different title for the default case. However, on a
> > second thought, I believe we should log the "raw" event in all cases,
> > since we aren't printing all the fields anyway. For example, for
> > F_TRANSLATION we don't print IMPL_DEF fields, NSIPA etc. It might be
> > helpful to see the raw event even for the "non-default" cases.
> 
> That makes sense. I'd dump the raw dwords outside the switch-case,
> i.e. in the common path.
> 

Ack. I'd dump the raw dwords outside the switch-case in v3.

> > > That is fine, though should break the lines too. Maybe:
> > >       dev_err(smmu->dev, "%s%s%s%s%s\n", title,
> > >               strlen(addrs) ? "\n" : "", addrs,
> > >               strlen(other) ? "\n" : "", other);
> > > ?
> > >
> > 
> > I'd like line-feeds too, but I'm unsure if that could cause dmesg log
> > interruptions? I assume adding a "\n" flushes the console buffer, i.e.
> > we might get interrupted logs (I maybe wrong here).
> 
> I think the console_lock is grabbed per printk call, not per "\n".

Ahh okay! I took the opportunity to read up the printk implementation.
I see the `vprintk_store` stores a single log as a unit in the buffer,
and the `console_unlock` actually flushes it out to the console. That
said, I think nothing (other than hard IRQs printing logs) should cause
interleaving between the log. Interesting stuff!

> 
> Thanks
> Nicolin

Thanks,
Pranjal
