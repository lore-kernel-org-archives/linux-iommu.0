Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D741F3F6C2A
	for <iommu@lists.linux.dev>; Thu, 23 Jul 2026 07:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784793039; cv=pass; b=cCXZudfUe29BMP50P7D/ex4xNgHEGFIpDcQt9fdiYdIzuoMfOmWu+SJr1PaIBkrvdSbeznUzTHK+Eggnj4NW+PHIDpuz8B8/9KKZ+CWbFnkq58chWyaH8pJEU5nivr4E7q/QzaGKpJ4EyArczLZVJCPzCqgmyKL5Y7PUSpLGRDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784793039; c=relaxed/simple;
	bh=6mzCw2SRODucVsRA/uemTkC0IDQToNI4yxBuFQz9PNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sRAmigylte9YvpkX+Za5NL2La/gtcG9BizLQ1k3qOocc3VUvtOgbHRWg8DSZBAkXqtYfsC5YwRYIpveYyTxdVoX63IikcuiWHH11M1tSOR34thjwedfXKyi4vt4ppTxs3/E/bma1u1dj+TcuKONX3AZjX7v/WougYyZAuNnEgzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=dzjgdPaD; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dzjgdPaD"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-698aa7ba320so414438a12.1
        for <iommu@lists.linux.dev>; Thu, 23 Jul 2026 00:50:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784793035; cv=none;
        d=google.com; s=arc-20260327;
        b=DkhPbzqvYfMnHnyP7e4XJZwCmrcMRNLTDyFyBgFSJ2jTRwbO27RvdoJYUHwutpaqXV
         KQxBbKGfLR9MQQy0r47ITOwqaZxdRt33QbJi8DRJL2qSED0hSEkDyAdmqqbvv7kYlk91
         T+/xMWAk0wRtyBCU1LLULZBO6oA/CgMXwD/SIRAwXO/wCI9jxTQBwCOx5Xjcs/gRu1yu
         TnB8tQjNau8Ahp4YH3RBiDfljH+6ESu07eyPBfYxPKl/P27iL3M8Ek/0KIQlVfDgVHI+
         tw10lD6fexrgaZHun7YLJqvmVyt8EcySACEOyETVGWHZLASKrTRIwNpzCI3dopUzwCBh
         9ttA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OQU7tHiWIG/hwSP5pM1ZCdJt6OQTXlTxKddLqTxHVsk=;
        fh=L2ouEz809mlRWEavno0DoTXoBuTb+Koo8TiegY4motE=;
        b=UYI62acUpQ+iuyz1sk9AxkBXk8IxOBiPE1xJ5xTCClVAXBtmSYQoJriwmoXh/tc8mi
         pje4NpvFaAHBBox4nVciYWMfma0C2mzajaqQgCVGbQAG3q7EoWD5bCf8zEUc1ETBIGPP
         f+VwXMRtKn3eozNaU4upT35Sk338Kt/OGBdaE8mAv2SeJYc8EGLnsDm39+zTj+T19Gnh
         qoR5jKlmFJMiKgGH7eVf8Q9k+Rg1UHZ3lo2VRv1GRxFEEWZsNlcPqdJTohZhKUgxqcUt
         4BXU6kGvVCp+dWdY2q9fJvKC+1eBWSDZUZmyoBTXzDVkhdmswj0YbrJPK8j74Kh1uPKK
         51oQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1784793035; x=1785397835; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OQU7tHiWIG/hwSP5pM1ZCdJt6OQTXlTxKddLqTxHVsk=;
        b=dzjgdPaDaihbfdy+b+4lBhkGTmB1d8o2xIjpqzoiuq6w6Hr3Gyo/nlYJuRHma29jBk
         puFlJqIwpcl5+Zjrf+PRKqd+4zfnNjlEqMITpK7m/Ykyf/KfVx8fMSk2VEmtVxdCROw4
         GsBmQMFemb6+hNO1gVjmTqNk9yId1E2IoH4P7yDhXax1+JY8rNAFPAQUW7NGqYPFL4G7
         od5CmNzjvJnoHt0MVKxPqnN3S9TWJDaX6VgKf82gst4QVdd+Cg+BP+vZeosF/o7FPRxB
         82r2aYsRcBhlhD/cTmK4BD7u0l6+6s6c8HvPW7HKQO7KflIWGRQmztKHmWuc8aEHWPGy
         PhMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784793035; x=1785397835;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OQU7tHiWIG/hwSP5pM1ZCdJt6OQTXlTxKddLqTxHVsk=;
        b=SNM1wxr10XfUUZTZ2Pul1F3soZDUbbpug/Xx/ONsbmbAhEQ286O1ycCMu2mUCs/YqW
         Xe8M7U8e+4t1HfxR03+Opc4XzHsUcJF9aPnq7cOC0rZwbcKizIJXsSI2LF3j+qgelbh/
         pvuH1Pl1kCgiRFMySGpQR5UHEdU2TI7qo5Fum5eGetyy7YzIYFbDS9Lxjhw5XpVm+/H0
         GbOY48U9dkMMC9WPXYpJEXvn2M8P4EJFntjFEsO3nw6addAICq2Xjios08hXgXTc0UDZ
         ZeVyCMNfGB+GCML/5NyOylT0Gw17WzOn9Xkk9ubq/mm53aoTElocNLX0WAW04KbPHOLu
         FAMQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq4339Umb5kOrHpep8f0x6oZ2w3wENOfRAz8P4w1FjwARfUmnWexoaWTmeKFUzWOQ9+Mi6RbQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTlFv4Ye5kZenOxghMHxc7GlmaH3D2f8ZdEHqUGbGBYkMnfieS
	3gnMNo6M7SWPcON1qQm/K6AH7KW40SVGX2RvFoJxBfb/kbeaxUtUFXisKYnRc3hkuJM3XjOv8bM
	bppcxqK2smx41wTP9FGFGVF5D+6r0rCyrpBHUSKYcYg==
X-Gm-Gg: AR+sD10UNdbMKf21Rxq1j0Y44PiD0AmHVwOd34GOX2sd49AJ1MPS8tgQbE42XXR6Qp6
	awVcHOzp1IH/qDOTKq6aWZHsCr4Boq+MdAX9RncYfVL4Bs9AwnFSnfa8SUkIjhC6c8EdiKYcgIs
	oRQ8VIR2vega1WyEM4VCqQy/vcSAvDKr53zsmhhrBmK6EstuCMiedb3qHuhEWKP4+uZUvsqCw01
	Pk15lINXdcyTmteoTp6OaTBWPWZONT5tPGHwT38lBlYGZSdI7uQFiAYsveEs0he
X-Received: by 2002:a05:6402:52d8:b0:698:86ce:8dc8 with SMTP id
 4fb4d7f45d1cf-69f7489d94emr543897a12.10.1784793034999; Thu, 23 Jul 2026
 00:50:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260630023042.837926-1-zong.li@sifive.com> <e2b13e82-f762-4fb0-83cb-d4bef57be427@linux.dev>
In-Reply-To: <e2b13e82-f762-4fb0-83cb-d4bef57be427@linux.dev>
From: Zong Li <zong.li@sifive.com>
Date: Thu, 23 Jul 2026 15:50:24 +0800
X-Gm-Features: AUfX_mxFZmusICHXCVp6ZDU9TkhSVPe-xkYvzhJLVb2IgZi-tVZ_1R3SfWYnipg
Message-ID: <CANXhq0r=g5Gh6wAkVUz3DCunZ2jRVOWbC=8qr3KbXY8oFcUauQ@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/riscv: Replace illegal command with dummy
 IOFENCE to prevent hardware lockup
To: Tomasz Jeznach <tomasz.jeznach@linux.dev>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 9:46=E2=80=AFPM Tomasz Jeznach <tomasz.jeznach@linu=
x.dev> wrote:
>
> Hi,
>
> On 6/29/26 7:30 PM, Zong Li wrote:
> > When the RISC-V IOMMU encounters an illegal command, the hardware
> > stops processing and the HEAD register remains pointing at the
> > illegal command. If software does not handle this properly, the
> > hardware will be stuck at this index indefinitely, preventing any
> > further command queue operations.
>
> The definition of proper handling was included in the spec. This patch
> simply implements logic to ignore real hardware errors and move forward,
> leaving the system in an unspecified state. The driver should not allow
> the system to pretend that everything is fine.
>
> > This patch implements a recovery mechanism by replacing the illegal
> > command with a dummy IOFENCE instruction (all operands are zero):
> >
> > 1. Prevents hardware lockup: By overwriting the illegal command with
> >     a valid instruction, the hardware can continue processing from the
> >     current position instead of being stuck.
> Currently, there is no clear way of communicating mapping
> synchronization failures in the IOMMU/DMA path. The only reasonable
> fault handler is either to panic or to make the fault visible to the
> user with a very long timeout. The timeout approach has been chosen in
> this driver; there are pros and cons to this, but let's not get into
> that discussion here.
>
> By overwriting an illegal command without any notification to the user,
> we are simply hiding e.g. TLB invalidation faults and likely causing
> use-after-free errors for DMA transfers. I would prefer not to go that wa=
y.
>
> > 2. Enables user recovery: After replacing the illegal command, the
> >     user/driver has an opportunity to retry the original failed
> >     operation rather than losing all queued work.
> Unfortunately user/driver has no way to know if any retry is required.
>
> > 3. Minimal hardware impact: A dummy IOFENCE behaves as a NOP, it
> >     it performs no cache invalidation operations and has no side
> >     effects on the system state. This is the safest replacement
> >     instruction.
> In the first place, an illegal command should not be enqueued into the
> command queue. If there is one, it's a driver/software bug or a hardware
> incompatibility with the specification. We should address this problem
> first. If a command has been interpreted as illegal, there might be
> other possible reasons for the fault - e.g., reading commands from an
> incorrect memory location or some other memory corruption related
> issues. Overwriting it with a "NOP" might not resolve this at all.
>
> I agree there is error handling needed for cmd_ill / timeout / fault
> errors, but so far the only reasonable way to handle those is to make
> the fault loud and annoying to the user (applications), with the IOMMU
> driver reporting errors via the kernel log.
>
> Is this patch trying to solve a real problem of a hardware faulting on
> illegal instructions, or is this a theoretical scenario with the
> implementation mimicking the SMMU implementation?
>
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >
> > The main goal is to at least prevent the hardware from getting stuck
> > and crashing the entire system.
> >
> > Here are the main issues we would need to solve if we fully follow the =
spec:
> >
> > 1. IOFENCE index shift: After an illegal command, if another thread is
> > waiting for subsequent IOFENCE to finish, resubmitting commands will
> > change that IOFENCE's index in the queue. This means the waiting
> > thread in 'riscv_iommu_cmd_sync' might finish too early because the
> > 'prod' value should be changed as well. We could fix this by making
> > IOFENCE write a sequence number to a specific address, and having the
> > thread wait for that data instead.
>
> Unfortunately, there is already a 'fix' added in the driver to exit the
> sync wait loop if a fault is reported on the command queue (line #381).
> There is a race with the fault interrupt handler that should be
> addressed and fixed.
>
> > 2. Timeout errors: If an illegal command happens while another thread
> > is trying to write a command, that thread might be waiting for the
> > tail to move (in 'riscv_iommu_queue_send'), and exit the wait due to a
> > timeout. This leads to errors in the caller subsystem (like DMA). So
> > it seems even if the resubmit finishes later, it might not help much.
> >
> > 3. Queue tail mismatch: Similar to point 2 situation, a thread waiting
> > in 'riscv_iommu_queue_send' expects prod =3D=3D queue->tail. If we
> > resubmit commands quickly, queue->tail is updated asynchronously to a
> > farther value. The waiting thread might never see the condition met
> > and time out.
> >
> > 4. Shadow queue overhead: Inside the threading IRQ handler, we cannot
> > easily know what the illegal command was just by checking the current
> > command queue. We would need to create a "shadow command queue" to
> > keep a history. This would break the current driver design. We would
> > also need to add locks to prevent race conditions on shadow command
> > queue, which would reduce the driver's performance.
> >
> > Considering these trade-offs, I prefer not to make the driver much
> > more complex and slower just to handle rare hardware errors.
> > Treating this hardware fault as a fatal error without trying to
> > recover it in software might be too extreme and would require a
> > hardware reset. Therefore, this patch might be a good middle ground.
>
> As an alternative trade-off, maybe consider reporting and storing the
> fault for the IOMMU instance and failing all subsequent page map
> requests. Instead of a long timeout, this would fail quickly, giving
> users a clear signal that the DMA subsystem using this IOMMU device is
> no longer usable.
>
> An alternative error-handling mechanism I've considered in the past was
> to shut down the command queue, quiesce all IOMMU interfaces (PRI/ATS),
> and completely reprogram the IOMMU from scratch (setting up the DDTP and
> re-enabling the command queue). As per the specification, restarting the
> command queue clears cmd_ill/timeout/fault errors. Once the IOMMU
> configuration is restarted, we can unblock any pending
> riscv_iommu_queue_wait() calls with a simpler sequence lock.
>
> > It prevents the hardware lockup. Even though we might lose some command=
s
> > and cause incorrect results for the user, it at least keeps the system
> > alive and gives the user a chance to retry their operation again.
> I think this patch only hides hardware errors, potentially masking
> not-so-rare real faults.
>

Hi Tomasz,
I totally agree with your prespective. This patch tries to recover the
IOMMU hardware from lockup, but it doesn't recover the command. It
might introduce potential errors. I would not continue with this patch
until we can solve it properly. Thanks

>
> Best,
> - Tomasz
>
> >
> > Changed in v1:
> > - Added more comments
> > - Rebased on v7.2-rc1
> >
> >   drivers/iommu/riscv/iommu.c | 32 +++++++++++++++++++++++++++++++-
> >   1 file changed, 31 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> > index cec3ddd7ab10..c009c1906e23 100644
> > --- a/drivers/iommu/riscv/iommu.c
> > +++ b/drivers/iommu/riscv/iommu.c
> > @@ -464,13 +464,43 @@ static unsigned int riscv_iommu_queue_send(struct=
 riscv_iommu_queue *queue,
> >   static irqreturn_t riscv_iommu_cmdq_process(int irq, void *data)
> >   {
> >       const struct riscv_iommu_queue *queue =3D (struct riscv_iommu_que=
ue *)data;
> > -     unsigned int ctrl;
> > +     struct riscv_iommu_command cmd;
> > +     unsigned int ctrl, head;
> >
> >       /* Clear MF/CQ errors, complete error recovery to be implemented.=
 */
> >       ctrl =3D riscv_iommu_readl(queue->iommu, queue->qcr);
> >       if (ctrl & (RISCV_IOMMU_CQCSR_CQMF | RISCV_IOMMU_CQCSR_CMD_TO |
> >                   RISCV_IOMMU_CQCSR_CMD_ILL | RISCV_IOMMU_CQCSR_FENCE_W=
_IP)) {
> > +
> > +             /*
> > +              * Resubmitting all commands submitted since the last IOF=
ENCE that
> > +              * successfully completed will introduce various race con=
ditions.
> > +              * Use a dummy IOFENCE instead of the illegal command to =
prevent
> > +              * hardware lockup.
> > +              * Please note that some commands might be lost, includin=
g:
> > +              *  - The task from the illegal command itself
> > +              *  - The commands submitted between the last IOFENCE and=
 illegal one
> > +              * However, this gives the user or driver a chance to ret=
ry the
> > +              * failed operation without resetting the enitre system
> > +              */
> > +             if (ctrl & RISCV_IOMMU_CQCSR_CMD_ILL) {
> > +                     /*
> > +                      * The head pointer is not updated by the hardwar=
e, it
> > +                      * still points to the index of illegal command
> > +                      */
> > +                     riscv_iommu_readl_timeout(queue->iommu, Q_HEAD(qu=
eue), head,
> > +                                               !(head & ~queue->mask),=
 0,
> > +                                               RISCV_IOMMU_QUEUE_TIMEO=
UT);
> > +
> > +                     memset(&cmd, 0, sizeof(cmd));
> > +                     cmd.dword0 =3D FIELD_PREP(RISCV_IOMMU_CMD0_OPCODE=
,
> > +                                             RISCV_IOMMU_CMD_IOFENCE_O=
PCODE);
> > +                     memcpy(queue->base + head * sizeof(cmd), &cmd, si=
zeof(cmd));
> > +                     dma_wmb();
> > +             }
> > +
> >               riscv_iommu_writel(queue->iommu, queue->qcr, ctrl);
> > +
> >               dev_warn(queue->iommu->dev,
> >                        "Queue #%u error; fault:%d timeout:%d illegal:%d=
 fence_w_ip:%d\n",
> >                        queue->qid,
>
