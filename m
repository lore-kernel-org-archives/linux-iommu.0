Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E2514F12F
	for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 07:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724053770; cv=none; b=J6XA/XQB0juZPwdqcC99baHNO0+d3e9864eedwq1eWcWXhunryaLXfTVmCZnseaEvXgWLMU4oUafKW2wEV4E4wU3lluMC3ctQICjV2bDJmkDiC1DvuG25082jVi/yBnh+S/uMaEswbrDPqhkJ1hbPaFWefAQtd5+lif8qtuOxwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724053770; c=relaxed/simple;
	bh=dBBrPIfbp6qwkjh5voowEDdDMFxyyxt5vSOUgIS7qlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrbK5VWrikArAB36O6lddVZlsdL2AlbFxuFVIyc9DwF/RbaobN91ZfUSQU93dO2PQ9B9Ew8yP8oDKY8W+QsWZYTTrkmPRGG+I3fOl2Jy7hV/6zDGv1OJNwMb/ZLW9xKV2D28KJkNyV63LwcW93tDSlYvPyc+dyH8egpshNgzhBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dIksL9AV; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dIksL9AV"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d3da054f7cso2154285a91.1
        for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 00:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724053768; x=1724658568; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUVuHKHVrcEtqoNkxteJqRlTWi2IdXz9WHlXJpbxXpI=;
        b=dIksL9AVDxJHb+dLneLXr3Z8KkBoGO6oqevIEQt+XXgo1vknYFRhjip66VetoFIxWT
         5PyVd7rbotthRi49IdnL6i54WND/jMO+gafKQGQ/jZPczJ4Lt+eloaXJ4Ytb1S0DoC+U
         TEZ7AMvqWmCFzV+uXZ8Cuw64ALJFdobo1kElLEBucxwphYTULu9+Lu8iMbrkoj8Hdf2A
         T78vU543BunhxBVO97dJoaLE5U7PUqk9h+G5lxiQFv8Ofezfu/CFJpRKdrSAXHa1onpS
         xlgMp84qE97mxzeI/JUWv0PEQqHK6o4ylTzWY0owA/W6+aEx9BXSaxa32Wv7nhcbr/+Z
         nakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724053768; x=1724658568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YUVuHKHVrcEtqoNkxteJqRlTWi2IdXz9WHlXJpbxXpI=;
        b=L4q9ZG9WtXXNAONZ0PRVopajRYxXLyL1fKkpa4g3AcYvJyg/EaQ0fYs3Tq2WHeKqtP
         58zgLV/W0oxSxdtvyNP13CjRttsqZUGD4EduNHBCKbJzbmRTDydCTHg1lmz+A8YxMBTi
         2Z8V/t6WxLPs++e3YjB6lNQGO6JKV/d48r0mngjTUOWTW++CFNnVL1OIegM8J9w8VnkZ
         IGqOF5mo/xM9QUPi3lYcD22dhxv/8aopJA7+L5cpLncX5kFTQNFh10obkNeMe9/6FqB/
         GLfeIAcC0zmfoRe3lZxkRdIyyA2a6bwiLw8d0Ojb5ODp6JXEJPL7oUnT3IjHhxJJSMwG
         NnOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYBPFg0z6KJSFxVbmFZy/fbyii+qO98TuchoJgUz2SzPNIGUv+WloFBN2edr8vrbMtc3PmsG4zhG6yHI01QAPZ/ZUsj1M=
X-Gm-Message-State: AOJu0Yz7hRFxT0wjg2HA7aORM41ueIPYou5YgVG+Lc10DN0sQDwjdZ7Z
	KswgzwwzyADI/CcnSqMAvIwYkhKy0kf5jncmUqfQBf0OzP3DVA1G4W2PyUO0Wh690qN6yCrBBAX
	Cmfa7xi6aeI7xN1fc1IrKTGFcBPR5es+ZFidEgw==
X-Google-Smtp-Source: AGHT+IGMUxO+SbJNNsJNOeCjlAxiHYJmrGmzXoT7AF6Cdx1Io2AIZBXwOGeT+8FzlSsn1R93xMpQ61uziEW80Qs3BTQ=
X-Received: by 2002:a17:90a:c28b:b0:2d3:c4d3:de19 with SMTP id
 98e67ed59e1d1-2d3dfac98f0mr8696169a91.0.1724053767927; Mon, 19 Aug 2024
 00:49:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAPYmKFsTcurrUiWqM8cFj+GgqfRiaLqPDGOTSE+RLyKJGSKE2g@mail.gmail.com>
 <B0C91D33-8C1C-4C67-B9B4-41206EFD8ECF@jrtc27.com>
In-Reply-To: <B0C91D33-8C1C-4C67-B9B4-41206EFD8ECF@jrtc27.com>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Mon, 19 Aug 2024 15:49:16 +0800
Message-ID: <CAPYmKFs7ZyHyKo8uULvYp3YK8ABOJo8+FWDG_cr2YU_cXgfRww@mail.gmail.com>
Subject: Re: [External] Re: Some feedbacks on RISC-V IOMMU driver
To: Jessica Clarke <jrtc27@jrtc27.com>
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>, Anup Patel <apatel@ventanamicro.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com, Will Deacon <will@kernel.org>, 
	joro@8bytes.org, LKML <linux-kernel@vger.kernel.org>, 
	Yongji Xie <xieyongji@bytedance.com>, iommu@lists.linux.dev, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, wangqian.rd@bytedance.com, 
	linux-riscv <linux-riscv@lists.infradead.org>, robin.murphy@arm.com, 
	Hangjing Li <lihangjing@bytedance.com>, baolu.lu@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jessica,

On Mon, Aug 19, 2024 at 1:17=E2=80=AFPM Jessica Clarke <jrtc27@jrtc27.com> =
wrote:
>
> On 19 Aug 2024, at 04:56, Xu Lu <luxu.kernel@bytedance.com> wrote:
> >
> > Hi Tomasz,
> >
> > Thanks for your brilliant job on RISC-V IOMMU driver. It helps us a
> > lot for what we are doing. Below is our feedback on the existing
> > implementation[1].
> >
> > 1) Some IOMMU HW may only support 32-bit granularity access on its
> > control registers (even when the register is 8 byte length). Maybe it
> > is better to provide a 32-bit access method for 8 byte length
> > registers like what opensbi does on ACLINT MTIME register.
>
> That OpenSBI has to access MTIME piecewise is a workaround for a vendor
> not implementing what the spec clearly intended, even if it wasn=E2=80=99=
t
> explicitly stated (but is now, in response to that). Repeating that
> situation would be a pitiful mistake.
>
> The current IOMMU spec draft very clearly states:
>
>   "Registers that are 64-bit wide may be accessed using either a 32-bit
>    or a 64-bit access.=E2=80=9D
>

The spec's description about this is pretty confusing.
 "The 8 byte IOMMU registers are defined in such a way that software
can perform two individual 4 byte accesses, or hardware can perform
two independent 4 byte transactions resulting from an 8 byte access."
It seems that there is no requirement to implement 8-byte access.
It's OK then if we think this is not a problem.

> Jess
>
> > 2) In the IOMMU fault queue handling procedure, I wonder whether it is
> > better to clear the fqmf/fqof bit first, and then clear the ipsr.fip
> > bit. Otherwise the ipsr.fip can not be cleared and a redundant
> > interrupt will be signaled.

By the way, it seems the irq handler must clear ipsr.fip first to
avoid missing out some faults no matter whether a redundant irq will
be generated.

If ipsr.fiq pending via fqof/fqmf is implemented as edge triggering,
then ipsr.fiq can be cleared at first. In this case we can not clear
ipsr.fip again after clearing fqof/fqmf bit, as it indicates a new
fault to be handled.

If ipsr.fiq pending via fqof/fqmf is implemented as level triggering,
then ipsr.fiq can not be cleared at first and a redundant irq will be
generated after this handler's return. But it is OK as no fault will
be missed. Otherwise it is hard to detect whether the ipsr.fiq is an
old one or a new one.

Please correct me if I have any misunderstanding. Looking forward to
the subsequent code.

Best regards!

> >
> > Best regards!
> > Xu Lu
> >
> > [1] https://lore.kernel.org/all/cover.1718388908.git.tjeznach@rivosinc.=
com/
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
