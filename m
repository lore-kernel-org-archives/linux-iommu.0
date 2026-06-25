Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723726BB5B
	for <iommu@lists.linux.dev>; Thu, 25 Jun 2026 07:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782371587; cv=pass; b=BUqQ1BrraIpS06/2hG0oBwip6m+Hs8IathowxS+FTGhAwwXl28lHn6GEdnopN+bvdHTMtqo6Nj/SeC3ac1SvPwX8PEC2o18a0rqhDeTGCOi6RfZPyWtN7eGlpC/tDC+MK1EmPDVQ7WjItommqfCRt6OBR5egOhnG/tb+pHvZv9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782371587; c=relaxed/simple;
	bh=aI+K+vq4A8JQBJUN69olwZI+HJKLJNQ5rLECjdZJoQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WFF9Juhy/a5e7uqw4MQW9HZNrdJUJGzmjoWWwbYNI9WCcB8Hy5se3uWKWCGV21i0APHEw/iQdNPfZv+0eiYNhmO96ty51+G87tl5/4tvKubC9qW1FatyBqFezTZ6VC+1cc4QTwTSoAwK5A04TCrnnVYJ6I+olWsbwMLe0yT3gQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Le3anXXB; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Le3anXXB"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-befee9e5ef7so290332466b.0
        for <iommu@lists.linux.dev>; Thu, 25 Jun 2026 00:13:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782371583; cv=none;
        d=google.com; s=arc-20260327;
        b=GpUOGRKDBsq1SuVsyYHVzGAtfd9Yq4YurswY0ThHiPump/FrrKSQ7p5bHK/CH47LXR
         V9zR73Ky/YBLRtEF5HrvemxeXVcdF8dOe7SzISJcuenmCOUN93ovb5G5PwTl6D/APFbw
         WCa47yW4ziahL1A8R8Q9an2u63qdgtt+xTCjv2N1iNW3yOaMgwyLAxpYyjslNwK0o4hf
         sKEyHfrY6B9NqxRLzu7ZCJeP43v6moiPTBxKnd/kLWk2SuaZL4Gaq6qRvBEzwsb71o3O
         +ZSqLxySdXLyzg9tShQ4LGatsqz4MwwJGILT0s1CiMzDtZZk+43g56lbd/3yv7HqHqMK
         tiTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lD+bsFDN/w3G1ptzVJtRCyjro+q4S2V6FARevsGcXdc=;
        fh=VDXaPECa9QghTkbtaEgnDTU7n41EgqRJNrMOr+1/gog=;
        b=UX3wf3M+Q3NDI1yOF5BhlSX8l0K4j4doUXRRPMEFSR+7Rlt8Iu68hGwNecTxI29tH1
         FJPbkE7T2Cv0pfJlSIIvhzSX7C3wZsIQgrNrfIDfDIs1SP7zH8UeSXl23/gdMvYBO1JM
         qONaMfYU6FP8BQy2MYUbawYYsDX8UmHM85x4ltlGB5I69pTSTb73sg0s2Ez9evBN54au
         DHtTtk5hmI/oyOLWbfVuDhSTSl/V/ez49TEgsFkSD+p1LGdzSMKoxsFMlrc5htyqTZbW
         r/6ErtwcEy2+L5TNA94U6gd1Xw40qJkFSP1CyNH8N2Xi9SSvkZJ2O11PiteE9o/F0WKh
         pByQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1782371583; x=1782976383; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lD+bsFDN/w3G1ptzVJtRCyjro+q4S2V6FARevsGcXdc=;
        b=Le3anXXB8JM6b3LDykvTmz0kDhMHn+apJ7FREb1tkA5KA7/pzSoFGHxC/eLW6P2snT
         eb+EfAUyrH4qlZ7UsdvmDZR42RgWlV86ZWBevfKRORPGxH7CVTbRotW5xw6WPDAhaRMN
         P1leNr7u5VexO7s0cww5heM1R+o4VNDusuiJaM+TLYGR8m9bRtrpGA584VxZx80SH1Jh
         dKjzSM6gDmWznpbhBCtvwhgR12u8Ezut++cubJ42YHtL0oLfM449HcuSiQUAUTqV3eMM
         QuLLQw+yoSVRdGTtKiDrA36KRq8Rs2cCm1d2H/wmuxQKr4naHsgOGYgStxgyWn/4oqx7
         iPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782371583; x=1782976383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lD+bsFDN/w3G1ptzVJtRCyjro+q4S2V6FARevsGcXdc=;
        b=jbGNScb9Z2fKRoBWL/9ss2JIa1VIFB1tqbuB9DVIS/PfhaeZ60UMsZAavygqvng9tU
         bGepMHyUWNg7GwJmQScduR+q5CqEwpWbKfpx+Z5mbrJgq1KdYdWPv9qW5r6pDiB96LUY
         T400IELyDqYWQrYV1ydLGXU5sZYZHL53zB6OD1T13H64P6eGZdmH1KqZz8rbx5iCDAVg
         JRKcZsGKNOgFEoVziEPXanxH7IYuTXw3H8qE/JrdIdPhutKWOr7IQ/aqZM8voF7ZCNmE
         X6GAqqLsGIxOcj1qDj/tpQ34WHGAWa12p3mjAycqFq59966Rck9WO/Pa999y3mv6yp8d
         fctw==
X-Forwarded-Encrypted: i=1; AHgh+Rq9jL3DBaJlxt1Uk9Q4OEpCdo/+3CZ/bQltNMetVW0sYopPQNljV4n4wMOOlc+Df86Kbwjr8Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwR0p9PZiQNlbJm82ea3JgZRJL3QAkk2pZSALWtlOtILogYgDaz
	E82idNPKk8JaZfCucfj2KKK5S3Oj/a3PX+/0/ihH69ghE/sfFSi2QH2su/MnVHde0X0TVCmbNs4
	m1iMAXM8/39ObgUSYYT/aFKn38D5m/UTC4Iwn0dS5Jw==
X-Gm-Gg: AfdE7clNULd4sQ+PRCPQWo/8QP92o/9H6iQOlOG6W0DBHAV/1ANZsNuvwD4D6Y6sUti
	H/ih1656ajQ67sJ4fyEL6+IRUx0Liwlc5Y+i+EEw5lXQ//HQChW4QFCGm+AtwwUOLV9HUQCgg2Y
	FCfiEW4MxKaJh3msWaFw/X8X+kV3W+d4twr++Ej8YjrEuRarcCT7wYjzzdbocGUYA2ffg1+ZggD
	UuxExYcf6jim9bFJ0+NLKOuISqy3ya1LJ90rPLFyPyzDAig5beTSZcN6XgN0CZpioofxfHwqgrf
	iHq31zBMow==
X-Received: by 2002:a17:906:eec1:b0:c0d:43b2:e8e7 with SMTP id
 a640c23a62f3a-c1205ee0e4bmr67586366b.35.1782371582786; Thu, 25 Jun 2026
 00:13:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260623081902.589810-1-zong.li@sifive.com> <20260624140752.31155-1-fangyu.yu@linux.alibaba.com>
In-Reply-To: <20260624140752.31155-1-fangyu.yu@linux.alibaba.com>
From: Zong Li <zong.li@sifive.com>
Date: Thu, 25 Jun 2026 15:12:50 +0800
X-Gm-Features: AVVi8CczPZyncIuLXLfmlO7dY8kTC6oJKg1-nkVpDJdk7V-MF_vWEokLL9oEOro
Message-ID: <CANXhq0pw5TPSD+p3YnTyEHQTSB-3jmAp3bzRSXvHdVjvevfL7w@mail.gmail.com>
Subject: Re: [PATCH] iommu/riscv: Replace illegal command with dummy IOFENCE
 to prevent hardware lockup
To: fangyu.yu@linux.alibaba.com
Cc: alex@ghiti.fr, aou@eecs.berkeley.edu, iommu@lists.linux.dev, 
	joro@8bytes.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, palmer@dabbelt.com, pjw@kernel.org, 
	robin.murphy@arm.com, tomasz.jeznach@linux.dev, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 10:08=E2=80=AFPM <fangyu.yu@linux.alibaba.com> wrot=
e:
>
> >When the RISC-V IOMMU encounters an illegal command, the hardware
> >stops processing and the HEAD register remains pointing at the
> >illegal command. If software does not handle this properly, the
> >hardware will be stuck at this index indefinitely, preventing any
> >further command queue operations.
> >
> >This patch implements a recovery mechanism by replacing the illegal
> >command with a dummy IOFENCE instruction (all operands are zero):
> >
> >1. Prevents hardware lockup: By overwriting the illegal command with
> >   a valid instruction, the hardware can continue processing from the
> >   current position instead of being stuck.
> >
> >2. Enables user recovery: After replacing the illegal command, the
> >   user/driver has an opportunity to retry the original failed
> >   operation rather than losing all queued work.
> >
> >3. Minimal hardware impact: A dummy IOFENCE behaves as a NOP, it
> >   it performs no cache invalidation operations and has no side
> >   effects on the system state. This is the safest replacement
> >   instruction.
> >
> >Signed-off-by: Zong Li <zong.li@sifive.com>
> >---
> > drivers/iommu/riscv/iommu.c | 24 +++++++++++++++++++++++-
> > 1 file changed, 23 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> >index cec3ddd7ab10..6305ec5f467b 100644
> >--- a/drivers/iommu/riscv/iommu.c
> >+++ b/drivers/iommu/riscv/iommu.c
> >@@ -464,13 +464,35 @@ static unsigned int riscv_iommu_queue_send(struct =
riscv_iommu_queue *queue,
> > static irqreturn_t riscv_iommu_cmdq_process(int irq, void *data)
> > {
> >       const struct riscv_iommu_queue *queue =3D (struct riscv_iommu_que=
ue *)data;
> >-      unsigned int ctrl;
> >+      struct riscv_iommu_command cmd;
> >+      unsigned int ctrl, head;
> >
> >       /* Clear MF/CQ errors, complete error recovery to be implemented.=
 */
> >       ctrl =3D riscv_iommu_readl(queue->iommu, queue->qcr);
> >       if (ctrl & (RISCV_IOMMU_CQCSR_CQMF | RISCV_IOMMU_CQCSR_CMD_TO |
> >                   RISCV_IOMMU_CQCSR_CMD_ILL | RISCV_IOMMU_CQCSR_FENCE_W=
_IP)) {
> >+              /*
> >+               * The head pointer is not updated by the hardware, it
> >+               * still points to the index of illegal command
> >+               */
> >+              riscv_iommu_readl_timeout(queue->iommu, Q_HEAD(queue), he=
ad,
> >+                                        !(head & ~queue->mask), 0,
> >+                                        RISCV_IOMMU_QUEUE_TIMEOUT);
> >+
> >+              if (ctrl & RISCV_IOMMU_CQCSR_CMD_ILL) {
> >+                      /*
> >+                       * Use a dummy IOFENCE instead of the illegal com=
mand
> >+                       * to prevent hardware lockup
> >+                       */
>
> The RISC-V IOMMU spec 1.0 (Section 5.15, cqcsr) states:
>
>   "If software makes the CQ operational again after a cmd_ill or
>    cqmf error, then software should resubmit the commands submitted
>    since the last IOFENCE.C that successfully completed."
>
> So it seems that simply replacing the illegal command and letting the
> queue continue is not sufficient.
>

Yes, this patch doesn't completly follow what the spec mentioned.
Initially, I wanted to implement the method suggested by the spec.
However, there are some synchronization challenges based on current
driver implementation. Therefore, I chose an approach similar to other
IOMMU drivers (like SMMU and Intel VT-d). The main goal is to at least
prevent the hardware from getting stuck and crashing the entire
system.

Here are the main issues we would need to solve if we fully follow the spec=
:

1. IOFENCE index shift: After an illegal command, if another thread is
waiting for subsequent IOFENCE to finish, re-submitting commands will
change that IOFENCE's index in the queue. This means the waiting
thread in 'riscv_iommu_cmd_sync' might finish too early because the
'prod' value should be changed as well. We could fix this by making
IOFENCE write a sequence number to a specific address, and having the
thread wait for that data instead.

2. Timeout errors: If an illegal command happens while another thread
is trying to write a command, that thread might be waiting for the
tail to move (in 'riscv_iommu_queue_send'), and exit the wait due to a
timeout. This leads to errors in the caller subsystem (like DMA). So
it seems even if the resubmit finishes later, it might not help much.

3. Queue tail mismatch: Similar to point 2 situation, a thread waiting
in 'riscv_iommu_queue_send' expects prod =3D=3D queue->tail. If we
re-submit commands quickly, queue->tail is updated asynchronously to a
farther value. The waiting thread might never see the condition met
and time out.

4. Shadow queue overhead: Inside the threading IRQ handler, we cannot
easily know what the illegal command was just by checking the current
command queue. We would need to create a "shadow command queue" to
keep a history. This would break the current driver design. We would
also need to add locks to prevent race conditions on shadow command
queue, which would reduce the driver's performance.

Considering these trade-offs, I prefer not to make the driver much
more complex and slower just to handle rare hardware errors.
Personally, I lean towards treating this hardware fault as a fatal
error without trying to recover it in software. However, I understand
this might be too extreme and would require a hardware reset.
Therefore, this patch might be a good middle ground. It prevents the
hardware lockup. Even though we might lose some commands and cause
incorrect results for the user, it at least keeps the system alive and
gives the user a chance to retry their operation again.


> Thanks,
> Fangyu
>
> >+                      memset(&cmd, 0, sizeof(cmd));
> >+                      cmd.dword0 =3D FIELD_PREP(RISCV_IOMMU_CMD0_OPCODE=
,
> >+                                              RISCV_IOMMU_CMD_IOFENCE_O=
PCODE);
> >+                      memcpy(queue->base + head * sizeof(cmd), &cmd, si=
zeof(cmd));
> >+                      dma_wmb();
> >+              }
> >+
> >               riscv_iommu_writel(queue->iommu, queue->qcr, ctrl);
> >+
> >               dev_warn(queue->iommu->dev,
> >                        "Queue #%u error; fault:%d timeout:%d illegal:%d=
 fence_w_ip:%d\n",
> >                        queue->qid,
> >--
> >2.43.7
