Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D5013C830
	for <iommu@lists.linux.dev>; Thu,  9 May 2024 01:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715219888; cv=none; b=UIcrb7QBc1m5xl+3bk9xeaLY1BpxUZ6Cf0Gi6iA8n/BMkj89gPo7xvlk95UkNWVE5nbNZG35P3lqaRMe9Si5dF7JGhzFS+DmGr13QjbVwf5Vbn2eDT/ij+kf4+KSiGdnPKpFu/qhYdnUH2r1zEfCo1gcUQ0dszJVg5NyNMwT1EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715219888; c=relaxed/simple;
	bh=MslVLgIxgHBl+0Lt+ft238DkzNbMCXbaWK7L/yXgtwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aPZtLy61cedg+5XBLypQJ4KMaXw+g46I0ikEF5Xz8D4vA8r3nPk9GHuaMWE6rN1uOgCa3Y0dFjDH2ioIimldh8e4C6qXp4IoIhS+63TwASBHjQtuxsOOK0mXZ/5MbSguNDMsfCPE5B9uBd93U7Jbl8jmZjqBnYSASYeBrEpqkcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=SwCygwrX; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SwCygwrX"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-36c5b808a70so972585ab.3
        for <iommu@lists.linux.dev>; Wed, 08 May 2024 18:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715219884; x=1715824684; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFbPdyNXAmPDgRMnsXkYwRU/eurcP6NCi2ubSK27CbY=;
        b=SwCygwrXeJuMmm29i75xBuBMMDP8Tj4PMEFdgIrcvC0YsExF0aYmSwPnisccSPyH6t
         sKJ46mQqSyZvs1KWaPl31Fjza1y3EviXZI+yhqDX5volXytieizU4P9cOlCn1bryyK+Q
         eT0GFbGK0fwqLxIXTr6I3DIfdEaVjv07HS1J610PhwzyLYIPeoplqhaEh5EyNbLzPUUa
         tK2FYvxcJFAF0qgwU4hsSIDHnFgHw8FNY7pBT9Vt68zqLqo+ykGro7JNF7dDrRx/V/jF
         KpBOor4yYzPaP/9zNZU7dwFesq6tF8xL2wys2coF/+iACLU9HXCSIMrX9NjXSGSbexvh
         /Z7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715219885; x=1715824685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YFbPdyNXAmPDgRMnsXkYwRU/eurcP6NCi2ubSK27CbY=;
        b=etdm4BtS/C4B1YrMKZUW4lnzrVJhRvBdHtlmFBo1kOlOTUivH3hQSuGbyxpdOuJPrR
         B5UVv5sf4/ZPn3Lyal5TmEV1qqU2Pt43iBoS2wae/kELC7Z6pVv8OKV4gTenH8K/wOzv
         IJNAm0kzUD+QBeDop3RKm4aiU/mKYmeZN7rfmPHv51AYlmcKU2I9Z47jks3lJaJ5V5N6
         4Rwiee0EDEoSriS9ckKlIneShGPIKQijzeJh9n1JVi2Lduv3sXWmMgxnHDGlRSHDWqza
         2NX22/PaANlw3G23cwAyODoHmZQTvN97eByULBXtCtI0OvLaKwKCuufKXDViv3g0dILN
         czWA==
X-Forwarded-Encrypted: i=1; AJvYcCW8QX1Ne8U4qf/g74CnEmjmWMrhBLdWpJGK0OnLgrfgtGPQ08J4ShAIaB2O0ahCqqS9M/jj7b4JkdJJplLn3I89Y4Q5cpk=
X-Gm-Message-State: AOJu0YzhjuyGUlTqh6dDNNyg/FcN7c02Vz2bcD29IYqTWruyfNOTV3Os
	DxvXwyjjqwZXuAApujqoIQ3+CcQ+8/2aDjFGUMVlLwCLa+QFUupbDN0DTlYZ25sIeKlT51KwnwH
	QPGN0+MiJw+XYITS548J1zdbFPNiNPT40zMM8CA==
X-Google-Smtp-Source: AGHT+IF4RVogvPfjo/ijFH9x2U3bkaDZmtp/UsQSkST5lELnt8YqnwCHSoL3O17W6xCugrrQFjtRXoK6GgZZy/otp9w=
X-Received: by 2002:a05:6e02:1c8e:b0:36c:5124:eb35 with SMTP id
 e9e14a558f8ab-36caeba7990mr48591615ab.3.1715219884531; Wed, 08 May 2024
 18:58:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1714752293.git.tjeznach@rivosinc.com> <f63635cd72fd0d1b0026a6839dbfeaa2cd154eaa.1714752293.git.tjeznach@rivosinc.com>
 <CANXhq0qD-9d5Nbh3By2zf6BORNOsM3W4CN4J8H94c_n3_xT_Pg@mail.gmail.com> <CAH2o1u5wHZr-BHU0zbvq_DHzXY6xshyF1EkDDffGuAqZ670bXQ@mail.gmail.com>
In-Reply-To: <CAH2o1u5wHZr-BHU0zbvq_DHzXY6xshyF1EkDDffGuAqZ670bXQ@mail.gmail.com>
From: Zong Li <zong.li@sifive.com>
Date: Thu, 9 May 2024 09:57:52 +0800
Message-ID: <CANXhq0osw1rjRnuB-s18trEPw+x5woLiEUt5MQ7+wmjg+WAgLA@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] iommu/riscv: Command and fault queue support
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Anup Patel <apatel@ventanamicro.com>, devicetree@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com, 
	linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, 
	Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev, 
	Palmer Dabbelt <palmer@dabbelt.com>, Nick Kossifidis <mick@ics.forth.gr>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-riscv@lists.infradead.org, 
	Lu Baolu <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 12:03=E2=80=AFAM Tomasz Jeznach <tjeznach@rivosinc.c=
om> wrote:
>
> On Wed, May 8, 2024 at 8:39=E2=80=AFAM Zong Li <zong.li@sifive.com> wrote=
:
> >
> > On Sat, May 4, 2024 at 12:13=E2=80=AFAM Tomasz Jeznach <tjeznach@rivosi=
nc.com> wrote:
> > >
> > > Introduce device command submission and fault reporting queues,
> > > as described in Chapter 3.1 and 3.2 of the RISC-V IOMMU Architecture
> > > Specification.
> > >
> > > Command and fault queues are instantiated in contiguous system memory
> > > local to IOMMU device domain, or mapped from fixed I/O space provided
> > > by the hardware implementation. Detection of the location and maximum
> > > allowed size of the queue utilize WARL properties of queue base contr=
ol
> > > register. Driver implementation will try to allocate up to 128KB of
> > > system memory, while respecting hardware supported maximum queue size=
.
> > >
> > > Interrupts allocation is based on interrupt vectors availability and
> > > distributed to all queues in simple round-robin fashion. For hardware
> > > Implementation with fixed event type to interrupt vector assignment
> > > IVEC WARL property is used to discover such mappings.
> > >
> > > Address translation, command and queue fault handling in this change
> > > is limited to simple fault reporting without taking any action.
> > >
> > > Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> > > Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> > > ---
> > >  drivers/iommu/riscv/iommu-bits.h |  75 +++++
> > >  drivers/iommu/riscv/iommu.c      | 496 +++++++++++++++++++++++++++++=
+-
> > >  drivers/iommu/riscv/iommu.h      |  21 ++
> > >  3 files changed, 590 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/i=
ommu-bits.h
> > > index ba093c29de9f..40c379222821 100644
> > > --- a/drivers/iommu/riscv/iommu-bits.h
> > > +++ b/drivers/iommu/riscv/iommu-bits.h
> > > @@ -704,4 +704,79 @@ struct riscv_iommu_msi_pte {
> > >  #define RISCV_IOMMU_MSI_MRIF_NPPN      RISCV_IOMMU_PPN_FIELD
> > >  #define RISCV_IOMMU_MSI_MRIF_NID_MSB   BIT_ULL(60)
> > >
> > > +/* Helper functions: command structure builders. */
> > > +
> > > +static inline void riscv_iommu_cmd_inval_vma(struct riscv_iommu_comm=
and *cmd)
> > > +{
> > > +       cmd->dword0 =3D FIELD_PREP(RISCV_IOMMU_CMD_OPCODE, RISCV_IOMM=
U_CMD_IOTINVAL_OPCODE) |
> > > +                     FIELD_PREP(RISCV_IOMMU_CMD_FUNC, RISCV_IOMMU_CM=
D_IOTINVAL_FUNC_VMA);
> > > +       cmd->dword1 =3D 0;
> > > +}
> > > +
> > > +static inline void riscv_iommu_cmd_inval_set_addr(struct riscv_iommu=
_command *cmd,
> > > +                                                 u64 addr)
> > > +{
> > > +       cmd->dword1 =3D FIELD_PREP(RISCV_IOMMU_CMD_IOTINVAL_ADDR, phy=
s_to_pfn(addr));
> > > +       cmd->dword0 |=3D RISCV_IOMMU_CMD_IOTINVAL_AV;
> > > +}
> > > +
> > > +static inline void riscv_iommu_cmd_inval_set_pscid(struct riscv_iomm=
u_command *cmd,
> > > +                                                  int pscid)
> > > +{
> > > +       cmd->dword0 |=3D FIELD_PREP(RISCV_IOMMU_CMD_IOTINVAL_PSCID, p=
scid) |
> > > +                      RISCV_IOMMU_CMD_IOTINVAL_PSCV;
> > > +}
> > > +
> > > +static inline void riscv_iommu_cmd_inval_set_gscid(struct riscv_iomm=
u_command *cmd,
> > > +                                                  int gscid)
> > > +{
> > > +       cmd->dword0 |=3D FIELD_PREP(RISCV_IOMMU_CMD_IOTINVAL_GSCID, g=
scid) |
> > > +                      RISCV_IOMMU_CMD_IOTINVAL_GV;
> > > +}
> > > +
> > > +static inline void riscv_iommu_cmd_iofence(struct riscv_iommu_comman=
d *cmd)
> > > +{
> > > +       cmd->dword0 =3D FIELD_PREP(RISCV_IOMMU_CMD_OPCODE, RISCV_IOMM=
U_CMD_IOFENCE_OPCODE) |
> > > +                     FIELD_PREP(RISCV_IOMMU_CMD_FUNC, RISCV_IOMMU_CM=
D_IOFENCE_FUNC_C) |
> > > +                     RISCV_IOMMU_CMD_IOFENCE_PR | RISCV_IOMMU_CMD_IO=
FENCE_PW;
> > > +       cmd->dword1 =3D 0;
> > > +}
> > > +
> > > +static inline void riscv_iommu_cmd_iofence_set_av(struct riscv_iommu=
_command *cmd,
> > > +                                                 u64 addr, u32 data)
> > > +{
> > > +       cmd->dword0 =3D FIELD_PREP(RISCV_IOMMU_CMD_OPCODE, RISCV_IOMM=
U_CMD_IOFENCE_OPCODE) |
> > > +                     FIELD_PREP(RISCV_IOMMU_CMD_FUNC, RISCV_IOMMU_CM=
D_IOFENCE_FUNC_C) |
> > > +                     FIELD_PREP(RISCV_IOMMU_CMD_IOFENCE_DATA, data) =
|
> > > +                     RISCV_IOMMU_CMD_IOFENCE_AV;
> > > +       cmd->dword1 =3D addr >> 2;
> > > +}
> > > +
> > > +static inline void riscv_iommu_cmd_iodir_inval_ddt(struct riscv_iomm=
u_command *cmd)
> > > +{
> > > +       cmd->dword0 =3D FIELD_PREP(RISCV_IOMMU_CMD_OPCODE, RISCV_IOMM=
U_CMD_IODIR_OPCODE) |
> > > +                     FIELD_PREP(RISCV_IOMMU_CMD_FUNC, RISCV_IOMMU_CM=
D_IODIR_FUNC_INVAL_DDT);
> > > +       cmd->dword1 =3D 0;
> > > +}
> > > +
> > > +static inline void riscv_iommu_cmd_iodir_inval_pdt(struct riscv_iomm=
u_command *cmd)
> > > +{
> > > +       cmd->dword0 =3D FIELD_PREP(RISCV_IOMMU_CMD_OPCODE, RISCV_IOMM=
U_CMD_IODIR_OPCODE) |
> > > +                     FIELD_PREP(RISCV_IOMMU_CMD_FUNC, RISCV_IOMMU_CM=
D_IODIR_FUNC_INVAL_PDT);
> > > +       cmd->dword1 =3D 0;
> > > +}
> > > +
> > > +static inline void riscv_iommu_cmd_iodir_set_did(struct riscv_iommu_=
command *cmd,
> > > +                                                unsigned int devid)
> > > +{
> > > +       cmd->dword0 |=3D FIELD_PREP(RISCV_IOMMU_CMD_IODIR_DID, devid)=
 |
> > > +                      RISCV_IOMMU_CMD_IODIR_DV;
> > > +}
> > > +
> > > +static inline void riscv_iommu_cmd_iodir_set_pid(struct riscv_iommu_=
command *cmd,
> > > +                                                unsigned int pasid)
> > > +{
> > > +       cmd->dword0 |=3D FIELD_PREP(RISCV_IOMMU_CMD_IODIR_PID, pasid)=
;
> > > +}
> > > +
> > >  #endif /* _RISCV_IOMMU_BITS_H_ */
> > > diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.=
c
> > > index 71b7903d83d4..4349ac8a3990 100644
> > > --- a/drivers/iommu/riscv/iommu.c
> > > +++ b/drivers/iommu/riscv/iommu.c
> > > @@ -25,7 +25,14 @@
> > >  #include "iommu.h"
> > >
> > >  /* Timeouts in [us] */
> > > -#define RISCV_IOMMU_DDTP_TIMEOUT       50000
> > > +#define RISCV_IOMMU_QCSR_TIMEOUT       150000
> > > +#define RISCV_IOMMU_QUEUE_TIMEOUT      150000
> > > +#define RISCV_IOMMU_DDTP_TIMEOUT       10000000
> > > +#define RISCV_IOMMU_IOTINVAL_TIMEOUT   90000000
> > > +
> > > +/* Number of entries per CMD/FLT queue, should be <=3D INT_MAX */
> > > +#define RISCV_IOMMU_DEF_CQ_COUNT       8192
> > > +#define RISCV_IOMMU_DEF_FQ_COUNT       4096
> > >
> > >  /* RISC-V IOMMU PPN <> PHYS address conversions, PHYS <=3D> PPN[53:1=
0] */
> > >  #define phys_to_ppn(va)  (((va) >> 2) & (((1ULL << 44) - 1) << 10))
> > > @@ -89,6 +96,432 @@ static void riscv_iommu_free_pages(struct riscv_i=
ommu_device *iommu, void *addr)
> > >                        riscv_iommu_devres_pages_match, &devres);
> > >  }
> > >
> > > +/*
> > > + * Hardware queue allocation and management.
> > > + */
> > > +
> > > +/* Setup queue base, control registers and default queue length */
> > > +#define RISCV_IOMMU_QUEUE_INIT(q, name) do {                        =
   \
> > > +       struct riscv_iommu_queue *_q =3D q;                          =
     \
> > > +       _q->qid =3D RISCV_IOMMU_INTR_ ## name;                       =
     \
> > > +       _q->qbr =3D RISCV_IOMMU_REG_ ## name ## B;                   =
     \
> > > +       _q->qcr =3D RISCV_IOMMU_REG_ ## name ## CSR;                 =
     \
> > > +       _q->mask =3D _q->mask ?: (RISCV_IOMMU_DEF_ ## name ## _COUNT)=
 - 1;\
> > > +} while (0)
> > > +
> > > +/* Note: offsets are the same for all queues */
> > > +#define Q_HEAD(q) ((q)->qbr + (RISCV_IOMMU_REG_CQH - RISCV_IOMMU_REG=
_CQB))
> > > +#define Q_TAIL(q) ((q)->qbr + (RISCV_IOMMU_REG_CQT - RISCV_IOMMU_REG=
_CQB))
> > > +#define Q_ITEM(q, index) ((q)->mask & (index))
> > > +#define Q_IPSR(q) BIT((q)->qid)
> > > +
> > > +/*
> > > + * Discover queue ring buffer hardware configuration, allocate in-me=
mory
> > > + * ring buffer or use fixed I/O memory location, configure queue bas=
e register.
> > > + * Must be called before hardware queue is enabled.
> > > + *
> > > + * @queue - data structure, configured with RISCV_IOMMU_QUEUE_INIT()
> > > + * @entry_size - queue single element size in bytes.
> > > + */
> > > +static int riscv_iommu_queue_alloc(struct riscv_iommu_device *iommu,
> > > +                                  struct riscv_iommu_queue *queue,
> > > +                                  size_t entry_size)
> > > +{
> > > +       unsigned int logsz;
> > > +       u64 qb, rb;
> > > +
> > > +       /*
> > > +        * Use WARL base register property to discover maximum allowe=
d
> > > +        * number of entries and optional fixed IO address for queue =
location.
> > > +        */
> > > +       riscv_iommu_writeq(iommu, queue->qbr, RISCV_IOMMU_QUEUE_LOGSZ=
_FIELD);
> > > +       qb =3D riscv_iommu_readq(iommu, queue->qbr);
> > > +
> > > +       /*
> > > +        * Calculate and verify hardware supported queue length, as r=
eported
> > > +        * by the field LOGSZ, where max queue length is equal to 2^(=
LOGSZ + 1).
> > > +        * Update queue size based on hardware supported value.
> > > +        */
> > > +       logsz =3D ilog2(queue->mask);
> > > +       if (logsz > FIELD_GET(RISCV_IOMMU_QUEUE_LOGSZ_FIELD, qb))
> > > +               logsz =3D FIELD_GET(RISCV_IOMMU_QUEUE_LOGSZ_FIELD, qb=
);
> > > +
> > > +       /*
> > > +        * Use WARL base register property to discover an optional fi=
xed IO
> > > +        * address for queue ring buffer location. Otherwise allocate=
 contigus
> > > +        * system memory.
> > > +        */
> > > +       if (FIELD_GET(RISCV_IOMMU_PPN_FIELD, qb)) {
> > > +               const size_t queue_size =3D entry_size << (logsz + 1)=
;
> > > +
> > > +               queue->phys =3D ppn_to_phys(FIELD_GET(RISCV_IOMMU_PPN=
_FIELD, qb));
> > > +               queue->base =3D devm_ioremap(iommu->dev, queue->phys,=
 queue_size);
> > > +       } else {
> > > +               do {
> > > +                       const size_t queue_size =3D entry_size << (lo=
gsz + 1);
> > > +                       const int order =3D get_order(queue_size);
> > > +
> > > +                       queue->base =3D riscv_iommu_get_pages(iommu, =
order);
> > > +                       queue->phys =3D __pa(queue->base);
> > > +               } while (!queue->base && logsz-- > 0);
> > > +       }
> > > +
> > > +       if (!queue->base)
> > > +               return -ENOMEM;
> > > +
> > > +       qb =3D phys_to_ppn(queue->phys) |
> > > +            FIELD_PREP(RISCV_IOMMU_QUEUE_LOGSZ_FIELD, logsz);
> > > +
> > > +       /* Update base register and read back to verify hw accepted o=
ur write */
> > > +       riscv_iommu_writeq(iommu, queue->qbr, qb);
> > > +       rb =3D riscv_iommu_readq(iommu, queue->qbr);
> > > +       if (rb !=3D qb) {
> > > +               dev_err(iommu->dev, "queue #%u allocation failed\n", =
queue->qid);
> > > +               return -ENODEV;
> > > +       }
> > > +
> > > +       /* Update actual queue mask */
> > > +       queue->mask =3D (2U << logsz) - 1;
> > > +
> > > +       dev_dbg(iommu->dev, "queue #%u allocated 2^%u entries",
> > > +               queue->qid, logsz + 1);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +/* Check interrupt queue status, IPSR */
> > > +static irqreturn_t riscv_iommu_queue_ipsr(int irq, void *data)
> > > +{
> > > +       struct riscv_iommu_queue *queue =3D (struct riscv_iommu_queue=
 *)data;
> > > +
> > > +       if (riscv_iommu_readl(queue->iommu, RISCV_IOMMU_REG_IPSR) & Q=
_IPSR(queue))
> > > +               return IRQ_WAKE_THREAD;
> > > +
> > > +       return IRQ_NONE;
> > > +}
> > > +
> > > +static int riscv_iommu_queue_vec(struct riscv_iommu_device *iommu, i=
nt n)
> > > +{
> > > +       /* Reuse IVEC.CIV mask for all interrupt vectors mapping. */
> > > +       return (iommu->ivec >> (n * 4)) & RISCV_IOMMU_IVEC_CIV;
> > > +}
> > > +
> > > +/*
> > > + * Enable queue processing in the hardware, register interrupt handl=
er.
> > > + *
> > > + * @queue - data structure, already allocated with riscv_iommu_queue=
_alloc()
> > > + * @irq_handler - threaded interrupt handler.
> > > + */
> > > +static int riscv_iommu_queue_enable(struct riscv_iommu_device *iommu=
,
> > > +                                   struct riscv_iommu_queue *queue,
> > > +                                   irq_handler_t irq_handler)
> > > +{
> > > +       const unsigned int irq =3D iommu->irqs[riscv_iommu_queue_vec(=
iommu, queue->qid)];
> > > +       u32 csr;
> > > +       int rc;
> > > +
> > > +       if (queue->iommu)
> > > +               return -EBUSY;
> > > +
> > > +       /* Polling not implemented */
> > > +       if (!irq)
> > > +               return -ENODEV;
> > > +
> > > +       queue->iommu =3D iommu;
> > > +       rc =3D request_threaded_irq(irq, riscv_iommu_queue_ipsr, irq_=
handler,
> > > +                                 IRQF_ONESHOT | IRQF_SHARED,
> > > +                                 dev_name(iommu->dev), queue);
> > > +       if (rc) {
> > > +               queue->iommu =3D NULL;
> > > +               return rc;
> > > +       }
> > > +
> > > +       /*
> > > +        * Enable queue with interrupts, clear any memory fault if an=
y.
> > > +        * Wait for the hardware to acknowledge request and activate =
queue
> > > +        * processing.
> > > +        * Note: All CSR bitfields are in the same offsets for all qu=
eues.
> > > +        */
> > > +       riscv_iommu_writel(iommu, queue->qcr,
> > > +                          RISCV_IOMMU_QUEUE_ENABLE |
> > > +                          RISCV_IOMMU_QUEUE_INTR_ENABLE |
> > > +                          RISCV_IOMMU_QUEUE_MEM_FAULT);
> > > +
> > > +       riscv_iommu_readl_timeout(iommu, queue->qcr,
> > > +                                 csr, !(csr & RISCV_IOMMU_QUEUE_BUSY=
),
> > > +                                 10, RISCV_IOMMU_QCSR_TIMEOUT);
> > > +
> > > +       if (RISCV_IOMMU_QUEUE_ACTIVE !=3D (csr & (RISCV_IOMMU_QUEUE_A=
CTIVE |
> > > +                                               RISCV_IOMMU_QUEUE_BUS=
Y |
> > > +                                               RISCV_IOMMU_QUEUE_MEM=
_FAULT))) {
> > > +               /* Best effort to stop and disable failing hardware q=
ueue. */
> > > +               riscv_iommu_writel(iommu, queue->qcr, 0);
> > > +               free_irq(irq, queue);
> > > +               queue->iommu =3D NULL;
> > > +               dev_err(iommu->dev, "queue #%u failed to start\n", qu=
eue->qid);
> > > +               return -EBUSY;
> > > +       }
> > > +
> > > +       /* Clear any pending interrupt flag. */
> > > +       riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IPSR, Q_IPSR(queue)=
);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +/*
> > > + * Disable queue. Wait for the hardware to acknowledge request and
> > > + * stop processing enqueued requests. Report errors but continue.
> > > + */
> > > +static void riscv_iommu_queue_disable(struct riscv_iommu_queue *queu=
e)
> > > +{
> > > +       struct riscv_iommu_device *iommu =3D queue->iommu;
> > > +       u32 csr;
> > > +
> > > +       if (!iommu)
> > > +               return;
> > > +
> > > +       free_irq(iommu->irqs[riscv_iommu_queue_vec(iommu, queue->qid)=
], queue);
> > > +       riscv_iommu_writel(iommu, queue->qcr, 0);
> > > +       riscv_iommu_readl_timeout(iommu, queue->qcr,
> > > +                                 csr, !(csr & RISCV_IOMMU_QUEUE_BUSY=
),
> > > +                                 10, RISCV_IOMMU_QCSR_TIMEOUT);
> > > +
> > > +       if (csr & (RISCV_IOMMU_QUEUE_ACTIVE | RISCV_IOMMU_QUEUE_BUSY)=
)
> > > +               dev_err(iommu->dev, "fail to disable hardware queue #=
%u, csr 0x%x\n",
> > > +                       queue->qid, csr);
> > > +
> > > +       queue->iommu =3D NULL;
> > > +}
> > > +
> > > +/*
> > > + * Returns number of available valid queue entries and the first ite=
m index.
> > > + * Update shadow producer index if necessary.
> > > + */
> > > +static int riscv_iommu_queue_consume(struct riscv_iommu_queue *queue=
,
> > > +                                    unsigned int *index)
> > > +{
> > > +       unsigned int head =3D atomic_read(&queue->head);
> > > +       unsigned int tail =3D atomic_read(&queue->tail);
> > > +       unsigned int last =3D Q_ITEM(queue, tail);
> > > +       int available =3D (int)(tail - head);
> > > +
> > > +       *index =3D head;
> > > +
> > > +       if (available > 0)
> > > +               return available;
> > > +
> > > +       /* read hardware producer index, check reserved register bits=
 are not set. */
> > > +       if (riscv_iommu_readl_timeout(queue->iommu, Q_TAIL(queue),
> > > +                                     tail, (tail & ~queue->mask) =3D=
=3D 0,
> > > +                                     0, RISCV_IOMMU_QUEUE_TIMEOUT)) =
{
> > > +               dev_err_once(queue->iommu->dev,
> > > +                            "Hardware error: queue access timeout\n"=
);
> > > +               return 0;
> > > +       }
> > > +
> > > +       if (tail =3D=3D last)
> > > +               return 0;
> > > +
> > > +       /* update shadow producer index */
> > > +       return (int)(atomic_add_return((tail - last) & queue->mask, &=
queue->tail) - head);
> > > +}
> > > +
> > > +/*
> > > + * Release processed queue entries, should match riscv_iommu_queue_c=
onsume() calls.
> > > + */
> > > +static void riscv_iommu_queue_release(struct riscv_iommu_queue *queu=
e, int count)
> > > +{
> > > +       const unsigned int head =3D atomic_add_return(count, &queue->=
head);
> > > +
> > > +       riscv_iommu_writel(queue->iommu, Q_HEAD(queue), Q_ITEM(queue,=
 head));
> > > +}
> > > +
> > > +/* Return actual consumer index based on hardware reported queue hea=
d index. */
> > > +static unsigned int riscv_iommu_queue_cons(struct riscv_iommu_queue =
*queue)
> > > +{
> > > +       const unsigned int cons =3D atomic_read(&queue->head);
> > > +       const unsigned int last =3D Q_ITEM(queue, cons);
> > > +       unsigned int head;
> > > +
> > > +       if (riscv_iommu_readl_timeout(queue->iommu, Q_HEAD(queue), he=
ad,
> > > +                                     !(head & ~queue->mask),
> > > +                                     0, RISCV_IOMMU_QUEUE_TIMEOUT))
> > > +               return cons;
> > > +
> > > +       return cons + ((head - last) & queue->mask);
> > > +}
> > > +
> > > +/* Wait for submitted item to be processed. */
> > > +static int riscv_iommu_queue_wait(struct riscv_iommu_queue *queue,
> > > +                                 unsigned int index,
> > > +                                 unsigned int timeout_us)
> > > +{
> > > +       unsigned int cons =3D atomic_read(&queue->head);
> > > +
> > > +       /* Already processed by the consumer */
> > > +       if ((int)(cons - index) > 0)
> > > +               return 0;
> > > +
> > > +       /* Monitor consumer index */
> > > +       return readx_poll_timeout(riscv_iommu_queue_cons, queue, cons=
,
> > > +                                (int)(cons - index) > 0, 0, timeout_=
us);
> > > +}
> >
> > Apart from iofence command, it seems to me that we might not be able
> > to use the head pointer to determine whether the command is executed,
> > because spec mentioned that the IOMMU advancing cqh is not a guarantee
> > that the commands fetched by the IOMMU have been executed or
> > committed. For iofence completion, perhaps using ADD and AV to write
> > memory would be better as well.
> >
>
> I'll update the comment to the function that this is *only* allowed to
> track IOFENCE.C completion. Call to riscv_iommu_queue_wait() is used
> only for this purpose (unless specification will be extended to track
> other commands with head/tail updates).

I'm not sure whether it is a good idea if we check the opcode around
there, but adding comment is ok to me. Thanks

>
> Previous version of the command tracking used address/AV notifier, but
> after several iterations and testing we've considered tracking
> head/tail as best approach.

Thanks for bringing the information back here again.

>
> > > +
> > > +/* Enqueue an entry and wait to be processed if timeout_us > 0
> > > + *
> > > + * Error handling for IOMMU hardware not responding in reasonable ti=
me
> > > + * will be added as separate patch series along with other RAS featu=
res.
> > > + * For now, only report hardware failure and continue.
> > > + */
> > > +static void riscv_iommu_queue_send(struct riscv_iommu_queue *queue,
> > > +                                  void *entry, size_t entry_size,
> > > +                                  unsigned int timeout_us)
> > > +{
> > > +       unsigned int prod;
> > > +       unsigned int head;
> > > +       unsigned int tail;
> > > +       unsigned long flags;
> > > +
> > > +       /* Do not preempt submission flow. */
> > > +       local_irq_save(flags);
> > > +
> > > +       /* 1. Allocate some space in the queue */
> > > +       prod =3D atomic_inc_return(&queue->prod) - 1;
> > > +       head =3D atomic_read(&queue->head);
> > > +
> > > +       /* 2. Wait for space availability. */
> > > +       if ((prod - head) > queue->mask) {
> > > +               if (readx_poll_timeout(atomic_read, &queue->head,
> > > +                                      head, (prod - head) < queue->m=
ask,
> > > +                                      0, RISCV_IOMMU_QUEUE_TIMEOUT))
> > > +                       goto err_busy;
> > > +       } else if ((prod - head) =3D=3D queue->mask) {
> > > +               const unsigned int last =3D Q_ITEM(queue, head);
> > > +
> > > +               if (riscv_iommu_readl_timeout(queue->iommu, Q_HEAD(qu=
eue), head,
> > > +                                             !(head & ~queue->mask) =
&& head !=3D last,
> > > +                                             0, RISCV_IOMMU_QUEUE_TI=
MEOUT))
> > > +                       goto err_busy;
> > > +               atomic_add((head - last) & queue->mask, &queue->head)=
;
> > > +       }
> > > +
> > > +       /* 3. Store entry in the ring buffer. */
> > > +       memcpy(queue->base + Q_ITEM(queue, prod) * entry_size, entry,=
 entry_size);
> > > +
> > > +       /* 4. Wait for all previous entries to be ready */
> > > +       if (readx_poll_timeout(atomic_read, &queue->tail, tail, prod =
=3D=3D tail,
> > > +                              0, RISCV_IOMMU_QUEUE_TIMEOUT))
> > > +               goto err_busy;
> > > +
> > > +       /* 5. Complete submission and restore local interrupts */
> > > +       dma_wmb();
> > > +       riscv_iommu_writel(queue->iommu, Q_TAIL(queue), Q_ITEM(queue,=
 prod + 1));
> > > +       atomic_inc(&queue->tail);
> > > +       local_irq_restore(flags);
> > > +
> > > +       if (timeout_us && riscv_iommu_queue_wait(queue, prod, timeout=
_us))
> > > +               dev_err_once(queue->iommu->dev,
> > > +                            "Hardware error: command execution timeo=
ut\n");
> > > +
> > > +       return;
> > > +
> > > +err_busy:
> > > +       local_irq_restore(flags);
> > > +       dev_err_once(queue->iommu->dev, "Hardware error: command enqu=
eue failed\n");
> > > +}
> > > +
> > > +/*
> > > + * IOMMU Command queue chapter 3.1
> > > + */
> > > +
> > > +/* Command queue interrupt handler thread function */
> > > +static irqreturn_t riscv_iommu_cmdq_process(int irq, void *data)
> > > +{
> > > +       const struct riscv_iommu_queue *queue =3D (struct riscv_iommu=
_queue *)data;
> > > +       unsigned int ctrl;
> > > +
> > > +       /* Clear MF/CQ errors, complete error recovery to be implemen=
ted. */
> > > +       ctrl =3D riscv_iommu_readl(queue->iommu, queue->qcr);
> > > +       if (ctrl & (RISCV_IOMMU_CQCSR_CQMF | RISCV_IOMMU_CQCSR_CMD_TO=
 |
> > > +                   RISCV_IOMMU_CQCSR_CMD_ILL | RISCV_IOMMU_CQCSR_FEN=
CE_W_IP)) {
> > > +               riscv_iommu_writel(queue->iommu, queue->qcr, ctrl);
> >
> > For RISCV_IOMMU_CQCSR_CMD_ILL and RISCV_IOMMU_CQCSR_CMD_TO, I think we
> > need to adjust the head/tail pointer, otherwise, IOMMU might keep
> > trying to execute the problematic command.
> >
> > > +               dev_warn(queue->iommu->dev,
> > > +                        "Queue #%u error; fault:%d timeout:%d illega=
l:%d fence_w_ip:%d\n",
> >
> > It might be a bit weird if we view fence_w_ip as queue error and print
> > the message as error?
>
> Driver does not set WSI bit in IOFENCE.C command structure, so it's
> unexpected to see fence_w_ip set. This message is warning only about
> unexpected command queue interrupt, listing state of possible
> triggers.

Okay, perhaps we can adjust it in the future when we actually enable
the fence_w_ip. Thanks

>
> >
> > > +                        queue->qid,
> > > +                        !!(ctrl & RISCV_IOMMU_CQCSR_CQMF),
> > > +                        !!(ctrl & RISCV_IOMMU_CQCSR_CMD_TO),
> > > +                        !!(ctrl & RISCV_IOMMU_CQCSR_CMD_ILL),
> > > +                        !!(ctrl & RISCV_IOMMU_CQCSR_FENCE_W_IP));
> > > +       }
> > > +
> > > +       /* Placeholder for command queue interrupt notifiers */
> > > +
> > > +       /* Clear command interrupt pending. */
> > > +       riscv_iommu_writel(queue->iommu, RISCV_IOMMU_REG_IPSR, Q_IPSR=
(queue));
> > > +
> > > +       return IRQ_HANDLED;
> > > +}
> > > +
> > > +/* Send command to the IOMMU command queue */
> > > +static void riscv_iommu_cmd_send(struct riscv_iommu_device *iommu,
> > > +                                struct riscv_iommu_command *cmd,
> > > +                                unsigned int timeout_us)
> > > +{
> > > +       riscv_iommu_queue_send(&iommu->cmdq, cmd, sizeof(*cmd), timeo=
ut_us);
> > > +}
> > > +
> > > +/*
> > > + * IOMMU Fault/Event queue chapter 3.2
> > > + */
> > > +
> > > +static void riscv_iommu_fault(struct riscv_iommu_device *iommu,
> > > +                             struct riscv_iommu_fq_record *event)
> > > +{
> > > +       unsigned int err =3D FIELD_GET(RISCV_IOMMU_FQ_HDR_CAUSE, even=
t->hdr);
> > > +       unsigned int devid =3D FIELD_GET(RISCV_IOMMU_FQ_HDR_DID, even=
t->hdr);
> > > +
> > > +       /* Placeholder for future fault handling implementation, repo=
rt only. */
> > > +       if (err)
> > > +               dev_warn_ratelimited(iommu->dev,
> > > +                                    "Fault %d devid: 0x%x iotval: %l=
lx iotval2: %llx\n",
> > > +                                    err, devid, event->iotval, event=
->iotval2);
> > > +}
> > > +
> > > +/* Fault queue interrupt handler thread function */
> > > +static irqreturn_t riscv_iommu_fltq_process(int irq, void *data)
> > > +{
> > > +       struct riscv_iommu_queue *queue =3D (struct riscv_iommu_queue=
 *)data;
> > > +       struct riscv_iommu_device *iommu =3D queue->iommu;
> > > +       struct riscv_iommu_fq_record *events;
> > > +       unsigned int ctrl, idx;
> > > +       int cnt, len;
> > > +
> > > +       events =3D (struct riscv_iommu_fq_record *)queue->base;
> > > +
> > > +       /* Clear fault interrupt pending and process all received fau=
lt events. */
> > > +       riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IPSR, Q_IPSR(queue)=
);
> > > +
> > > +       do {
> > > +               cnt =3D riscv_iommu_queue_consume(queue, &idx);
> > > +               for (len =3D 0; len < cnt; idx++, len++)
> > > +                       riscv_iommu_fault(iommu, &events[Q_ITEM(queue=
, idx)]);
> > > +               riscv_iommu_queue_release(queue, cnt);
> > > +       } while (cnt > 0);
> > > +
> > > +       /* Clear MF/OF errors, complete error recovery to be implemen=
ted. */
> > > +       ctrl =3D riscv_iommu_readl(iommu, queue->qcr);
> > > +       if (ctrl & (RISCV_IOMMU_FQCSR_FQMF | RISCV_IOMMU_FQCSR_FQOF))=
 {
> > > +               riscv_iommu_writel(iommu, queue->qcr, ctrl);
> > > +               dev_warn(iommu->dev,
> > > +                        "Queue #%u error; memory fault:%d overflow:%=
d\n",
> > > +                        queue->qid,
> > > +                        !!(ctrl & RISCV_IOMMU_FQCSR_FQMF),
> > > +                        !!(ctrl & RISCV_IOMMU_FQCSR_FQOF));
> > > +       }
> > > +
> > > +       return IRQ_HANDLED;
> > > +}
> > > +
> > >  /* Lookup and initialize device context info structure. */
> > >  static struct riscv_iommu_dc *riscv_iommu_get_dc(struct riscv_iommu_=
device *iommu,
> > >                                                  unsigned int devid)
> > > @@ -250,6 +683,7 @@ static int riscv_iommu_iodir_set_mode(struct risc=
v_iommu_device *iommu,
> > >         struct device *dev =3D iommu->dev;
> > >         u64 ddtp, rq_ddtp;
> > >         unsigned int mode, rq_mode =3D ddtp_mode;
> > > +       struct riscv_iommu_command cmd;
> > >
> > >         ddtp =3D riscv_iommu_read_ddtp(iommu);
> > >         if (ddtp & RISCV_IOMMU_DDTP_BUSY)
> > > @@ -317,6 +751,18 @@ static int riscv_iommu_iodir_set_mode(struct ris=
cv_iommu_device *iommu,
> > >         if (mode !=3D ddtp_mode)
> > >                 dev_dbg(dev, "DDTP hw mode %u, requested %u\n", mode,=
 ddtp_mode);
> > >
> > > +       /* Invalidate device context cache */
> > > +       riscv_iommu_cmd_iodir_inval_ddt(&cmd);
> > > +       riscv_iommu_cmd_send(iommu, &cmd, 0);
> > > +
> > > +       /* Invalidate address translation cache */
> > > +       riscv_iommu_cmd_inval_vma(&cmd);
> > > +       riscv_iommu_cmd_send(iommu, &cmd, 0);
> > > +
> > > +       /* IOFENCE.C */
> > > +       riscv_iommu_cmd_iofence(&cmd);
> > > +       riscv_iommu_cmd_send(iommu, &cmd, RISCV_IOMMU_IOTINVAL_TIMEOU=
T);
> > > +
> > >         return 0;
> > >  }
> > >
> > > @@ -492,6 +938,26 @@ static int riscv_iommu_init_check(struct riscv_i=
ommu_device *iommu)
> > >                         return -EINVAL;
> > >         }
> > >
> > > +       /*
> > > +        * Distribute interrupt vectors, always use first vector for =
CIV.
> > > +        * At least one interrupt is required. Read back and verify.
> > > +        */
> > > +       if (!iommu->irqs_count)
> > > +               return -EINVAL;
> > > +
> > > +       iommu->ivec =3D 0;
> > > +       iommu->ivec |=3D FIELD_PREP(RISCV_IOMMU_IVEC_FIV, 1 % iommu->=
irqs_count);
> > > +       iommu->ivec |=3D FIELD_PREP(RISCV_IOMMU_IVEC_PIV, 2 % iommu->=
irqs_count);
> > > +       iommu->ivec |=3D FIELD_PREP(RISCV_IOMMU_IVEC_PMIV, 3 % iommu-=
>irqs_count);
> > > +       riscv_iommu_writeq(iommu, RISCV_IOMMU_REG_IVEC, iommu->ivec);
> > > +
> > > +       iommu->ivec =3D riscv_iommu_readq(iommu, RISCV_IOMMU_REG_IVEC=
);
> > > +       if (riscv_iommu_queue_vec(iommu, RISCV_IOMMU_IVEC_CIV) >=3D R=
ISCV_IOMMU_INTR_COUNT ||
> > > +           riscv_iommu_queue_vec(iommu, RISCV_IOMMU_IVEC_FIV) >=3D R=
ISCV_IOMMU_INTR_COUNT ||
> > > +           riscv_iommu_queue_vec(iommu, RISCV_IOMMU_IVEC_PIV) >=3D R=
ISCV_IOMMU_INTR_COUNT ||
> > > +           riscv_iommu_queue_vec(iommu, RISCV_IOMMU_IVEC_PMIV) >=3D =
RISCV_IOMMU_INTR_COUNT)
> > > +               return -EINVAL;
> > > +
> > >         return 0;
> > >  }
> > >
> > > @@ -500,12 +966,17 @@ void riscv_iommu_remove(struct riscv_iommu_devi=
ce *iommu)
> > >         iommu_device_unregister(&iommu->iommu);
> > >         iommu_device_sysfs_remove(&iommu->iommu);
> > >         riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_MODE_OFF);
> > > +       riscv_iommu_queue_disable(&iommu->cmdq);
> > > +       riscv_iommu_queue_disable(&iommu->fltq);
> > >  }
> > >
> > >  int riscv_iommu_init(struct riscv_iommu_device *iommu)
> > >  {
> > >         int rc;
> > >
> > > +       RISCV_IOMMU_QUEUE_INIT(&iommu->cmdq, CQ);
> > > +       RISCV_IOMMU_QUEUE_INIT(&iommu->fltq, FQ);
> > > +
> > >         rc =3D riscv_iommu_init_check(iommu);
> > >         if (rc)
> > >                 return dev_err_probe(iommu->dev, rc, "unexpected devi=
ce state\n");
> > > @@ -514,10 +985,28 @@ int riscv_iommu_init(struct riscv_iommu_device =
*iommu)
> > >         if (rc)
> > >                 return rc;
> > >
> > > -       rc =3D riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_MOD=
E_MAX);
> > > +       rc =3D riscv_iommu_queue_alloc(iommu, &iommu->cmdq,
> > > +                                    sizeof(struct riscv_iommu_comman=
d));
> > > +       if (rc)
> > > +               return rc;
> > > +
> > > +       rc =3D riscv_iommu_queue_alloc(iommu, &iommu->fltq,
> > > +                                    sizeof(struct riscv_iommu_fq_rec=
ord));
> > > +       if (rc)
> > > +               return rc;
> > > +
> > > +       rc =3D riscv_iommu_queue_enable(iommu, &iommu->cmdq, riscv_io=
mmu_cmdq_process);
> > >         if (rc)
> > >                 return rc;
> > >
> > > +       rc =3D riscv_iommu_queue_enable(iommu, &iommu->fltq, riscv_io=
mmu_fltq_process);
> > > +       if (rc)
> > > +               goto err_queue_disable;
> > > +
> > > +       rc =3D riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_MOD=
E_MAX);
> > > +       if (rc)
> > > +               goto err_queue_disable;
> > > +
> > >         rc =3D iommu_device_sysfs_add(&iommu->iommu, NULL, NULL, "ris=
cv-iommu@%s",
> > >                                     dev_name(iommu->dev));
> > >         if (rc) {
> > > @@ -537,5 +1026,8 @@ int riscv_iommu_init(struct riscv_iommu_device *=
iommu)
> > >         iommu_device_sysfs_remove(&iommu->iommu);
> > >  err_iodir_off:
> > >         riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_MODE_OFF);
> > > +err_queue_disable:
> > > +       riscv_iommu_queue_disable(&iommu->fltq);
> > > +       riscv_iommu_queue_disable(&iommu->cmdq);
> > >         return rc;
> > >  }
> > > diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.=
h
> > > index f1696926582c..03e0c45bc7e1 100644
> > > --- a/drivers/iommu/riscv/iommu.h
> > > +++ b/drivers/iommu/riscv/iommu.h
> > > @@ -17,6 +17,22 @@
> > >
> > >  #include "iommu-bits.h"
> > >
> > > +struct riscv_iommu_device;
> > > +
> > > +struct riscv_iommu_queue {
> > > +       atomic_t prod;                          /* unbounded producer=
 allocation index */
> > > +       atomic_t head;                          /* unbounded shadow r=
ing buffer consumer index */
> > > +       atomic_t tail;                          /* unbounded shadow r=
ing buffer producer index */
> > > +       unsigned int mask;                      /* index mask, queue =
length - 1 */
> > > +       unsigned int irq;                       /* allocated interrup=
t number */
> > > +       struct riscv_iommu_device *iommu;       /* iommu device handl=
ing the queue when active */
> > > +       void *base;                             /* ring buffer kernel=
 pointer */
> > > +       dma_addr_t phys;                        /* ring buffer physic=
al address */
> > > +       u16 qbr;                                /* base register offs=
et, head and tail reference */
> > > +       u16 qcr;                                /* control and status=
 register offset */
> > > +       u8 qid;                                 /* queue identifier, =
same as RISCV_IOMMU_INTR_XX */
> > > +};
> > > +
> > >  struct riscv_iommu_device {
> > >         /* iommu core interface */
> > >         struct iommu_device iommu;
> > > @@ -34,6 +50,11 @@ struct riscv_iommu_device {
> > >         /* available interrupt numbers, MSI or WSI */
> > >         unsigned int irqs[RISCV_IOMMU_INTR_COUNT];
> > >         unsigned int irqs_count;
> > > +       unsigned int ivec;
> > > +
> > > +       /* hardware queues */
> > > +       struct riscv_iommu_queue cmdq;
> > > +       struct riscv_iommu_queue fltq;
> > >
> > >         /* device directory */
> > >         unsigned int ddt_mode;
> > > --
> > > 2.34.1
> > >
>
> Best,
> - Tomasz
>
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
