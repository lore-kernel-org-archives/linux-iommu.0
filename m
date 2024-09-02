Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C611865F6
	for <iommu@lists.linux.dev>; Mon,  2 Sep 2024 08:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725265411; cv=none; b=dkKjlcigAmghtPAF7htxrCb5TavExJXN38BmG7nYnSiyOFQZM6sXmBBp6AISAId577flzefavq864mrrLaopnJbsYrynwiM9riaC+SfcP6yr27jz7Evj/zqKj8bJxYN4EM4DBGRVX8NXePS8uUxexRC7ho7fK0K6dThZFi2uZAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725265411; c=relaxed/simple;
	bh=0ZHN2BNHYBFFyrBc8JWQcVHYZ4eY8jvvzzthorD4Pws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGoVEhXCaPhSi8HcQa/twrA6xjGfmaW46zfJUO4/Tdm6+AKw4Wo5clzpL75YCkSlq25KV74tGftldXnxRx9bMfdRcNiAFofJB8rM0cV+sKgMguCjDJRXffTU8Fta3JnhLURir/9R18EkuwvW7GEsE48qMsA+KgU/KinwS7tDgUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XeSQjXHT; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XeSQjXHT"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2056aa5cefcso159875ad.0
        for <iommu@lists.linux.dev>; Mon, 02 Sep 2024 01:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725265409; x=1725870209; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uFuIHUJblGALZ4+TeWei5Wh4QxNqB1CwHIXZGRjEDCc=;
        b=XeSQjXHTeVjvWXV0hz01+OiO8p8rU+ewrQnTSQjY0SlB5bigYPLPzDGjVZoF/ogkqz
         4avxbsn6qcTkvhy6zy+RmWXuz1YIy9oZwvNhwY5DF2wKE5Ymm/4Ajqtxh/x2cHXGkIGe
         E9wny3Jal93+tuXlYsDt+m+DONpt1OGGMaD0Yiv00ioNHoG1b0lq513sesN95U2xCYBj
         9DUzlqSmOQzBhqeQbXtTam0MG21yzcZzjtiRYUKTvDk1ELGcPijUBlevx3DtdkISfMbb
         DKRUcxn5lJWAtfqpMU48ZfD2lf/IkBXOJscVRID+/6smMsfXb4bMr6VgJzoMz5jRoxVJ
         XASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725265409; x=1725870209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFuIHUJblGALZ4+TeWei5Wh4QxNqB1CwHIXZGRjEDCc=;
        b=wiD3zsbgOgbQU8gfVhcVMUK1+1Z2zb6JNAAw72rcMvbI3NW8hsVpc/ND/C25s/NJYX
         2w15HN5aZNJr9OVM/srCxTCT6kwBa0h+4CXmySGgrZhw5Gl6Qy5VNuDEy6m+DfRhow87
         Fn4yE1xg+AOWfyVga/oYytHfrIifv34hYpWGxo2lByJXDml0jLcCxLP2PZWqQ5FdGnci
         Nu+XGmHIepvUguxT4TewIrc2a1cOAmc6F5iOlLj6yKJXIr4op22UkYkuxfg5Vb5MaFbJ
         4sCaURlLvsBhZ8MfRzZA4ltZvvVIyWOnE8By8RRKSwyygXk1wo7vvcTSTG8/r/tg5rLQ
         TCnw==
X-Forwarded-Encrypted: i=1; AJvYcCV4Nwhf6YZuGZF5oX1+On6QYZuHSocpHdXI+RaZw1uGzqLlGfUSPXPlMcSivVp3xBVcafRHGw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzHAz0CZ/Fk0G2gInysrSqxet+4pYZslgkCg75bEh6KgpKFqx6s
	mFDvvbJ+4l051XkNamUmXLLOj0EjbrRbijJW6OvqRVpAL+ylBa9aL22G0t4j7Lu7QTDBV3RihNZ
	DyA==
X-Google-Smtp-Source: AGHT+IGeFGayJBpJYej7aNKadQM0NLxlpEY55q96hyQwYbiaFzLlo2ZAaOoo/oUUlwAe1e1HHPpIOw==
X-Received: by 2002:a17:903:1250:b0:1f4:95dc:bc61 with SMTP id d9443c01a7336-205495a9cb8mr3429245ad.15.1725265408337;
        Mon, 02 Sep 2024 01:23:28 -0700 (PDT)
Received: from google.com (202.141.197.35.bc.googleusercontent.com. [35.197.141.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205f6d30bb6sm443355ad.211.2024.09.02.01.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 01:23:27 -0700 (PDT)
Date: Mon, 2 Sep 2024 08:23:20 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH v2 1/2] iommu/arm-smmu-v3: Print better events records
Message-ID: <ZtV1-IL8AZu--jGp@google.com>
References: <20240827193026.3993039-1-praan@google.com>
 <20240827193026.3993039-2-praan@google.com>
 <ZtAW0hVPFD6JbLTL@Asurada-Nvidia>
 <ZtEKMknbGaD9q170@google.com>
 <ZtEkUQ7tI3Nb0NOc@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtEkUQ7tI3Nb0NOc@Asurada-Nvidia>

On Thu, Aug 29, 2024 at 06:45:53PM -0700, Nicolin Chen wrote:
> On Thu, Aug 29, 2024 at 11:54:26PM +0000, Pranjal Shrivastava wrote:
> 
> > > > +static const char * const class_str[] = {
> > > > +       [0] = "CD",
> > > > +       [1] = "TTD",
> > > > +       [2] = "IN",
> > > > +       [3] = "RES",
> > > > +};
> > >
> > > Unlike the event IDs, these class code names are still uneasy to
> > > read. Though it'd result in a print-format change, yet could we
> > > simply dump full strings instead?
> > >
> > 
> > By "full strings" do you mean "CD => CD Fetch" as mentioned in the spec?
> 
> Yes.

Ack. So, just for confirmation we want the following 4 class strings:
"CD Fetch"
"Stage 1 translation table fetch"
"Input address caused fault"
"Reserved"

Right?

> 
> > > > +static void arm_smmu_get_evt_info(struct arm_smmu_device *smmu, u64 *evt,
> > > > +                                 struct arm_smmu_event *event)
> > > > +{
> > > > +       /* Pick out the good stuff */
> > > > +       event->id = FIELD_GET(EVTQ_0_ID, evt[0]);
> > > > +       event->sid = FIELD_GET(EVTQ_0_SID, evt[0]);
> > > > +       event->ssid_valid = evt[0] & EVTQ_0_SSV;
> > > > +       event->ssid = event->ssid_valid ? FIELD_GET(EVTQ_0_SSID, evt[0]) : IOMMU_NO_PASID;
> > > > +       event->class = FIELD_GET(EVTQ_1_CLASS, evt[1]);
> > > > +       event->iova = FIELD_GET(EVTQ_2_ADDR, evt[2]);
> > > > +       event->ipa = FIELD_GET(EVTQ_3_IPA, evt[3]);
> > > > +       event->privileged = FIELD_GET(EVTQ_1_PnU, evt[1]);
> > > > +       event->instruction = FIELD_GET(EVTQ_1_InD, evt[1]);
> > > > +       event->stage = FIELD_GET(EVTQ_1_S2, evt[1]);
> > > > +       event->read = FIELD_GET(EVTQ_1_RnW, evt[1]);
> > > > +       event->raw = evt;
> > >
> > > Maybe we could define struct arm_smmu_event in this way:
> > >
> > > +struct arm_smmu_event {
> > > +     union {
> > > +             u64 evt[4];
> > > +             struct {
> > > +                     /* Bit 0:63 */
> > > +                     u64 id : 8;
> > > +                     u64 _res0 : 3;
> > > +                     u64 ssv : 1;
> > > +                     u64 ssid : 20;
> > > +                     u64 sid : 32;
> > > +                     /* Bit 64:127 */
> > > +                     u64 stag : 16;
> > > +                     u64 _res1 : 15;
> > > +                     u64 stall : 1;
> > > +                     u64 _res2 : 1;
> > > +                     u64 pnu : 1;
> > > +                     u64 ind : 1;
> > > +                     u64 rnw : 1;
> > > +                     u64 _res3 : 2;
> > > +                     u64 nsipa : 1;
> > > +                     u64 s2 : 1;
> > > +                     u64 class : 2;
> > > +                     u64 _res4 : 6;
> > > +                     u64 impl_def : 16;
> > > +                     /* Bit 128:191 */
> > > +                     u64 inputaddr;
> > > +                     /* Bit 192:255 */
> > > +                     u64 _res5 : 12;
> > > +                     u64 ipa : 40;
> > > +                     u64 _res6 : 12;
> > > +             } f_trans;
> > > +             /* FIXME Add other event structs */
> > > +     };
> > > +};
> > >
> > > Then, event would be just:
> > > +             struct arm_smmu_event *event = (struct arm_smmu_event *)evt;
> > >
> > > Not sure if Will would like this though...
> > 
> > Yea, I thought about this too but I felt that it'd bloat up the code
> > for every new event that's introduced.
> 
> That'd be in the header. The IRQ Handler would be always clean
> and fast.
> 
> > Also, the printing would become
> > more complicated as we'd have to log different fields for different
> > events. Additionally, I don't see that many unions being defined
> > elsewhere in the kernel.
> 
> OK. That's a fair point. I think we could have just one common
> union for the "good stuff" fields. Then, if something isn't in
> the common union, do a FIELD_GET(raw)?
> 

I'm not sure if I get this right, but are you suggesting something like:

+struct arm_smmu_event {
+	union {
+	u64 raw_evt[4];
+	struct {
+		/* "Good stuff" fields */
+	};
+};

and then based on the fault type we can use the "good stuff" or raw_evt?
So, basically just add a union between raw_evt and the other fields to
improve struct arm_smmu_event present in v2?

> > > > +       mutex_lock(&smmu->streams_mutex);
> > > > +       event->master = arm_smmu_find_master(smmu, event->sid);
> > > > +       mutex_unlock(&smmu->streams_mutex);
> > >
> > > Same as I pointed out at the other patch, "master" is unprotected
> > > after the unlock. It can unlikely-yet-still-possibly race against
> > > arm_smmu_release_device.
> > >
> > 
> > Hmm.. are you suggesting that the `master` could've been removed by the
> > arm_smmu_release_device while we access it in an event handler?
> > 
> > As in, something like the following situation:
> > 
> > 1. The evtq_thread gets scheduled
> > 2. arm_smmu_release_device removes the `master` & its streams
> > 3. In the `handle_evt` we dereference `master` which has been `kfree`ed
> >    (also, we don't return -EINVAL like we ideally should)
> > 
> > In that case, I think I should add back the `arm_smmu_find_master` to
> > the `arm_smmu_handle_evt` along with the locks. Nice catch! :)
> 
> Probably could lock the entire iteration, master pointer could
> be then passed in safely between the helper functions.

I'm just wondering if that'd be too much to print the "master_name", I
mean what if we simply save the master_name in `struct arm_smmu_event`?
That way, we can keep the locking as is in `arm_smmu_handle_evt` and
simply print the stored "master_name".

Note: I'm suggesting to store the entire string and not just the ptr
returned by dev_name(master->dev)), something like: 

`strcpy(event->master_name, dev_name(master->dev))`

> 
> > > And it'd feel clearer to have an "ssid". And perhaps adding commas
> > > to separate them too.
> > 
> > I referred to the log in `arm_smmu_handle_ppr` for the sid.ssid format.
> > If we'd prefer a separate "ssid", should we change the one in ppr too?
> > LMK, what you and Will think about that?
> 
> Didn't realize arm_smmu_handle_ppr does that. It's fine to keep
> the format in that way then.

Ack.

> 
> > > > +                       evts[event->id], event->master_name, event->sid, event->ssid);
> > > > +       dev_err(smmu->dev, "\tiova = %#llx ipa = %#llx (%s%s%s%s%s%s)\n", event->iova, event->ipa,
> > > > +                   event->privileged ? "Priv " : "Unpriv ",
> > > > +                   event->instruction ? "Inst " : "Data ",
> > > > +                   event->read ? "Read " : "Write ",
> > > > +                   event->stage ? "S2 " : "S1 ", class_str[event->class],
> > > > +                   ((event->id == EVT_ID_PERMISSION_FAULT) && (event->class == EVTQ_1_CLASS_TT)) ?
> > > > +                   (FIELD_GET(EVTQ_1_TT_READ, event->raw[1]) ? " TTD Read" : " TTD Write")
> > > > +                   : "");
> > >
> > > Indentation should follow the existing printk() in this driver. And
> > 
> > I'm sorry but I'm not sure if I understand what is meant by "the
> > existing printk indentation in this driver", do you mean aligning the
> > next line with the opening brace? For example:
> > 
> >         dev_err(smmu->dev,
> >                 "failed to allocate queue (0x%zx
> >                 bytes) for %s\n",
> >                 qsz, name);
> 
> Yea, just to keep the same coding style, line wrapping can still
> happen to 80 characters in general though.
> 

Ack.

> > > those ternary operators at the last field(s?) are hard to ready..
> > >
> > 
> > Hmm, I wanted the last fields to be printed only when the fault was
> > F_PERMISSION, in the same log. Any suggestions on what might make it
> > easier to read? Some helpful comments around it? Something else?
> 
> With an "other" string, we could sprintf on conditions inside the
> "case F_PERMISSION:".
> 

Ohh alright, basically we append something extra in the "other" string
for `F_PERMISSION`. Got it.

> > > > +static void arm_smmu_dump_fetch_fault(struct arm_smmu_device *smmu,
> > > > +                                     struct arm_smmu_event *event)
> > > > +{
> > > > +       dev_err(smmu->dev, "Bad fetch: %s client %s sid 0x%08x.0x%05x: fetch addr = %#llx\n",
> > > > +                       evts[event->id], event->master_name, event->sid, event->ssid, event->ipa);
> > >
> > > Actually, the "Fault", "Bad fetch", and "Bad smmu config" doesn't
> > > feel very necessary, since we prints the event string already.
> > >
> > 
> > That makes sense, I'll remove those in a follow up patch.
> > Although, I guess we should still say "fault" somewhere to hint folks
> > without arm-smmu-v3 knowledge that the event wasn't normal operation.
> > 
> > LMK what you think? I've had a few interactions where clients tend to
> > ignore the current "event received" dump considering that to be a part
> > of normal SMMU operation.
> 
> Well, we could improve the event_str with human-readable ones:
> 	s/F_TRANSLATION/Translation\ Fault
> 

Yea, but I'd still want to see a "spec searchable" name for the fault.
Maybe we can have "Unexpected event recieved:<spec_fault_name>" in the
"title" string?

> > > > +}
> > > > +
> > > > +static void arm_smmu_dump_raw_event(struct arm_smmu_device *smmu,
> > > > +                                   struct arm_smmu_event *event)
> > > > +{
> > > > +       int i;
> > > > +
> > > > +       dev_err(smmu->dev, "event 0x%02x received: client %s:\n", event->id, event->master_name);
> > >
> > > Looks like it would print another title that's sorta duplicated to
> > > other dump functions yet less informative?
> > >
> > 
> > Yea, I didn't wanna break backward compatibility, people might have
> > tools to parse out the existing dump, lol!
> >
> > On a serious note, I believe it'd be better to print this as some
> > implmentations might have some "IMPLEMENTATION DEFINED" fields which
> > people might be interested to look at.
> > 
> > Although, we can dump the raw event only in the `default` case, i.e.
> > when we don't have a dumper function for that particular event ID but
> > that might still avoid printing the IMPL_DEFINED fields in fetch faults
> 
> Makes sense to me by having a different title for the default case.
> 

Ack, we can have a different title for the default case. However, on a
second thought, I believe we should log the "raw" event in all cases,
since we aren't printing all the fields anyway. For example, for
F_TRANSLATION we don't print IMPL_DEF fields, NSIPA etc. It might be 
helpful to see the raw event even for the "non-default" cases.

> > > > +       for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
> > > > +               dev_err(smmu->dev, "\t0x%016llx\n",
> > > > +                        (unsigned long long)event->raw[i]);
> > > > +}
> > > > +
> > > > +static void arm_smmu_dump_event(struct arm_smmu_device *smmu,
> > > > +    
> > 
> > I thought about something similar as well, but then referred to Robin's
> > comments on [1]. Also, printing strings in 3 different `dev_err` logs
> > could result in interruptions from other logs in dmesg, I'd prefer to
> 
> Ack.
> 
> > see the entire log in a single `dev_err` for ease. Although, I think we
> > should be able to do something like the following to achieve that:
> >         ...
> > 
> >         dev_err(%s %s %s, strlen(title) ? title : ""
> >                 strlen(addrs) ? addrs : ""
> >                 strlen(other) ? other : ""
> 
> That is fine, though should break the lines too. Maybe:
> 	dev_err(smmu->dev, "%s%s%s%s%s\n", title,
> 		strlen(addrs) ? "\n" : "", addrs,
> 		strlen(other) ? "\n" : "", other);
> ?
> 

I'd like line-feeds too, but I'm unsure if that could cause dmesg log
interruptions? I assume adding a "\n" flushes the console buffer, i.e.
we might get interrupted logs (I maybe wrong here).

> > 
> >         for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
> >                 dev_err(smmu->dev, "\t0x%016llx\n", event->evt[i]);
> 
> Maybe merge the four dev_err iterations too?

Ack.

> 
> Nicolin

Thanks,
Pranjal
