Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B993818991C
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 23:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724975677; cv=none; b=LzYPAtl6IX9gvPxo0JznujHzRkdalaK0xF465fYrAlZ7X2UVzDw27iSazIvRC9NjUVoHdo7OpH6XIbYo4sh5hDZ2Im5XuW1RrdTAknOuLJHs5zNPMm87v+8JdCfGZ94EpePmyfh4BUMtKEOJy6nBrKAwSo1GilbB6EQXy/qEMrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724975677; c=relaxed/simple;
	bh=HUuc23I/QH9KzDBkBxcAiKY9JJEzIyafG8tosmYfCxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKWekjEMYWfEA+Ur92fsiaPAIYBOMxdQsTyEPJM/LqbOQKmmF5txps1pNmbrzbNFpuu4yYcLdrgQH7/XqwLZna/5Edr8O9sXVunu8pHZMWLlfaNxt+vBoHnGjmo9jScpmdp//iOeJbaJ3c+OgWGQaMQdN6qZgZdBvA4Rq9fSzBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3e7OZwc9; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3e7OZwc9"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-202018541afso50925ad.1
        for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 16:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724975675; x=1725580475; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ge4/5mRfM2hHbGcZxNEoskkxEOLD5n6rhL/4y25lQw0=;
        b=3e7OZwc9FFpa5NjsN7yHH1/bRBeuPIzGiKyy5tsO3QFwhDV4aKuhIyXNrULbpI8tii
         sD8fzMnZ/ToqGHDvHjVNSDcpazgseRYg5tOk/EtkpF4Z5eClvZcdNct4soy/n4QjeN1N
         ac9Y2PMJIEWYFsa06SFkfVCPtywM9ZDCJg07qdUVX8w9MxBF+2EP6b3CEPunW3Ud5zey
         S8jtPvFuZ95eSVZ7oTkIezoizJiC5NJJrhD1b24+1uVLmMhFITbM/pCe1irQ+EcZMMFT
         /9RjdeMGnLRfcSTMfCppNwoSv/htW/FYBMgUFRK+rU49/+GllQGawvJT0cXEIkeFm7AT
         h9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724975675; x=1725580475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ge4/5mRfM2hHbGcZxNEoskkxEOLD5n6rhL/4y25lQw0=;
        b=ftufrk1zvJMP79kFufbnzyqnj/Qh893iihBwDQotxzEWGE+JC17SLosMWRIVx1IuI0
         tNnuRh7aLdXMnoVk5G/C7wQhc/f8jhBzPdwGjygQUVMGxVIZmrBGf0tJ++7vFLlYcwTX
         NekGlKh7zKjWeS3Zx0VlWn6Bz7EA/GPEnVrL/7YzSQj201kTZc3fNJxXQrMlGlJ/pRRA
         QbdMJNZAk3FUireOSLP/JNGoFvfVDvGx6DPtg3Kh5DpH/k7aPmA0IFkzkBDrKcVByDpV
         TZMuc9kPziSrOu7jbHr2ZBmiv4qD/Z74ghMRyKWrUsEp8ffv/m8pYaKQ9mapZTCf0Ee0
         IjHg==
X-Forwarded-Encrypted: i=1; AJvYcCUCjUJaW1Xy07i61dwCBF8XXAqC5vR4a5o3Gp1H3av39pJ6oIuN1j4huGsq3yCmLZPMwdijXg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyYIaf+NCgDB4BPJKXb7OStgGzxthoavz+5gmXdzJTGuxdOY+K8
	R4vHOxWPSCK/QYOeKVuSKicq6qrL2NAc4eqsei4HyZlID/LlTvjW70AhnPiPPg==
X-Google-Smtp-Source: AGHT+IFaLrKeXbQ0epsyT/cncb9jFc9JXOvO7JvFrMwiUirx/h/13BQnWoqDbhPYHs56EFsbhc0jgg==
X-Received: by 2002:a17:902:e801:b0:1fe:d7da:cd22 with SMTP id d9443c01a7336-20528817c64mr580785ad.29.1724975674645;
        Thu, 29 Aug 2024 16:54:34 -0700 (PDT)
Received: from google.com (202.141.197.35.bc.googleusercontent.com. [35.197.141.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152cedb9sm16614315ad.79.2024.08.29.16.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 16:54:34 -0700 (PDT)
Date: Thu, 29 Aug 2024 23:54:26 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH v2 1/2] iommu/arm-smmu-v3: Print better events records
Message-ID: <ZtEKMknbGaD9q170@google.com>
References: <20240827193026.3993039-1-praan@google.com>
 <20240827193026.3993039-2-praan@google.com>
 <ZtAW0hVPFD6JbLTL@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtAW0hVPFD6JbLTL@Asurada-Nvidia>

On Wed, Aug 28, 2024 at 11:36:02PM -0700, Nicolin Chen wrote:
Hi Nicolin,
> Hi Pranjal,
> 
> The prints would be very helpful for debugging. Thanks for the
> patch!
> 
> I have some personally thoughts here, so hopefully we can make
> it cleaner and more readable.
> 
> On Tue, Aug 27, 2024 at 12:30:25PM -0700, Pranjal Shrivastava wrote:
> 
> > +static const char * const evts[] = {
> 
> s/evts/event_str
> 

Ack, would change that in the follow up patch.

> > +       /* Bad config events */
> > +       [EVT_ID_BAD_SID_CONFIG] = "C_BAD_STREAMID",
> > +       [EVT_ID_BAD_STE_CONFIG] = "C_BAD_STE",
> > +       [EVT_ID_BAD_CD_CONFIG] = "C_BAD_CD",
> > +       [EVT_ID_BAD_SSID_CONFIG] = "C_BAD_SUBSTREAMID",
> > +       [EVT_ID_STREAM_DISABLED] = "F_STREAM_DISABLED",
> > +
> > +       /* Bad translation events */
> > +       [EVT_ID_TRANSLATION_FAULT] = "F_TRANSLATION",
> > +       [EVT_ID_ADDR_SIZE_FAULT] = "F_ADDR_SIZE",
> > +       [EVT_ID_ACCESS_FAULT] = "F_ACCESS",
> > +       [EVT_ID_PERMISSION_FAULT] = "F_PERMISSION",
> > +
> > +       /* Bad fetch events */
> > +       [EVT_ID_STE_FETCH_FAULT] = "F_STE_FETCH",
> > +       [EVT_ID_CD_FETCH_FAULT] = "F_CD_FETCH",
> > +       [EVT_ID_VMS_FETCH_FAULT] = "F_VMS_FAULT"
> > +};
> > +
> > +static const char * const class_str[] = {
> > +       [0] = "CD",
> > +       [1] = "TTD",
> > +       [2] = "IN",
> > +       [3] = "RES",
> > +};
> 
> Unlike the event IDs, these class code names are still uneasy to
> read. Though it'd result in a print-format change, yet could we
> simply dump full strings instead?
> 

By "full strings" do you mean "CD => CD Fetch" as mentioned in the spec?
Or do you mean "Context Descriptor", "Translation Table Desc" etc.? I'm
afraid that the latter would make the printed string much longer.
Although, I wouldn't mind doing that if we have consensus.

> > +static void arm_smmu_get_evt_info(struct arm_smmu_device *smmu, u64 *evt,
> > +                                 struct arm_smmu_event *event)
> > +{
> > +       /* Pick out the good stuff */
> > +       event->id = FIELD_GET(EVTQ_0_ID, evt[0]);
> > +       event->sid = FIELD_GET(EVTQ_0_SID, evt[0]);
> > +       event->ssid_valid = evt[0] & EVTQ_0_SSV;
> > +       event->ssid = event->ssid_valid ? FIELD_GET(EVTQ_0_SSID, evt[0]) : IOMMU_NO_PASID;
> > +       event->class = FIELD_GET(EVTQ_1_CLASS, evt[1]);
> > +       event->iova = FIELD_GET(EVTQ_2_ADDR, evt[2]);
> > +       event->ipa = FIELD_GET(EVTQ_3_IPA, evt[3]);
> > +       event->privileged = FIELD_GET(EVTQ_1_PnU, evt[1]);
> > +       event->instruction = FIELD_GET(EVTQ_1_InD, evt[1]);
> > +       event->stage = FIELD_GET(EVTQ_1_S2, evt[1]);
> > +       event->read = FIELD_GET(EVTQ_1_RnW, evt[1]);
> > +       event->raw = evt;
> 
> Maybe we could define struct arm_smmu_event in this way:
> 
> +struct arm_smmu_event {
> +	union {
> +		u64 evt[4];
> +		struct {
> +			/* Bit 0:63 */
> +			u64 id : 8;
> +			u64 _res0 : 3;
> +			u64 ssv : 1;
> +			u64 ssid : 20;
> +			u64 sid : 32;
> +			/* Bit 64:127 */
> +			u64 stag : 16;
> +			u64 _res1 : 15;
> +			u64 stall : 1;
> +			u64 _res2 : 1;
> +			u64 pnu : 1;
> +			u64 ind : 1;
> +			u64 rnw : 1;
> +			u64 _res3 : 2;
> +			u64 nsipa : 1;
> +			u64 s2 : 1;
> +			u64 class : 2;
> +			u64 _res4 : 6;
> +			u64 impl_def : 16;
> +			/* Bit 128:191 */
> +			u64 inputaddr;
> +			/* Bit 192:255 */
> +			u64 _res5 : 12;
> +			u64 ipa : 40;
> +			u64 _res6 : 12;
> +		} f_trans;
> +		/* FIXME Add other event structs */
> +	};
> +};
> 
> Then, event would be just:
> +		struct arm_smmu_event *event = (struct arm_smmu_event *)evt;
> 
> Not sure if Will would like this though...

Yea, I thought about this too but I felt that it'd bloat up the code
for every new event that's introduced. Also, the printing would become
more complicated as we'd have to log different fields for different
events. Additionally, I don't see that many unions being defined
elsewhere in the kernel.

...and, I'm not a fan of too many unions (personally) :) 

> 
> > +
> > +       mutex_lock(&smmu->streams_mutex);
> > +       event->master = arm_smmu_find_master(smmu, event->sid);
> > +       mutex_unlock(&smmu->streams_mutex);
> 
> Same as I pointed out at the other patch, "master" is unprotected
> after the unlock. It can unlikely-yet-still-possibly race against
> arm_smmu_release_device.
>

Hmm.. are you suggesting that the `master` could've been removed by the
arm_smmu_release_device while we access it in an event handler?

As in, something like the following situation:

1. The evtq_thread gets scheduled
2. arm_smmu_release_device removes the `master` & its streams
3. In the `handle_evt` we dereference `master` which has been `kfree`ed
   (also, we don't return -EINVAL like we ideally should)

In that case, I think I should add back the `arm_smmu_find_master` to
the `arm_smmu_handle_evt` along with the locks. Nice catch! :)


> > +static void arm_smmu_dump_xlation_fault(struct arm_smmu_device *smmu,
> > +                                       struct arm_smmu_event *event)
> > +{
> > +       dev_err(smmu->dev, "Fault: %s client %s sid 0x%08x.0x%05x:\n",
> 
> "client" doesn't seem to be used anywhere in this driver, I would:
> s/client/master
> 

Ack, would change this to "master".

> And it'd feel clearer to have an "ssid". And perhaps adding commas
> to separate them too.

I referred to the log in `arm_smmu_handle_ppr` for the sid.ssid format.
If we'd prefer a separate "ssid", should we change the one in ppr too?
LMK, what you and Will think about that?

> 
> > +                       evts[event->id], event->master_name, event->sid, event->ssid);
> > +       dev_err(smmu->dev, "\tiova = %#llx ipa = %#llx (%s%s%s%s%s%s)\n", event->iova, event->ipa,
> > +                   event->privileged ? "Priv " : "Unpriv ",
> > +                   event->instruction ? "Inst " : "Data ",
> > +                   event->read ? "Read " : "Write ",
> > +                   event->stage ? "S2 " : "S1 ", class_str[event->class],
> > +                   ((event->id == EVT_ID_PERMISSION_FAULT) && (event->class == EVTQ_1_CLASS_TT)) ?
> > +                   (FIELD_GET(EVTQ_1_TT_READ, event->raw[1]) ? " TTD Read" : " TTD Write")
> > +                   : "");
> 
> Indentation should follow the existing printk() in this driver. And

I'm sorry but I'm not sure if I understand what is meant by "the
existing printk indentation in this driver", do you mean aligning the
next line with the opening brace? For example:

	dev_err(smmu->dev,
		"failed to allocate queue (0x%zx
		bytes) for %s\n",
		qsz, name);

> those ternary operators at the last field(s?) are hard to ready..
>

Hmm, I wanted the last fields to be printed only when the fault was
F_PERMISSION, in the same log. Any suggestions on what might make it
easier to read? Some helpful comments around it? Something else?

I just noticed that I've missed the `STAG` field in the in xlation_fault
dump, would add that too in the next version of this patch.

> > +static void arm_smmu_dump_fetch_fault(struct arm_smmu_device *smmu,
> > +                                     struct arm_smmu_event *event)
> > +{
> > +       dev_err(smmu->dev, "Bad fetch: %s client %s sid 0x%08x.0x%05x: fetch addr = %#llx\n",
> > +                       evts[event->id], event->master_name, event->sid, event->ssid, event->ipa);
> 
> Actually, the "Fault", "Bad fetch", and "Bad smmu config" doesn't
> feel very necessary, since we prints the event string already.
> 

That makes sense, I'll remove those in a follow up patch.
Although, I guess we should still say "fault" somewhere to hint folks
without arm-smmu-v3 knowledge that the event wasn't normal operation.

LMK what you think? I've had a few interactions where clients tend to
ignore the current "event received" dump considering that to be a part
of normal SMMU operation.

> > +}
> > +
> > +static void arm_smmu_dump_raw_event(struct arm_smmu_device *smmu,
> > +                                   struct arm_smmu_event *event)
> > +{
> > +       int i;
> > +
> > +       dev_err(smmu->dev, "event 0x%02x received: client %s:\n", event->id, event->master_name);
> 
> Looks like it would print another title that's sorta duplicated to
> other dump functions yet less informative?
>

Yea, I didn't wanna break backward compatibility, people might have
tools to parse out the existing dump, lol!

On a serious note, I believe it'd be better to print this as some
implmentations might have some "IMPLEMENTATION DEFINED" fields which
people might be interested to look at.

Although, we can dump the raw event only in the `default` case, i.e.
when we don't have a dumper function for that particular event ID but
that might still avoid printing the IMPL_DEFINED fields in fetch faults

> > +       for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
> > +               dev_err(smmu->dev, "\t0x%016llx\n",
> > +                        (unsigned long long)event->raw[i]);
> > +}
> > +
> > +static void arm_smmu_dump_event(struct arm_smmu_device *smmu,
> > +                                struct arm_smmu_event *event)
> > +{
> > +       switch (event->id) {
> > +       case EVT_ID_BAD_SID_CONFIG:
> > +       case EVT_ID_BAD_STE_CONFIG:
> > +       case EVT_ID_BAD_SSID_CONFIG:
> > +       case EVT_ID_BAD_CD_CONFIG:
> > +       case EVT_ID_STREAM_DISABLED:
> > +               dev_err(smmu->dev, "Bad smmu config - %s client %s sid 0x%08x.0x%05x\n",
> > +                               evts[event->id], event->master_name, event->sid, event->ssid);
> > +               break;
> > +
> > +       case EVT_ID_TRANSLATION_FAULT:
> > +       case EVT_ID_ADDR_SIZE_FAULT:
> > +       case EVT_ID_ACCESS_FAULT:
> > +       case EVT_ID_PERMISSION_FAULT:
> > +               arm_smmu_dump_xlation_fault(smmu, event);
> > +               break;
> > +
> > +       case EVT_ID_STE_FETCH_FAULT:
> > +       case EVT_ID_CD_FETCH_FAULT:
> > +       case EVT_ID_VMS_FETCH_FAULT:
> > +               arm_smmu_dump_fetch_fault(smmu, event);
> > +               break;
> > +       }
> > +
> > +       arm_smmu_dump_raw_event(smmu, event);
> 
> I wonder if something like this would be cleaner:
> 
> 	...
> 	char title[256];
> 	char addrs[256];
> 	char other[256];
> 	int i;
> 
> 	switch () {
> 	case xxxx:
> 		/* If duplicated between cases, put them into helpers */
> 		snprintf(title, 256, "%s: Master %s, sid 0x%08x, ssid 0x%05x\n",
> 			 event_str(event->id], dev_name(master->dev),
> 			 event->sid, event->ssid);
> 		snprintf(addrs, 256, .....);
> 		snprintf(other, 256, .....);
> 		break;
> 	...
> 	default:
> 		/* snprintf raw title */
> 		break;
> 	}
> 	if (strlen(title))
> 		dev_err(smmu->dev, "%s", title);
> 	if (strlen(addrs))
> 		dev_err(smmu->dev, "%s", addrs);
> 	if (strlen(other))
> 		dev_err(smmu->dev, "%s", other);
> 	for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
> 		dev_err(smmu->dev, "\t0x%016llx\n", event->evt[i]);
> 	...
> 

I thought about something similar as well, but then referred to Robin's
comments on [1]. Also, printing strings in 3 different `dev_err` logs
could result in interruptions from other logs in dmesg, I'd prefer to
see the entire log in a single `dev_err` for ease. Although, I think we
should be able to do something like the following to achieve that:
	...

	dev_err(%s %s %s, strlen(title) ? title : ""
		strlen(addrs) ? addrs : ""
		strlen(other) ? other : ""

	for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
		dev_err(smmu->dev, "\t0x%016llx\n", event->evt[i]);

	...

It does look cleaner to me as well. I'd wait for what other have to say.

> Thanks
> Nicolin

[1]
https://lore.kernel.org/linux-arm-kernel/07c7426c-7d01-4160-a344-1857b738e9c4@arm.com/T/#m9c38920897999c56f0b135556133cae38f40b754a

Thanks,
Pranjal
