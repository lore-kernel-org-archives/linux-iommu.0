Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898BB2010E1
	for <iommu@lists.linux.dev>; Thu, 23 Jan 2025 06:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737615430; cv=none; b=CT6xMS4JIc3oGupM32IHRMiFbCvUCLuihQ9wnL4jNXLPjPMGcUtO+D5vTAXvDXnA5HSx9wFCujgikjNfwek4Sh+S08sSQHlyJH3SKC7eLKQGH9sjp5JUgylusuLa4oKBo3xYgPUbWL4xOg6AvU5YXxEc+qM52F+/LJ3x/IRfDvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737615430; c=relaxed/simple;
	bh=+Ls6maGjXw9atJKzg+RCj5e6sTCkEEu6nthWGNOcaS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U2hsVyhLib5LO5yli/BeDpafPB+vRiCtcFoSXXOwZbjRLShbYLxH+KUGqTUNQO8BqLxNq5OsL3ij9k5NGW/TEs7mmkiDC4m3BE5lYN6OsG8gRjqg3fR3fk72/WEtAJIWCLTddQ1O22UxRWTn0/OzlPI7CXEIfG1bG8dmxfmhS84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=HPkARFsU; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HPkARFsU"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-852050432a8so18697639f.1
        for <iommu@lists.linux.dev>; Wed, 22 Jan 2025 22:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1737615426; x=1738220226; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2iP6aMt1l3boKT6OjRQZI1cwqPHTAeLXe++rNKnus/s=;
        b=HPkARFsUy5K71ByWo5eU8dflm1w+lyAOp2TFi15B3QiaXaSVsHxQMYHiltpdS5+5Zr
         oYELXF4EcRpjgXWkleyqAJdHQo2nl8U/DaZD+pa4/PmbObsZ9eLHp9eb99XLX26ujhaS
         C1Eg9on0AWoemMASyWCTohojVwiopwOdwKEo6eEHtpDDuQaowiCNjoWDE3piJuzjq1VY
         t+zdhDU9Z/BfHJKiLhqjfXZnRdD6+BF70Vz8+MRV9k1uaz/b8LTGJHfUt3HUXt4NEXxU
         7hNqXMmV8VAmgLBL61kvO4RFpzUzq0o1S3VNeniNJpRKpj0D/i8k5HBMtRPZFPqjukU1
         h/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737615426; x=1738220226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2iP6aMt1l3boKT6OjRQZI1cwqPHTAeLXe++rNKnus/s=;
        b=oVvFpnD1kpVWP7VNiwjehI3zD1Cd+mq8sPWv0BEznCcaUCFC/q4uKDimgr6Jj1sQoU
         WKHMpBaKgQXF4haSFpDhVfu2Ixt++4w3NGql1Fnp+yIx4fLsvmdZ6e2HTe0+tfrVibGt
         7P7rR6Q1pxwz/djEmbju26sFXFT+V/TbYw5vmBKarjTV9VSmrE0fUMAfa+C+n7pEcAZx
         jxl4F+iPw1WKeC1upkcT3PnrMQ4a19zM7DBiEH8EY11/j95wnQGmnkIfzY5m7vGVd2Rm
         VIPAG0a5lqZHWe+4VxFBK8+617TQp4n02ySmOi502llqmu1/h+w6w3S8dir+LmKip4Eu
         l7RA==
X-Forwarded-Encrypted: i=1; AJvYcCUCwQW/2dv1B/U02mRihPP4L3Xm5w7HgTiCPC17aBjtSn2VlBEC7DB9rU17HUzITA0VVKiNCg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZXf0TeznaZYEAKP7uHaxf7vM+vBFf8mCMsVAcRgrxCaMVpUiu
	D5hVU9g20dxOiFZ0VDsdeqJTy2Zwa3wsekgLFKes44HFRyiyVrLfxxAEk3iws6rjx5WJ300AsVk
	iLSv0KeFi83nvCI5OrHUmtqynv4MtScYRCbaduQ==
X-Gm-Gg: ASbGncvTNWisNWNVBLQeL01O4pTkR67+HjZD0mdTTFG6u33uuW4WNV6x5Y+xtvaV9lm
	ubvfTLyH796Mipoi9twguhC6BHWvNp0QBmkyOI79ZtHIvVSS3hJvsmUBTVu9ZOjyH
X-Google-Smtp-Source: AGHT+IFUBhjQ2xh/Y5BZF2wTibiwIdGK4px22BkDjccywSxIUxQ5cuLV+l3i79y/v72fMl6lrY743D5+b3fw8imDWLU=
X-Received: by 2002:a5d:8356:0:b0:835:3dfc:5ba5 with SMTP id
 ca18e2360f4ac-8520be3e82cmr168397139f.5.1737615426328; Wed, 22 Jan 2025
 22:57:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250115030306.29735-1-zong.li@sifive.com> <20250115030306.29735-2-zong.li@sifive.com>
 <896f03f9-4878-4d20-9992-ef3f39253acc@arm.com>
In-Reply-To: <896f03f9-4878-4d20-9992-ef3f39253acc@arm.com>
From: Zong Li <zong.li@sifive.com>
Date: Thu, 23 Jan 2025 14:56:53 +0800
X-Gm-Features: AbW1kvYHwIyjUkGsZg86Ha1GcATbHZCPtQm9TsAZbjWElSLKfw9kYLPX5SGVI90
Message-ID: <CANXhq0qM_GqFtN61uWas2Ff=Dj6U3YZ4AJHWeQ_oYs6Qq6=u1Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] iommu/riscv: add RISC-V IOMMU PMU support
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, tjeznach@rivosinc.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	luxu.kernel@bytedance.com, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Robin,
Thanks for your review, sorry for the late response, there was a lot
of information mentioned, and I took some time to digest it.

On Thu, Jan 16, 2025 at 5:32=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2025-01-15 3:03 am, Zong Li wrote:
> > Support for the RISC-V IOMMU hardware performance monitor includes
> > both counting and sampling modes.
> >
> > The specification does not define an event ID for counting the
> > number of clock cycles, meaning there is no associated `iohpmevt0`.
> > However, we need an event for counting cycle, so we reserve the
> > maximum event ID for this purpose.
>
> Why not use an extra config bit to encode cycles events completely
> independently of the regular eventID space? Or even just use 0 since by
> definition that cannot overlap a valid eventID?

Event ID 0 means "Don't count", It might be a bit confusing when
compared to the spec,
so I guess we could use another bit for the cycle event, such as bit 15.

>
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > Tested-by: Xu Lu <luxu.kernel@bytedance.com>
> > ---
> >   drivers/iommu/riscv/Makefile     |   2 +-
> >   drivers/iommu/riscv/iommu-bits.h |  16 +
> >   drivers/iommu/riscv/iommu-pmu.c  | 486 ++++++++++++++++++++++++++++++=
+
> >   drivers/iommu/riscv/iommu.h      |   8 +
> >   4 files changed, 511 insertions(+), 1 deletion(-)
> >   create mode 100644 drivers/iommu/riscv/iommu-pmu.c
> >
> > diff --git a/drivers/iommu/riscv/Makefile b/drivers/iommu/riscv/Makefil=
e
> > index f54c9ed17d41..d36625a1fd08 100644
> > --- a/drivers/iommu/riscv/Makefile
> > +++ b/drivers/iommu/riscv/Makefile
> > @@ -1,3 +1,3 @@
> >   # SPDX-License-Identifier: GPL-2.0-only
> > -obj-$(CONFIG_RISCV_IOMMU) +=3D iommu.o iommu-platform.o
> > +obj-$(CONFIG_RISCV_IOMMU) +=3D iommu.o iommu-platform.o iommu-pmu.o
> >   obj-$(CONFIG_RISCV_IOMMU_PCI) +=3D iommu-pci.o
> > diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iom=
mu-bits.h
> > index 98daf0e1a306..60523449f016 100644
> > --- a/drivers/iommu/riscv/iommu-bits.h
> > +++ b/drivers/iommu/riscv/iommu-bits.h
> > @@ -17,6 +17,7 @@
> >   #include <linux/types.h>
> >   #include <linux/bitfield.h>
> >   #include <linux/bits.h>
> > +#include <linux/perf_event.h>
> >
> >   /*
> >    * Chapter 5: Memory Mapped register interface
> > @@ -207,6 +208,7 @@ enum riscv_iommu_ddtp_modes {
> >   /* 5.22 Performance monitoring event counters (31 * 64bits) */
> >   #define RISCV_IOMMU_REG_IOHPMCTR_BASE       0x0068
> >   #define RISCV_IOMMU_REG_IOHPMCTR(_n)        (RISCV_IOMMU_REG_IOHPMCTR=
_BASE + ((_n) * 0x8))
> > +#define RISCV_IOMMU_IOHPMCTR_COUNTER GENMASK_ULL(63, 0)
> >
> >   /* 5.23 Performance monitoring event selectors (31 * 64bits) */
> >   #define RISCV_IOMMU_REG_IOHPMEVT_BASE       0x0160
> > @@ -250,6 +252,20 @@ enum riscv_iommu_hpmevent_id {
> >       RISCV_IOMMU_HPMEVENT_MAX        =3D 9
> >   };
> >
> > +/* Use maximum event ID for cycle event */
> > +#define RISCV_IOMMU_HPMEVENT_CYCLE   GENMASK_ULL(14, 0)
>
> It's also horribly confusing to use GENMASK for something which is not
> actually a mask at all.

Let's define a constant value for it, or maybe use BIT(15) as I mentioned a=
bove.

>
> > +#define RISCV_IOMMU_HPM_COUNTER_NUM  32
> > +
> > +struct riscv_iommu_pmu {
> > +     struct pmu pmu;
> > +     void __iomem *reg;
> > +     int num_counters;
> > +     u64 mask_counter;
> > +     struct perf_event *events[RISCV_IOMMU_IOHPMEVT_CNT + 1];
> > +     DECLARE_BITMAP(used_counters, RISCV_IOMMU_IOHPMEVT_CNT + 1);
>
> Hmm, from experience I would expect these variables to be
> number-of-counters related, but I guess there must be some special
> cleverness going on since that number-of-counters looking
> RISCV_IOMMU_HPM_COUNTER_NUM definition is conspicuously not used, so it
> must be significant that these are instead related to the number of...
>
> [ goes off to search code... ]
>
> ...event selectors? But with a magic +1 for reasons so obvious they
> clearly don't need explaining.

Yes, I think RISCV_IOMMU_HPM_COUNTER_NUM is better. I can't remember
clearly why I preferred to use RISCV_IOMMU_IOHPMEVT_CNT + 1 before.
Maybe I'd like to emphasize the number of counter is N event counter +
1 cycle counter.

>
> > +};
> > +
> >   /* 5.24 Translation request IOVA (64bits) */
> >   #define RISCV_IOMMU_REG_TR_REQ_IOVA     0x0258
> >   #define RISCV_IOMMU_TR_REQ_IOVA_VPN GENMASK_ULL(63, 12)
> > diff --git a/drivers/iommu/riscv/iommu-pmu.c b/drivers/iommu/riscv/iomm=
u-pmu.c
> > new file mode 100644
> > index 000000000000..74eb1525cd32
> > --- /dev/null
> > +++ b/drivers/iommu/riscv/iommu-pmu.c
> > @@ -0,0 +1,486 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2024 SiFive
> > + *
> > + * Authors
> > + *   Zong Li <zong.li@sifive.com>
> > + */
> > +
> > +#include <linux/io-64-nonatomic-hi-lo.h>
> > +
> > +#include "iommu.h"
> > +#include "iommu-bits.h"
> > +
> > +#define to_riscv_iommu_pmu(p) (container_of(p, struct riscv_iommu_pmu,=
 pmu))
> > +
> > +#define RISCV_IOMMU_PMU_ATTR_EXTRACTOR(_name, _mask)                 \
> > +     static inline u32 get_##_name(struct perf_event *event)         \
> > +     {                                                               \
> > +             return FIELD_GET(_mask, event->attr.config);            \
> > +     }                                                               \
> > +
> > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(event, RISCV_IOMMU_IOHPMEVT_EVENTID);
> > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(partial_matching, RISCV_IOMMU_IOHPMEVT_=
DMASK);
> > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(pid_pscid, RISCV_IOMMU_IOHPMEVT_PID_PSC=
ID);
> > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(did_gscid, RISCV_IOMMU_IOHPMEVT_DID_GSC=
ID);
> > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(filter_pid_pscid, RISCV_IOMMU_IOHPMEVT_=
PV_PSCV);
> > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(filter_did_gscid, RISCV_IOMMU_IOHPMEVT_=
DV_GSCV);
> > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(filter_id_type, RISCV_IOMMU_IOHPMEVT_ID=
T);
> > +
> > +/* Formats */
> > +PMU_FORMAT_ATTR(event, "config:0-14");
> > +PMU_FORMAT_ATTR(partial_matching, "config:15");
> > +PMU_FORMAT_ATTR(pid_pscid, "config:16-35");
> > +PMU_FORMAT_ATTR(did_gscid, "config:36-59");
> > +PMU_FORMAT_ATTR(filter_pid_pscid, "config:60");
> > +PMU_FORMAT_ATTR(filter_did_gscid, "config:61");
> > +PMU_FORMAT_ATTR(filter_id_type, "config:62");
> > +
> > +static struct attribute *riscv_iommu_pmu_formats[] =3D {
> > +     &format_attr_event.attr,
> > +     &format_attr_partial_matching.attr,
> > +     &format_attr_pid_pscid.attr,
> > +     &format_attr_did_gscid.attr,
> > +     &format_attr_filter_pid_pscid.attr,
> > +     &format_attr_filter_did_gscid.attr,
> > +     &format_attr_filter_id_type.attr,
> > +     NULL,
> > +};
> > +
> > +static const struct attribute_group riscv_iommu_pmu_format_group =3D {
> > +     .name =3D "format",
> > +     .attrs =3D riscv_iommu_pmu_formats,
> > +};
> > +
> > +/* Events */
> > +static ssize_t riscv_iommu_pmu_event_show(struct device *dev,
> > +                                       struct device_attribute *attr,
> > +                                       char *page)
> > +{
> > +     struct perf_pmu_events_attr *pmu_attr;
> > +
> > +     pmu_attr =3D container_of(attr, struct perf_pmu_events_attr, attr=
);
> > +
> > +     return sprintf(page, "event=3D0x%02llx\n", pmu_attr->id);
>
> sysfs_emit()
>

Thanks for pointig it out.

> > +}
> > +
> > +PMU_EVENT_ATTR(cycle, event_attr_cycle,
> > +            RISCV_IOMMU_HPMEVENT_CYCLE, riscv_iommu_pmu_event_show);
> > +PMU_EVENT_ATTR(dont_count, event_attr_dont_count,
> > +            RISCV_IOMMU_HPMEVENT_INVALID, riscv_iommu_pmu_event_show);
> > +PMU_EVENT_ATTR(untranslated_req, event_attr_untranslated_req,
> > +            RISCV_IOMMU_HPMEVENT_URQ, riscv_iommu_pmu_event_show);
> > +PMU_EVENT_ATTR(translated_req, event_attr_translated_req,
> > +            RISCV_IOMMU_HPMEVENT_TRQ, riscv_iommu_pmu_event_show);
> > +PMU_EVENT_ATTR(ats_trans_req, event_attr_ats_trans_req,
> > +            RISCV_IOMMU_HPMEVENT_ATS_RQ, riscv_iommu_pmu_event_show);
> > +PMU_EVENT_ATTR(tlb_miss, event_attr_tlb_miss,
> > +            RISCV_IOMMU_HPMEVENT_TLB_MISS, riscv_iommu_pmu_event_show)=
;
> > +PMU_EVENT_ATTR(ddt_walks, event_attr_ddt_walks,
> > +            RISCV_IOMMU_HPMEVENT_DD_WALK, riscv_iommu_pmu_event_show);
> > +PMU_EVENT_ATTR(pdt_walks, event_attr_pdt_walks,
> > +            RISCV_IOMMU_HPMEVENT_PD_WALK, riscv_iommu_pmu_event_show);
> > +PMU_EVENT_ATTR(s_vs_pt_walks, event_attr_s_vs_pt_walks,
> > +            RISCV_IOMMU_HPMEVENT_S_VS_WALKS, riscv_iommu_pmu_event_sho=
w);
> > +PMU_EVENT_ATTR(g_pt_walks, event_attr_g_pt_walks,
> > +            RISCV_IOMMU_HPMEVENT_G_WALKS, riscv_iommu_pmu_event_show);
> > +
> > +static struct attribute *riscv_iommu_pmu_events[] =3D {
> > +     &event_attr_cycle.attr.attr,
> > +     &event_attr_dont_count.attr.attr,
> > +     &event_attr_untranslated_req.attr.attr,
> > +     &event_attr_translated_req.attr.attr,
> > +     &event_attr_ats_trans_req.attr.attr,
> > +     &event_attr_tlb_miss.attr.attr,
> > +     &event_attr_ddt_walks.attr.attr,
> > +     &event_attr_pdt_walks.attr.attr,
> > +     &event_attr_s_vs_pt_walks.attr.attr,
> > +     &event_attr_g_pt_walks.attr.attr,
> > +     NULL,
> > +};
> > +
> > +static const struct attribute_group riscv_iommu_pmu_events_group =3D {
> > +     .name =3D "events",
> > +     .attrs =3D riscv_iommu_pmu_events,
> > +};
> > +
> > +static const struct attribute_group *riscv_iommu_pmu_attr_grps[] =3D {
> > +     &riscv_iommu_pmu_format_group,
> > +     &riscv_iommu_pmu_events_group,
> > +     NULL,
> > +};
>
> You also need a "cpumask" attribute to tell userspace this is a
> system/uncore PMU.

Thanks.

>
> > +
> > +/* PMU Operations */
> > +static void riscv_iommu_pmu_set_counter(struct riscv_iommu_pmu *pmu, u=
32 idx,
> > +                                     u64 value)
> > +{
> > +     void __iomem *addr =3D pmu->reg + RISCV_IOMMU_REG_IOHPMCYCLES;
> > +
> > +     if (WARN_ON_ONCE(idx < 0 || idx > pmu->num_counters))
>
> One of those conditions is literally impossible, the other should
> already be avoided by construction.
>

Let me remove this condition check.

> > +             return;
> > +
> > +     if (idx =3D=3D 0)
> > +             value =3D (value & ~RISCV_IOMMU_IOHPMCYCLES_OF) |
> > +                      (readq(addr) & RISCV_IOMMU_IOHPMCYCLES_OF);
>
> I don't think you need this - as best I can tell, you never initialise a
> counter without also (re)enabling the interrupt (which is logical), so
> since "value" for the cycle counter should always implicitly have OF=3D0
> anyway, it should work to just write it like the other counters.
>
> > +     writeq(FIELD_PREP(RISCV_IOMMU_IOHPMCTR_COUNTER, value), addr + id=
x * 8);
>
> Is RISCV_IOMMU_IOHPMCTR_COUNTER honestly useful? Or is it actively
> hurting readability by obfuscating that we are in fact just using the
> full 64-bit value in all those places?

It should be riscv_iommu_pmu->mask_counter, as the valid width is
hardware-implemented.
Although we can still write a 64-bit value here since the register is
WARL, I think it would be more readable
if we mask the valid bit here. This way, we can be aware that the
valid width might not be the full 64 bits

>
> > +}
> > +
> > +static u64 riscv_iommu_pmu_get_counter(struct riscv_iommu_pmu *pmu, u3=
2 idx)
> > +{
> > +     void __iomem *addr =3D pmu->reg + RISCV_IOMMU_REG_IOHPMCYCLES;
> > +     u64 value;
> > +
> > +     if (WARN_ON_ONCE(idx < 0 || idx > pmu->num_counters))
> > +             return -EINVAL;
> > +
> > +     value =3D readq(addr + idx * 8);
>
> Might be worth leaving a comment just in case anyone does try to enable
> this for 32-bit that the io-64-nonatomic readq() isn't enough to work
> properly here.

I guess you are referring to a 32-bit width counter, is that correct?
Because It should be fine on a 32-bit system
since readq will be defined as hi_lo_readq.
For a 32-bit width counter, the return value will be masked with the
valid width, so I think it should work as expected
 Does that make sense?

>
> > +
> > +     if (idx =3D=3D 0)
> > +             return FIELD_GET(RISCV_IOMMU_IOHPMCYCLES_COUNTER, value);
> > +
> > +     return FIELD_GET(RISCV_IOMMU_IOHPMCTR_COUNTER, value);
> > +}
> > +
> > +static u64 riscv_iommu_pmu_get_event(struct riscv_iommu_pmu *pmu, u32 =
idx)
> > +{
> > +     void __iomem *addr =3D pmu->reg + RISCV_IOMMU_REG_IOHPMEVT_BASE;
> > +
> > +     if (WARN_ON_ONCE(idx < 0 || idx > pmu->num_counters))
> > +             return 0;
> > +
> > +     /* There is no associtated IOHPMEVT0 for IOHPMCYCLES */
> > +     if (idx =3D=3D 0)
> > +             return 0;
> > +
> > +     return readq(addr + (idx - 1) * 8);
> > +}
>
> That's a wonderfully expensive way to spell "pmu->events[idx]->hw.config"=
...
>

Yes, I think we can use what we store in memory
(pmu->event[idx]->hw.config). The contents are consistent.

> > +
> > +static void riscv_iommu_pmu_set_event(struct riscv_iommu_pmu *pmu, u32=
 idx,
> > +                                   u64 value)
> > +{
> > +     void __iomem *addr =3D pmu->reg + RISCV_IOMMU_REG_IOHPMEVT_BASE;
> > +
> > +     if (WARN_ON_ONCE(idx < 0 || idx > pmu->num_counters))
> > +             return;
> > +
> > +     /* There is no associtated IOHPMEVT0 for IOHPMCYCLES */
> > +     if (idx =3D=3D 0)
> > +             return;
> > +
> > +     writeq(value, addr + (idx - 1) * 8);
> > +}
> > +
> > +static void riscv_iommu_pmu_enable_counter(struct riscv_iommu_pmu *pmu=
, u32 idx)
> > +{
> > +     void __iomem *addr =3D pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH;
> > +     u32 value =3D readl(addr);
> > +
> > +     writel(value & ~BIT(idx), addr);
> > +}
> > +
> > +static void riscv_iommu_pmu_disable_counter(struct riscv_iommu_pmu *pm=
u, u32 idx)
> > +{
> > +     void __iomem *addr =3D pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH;
> > +     u32 value =3D readl(addr);
> > +
> > +     writel(value | BIT(idx), addr);
> > +}
> > +
> > +static void riscv_iommu_pmu_enable_ovf_intr(struct riscv_iommu_pmu *pm=
u, u32 idx)
> > +{
> > +     u64 value;
> > +
> > +     if (get_event(pmu->events[idx]) =3D=3D RISCV_IOMMU_HPMEVENT_CYCLE=
) {
>
> And that's a very creative way to spell "if (idx =3D=3D 0)".

Let's use value of idx directly.

>
> > +             value =3D riscv_iommu_pmu_get_counter(pmu, idx) & ~RISCV_=
IOMMU_IOHPMCYCLES_OF;
> > +             writeq(value, pmu->reg + RISCV_IOMMU_REG_IOHPMCYCLES);
>
> (and as above, I think you can make this a no-op for the cycle counter)

Let's remove it.

>
> > +     } else {
> > +             value =3D riscv_iommu_pmu_get_event(pmu, idx) & ~RISCV_IO=
MMU_IOHPMEVT_OF;
> > +             writeq(value, pmu->reg + RISCV_IOMMU_REG_IOHPMEVT_BASE + =
(idx - 1) * 8);
> > +     }
> > +}
> > +
> > +static void riscv_iommu_pmu_disable_ovf_intr(struct riscv_iommu_pmu *p=
mu, u32 idx)
> > +{
> > +     u64 value;
> > +
> > +     if (get_event(pmu->events[idx]) =3D=3D RISCV_IOMMU_HPMEVENT_CYCLE=
) {
> > +             value =3D riscv_iommu_pmu_get_counter(pmu, idx) | RISCV_I=
OMMU_IOHPMCYCLES_OF;
> > +             writeq(value, pmu->reg + RISCV_IOMMU_REG_IOHPMCYCLES);
> > +     } else {
> > +             value =3D riscv_iommu_pmu_get_event(pmu, idx) | RISCV_IOM=
MU_IOHPMEVT_OF;
> > +             writeq(value, pmu->reg + RISCV_IOMMU_REG_IOHPMEVT_BASE + =
(idx - 1) * 8);
> > +     }
> > +}
>
> TBH I'd be inclined to just leave out all the dead cleanup code if the
> PMU driver is tied to the IOMMU driver and can never realistically be
> removed.

Yes, but riscv_iommu_remove has been implemented. Does it still make
sense to clean up the PMU when certain cases enter riscv_iommu_remove?

>
> > +static void riscv_iommu_pmu_start_all(struct riscv_iommu_pmu *pmu)
> > +{
> > +     int idx;
> > +
> > +     for_each_set_bit(idx, pmu->used_counters, pmu->num_counters) {
> > +             riscv_iommu_pmu_enable_ovf_intr(pmu, idx);
>
> Surely this should only touch the counter(s) that overflowed and have
> been handled? It might be cleaner to keep that within the IRQ handler
> itself.
>

Yes, let me move it into the IRQ handler and handle only the counters
that have overflowed.

> > +             riscv_iommu_pmu_enable_counter(pmu, idx);
>
> This needs to start all active counters together, not one-by-one.
>

Ok, I think we need a new wrapper to achieve it.

> > +     }
> > +}
> > +
> > +static void riscv_iommu_pmu_stop_all(struct riscv_iommu_pmu *pmu)
> > +{
> > +     writel(GENMASK_ULL(pmu->num_counters - 1, 0),
> > +            pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH);
> > +}
> > +
> > +/* PMU APIs */
> > +static int riscv_iommu_pmu_set_period(struct perf_event *event)
> > +{
> > +     struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> > +     struct hw_perf_event *hwc =3D &event->hw;
> > +     s64 left =3D local64_read(&hwc->period_left);
> > +     s64 period =3D hwc->sample_period;
> > +     u64 max_period =3D pmu->mask_counter;
> > +     int ret =3D 0;
> > +
> > +     if (unlikely(left <=3D -period)) {
> > +             left =3D period;
> > +             local64_set(&hwc->period_left, left);
> > +             hwc->last_period =3D period;
> > +             ret =3D 1;
> > +     }
> > +
> > +     if (unlikely(left <=3D 0)) {
> > +             left +=3D period;
> > +             local64_set(&hwc->period_left, left);
> > +             hwc->last_period =3D period;
> > +             ret =3D 1;
> > +     }
>
> None of this is relevant or necessary. This is not a CPU PMU, so it
> can't support sampling because it doesn't have a meaningful context to
> sample.
>
> > +     /*
> > +      * Limit the maximum period to prevent the counter value
> > +      * from overtaking the one we are about to program. In
> > +      * effect we are reducing max_period to account for
> > +      * interrupt latency (and we are being very conservative).
> > +      */
> > +     if (left > (max_period >> 1))
> > +             left =3D (max_period >> 1);
> > +
> > +     local64_set(&hwc->prev_count, (u64)-left);
> > +     riscv_iommu_pmu_set_counter(pmu, hwc->idx, (u64)(-left) & max_per=
iod);
> > +     perf_event_update_userpage(event);
> > +
> > +     return ret;
> > +}
> > +
> > +static int riscv_iommu_pmu_event_init(struct perf_event *event)
> > +{
> > +     struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> > +     struct hw_perf_event *hwc =3D &event->hw;
>
> You first need to validate that the event is for this PMU at all, and
> return -ENOENT if not.

Thanks for pointing it out. I will add event check here.

>
> > +     hwc->idx =3D -1;
> > +     hwc->config =3D event->attr.config;
> > +
> > +     if (!is_sampling_event(event)) {
>
> As above, you can't support sampling events anyway, so you should reject
> them with -EINVAL.
>
> You also need to validate event groups to ensure they don't contain more
> events than could ever be scheduled at once.

Check event group in the next version.

>
> > +             /*
> > +              * For non-sampling runs, limit the sample_period to half
> > +              * of the counter width. That way, the new counter value
> > +              * is far less likely to overtake the previous one unless
> > +              * you have some serious IRQ latency issues.
> > +              */
> > +             hwc->sample_period =3D pmu->mask_counter >> 1;
> > +             hwc->last_period =3D hwc->sample_period;
> > +             local64_set(&hwc->period_left, hwc->sample_period);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void riscv_iommu_pmu_update(struct perf_event *event)
> > +{
> > +     struct hw_perf_event *hwc =3D &event->hw;
> > +     struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> > +     u64 delta, prev, now;
> > +     u32 idx =3D hwc->idx;
> > +
> > +     do {
> > +             prev =3D local64_read(&hwc->prev_count);
> > +             now =3D riscv_iommu_pmu_get_counter(pmu, idx);
> > +     } while (local64_cmpxchg(&hwc->prev_count, prev, now) !=3D prev);
> > +
> > +     delta =3D FIELD_GET(RISCV_IOMMU_IOHPMCTR_COUNTER, now - prev) & p=
mu->mask_counter;
> > +     local64_add(delta, &event->count);
> > +     local64_sub(delta, &hwc->period_left);
> > +}
> > +
> > +static void riscv_iommu_pmu_start(struct perf_event *event, int flags)
> > +{
> > +     struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> > +     struct hw_perf_event *hwc =3D &event->hw;
> > +
> > +     if (WARN_ON_ONCE(!(event->hw.state & PERF_HES_STOPPED)))
> > +             return;
> > +
> > +     if (flags & PERF_EF_RELOAD)
> > +             WARN_ON_ONCE(!(event->hw.state & PERF_HES_UPTODATE));
> > +
> > +     hwc->state =3D 0;
> > +     riscv_iommu_pmu_set_period(event);
> > +     riscv_iommu_pmu_set_event(pmu, hwc->idx, hwc->config);
> > +     riscv_iommu_pmu_enable_ovf_intr(pmu, hwc->idx);
>
> This does nothing, since set_event has just implicitly written OF=3D0.
>
> ...unless, that is, the user was mischievous and also set bit 63 in
> event->attr.config, since you never sanitised the input ;)

Ok, and I think we need to mask the input with valid width.

>
> > +     riscv_iommu_pmu_enable_counter(pmu, hwc->idx);
> > +
> > +     perf_event_update_userpage(event);
> > +}
> > +
> > +static void riscv_iommu_pmu_stop(struct perf_event *event, int flags)
> > +{
> > +     struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> > +     struct hw_perf_event *hwc =3D &event->hw;
> > +
> > +     if (hwc->state & PERF_HES_STOPPED)
> > +             return;
> > +
> > +     riscv_iommu_pmu_set_event(pmu, hwc->idx, RISCV_IOMMU_HPMEVENT_INV=
ALID);
> > +     riscv_iommu_pmu_disable_counter(pmu, hwc->idx);
> > +
> > +     if ((flags & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE)=
)
> > +             riscv_iommu_pmu_update(event);
> > +
> > +     hwc->state |=3D PERF_HES_STOPPED | PERF_HES_UPTODATE;
> > +}
> > +
> > +static int riscv_iommu_pmu_add(struct perf_event *event, int flags)
> > +{
> > +     struct hw_perf_event *hwc =3D &event->hw;
> > +     struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> > +     unsigned int num_counters =3D pmu->num_counters;
> > +     int idx;
> > +
> > +     /* Reserve index zero for iohpmcycles */
> > +     if (get_event(event) =3D=3D RISCV_IOMMU_HPMEVENT_CYCLE)
> > +             idx =3D 0;
> > +     else
> > +             idx =3D find_next_zero_bit(pmu->used_counters, num_counte=
rs, 1);
> > +
> > +     if (idx =3D=3D num_counters)
> > +             return -EAGAIN;
>
> But stomping a cycles event on top of an existing cycles event is fine?

Yes, we need a way to check this situation and return failure.

>
> > +     set_bit(idx, pmu->used_counters);
> > +
> > +     pmu->events[idx] =3D event;
> > +     hwc->idx =3D idx;
> > +     hwc->state =3D PERF_HES_STOPPED | PERF_HES_UPTODATE;
> > +
> > +     if (flags & PERF_EF_START)
> > +             riscv_iommu_pmu_start(event, flags);
> > +
> > +     /* Propagate changes to the userspace mapping. */
> > +     perf_event_update_userpage(event);
> > +
> > +     return 0;
> > +}
> > +
> > +static void riscv_iommu_pmu_read(struct perf_event *event)
> > +{
> > +     riscv_iommu_pmu_update(event);
> > +}
> > +
> > +static void riscv_iommu_pmu_del(struct perf_event *event, int flags)
> > +{
> > +     struct hw_perf_event *hwc =3D &event->hw;
> > +     struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> > +     int idx =3D hwc->idx;
> > +
> > +     riscv_iommu_pmu_stop(event, PERF_EF_UPDATE);
> > +     pmu->events[idx] =3D NULL;
> > +     clear_bit(idx, pmu->used_counters);
> > +     perf_event_update_userpage(event);
> > +}
> > +
> > +irqreturn_t riscv_iommu_pmu_handle_irq(struct riscv_iommu_pmu *pmu)
> > +{
> > +     struct perf_sample_data data;
> > +     struct pt_regs *regs;
> > +     u32 ovf =3D readl(pmu->reg + RISCV_IOMMU_REG_IOCOUNTOVF);
> > +     int idx;
> > +
> > +     if (!ovf)
> > +             return IRQ_NONE;
> > +
> > +     riscv_iommu_pmu_stop_all(pmu);
> > +
> > +     regs =3D get_irq_regs();
>
> What do these regs represent? If you look at the perf_event_open ABI,
> you'll see that events can target various combinations of CPU and/or
> pid, but there is no encoding for "whichever CPU takes the IOMMU PMU
> interrupt". Thus whatever you get here is more than likely not what the
> user asked for, and this is why non-CPU PMUs cannot reasonably support
> sampling ;)
>

There are some comments related to removing sampling, and I can't
completely understand them.
Please correct me if I am misunderstanding.
If the user doesn't specify a target CPU, does this situation make
sense for non-CPU PMUs? If so,
should the user be aware that they are using non-CPU PMUs and should
use them by system-wide?
Otherwise, the behavior would be unexpected.
Could you please help me understand it better? Thank you

> > +
> > +     for_each_set_bit(idx, (unsigned long *)&ovf, pmu->num_counters) {
> > +             struct perf_event *event =3D pmu->events[idx];
> > +             struct hw_perf_event *hwc;
> > +
> > +             if (WARN_ON_ONCE(!event) || !is_sampling_event(event))
>
> You still need to handle counter rollover for all events, otherwise they
> can start losing counts and rapidly turn to nonsense. Admittedly it's
> largely theoretical with full 64-bit counters, but still...

Ok. Let's fix it in the next version.

>
> > +                     continue;
> > +
> > +             hwc =3D &event->hw;
> > +
> > +             riscv_iommu_pmu_update(event);
> > +             perf_sample_data_init(&data, 0, hwc->last_period);
> > +             if (!riscv_iommu_pmu_set_period(event))
> > +                     continue;
> > +
> > +             if (perf_event_overflow(event, &data, regs))
> > +                     riscv_iommu_pmu_stop(event, 0);
> > +     }
> > +
> > +     riscv_iommu_pmu_start_all(pmu);
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +int riscv_iommu_pmu_init(struct riscv_iommu_pmu *pmu, void __iomem *re=
g,
> > +                      const char *dev_name)
> > +{
> > +     char *name;
> > +     int ret;
> > +
> > +     pmu->reg =3D reg;
> > +     pmu->num_counters =3D RISCV_IOMMU_HPM_COUNTER_NUM;
> > +     pmu->mask_counter =3D RISCV_IOMMU_IOHPMCTR_COUNTER;
>
> Initially this looks weird - why bother storing constants in memory if
> they're constant? - but I see the spec implies they are not necessarily
> fixed, and we can only actually assume at least one counter at least 32
> bits wide, so I guess this is really more of a placeholder? Is there a
> well-defined way we're supposed to be able to discover these, like some
> more ID register fields somewhere, or writing all 1s to various
> registers to see what sticks, or is it liable to be a mess of just
> having to know what each implementation has by matching DT compatibles
> and/or PCI IDs?

As you mentioned, the idea is that the valid width of the counter and
the number of counters are hardware-implemented.
My original plan was to submit another series to add vendor-specific
implementations, using matching data to indicate these two values.
However, based on your suggestion, I think we only need to specify
num_counter, as mask_counter can be detected by writing all 1s.

In the next version, I could check whether pmu->num_counters is 0
before setting num_counter to default value, then it looks more
reasonable. Does that make sense to you?

>
> > +
> > +     pmu->pmu =3D (struct pmu) {
> > +             .task_ctx_nr    =3D perf_invalid_context,
> > +             .event_init     =3D riscv_iommu_pmu_event_init,
> > +             .add            =3D riscv_iommu_pmu_add,
> > +             .del            =3D riscv_iommu_pmu_del,
> > +             .start          =3D riscv_iommu_pmu_start,
> > +             .stop           =3D riscv_iommu_pmu_stop,
> > +             .read           =3D riscv_iommu_pmu_read,
> > +             .attr_groups    =3D riscv_iommu_pmu_attr_grps,
> > +             .capabilities   =3D PERF_PMU_CAP_NO_EXCLUDE,
> > +             .module         =3D THIS_MODULE,
> > +     };
>
> The new thing is that you can now set pmu.parent to the IOMMU device so
> their relationship is clear in sysfs, rather than having to play tricks
> with the PMU name.

Let me add it.

>
> > +
> > +     name =3D kasprintf(GFP_KERNEL, "riscv_iommu_pmu_%s", dev_name);
> > +
> > +     ret =3D perf_pmu_register(&pmu->pmu, name, -1);
> > +     if (ret) {
> > +             pr_err("Failed to register riscv_iommu_pmu_%s: %d\n",
> > +                    dev_name, ret);
> > +             return ret;
> > +     }
> > +
> > +     /* Stop all counters and later start the counter with perf */
> > +     riscv_iommu_pmu_stop_all(pmu);
> > +
> > +     pr_info("riscv_iommu_pmu_%s: Registered with %d counters\n",
> > +             dev_name, pmu->num_counters);
> > +
> > +     return 0;
> > +}
> > +
> > +void riscv_iommu_pmu_uninit(struct riscv_iommu_pmu *pmu)
> > +{
> > +     int idx;
> > +
> > +     /* Disable interrupt and functions */
> > +     for_each_set_bit(idx, pmu->used_counters, pmu->num_counters) {
>
> This will never do anything, since even if we could ever get here, it
> would not be at a time when there are any active events. Unregistering
> an in-use PMU does not end well (hence why standalone PMU drivers need
> to use suppress_bind_attrs)...

Okay, let's remove it. Thanks

>
> Thanks,
> Robin.
>
> > +             riscv_iommu_pmu_disable_counter(pmu, idx);
> > +             riscv_iommu_pmu_disable_ovf_intr(pmu, idx);
> > +     }
> > +
> > +     perf_pmu_unregister(&pmu->pmu);
> > +}
> > diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
> > index b1c4664542b4..92659a8a75ae 100644
> > --- a/drivers/iommu/riscv/iommu.h
> > +++ b/drivers/iommu/riscv/iommu.h
> > @@ -60,11 +60,19 @@ struct riscv_iommu_device {
> >       unsigned int ddt_mode;
> >       dma_addr_t ddt_phys;
> >       u64 *ddt_root;
> > +
> > +     /* hardware performance monitor */
> > +     struct riscv_iommu_pmu pmu;
> >   };
> >
> >   int riscv_iommu_init(struct riscv_iommu_device *iommu);
> >   void riscv_iommu_remove(struct riscv_iommu_device *iommu);
> >
> > +int riscv_iommu_pmu_init(struct riscv_iommu_pmu *pmu, void __iomem *re=
g,
> > +                      const char *name);
> > +void riscv_iommu_pmu_uninit(struct riscv_iommu_pmu *pmu);
> > +irqreturn_t riscv_iommu_pmu_handle_irq(struct riscv_iommu_pmu *pmu);
> > +
> >   #define riscv_iommu_readl(iommu, addr) \
> >       readl_relaxed((iommu)->reg + (addr))
> >
>
