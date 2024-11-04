Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1740D38F97
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 06:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730702213; cv=none; b=kAetoL8sbL/NhJ2+ReKyWZRoA+iQ3HMZdNPAuqzVW617rz/mi3pr7lOgvwAH2PZiX9cjP5tBz4NmopXgWLgN/FxXnpduA5tMNUWtkBwQAjQeXWh8Xo54HtHduVjxh4B/A9WT3Jrmuh7Y1NOh//kf7jPcKvAEiNUD+1WAoB5++2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730702213; c=relaxed/simple;
	bh=3Qq49t4TaZEcp/YV3Kib2InH4wO0Ca8dvzQPQEUWuqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VKC9W3pE719+6YCheZ7G8I8jiODSMXqjsxlzYvUM15wDXvyfIcN0MVQ5KERamImRdLXTrVVEh8lxNj3D/Ov7MVqr0Q41VzkBlZUUW3I4HO4ET4oHBFvgT/yWH6nhVM7yCis/RGNl6mo1Uhx3chlkfgQftdAa5uIMN8ZG7l2k0T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d7XwUPOf; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d7XwUPOf"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c93e9e701fso4892a12.1
        for <iommu@lists.linux.dev>; Sun, 03 Nov 2024 22:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730702209; x=1731307009; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/kNg7tw7q3Nfvi7hDitjLdJUEXtnMf+rJvUjtNMSTM=;
        b=d7XwUPOfeXQY7Rm++QYVPAQbt6wgf3IaqgB35y/KHA8nMCiOFvOqmn3uuLVRNpmlnS
         u00BNAkwP77uZcBKPEQMiTL1O1FVchFHPn78BnmymXXhx4y3+Yq2CYypryNDA4zQoJl7
         xRJshdYEhCqiQvsHABssY2aSpQXNQqhW4zeTVo0mPqGxeXQxAO1jf0CFVw2JfL7UgQym
         +PIloPqBWzbV8kosylKy89mkzTJZdz80jXfNcnPfwdeT6d9Vjo0sT5mIb0uDO6xqm0lS
         6moH2SzuTLlACsealcyBL9H3TEoE0fsAWvl0Evclt9VrBVEl7zhJ67PAj3TtTZPy7UfN
         srwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730702209; x=1731307009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/kNg7tw7q3Nfvi7hDitjLdJUEXtnMf+rJvUjtNMSTM=;
        b=KxSJtBoWQvkkdX0Xey9GiNik4cfNTFrjKGT6wTSUnu7y7cN9EyijK5ZywqktDXf9FZ
         gV2PROXZCHxMool7m/LAHJ6d52NatKMjL8uPfV+8pYV/jLP6bf7q+pm07GtqbN/WG2gv
         MNx+h/MEC5WZCFypuGevM9ZyHuULMJJeThgK79cl5WEUIk3o/mLh/YalVHLkI1iQK3ww
         3qOMR/KgsY9m45RruzIDtm+X1o2uw0MDXmWLhW5tBhxhG2TEZdshJia1PdoII2sjkgtT
         2MRvhCJC7mnpM0gu8KFgp5JTbgsKSa6Zs1WVEwg0R9VWOT1+WbPX1pVmL9kE4130nf4M
         H4tg==
X-Forwarded-Encrypted: i=1; AJvYcCXjAFY3y9wjqI+yOm+zbk4zIaaiObMzuR2Xe+wUzuc/84KNwUY/G84A4EqW+oLcBcUBc/IqLA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxmszkXVFHKSflJLPeA5xXlKcLGbdestMJDmVBrEQPQ6XcjxLaM
	3eiH6q872esq9HdiUczbaU1Eslgv9qU7JnintaVBtzWG0ziEdq7Vlc83Q5mDmEcMWTsLhs8By9y
	FsFdejT1IoIS1fkTfB90xilHspVEpXA07f2ZE
X-Gm-Gg: ASbGnct8U/XsZkKCDUGmcH/ucxhAQa4jV9Mg1aZq9S/yi/6tlOcTOO02l7rWswE9MJy
	2+A6UjQAZVYA2++wEQ1+CPpAuWZiRU3QdqzEBHcT9bdDkI1P68sAXtgNXLJVvF2doyw==
X-Google-Smtp-Source: AGHT+IHVMSYVw798RVJNpH4ubMY3KIeMDrkulIdZNqnNLvGIHeYGnLdLxx+INrTHk0e/j4I/AcW9sF8PGXs8pcs+fiI=
X-Received: by 2002:a05:6402:1a44:b0:5cb:6694:a291 with SMTP id
 4fb4d7f45d1cf-5ceca05272emr87352a12.1.1730702209171; Sun, 03 Nov 2024
 22:36:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241018180022.807928-1-praan@google.com> <20241018180022.807928-3-praan@google.com>
In-Reply-To: <20241018180022.807928-3-praan@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Sun, 3 Nov 2024 22:36:36 -0800
Message-ID: <CAE2F3rBkHX=at0a5MN2XGSpxo02ithb=23Tn9rczrbquo6fzwA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] iommu/arm-smmu-v3: Log better event records
To: Pranjal Shrivastava <praan@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev, 
	Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 11:01=E2=80=AFAM Pranjal Shrivastava <praan@google.=
com> wrote:
>
> Currently, the driver dumps the raw hex for a received event record.
> Improve this by leveraging `struct arm_smmu_event` for event fields
> and log human-readable event records with meaningful information.
>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 109 ++++++++++++++++++--
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  13 +++
>  2 files changed, 113 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index 2f1108e5de51..4477cf86cb8e 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -83,6 +83,34 @@ static struct arm_smmu_option_prop arm_smmu_options[] =
=3D {
>         { 0, NULL},
>  };
>
> +static const char * const event_str[] =3D {

I'd prefer the order in which they are specified in the Arm SMMUv3 arch spe=
c.

> +       /* Bad config events */
> +       [EVT_ID_BAD_SID_CONFIG] =3D "C_BAD_STREAMID",
> +       [EVT_ID_BAD_STE_CONFIG] =3D "C_BAD_STE",
> +       [EVT_ID_BAD_CD_CONFIG] =3D "C_BAD_CD",
> +       [EVT_ID_BAD_SSID_CONFIG] =3D "C_BAD_SUBSTREAMID",
> +       [EVT_ID_STREAM_DISABLED] =3D "F_STREAM_DISABLED",
> +
> +       /* Bad translation events */
> +       [EVT_ID_TRANSLATION_FAULT] =3D "F_TRANSLATION",
> +       [EVT_ID_ADDR_SIZE_FAULT] =3D "F_ADDR_SIZE",
> +       [EVT_ID_ACCESS_FAULT] =3D "F_ACCESS",
> +       [EVT_ID_PERMISSION_FAULT] =3D "F_PERMISSION",
> +
> +       /* Bad fetch events */
> +       [EVT_ID_STE_FETCH_FAULT] =3D "F_STE_FETCH",
> +       [EVT_ID_CD_FETCH_FAULT] =3D "F_CD_FETCH",
> +       [EVT_ID_VMS_FETCH_FAULT] =3D "F_VMS_FAULT",

F_VMS_FETCH not F_VMS_FAULT

> +       [EVT_ID_MAX] =3D NULL,

Have you considered checking if evt->id is smaller than
ARRAY_SIZE(event_str) rather than inflating even_str[] to contain 256
entries?

> +};
> +
> +static const char * const event_class_str[] =3D {
> +       [0] =3D "CD fetch",
> +       [1] =3D "Stage 1 translation table fetch",
> +       [2] =3D "Input address caused fault ",
> +       [3] =3D "Reserved",
> +};
> +
>  static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
>                                     struct arm_smmu_device *smmu, u32 fla=
gs);
>  static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
> @@ -1756,6 +1784,60 @@ arm_smmu_find_master(struct arm_smmu_device *smmu,=
 u32 sid)
>         return rb_entry(node, struct arm_smmu_stream, node)->master;
>  }
>
> +static void arm_smmu_dump_raw_event(struct arm_smmu_event *event)
> +{
> +       int i;
> +       struct arm_smmu_device *smmu =3D event->smmu;
> +
> +       dev_err(smmu->dev, "event 0x%02x received: master %s:\n",
> +               event->id, event->master_name);
> +
> +       for (i =3D 0; i < EVTQ_ENT_DWORDS; ++i)
> +               dev_err(smmu->dev, "\t0x%016llx\n", event->raw[i]);
> +}
> +
> +static void arm_smmu_dump_event(struct arm_smmu_event *evt, struct ratel=
imit_state *rs)
> +{
> +       struct arm_smmu_device *smmu =3D evt->smmu;
> +       char title[100] =3D {0};
> +       char mastr[100] =3D {0};
> +       char addrs[100] =3D {0};
> +       char flags[100] =3D {0};
> +       char other[50] =3D {0};
> +
> +       if (!__ratelimit(rs))
> +               return;
> +
> +       snprintf(title, 100, "Unexpected event received: %s\n", event_str=
[evt->id]);
> +       snprintf(mastr, 100, "\tmaster: %s sid: 0x%08x.0x%05x\n",
> +                evt->master_name, evt->sid, evt->ssid);
> +
> +       switch (evt->id) {
> +       case EVT_ID_TRANSLATION_FAULT:
> +       case EVT_ID_ADDR_SIZE_FAULT:
> +       case EVT_ID_ACCESS_FAULT:
> +       case EVT_ID_PERMISSION_FAULT:
> +               snprintf(addrs, 100, "\tiova =3D %#llx ipa =3D %#llx\n", =
evt->iova, evt->ipa);
> +               snprintf(other, 50, "\tSTAG =3D %#x Stall =3D %#x\n", evt=
->stag, evt->stall);
> +               snprintf(flags, 100, "\t%s%s%s%s%s%s\n",
> +                        evt->privileged ? "Priv | " : "Unpriv | ",
> +                        evt->instruction ? "Inst | " : "Data | ",
> +                        evt->read ? "Read | " : "Write | ",
> +                        evt->s2 ? "S2 | " : "S1 | ", event_class_str[evt=
->class],
> +                        evt->ttrnw_valid ? (evt->ttrnw ? "| TTD Read" : =
"| TTD Write") : "");
> +               break;
> +
> +       case EVT_ID_STE_FETCH_FAULT:
> +       case EVT_ID_CD_FETCH_FAULT:
> +       case EVT_ID_VMS_FETCH_FAULT:
> +               snprintf(addrs, 100, "\tFetch address: %#llx\n", evt->ipa=
);
> +               break;
> +       }
> +
> +       dev_err(smmu->dev, "%s%s%s%s%s", title, mastr, addrs, flags, othe=
r);
> +       arm_smmu_dump_raw_event(evt);
> +}
> +
>  /* IRQ and event handlers */
>  static int arm_smmu_handle_evt(struct arm_smmu_event *event)
>  {
> @@ -1819,6 +1901,8 @@ static int arm_smmu_handle_evt(struct arm_smmu_even=
t *event)
>  static void arm_smmu_get_event_from_raw(struct arm_smmu_device *smmu,
>                                         struct arm_smmu_event *event)
>  {
> +       struct arm_smmu_master *master;
> +
>         /* Pick out the good stuff */
>         event->id =3D FIELD_GET(EVTQ_0_ID, event->raw[0]);
>         event->sid =3D FIELD_GET(EVTQ_0_SID, event->raw[0]);
> @@ -1833,12 +1917,24 @@ static void arm_smmu_get_event_from_raw(struct ar=
m_smmu_device *smmu,
>         event->class =3D FIELD_GET(EVTQ_1_CLASS, event->raw[1]);
>         event->iova =3D FIELD_GET(EVTQ_2_ADDR, event->raw[2]);
>         event->ipa =3D FIELD_GET(EVTQ_3_IPA, event->raw[3]);
> +       event->ttrnw =3D FIELD_GET(EVTQ_1_TT_READ, event->raw[1]);
> +       event->ttrnw_valid =3D false;
>         event->smmu =3D smmu;
> +       event->dev =3D NULL;
> +
> +       if (event->id =3D=3D EVT_ID_PERMISSION_FAULT)
> +               event->ttrnw_valid =3D (event->class =3D=3D EVTQ_1_CLASS_=
TT);
> +
> +       mutex_lock(&smmu->streams_mutex);
> +       master =3D arm_smmu_find_master(smmu, event->sid);
> +       if (master)
> +               event->dev =3D get_device(master->dev);
> +       mutex_unlock(&smmu->streams_mutex);
> +       event->master_name =3D event->dev ? dev_name(event->dev) : "(unas=
signed sid)";
>  }
>
>  static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
>  {
> -       int i, ret;
>         struct arm_smmu_event evt;
>         struct arm_smmu_device *smmu =3D dev;
>         struct arm_smmu_queue *q =3D &smmu->evtq.q;
> @@ -1850,15 +1946,10 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, =
void *dev)
>                 while (!queue_remove_raw(q, evt.raw)) {
>
>                         arm_smmu_get_event_from_raw(smmu, &evt);
> -                       ret =3D arm_smmu_handle_evt(&evt);
> -                       if (!ret || !__ratelimit(&rs))
> -                               continue;
> -
> -                       dev_info(smmu->dev, "event 0x%02x received:\n", e=
vt.id);
> -                       for (i =3D 0; i < EVTQ_ENT_DWORDS; ++i)
> -                               dev_info(smmu->dev, "\t0x%016llx\n",
> -                                       (unsigned long long)evt.raw[i]);
> +                       if (arm_smmu_handle_evt(&evt))
> +                               arm_smmu_dump_event(&evt, &rs);
>
> +                       put_device(evt.dev);
>                         cond_resched();
>                 }
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.h
> index 8a42d7b701fb..820b08f872af 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -438,10 +438,19 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(un=
signed int ssid)
>  #define EVTQ_0_ID                      GENMASK_ULL(7, 0)
>
>  /* Events */
> +#define EVT_ID_BAD_SID_CONFIG          0x02

I find that EVT_ID_BAD_STREAMID_CONFIG would be more consistent with
the spec and what's already in this header file.

> +#define EVT_ID_STE_FETCH_FAULT         0x03
> +#define EVT_ID_BAD_STE_CONFIG          0x04
> +#define EVT_ID_STREAM_DISABLED         0x06

EVT_ID_STREAM_DISABLED_FAULT

> +#define EVT_ID_BAD_SSID_CONFIG         0x08

EVT_ID_BAD_SUBSTREAMID_CONFIG

> +#define EVT_ID_CD_FETCH_FAULT          0x09
> +#define EVT_ID_BAD_CD_CONFIG           0x0a
>  #define EVT_ID_TRANSLATION_FAULT       0x10
>  #define EVT_ID_ADDR_SIZE_FAULT         0x11
>  #define EVT_ID_ACCESS_FAULT            0x12
>  #define EVT_ID_PERMISSION_FAULT                0x13
> +#define EVT_ID_VMS_FETCH_FAULT         0x25
> +#define EVT_ID_MAX                     0xff
>
>  #define EVTQ_0_SSV                     (1UL << 11)
>  #define EVTQ_0_SSID                    GENMASK_ULL(31, 12)
> @@ -774,7 +783,9 @@ struct arm_smmu_stream {
>  };
>
>  struct arm_smmu_event {
> +       const char                      *master_name;
>         struct arm_smmu_device          *smmu;
> +       struct device                   *dev;
>         u8                              id;
>         u8                              class;
>         u16                             stag;
> @@ -789,6 +800,8 @@ struct arm_smmu_event {
>         bool                            instruction;
>         bool                            s2;
>         bool                            read;
> +       bool                            ttrnw;
> +       bool                            ttrnw_valid;
>  };
>
>  /* SMMU private data for each master */
> --
> 2.47.0.rc1.288.g06298d1525-goog
>
>
