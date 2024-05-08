Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DEA84A38
	for <iommu@lists.linux.dev>; Wed,  8 May 2024 15:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715182750; cv=none; b=PDt0aPcAt0gpbvwz6d5PcMYQlDIAFL9pAnI9aR6npva3G0RxJcdUaOQ1UMBIcf5NxQ6lIX6FB9FyCBvTvYIe0xSEpY0oj8gcIbjZu9s7b5uSLvaKpFL5ui41f3j9Q7WD+bzJ8TGIp/9JlOpRzDxoS2wK2rXQGJMU5NN1/64cu8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715182750; c=relaxed/simple;
	bh=XCOfphAWWVHCXqG8wyNN2Wcii1G+lx1EInsiJpHscLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4mQq5ty9E/0uJrCd4ct16xAr+WJ/gFvfMisIvIPHLsTA33Ejca2ntVrfoYPWckCEhGU/jHLNqd05NvCLeeyxY07cvmpiTlnzZkVexvhU0KxuecQ6I6sChua8jaWGvy+xTLFWVLft2/8xqMFJOt8CPRbCQFUvkbG0UFkclPSSyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=f6qNR+TP; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="f6qNR+TP"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5b22f818a24so1491605eaf.1
        for <iommu@lists.linux.dev>; Wed, 08 May 2024 08:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715182747; x=1715787547; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=limtBVI9MykgftDyY/f+++qPSUASl/s/QYosYT8KLzQ=;
        b=f6qNR+TPeLZxAL4iV9qvXOJUKPoSRC0wY4Q725djxZW56fFhmqMTjsp4WJbN21DB3W
         rtkxMOKoMYVIYDDud0fsFgv3qwC++V5xsWoyBTD22BAIo4sYUijJU1ENVDSInKn7xTyp
         quVZIdDze4VL6uUgpKrk5mEu3cM/7diRDkJBfa8c2AL3pM4+0Td94486SVxUBC5MiD5I
         HqYT6oUh0VjueLLAfMEJJmnAlJYe8sB08IhvGY7TYtqpTc4p98ktLVHfAFQb/ysj3VKe
         rFKccBvQk/bu+xi9nuhMFex0Yb+suyg7L8nU1VodIuoBNaAX0vhm1aCIomhR1LaEhVCE
         wRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715182747; x=1715787547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=limtBVI9MykgftDyY/f+++qPSUASl/s/QYosYT8KLzQ=;
        b=cFdn7g5xuVpZVlWKAe4avkHaFKR7BphcujmuxR77LISjGAromjesQ1gxsfHNetPUCO
         rkB/iIj2uuPGcoIowA9TCvgT+AkUPv/aTYRPw0EwhqpSC/Wttaa+jxK9d++zXimsGMLN
         Neng95XrlkZr+V5rr+qCIo+LDwLacfXGoD4X1mn1zmX4CVk01wcoh51eXRZoPRBMAnYy
         AGZj7n0Gol/mn4gfEDH79Yh+cwXvQ49uzFY/ABA7xC2PiIb/xtH5r8JEGtcHRHDxhdnl
         ZZsLUhs4jLMTZT+Q78lrIRrHzaJVjt0FXUEoHrxsUIKKCUGi5liq2PmUp2ab8WyODNf5
         5hbQ==
X-Forwarded-Encrypted: i=1; AJvYcCW95v9Ed3ONTPjdb/zekH8GPrZzYiXApuWM2wsOsobrAFqDLxfuz61m/rFJT5FJ624Zju62n0lMP1TVVVfXKBjk7KtHmVY=
X-Gm-Message-State: AOJu0YxB/D+Tef1e9x7X49wZzO+/He9Nc+mH0TYjzgWJSMGsliDkaPu9
	J7h8utS7PE/JVIHb0nEC3Xbp7ZFFuKoiAMbF9ucwNbSlSgsI2STDiYr5Zjc/etEnhjHWoaH/QK2
	47IcoJFva1A0nsZKzb5UvvYmZRH4GmJY3IyWinw==
X-Google-Smtp-Source: AGHT+IHI2DGsLq0EFgaG62DbfYkEkjx6W1M2aYxvCsIqCTNU0xdxrusynWsIt+er9+03eFj12c8TpjPDVXz0WlDMyKo=
X-Received: by 2002:a4a:8c24:0:b0:5aa:538a:ed60 with SMTP id
 006d021491bc7-5b24d28fdb4mr2724899eaf.3.1715182747035; Wed, 08 May 2024
 08:39:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1714752293.git.tjeznach@rivosinc.com> <f63635cd72fd0d1b0026a6839dbfeaa2cd154eaa.1714752293.git.tjeznach@rivosinc.com>
In-Reply-To: <f63635cd72fd0d1b0026a6839dbfeaa2cd154eaa.1714752293.git.tjeznach@rivosinc.com>
From: Zong Li <zong.li@sifive.com>
Date: Wed, 8 May 2024 23:38:56 +0800
Message-ID: <CANXhq0qD-9d5Nbh3By2zf6BORNOsM3W4CN4J8H94c_n3_xT_Pg@mail.gmail.com>
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

On Sat, May 4, 2024 at 12:13=E2=80=AFAM Tomasz Jeznach <tjeznach@rivosinc.c=
om> wrote:
>
> Introduce device command submission and fault reporting queues,
> as described in Chapter 3.1 and 3.2 of the RISC-V IOMMU Architecture
> Specification.
>
> Command and fault queues are instantiated in contiguous system memory
> local to IOMMU device domain, or mapped from fixed I/O space provided
> by the hardware implementation. Detection of the location and maximum
> allowed size of the queue utilize WARL properties of queue base control
> register. Driver implementation will try to allocate up to 128KB of
> system memory, while respecting hardware supported maximum queue size.
>
> Interrupts allocation is based on interrupt vectors availability and
> distributed to all queues in simple round-robin fashion. For hardware
> Implementation with fixed event type to interrupt vector assignment
> IVEC WARL property is used to discover such mappings.
>
> Address translation, command and queue fault handling in this change
> is limited to simple fault reporting without taking any action.
>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> ---
>  drivers/iommu/riscv/iommu-bits.h |  75 +++++
>  drivers/iommu/riscv/iommu.c      | 496 ++++++++++++++++++++++++++++++-
>  drivers/iommu/riscv/iommu.h      |  21 ++
>  3 files changed, 590 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iommu=
-bits.h
> index ba093c29de9f..40c379222821 100644
> --- a/drivers/iommu/riscv/iommu-bits.h
> +++ b/drivers/iommu/riscv/iommu-bits.h
> @@ -704,4 +704,79 @@ struct riscv_iommu_msi_pte {
>  #define RISCV_IOMMU_MSI_MRIF_NPPN      RISCV_IOMMU_PPN_FIELD
>  #define RISCV_IOMMU_MSI_MRIF_NID_MSB   BIT_ULL(60)
>
> +/* Helper functions: command structure builders. */
> +
> +static inline void riscv_iommu_cmd_inval_vma(struct riscv_iommu_command =
*cmd)
> +{
> +       cmd->dword0 =3D FIELD_PREP(RISCV_IOMMU_CMD_OPCODE, RISCV_IOMMU_CM=
D_IOTINVAL_OPCODE) |
> +                     FIELD_PREP(RISCV_IOMMU_CMD_FUNC, RISCV_IOMMU_CMD_IO=
TINVAL_FUNC_VMA);
> +       cmd->dword1 =3D 0;
> +}
> +
> +static inline void riscv_iommu_cmd_inval_set_addr(struct riscv_iommu_com=
mand *cmd,
> +                                                 u64 addr)
> +{
> +       cmd->dword1 =3D FIELD_PREP(RISCV_IOMMU_CMD_IOTINVAL_ADDR, phys_to=
_pfn(addr));
> +       cmd->dword0 |=3D RISCV_IOMMU_CMD_IOTINVAL_AV;
> +}
> +
> +static inline void riscv_iommu_cmd_inval_set_pscid(struct riscv_iommu_co=
mmand *cmd,
> +                                                  int pscid)
> +{
> +       cmd->dword0 |=3D FIELD_PREP(RISCV_IOMMU_CMD_IOTINVAL_PSCID, pscid=
) |
> +                      RISCV_IOMMU_CMD_IOTINVAL_PSCV;
> +}
> +
> +static inline void riscv_iommu_cmd_inval_set_gscid(struct riscv_iommu_co=
mmand *cmd,
> +                                                  int gscid)
> +{
> +       cmd->dword0 |=3D FIELD_PREP(RISCV_IOMMU_CMD_IOTINVAL_GSCID, gscid=
) |
> +                      RISCV_IOMMU_CMD_IOTINVAL_GV;
> +}
> +
> +static inline void riscv_iommu_cmd_iofence(struct riscv_iommu_command *c=
md)
> +{
> +       cmd->dword0 =3D FIELD_PREP(RISCV_IOMMU_CMD_OPCODE, RISCV_IOMMU_CM=
D_IOFENCE_OPCODE) |
> +                     FIELD_PREP(RISCV_IOMMU_CMD_FUNC, RISCV_IOMMU_CMD_IO=
FENCE_FUNC_C) |
> +                     RISCV_IOMMU_CMD_IOFENCE_PR | RISCV_IOMMU_CMD_IOFENC=
E_PW;
> +       cmd->dword1 =3D 0;
> +}
> +
> +static inline void riscv_iommu_cmd_iofence_set_av(struct riscv_iommu_com=
mand *cmd,
> +                                                 u64 addr, u32 data)
> +{
> +       cmd->dword0 =3D FIELD_PREP(RISCV_IOMMU_CMD_OPCODE, RISCV_IOMMU_CM=
D_IOFENCE_OPCODE) |
> +                     FIELD_PREP(RISCV_IOMMU_CMD_FUNC, RISCV_IOMMU_CMD_IO=
FENCE_FUNC_C) |
> +                     FIELD_PREP(RISCV_IOMMU_CMD_IOFENCE_DATA, data) |
> +                     RISCV_IOMMU_CMD_IOFENCE_AV;
> +       cmd->dword1 =3D addr >> 2;
> +}
> +
> +static inline void riscv_iommu_cmd_iodir_inval_ddt(struct riscv_iommu_co=
mmand *cmd)
> +{
> +       cmd->dword0 =3D FIELD_PREP(RISCV_IOMMU_CMD_OPCODE, RISCV_IOMMU_CM=
D_IODIR_OPCODE) |
> +                     FIELD_PREP(RISCV_IOMMU_CMD_FUNC, RISCV_IOMMU_CMD_IO=
DIR_FUNC_INVAL_DDT);
> +       cmd->dword1 =3D 0;
> +}
> +
> +static inline void riscv_iommu_cmd_iodir_inval_pdt(struct riscv_iommu_co=
mmand *cmd)
> +{
> +       cmd->dword0 =3D FIELD_PREP(RISCV_IOMMU_CMD_OPCODE, RISCV_IOMMU_CM=
D_IODIR_OPCODE) |
> +                     FIELD_PREP(RISCV_IOMMU_CMD_FUNC, RISCV_IOMMU_CMD_IO=
DIR_FUNC_INVAL_PDT);
> +       cmd->dword1 =3D 0;
> +}
> +
> +static inline void riscv_iommu_cmd_iodir_set_did(struct riscv_iommu_comm=
and *cmd,
> +                                                unsigned int devid)
> +{
> +       cmd->dword0 |=3D FIELD_PREP(RISCV_IOMMU_CMD_IODIR_DID, devid) |
> +                      RISCV_IOMMU_CMD_IODIR_DV;
> +}
> +
> +static inline void riscv_iommu_cmd_iodir_set_pid(struct riscv_iommu_comm=
and *cmd,
> +                                                unsigned int pasid)
> +{
> +       cmd->dword0 |=3D FIELD_PREP(RISCV_IOMMU_CMD_IODIR_PID, pasid);
> +}
> +
>  #endif /* _RISCV_IOMMU_BITS_H_ */
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index 71b7903d83d4..4349ac8a3990 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -25,7 +25,14 @@
>  #include "iommu.h"
>
>  /* Timeouts in [us] */
> -#define RISCV_IOMMU_DDTP_TIMEOUT       50000
> +#define RISCV_IOMMU_QCSR_TIMEOUT       150000
> +#define RISCV_IOMMU_QUEUE_TIMEOUT      150000
> +#define RISCV_IOMMU_DDTP_TIMEOUT       10000000
> +#define RISCV_IOMMU_IOTINVAL_TIMEOUT   90000000
> +
> +/* Number of entries per CMD/FLT queue, should be <=3D INT_MAX */
> +#define RISCV_IOMMU_DEF_CQ_COUNT       8192
> +#define RISCV_IOMMU_DEF_FQ_COUNT       4096
>
>  /* RISC-V IOMMU PPN <> PHYS address conversions, PHYS <=3D> PPN[53:10] *=
/
>  #define phys_to_ppn(va)  (((va) >> 2) & (((1ULL << 44) - 1) << 10))
> @@ -89,6 +96,432 @@ static void riscv_iommu_free_pages(struct riscv_iommu=
_device *iommu, void *addr)
>                        riscv_iommu_devres_pages_match, &devres);
>  }
>
> +/*
> + * Hardware queue allocation and management.
> + */
> +
> +/* Setup queue base, control registers and default queue length */
> +#define RISCV_IOMMU_QUEUE_INIT(q, name) do {                           \
> +       struct riscv_iommu_queue *_q =3D q;                              =
 \
> +       _q->qid =3D RISCV_IOMMU_INTR_ ## name;                           =
 \
> +       _q->qbr =3D RISCV_IOMMU_REG_ ## name ## B;                       =
 \
> +       _q->qcr =3D RISCV_IOMMU_REG_ ## name ## CSR;                     =
 \
> +       _q->mask =3D _q->mask ?: (RISCV_IOMMU_DEF_ ## name ## _COUNT) - 1=
;\
> +} while (0)
> +
> +/* Note: offsets are the same for all queues */
> +#define Q_HEAD(q) ((q)->qbr + (RISCV_IOMMU_REG_CQH - RISCV_IOMMU_REG_CQB=
))
> +#define Q_TAIL(q) ((q)->qbr + (RISCV_IOMMU_REG_CQT - RISCV_IOMMU_REG_CQB=
))
> +#define Q_ITEM(q, index) ((q)->mask & (index))
> +#define Q_IPSR(q) BIT((q)->qid)
> +
> +/*
> + * Discover queue ring buffer hardware configuration, allocate in-memory
> + * ring buffer or use fixed I/O memory location, configure queue base re=
gister.
> + * Must be called before hardware queue is enabled.
> + *
> + * @queue - data structure, configured with RISCV_IOMMU_QUEUE_INIT()
> + * @entry_size - queue single element size in bytes.
> + */
> +static int riscv_iommu_queue_alloc(struct riscv_iommu_device *iommu,
> +                                  struct riscv_iommu_queue *queue,
> +                                  size_t entry_size)
> +{
> +       unsigned int logsz;
> +       u64 qb, rb;
> +
> +       /*
> +        * Use WARL base register property to discover maximum allowed
> +        * number of entries and optional fixed IO address for queue loca=
tion.
> +        */
> +       riscv_iommu_writeq(iommu, queue->qbr, RISCV_IOMMU_QUEUE_LOGSZ_FIE=
LD);
> +       qb =3D riscv_iommu_readq(iommu, queue->qbr);
> +
> +       /*
> +        * Calculate and verify hardware supported queue length, as repor=
ted
> +        * by the field LOGSZ, where max queue length is equal to 2^(LOGS=
Z + 1).
> +        * Update queue size based on hardware supported value.
> +        */
> +       logsz =3D ilog2(queue->mask);
> +       if (logsz > FIELD_GET(RISCV_IOMMU_QUEUE_LOGSZ_FIELD, qb))
> +               logsz =3D FIELD_GET(RISCV_IOMMU_QUEUE_LOGSZ_FIELD, qb);
> +
> +       /*
> +        * Use WARL base register property to discover an optional fixed =
IO
> +        * address for queue ring buffer location. Otherwise allocate con=
tigus
> +        * system memory.
> +        */
> +       if (FIELD_GET(RISCV_IOMMU_PPN_FIELD, qb)) {
> +               const size_t queue_size =3D entry_size << (logsz + 1);
> +
> +               queue->phys =3D ppn_to_phys(FIELD_GET(RISCV_IOMMU_PPN_FIE=
LD, qb));
> +               queue->base =3D devm_ioremap(iommu->dev, queue->phys, que=
ue_size);
> +       } else {
> +               do {
> +                       const size_t queue_size =3D entry_size << (logsz =
+ 1);
> +                       const int order =3D get_order(queue_size);
> +
> +                       queue->base =3D riscv_iommu_get_pages(iommu, orde=
r);
> +                       queue->phys =3D __pa(queue->base);
> +               } while (!queue->base && logsz-- > 0);
> +       }
> +
> +       if (!queue->base)
> +               return -ENOMEM;
> +
> +       qb =3D phys_to_ppn(queue->phys) |
> +            FIELD_PREP(RISCV_IOMMU_QUEUE_LOGSZ_FIELD, logsz);
> +
> +       /* Update base register and read back to verify hw accepted our w=
rite */
> +       riscv_iommu_writeq(iommu, queue->qbr, qb);
> +       rb =3D riscv_iommu_readq(iommu, queue->qbr);
> +       if (rb !=3D qb) {
> +               dev_err(iommu->dev, "queue #%u allocation failed\n", queu=
e->qid);
> +               return -ENODEV;
> +       }
> +
> +       /* Update actual queue mask */
> +       queue->mask =3D (2U << logsz) - 1;
> +
> +       dev_dbg(iommu->dev, "queue #%u allocated 2^%u entries",
> +               queue->qid, logsz + 1);
> +
> +       return 0;
> +}
> +
> +/* Check interrupt queue status, IPSR */
> +static irqreturn_t riscv_iommu_queue_ipsr(int irq, void *data)
> +{
> +       struct riscv_iommu_queue *queue =3D (struct riscv_iommu_queue *)d=
ata;
> +
> +       if (riscv_iommu_readl(queue->iommu, RISCV_IOMMU_REG_IPSR) & Q_IPS=
R(queue))
> +               return IRQ_WAKE_THREAD;
> +
> +       return IRQ_NONE;
> +}
> +
> +static int riscv_iommu_queue_vec(struct riscv_iommu_device *iommu, int n=
)
> +{
> +       /* Reuse IVEC.CIV mask for all interrupt vectors mapping. */
> +       return (iommu->ivec >> (n * 4)) & RISCV_IOMMU_IVEC_CIV;
> +}
> +
> +/*
> + * Enable queue processing in the hardware, register interrupt handler.
> + *
> + * @queue - data structure, already allocated with riscv_iommu_queue_all=
oc()
> + * @irq_handler - threaded interrupt handler.
> + */
> +static int riscv_iommu_queue_enable(struct riscv_iommu_device *iommu,
> +                                   struct riscv_iommu_queue *queue,
> +                                   irq_handler_t irq_handler)
> +{
> +       const unsigned int irq =3D iommu->irqs[riscv_iommu_queue_vec(iomm=
u, queue->qid)];
> +       u32 csr;
> +       int rc;
> +
> +       if (queue->iommu)
> +               return -EBUSY;
> +
> +       /* Polling not implemented */
> +       if (!irq)
> +               return -ENODEV;
> +
> +       queue->iommu =3D iommu;
> +       rc =3D request_threaded_irq(irq, riscv_iommu_queue_ipsr, irq_hand=
ler,
> +                                 IRQF_ONESHOT | IRQF_SHARED,
> +                                 dev_name(iommu->dev), queue);
> +       if (rc) {
> +               queue->iommu =3D NULL;
> +               return rc;
> +       }
> +
> +       /*
> +        * Enable queue with interrupts, clear any memory fault if any.
> +        * Wait for the hardware to acknowledge request and activate queu=
e
> +        * processing.
> +        * Note: All CSR bitfields are in the same offsets for all queues=
.
> +        */
> +       riscv_iommu_writel(iommu, queue->qcr,
> +                          RISCV_IOMMU_QUEUE_ENABLE |
> +                          RISCV_IOMMU_QUEUE_INTR_ENABLE |
> +                          RISCV_IOMMU_QUEUE_MEM_FAULT);
> +
> +       riscv_iommu_readl_timeout(iommu, queue->qcr,
> +                                 csr, !(csr & RISCV_IOMMU_QUEUE_BUSY),
> +                                 10, RISCV_IOMMU_QCSR_TIMEOUT);
> +
> +       if (RISCV_IOMMU_QUEUE_ACTIVE !=3D (csr & (RISCV_IOMMU_QUEUE_ACTIV=
E |
> +                                               RISCV_IOMMU_QUEUE_BUSY |
> +                                               RISCV_IOMMU_QUEUE_MEM_FAU=
LT))) {
> +               /* Best effort to stop and disable failing hardware queue=
. */
> +               riscv_iommu_writel(iommu, queue->qcr, 0);
> +               free_irq(irq, queue);
> +               queue->iommu =3D NULL;
> +               dev_err(iommu->dev, "queue #%u failed to start\n", queue-=
>qid);
> +               return -EBUSY;
> +       }
> +
> +       /* Clear any pending interrupt flag. */
> +       riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IPSR, Q_IPSR(queue));
> +
> +       return 0;
> +}
> +
> +/*
> + * Disable queue. Wait for the hardware to acknowledge request and
> + * stop processing enqueued requests. Report errors but continue.
> + */
> +static void riscv_iommu_queue_disable(struct riscv_iommu_queue *queue)
> +{
> +       struct riscv_iommu_device *iommu =3D queue->iommu;
> +       u32 csr;
> +
> +       if (!iommu)
> +               return;
> +
> +       free_irq(iommu->irqs[riscv_iommu_queue_vec(iommu, queue->qid)], q=
ueue);
> +       riscv_iommu_writel(iommu, queue->qcr, 0);
> +       riscv_iommu_readl_timeout(iommu, queue->qcr,
> +                                 csr, !(csr & RISCV_IOMMU_QUEUE_BUSY),
> +                                 10, RISCV_IOMMU_QCSR_TIMEOUT);
> +
> +       if (csr & (RISCV_IOMMU_QUEUE_ACTIVE | RISCV_IOMMU_QUEUE_BUSY))
> +               dev_err(iommu->dev, "fail to disable hardware queue #%u, =
csr 0x%x\n",
> +                       queue->qid, csr);
> +
> +       queue->iommu =3D NULL;
> +}
> +
> +/*
> + * Returns number of available valid queue entries and the first item in=
dex.
> + * Update shadow producer index if necessary.
> + */
> +static int riscv_iommu_queue_consume(struct riscv_iommu_queue *queue,
> +                                    unsigned int *index)
> +{
> +       unsigned int head =3D atomic_read(&queue->head);
> +       unsigned int tail =3D atomic_read(&queue->tail);
> +       unsigned int last =3D Q_ITEM(queue, tail);
> +       int available =3D (int)(tail - head);
> +
> +       *index =3D head;
> +
> +       if (available > 0)
> +               return available;
> +
> +       /* read hardware producer index, check reserved register bits are=
 not set. */
> +       if (riscv_iommu_readl_timeout(queue->iommu, Q_TAIL(queue),
> +                                     tail, (tail & ~queue->mask) =3D=3D =
0,
> +                                     0, RISCV_IOMMU_QUEUE_TIMEOUT)) {
> +               dev_err_once(queue->iommu->dev,
> +                            "Hardware error: queue access timeout\n");
> +               return 0;
> +       }
> +
> +       if (tail =3D=3D last)
> +               return 0;
> +
> +       /* update shadow producer index */
> +       return (int)(atomic_add_return((tail - last) & queue->mask, &queu=
e->tail) - head);
> +}
> +
> +/*
> + * Release processed queue entries, should match riscv_iommu_queue_consu=
me() calls.
> + */
> +static void riscv_iommu_queue_release(struct riscv_iommu_queue *queue, i=
nt count)
> +{
> +       const unsigned int head =3D atomic_add_return(count, &queue->head=
);
> +
> +       riscv_iommu_writel(queue->iommu, Q_HEAD(queue), Q_ITEM(queue, hea=
d));
> +}
> +
> +/* Return actual consumer index based on hardware reported queue head in=
dex. */
> +static unsigned int riscv_iommu_queue_cons(struct riscv_iommu_queue *que=
ue)
> +{
> +       const unsigned int cons =3D atomic_read(&queue->head);
> +       const unsigned int last =3D Q_ITEM(queue, cons);
> +       unsigned int head;
> +
> +       if (riscv_iommu_readl_timeout(queue->iommu, Q_HEAD(queue), head,
> +                                     !(head & ~queue->mask),
> +                                     0, RISCV_IOMMU_QUEUE_TIMEOUT))
> +               return cons;
> +
> +       return cons + ((head - last) & queue->mask);
> +}
> +
> +/* Wait for submitted item to be processed. */
> +static int riscv_iommu_queue_wait(struct riscv_iommu_queue *queue,
> +                                 unsigned int index,
> +                                 unsigned int timeout_us)
> +{
> +       unsigned int cons =3D atomic_read(&queue->head);
> +
> +       /* Already processed by the consumer */
> +       if ((int)(cons - index) > 0)
> +               return 0;
> +
> +       /* Monitor consumer index */
> +       return readx_poll_timeout(riscv_iommu_queue_cons, queue, cons,
> +                                (int)(cons - index) > 0, 0, timeout_us);
> +}

Apart from iofence command, it seems to me that we might not be able
to use the head pointer to determine whether the command is executed,
because spec mentioned that the IOMMU advancing cqh is not a guarantee
that the commands fetched by the IOMMU have been executed or
committed. For iofence completion, perhaps using ADD and AV to write
memory would be better as well.

> +
> +/* Enqueue an entry and wait to be processed if timeout_us > 0
> + *
> + * Error handling for IOMMU hardware not responding in reasonable time
> + * will be added as separate patch series along with other RAS features.
> + * For now, only report hardware failure and continue.
> + */
> +static void riscv_iommu_queue_send(struct riscv_iommu_queue *queue,
> +                                  void *entry, size_t entry_size,
> +                                  unsigned int timeout_us)
> +{
> +       unsigned int prod;
> +       unsigned int head;
> +       unsigned int tail;
> +       unsigned long flags;
> +
> +       /* Do not preempt submission flow. */
> +       local_irq_save(flags);
> +
> +       /* 1. Allocate some space in the queue */
> +       prod =3D atomic_inc_return(&queue->prod) - 1;
> +       head =3D atomic_read(&queue->head);
> +
> +       /* 2. Wait for space availability. */
> +       if ((prod - head) > queue->mask) {
> +               if (readx_poll_timeout(atomic_read, &queue->head,
> +                                      head, (prod - head) < queue->mask,
> +                                      0, RISCV_IOMMU_QUEUE_TIMEOUT))
> +                       goto err_busy;
> +       } else if ((prod - head) =3D=3D queue->mask) {
> +               const unsigned int last =3D Q_ITEM(queue, head);
> +
> +               if (riscv_iommu_readl_timeout(queue->iommu, Q_HEAD(queue)=
, head,
> +                                             !(head & ~queue->mask) && h=
ead !=3D last,
> +                                             0, RISCV_IOMMU_QUEUE_TIMEOU=
T))
> +                       goto err_busy;
> +               atomic_add((head - last) & queue->mask, &queue->head);
> +       }
> +
> +       /* 3. Store entry in the ring buffer. */
> +       memcpy(queue->base + Q_ITEM(queue, prod) * entry_size, entry, ent=
ry_size);
> +
> +       /* 4. Wait for all previous entries to be ready */
> +       if (readx_poll_timeout(atomic_read, &queue->tail, tail, prod =3D=
=3D tail,
> +                              0, RISCV_IOMMU_QUEUE_TIMEOUT))
> +               goto err_busy;
> +
> +       /* 5. Complete submission and restore local interrupts */
> +       dma_wmb();
> +       riscv_iommu_writel(queue->iommu, Q_TAIL(queue), Q_ITEM(queue, pro=
d + 1));
> +       atomic_inc(&queue->tail);
> +       local_irq_restore(flags);
> +
> +       if (timeout_us && riscv_iommu_queue_wait(queue, prod, timeout_us)=
)
> +               dev_err_once(queue->iommu->dev,
> +                            "Hardware error: command execution timeout\n=
");
> +
> +       return;
> +
> +err_busy:
> +       local_irq_restore(flags);
> +       dev_err_once(queue->iommu->dev, "Hardware error: command enqueue =
failed\n");
> +}
> +
> +/*
> + * IOMMU Command queue chapter 3.1
> + */
> +
> +/* Command queue interrupt handler thread function */
> +static irqreturn_t riscv_iommu_cmdq_process(int irq, void *data)
> +{
> +       const struct riscv_iommu_queue *queue =3D (struct riscv_iommu_que=
ue *)data;
> +       unsigned int ctrl;
> +
> +       /* Clear MF/CQ errors, complete error recovery to be implemented.=
 */
> +       ctrl =3D riscv_iommu_readl(queue->iommu, queue->qcr);
> +       if (ctrl & (RISCV_IOMMU_CQCSR_CQMF | RISCV_IOMMU_CQCSR_CMD_TO |
> +                   RISCV_IOMMU_CQCSR_CMD_ILL | RISCV_IOMMU_CQCSR_FENCE_W=
_IP)) {
> +               riscv_iommu_writel(queue->iommu, queue->qcr, ctrl);

For RISCV_IOMMU_CQCSR_CMD_ILL and RISCV_IOMMU_CQCSR_CMD_TO, I think we
need to adjust the head/tail pointer, otherwise, IOMMU might keep
trying to execute the problematic command.

> +               dev_warn(queue->iommu->dev,
> +                        "Queue #%u error; fault:%d timeout:%d illegal:%d=
 fence_w_ip:%d\n",

It might be a bit weird if we view fence_w_ip as queue error and print
the message as error?


> +                        queue->qid,
> +                        !!(ctrl & RISCV_IOMMU_CQCSR_CQMF),
> +                        !!(ctrl & RISCV_IOMMU_CQCSR_CMD_TO),
> +                        !!(ctrl & RISCV_IOMMU_CQCSR_CMD_ILL),
> +                        !!(ctrl & RISCV_IOMMU_CQCSR_FENCE_W_IP));
> +       }
> +
> +       /* Placeholder for command queue interrupt notifiers */
> +
> +       /* Clear command interrupt pending. */
> +       riscv_iommu_writel(queue->iommu, RISCV_IOMMU_REG_IPSR, Q_IPSR(que=
ue));
> +
> +       return IRQ_HANDLED;
> +}
> +
> +/* Send command to the IOMMU command queue */
> +static void riscv_iommu_cmd_send(struct riscv_iommu_device *iommu,
> +                                struct riscv_iommu_command *cmd,
> +                                unsigned int timeout_us)
> +{
> +       riscv_iommu_queue_send(&iommu->cmdq, cmd, sizeof(*cmd), timeout_u=
s);
> +}
> +
> +/*
> + * IOMMU Fault/Event queue chapter 3.2
> + */
> +
> +static void riscv_iommu_fault(struct riscv_iommu_device *iommu,
> +                             struct riscv_iommu_fq_record *event)
> +{
> +       unsigned int err =3D FIELD_GET(RISCV_IOMMU_FQ_HDR_CAUSE, event->h=
dr);
> +       unsigned int devid =3D FIELD_GET(RISCV_IOMMU_FQ_HDR_DID, event->h=
dr);
> +
> +       /* Placeholder for future fault handling implementation, report o=
nly. */
> +       if (err)
> +               dev_warn_ratelimited(iommu->dev,
> +                                    "Fault %d devid: 0x%x iotval: %llx i=
otval2: %llx\n",
> +                                    err, devid, event->iotval, event->io=
tval2);
> +}
> +
> +/* Fault queue interrupt handler thread function */
> +static irqreturn_t riscv_iommu_fltq_process(int irq, void *data)
> +{
> +       struct riscv_iommu_queue *queue =3D (struct riscv_iommu_queue *)d=
ata;
> +       struct riscv_iommu_device *iommu =3D queue->iommu;
> +       struct riscv_iommu_fq_record *events;
> +       unsigned int ctrl, idx;
> +       int cnt, len;
> +
> +       events =3D (struct riscv_iommu_fq_record *)queue->base;
> +
> +       /* Clear fault interrupt pending and process all received fault e=
vents. */
> +       riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IPSR, Q_IPSR(queue));
> +
> +       do {
> +               cnt =3D riscv_iommu_queue_consume(queue, &idx);
> +               for (len =3D 0; len < cnt; idx++, len++)
> +                       riscv_iommu_fault(iommu, &events[Q_ITEM(queue, id=
x)]);
> +               riscv_iommu_queue_release(queue, cnt);
> +       } while (cnt > 0);
> +
> +       /* Clear MF/OF errors, complete error recovery to be implemented.=
 */
> +       ctrl =3D riscv_iommu_readl(iommu, queue->qcr);
> +       if (ctrl & (RISCV_IOMMU_FQCSR_FQMF | RISCV_IOMMU_FQCSR_FQOF)) {
> +               riscv_iommu_writel(iommu, queue->qcr, ctrl);
> +               dev_warn(iommu->dev,
> +                        "Queue #%u error; memory fault:%d overflow:%d\n"=
,
> +                        queue->qid,
> +                        !!(ctrl & RISCV_IOMMU_FQCSR_FQMF),
> +                        !!(ctrl & RISCV_IOMMU_FQCSR_FQOF));
> +       }
> +
> +       return IRQ_HANDLED;
> +}
> +
>  /* Lookup and initialize device context info structure. */
>  static struct riscv_iommu_dc *riscv_iommu_get_dc(struct riscv_iommu_devi=
ce *iommu,
>                                                  unsigned int devid)
> @@ -250,6 +683,7 @@ static int riscv_iommu_iodir_set_mode(struct riscv_io=
mmu_device *iommu,
>         struct device *dev =3D iommu->dev;
>         u64 ddtp, rq_ddtp;
>         unsigned int mode, rq_mode =3D ddtp_mode;
> +       struct riscv_iommu_command cmd;
>
>         ddtp =3D riscv_iommu_read_ddtp(iommu);
>         if (ddtp & RISCV_IOMMU_DDTP_BUSY)
> @@ -317,6 +751,18 @@ static int riscv_iommu_iodir_set_mode(struct riscv_i=
ommu_device *iommu,
>         if (mode !=3D ddtp_mode)
>                 dev_dbg(dev, "DDTP hw mode %u, requested %u\n", mode, ddt=
p_mode);
>
> +       /* Invalidate device context cache */
> +       riscv_iommu_cmd_iodir_inval_ddt(&cmd);
> +       riscv_iommu_cmd_send(iommu, &cmd, 0);
> +
> +       /* Invalidate address translation cache */
> +       riscv_iommu_cmd_inval_vma(&cmd);
> +       riscv_iommu_cmd_send(iommu, &cmd, 0);
> +
> +       /* IOFENCE.C */
> +       riscv_iommu_cmd_iofence(&cmd);
> +       riscv_iommu_cmd_send(iommu, &cmd, RISCV_IOMMU_IOTINVAL_TIMEOUT);
> +
>         return 0;
>  }
>
> @@ -492,6 +938,26 @@ static int riscv_iommu_init_check(struct riscv_iommu=
_device *iommu)
>                         return -EINVAL;
>         }
>
> +       /*
> +        * Distribute interrupt vectors, always use first vector for CIV.
> +        * At least one interrupt is required. Read back and verify.
> +        */
> +       if (!iommu->irqs_count)
> +               return -EINVAL;
> +
> +       iommu->ivec =3D 0;
> +       iommu->ivec |=3D FIELD_PREP(RISCV_IOMMU_IVEC_FIV, 1 % iommu->irqs=
_count);
> +       iommu->ivec |=3D FIELD_PREP(RISCV_IOMMU_IVEC_PIV, 2 % iommu->irqs=
_count);
> +       iommu->ivec |=3D FIELD_PREP(RISCV_IOMMU_IVEC_PMIV, 3 % iommu->irq=
s_count);
> +       riscv_iommu_writeq(iommu, RISCV_IOMMU_REG_IVEC, iommu->ivec);
> +
> +       iommu->ivec =3D riscv_iommu_readq(iommu, RISCV_IOMMU_REG_IVEC);
> +       if (riscv_iommu_queue_vec(iommu, RISCV_IOMMU_IVEC_CIV) >=3D RISCV=
_IOMMU_INTR_COUNT ||
> +           riscv_iommu_queue_vec(iommu, RISCV_IOMMU_IVEC_FIV) >=3D RISCV=
_IOMMU_INTR_COUNT ||
> +           riscv_iommu_queue_vec(iommu, RISCV_IOMMU_IVEC_PIV) >=3D RISCV=
_IOMMU_INTR_COUNT ||
> +           riscv_iommu_queue_vec(iommu, RISCV_IOMMU_IVEC_PMIV) >=3D RISC=
V_IOMMU_INTR_COUNT)
> +               return -EINVAL;
> +
>         return 0;
>  }
>
> @@ -500,12 +966,17 @@ void riscv_iommu_remove(struct riscv_iommu_device *=
iommu)
>         iommu_device_unregister(&iommu->iommu);
>         iommu_device_sysfs_remove(&iommu->iommu);
>         riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_MODE_OFF);
> +       riscv_iommu_queue_disable(&iommu->cmdq);
> +       riscv_iommu_queue_disable(&iommu->fltq);
>  }
>
>  int riscv_iommu_init(struct riscv_iommu_device *iommu)
>  {
>         int rc;
>
> +       RISCV_IOMMU_QUEUE_INIT(&iommu->cmdq, CQ);
> +       RISCV_IOMMU_QUEUE_INIT(&iommu->fltq, FQ);
> +
>         rc =3D riscv_iommu_init_check(iommu);
>         if (rc)
>                 return dev_err_probe(iommu->dev, rc, "unexpected device s=
tate\n");
> @@ -514,10 +985,28 @@ int riscv_iommu_init(struct riscv_iommu_device *iom=
mu)
>         if (rc)
>                 return rc;
>
> -       rc =3D riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_MODE_MA=
X);
> +       rc =3D riscv_iommu_queue_alloc(iommu, &iommu->cmdq,
> +                                    sizeof(struct riscv_iommu_command));
> +       if (rc)
> +               return rc;
> +
> +       rc =3D riscv_iommu_queue_alloc(iommu, &iommu->fltq,
> +                                    sizeof(struct riscv_iommu_fq_record)=
);
> +       if (rc)
> +               return rc;
> +
> +       rc =3D riscv_iommu_queue_enable(iommu, &iommu->cmdq, riscv_iommu_=
cmdq_process);
>         if (rc)
>                 return rc;
>
> +       rc =3D riscv_iommu_queue_enable(iommu, &iommu->fltq, riscv_iommu_=
fltq_process);
> +       if (rc)
> +               goto err_queue_disable;
> +
> +       rc =3D riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_MODE_MA=
X);
> +       if (rc)
> +               goto err_queue_disable;
> +
>         rc =3D iommu_device_sysfs_add(&iommu->iommu, NULL, NULL, "riscv-i=
ommu@%s",
>                                     dev_name(iommu->dev));
>         if (rc) {
> @@ -537,5 +1026,8 @@ int riscv_iommu_init(struct riscv_iommu_device *iomm=
u)
>         iommu_device_sysfs_remove(&iommu->iommu);
>  err_iodir_off:
>         riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_MODE_OFF);
> +err_queue_disable:
> +       riscv_iommu_queue_disable(&iommu->fltq);
> +       riscv_iommu_queue_disable(&iommu->cmdq);
>         return rc;
>  }
> diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
> index f1696926582c..03e0c45bc7e1 100644
> --- a/drivers/iommu/riscv/iommu.h
> +++ b/drivers/iommu/riscv/iommu.h
> @@ -17,6 +17,22 @@
>
>  #include "iommu-bits.h"
>
> +struct riscv_iommu_device;
> +
> +struct riscv_iommu_queue {
> +       atomic_t prod;                          /* unbounded producer all=
ocation index */
> +       atomic_t head;                          /* unbounded shadow ring =
buffer consumer index */
> +       atomic_t tail;                          /* unbounded shadow ring =
buffer producer index */
> +       unsigned int mask;                      /* index mask, queue leng=
th - 1 */
> +       unsigned int irq;                       /* allocated interrupt nu=
mber */
> +       struct riscv_iommu_device *iommu;       /* iommu device handling =
the queue when active */
> +       void *base;                             /* ring buffer kernel poi=
nter */
> +       dma_addr_t phys;                        /* ring buffer physical a=
ddress */
> +       u16 qbr;                                /* base register offset, =
head and tail reference */
> +       u16 qcr;                                /* control and status reg=
ister offset */
> +       u8 qid;                                 /* queue identifier, same=
 as RISCV_IOMMU_INTR_XX */
> +};
> +
>  struct riscv_iommu_device {
>         /* iommu core interface */
>         struct iommu_device iommu;
> @@ -34,6 +50,11 @@ struct riscv_iommu_device {
>         /* available interrupt numbers, MSI or WSI */
>         unsigned int irqs[RISCV_IOMMU_INTR_COUNT];
>         unsigned int irqs_count;
> +       unsigned int ivec;
> +
> +       /* hardware queues */
> +       struct riscv_iommu_queue cmdq;
> +       struct riscv_iommu_queue fltq;
>
>         /* device directory */
>         unsigned int ddt_mode;
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
