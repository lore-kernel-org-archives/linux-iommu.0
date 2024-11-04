Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D4A1C07D9
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 10:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717474; cv=none; b=YNiEc3TOWcK89CRkrLMaOKUuSB13IMDso+3ylu8XJiTaEjwWUk1X99zZXe7Tjpy6gWQCt3ua6KWXeNAf2FH7vd1QTawF+TXYIWNV66NQH59ZW6Ttdy7JULKzzGJyM+/kn5OwxSEIcfLeBYdWUpdSKiiLwANVFAmX/eaFXsnaBBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717474; c=relaxed/simple;
	bh=+jjm72Rrbx7D01eeRdmG7VytvDkzXIgriG1qQ7Ndpeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJhI+oUPu5c5ktXE4YpPTyJY7v0+sDGNQRU0XFhL9DDi5O/lztUpar//etd8MvEVdbQwm++nU8/q//TY5ou8yLLTskWJFE5rpqzwKgi6WhcsHMGwjMN4ehq9uuSXZ9fexRwfrnIpNMH7u/+iev1s3TbOs0NnTP7NUakm5m+QRRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NDbpGVWL; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NDbpGVWL"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20ca4877690so158535ad.1
        for <iommu@lists.linux.dev>; Mon, 04 Nov 2024 02:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730717471; x=1731322271; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7ZE3DIXU6hoG1//oae8mxFzQUxst/aIX8rej04QwSx8=;
        b=NDbpGVWLTxePBg+yRx2f8ZS6XgT1WWbdQk8MRWG11eWqmcrENmMOwJz8smZJH1kiwE
         xGM8i0BXG0lsxagZjh6qJhdAYLwgJ9nkTew7fE0b1BCVj7N5oeTau9hLjzvUjuzdqFh9
         emD2vM77W/1Yo7mk9qiFNlV3TgbAKh62lN/ixxRh2Es6J+FTe9A3vVb50lzvQRQQFByP
         RgtQETp0FfD+ue0CTmpti2chlQh7yomhCrv42tTV4dRmK9ObeTSm0tfZgwTWurIWcL9d
         uL4qJzOq53zijOZo4ydnHod0bIlzjK9mZTNPrWSlUyjxq55aqWHqrZj2vTyo1lWKiIKa
         nxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730717471; x=1731322271;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZE3DIXU6hoG1//oae8mxFzQUxst/aIX8rej04QwSx8=;
        b=jnBhIJa0UKJTt3cmszs+woXVIh/WxHi/XDmjQQqcFVKW8KvQtCNBB8dioEpBdE+vxo
         ZUxY3WeHw9j4Jrhj5f4OScEIj39ge2Y7q4AMMGhZzoQkZSgmHbTVMJTc9d8dyJqnDk27
         TjMMHXuZ0Tcq5lFyHJgDn7cLy14dwXiC/DoAqaTxDOq3FiBj2lMIwzck3ZQSQE43LA9S
         MuImyfTWGvtBvOK8TsPSKj0ixLg1KjdJMgx9HoKGTF+5hlGlVqt8v/ORAbhFnIYI02/x
         niVMJoyXU8ovkYLwB0UpTUUHLaNXq9LCk9fxIA7yPlOL61/q/ybvXecUmI1/iBMMiNLH
         4o1A==
X-Forwarded-Encrypted: i=1; AJvYcCU74ZeDK8l0aafJkqNWNuZMoQzdyPBna5i/Lk7/jMqkhPAKJE+0kC7OU2Rt/XxPiul5+0KDDA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxed+KCL6WtN/ORv2PSlpd5zdLNez2AZ1ZjuTT4cLzSUdUInfyG
	krCqtg8lucPLsJC2OkMe0a7Kq3fQzLy4lntEG8uwpKNGpjJR0FJmBE/1XUTgOg==
X-Gm-Gg: ASbGncury4QHg9hr4zRos1LYxe+A8PZ3MOknPz6LU2AUyjz/IOet+qxM194rEXNs58W
	qsUlhdFDF+n4ghfrMe+4YYzw1a690wANbmpcjEnYLDXsAzUJiMFB1Zt8PQlDjtS7k/Vup723iTe
	oAvznuPAU9/WdyMMHq0MThvKqxJZWt6okuI3vCxPakhjqIN3NG4COUq/TR6TUArxp0bKZKlg5xn
	990BWJ9wFcIHPt8nFEFnf/SVaPqbL34jjro3VdjASuJ71ZtJWXpDftauFTApbVA9HYFn8O4umAs
	7LpKq4jDv2s=
X-Google-Smtp-Source: AGHT+IGU+7VKiTetnaL/UA6a8utTEqpyvLqVvByzSnRXMu51NdhQgdofd/bOXB3VN1JBTxcj5HsZ3g==
X-Received: by 2002:a17:902:f54b:b0:20c:79d7:d8c9 with SMTP id d9443c01a7336-211327aa463mr2927995ad.26.1730717471104;
        Mon, 04 Nov 2024 02:51:11 -0800 (PST)
Received: from google.com (146.254.240.35.bc.googleusercontent.com. [35.240.254.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1e5a64sm7123060b3a.65.2024.11.04.02.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 02:51:10 -0800 (PST)
Date: Mon, 4 Nov 2024 10:51:02 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 2/3] iommu/arm-smmu-v3: Log better event records
Message-ID: <ZyinFh3HlawGt4iJ@google.com>
References: <20241018180022.807928-1-praan@google.com>
 <20241018180022.807928-3-praan@google.com>
 <CAE2F3rBkHX=at0a5MN2XGSpxo02ithb=23Tn9rczrbquo6fzwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rBkHX=at0a5MN2XGSpxo02ithb=23Tn9rczrbquo6fzwA@mail.gmail.com>

On Sun, Nov 03, 2024 at 10:36:36PM -0800, Daniel Mentz wrote:
> On Fri, Oct 18, 2024 at 11:01 AM Pranjal Shrivastava <praan@google.com> wrote:
> >
> > Currently, the driver dumps the raw hex for a received event record.
> > Improve this by leveraging `struct arm_smmu_event` for event fields
> > and log human-readable event records with meaningful information.
> >
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 109 ++++++++++++++++++--
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  13 +++
> >  2 files changed, 113 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 2f1108e5de51..4477cf86cb8e 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -83,6 +83,34 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
> >         { 0, NULL},
> >  };
> >
> > +static const char * const event_str[] = {
> 
> I'd prefer the order in which they are specified in the Arm SMMUv3 arch spec.
> 

Ack. I had this initially as I grouped the event parsing in the
following types which has changed in the new versions. I'll re-order
them as they appear in the Arm SMMUv3 spec.

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
> > +       [EVT_ID_VMS_FETCH_FAULT] = "F_VMS_FAULT",
> 
> F_VMS_FETCH not F_VMS_FAULT
> 

Ahh, yes! Thanks! I'll fix this.

> > +       [EVT_ID_MAX] = NULL,
> 
> Have you considered checking if evt->id is smaller than
> ARRAY_SIZE(event_str) rather than inflating even_str[] to contain 256
> entries?
> 

Yea.. a comparison of evt_id with array size wouldn't be correct as we
aren't listing all the events. Let's take the following example:

The `F_BAD_ATS_TREQ` has an event id of 0x05 but isn't defined above. In
this case, evt->id < ARRAY_SIZE(event_str) will be true.

The spec defines event IDs with inconsistent holes, for e.g. after 0x0b
we have 0x10, after 0x13 we have 0x20, after 0x21 we have 0x24.

Although, I agree that inflating the event_str[] to contain 256 entries
while most of them being NULL isn't good.

I think we can set the EVT_ID_MAX to 0x26 (the last spec-defined event
has an ID of 0x25). That way, we'll have 0x27 entries in the event_str
with a few holes. 

That way, if ((event_str[id] == NULL) || (id > ARRAY_SIZE(event_str))
we can print "Unknown Event". I believe that'd be better.

I'm assuming since we don't have anything in upstream for 
"Implementation-defined" events we can mark them as "UNKNOWN EVENTS"

> > +};
> > +
> > +static const char * const event_class_str[] = {
> > +       [0] = "CD fetch",
> > +       [1] = "Stage 1 translation table fetch",
> > +       [2] = "Input address caused fault ",
> > +       [3] = "Reserved",
> > +};
> > +
> >  static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
> >                                     struct arm_smmu_device *smmu, u32 flags);
> >  static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
> > @@ -1756,6 +1784,60 @@ arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
> >         return rb_entry(node, struct arm_smmu_stream, node)->master;
> >  }
> >
> > +static void arm_smmu_dump_raw_event(struct arm_smmu_event *event)
> > +{
> > +       int i;
> > +       struct arm_smmu_device *smmu = event->smmu;
> > +
> > +       dev_err(smmu->dev, "event 0x%02x received: master %s:\n",
> > +               event->id, event->master_name);
> > +
> > +       for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
> > +               dev_err(smmu->dev, "\t0x%016llx\n", event->raw[i]);
> > +}
> > +
> > +static void arm_smmu_dump_event(struct arm_smmu_event *evt, struct ratelimit_state *rs)
> > +{
> > +       struct arm_smmu_device *smmu = evt->smmu;
> > +       char title[100] = {0};
> > +       char mastr[100] = {0};
> > +       char addrs[100] = {0};
> > +       char flags[100] = {0};
> > +       char other[50] = {0};
> > +
> > +       if (!__ratelimit(rs))
> > +               return;
> > +
> > +       snprintf(title, 100, "Unexpected event received: %s\n", event_str[evt->id]);
> > +       snprintf(mastr, 100, "\tmaster: %s sid: 0x%08x.0x%05x\n",
> > +                evt->master_name, evt->sid, evt->ssid);
> > +
> > +       switch (evt->id) {
> > +       case EVT_ID_TRANSLATION_FAULT:
> > +       case EVT_ID_ADDR_SIZE_FAULT:
> > +       case EVT_ID_ACCESS_FAULT:
> > +       case EVT_ID_PERMISSION_FAULT:
> > +               snprintf(addrs, 100, "\tiova = %#llx ipa = %#llx\n", evt->iova, evt->ipa);
> > +               snprintf(other, 50, "\tSTAG = %#x Stall = %#x\n", evt->stag, evt->stall);
> > +               snprintf(flags, 100, "\t%s%s%s%s%s%s\n",
> > +                        evt->privileged ? "Priv | " : "Unpriv | ",
> > +                        evt->instruction ? "Inst | " : "Data | ",
> > +                        evt->read ? "Read | " : "Write | ",
> > +                        evt->s2 ? "S2 | " : "S1 | ", event_class_str[evt->class],
> > +                        evt->ttrnw_valid ? (evt->ttrnw ? "| TTD Read" : "| TTD Write") : "");
> > +               break;
> > +
> > +       case EVT_ID_STE_FETCH_FAULT:
> > +       case EVT_ID_CD_FETCH_FAULT:
> > +       case EVT_ID_VMS_FETCH_FAULT:
> > +               snprintf(addrs, 100, "\tFetch address: %#llx\n", evt->ipa);
> > +               break;
> > +       }
> > +
> > +       dev_err(smmu->dev, "%s%s%s%s%s", title, mastr, addrs, flags, other);
> > +       arm_smmu_dump_raw_event(evt);
> > +}
> > +
> >  /* IRQ and event handlers */
> >  static int arm_smmu_handle_evt(struct arm_smmu_event *event)
> >  {
> > @@ -1819,6 +1901,8 @@ static int arm_smmu_handle_evt(struct arm_smmu_event *event)
> >  static void arm_smmu_get_event_from_raw(struct arm_smmu_device *smmu,
> >                                         struct arm_smmu_event *event)
> >  {
> > +       struct arm_smmu_master *master;
> > +
> >         /* Pick out the good stuff */
> >         event->id = FIELD_GET(EVTQ_0_ID, event->raw[0]);
> >         event->sid = FIELD_GET(EVTQ_0_SID, event->raw[0]);
> > @@ -1833,12 +1917,24 @@ static void arm_smmu_get_event_from_raw(struct arm_smmu_device *smmu,
> >         event->class = FIELD_GET(EVTQ_1_CLASS, event->raw[1]);
> >         event->iova = FIELD_GET(EVTQ_2_ADDR, event->raw[2]);
> >         event->ipa = FIELD_GET(EVTQ_3_IPA, event->raw[3]);
> > +       event->ttrnw = FIELD_GET(EVTQ_1_TT_READ, event->raw[1]);
> > +       event->ttrnw_valid = false;
> >         event->smmu = smmu;
> > +       event->dev = NULL;
> > +
> > +       if (event->id == EVT_ID_PERMISSION_FAULT)
> > +               event->ttrnw_valid = (event->class == EVTQ_1_CLASS_TT);
> > +
> > +       mutex_lock(&smmu->streams_mutex);
> > +       master = arm_smmu_find_master(smmu, event->sid);
> > +       if (master)
> > +               event->dev = get_device(master->dev);
> > +       mutex_unlock(&smmu->streams_mutex);
> > +       event->master_name = event->dev ? dev_name(event->dev) : "(unassigned sid)";
> >  }
> >
> >  static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
> >  {
> > -       int i, ret;
> >         struct arm_smmu_event evt;
> >         struct arm_smmu_device *smmu = dev;
> >         struct arm_smmu_queue *q = &smmu->evtq.q;
> > @@ -1850,15 +1946,10 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
> >                 while (!queue_remove_raw(q, evt.raw)) {
> >
> >                         arm_smmu_get_event_from_raw(smmu, &evt);
> > -                       ret = arm_smmu_handle_evt(&evt);
> > -                       if (!ret || !__ratelimit(&rs))
> > -                               continue;
> > -
> > -                       dev_info(smmu->dev, "event 0x%02x received:\n", evt.id);
> > -                       for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
> > -                               dev_info(smmu->dev, "\t0x%016llx\n",
> > -                                       (unsigned long long)evt.raw[i]);
> > +                       if (arm_smmu_handle_evt(&evt))
> > +                               arm_smmu_dump_event(&evt, &rs);
> >
> > +                       put_device(evt.dev);
> >                         cond_resched();
> >                 }
> >
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > index 8a42d7b701fb..820b08f872af 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > @@ -438,10 +438,19 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
> >  #define EVTQ_0_ID                      GENMASK_ULL(7, 0)
> >
> >  /* Events */
> > +#define EVT_ID_BAD_SID_CONFIG          0x02
> 
> I find that EVT_ID_BAD_STREAMID_CONFIG would be more consistent with
> the spec and what's already in this header file.
> 

Ack.

> > +#define EVT_ID_STE_FETCH_FAULT         0x03
> > +#define EVT_ID_BAD_STE_CONFIG          0x04
> > +#define EVT_ID_STREAM_DISABLED         0x06
> 
> EVT_ID_STREAM_DISABLED_FAULT
> 
> > +#define EVT_ID_BAD_SSID_CONFIG         0x08
> 
> EVT_ID_BAD_SUBSTREAMID_CONFIG
> 

Ack. Will update the names.

> > +#define EVT_ID_CD_FETCH_FAULT          0x09
> > +#define EVT_ID_BAD_CD_CONFIG           0x0a
> >  #define EVT_ID_TRANSLATION_FAULT       0x10
> >  #define EVT_ID_ADDR_SIZE_FAULT         0x11
> >  #define EVT_ID_ACCESS_FAULT            0x12
> >  #define EVT_ID_PERMISSION_FAULT                0x13
> > +#define EVT_ID_VMS_FETCH_FAULT         0x25
> > +#define EVT_ID_MAX                     0xff
> >
> >  #define EVTQ_0_SSV                     (1UL << 11)
> >  #define EVTQ_0_SSID                    GENMASK_ULL(31, 12)
> > @@ -774,7 +783,9 @@ struct arm_smmu_stream {
> >  };
> >
> >  struct arm_smmu_event {
> > +       const char                      *master_name;
> >         struct arm_smmu_device          *smmu;
> > +       struct device                   *dev;
> >         u8                              id;
> >         u8                              class;
> >         u16                             stag;
> > @@ -789,6 +800,8 @@ struct arm_smmu_event {
> >         bool                            instruction;
> >         bool                            s2;
> >         bool                            read;
> > +       bool                            ttrnw;
> > +       bool                            ttrnw_valid;
> >  };
> >
> >  /* SMMU private data for each master */
> > --
> > 2.47.0.rc1.288.g06298d1525-goog
> >
> >

Thanks,
Praan
