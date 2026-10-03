Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC071377550
	for <iommu@lists.linux.dev>; Sat,  3 Oct 2026 08:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791017408; cv=pass; b=nGajGkHnEc8JtqVXNT4JsgOGWQM7lTnn1TP9uornG+vslIQfw9oSpSoIOyFe3m0IkdKwysiNEJeJ4lTiobmivc87sPILRSb0qd8sPpR9SAEYReSZiPPrpLgFLEF1X1CVG3DtVgF4DQNokUxt7JlLSRNoFUH3C8l9COFwP2tBlZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791017408; c=relaxed/simple;
	bh=wwEY7S58LLbqNEpta5C1Ecn/2pNosDxbBn3Dvm4v3mg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=A4930SKR+wyCyLcI+NOlLS2+nC/Pcm2zL78uIiJxnmRglRH4tz0E0vvhR2YSEkcO95+Fx5yIZVL6CZknNAzakjw4AfcZayBIDiOugVeAmfJBXRFW3w4TUJbKvJc2KdvUuLldSgWFwNZDPRDVVZr5uEj2B1I5n2DwJ1EPsG5+b1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEiVVc/g; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEiVVc/g"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-917ad52d7b6so5159276d6.2
        for <iommu@lists.linux.dev>; Sat, 03 Oct 2026 01:50:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791017405; cv=none;
        d=google.com; s=arc-20260327;
        b=JnEbPZyaYj+Vh984cf9pcEkrvF+iNsr5Nz48hfU+/Fgc6fVvzTr/+HZNh1cLkFL3Xq
         9fRjaXlPWlFGHsOZbbdkRwgw0v08PPjlIAcj0gIuLJAq4grSrxRw5y5TDda5psEiEwUX
         NQMexRSgPzp5Cpmp8mHJysMu2o64YgkuTNbMNDXemZAt2ZW93lx1iksa/xVBEVI9uQCw
         2riOKc9QjxsLQwlQr0fnTWX5cPYl6QWEYU+x6Ya8z0ZlgDt0qFHNj9Pr+bxdNnihAkJr
         /MrllndpWpZ45QpcyZzSmEZhL2paByIb1yqvzR2TtUE7R8suzv8WMWc9ZSNsuI+5AhEg
         hOgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=aw92WUQMYYkpSyEQ6zu6Xuske1k+/7TiDhQr8+Oxm0w=;
        fh=qR3VQXVegcdGAIFOeV+QId1twGveXTs7Z7KH3dsxKxk=;
        b=ZOXHVdievq0eBTy1khvXxD8OvkE1ArLP7Jo6Yzy9pQdXDmwHO37qr50gO7T7Y5RkOu
         /ml7kXfDncsYzhQBojsYHBXGrIoG3j9mr3KAswoESlhcOxHGIDTvXdqzrTQweliRqnKd
         2OqUPGLMWoMVtMk2VlFT+GE1YlIXr1yFoo/O79lwuABvvFWjTBlmwakpSw5nYMtTbY2X
         fvFqEC5qPwPNuGEudCmNGTwnSnKW63GzHjJTdOMrHfGbvHCVGjiyj6SmQJ/z59cRYsHF
         VU9CTq5EBlvEINGQaaZz5tAhulp0TRT5OMd9Jq31TpW8iyk84t59HxL86vfR5O5WjGqx
         40uw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791017405; x=1791622205; darn=lists.linux.dev;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=aw92WUQMYYkpSyEQ6zu6Xuske1k+/7TiDhQr8+Oxm0w=;
        b=bEiVVc/gL/OzNDxl4LswDTKo6Mgu6sGAngAxZAeGAgwsG753ZkFcgp3bMbzAqGAiLb
         8FpfBUMWzdxuM8nskluz3Xumc/p9iEnElI+YwnhbwHYPErj9dECrgweUparzdAiQGjcB
         furRaXIxwaOhuXo2PECeiCAEAACHRgL3Kpqnsp1a1RMGrcfNVjOA6zvkn5irBa1ACdpk
         PIVqPyo2Y3xeWcvSNdw2KzbnN38R3/OBQj+pljK//YLa0rN/gauUOP1v0hYinBaZ/bcS
         YnuF1uf26yG/uGrsbD+RL9MhDZMso/0WAjDpoPbseH/L/gotQcxUPLWXs+t+mIF3xIdN
         TNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791017405; x=1791622205;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aw92WUQMYYkpSyEQ6zu6Xuske1k+/7TiDhQr8+Oxm0w=;
        b=CI2Vzmr3kPNdyc6nyY6jbEgTzs5Y4lxDfKT/+A9fPNYzRkpXvsxi6175+mmyLFqiwx
         CxR1y4HLxoeriug3cbYDtQotYx8+E97FG1O49Gx+jOx6vWFenGD1PfkWeAkzW+Qd10w1
         iGChnNCPdWN4f6FDF9kNbXc0MwbH6w2YICn6LPdDAKe86R7wAr9hXGHZ8RIF5vc0+Dra
         /i+oMtBjbXTRR0C9oZMj7YqMY3WxoJEmkMM/OZ6eFSL07MTsyVJ2M/kwvMiSeZVhqR2z
         SDjInEdkGPCEIWT5M/w91Pv5tygo5RjdQA1RwZR8Y0942XfKsOx9y3sChAvPYSa91kUt
         cElA==
X-Gm-Message-State: AFq9FYKgVs3ZpioHes35AR7SPBEdrQKEEPP3CaIQFluYj+6tLtEkvQh9
	azL794HtVAN2VbkdWkCsxwIeu6ySdQ4puQa3T+dRU1QuHt1EpqyvzQAaaMIyPrRQ/1wQjQ3OX9m
	Qz9lMch2P43UYcEjmylAJoviPkACrZCwYMXPM
X-Gm-Gg: AYBFou1MSBcI7ooYziRI0SQ+8xaJyRnk/1E1sn+wdIwgFRH4Z8hJcitt9fGjMFGdwZL
	oVdhuCHYRkKy7z9QZM5evs7rooE3RRkfdp2f2kpGoLGz5AtWl8AruGuR+OonY87W/hz5Ea7oBiy
	A3MF4mPGmtdXSB0SZ/HkBizPZmeo9PDqgMhn0sd/7uTW/Fftcw9NA73G0tx4t0moj2l6ITRp/v9
	LW9/isfqtX9qo8o4FOKjv5UzcM1qnK1hNkbUhjooQMr1tn4hNbVIS9kZvWjgAfUTSQURXfz55O7
	mpc1IOlXZT9f5v1Q+rCpuLMdeBMSicjtQy8A9tyCfyFal/7f43fiTKgJWgwP8n62JhpnI4/o/mr
	uj4fxvzz7AG4JqYTwHot7GwnZgdsvVoBPFI8p2db8BSMYtpI=
X-Received: by 2002:a05:6214:19ed:b0:915:e6ed:db32 with SMTP id
 6a1803df08f44-9195d202047mr34293916d6.43.1791017405252; Sat, 03 Oct 2026
 01:50:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Thomas Kroll <nofuturekid@gmail.com>
Date: Sat, 3 Oct 2026 10:49:39 +0200
X-Gm-Features: AclHuK-KochZyQ4RHrlZSze3j2U8UwBGcRtQAlKKoEs5_vb-guRgHQ_ZEvQmy9c
Message-ID: <CACvYUjoCW-HReH1VMVDVvJqbAbnZENdBjDD2HmUdcVhTx7qzsA@mail.gmail.com>
Subject: amd_iommu: MMIO_STATUS_TIMEOUT on hibernate (S4) with Ryzen 8700G,
 amd_iommu_intr=legacy avoids it
To: iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

This adds to the existing report "[BUG] amd_iommu driver timeout
(i >= MMIO_STATUS_TIMEOUT) during S3 resume on ASUS B650M (Ryzen 8700G)"
(Gareth Wilson, 2026-08-07, follow-up 2026-10-02). Sorry for not
replying in-thread, I could not get the Message-ID.

Same 8700G, a third board, and on the hibernate (S4) path:

  MSI MAG X870E TOMAHAWK WIFI (MS-7E59), BIOS 2.AC3 06/25/2026
  Ryzen 7 8700G, kernel 7.2.8-zen1 (Arch)

It hits every hibernate cycle (5 of 5 checked), twice per cycle:
once in syscore_resume() right after the snapshot is created, and
once after the image is restored. Each time about 24 s pass inside
amd_iommu_resume() before:

  WARNING: drivers/iommu/amd/init.c:945 at
amd_iommu_enable_interrupts+0x523/0x5e0
  i >= MMIO_STATUS_TIMEOUT
   syscore_resume+0x5d/0x170
   hibernation_snapshot+0x24d/0x4f0
   hibernate.cold+0x117/0x4b5

It reproduces without writing an image: with
"echo core > /sys/power/pm_test", the 5 s test delay takes 31 s.

amd_iommu_intr=legacy avoids it while keeping the IOMMU enabled: no
warning, and the time from "hibernation entry" to "Image saving done"
drops from ~70 s to 9 s. That may be a narrower workaround than
amd_iommu=off for others hitting this.

Happy to test patches.

(I tracked this down with help from an AI assistant; the numbers and
log lines are from my machine.)

Thomas
