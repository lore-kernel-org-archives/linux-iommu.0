Received: from sg-1-31.ptr.blmpb.com (sg-1-31.ptr.blmpb.com [118.26.132.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318991F2B8D
	for <iommu@lists.linux.dev>; Wed, 28 Jan 2026 02:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769567079; cv=none; b=Y551fx4i3xpFxp5wYxMiB89NwDcRVpGKrbsKu82ZtAMci2j1vXFvgxyA2t7tn4kH3rFVoH+b0uM2opsiteSYqZts8jW4i0y+DxS4p4h1VU3AOvAiLcHiXhIOetVFqHftoH/uucrX4jOJEgTS5h6mEE691ZPXDwPGWFtPvPBey6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769567079; c=relaxed/simple;
	bh=YH9GyowoNZADKncya9LuKun3Zt1L8c7msQs246DI0GA=;
	h=Cc:Mime-Version:To:Message-Id:Subject:Date:Content-Type:From; b=VPUkS5O/4HEHwS18IBvbB6OFXgUmi0BIhqGbQRs0uz+BNsMVpSLWl80ToQJhac0+CaYT4jg1WtWdbv5d0Xzxcg3kE8n2cG6TsmpfmgGskW6hs+Dm6FE6iQDbvM//3sud8gYyzul8TUgsgWF4Y593YA/toAOfq3HjVkKG7tdYy+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=spacemit.com; spf=pass smtp.mailfrom=spacemit.com; dkim=pass (2048-bit key) header.d=spacemit.com header.i=@spacemit.com header.b=Zhlfswd0; arc=none smtp.client-ip=118.26.132.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spacemit.com header.i=@spacemit.com header.b="Zhlfswd0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303021642; d=spacemit.com; t=1769567064; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=xEIU4lj1xUbCqVlkRRJBSbUjjv82goMTRsTxJcyFGKw=;
 b=Zhlfswd0XkD3wunpk+2iGAcm5TIWSBSHi8apbrBOvyxMqyqsI6i15f6uC1FQCgd+JXM/5i
 NKp8dpK1GSKW/0wj7EMhvhBKx9iffHgF0zi6iw93OZt5p906ONczMS9K34UqklX7U3LgXV
 tvMMWZNkawMk9yOe3FV40hAIZuyUef49XE55aky82gFClxDaMmGFsLbEEXVrF9M+BQjBIs
 OlnZsYOiJLTilBH0J/nkLT1VsMTkyekMeGQms064mazRiQnnHy72DfRtotBqz99tAYcZRJ
 0NCcN84qtTibTcahdUXUEq2waib+2QfKW2LKUDjAkUNh5BiLV7NjBhPcdJf43Q==
Cc: "Jingyu Li" <joey.li@spacemit.com>, "Lv Zheng" <lv.zheng@spacemit.com>, 
	"Zhijian Chen" <zhijian@spacemit.com>, <iommu@lists.linux.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: "Robin Murphy" <robin.murphy@arm.com>, 
	"Tomasz Jeznach" <tjeznach@rivosinc.com>
Message-Id: <cover.1769562575.git.lv.zheng@spacemit.com>
X-Lms-Return-Path: <lba+269797356+987c9c+lists.linux.dev+lv.zheng@spacemit.com>
X-Mailer: git-send-email 2.43.0
X-Original-From: Lv Zheng <lv.zheng@spacemit.com>
Subject: [PATCH 0/6] iommu/riscv: Add HPM support for RISC-V IOMMU
Date: Wed, 28 Jan 2026 10:24:16 +0800
Content-Type: text/plain; charset=UTF-8
From: "Lv Zheng" <lv.zheng@spacemit.com>
Received: from SurfaceBook2-B.localdomain ([122.224.183.70]) by smtp.feishu.cn with ESMTPS; Wed, 28 Jan 2026 10:24:22 +0800

This patchset adds HPM support for RISC-V IOMMU. The HPM support can be
found in recent announced SpacemiT SoCs (K3), where T100 (SpacemiT
distributed IOMMU) is shipped.=20

The tested result can be found as follows:

 root@sdfirm:~# perf stat --timeout 5000 -a -e riscv_iommu_hpm_0/device-dir=
ectory-walks,config1=3D0x20c0010000000000/ dmatest; sleep 1
 [  176.025295] event_source riscv_iommu_hpm_0: Setting event filter: 20c00=
10000000005, PID PSCID: 0x0, DID GSCID: 0xc0010, PV PSCV: 0x0, DV GSCV: 0x1=
, IDT: 0x0, DMASK: 0x0, Index: 0
 [  176.110211] dmatest: Started 1 threads using dma0chan0
 [  176.114933] dmatest: dma0chan0-copy0: summary 1 tests, 0 failures 394.9=
4 iops 394 KB/s (0)
=20
  Performance counter stats for 'system wide':
=20
                  3      riscv_iommu_hpm_0/device-directory-walks,config1=
=3D0x20c0010000000000/                                  =20
=20
        0.081056000 seconds time elapsed
=20
 root@sdfirm:~# perf stat --timeout 5000 -a -e riscv_iommu_hpm_0/first-stag=
e-page-table-walks,config1=3D0x20c0010000000000/ dmatest; sleep 1
 [   68.050220] event_source riscv_iommu_hpm_0: Setting event filter: 20c00=
10000000007, PID PSCID: 0x0, DID GSCID: 0xc0010, PV PSCV: 0x0, DV GSCV: 0x1=
, IDT: 0x0, DMASK: 0x0, Index: 0
 [   68.152992] dmatest: Started 1 threads using dma0chan0
 [   68.158071] dmatest: dma0chan0-copy0: summary 1 tests, 0 failures 401.9=
2 iops 401 KB/s (0)
=20
  Performance counter stats for 'system wide':
=20
                  6      riscv_iommu_hpm_0/first-stage-page-table-walks,con=
fig1=3D0x20c0010000000000/                                  =20
=20
        0.083192000 seconds time elapsed

Jingyu Li (3):
  iommu/riscv: Enable IOMMU DMA mapping support
  iommu/riscv: Fix WSI mode IRQ number handling
  iommu/riscv: Add HPM support for performance monitoring

Lv Zheng (3):
  spacemit/t100: Add vendor event support for RISC-V IOMMU HPM
  spacemit/t100: Add global filter support for RISC-V IOMMU HPM
  spacemit/t100: Add SpacemiT T100 IOATC HPM support

 .../bindings/iommu/riscv,iommu.yaml           |    6 +
 drivers/iommu/Kconfig                         |    2 +-
 drivers/iommu/riscv/Kconfig                   |    9 +
 drivers/iommu/riscv/Makefile                  |    1 +
 drivers/iommu/riscv/iommu-bits.h              |   19 +-
 drivers/iommu/riscv/iommu-hpm.c               | 1141 +++++++++++++++++
 drivers/iommu/riscv/iommu-pci.c               |   13 +-
 drivers/iommu/riscv/iommu-platform.c          |   12 +-
 drivers/iommu/riscv/iommu.c                   |   25 +-
 drivers/iommu/riscv/iommu.h                   |   44 +-
 10 files changed, 1259 insertions(+), 13 deletions(-)
 create mode 100644 drivers/iommu/riscv/iommu-hpm.c

--=20
2.43.0

This message and any attachment are confidential and may be privileged or o=
therwise protected from disclosure. If you are not an intended recipient of=
 this message, please delete it and any attachment from your system and not=
ify the sender immediately by reply e-mail. Unintended recipients should no=
t use, copy, disclose or take any action based on this message or any infor=
mation contained in this message. Emails cannot be guaranteed to be secure =
or error free as they can be intercepted, amended, lost or destroyed, and y=
ou should take full responsibility for security checking.=20
=20
=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E4=BB=BB=E4=BD=95=E9=99=84=E4=
=BB=B6=E5=85=B7=E6=9C=89=E4=BF=9D=E5=AF=86=E6=80=A7=E8=B4=A8=EF=BC=8C=E5=B9=
=B6=E5=8F=AF=E8=83=BD=E5=8F=97=E5=85=B6=E4=BB=96=E4=BF=9D=E6=8A=A4=E6=88=96=
=E4=B8=8D=E5=85=81=E8=AE=B8=E8=A2=AB=E6=8A=AB=E9=9C=B2=E7=BB=99=E7=AC=AC=E4=
=B8=89=E6=96=B9=E3=80=82=E5=A6=82=E9=98=81=E4=B8=8B=E8=AF=AF=E6=94=B6=E5=88=
=B0=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E6=95=AC=E8=AF=B7=E7=AB=8B=E5=8D=B3=
=E4=BB=A5=E5=9B=9E=E5=A4=8D=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E7=9A=84=E6=
=96=B9=E5=BC=8F=E9=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=8C=E5=B9=
=B6=E5=B0=86=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E4=BB=BB=E4=BD=95=
=E9=99=84=E4=BB=B6=E4=BB=8E=E9=98=81=E4=B8=8B=E7=B3=BB=E7=BB=9F=E4=B8=AD=E4=
=BA=88=E4=BB=A5=E5=88=A0=E9=99=A4=E3=80=82=E5=A6=82=E9=98=81=E4=B8=8B=E5=B9=
=B6=E9=9D=9E=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=86=99=E6=98=8E=E4=B9=8B=E6=94=B6=
=E4=BB=B6=E4=BA=BA=EF=BC=8C=E6=95=AC=E8=AF=B7=E5=88=87=E5=8B=BF=E4=BD=BF=E7=
=94=A8=E3=80=81=E5=A4=8D=E5=88=B6=E3=80=81=E6=8A=AB=E9=9C=B2=E6=9C=AC=E9=82=
=AE=E4=BB=B6=E6=88=96=E5=85=B6=E4=BB=BB=E4=BD=95=E5=86=85=E5=AE=B9=EF=BC=8C=
=E4=BA=A6=E8=AF=B7=E5=88=87=E5=8B=BF=E4=BE=9D=E6=9C=AC=E9=82=AE=E4=BB=B6=E6=
=88=96=E5=85=B6=E4=BB=BB=E4=BD=95=E5=86=85=E5=AE=B9=E8=80=8C=E9=87=87=E5=8F=
=96=E4=BB=BB=E4=BD=95=E8=A1=8C=E5=8A=A8=E3=80=82=E7=94=B5=E5=AD=90=E9=82=AE=
=E4=BB=B6=E6=97=A0=E6=B3=95=E4=BF=9D=E8=AF=81=E6=98=AF=E4=B8=80=E7=A7=8D=E5=
=AE=89=E5=85=A8=E5=92=8C=E4=B8=8D=E4=BC=9A=E5=87=BA=E7=8E=B0=E4=BB=BB=E4=BD=
=95=E5=B7=AE=E9=94=99=E7=9A=84=E9=80=9A=E4=BF=A1=E6=96=B9=E5=BC=8F=EF=BC=8C=
=E5=8F=AF=E8=83=BD=E4=BC=9A=E8=A2=AB=E6=8B=A6=E6=88=AA=E3=80=81=E4=BF=AE=E6=
=94=B9=E3=80=81=E4=B8=A2=E5=A4=B1=E6=88=96=E6=8D=9F=E5=9D=8F=EF=BC=8C=E6=94=
=B6=E4=BB=B6=E4=BA=BA=E9=9C=80=E8=87=AA=E8=A1=8C=E8=B4=9F=E8=B4=A3=E5=81=9A=
=E5=A5=BD=E5=AE=89=E5=85=A8=E6=A3=80=E6=9F=A5=E3=80=82
