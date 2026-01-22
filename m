Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC2A1C84D7
	for <iommu@lists.linux.dev>; Thu, 22 Jan 2026 01:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769046424; cv=pass; b=fz9yVcse7TuF1B/DDK0tqtOSospGjPnQ/eYzlH+jE1haKmUTFcSFg5Y6QAavVasuvUbKLh3BGqYzg7ugOWUzcztS4z5khxSUkqv7k2cvWVYQY1tCvOqOIIJUtvUxl95IwFwzsPJB7Ph20VzJ7N8ja3GUiubW5v/l7TZ4RJ6PycI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769046424; c=relaxed/simple;
	bh=0u8zE8DwwJ3CkOI5RZfv+1sTutkTchoW6WqM0X17EGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eEQV9sSzx2GARz7Mgk3Nx4YYNoElsuSEjcE3d1tsvQipcxQToAsbDt7jmdZtNJ99mV1+QN6Hm5OsQJWVaoZnpnaGQs5tcBEuVi8SV1EuuszCglQcc0VayjUf4BG9Et0nCDu+/A/4RQZ3eTLhxUEFcCr+7vflh9IA/6j1cOqp7FE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=TMJdcLXm; arc=pass smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TMJdcLXm"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-66109b09b53so146939eaf.1
        for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 17:47:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769046420; cv=none;
        d=google.com; s=arc-20240605;
        b=JcrmM2eiBaDXhKacvbOqYJ5ftJQhrvBlTc86okqGtHtcBc0RZYjYuz9aNTET/0MZqn
         eTjjOJnL50TjlRndbhvbD+wdsPojbyKyAH25WSkIy66Eizuirx6kDHMhSBijrqekwjbe
         pzLb6lNb2xKFT9Q+tVpbPZ+2jJqzyWj14UUslzhdox+fGyziD+7G4YWhWwjGEkmic41m
         HUfPggqRu2PsYo4dMNC/HsT7IH8UV+awDVt7sP2ehyUXckh1tUrKJKtzsPSgc+RWZHuG
         2F4YyzUkbDhNAPu9SdowaR32YZesTFKHoCYAhFrM7OY2LZi06ZWU0V3cnpImRYpffxSG
         NseQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9PTzoubPp4hDkja30sWF+suRnJHt7y0QXrdAbJ13kqA=;
        fh=R34M5QsXHa9qsdpCLnrTMMMyRe1XdGVPQ14lTZchiTQ=;
        b=gvp8RLwnipS9cgWjF6+e+KgSEdRXtLLzhHbxJnoSjx2othBvP2VRN6n5ZKQc3mzCPw
         QAARxzXqaygKrYfOa8+4lfyp5C4DYiu0Mw5PDukls/hjPbGzf4jpPOqGcpehFvkSEAeX
         KzADVrUtEQauxn8sXF1cfnIeetx7DRE34B0PJh0eosi2KChhrxkZAJFh6Nu0kETZd87N
         yCp35YxpDs7xVrMpckQLb8Nnr5bsc6bXy6V2USLAqAH5Zt4H0FnvLt9sJ4gz3gWvKTqL
         hm1Dwb+rw4P70iqIA0FYlsWQIXHR/cV+SwwhR/K6YYDawZI4c6Mp9ajoeoswgW7KtJ7L
         CNtw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1769046420; x=1769651220; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9PTzoubPp4hDkja30sWF+suRnJHt7y0QXrdAbJ13kqA=;
        b=TMJdcLXmuC+d+ueuQAob7jZkgNbrZhobNQ6v6+0xPSHDn4EMLDuSPC5/zya9h3Brib
         a4YSTbzQOfUQCcuyZd37tXHK/CN2p5lbw4Ye9fQO32Ti13mcSjdOdFbeMD0rJhQTdreQ
         kVszbpjdkfpJp3kljjiTbFNWJ/PljCRTdS3YQ3HKEuFG2teiB1N+LkyiagZpZEiPJLPv
         fvvk/qDy8oPDXUMNVCXC6SdK2o9msLmJ66wK8HPDLQNvNdVkJCOo9f3xHNvM2GGx9EVo
         1TrfcqVJWoId1NhiPTHLGLKH7PKr+nqucbSt+/A1FYWRWZ9+8lLtgTfvkbSDEDExVZr3
         Lr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769046420; x=1769651220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9PTzoubPp4hDkja30sWF+suRnJHt7y0QXrdAbJ13kqA=;
        b=ml7m74fPOx4P7JB6EXDwSp9PInDjaujBtsEJ0vZ1XcTYwnod2qh3ETLCSZPJmXp4W8
         VlSIFQ2qZThRpzmTgWXYWVN9gRHAWUvYfm0rcntsq5vggmB92R58oJPXvYkPV2vabpd3
         Cz5R9nqrclpVnzpLY+qp9Vu5HJ2s7eERhbKaR1bY+svQ1QH6H0nTa3DkaolfUXxp0j4G
         3j3pZDgHLQe2DO5v4frC1p0rZpwcctKgkBLs7tjdEWQlfCbC9c98I2sG88BxSaTP1k72
         vZvWr3ikzSuQLOkherFGqCLyWdvRu3Q9q23vMAe8nMJ927FfMvZFt2KP9Ce8J+aNCG7u
         sW2w==
X-Forwarded-Encrypted: i=1; AJvYcCVcEu5P1lumLIL2IL//qk31DzIxI3O/EnUdiyJxnGN8Awss19AKMaREhKgiOuwvXtG1xbognA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzFxVirXEqCotSj0HqOEzM7yEJth2Ia7JmCSMnENK15gMdD1wln
	Gf8F9+XSAbcYmfQOTWwcjAZHjotrY8rgWr1hTATixQPnU6+KJCQ6a1S7vB/wveYws5NAXf7sWIO
	JXYnTU1ED2zHyyj8X0hz7lWoQUKxq5mXtR9CS8CC9HA==
X-Gm-Gg: AZuq6aKgLvXR3fzxKRNYajKE4Uvno+xzxekP0aQboO2pzpkiOPXmlryBK7AGmqcaZ9k
	z5H0j7uHwyT8RpkakjhT9wpHwTTC14uiaZvsoyb+TEQGA9yEVK1pfbCKEZ0yyGp8eFXkJMT2FOy
	zDyHtoXg8xnHNqsHLFzV3lLeCZmQioeEDpY3qDYc0n6laRNxtFBZOX+LW+4tH9d6mx7bw+nhPsc
	fzM5MD6fqP15LLv+Nepm4I5S1TVLOkXPjGshJ+ZitbUMKjEs6poEtUSxzQzpjhOpYwpyZ3o8vNF
	i6RDX33+
X-Received: by 2002:a05:6820:4d5a:20b0:662:b8fe:201 with SMTP id
 006d021491bc7-662b8fe0440mr1740999eaf.23.1769046420173; Wed, 21 Jan 2026
 17:47:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v2-b11ebca8abb6+c096-iommu_pt_riscv_jgg@nvidia.com>
In-Reply-To: <0-v2-b11ebca8abb6+c096-iommu_pt_riscv_jgg@nvidia.com>
From: Vincent Chen <vincent.chen@sifive.com>
Date: Thu, 22 Jan 2026 09:46:47 +0800
X-Gm-Features: AZwV_QiJd5q6gXWC5pBl8iW8G0RoL8rDe_7SQsYQAor2KcNuj9vdHUwn-MU0KzM
Message-ID: <CABvJ_xiUK9BqUJS9-Sk1sS4vhVhyXN8P8NooZ0t_Zp7ycG0bAw@mail.gmail.com>
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

Hi Jason,

I tested this patch set on my side with the QEMU-virt machine.
I used the following QEMU command for testing:

  $QEMU/qemu-system-riscv64 \
    -M virt,aia=3Daplic-imsic,aia-guests=3D7,iommu-sys=3Don -m 8G -nographi=
c \
    -bios $OPENSBI_IMAGE \
    -serial mon:stdio -serial null -nographic \
    -device e1000e,netdev=3Dnet0 \
    -netdev user,id=3Dnet0 \
    -cpu rv64,v=3Dtrue,vlen=3D256,ssdbltrp=3Dtrue,smdbltrp=3Dtrue \
    -device '{"driver":"virtio-9p-device","fsdev":"share","mount_tag":"host=
0"}'
\
    -fsdev local,id=3Dshare,path=3Dshare,security_model=3Dmapped \
    -append 'console=3DttyS0 earlycon' \
    -kernel $KERNEL_IMAGE \
    -gdb tcp::6234 \
    -smp 4

The boot log shows that the e1000e is successfully added to IOMMU group 1:

  [    0.752808] pci 0000:00:00.0: Adding to iommu group 0
  [    0.753279] pci 0000:00:01.0: Adding to iommu group 1
  [...]
  [    0.763212] e1000e 0000:00:01.0: enabling device (0000 -> 0002)
  [    0.765241] e1000e 0000:00:01.0: Interrupt Throttling Rate
(ints/sec) set to dynamic conservative mode
  [    0.868120] e1000e 0000:00:01.0 eth0: (PCI Express:2.5GT/s:Width
x1) 52:54:00:12:34:56
  [    0.868740] e1000e 0000:00:01.0 eth0: Intel(R) PRO/1000 Network Connec=
tion
  [    0.869087] e1000e 0000:00:01.0 eth0: MAC: 3, PHY: 8, PBA No: 000000-0=
00

In this environment, I used iperf3 to verify that the e1000e functions
correctly. The result shows that the test completed successfully:

  # iperf3 --bind-dev eth0 -c speedtest.uztelecom.uz -t 120 -i 10 -V -Z -p =
5203
  iperf 3.20
  Linux buildroot 6.19.0-rc4-00059-g92d6f969eb10 #10 SMP Wed Jan 21
11:06:14 CST 2026 riscv64
  Control connection MSS 1460
  Time: Thu, 22 Jan 2026 01:30:52 GMT
  Connecting to host speedtest.uztelecom.uz, port 5203
  [...]
  [  5] local 10.0.2.15 port 58132 connected to 195.69.189.215 port 5203
  Starting Test: protocol: TCP, 1 streams, 131072 byte blocks,
omitting 0 seconds, 120 second test, tos 0
  [ ID] Interval          Transfer    Bitrate        Retr  Cwnd
  [  5]   0.00-10.01  sec  5.62 MBytes  4.71 Mbits/sec    0    128 KBytes
  [  5]  10.01-20.01  sec  44.0 MBytes  36.9 Mbits/sec    0    128 KBytes
  [...]
  [  5] 110.01-120.05 sec  69.1 MBytes  57.7 Mbits/sec    0    128 KBytes
  - - - - - - - - - - - - - - - - - - - - - - - - -
  Test Complete. Summary Results:
  [ ID] Interval          Transfer    Bitrate        Retr
  [  5]   0.00-120.05 sec   676 MBytes  47.2 Mbits/sec    0             sen=
der
  [  5]   0.00-120.05 sec   675 MBytes  47.2 Mbits/sec                  rec=
eiver
  CPU Utilization: local/sender 3.8% (0.0%u/3.8%s), remote/receiver
5.2% (0.7%u/4.6%s)

  iperf Done.

Thank you very much for enabling the generic IOMMU page table mechanism to
support RISC-V IOMMU.

Tested-by: Vincent Chen <vincent.chen@sifive.com>

On Tue, Jan 6, 2026 at 11:07=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> This is a fairly straightforward conversion of the RISC-V iommu driver to
> use the now merged generic iommu page table code.
>
> It brings support for SVNAPOT which is a 64K contiguous page. Otherwise i=
t
> should not change the behavior.
>
> The series disables SADE as the dirty tracking support is not implemented
> in the driver and should be done somewhat differently. The generic code
> gets further along though this does not include the format implementation
> of read and clear dirty.
>
> The format implementation should be able to support the 32 bit option, bu=
t
> this does not enable the iommu implementation as there seems to be no use=
r
> today.
>
> It looks like RISCV could support the DYNAMIC_TOP option. It would requir=
e
> some additional work on the core side to interact safely with SIGN_EXTEND=
.
>
> This is on github: https://github.com/jgunthorpe/linux/commits/iommu_pt_r=
iscv
>
> v2:
>  - Rebase to v6.19-rc1
>  - Fix typo in PT_FEAT_RISCV_SVNAPOT_64K
> v1: https://patch.msgid.link/r/0-v1-d3317b0ee398+50-iommu_pt_riscv_jgg@nv=
idia.com
>
> Jason Gunthorpe (5):
>   iommupt: Add the RISC-V page table format
>   iommu/riscv: Disable SADE
>   iommu/riscv: Use the generic iommu page table
>   iommu/riscv: Enable SVNAPOT support for contiguous ptes
>   iommu/riscv: Allow RISC_VIOMMU to COMPILE_TEST
>
>  drivers/iommu/generic_pt/.kunitconfig        |   1 +
>  drivers/iommu/generic_pt/Kconfig             |   9 +
>  drivers/iommu/generic_pt/fmt/Makefile        |   2 +
>  drivers/iommu/generic_pt/fmt/defs_riscv.h    |  29 ++
>  drivers/iommu/generic_pt/fmt/iommu_riscv64.c |  11 +
>  drivers/iommu/generic_pt/fmt/riscv.h         | 313 +++++++++++++++++++
>  drivers/iommu/riscv/Kconfig                  |   8 +-
>  drivers/iommu/riscv/iommu-bits.h             |   4 +-
>  drivers/iommu/riscv/iommu.c                  | 302 +++---------------
>  include/linux/generic_pt/common.h            |  16 +
>  include/linux/generic_pt/iommu.h             |  11 +
>  11 files changed, 445 insertions(+), 261 deletions(-)
>  create mode 100644 drivers/iommu/generic_pt/fmt/defs_riscv.h
>  create mode 100644 drivers/iommu/generic_pt/fmt/iommu_riscv64.c
>  create mode 100644 drivers/iommu/generic_pt/fmt/riscv.h
>
>
> base-commit: 9ace4753a5202b02191d54e9fdf7f9e3d02b85eb
> --
> 2.43.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
