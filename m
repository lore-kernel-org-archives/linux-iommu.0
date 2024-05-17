Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D0517BBB
	for <iommu@lists.linux.dev>; Fri, 17 May 2024 07:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715930350; cv=none; b=V1bAfkko93QeUROs6DukclOtoLwaLDUxwQNZQ0RU2GmgJr1w+D/LWVHMLIpIBJg6Fniv4mtzhLOGahw8GT2EPwpD7EoLD+vKBystl5izQQUeRWOUlKId8zVgCOzhmocE4nSyW7Xhcd3lyDljUlQ38jv4OZvBVgM2H5TTS3Ll+B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715930350; c=relaxed/simple;
	bh=chj1piHlXhOQbxBlIl7o75pR7FanUmvbM5SMA7m9tw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IU70S/omt2BwPw3XGxlGGp4V9bhldpS7tTRtAGJpciU47NCtlOrZLRkFn//7C50LoMWrJ6g7JkaD0YDKWElUH/H6MGsFoOQfU+VMPfIY6rknA+srCxOcSbR4QryHdSrzMIRJ9PsIspTsFKG2FbnuX8KzHHFZK3SVkBC3FWlhF18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=F+Ff/BBP; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="F+Ff/BBP"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-36c80f9c86bso1451705ab.0
        for <iommu@lists.linux.dev>; Fri, 17 May 2024 00:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715930347; x=1716535147; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kacRBuLvIWaMwio/5BoHLoNB5nan+q+qFSLyxWqShQ0=;
        b=F+Ff/BBPm8gakjo8p7/sDe0KFwwZrf4kX4mDeCFcvOnisljPK/ycyIcXsYfjmyE47J
         jAllvgRAqdfZxe2BWC+zcta4b0xal9zbiy/ftwSMd0e37aEsEc/k6uaZs+1VAuaKlF0A
         wppu+VgIMwszr/8sfu2i5rd1AJtqQLTSiUqHA72ZvZe9Cbstp27xur6QCUZh1kBH1DBX
         gRb7DWnqa5GhKciiWDNQwoN4Pg0JJD8ivVZX1gTSXD3gSmiFzlb90RNTbN1QAo1CQ2wY
         3t0ZrPZA1guI7eeVhp5BKTcRS39Q2YMl+QwWUUt4vm/PEZOnQB43U9tB6IrAh6VtbEAh
         TgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715930347; x=1716535147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kacRBuLvIWaMwio/5BoHLoNB5nan+q+qFSLyxWqShQ0=;
        b=ZweLGOdWncqwsWTsOLyGUmp+ug/q7vWDhclHW59Ko/onvsg5LahmSRpYpLAfuhv95Z
         JWbYvWPlxABmtqSu0PPvNldsrq5CzV3vacG+GVSSIQxTAJpRcY/RJhrIJgWfLfJ//fwH
         yeMpwVPMGymmttusvQ3dzrmbdynzCMUMS+JI55/D4NJs27e+PU+uSOL0x5OtEVUS3zvZ
         JtyPrFA/ecVxOAzWsfwBdYT0i7458LsWNtt+iRzPrjGEMwd6nVcF0P4cr34KUpPMJJtU
         sVHVq8iUM8xQE3+bkUOJksVNmJ0lfHiYobSVBDe4xUDIZ0v/gFVnz8Fr6RAyVz6KS0/n
         Qj6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVokca78uvx7BdYdZM9U8ddzgNhlIVr2lGU3DhxrRnJfq5HArEKdlEjqepO+CM75Rl4SwUT2BfQrAqJabv0B9EidJDrV8I=
X-Gm-Message-State: AOJu0YxnRGGQerFyNOpW1I0bgFW7dX+SwrVm4X/WQD/Um8B2HsGAamnS
	OHE3p+2lwNOpJ0zickj86cWIXBHrDbKzPgIEkC8jIm3Jfjl7z86QyICXR3ERznO8heCLaDsiZrR
	TshhMOcv9EWLNVZH2Way77HR3DSQiB3ulrSJHDA==
X-Google-Smtp-Source: AGHT+IFUx3sU25xAya1dlakBXuVVC6Y71L+G8bo1BEzrkPemMVEyQ5B+UMrQ8slVeRDikp5yUTCQWBYZyy6LjG8wFFs=
X-Received: by 2002:a05:6e02:1647:b0:36c:c5c:784d with SMTP id
 e9e14a558f8ab-36cc144b690mr333520595ab.13.1715930346786; Fri, 17 May 2024
 00:19:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1715708679.git.tjeznach@rivosinc.com> <911790205e688405a97b5f04e3f284945092c9a1.1715708679.git.tjeznach@rivosinc.com>
In-Reply-To: <911790205e688405a97b5f04e3f284945092c9a1.1715708679.git.tjeznach@rivosinc.com>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 17 May 2024 15:18:56 +0800
Message-ID: <CANXhq0qff3ShvkvVrTuYLWtj1g6_ABg=pCGJBgQY=1ce8i5dGw@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] iommu/riscv: Command and fault queue support
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

On Wed, May 15, 2024 at 2:17=E2=80=AFAM Tomasz Jeznach <tjeznach@rivosinc.c=
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
>  drivers/iommu/riscv/iommu.c      | 507 ++++++++++++++++++++++++++++++-
>  drivers/iommu/riscv/iommu.h      |  21 ++
>  3 files changed, 601 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iommu=
-bits.h
> index 48f795a0cd10..78b98b4546ba 100644
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
> index 9ca130505c96..8666ea0517ee 100644
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
>  #define phys_to_ppn(pa)  (((pa) >> 2) & (((1ULL << 44) - 1) << 10))
> @@ -89,6 +96,446 @@ static void riscv_iommu_free_pages(struct riscv_iommu=
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
> +       /* Reuse ICVEC.CIV mask for all interrupt vectors mapping. */
> +       return (iommu->icvec >> (n * 4)) & RISCV_IOMMU_ICVEC_CIV;
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
> +
> +/* Enqueue an entry and wait to be processed if timeout_us > 0
> + *
> + * Error handling for IOMMU hardware not responding in reasonable time
> + * will be added as separate patch series along with other RAS features.
> + * For now, only report hardware failure and continue.
> + */
> +static unsigned int riscv_iommu_queue_send(struct riscv_iommu_queue *que=
ue,
> +                                          void *entry, size_t entry_size=
)
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
> +       return prod;
> +
> +err_busy:
> +       local_irq_restore(flags);
> +       dev_err_once(queue->iommu->dev, "Hardware error: command enqueue =
failed\n");
> +
> +       return prod;
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
> +               dev_warn(queue->iommu->dev,
> +                        "Queue #%u error; fault:%d timeout:%d illegal:%d=
 fence_w_ip:%d\n",
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
> +                                struct riscv_iommu_command *cmd)
> +{
> +       riscv_iommu_queue_send(&iommu->cmdq, cmd, sizeof(*cmd));
> +}
> +
> +/* Send IOFENCE.C command and wait for all scheduled commands to complet=
e. */
> +static void riscv_iommu_cmd_sync(struct riscv_iommu_device *iommu,
> +                                unsigned int timeout_us)
> +{
> +       struct riscv_iommu_command cmd;
> +       unsigned int prod;
> +
> +       riscv_iommu_cmd_iofence(&cmd);
> +       prod =3D riscv_iommu_queue_send(&iommu->cmdq, &cmd, sizeof(cmd));
> +
> +       if (!timeout_us)
> +               return;
> +
> +       if (riscv_iommu_queue_wait(&iommu->cmdq, prod, timeout_us))
> +               dev_err_once(iommu->dev,
> +                            "Hardware error: command execution timeout\n=
");
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
> @@ -250,6 +697,7 @@ static int riscv_iommu_iodir_set_mode(struct riscv_io=
mmu_device *iommu,
>         struct device *dev =3D iommu->dev;
>         u64 ddtp, rq_ddtp;
>         unsigned int mode, rq_mode =3D ddtp_mode;
> +       struct riscv_iommu_command cmd;
>
>         ddtp =3D riscv_iommu_read_ddtp(iommu);
>         if (ddtp & RISCV_IOMMU_DDTP_BUSY)
> @@ -317,6 +765,17 @@ static int riscv_iommu_iodir_set_mode(struct riscv_i=
ommu_device *iommu,
>         if (mode !=3D ddtp_mode)
>                 dev_dbg(dev, "DDTP hw mode %u, requested %u\n", mode, ddt=
p_mode);
>
> +       /* Invalidate device context cache */
> +       riscv_iommu_cmd_iodir_inval_ddt(&cmd);
> +       riscv_iommu_cmd_send(iommu, &cmd);
> +
> +       /* Invalidate address translation cache */
> +       riscv_iommu_cmd_inval_vma(&cmd);
> +       riscv_iommu_cmd_send(iommu, &cmd);
> +
> +       /* IOFENCE.C */
> +       riscv_iommu_cmd_sync(iommu, RISCV_IOMMU_IOTINVAL_TIMEOUT);
> +
>         return 0;
>  }
>
> @@ -493,6 +952,24 @@ static int riscv_iommu_init_check(struct riscv_iommu=
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
> +       iommu->icvec =3D FIELD_PREP(RISCV_IOMMU_ICVEC_FIV, 1 % iommu->irq=
s_count) |
> +                      FIELD_PREP(RISCV_IOMMU_ICVEC_PIV, 2 % iommu->irqs_=
count) |
> +                      FIELD_PREP(RISCV_IOMMU_ICVEC_PMIV, 3 % iommu->irqs=
_count);
> +       riscv_iommu_writeq(iommu, RISCV_IOMMU_REG_ICVEC, iommu->icvec);
> +       iommu->icvec =3D riscv_iommu_readq(iommu, RISCV_IOMMU_REG_ICVEC);
> +       if (max(max(FIELD_GET(RISCV_IOMMU_ICVEC_CIV, iommu->icvec),
> +                   FIELD_GET(RISCV_IOMMU_ICVEC_FIV, iommu->icvec)),
> +               max(FIELD_GET(RISCV_IOMMU_ICVEC_PIV, iommu->icvec),
> +                   FIELD_GET(RISCV_IOMMU_ICVEC_PMIV, iommu->icvec))) >=
=3D iommu->irqs_count)
> +               return -EINVAL;
> +
>         return 0;
>  }
>
> @@ -501,12 +978,17 @@ void riscv_iommu_remove(struct riscv_iommu_device *=
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
> @@ -515,10 +997,28 @@ int riscv_iommu_init(struct riscv_iommu_device *iom=
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
> @@ -538,5 +1038,8 @@ int riscv_iommu_init(struct riscv_iommu_device *iomm=
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
> index f1696926582c..b1c4664542b4 100644
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
> +       unsigned int icvec;
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

Reviewed-by: Zong Li <zong.li@sifive.com>

Thanks

>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
