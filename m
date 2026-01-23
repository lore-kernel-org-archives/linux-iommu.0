Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEF035A93B
	for <iommu@lists.linux.dev>; Fri, 23 Jan 2026 03:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769137575; cv=pass; b=oyFH/UbmFvre4/jkk48BBbhrkAKYauhIFWnW4Rtwa0WZmXq/hhRTdaVGu651VRYqXtDD0gkqQ6bCIQUpnyR2pY3sMUyi2xxt+hxkDVRR+mMov2QPSTOpCpJbF8y0TovEPdxrSZQD8RWyL2XMNdr7qD3/j3miMJIutw1lvdqq3I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769137575; c=relaxed/simple;
	bh=1wnj6FJjUa5YD6snLv7xk5DLRr7pplGGAM5h/Cjd1J0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ehM0cCDW8ytiXIphXKwcQLujBq0piCml08VW8jtNF0+pWIL/FmcqNhme9N55rbLbQajd30Xw7bIL2AiSVlebvJGKpHVlw2nUwkp8Xk5EgICUvb8A9qjDj3lUMzGsOF7Cy2mRNucaOVhB1zoUJzmMFJxQOIR8jq2nTjkNWYHFNCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=hNYZ9loT; arc=pass smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hNYZ9loT"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-66297aaf39dso529794eaf.2
        for <iommu@lists.linux.dev>; Thu, 22 Jan 2026 19:05:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769137552; cv=none;
        d=google.com; s=arc-20240605;
        b=Mra33Yh2L68k2wU0ZHInwOEjsR5rjC2utrOojz7tBRup7bWUc/Wy+qMcxAhgKaJr8q
         e7nLSR3ULtzNgH2qAP0fJB4NPRR2DXVuSpaybHNrFeF3em73Xg8npxi/bKQ32MJk4NKG
         xYEp+TDTPsvPBhO5Al1P3MyFUAcy/Haj8CIdTgjn/cC/rxi3oWU2urD6x+yPTpLfNFtg
         od3gH/EeeKgjO2KYvwvgHo8dhNFSkF0wGQaLwdw5pKz8EPYZeXbFHx4lkoGqAG8tuRKx
         Wu2ZbdIS/M7a5+Dm9QL+7ZIhT5NgwbnbVsaz8qJqLoghMPzihz1HGCj0mexk2pf7vg8S
         J5EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HGEqT7UyTgtMNvCrnujktZSI0NxpTV7HktWMzKUJGvI=;
        fh=Dc0DxpPzM3If093TWEYP+teslPnTl+hXLtwXmSJKTaM=;
        b=h+IetHdL17yMlqRYtarJ7V2X/8n4fAAvO3ijKkmz5TcCsx2Lg2MhdceNTdFaxt5e1l
         ifQgRsf6pNplssq8eIRi0o+8AtD3UNgwM7aWRBLGp0j8djfphm3IEXSH19t07ePvJeTB
         asOzW6iZRHst4bdxAFdzDGASjG5YCWfowidjmsNKGwdYBD+gp7wEMEHxsdU4bHLE9P9F
         XixGRCIo4C43NiBI3e5JsDXKVVqMxT3CfAF1D4yToQQO+FAZlWwtxmCJzfhljut0/6M0
         u8QS/HPpJE2JSKmC3ftJ1qtD8IoY0GGmUU8obPlljhN8POh7ZcaSMjBN/X5spHZdZ4iV
         TqmA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1769137552; x=1769742352; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGEqT7UyTgtMNvCrnujktZSI0NxpTV7HktWMzKUJGvI=;
        b=hNYZ9loTUp7MGvaxmheCqublwfG3w2T+fPIhd8BpCBNkl5qy4xjGhJpU0vOYW1hx97
         +04dntL9duXjD/L0AeNOnoigHbI0ZsJhbgfY3UZGgut8NNOKoRC88MaAyn6tz3cEhkI0
         NtnCtIybVUiAlbBf34EfcmIr8/F3PEu92e7EoOvhotrJVRBCgPKjNYpVEF4llulHrs7V
         6lUT0UxicQw01r1NG9io2y3/JMXq5bA6O7uYMAB2vC09mIdNTe92mFHV/5Phy77UdlZK
         /KTi9YMoBHpKsyCCk2STygGmeB48ePB3deJYitk/6ZU9FZqmvo+cy5tShidznR2EQTaq
         JPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769137552; x=1769742352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HGEqT7UyTgtMNvCrnujktZSI0NxpTV7HktWMzKUJGvI=;
        b=GoQEEkW8yB0b24xMBf27gdFF7DSWCm3tUe6sQclf3YMBGLp1VjHXUPTq9fXE4hp1Kv
         XECXbhKqySFD7yHqOr2SVxgq9jH5tfzwbEH6/NonmXymxHX+Y1SjjFJ4J8dO3rBo4LtS
         Ozu/eo428m7XNnTiaHUf17KnhN1mw7zexN8hhOb9OU5U4Hp7Gdsy7InOT+oOYRb5lrOH
         WTTXm2XMfAFB+nFiMLj6x3BTM7hbek2AU7/LyTZjgXMnxrzBlMRhCHhI48iq+ZswcVvf
         NSRSSViiTmrWYkMG6wpnvZp9TbCPjG2ygRFqI2iNC9/dwMefttlhPgmvTyCc6gI6CrgP
         nfmw==
X-Forwarded-Encrypted: i=1; AJvYcCWukafsMxM8c6hGtbMK0R5N8XRR1TwQS6AuGX3tZj888TvuFZLx1f3x1wVkzZWR0ZG4Icvb9w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwU9oVe1pS9INypkgxjnC0bkz/9zqc1Nds/LpNHHpA2webiqEL/
	mh78pTr9bACLw8laRyUGq+i1bqO97zKx3OES+7XdUyDyOUEheixrOBFK82E3ZJhEWM6Hdng7Pr/
	2PlDBo7I/ACOEZ4Ag5OYehL+SQipVIFL1R9VhBg7dOw==
X-Gm-Gg: AZuq6aIoOOY32SrBGQC9YNNSk0vny1Nln/GPqXNObK2ynSSNgFRi5X3B96smDdCcgcx
	3N7aVUv1vHMqzpZE4h+gLjEHVr/9LsyVudJXkzDgovlKHioojjWczKm1tK4cJIfhkAUo+44xT+X
	nECcay4tZsB3FVNUIbQa9Y5O4aLPn0hl12rtfszxgpLsVn8xhrjcV6ErP+ugNjhrJlSY6H15j0s
	uEVsILnhMcZ30dn1hsaRxnBz2taFpTTzLUub9rKGUihu7KAKz4KzYxuUY417loCUFj37R8zUA==
X-Received: by 2002:a05:6820:1689:b0:65d:95d:2de2 with SMTP id
 006d021491bc7-662cab0b17fmr951053eaf.25.1769137551657; Thu, 22 Jan 2026
 19:05:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v2-b11ebca8abb6+c096-iommu_pt_riscv_jgg@nvidia.com>
 <CABvJ_xiUK9BqUJS9-Sk1sS4vhVhyXN8P8NooZ0t_Zp7ycG0bAw@mail.gmail.com> <20260122153134.GO1134360@nvidia.com>
In-Reply-To: <20260122153134.GO1134360@nvidia.com>
From: Vincent Chen <vincent.chen@sifive.com>
Date: Fri, 23 Jan 2026 11:05:40 +0800
X-Gm-Features: AZwV_Qg9IApxpDwG1qJn4LgmdvEEpNtmIvGulgwGbciwMW5SeFs7SpLra02DWaI
Message-ID: <CABvJ_xgSbK3omxT7XGJ0N7oEva6dQAJwZxRhsBqi44BRNZ3G5Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Convert riscv to use the generic iommu page table
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Albert Ou <aou@eecs.berkeley.edu>, iommu@lists.linux.dev, 
	Joerg Roedel <joro@8bytes.org>, linux-riscv@lists.infradead.org, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Tomasz Jeznach <tjeznach@rivosinc.com>, Will Deacon <will@kernel.org>, lihangjing@bytedance.com, 
	Xu Lu <luxu.kernel@bytedance.com>, patches@lists.linux.dev, 
	xieyongji@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 11:31=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> w=
rote:
>
> On Thu, Jan 22, 2026 at 09:46:47AM +0800, Vincent Chen wrote:
> > Hi Jason,
> >
> > I tested this patch set on my side with the QEMU-virt machine.
> > I used the following QEMU command for testing:
> >
> >   $QEMU/qemu-system-riscv64 \
> >     -M virt,aia=3Daplic-imsic,aia-guests=3D7,iommu-sys=3Don -m 8G -nogr=
aphic \
> >     -bios $OPENSBI_IMAGE \
> >     -serial mon:stdio -serial null -nographic \
> >     -device e1000e,netdev=3Dnet0 \
> >     -netdev user,id=3Dnet0 \
> >     -cpu rv64,v=3Dtrue,vlen=3D256,ssdbltrp=3Dtrue,smdbltrp=3Dtrue \
> >     -device '{"driver":"virtio-9p-device","fsdev":"share","mount_tag":"=
host0"}'
> > \
> >     -fsdev local,id=3Dshare,path=3Dshare,security_model=3Dmapped \
> >     -append 'console=3DttyS0 earlycon' \
> >     -kernel $KERNEL_IMAGE \
> >     -gdb tcp::6234 \
> >     -smp 4
> >
> > The boot log shows that the e1000e is successfully added to IOMMU group=
 1:
> >
> >   [    0.752808] pci 0000:00:00.0: Adding to iommu group 0
> >   [    0.753279] pci 0000:00:01.0: Adding to iommu group 1
> >   [...]
> >   [    0.763212] e1000e 0000:00:01.0: enabling device (0000 -> 0002)
> >   [    0.765241] e1000e 0000:00:01.0: Interrupt Throttling Rate
> > (ints/sec) set to dynamic conservative mode
> >   [    0.868120] e1000e 0000:00:01.0 eth0: (PCI Express:2.5GT/s:Width
> > x1) 52:54:00:12:34:56
> >   [    0.868740] e1000e 0000:00:01.0 eth0: Intel(R) PRO/1000 Network Co=
nnection
> >   [    0.869087] e1000e 0000:00:01.0 eth0: MAC: 3, PHY: 8, PBA No: 0000=
00-000
> >
> > In this environment, I used iperf3 to verify that the e1000e functions
> > correctly. The result shows that the test completed successfully:
>
> This is great, thanks!
>
> Can you confirm that the iommu was set to translating for this test?
>
> $ cat /sys/kernel/iommu_groups/0/type
> DMA-FQ
> $ cat /sys/kernel/iommu_groups/1/type
> DMA-FQ
>

Sure.

# cat /sys/kernel/iommu_groups/0/type
DMA
# cat /sys/kernel/iommu_groups/1/type
DMA
