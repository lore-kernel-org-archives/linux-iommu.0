Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB28D284A69
	for <iommu@lists.linux.dev>; Wed, 15 Jan 2025 08:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736929533; cv=none; b=e8zoS68GsXrCG4PPzZGEsy+8+1xxY2Lq16DxBZaJfQg8hbxaKig+2M/Q68Jnre03rmW4R9XDEaAjbq8CjgtdKw8E9rYgcC8qcCbCxZLOP9bPjkRIJXLes3KUiYMEjITaYbfn85WJGWlZp62DfgmE0N5Q1aFRbrL13j8N2cVBPz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736929533; c=relaxed/simple;
	bh=7iaCNdPiufiOn7dAjw8AXlwkHVICWcv9160B/XQ/rPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ripYpzZyfP/dPfUaFrevQgF7sqx+M5VrXSVK97h+JynVWNgcWTayGf0fiXctP+eUaQ+3zSoYWKQ+zfWhpLWjm9ZxS6AYBdIR9GV+CJDFAfn2KOQC7uco2KiSI3eTBYGYyThBCRvJ6AmgcsC9CSeumzKfrBozkvQxpdvQzd7pz08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dYJvYXHC; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dYJvYXHC"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ef87d24c2dso8463921a91.1
        for <iommu@lists.linux.dev>; Wed, 15 Jan 2025 00:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736929530; x=1737534330; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ID0tug8pjqt4u96YXUcNt3kkNxDciR93qg+2l0m5Yig=;
        b=dYJvYXHCffMTtWujvT6RrQw36Y8jUmIhCdQYMoGyo29OxzkWXhCkldTMs8GEKs/LJ/
         IGbDq5LKUjso4lG7J8QgLqszbifcJcdMr21kGy9F3Iwl0E35NicEFUFhvBr6frDS4PGN
         IB6BzeefSvP7Jt8VtwiOnIJ9TRmQf+RiZsLZ8N11jNnKqfwkdXSlGKHLf3EwKKhfqy5C
         nV3kaMBJTcP+mR3BoJE04vus/zDcafurMCy2fLoLfw9tSjGQ/ZhvoON7enyRcDJlEig6
         SG2JcZWypghuZhGN1uGV7iOz1liNQVtv2y3RWFAsbGzZkOPkzNFIBqv//b1saUMliUGe
         8lLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736929530; x=1737534330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ID0tug8pjqt4u96YXUcNt3kkNxDciR93qg+2l0m5Yig=;
        b=P8IeGX646nPDdgYANsEM8kvrYKWegyzFOucgZhcSvEDZs4U/51eV1g7PJYp+8AAVEs
         LgtF0Pca0jwACcg5OLKgjq21hnRq+brZ2z+6Hp1wYldeJKUpsN5Izt1p0SYqe9Fq9lac
         BbvRAsJLfFntcBWKPZ/NIlKJS14C9XDiPXRcrfXvan/sJ9XTFjZ1JXzqyKKs3MzU4oyz
         h9jeOP12D7fcT3Y+0QRmt7pqZ2bgndAZmHBdG+2IjuhxyWrFL51tgcOTL39s40MdOqcs
         HUcCpRSvR4ILnevVP/FmC4CjZ7S6bNI9U6gUjes/ygaeEZO2YPtE5Rg7khOkq+npZPTX
         Yg9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXdsQspwaejYVG/bQgX7vmJsARoDVCbxFXEqm8I3+oRDgXSL0XU4Mp+oxGRAyHWy0MomKKDLg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzGCLOyGwghY92jQMjIb2Yl15I4IB6dy8hB7v1R4rySEKdyyaY9
	EcUv+RUUzm1lq2KyUwDOAF9quG6r+rnuT/baFzFMyOLGFLBipZ38PF7cBxCB75qmib19yY+1Ekb
	Pz2bbIBflIHTNUxm/+FlwaJKyarquqeRrXmqr4w==
X-Gm-Gg: ASbGncvVkjXf+Cln2XgFVCBmv/jSd0DdZujngDlA/pnr0OzbjbVfavSuJHMnXPXkvmU
	9pYQjC7Cig1DMxZOJB9hkI10lCl9ZMR83tXZTHf1rQggF04Lf6a0=
X-Google-Smtp-Source: AGHT+IGODKZp8emw/qkJiqIRLg6TeUKs8A2cWU7B7WmbifdI4jqu7li8RQY0rZmyN0mgVVHtZBF/K1Hc4PjcULmkWN4=
X-Received: by 2002:a17:90b:2c84:b0:2ee:8430:b831 with SMTP id
 98e67ed59e1d1-2f548f1628fmr43000924a91.2.1736929530084; Wed, 15 Jan 2025
 00:25:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250115030306.29735-1-zong.li@sifive.com> <20250115030306.29735-2-zong.li@sifive.com>
 <CAPYmKFueq8dZspxM-UNBoK2Fh-ynyUJdb_P-SyjFqCZ6tFQ_eA@mail.gmail.com> <CANXhq0pZjGL2a8wZK+jEFoQXHbNBKM_MinN6QdLQ0OyuiPM5yw@mail.gmail.com>
In-Reply-To: <CANXhq0pZjGL2a8wZK+jEFoQXHbNBKM_MinN6QdLQ0OyuiPM5yw@mail.gmail.com>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Wed, 15 Jan 2025 16:25:19 +0800
X-Gm-Features: AbW1kvaX6oXOXF7d-5EmbUOXhMjSuwECHJsEqKoEHCZ-akfcryyEHH87vECePTU
Message-ID: <CAPYmKFs-DCvTtH9SqrcqhxH9hn1d9w9Z2vu4FrE0LG=H9QnT1Q@mail.gmail.com>
Subject: Re: [External] [PATCH 1/2] iommu/riscv: add RISC-V IOMMU PMU support
To: Zong Li <zong.li@sifive.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 3:49=E2=80=AFPM Zong Li <zong.li@sifive.com> wrote:
>
> On Wed, Jan 15, 2025 at 11:45=E2=80=AFAM Xu Lu <luxu.kernel@bytedance.com=
> wrote:
> >
> > Hi Zong,
> >
> > On Wed, Jan 15, 2025 at 11:03=E2=80=AFAM Zong Li <zong.li@sifive.com> w=
rote:
> > >
> > > Support for the RISC-V IOMMU hardware performance monitor includes
> > > both counting and sampling modes.
> > >
> > > The specification does not define an event ID for counting the
> > > number of clock cycles, meaning there is no associated `iohpmevt0`.
> > > However, we need an event for counting cycle, so we reserve the
> > > maximum event ID for this purpose.
> > >
> > > Signed-off-by: Zong Li <zong.li@sifive.com>
> > > Tested-by: Xu Lu <luxu.kernel@bytedance.com>
> > > ---
> > >  drivers/iommu/riscv/Makefile     |   2 +-
> > >  drivers/iommu/riscv/iommu-bits.h |  16 +
> > >  drivers/iommu/riscv/iommu-pmu.c  | 486 +++++++++++++++++++++++++++++=
++
> > >  drivers/iommu/riscv/iommu.h      |   8 +
> > >  4 files changed, 511 insertions(+), 1 deletion(-)
> > >  create mode 100644 drivers/iommu/riscv/iommu-pmu.c
> > >
> > > diff --git a/drivers/iommu/riscv/Makefile b/drivers/iommu/riscv/Makef=
ile
> > > index f54c9ed17d41..d36625a1fd08 100644
> > > --- a/drivers/iommu/riscv/Makefile
> > > +++ b/drivers/iommu/riscv/Makefile
> > > @@ -1,3 +1,3 @@
> > >  # SPDX-License-Identifier: GPL-2.0-only
> > > -obj-$(CONFIG_RISCV_IOMMU) +=3D iommu.o iommu-platform.o
> > > +obj-$(CONFIG_RISCV_IOMMU) +=3D iommu.o iommu-platform.o iommu-pmu.o
> > >  obj-$(CONFIG_RISCV_IOMMU_PCI) +=3D iommu-pci.o
> > > diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/i=
ommu-bits.h
> > > index 98daf0e1a306..60523449f016 100644
> > > --- a/drivers/iommu/riscv/iommu-bits.h
> > > +++ b/drivers/iommu/riscv/iommu-bits.h
> > > @@ -17,6 +17,7 @@
> > >  #include <linux/types.h>
> > >  #include <linux/bitfield.h>
> > >  #include <linux/bits.h>
> > > +#include <linux/perf_event.h>
> > >
> > >  /*
> > >   * Chapter 5: Memory Mapped register interface
> > > @@ -207,6 +208,7 @@ enum riscv_iommu_ddtp_modes {
> > >  /* 5.22 Performance monitoring event counters (31 * 64bits) */
> > >  #define RISCV_IOMMU_REG_IOHPMCTR_BASE  0x0068
> > >  #define RISCV_IOMMU_REG_IOHPMCTR(_n)   (RISCV_IOMMU_REG_IOHPMCTR_BAS=
E + ((_n) * 0x8))
> > > +#define RISCV_IOMMU_IOHPMCTR_COUNTER   GENMASK_ULL(63, 0)
> > >
> > >  /* 5.23 Performance monitoring event selectors (31 * 64bits) */
> > >  #define RISCV_IOMMU_REG_IOHPMEVT_BASE  0x0160
> > > @@ -250,6 +252,20 @@ enum riscv_iommu_hpmevent_id {
> > >         RISCV_IOMMU_HPMEVENT_MAX        =3D 9
> > >  };
> > >
> > > +/* Use maximum event ID for cycle event */
> > > +#define RISCV_IOMMU_HPMEVENT_CYCLE     GENMASK_ULL(14, 0)
> > > +
> > > +#define RISCV_IOMMU_HPM_COUNTER_NUM    32
> > > +
> > > +struct riscv_iommu_pmu {
> > > +       struct pmu pmu;
> > > +       void __iomem *reg;
> > > +       int num_counters;
> > > +       u64 mask_counter;
> > > +       struct perf_event *events[RISCV_IOMMU_IOHPMEVT_CNT + 1];
> > > +       DECLARE_BITMAP(used_counters, RISCV_IOMMU_IOHPMEVT_CNT + 1);
> > > +};
> > > +
> > >  /* 5.24 Translation request IOVA (64bits) */
> > >  #define RISCV_IOMMU_REG_TR_REQ_IOVA     0x0258
> > >  #define RISCV_IOMMU_TR_REQ_IOVA_VPN    GENMASK_ULL(63, 12)
> > > diff --git a/drivers/iommu/riscv/iommu-pmu.c b/drivers/iommu/riscv/io=
mmu-pmu.c
> > > new file mode 100644
> > > index 000000000000..74eb1525cd32
> > > --- /dev/null
> > > +++ b/drivers/iommu/riscv/iommu-pmu.c
> > > @@ -0,0 +1,486 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright (C) 2024 SiFive
> > > + *
> > > + * Authors
> > > + *     Zong Li <zong.li@sifive.com>
> > > + */
> > > +
> > > +#include <linux/io-64-nonatomic-hi-lo.h>
> > > +
> > > +#include "iommu.h"
> > > +#include "iommu-bits.h"
> > > +
> > > +#define to_riscv_iommu_pmu(p) (container_of(p, struct riscv_iommu_pm=
u, pmu))
> > > +
> > > +#define RISCV_IOMMU_PMU_ATTR_EXTRACTOR(_name, _mask)                =
   \
> > > +       static inline u32 get_##_name(struct perf_event *event)      =
   \
> > > +       {                                                            =
   \
> > > +               return FIELD_GET(_mask, event->attr.config);         =
   \
> > > +       }                                                            =
   \
> > > +
> > > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(event, RISCV_IOMMU_IOHPMEVT_EVENTID);
> > > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(partial_matching, RISCV_IOMMU_IOHPMEV=
T_DMASK);
> > > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(pid_pscid, RISCV_IOMMU_IOHPMEVT_PID_P=
SCID);
> > > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(did_gscid, RISCV_IOMMU_IOHPMEVT_DID_G=
SCID);
> > > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(filter_pid_pscid, RISCV_IOMMU_IOHPMEV=
T_PV_PSCV);
> > > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(filter_did_gscid, RISCV_IOMMU_IOHPMEV=
T_DV_GSCV);
> > > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(filter_id_type, RISCV_IOMMU_IOHPMEVT_=
IDT);
> > > +
> > > +/* Formats */
> > > +PMU_FORMAT_ATTR(event, "config:0-14");
> > > +PMU_FORMAT_ATTR(partial_matching, "config:15");
> > > +PMU_FORMAT_ATTR(pid_pscid, "config:16-35");
> > > +PMU_FORMAT_ATTR(did_gscid, "config:36-59");
> > > +PMU_FORMAT_ATTR(filter_pid_pscid, "config:60");
> > > +PMU_FORMAT_ATTR(filter_did_gscid, "config:61");
> > > +PMU_FORMAT_ATTR(filter_id_type, "config:62");
> > > +
> > > +static struct attribute *riscv_iommu_pmu_formats[] =3D {
> > > +       &format_attr_event.attr,
> > > +       &format_attr_partial_matching.attr,
> > > +       &format_attr_pid_pscid.attr,
> > > +       &format_attr_did_gscid.attr,
> > > +       &format_attr_filter_pid_pscid.attr,
> > > +       &format_attr_filter_did_gscid.attr,
> > > +       &format_attr_filter_id_type.attr,
> > > +       NULL,
> > > +};
> > > +
> > > +static const struct attribute_group riscv_iommu_pmu_format_group =3D=
 {
> > > +       .name =3D "format",
> > > +       .attrs =3D riscv_iommu_pmu_formats,
> > > +};
> > > +
> > > +/* Events */
> > > +static ssize_t riscv_iommu_pmu_event_show(struct device *dev,
> > > +                                         struct device_attribute *at=
tr,
> > > +                                         char *page)
> > > +{
> > > +       struct perf_pmu_events_attr *pmu_attr;
> > > +
> > > +       pmu_attr =3D container_of(attr, struct perf_pmu_events_attr, =
attr);
> > > +
> > > +       return sprintf(page, "event=3D0x%02llx\n", pmu_attr->id);
> > > +}
> > > +
> > > +PMU_EVENT_ATTR(cycle, event_attr_cycle,
> > > +              RISCV_IOMMU_HPMEVENT_CYCLE, riscv_iommu_pmu_event_show=
);
> > > +PMU_EVENT_ATTR(dont_count, event_attr_dont_count,
> > > +              RISCV_IOMMU_HPMEVENT_INVALID, riscv_iommu_pmu_event_sh=
ow);
> > > +PMU_EVENT_ATTR(untranslated_req, event_attr_untranslated_req,
> > > +              RISCV_IOMMU_HPMEVENT_URQ, riscv_iommu_pmu_event_show);
> > > +PMU_EVENT_ATTR(translated_req, event_attr_translated_req,
> > > +              RISCV_IOMMU_HPMEVENT_TRQ, riscv_iommu_pmu_event_show);
> > > +PMU_EVENT_ATTR(ats_trans_req, event_attr_ats_trans_req,
> > > +              RISCV_IOMMU_HPMEVENT_ATS_RQ, riscv_iommu_pmu_event_sho=
w);
> > > +PMU_EVENT_ATTR(tlb_miss, event_attr_tlb_miss,
> > > +              RISCV_IOMMU_HPMEVENT_TLB_MISS, riscv_iommu_pmu_event_s=
how);
> > > +PMU_EVENT_ATTR(ddt_walks, event_attr_ddt_walks,
> > > +              RISCV_IOMMU_HPMEVENT_DD_WALK, riscv_iommu_pmu_event_sh=
ow);
> > > +PMU_EVENT_ATTR(pdt_walks, event_attr_pdt_walks,
> > > +              RISCV_IOMMU_HPMEVENT_PD_WALK, riscv_iommu_pmu_event_sh=
ow);
> > > +PMU_EVENT_ATTR(s_vs_pt_walks, event_attr_s_vs_pt_walks,
> > > +              RISCV_IOMMU_HPMEVENT_S_VS_WALKS, riscv_iommu_pmu_event=
_show);
> > > +PMU_EVENT_ATTR(g_pt_walks, event_attr_g_pt_walks,
> > > +              RISCV_IOMMU_HPMEVENT_G_WALKS, riscv_iommu_pmu_event_sh=
ow);
> > > +
> > > +static struct attribute *riscv_iommu_pmu_events[] =3D {
> > > +       &event_attr_cycle.attr.attr,
> > > +       &event_attr_dont_count.attr.attr,
> > > +       &event_attr_untranslated_req.attr.attr,
> > > +       &event_attr_translated_req.attr.attr,
> > > +       &event_attr_ats_trans_req.attr.attr,
> > > +       &event_attr_tlb_miss.attr.attr,
> > > +       &event_attr_ddt_walks.attr.attr,
> > > +       &event_attr_pdt_walks.attr.attr,
> > > +       &event_attr_s_vs_pt_walks.attr.attr,
> > > +       &event_attr_g_pt_walks.attr.attr,
> > > +       NULL,
> > > +};
> > > +
> > > +static const struct attribute_group riscv_iommu_pmu_events_group =3D=
 {
> > > +       .name =3D "events",
> > > +       .attrs =3D riscv_iommu_pmu_events,
> > > +};
> > > +
> > > +static const struct attribute_group *riscv_iommu_pmu_attr_grps[] =3D=
 {
> > > +       &riscv_iommu_pmu_format_group,
> > > +       &riscv_iommu_pmu_events_group,
> > > +       NULL,
> > > +};
> > > +
> > > +/* PMU Operations */
> > > +static void riscv_iommu_pmu_set_counter(struct riscv_iommu_pmu *pmu,=
 u32 idx,
> > > +                                       u64 value)
> > > +{
> > > +       void __iomem *addr =3D pmu->reg + RISCV_IOMMU_REG_IOHPMCYCLES=
;
> > > +
> > > +       if (WARN_ON_ONCE(idx < 0 || idx > pmu->num_counters))
> > > +               return;
> > > +
> > > +       if (idx =3D=3D 0)
> > > +               value =3D (value & ~RISCV_IOMMU_IOHPMCYCLES_OF) |
> > > +                        (readq(addr) & RISCV_IOMMU_IOHPMCYCLES_OF);
> > > +
> > > +       writeq(FIELD_PREP(RISCV_IOMMU_IOHPMCTR_COUNTER, value), addr =
+ idx * 8);
> > > +}
> > > +
> > > +static u64 riscv_iommu_pmu_get_counter(struct riscv_iommu_pmu *pmu, =
u32 idx)
> > > +{
> > > +       void __iomem *addr =3D pmu->reg + RISCV_IOMMU_REG_IOHPMCYCLES=
;
> > > +       u64 value;
> > > +
> > > +       if (WARN_ON_ONCE(idx < 0 || idx > pmu->num_counters))
> > > +               return -EINVAL;
> > > +
> > > +       value =3D readq(addr + idx * 8);
> > > +
> > > +       if (idx =3D=3D 0)
> > > +               return FIELD_GET(RISCV_IOMMU_IOHPMCYCLES_COUNTER, val=
ue);
> > > +
> > > +       return FIELD_GET(RISCV_IOMMU_IOHPMCTR_COUNTER, value);
> > > +}
> > > +
> > > +static u64 riscv_iommu_pmu_get_event(struct riscv_iommu_pmu *pmu, u3=
2 idx)
> > > +{
> > > +       void __iomem *addr =3D pmu->reg + RISCV_IOMMU_REG_IOHPMEVT_BA=
SE;
> > > +
> > > +       if (WARN_ON_ONCE(idx < 0 || idx > pmu->num_counters))
> > > +               return 0;
> > > +
> > > +       /* There is no associtated IOHPMEVT0 for IOHPMCYCLES */
> > > +       if (idx =3D=3D 0)
> > > +               return 0;
> > > +
> > > +       return readq(addr + (idx - 1) * 8);
> > > +}
> > > +
> > > +static void riscv_iommu_pmu_set_event(struct riscv_iommu_pmu *pmu, u=
32 idx,
> > > +                                     u64 value)
> > > +{
> > > +       void __iomem *addr =3D pmu->reg + RISCV_IOMMU_REG_IOHPMEVT_BA=
SE;
> > > +
> > > +       if (WARN_ON_ONCE(idx < 0 || idx > pmu->num_counters))
> > > +               return;
> > > +
> > > +       /* There is no associtated IOHPMEVT0 for IOHPMCYCLES */
> > > +       if (idx =3D=3D 0)
> > > +               return;
> > > +
> > > +       writeq(value, addr + (idx - 1) * 8);
> > > +}
> > > +
> > > +static void riscv_iommu_pmu_enable_counter(struct riscv_iommu_pmu *p=
mu, u32 idx)
> > > +{
> > > +       void __iomem *addr =3D pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH;
> > > +       u32 value =3D readl(addr);
> > > +
> > > +       writel(value & ~BIT(idx), addr);
> > > +}
> > > +
> > > +static void riscv_iommu_pmu_disable_counter(struct riscv_iommu_pmu *=
pmu, u32 idx)
> > > +{
> > > +       void __iomem *addr =3D pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH;
> > > +       u32 value =3D readl(addr);
> > > +
> > > +       writel(value | BIT(idx), addr);
> > > +}
> > > +
> > > +static void riscv_iommu_pmu_enable_ovf_intr(struct riscv_iommu_pmu *=
pmu, u32 idx)
> > > +{
> > > +       u64 value;
> > > +
> > > +       if (get_event(pmu->events[idx]) =3D=3D RISCV_IOMMU_HPMEVENT_C=
YCLE) {
> > > +               value =3D riscv_iommu_pmu_get_counter(pmu, idx) & ~RI=
SCV_IOMMU_IOHPMCYCLES_OF;
> > > +               writeq(value, pmu->reg + RISCV_IOMMU_REG_IOHPMCYCLES)=
;
> > > +       } else {
> > > +               value =3D riscv_iommu_pmu_get_event(pmu, idx) & ~RISC=
V_IOMMU_IOHPMEVT_OF;
> > > +               writeq(value, pmu->reg + RISCV_IOMMU_REG_IOHPMEVT_BAS=
E + (idx - 1) * 8);
> > > +       }
> > > +}
> > > +
> > > +static void riscv_iommu_pmu_disable_ovf_intr(struct riscv_iommu_pmu =
*pmu, u32 idx)
> > > +{
> > > +       u64 value;
> > > +
> > > +       if (get_event(pmu->events[idx]) =3D=3D RISCV_IOMMU_HPMEVENT_C=
YCLE) {
> > > +               value =3D riscv_iommu_pmu_get_counter(pmu, idx) | RIS=
CV_IOMMU_IOHPMCYCLES_OF;
> > > +               writeq(value, pmu->reg + RISCV_IOMMU_REG_IOHPMCYCLES)=
;
> > > +       } else {
> > > +               value =3D riscv_iommu_pmu_get_event(pmu, idx) | RISCV=
_IOMMU_IOHPMEVT_OF;
> > > +               writeq(value, pmu->reg + RISCV_IOMMU_REG_IOHPMEVT_BAS=
E + (idx - 1) * 8);
> > > +       }
> > > +}
> > > +
> > > +static void riscv_iommu_pmu_start_all(struct riscv_iommu_pmu *pmu)
> > > +{
> > > +       int idx;
> > > +
> > > +       for_each_set_bit(idx, pmu->used_counters, pmu->num_counters) =
{
> > > +               riscv_iommu_pmu_enable_ovf_intr(pmu, idx);
> > > +               riscv_iommu_pmu_enable_counter(pmu, idx);
> > > +       }
> > > +}
> > > +
> > > +static void riscv_iommu_pmu_stop_all(struct riscv_iommu_pmu *pmu)
> > > +{
> > > +       writel(GENMASK_ULL(pmu->num_counters - 1, 0),
> > > +              pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH);
> > > +}
> > > +
> > > +/* PMU APIs */
> > > +static int riscv_iommu_pmu_set_period(struct perf_event *event)
> > > +{
> > > +       struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu=
);
> > > +       struct hw_perf_event *hwc =3D &event->hw;
> > > +       s64 left =3D local64_read(&hwc->period_left);
> > > +       s64 period =3D hwc->sample_period;
> > > +       u64 max_period =3D pmu->mask_counter;
> > > +       int ret =3D 0;
> > > +
> > > +       if (unlikely(left <=3D -period)) {
> > > +               left =3D period;
> > > +               local64_set(&hwc->period_left, left);
> > > +               hwc->last_period =3D period;
> > > +               ret =3D 1;
> > > +       }
> > > +
> > > +       if (unlikely(left <=3D 0)) {
> > > +               left +=3D period;
> > > +               local64_set(&hwc->period_left, left);
> > > +               hwc->last_period =3D period;
> > > +               ret =3D 1;
> > > +       }
> > > +
> > > +       /*
> > > +        * Limit the maximum period to prevent the counter value
> > > +        * from overtaking the one we are about to program. In
> > > +        * effect we are reducing max_period to account for
> > > +        * interrupt latency (and we are being very conservative).
> > > +        */
> > > +       if (left > (max_period >> 1))
> > > +               left =3D (max_period >> 1);
> > > +
> > > +       local64_set(&hwc->prev_count, (u64)-left);
> > > +       riscv_iommu_pmu_set_counter(pmu, hwc->idx, (u64)(-left) & max=
_period);
> > > +       perf_event_update_userpage(event);
> > > +
> > > +       return ret;
> > > +}
> > > +
> > > +static int riscv_iommu_pmu_event_init(struct perf_event *event)
> > > +{
> > > +       struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu=
);
> > > +       struct hw_perf_event *hwc =3D &event->hw;
> > > +
> > > +       hwc->idx =3D -1;
> > > +       hwc->config =3D event->attr.config;
> > > +
> > > +       if (!is_sampling_event(event)) {
> > > +               /*
> > > +                * For non-sampling runs, limit the sample_period to =
half
> > > +                * of the counter width. That way, the new counter va=
lue
> > > +                * is far less likely to overtake the previous one un=
less
> > > +                * you have some serious IRQ latency issues.
> > > +                */
> > > +               hwc->sample_period =3D pmu->mask_counter >> 1;
> > > +               hwc->last_period =3D hwc->sample_period;
> > > +               local64_set(&hwc->period_left, hwc->sample_period);
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static void riscv_iommu_pmu_update(struct perf_event *event)
> > > +{
> > > +       struct hw_perf_event *hwc =3D &event->hw;
> > > +       struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu=
);
> > > +       u64 delta, prev, now;
> > > +       u32 idx =3D hwc->idx;
> > > +
> > > +       do {
> > > +               prev =3D local64_read(&hwc->prev_count);
> > > +               now =3D riscv_iommu_pmu_get_counter(pmu, idx);
> > > +       } while (local64_cmpxchg(&hwc->prev_count, prev, now) !=3D pr=
ev);
> > > +
> > > +       delta =3D FIELD_GET(RISCV_IOMMU_IOHPMCTR_COUNTER, now - prev)=
 & pmu->mask_counter;
> > > +       local64_add(delta, &event->count);
> > > +       local64_sub(delta, &hwc->period_left);
> > > +}
> > > +
> > > +static void riscv_iommu_pmu_start(struct perf_event *event, int flag=
s)
> > > +{
> > > +       struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu=
);
> > > +       struct hw_perf_event *hwc =3D &event->hw;
> > > +
> > > +       if (WARN_ON_ONCE(!(event->hw.state & PERF_HES_STOPPED)))
> > > +               return;
> > > +
> > > +       if (flags & PERF_EF_RELOAD)
> > > +               WARN_ON_ONCE(!(event->hw.state & PERF_HES_UPTODATE));
> > > +
> > > +       hwc->state =3D 0;
> > > +       riscv_iommu_pmu_set_period(event);
> > > +       riscv_iommu_pmu_set_event(pmu, hwc->idx, hwc->config);
> > > +       riscv_iommu_pmu_enable_ovf_intr(pmu, hwc->idx);
> > > +       riscv_iommu_pmu_enable_counter(pmu, hwc->idx);
> > > +
> > > +       perf_event_update_userpage(event);
> > > +}
> > > +
> > > +static void riscv_iommu_pmu_stop(struct perf_event *event, int flags=
)
> > > +{
> > > +       struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu=
);
> > > +       struct hw_perf_event *hwc =3D &event->hw;
> > > +
> > > +       if (hwc->state & PERF_HES_STOPPED)
> > > +               return;
> > > +
> > > +       riscv_iommu_pmu_set_event(pmu, hwc->idx, RISCV_IOMMU_HPMEVENT=
_INVALID);
> > > +       riscv_iommu_pmu_disable_counter(pmu, hwc->idx);
> > > +
> > > +       if ((flags & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTOD=
ATE))
> > > +               riscv_iommu_pmu_update(event);
> > > +
> > > +       hwc->state |=3D PERF_HES_STOPPED | PERF_HES_UPTODATE;
> > > +}
> > > +
> > > +static int riscv_iommu_pmu_add(struct perf_event *event, int flags)
> > > +{
> > > +       struct hw_perf_event *hwc =3D &event->hw;
> > > +       struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu=
);
> > > +       unsigned int num_counters =3D pmu->num_counters;
> > > +       int idx;
> > > +
> > > +       /* Reserve index zero for iohpmcycles */
> > > +       if (get_event(event) =3D=3D RISCV_IOMMU_HPMEVENT_CYCLE)
> > > +               idx =3D 0;
> > > +       else
> > > +               idx =3D find_next_zero_bit(pmu->used_counters, num_co=
unters, 1);
> > > +
> > > +       if (idx =3D=3D num_counters)
> > > +               return -EAGAIN;
> > > +
> > > +       set_bit(idx, pmu->used_counters);
> > > +
> > > +       pmu->events[idx] =3D event;
> > > +       hwc->idx =3D idx;
> > > +       hwc->state =3D PERF_HES_STOPPED | PERF_HES_UPTODATE;
> > > +
> > > +       if (flags & PERF_EF_START)
> > > +               riscv_iommu_pmu_start(event, flags);
> > > +
> > > +       /* Propagate changes to the userspace mapping. */
> > > +       perf_event_update_userpage(event);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static void riscv_iommu_pmu_read(struct perf_event *event)
> > > +{
> > > +       riscv_iommu_pmu_update(event);
> > > +}
> > > +
> > > +static void riscv_iommu_pmu_del(struct perf_event *event, int flags)
> > > +{
> > > +       struct hw_perf_event *hwc =3D &event->hw;
> > > +       struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu=
);
> > > +       int idx =3D hwc->idx;
> > > +
> > > +       riscv_iommu_pmu_stop(event, PERF_EF_UPDATE);
> > > +       pmu->events[idx] =3D NULL;
> > > +       clear_bit(idx, pmu->used_counters);
> > > +       perf_event_update_userpage(event);
> > > +}
> > > +
> > > +irqreturn_t riscv_iommu_pmu_handle_irq(struct riscv_iommu_pmu *pmu)
> > > +{
> > > +       struct perf_sample_data data;
> > > +       struct pt_regs *regs;
> > > +       u32 ovf =3D readl(pmu->reg + RISCV_IOMMU_REG_IOCOUNTOVF);
> > > +       int idx;
> > > +
> > > +       if (!ovf)
> > > +               return IRQ_NONE;
> > > +
> > > +       riscv_iommu_pmu_stop_all(pmu);
> > > +
> > > +       regs =3D get_irq_regs();
> > > +
> > > +       for_each_set_bit(idx, (unsigned long *)&ovf, pmu->num_counter=
s) {
> > > +               struct perf_event *event =3D pmu->events[idx];
> > > +               struct hw_perf_event *hwc;
> > > +
> > > +               if (WARN_ON_ONCE(!event) || !is_sampling_event(event)=
)
> > > +                       continue;
> > > +
> > > +               hwc =3D &event->hw;
> > > +
> > > +               riscv_iommu_pmu_update(event);
> > > +               perf_sample_data_init(&data, 0, hwc->last_period);
> > > +               if (!riscv_iommu_pmu_set_period(event))
> > > +                       continue;
> > > +
> > > +               if (perf_event_overflow(event, &data, regs))
> > > +                       riscv_iommu_pmu_stop(event, 0);
> > > +       }
> > > +
> > > +       riscv_iommu_pmu_start_all(pmu);
> > > +
> > > +       return IRQ_HANDLED;
> > > +}
> > > +
> > > +int riscv_iommu_pmu_init(struct riscv_iommu_pmu *pmu, void __iomem *=
reg,
> > > +                        const char *dev_name)
> > > +{
> > > +       char *name;
> > > +       int ret;
> > > +
> > > +       pmu->reg =3D reg;
> > > +       pmu->num_counters =3D RISCV_IOMMU_HPM_COUNTER_NUM;
> > > +       pmu->mask_counter =3D RISCV_IOMMU_IOHPMCTR_COUNTER;
> > > +
> > > +       pmu->pmu =3D (struct pmu) {
> > > +               .task_ctx_nr    =3D perf_invalid_context,
> > > +               .event_init     =3D riscv_iommu_pmu_event_init,
> > > +               .add            =3D riscv_iommu_pmu_add,
> > > +               .del            =3D riscv_iommu_pmu_del,
> > > +               .start          =3D riscv_iommu_pmu_start,
> > > +               .stop           =3D riscv_iommu_pmu_stop,
> > > +               .read           =3D riscv_iommu_pmu_read,
> > > +               .attr_groups    =3D riscv_iommu_pmu_attr_grps,
> > > +               .capabilities   =3D PERF_PMU_CAP_NO_EXCLUDE,
> > > +               .module         =3D THIS_MODULE,
> > > +       };
> > > +
> > > +       name =3D kasprintf(GFP_KERNEL, "riscv_iommu_pmu_%s", dev_name=
);
> >
> > The dev_name of RISCV IOMMU is usually 'riscv,iommu'. If we compose
> > the iommu pmu name of iommu dev name, then maybe perf subsystem can
> > not handle the pmu event name correctly as the exists ',' in it.
>
> I assume you are referring to compatible string because 'riscv,iommu'
> appears to be the compatible string. However, it seems to me that the
> dev_name is derived from the node name rather than the compatible
> string. As a result, there is no comma (',') symbol; instead, a dot
> ('.') symbol is used. For example, if the IOMMU node in the device
> tree is 'iommu@12345678', the dev_name would be '12345678.iommu'.
> Please let me know if I missed anything. Thanks
>

Tested it on qemu. You are right. Please ignore me. Thanks!

> >
> > Best Regards,
> >
> > Xu Lu
> >
> > > +
> > > +       ret =3D perf_pmu_register(&pmu->pmu, name, -1);
> > > +       if (ret) {
> > > +               pr_err("Failed to register riscv_iommu_pmu_%s: %d\n",
> > > +                      dev_name, ret);
> > > +               return ret;
> > > +       }
> > > +
> > > +       /* Stop all counters and later start the counter with perf */
> > > +       riscv_iommu_pmu_stop_all(pmu);
> > > +
> > > +       pr_info("riscv_iommu_pmu_%s: Registered with %d counters\n",
> > > +               dev_name, pmu->num_counters);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +void riscv_iommu_pmu_uninit(struct riscv_iommu_pmu *pmu)
> > > +{
> > > +       int idx;
> > > +
> > > +       /* Disable interrupt and functions */
> > > +       for_each_set_bit(idx, pmu->used_counters, pmu->num_counters) =
{
> > > +               riscv_iommu_pmu_disable_counter(pmu, idx);
> > > +               riscv_iommu_pmu_disable_ovf_intr(pmu, idx);
> > > +       }
> > > +
> > > +       perf_pmu_unregister(&pmu->pmu);
> > > +}
> > > diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.=
h
> > > index b1c4664542b4..92659a8a75ae 100644
> > > --- a/drivers/iommu/riscv/iommu.h
> > > +++ b/drivers/iommu/riscv/iommu.h
> > > @@ -60,11 +60,19 @@ struct riscv_iommu_device {
> > >         unsigned int ddt_mode;
> > >         dma_addr_t ddt_phys;
> > >         u64 *ddt_root;
> > > +
> > > +       /* hardware performance monitor */
> > > +       struct riscv_iommu_pmu pmu;
> > >  };
> > >
> > >  int riscv_iommu_init(struct riscv_iommu_device *iommu);
> > >  void riscv_iommu_remove(struct riscv_iommu_device *iommu);
> > >
> > > +int riscv_iommu_pmu_init(struct riscv_iommu_pmu *pmu, void __iomem *=
reg,
> > > +                        const char *name);
> > > +void riscv_iommu_pmu_uninit(struct riscv_iommu_pmu *pmu);
> > > +irqreturn_t riscv_iommu_pmu_handle_irq(struct riscv_iommu_pmu *pmu);
> > > +
> > >  #define riscv_iommu_readl(iommu, addr) \
> > >         readl_relaxed((iommu)->reg + (addr))
> > >
> > > --
> > > 2.17.1
> > >
