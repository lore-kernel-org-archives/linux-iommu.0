Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27798245012
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 01:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782698376; cv=pass; b=aiCQyQdvP5crAHQRLz2eLQXStkghUcHnt2Rp5l3Xlq0zlT7V4IABvZcbGYxB6orSrnsCS4otPnt3KcQdc8SmGXk6lsStYnrkc7xJvmCEnWwYG5lABbeJCttr8j1YjWYyOD89PL9bl9rh7T4UYeMuG/Vo93Enszd+Zs6o8q8FNKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782698376; c=relaxed/simple;
	bh=ci4xs6o79f5ubeHnEPZAtey0amYwWXwdlCPisz3L1SM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c0+hwARLDa6gAxVeL9GU3LvIVSTYNL4bVpLuy60T0bvkKpbOJu7akSHot5Rm2Mowdh6XirdriTohBdWgs1P6c5HC4TO68Vxa+CC7MuWADZes4UXLPguIAEM8L2LhI0oa6o0dx3Q14PODtiti7NwyRzqizeeibzWNRuILwQ9WUe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=FRFYK54P; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FRFYK54P"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-80e24970f1dso6612027b3.0
        for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 18:59:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782698374; cv=none;
        d=google.com; s=arc-20260327;
        b=qlO3qDYvNPNAzAR/Gqkmstnd33Onqbh2A3PddYRbIP4dhfqBdIlMMdiHjjsUWy3knx
         lLVT38WYB0LgxcblwTQ0zFkXp5K3HjVuSBz4YwEjwctJVvMgVaIm2LkuOm25p+EpB9hc
         7OKS57gaVr7/q9Lu28kr29dB2EVTm95ktknCqAYYZTk8XZsoZkmCxIZ4QB3kd4D/bfrK
         JCILQmPFyUW0S5jxJISWEU9c0MccHtThN+0UlajWLpiXFqbFt7UzI2cCC7DnmN2aCQGM
         NlTpzkmAcTW3Ubi3KCfK0eYQEPkE3Ag8+5nFDaDXl7rs7PjJROC0Cb7fUY0JMUh3wsnW
         J1EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PrKMfGvBB+n2SPK2Ky9jgrmaZHuvUlCc5IRFb6yy7lY=;
        fh=YhEpygcqt+02E/V9ada2Qcs4EzH9+X8krf1NfIhqeSo=;
        b=E5FE8kX2SogYbeVMSwqUA45AtQiapUziAIda3iWrpMzkjooCeHcgvJp6oDV5g8E0mh
         jBQP43vY7IXYCWpg/2jBhvQph4IXrGmXmXGFxeoxb2Sbk0o2bqzUIs0HSRxRtvHeROh4
         vH208lO/yFI8pzulu5+MdKp+X8yK21w6t4cfmDNxoZdygAeI7eEWVkqoSzLndNhDCa4A
         mwyNy+RHIxlYInes3TEMegOyGGTXVloWmjoiUqdZ75dB4NEa1hJbXjobpJQ55aVMTbWV
         MSDeYg/3iQ7JsuJSyhSGjwqiWhSEu1zdRbz1h1ZiUsVzfzILSTROAeRlB9w7jQKH/v+9
         E1HA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1782698374; x=1783303174; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PrKMfGvBB+n2SPK2Ky9jgrmaZHuvUlCc5IRFb6yy7lY=;
        b=FRFYK54P9e9LLb3NtDzcFTJ1lyZJQiDLjpl+luu45AV4dvUt0SCBqqhZdcg2N8Zwon
         jjDeockvr2xOLDhy+NuGjISVwgcN3k1C/EgoTkv/YTcCnU2jP8uJ/ZBIb6Wl4ZsGWMqd
         PSaORxiAWhk+w0n3uaEceu+rHYqEwZCw8CMAUoZiTdR+r/t1ndXa7q9wSAl981LuDoBa
         GXLJ1MJEXr+qhxp0i/WmOpP8xbjqZBUOm4htPAHDEjEVYwTjfXU8uENdD1aGjJUAJTM8
         NxaQEk6f1Vn9/TE/qytUa3oa/0bQ2co1cZ3vAu0TyU2eSensmdJgSU9a1zWdjmuIOxfQ
         EGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782698374; x=1783303174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PrKMfGvBB+n2SPK2Ky9jgrmaZHuvUlCc5IRFb6yy7lY=;
        b=jxgg8uFDLOqdaSpGwJ1/D76U7gNo3CDrEQDho/LdbKXXU8rSwxdP6y2n/elo1m2CuN
         4gmZwpCjgiM6alIJMfk+oJsZULirxPO7Gh9YUJfWRBEMjZygCIWDzqj570Ff8EPA0N9U
         vUcX3OkKn46i+h/hNj1Jl0cWRjQWLpHokivWamUH8bUjw2wXQJThulOWtYotv5L4zAmR
         Rvt9CRF+he10QRP+yIaAufTdb63qvU4uUwc+tnp2GZhIvAhT3HNZ/e8T/AIT5cWf4kG7
         faY9C/+2mxlRsMEB8n3zGY9DD6bs5foU4gmECT+SQSNL74QvI8iKOkZ17Vz2aAxLYcWn
         vT4Q==
X-Forwarded-Encrypted: i=1; AHgh+RpuqVldeeXZm+etAh7AqSBfBKXy4SAma7WbSa/lC92Bx0DXXywXsy/W6DcqN3iFVvODqrYCxw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw20AH5i9J4mEeR8U9I85txtr1/bzkYHbIBfSGI7qB3Llkzhceo
	F9cIk0YoIe5T6P2Pc6PyWEIP+F0YygFM89OWASwta8kt+lSTtP51V/QmRvjS6BwdjQPLJJ1hcfx
	mNIj1ItIA2tAX1Bho8INMHOFvNtrfrhrtPCEudp4s3g==
X-Gm-Gg: AfdE7clLOtEaU47+eiVJMD4bRe4UxF81G7WZjcQ32Ra3ubd3mRv+BAn96VOan9DCehI
	036iPfM4wNxqLoJN15s/83NpkXpvraBC0KhnbHLU5xtb+xhQrzf9cbq3qgDHrg+9POyfVGnH8sX
	7v0bXuRP03qnAnzq01z5e88YZNflDDI8NMPKqGf6qubFjeqsStrCRVIc+3nsDGJOUvRj4bN5RgL
	Et9x8jHb+Or6qFEC4jMF/yKhYE2/SBYm6RPJuHD1cpE6jHds1gwprsMDO6Z/oF+t7RQPZ8wcfg=
X-Received: by 2002:a05:690c:7208:b0:80c:85e5:8743 with SMTP id
 00721157ae682-80c85e58a99mr97225767b3.65.1782698374189; Sun, 28 Jun 2026
 18:59:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CANXhq0pw5TPSD+p3YnTyEHQTSB-3jmAp3bzRSXvHdVjvevfL7w@mail.gmail.com>
 <20260626135002.65703-1-fangyu.yu@linux.alibaba.com>
In-Reply-To: <20260626135002.65703-1-fangyu.yu@linux.alibaba.com>
From: Zong Li <zong.li@sifive.com>
Date: Mon, 29 Jun 2026 09:59:22 +0800
X-Gm-Features: AVVi8Cfs6OnM1zYw0BdE3kdeo1BeI9b7DrH8QUKjlQ1z_hZeH2r2MUO5dRtSSZs
Message-ID: <CANXhq0ozFOeUciPCmCwxJMw4SVwfHRGaz9+0DsOr98mixmjdew@mail.gmail.com>
Subject: Re: [PATCH] iommu/riscv: Replace illegal command with dummy IOFENCE
 to prevent hardware lockup
To: fangyu.yu@linux.alibaba.com
Cc: alex@ghiti.fr, aou@eecs.berkeley.edu, iommu@lists.linux.dev, 
	joro@8bytes.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, palmer@dabbelt.com, pjw@kernel.org, 
	robin.murphy@arm.com, tomasz.jeznach@linux.dev, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 9:50=E2=80=AFPM <fangyu.yu@linux.alibaba.com> wrote=
:
>
> >On Wed, Jun 24, 2026 at 10:08=E2=80=AFPM <fangyu.yu@linux.alibaba.com> w=
rote:
> >>
> >> >When the RISC-V IOMMU encounters an illegal command, the hardware
> >> >stops processing and the HEAD register remains pointing at the
> >> >illegal command. If software does not handle this properly, the
> >> >hardware will be stuck at this index indefinitely, preventing any
> >> >further command queue operations.
> >> >
> >> >This patch implements a recovery mechanism by replacing the illegal
> >> >command with a dummy IOFENCE instruction (all operands are zero):
> >> >
> >> >1. Prevents hardware lockup: By overwriting the illegal command with
> >> >   a valid instruction, the hardware can continue processing from the
> >> >   current position instead of being stuck.
> >> >
> >> >2. Enables user recovery: After replacing the illegal command, the
> >> >   user/driver has an opportunity to retry the original failed
> >> >   operation rather than losing all queued work.
> >> >
> >> >3. Minimal hardware impact: A dummy IOFENCE behaves as a NOP, it
> >> >   it performs no cache invalidation operations and has no side
> >> >   effects on the system state. This is the safest replacement
> >> >   instruction.
> >> >
> >> >Signed-off-by: Zong Li <zong.li@sifive.com>
> >> >---
> >> > drivers/iommu/riscv/iommu.c | 24 +++++++++++++++++++++++-
> >> > 1 file changed, 23 insertions(+), 1 deletion(-)
> >> >
> >> >diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.=
c
> >> >index cec3ddd7ab10..6305ec5f467b 100644
> >> >--- a/drivers/iommu/riscv/iommu.c
> >> >+++ b/drivers/iommu/riscv/iommu.c
> >> >@@ -464,13 +464,35 @@ static unsigned int riscv_iommu_queue_send(stru=
ct riscv_iommu_queue *queue,
> >> > static irqreturn_t riscv_iommu_cmdq_process(int irq, void *data)
> >> > {
> >> >       const struct riscv_iommu_queue *queue =3D (struct riscv_iommu_=
queue *)data;
> >> >-      unsigned int ctrl;
> >> >+      struct riscv_iommu_command cmd;
> >> >+      unsigned int ctrl, head;
> >> >
> >> >       /* Clear MF/CQ errors, complete error recovery to be implement=
ed. */
> >> >       ctrl =3D riscv_iommu_readl(queue->iommu, queue->qcr);
> >> >       if (ctrl & (RISCV_IOMMU_CQCSR_CQMF | RISCV_IOMMU_CQCSR_CMD_TO =
|
> >> >                   RISCV_IOMMU_CQCSR_CMD_ILL | RISCV_IOMMU_CQCSR_FENC=
E_W_IP)) {
> >> >+              /*
> >> >+               * The head pointer is not updated by the hardware, it
> >> >+               * still points to the index of illegal command
> >> >+               */
> >> >+              riscv_iommu_readl_timeout(queue->iommu, Q_HEAD(queue),=
 head,
> >> >+                                        !(head & ~queue->mask), 0,
> >> >+                                        RISCV_IOMMU_QUEUE_TIMEOUT);
> >> >+
> >> >+              if (ctrl & RISCV_IOMMU_CQCSR_CMD_ILL) {
> >> >+                      /*
> >> >+                       * Use a dummy IOFENCE instead of the illegal =
command
> >> >+                       * to prevent hardware lockup
> >> >+                       */
> >>
> >> The RISC-V IOMMU spec 1.0 (Section 5.15, cqcsr) states:
> >>
> >>   "If software makes the CQ operational again after a cmd_ill or
> >>    cqmf error, then software should resubmit the commands submitted
> >>    since the last IOFENCE.C that successfully completed."
> >>
> >> So it seems that simply replacing the illegal command and letting the
> >> queue continue is not sufficient.
> >>
> >
> >Yes, this patch doesn't completly follow what the spec mentioned.
> >Initially, I wanted to implement the method suggested by the spec.
> >However, there are some synchronization challenges based on current
> >driver implementation. Therefore, I chose an approach similar to other
> >IOMMU drivers (like SMMU and Intel VT-d). The main goal is to at least
> >prevent the hardware from getting stuck and crashing the entire
> >system.
>
> Thanks for the detailed explanation. I understand the practical
> challenges you described. However, I=E2=80=99d like to note that the ARM
> SMMUv3 and Intel VT-d specs appear to provide somewhat different
> guarantees from the RISC-V IOMMU spec with regard to error recovery.
>
> ARM SMMUv3 (IHI 0070, Section 7.1):
>   "Older commands are unaffected by a later Command queue error."
>
> Intel VT-d (Section 6.5.2.10):
>   "Any invalidation commands ahead of the invalid descriptor that
>    are already fetched and pending in hardware at the time of
>    detecting the invalid descriptor error are completed by
>    hardware as normal."
>

Thanks for your elaboration, it is important for discussion here.
Although SMMU and Intel VT-d can protect the commands sent before an
illegal one, the original task of the illegal command is still lost.
This might still lead to unexpected hardware behavior

> >
> >Here are the main issues we would need to solve if we fully follow the s=
pec:
> >
> >1. IOFENCE index shift: After an illegal command, if another thread is
> >waiting for subsequent IOFENCE to finish, re-submitting commands will
> >change that IOFENCE's index in the queue. This means the waiting
> >thread in 'riscv_iommu_cmd_sync' might finish too early because the
> >'prod' value should be changed as well. We could fix this by making
> >IOFENCE write a sequence number to a specific address, and having the
> >thread wait for that data instead.
> >
> >2. Timeout errors: If an illegal command happens while another thread
> >is trying to write a command, that thread might be waiting for the
> >tail to move (in 'riscv_iommu_queue_send'), and exit the wait due to a
> >timeout. This leads to errors in the caller subsystem (like DMA). So
> >it seems even if the resubmit finishes later, it might not help much.
> >
> >3. Queue tail mismatch: Similar to point 2 situation, a thread waiting
> >in 'riscv_iommu_queue_send' expects prod =3D=3D queue->tail. If we
> >re-submit commands quickly, queue->tail is updated asynchronously to a
> >farther value. The waiting thread might never see the condition met
> >and time out.
> >
> >4. Shadow queue overhead: Inside the threading IRQ handler, we cannot
> >easily know what the illegal command was just by checking the current
> >command queue. We would need to create a "shadow command queue" to
> >keep a history. This would break the current driver design. We would
> >also need to add locks to prevent race conditions on shadow command
> >queue, which would reduce the driver's performance.
> >
> >Considering these trade-offs, I prefer not to make the driver much
> >more complex and slower just to handle rare hardware errors.
> >Personally, I lean towards treating this hardware fault as a fatal
> >error without trying to recover it in software. However, I understand
> >this might be too extreme and would require a hardware reset.
> >Therefore, this patch might be a good middle ground. It prevents the
> >hardware lockup. Even though we might lose some commands and cause
> >incorrect results for the user, it at least keeps the system alive and
> >gives the user a chance to retry their operation again.
> >
>
> I understand the trade-off. Given the complexity of full spec
> compliance, this simplified version may not actually address the
> underlying issue very well, so I=E2=80=99d suggest making its limitations
> explicit. Specifically, could you document in the commit message or
> code comments which scenarios it can handle and which ones may
> still remain problematic?
>

Ok, I will add more details to the code comments and the commit
message. As we discussed, this method is a trade-off and doesn't
completely fix the problem. Whether to accept this patch might still
depend on the maintainer's decision. Thank you very much for your
review and the helpful discussion

> >
> >> Thanks,
> >> Fangyu
> >>
> >> >+                      memset(&cmd, 0, sizeof(cmd));
> >> >+                      cmd.dword0 =3D FIELD_PREP(RISCV_IOMMU_CMD0_OPC=
ODE,
> >> >+                                              RISCV_IOMMU_CMD_IOFENC=
E_OPCODE);
> >> >+                      memcpy(queue->base + head * sizeof(cmd), &cmd,=
 sizeof(cmd));
> >> >+                      dma_wmb();
> >> >+              }
> >> >+
> >> >               riscv_iommu_writel(queue->iommu, queue->qcr, ctrl);
> >> >+
> >> >               dev_warn(queue->iommu->dev,
> >> >                        "Queue #%u error; fault:%d timeout:%d illegal=
:%d fence_w_ip:%d\n",
> >> >                        queue->qid,
> >> >--
> >> >2.43.7
