Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13305299A81
	for <iommu@lists.linux.dev>; Fri, 23 Jan 2026 12:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769171355; cv=pass; b=azkHcR+11mwbUltwiy8tdqrKbp0zpfXhu+DWh4J4soUFMXzeOXEHno7ExVaA9zaBEtlKV7ZMKuIPVrryYpHGdYbc8FAucTmslMpY2NrDEMN6NENcRuE5flmyVNVLKhcgkmymMQr1veXD2c/nhUvdFxzmGgEndZTxWSDiTHjS/0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769171355; c=relaxed/simple;
	bh=XR+7C6pb807RCIW0CIuMZsWdXhj4rxWiUmBKJRrKbm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CixH+xTm1LH087JmfP53Ys3q0vLR9fnSzjwdITE3zG/Q8Vd9nm0Ua9tHifiewBqD/7q6D4vMbzV10RwpRwr46UuJS8z1gMP4HSVI4Bd7DoEN4PaVmRW/AyJFY7BZfzmvI38EMcSc6+Ohd2c93sBudztjtfUzmEfRNFDU7c88cXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=m7B8Ztlr; arc=pass smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="m7B8Ztlr"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-65f59501dacso1604489eaf.0
        for <iommu@lists.linux.dev>; Fri, 23 Jan 2026 04:29:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769171353; cv=none;
        d=google.com; s=arc-20240605;
        b=ClysGp8pPpRsbUYiDBGHP6nPgbIIbURtutTPCeFtRY7pud42fxdQq2bqp+iT1KRU3s
         zmRHDyjbwJzpGzpBYXwWsUYBlEsyWy+g2lwOuT3RB5+t+lsbXrX5FK/ptyZiOE0qy2Ly
         9H3TFVLnvS1sIBaQmNEBUEEYsYL30hcJkCNWjfODgwJKcG6kxGcQ710HX8zWf/Ifogwf
         Fl++bdK7MDawJRecfbt48I6Cir5dtTDNtDocYDgSVOUrzH8rfOLnyxxTv9iiZRf3ndb8
         DdfdMisW+K455+6ca8QmhyBLIHtlwyFOQN1Nb1GSHv5+zxlmSbyS+OasMRZNizfDxFhO
         Ojtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5ia/0onmW7rqxIqY0Xa3NnOog6ovCu83wYubolEXe60=;
        fh=9ZgVekkYIGLRvJskx/PL0EMW986lEDT8NgQJ6WI+mZ4=;
        b=HAb7G1eziH81pqT4C8ACCwtiL3Pkx6uK5EX4DtzNpj6Owftv3Na/sgTXf+e8rTv8dq
         7PFjZjrU39zxAz3/VMhFkiZ2c7M31PSoSz6gJTqkqiSgUOwuuEX6Ujg8Y5R1OlPqfg70
         5FxyyfpYtPgfydlqsnB2MRTyX0a3x5+RJzWOQ3nvXJonZ5171V8mpQC9OVDHrP/TYC7H
         bpKEYRsTH11sn9vn/p6gmwmvsn0VUdzFIa12HNOgIf8wvP6crc1qQmqXt0rzr0SJ3miW
         ba5RqeAHCqh5MFEDPaNcXDcS/pL7NXhfvel/UAyM6Ie2Ae9M2+OwMopqVDIlXGrre9n0
         4e+A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1769171353; x=1769776153; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ia/0onmW7rqxIqY0Xa3NnOog6ovCu83wYubolEXe60=;
        b=m7B8ZtlrsqyDaV6HmSAP9OTrRZfHKdyPFnd7byBO7H6OjGa8wa7+8r4GY/Kwv8pXV/
         q7DUd6QUoFTy29fekPcfYo5xsWI4L/1yP2ExRD08JJb5oVsfnv+8S/Sxz0AB7fP86cR2
         OizMGRtZlo0zyNY4fy/ocqJJ62+J8HACsbRgyZ0fihU3VuwOpDAr68ie05EIWAeDEHzl
         NPnDGHN8benSOAik+W2ZH2IY+/As7LZLnP0TtJTtv5eNfr5nstdUGWrguBT/FQgkaw7R
         qwC+iwK//ytD5QXVXfoxVDykZIEbJGuL2myURJk1OnXT5Ux0Panw16WkiDQWDs/MSe2Q
         XQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769171353; x=1769776153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5ia/0onmW7rqxIqY0Xa3NnOog6ovCu83wYubolEXe60=;
        b=cil2fsXmK9MK3fp8n4xw7mBITiiU7aMgrRbpz7dNp75Pkl/ybTynwxLslx9g5+Zk3N
         CrYRVDTiqbvDb6uWuEBGPCXsktYlGN4qad8wmQp3qJQXtUYvSv0woSnNynEg/1zoE+Pz
         kZo/FZMVE2qmQcakVO8frj9TyOI8Cvs1jT1rVdC8V5aupQg33lZQVovtRTTP9Cj00Z1n
         UPaO1MyIeugY4Pz0mpyLFbNZCacJgrfYJukF8+tGWhoS1+dQzQ7nFSZwni/7b0cNONTz
         4MyzQlhgoTWjolGKBVaxPAd5vNxB1YEOhCh1KVQBzwjrtlGaKKNONgXQlgW3nIJ/WOul
         NqKw==
X-Forwarded-Encrypted: i=1; AJvYcCXgn9AqY4iHK+haPj6XUGIbPkKaRYhiWCIOZzT4ia5T5SxfAsdRv50PDMpu8rNWQ2tWGOeoUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwK83ILDWGFFxdOfWMirvsXGPWBf+drxl3lQaz5BlDvfu8Qpvxc
	/kq5/f/phP0BPVkHI5Jrf+NILWuSmDZm2JzXTHDtYuxqQas29S2bWgBxn/L8r4C59/VHAjiVc8D
	NSpjAtwAk4+Xhyw+oCvQ6USbpfg5fRQ3jO6EKnOK+zw==
X-Gm-Gg: AZuq6aLlE/G/OaGl5jZcGrPUSd5KBGU96wv+SLkDGB0cfPbsDGSDA1tbXaEM5YyK5Qn
	YnK+HY7/XyuLQugIEWeN6LGLtcw8eWP9QsSjSRiXkamDFflF1zkKdK/Rco0fDp+7AxUcK+FxsAd
	eWkJEhhSvvn1Qg/+lgYcVkK9x6TXFscqeM6TLkrS7ggT3mVsn/48dbQpH21kz8o1gap8dD8THM1
	WEBGCCBpOOn3EZszpSkbZu98aIWuP+xxhESu3/EIbOfYHvOThiRMUaAEW/M8fF2VY1v9LJLch6Q
	OPlPVgIsDOB+ilfKO8E8OQBJbGf4Wg==
X-Received: by 2002:a05:6820:150e:b0:661:2215:4feb with SMTP id
 006d021491bc7-662cab7f464mr1186476eaf.62.1769171352774; Fri, 23 Jan 2026
 04:29:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v2-b11ebca8abb6+c096-iommu_pt_riscv_jgg@nvidia.com>
 <CABvJ_xiUK9BqUJS9-Sk1sS4vhVhyXN8P8NooZ0t_Zp7ycG0bAw@mail.gmail.com>
 <20260122153134.GO1134360@nvidia.com> <CABvJ_xgSbK3omxT7XGJ0N7oEva6dQAJwZxRhsBqi44BRNZ3G5Q@mail.gmail.com>
In-Reply-To: <CABvJ_xgSbK3omxT7XGJ0N7oEva6dQAJwZxRhsBqi44BRNZ3G5Q@mail.gmail.com>
From: Vincent Chen <vincent.chen@sifive.com>
Date: Fri, 23 Jan 2026 20:29:01 +0800
X-Gm-Features: AZwV_QjuLN0FLG3VneZxDaqO5dnkTcs75k0VirNO833q66YQcdrVcIgmsYXTtfY
Message-ID: <CABvJ_xhY_4ADOsVVbjhkBm8U1mKVOSwzKMfBw5mUsJe=kkUiLg@mail.gmail.com>
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

On Fri, Jan 23, 2026 at 11:05=E2=80=AFAM Vincent Chen <vincent.chen@sifive.=
com> wrote:
>
> On Thu, Jan 22, 2026 at 11:31=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com>=
 wrote:
> >
> > On Thu, Jan 22, 2026 at 09:46:47AM +0800, Vincent Chen wrote:
> > > Hi Jason,
> > >
> > > I tested this patch set on my side with the QEMU-virt machine.
> > > I used the following QEMU command for testing:
> > >
> > >   $QEMU/qemu-system-riscv64 \
> > >     -M virt,aia=3Daplic-imsic,aia-guests=3D7,iommu-sys=3Don -m 8G -no=
graphic \
> > >     -bios $OPENSBI_IMAGE \
> > >     -serial mon:stdio -serial null -nographic \
> > >     -device e1000e,netdev=3Dnet0 \
> > >     -netdev user,id=3Dnet0 \
> > >     -cpu rv64,v=3Dtrue,vlen=3D256,ssdbltrp=3Dtrue,smdbltrp=3Dtrue \
> > >     -device '{"driver":"virtio-9p-device","fsdev":"share","mount_tag"=
:"host0"}'
> > > \
> > >     -fsdev local,id=3Dshare,path=3Dshare,security_model=3Dmapped \
> > >     -append 'console=3DttyS0 earlycon' \
> > >     -kernel $KERNEL_IMAGE \
> > >     -gdb tcp::6234 \
> > >     -smp 4
> > >
> > > The boot log shows that the e1000e is successfully added to IOMMU gro=
up 1:
> > >
> > >   [    0.752808] pci 0000:00:00.0: Adding to iommu group 0
> > >   [    0.753279] pci 0000:00:01.0: Adding to iommu group 1
> > >   [...]
> > >   [    0.763212] e1000e 0000:00:01.0: enabling device (0000 -> 0002)
> > >   [    0.765241] e1000e 0000:00:01.0: Interrupt Throttling Rate
> > > (ints/sec) set to dynamic conservative mode
> > >   [    0.868120] e1000e 0000:00:01.0 eth0: (PCI Express:2.5GT/s:Width
> > > x1) 52:54:00:12:34:56
> > >   [    0.868740] e1000e 0000:00:01.0 eth0: Intel(R) PRO/1000 Network =
Connection
> > >   [    0.869087] e1000e 0000:00:01.0 eth0: MAC: 3, PHY: 8, PBA No: 00=
0000-000
> > >
> > > In this environment, I used iperf3 to verify that the e1000e function=
s
> > > correctly. The result shows that the test completed successfully:
> >
> > This is great, thanks!
> >
> > Can you confirm that the iommu was set to translating for this test?
> >
> > $ cat /sys/kernel/iommu_groups/0/type
> > DMA-FQ
> > $ cat /sys/kernel/iommu_groups/1/type
> > DMA-FQ
> >
>
> Sure.
>
> # cat /sys/kernel/iommu_groups/0/type
> DMA
> # cat /sys/kernel/iommu_groups/1/type
> DMA

Hi Jason,

Please disregard my previous test report. I realized that the previous
result was incorrect because the IOMMU was actually running in "identity"
mode, so the test did not verify your page table patch. Sorry for providing=
 the
incorrect test result.

  # cat /sys/kernel/iommu_groups/0/type
  identity
  # cat /sys/kernel/iommu_groups/1/type
  identity

This occurred because the RISC-V IOMMU driver in v6.19 does not yet
support MSI redirection. Consequently, devices using MSI fail unless the
translation mode is set to bypass (identity), meaning CONFIG_IOMMU_DMA
was not active.

To properly verify the patch with DMA translation enabled, I integrated
the MSI-related patches from Andrew Jones's RFC series to unblock the
test.

  Andrew's series:
  https://github.com/jones-drew/linux/commits/riscv/iommu-irqbypass-rfc-v2/

  My entire source tree (Jason's patches + Andrew's MSI patches) is here:
  https://github.com/VincentZWC/linux/tree/v6.19-iommu_pt_riscv-test

With this codebase, the IOMMU group type is now correctly configured as
DMA:

  # cat /sys/kernel/iommu_groups/0/type
  DMA
  # cat /sys/kernel/iommu_groups/1/type
  DMA

I re-ran the iperf3 test in this environment, and the test passed
successfully.
