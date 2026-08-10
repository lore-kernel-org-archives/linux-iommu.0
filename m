Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071C83B7B98
	for <iommu@lists.linux.dev>; Mon, 10 Aug 2026 10:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786356986; cv=none; b=rmwC9r6roRdLAXBMGP3IOoQ9uYIZxOXa+T2p24fIAwdgBdW11ytPSGOyfL3bGlP6ivFY/sBKkKEffAYEHiNMLutf9cHrrk5DDRCfYVipke9dbMmMNHapxEr3gjL+tLXZgc2V4BLjJdThHVI7henmLUJcz9fep7fNThzOs8rXQm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786356986; c=relaxed/simple;
	bh=6/f9wmm2awoewJ0RJjhCNb25rGgSGL053o6mzKpTT4M=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=IJ+GdUQdbgG9BfqcIIiuxBW1DJ8S0eNPQtt8yf+BAFbg1YPNeBaoqlzsIhYjomfRhWzP22DGcSxboOIzQokie906iKu4nqdJlVh7u8IQCqd4pJ5Gku0Kvt91V5Oi/Kwl2HSC97RmKUkf5Z8W7ovZLFatZC8JmwDdJtSvMC5lZv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=qToVQxf9; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="qToVQxf9"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c169ae1cb26so766577666b.1
        for <iommu@lists.linux.dev>; Mon, 10 Aug 2026 03:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1786356981; x=1786961781; darn=lists.linux.dev;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0DdJ1gMHWzOjplPr4v+9JtrcaHIdGLk0WTVEXhfhPJg=;
        b=qToVQxf9XyFGph6HUNeufKzoA/Yz0tGLeHsrCeGy8MlthNV6YQWCUo/NN3KO0R9HAg
         2vgDNbhg+JB6sQ3xzWxPSOGV3aqeynwYCn3sDI1QbcFXuzo5/CqV/aw6ktP3IdX3/Ey+
         Wsy4TmIXmLsRGAESsMO6pCkLH88JuweL1uJKAWfPljw4fq7RKUWeSsFNOe1CrMW+oQLl
         IWbfy+Urz4MwpuC+Nze0M/e64EIGjc+SFsse4kUagfBYRaiEB/1Y09/KMLTh8wiFxlLh
         LPWq/5BS6UDYGIvp2CWhCuqwr5yGQld3DrKcTizoofXwUBcF1vxrX87bO9BSlPb+QPUW
         uOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786356981; x=1786961781;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0DdJ1gMHWzOjplPr4v+9JtrcaHIdGLk0WTVEXhfhPJg=;
        b=blkrQv07SAfqfyIN7/lTduRk3+c8BkI9H7F4ssj5SeCBoeyhSvUWtr4XhQ8GmnH9gX
         YV6G5frISh6/BiYJt84Aj8iSIy83ZatqKoG5vY5bROcqusu1nMbg1s9VpzQ5zT8rrz0y
         QRKK7oJuhJpaQjKNYEu2sy+H9cUO5c4e/RjBflZysUvjwayuHdNwKhQRLOCr9efxXpb/
         h0V/fnlbOAQ3hJ1N3nreLFBnfmFKITb3qkIXypqx/1HZVzqVSEUw82ZDDCSfRpxAp+HO
         fLOr1fiBNbx/eiVHGgtEL0LzFh2/n/+nVMnxFBbW2uPR7CRR+DjGA+R8S/lwZSOThaLT
         EVEA==
X-Forwarded-Encrypted: i=1; AHgh+Roz3ohC0XEgE160TlEAbMUNzoDd/PJqb3ca1TXlFoy8TSR47BrwulE4x+sBFW7RN+KqMPmGkg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzmLu7pCeLg8R3Ykc9IHawuIomZFbawtuoUZhSG8tujWLbuouaz
	0rZO6mVqF3QLdqZrFTQRaUndT8PCmgKx7T9CuyjOoXYOPVqrz/DQddParYwHpM8AiHVgbjNCxBK
	l++ZXZ1o=
X-Gm-Gg: AR+sD12RKyGRSj7zitNwFEiTtPI1k+r/JkaPDh2D46FJHYWICUuREbDvPSmkShKhaVb
	ugeUjwn4iN0vd0s7oUg6Hz7ekj5Rj6+wfcQmZRV3WsK0IaFT6lrupSCdRn6nMsBCFmxJtHi/w+K
	MMZmFUwBhojyaISy1JzAJTypHHBBF2i2/1QUk2RLw27oeIXUuDEajuiU23euoGpJNMm3Y/a9mpS
	I1RgsHF2SRbkWIqoFef8heMceS73NqgpjYy3acxrTsRvr30wq2DeUywbnmBspFvSyNo7+Y4kisU
	9hi4shLWk+HL2U9+Md8UCr2rgCabKlljWk95BdsIEOZdOPApso9/QT2O0h37tm+Uf7SALKuMIaQ
	qvnHCGcsNihay74y2e3HWeiLeHj8R+jH6izBC9RJOlrMQNZYnZZk1eq9kkWx4pajBRpbCg7v6sm
	VJomNZVQP6qDg3PYSLPNfkp0dcsJjhOnSNFsE8BeHvGNb5SUjbYHzpaKpFCEkQuG1QGT/tdDSbF
	OmR4pSI09DB2KFZQsIO4ouVqEZaP9G0vQ==
X-Received: by 2002:a17:907:94cc:b0:c1c:6d29:8a11 with SMTP id a640c23a62f3a-c208d3ec3cdmr919652366b.13.1786356981152;
        Mon, 10 Aug 2026 03:16:21 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080a29a33sm357250966b.2.2026.08.10.03.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 03:16:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Aug 2026 12:16:19 +0200
Message-Id: <DKL6P7G0WTM7.UJ6KZERQZDFK@fairphone.com>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Joerg Roedel
 (AMD)" <joro@8bytes.org>, "Will Deacon" <will@kernel.org>, "Robin Murphy"
 <robin.murphy@arm.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Konrad Dybcio" <konradybcio@kernel.org>, "Rob Clark"
 <robin.clark@oss.qualcomm.com>, "Bjorn Andersson" <andersson@kernel.org>,
 "Luca Weiss" <luca.weiss@fairphone.com>
Cc: <linux-arm-msm@vger.kernel.org>, <iommu@lists.linux.dev>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 00/12] iommu: qcom_iommu: implement support for
 instances on MSM8974
From: "Luca Weiss" <luca.weiss@fairphone.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260809-msm8974-iommu-upstream-v1-0-87f5cd492560@oss.qualcomm.com>
In-Reply-To: <20260809-msm8974-iommu-upstream-v1-0-87f5cd492560@oss.qualcomm.com>

Hi Dmitry,

Many thanks for working on this and sending this patch series!

On Sun Aug 9, 2026 at 10:15 PM CEST, Dmitry Baryshkov wrote:
> Qualcomm MSM8974 platform has five SMMU instances, used by display, GPU,
> Venus, VFE (camera) and JPEG encoder. Each of them follows ARM SMMU v1
> spec, however they differ from other Qualcomm platforms in the
> implementation-specific registers and also in interaction with TZ.
> Venus, MDP and VFE SMMUs are secured and require programming only of
> CBs, while GPU and JPEG require full programming.
>
> This series skips IOMMUs which can't be tested right now (VFE and JPEG),
> and adds only MDP, GPU and Venus (although untested, it is required for
> display to work) SMMU instances.

I do have a patch series (sent years ago to the mailing lists as well)
for CAMSS so I can definitely test this in the future.

>
> Note, to get display to work properly one fix is necessary, [1]
>
> [1] https://patch.msgid.link/20260809-msm8974-mmcc-fix-v1-1-50f2dcf18d2e@=
oss.qualcomm.com

I've applied this series on v7.2-rc7, with the extra commits between
that and linux-next for qcom_iommu.c backported so that your series
applies without conflicts.

So far I'm stuck with the GPU not being able to probe, adding some
printk's shows that in msm_iommu_new() the call for
iommu_attach_device() is failing.

[    5.971154] msm_mdp fd900100.display-controller: failed to load adreno g=
pu
[    5.972991] msm_mdp fd900100.display-controller: failed to bind fdb00000=
.gpu (ops a3xx_ops [msm]): -16
[    5.974073] msm_mdp fd900100.display-controller: adev bind failed: -16
[    5.974152] panel-s6d6fa1 fd922800.dsi.0: error -EBUSY: Failed to attach=
 to DSI host
[    5.974230] panel-s6d6fa1 fd922800.dsi.0: probe with driver panel-s6d6fa=
1 failed with error -16

~ # dmesg | grep iommu
[    0.127014] iommu: Default domain type: Translated
[    0.127052] iommu: DMA domain TLB invalidation policy: strict mode
[    0.739899] platform fdb00000.gpu: Adding to iommu group 0
[    0.741358] qcom-iommu fdc84000.iommu: iommu sec: pgtable size: 90112
[    6.006877] platform fd900100.display-controller: Adding to iommu group =
1

Have you seen any issues like this?

Regards
Luca

>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
> Dmitry Baryshkov (12):
>       dt-bindings: iommu: qcom,iommu: document the MSM8974 IOMMUs
>       iommu: arm-smmu: add global register definitions used by the QSMMU
>       iommu: qcom_iommu: extract context bank programming into a helper
>       iommu: qcom_iommu: support the short-descriptor pagetable format
>       iommu: qcom_iommu: handle the SMMU global register space
>       iommu: qcom_iommu: support non-TZ-managed instances
>       iommu: qcom_iommu: restore context bank state after power collapse
>       iommu: qcom_iommu: halt the micro-MMU while programming context ban=
ks
>       iommu: qcom_iommu: allow faulting transactions to terminate
>       iommu: qcom_iommu: program BFP (prefetch) settings
>       iommu: qcom_iommu: add the MSM8974 instances
>       ARM: dts: qcom: msm8974: add the IOMMUs
>
>  .../devicetree/bindings/iommu/qcom,iommu.yaml      |  16 +-
>  arch/arm/boot/dts/qcom/qcom-msm8974.dtsi           |  85 +++-
>  drivers/iommu/arm/Kconfig                          |   1 +
>  drivers/iommu/arm/arm-smmu/arm-smmu.h              |  10 +
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c            | 445 +++++++++++++++=
++++--
>  5 files changed, 517 insertions(+), 40 deletions(-)
> ---
> base-commit: 6c5c106bff878247a9cc7255077aab9040df8bf8
> change-id: 20260809-msm8974-iommu-upstream-144b1e2a15f0
>
> Best regards,
> -- =20
> With best wishes
> Dmitry

