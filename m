Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C5E392822
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 07:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779263171; cv=pass; b=YHmr1nUdEzbGOy6RJGXkjRh7vm8VwA6eOI4Wzf2vpOYkP30y7J0AtiiUnVVtEolTlNk6JrI+SCGf4D0oyTFICHIuB1NkIe5nxz906Uho46Z214abRxjpKjEHXKtNnBB4xaQfRCsVfTr5GN5CnuN9bBpt3qACSCtAab5r2ZcUrGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779263171; c=relaxed/simple;
	bh=OQUTRvFUZHF1+ez+E6OC/Qi0rCOaZboe79Rv2x3CNgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Giw3QASHoZ5Tv2TuWRGPRR6JpNGpsDKAudmz0h5EwBlhlt1CB4gMBjRZ0Y6eglNAbzQB0xikCn8oGNqw6j81bnJGtHWCtFnK/GCU9kW8ywf6C9KxTz3wYPd4e5obCi5XAK4kT1EqAJ3BAvm6QjpfEeVnbFsZd15kCJeJbQFmFdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QglqAxWl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZSkOdsDD; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QglqAxWl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZSkOdsDD"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K7Wn5l1953980
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 07:46:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=O+neZlhZoIPG55qPIJ1F9Q1q+0lcFRe0NrLx1x9e9Mg=; b=Qg
	lqAxWl9zlp/BXEt0wTEfUDjLvrekKb2KieQ32ophaZyfi7NEXkme9yKlOeCH2Ccw
	G735FLq3/syCLVTnv2EEC2klCo95mG6MAsB9wROl7rU6lcrwkhuUwFIbjLwm8hYV
	gf34/KriAyhL/RiG6hB0HLhKfKC4WK/+4Etq2eAgy9+Y7oljqKXoUailAc+73beN
	cykXPUTonfgzRFMOCc88TKM6c9TYSHDU1GoXC/nSBEx6pd7+EwZaufKJPb5nUVtg
	NpMtK5gyO7GBZqFqcilheHyIIyoxLSV4AZqOIxeNNI6Cc9N4qfVSiCfY0B0eOefR
	I7MW2+8a1PwppNOWiL/A==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3xumwf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 07:46:09 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8c9e99fcd15so143713426d6.0
        for <iommu@lists.linux.dev>; Wed, 20 May 2026 00:46:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779263168; cv=none;
        d=google.com; s=arc-20240605;
        b=SfTlhe517MiTw1mo1Ab49AlPbNNZQ+faS66uwTk7R47hJ5QRY1+GsT07V7EDy03yG3
         JGD3kjVVqPQh15ExbJE1e2x94h8J/CgKMUf33gdFP0mej6j3tF6lFYmJDrsqwCiAG8fM
         ZQL9+VV6QLZjxQBxvTEvxhLhBQ4e7D1/83DglmBTK4H0jJdlieW6rYM/TLXE23HPVSTn
         JnpgykHOfHe+dCYYHaZmcUjpRwHhjSUV8j1GQ3mQOTlwabpssjV+71ZOZD9rGO4BZv5G
         YeA4XqHnTIj5arIz7H6ZxQl9+INVxUlLf3NvFRu8VO4IPOXiAgVRlF9ZCt8FabD6ka8w
         Z3TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=O+neZlhZoIPG55qPIJ1F9Q1q+0lcFRe0NrLx1x9e9Mg=;
        fh=HaB2xla1KrJkzBwZqeWlIDGgJG0hK4tdhxKxNfqtt04=;
        b=YO7qXh9PuDUn6zRxEB87K5872SfO9Tcr/iol2wn9eVEOOfMVHJiduE5wblB9+6CcIp
         rB8JlkE9xitS1wfCHcQCC3UcEuJTgcBftikV+zbmvUtflg+WSjIXMJ2U8ijO2jI07u6V
         cJ5eHxdCN1ZhdVw/F4P7+N+khvw/1Ad4b2h8YXi4fZMBDbJmAxbyl6bUNuc8BUcb9srR
         2ieygrM4+5QO5uQh59s94V39owtLjG2XtgdyTZHhDLn3HNHLMJE3hq3di5PZUnmQLyTX
         848ezNgLvJQ3UhnGhdD3P0W8ZecbED6TNpwY9DwQ8Mq3Oaui7zrM2BH6RVhDOhNnjnQt
         T4wA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779263168; x=1779867968; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O+neZlhZoIPG55qPIJ1F9Q1q+0lcFRe0NrLx1x9e9Mg=;
        b=ZSkOdsDDCDIWI2ZRidC8/GyRtyIlUNiUxQtLbpOhneOQuWR37M5dUfKusr5cfZDb/M
         ZTzQ4vfDlVmeWy3gVmeCAfk5YkeQnk995mwihowgbm15WPHcnTHvepT1NEgU19gcHDQU
         heu1JM8Z5DE9z984Aq6HQ9kuUNTMsoLiFfbztqWdUg/bODrgAe5vs8MLH0C5S0NWVTLQ
         MpoIQ5Ho03mRqtOGZe/YH2t1Xbg60IlwSnYoxkH2L/CorY30bt9S62aM4xozvQtSWkRg
         fiCOdIi+u/FuyY0uWkOM7gBpDvvgM7AhlK+6lgvsjLSgQAo/TYmR+1TC1KBMu7b/O4C5
         /ogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779263168; x=1779867968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O+neZlhZoIPG55qPIJ1F9Q1q+0lcFRe0NrLx1x9e9Mg=;
        b=lGJQVxMGC4AeqpbaoJ/u/yqCHeBnAqSksP15KU6mCP6ofdELcmqVvUevBf54LqoGO0
         2ipkKjyfSV/6QUbCxhDT8592NA/dMU7sfWSOnBS/aVvvWrqzUw1zBbP/xH9lIWe716bQ
         hpnU59RQibxA+mjYoN03qbwav3bHwBL5Q5EJvi3weaSoQbGp4qbpEja2IwEKtEBIpyIt
         jNOCavoaQydv7V1XBgp1ifwY5LRqPRF/0wvh7LW+m2r0hky/i7jl6Lx+yZKEGzMTe7in
         6OR453lwpa8LM6MAhA5h0qLFftj6QfnOA+NB/4GJ3+Jo8SyeCey/KtwQP1vxfj3f2to8
         asNw==
X-Forwarded-Encrypted: i=1; AFNElJ+8tOz/r6INuSL1roCWsP2hzSNytOSQzW5qNribnsU/Kh4OeEPK9LljfqaEefMS8folf6UiQA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzcTbmVBEnJlkjtjYvVO0HCq1xwuVOChsA9Ia15p2/4Mv8rFxuh
	zmtiIEthhrpXiVaYEX6Sx0/7w5yb1S2lbvVF7q7kkcptFIHssyIu0LOg+DkXcTjlNIMN/5PmR7g
	7lmwUqRp8s9whH6O27wkhFYrBozA9RrUXR4zl3eD0WrriXc7YtAKfrac8n2Sj7fUB0kxU/SHjMo
	Waj1eUb/rVK5Y8t2CuTTW0Bo9aSinviKkM63Qc/45a
X-Gm-Gg: Acq92OGpqds8Ln7+U5hTNkZi/fWnH3BScA+5Ss1lcXPwof2T8nKgEDFU016ZD/TRY1b
	Ky7jjMbRCoGL9pgacQaXe0QAH4/suMMIFL97CI7OAY9eBUZezhtv7IKhL1sNbnuJe5dd3ZVBxOK
	69sSzKTvcidq2DGz+qsrdhxnBZGvjOUAfdLvqsxZ+J8rnZrsvuIIVv5PAAfREyhvRED8SGwj3ah
	Rk8uGs=
X-Received: by 2002:a05:6214:5b0d:b0:8ca:25e6:e892 with SMTP id 6a1803df08f44-8ca25e6e8bbmr269085746d6.2.1779263167789;
        Wed, 20 May 2026 00:46:07 -0700 (PDT)
X-Received: by 2002:a05:6214:5b0d:b0:8ca:25e6:e892 with SMTP id
 6a1803df08f44-8ca25e6e8bbmr269085396d6.2.1779263167340; Wed, 20 May 2026
 00:46:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260519125716.81594-1-fangyu.yu@linux.alibaba.com>
In-Reply-To: <20260519125716.81594-1-fangyu.yu@linux.alibaba.com>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Wed, 20 May 2026 13:15:56 +0530
X-Gm-Features: AVHnY4Lgw6DV5LpnwFbar1eFNvQ3Rqpaj6_FwIN8ELASJvNY0Bf-7-jKrWD2V6Q
Message-ID: <CAB19ukGk2AUA3yjsrBxjsUsH9pUSeeu5F6vo1FFBcd504VQPzg@mail.gmail.com>
Subject: Re: [PATCH] iommu/riscv: prefer WSI on IGS=BOTH when wired IRQs are described
To: fangyu.yu@linux.alibaba.com
Cc: tomasz.jeznach@linux.dev, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, alex@ghiti.fr, ajones@ventanamicro.com,
        andrew.jones@oss.qualcomm.com, guoren@kernel.org,
        iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=WaY8rUhX c=1 sm=1 tr=0 ts=6a0d66c1 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=SRrdq9N9AAAA:8 a=RxsSgplYz4Zavn4rlPAA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: enUBfYJikt_nm_D5QZFV0iQ30pX_HLOu
X-Proofpoint-ORIG-GUID: enUBfYJikt_nm_D5QZFV0iQ30pX_HLOu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA3MyBTYWx0ZWRfX4LKENpYwl9VU
 9mxHq3emzVAm5Kb7lvI6fRC9MjK/zKv9RnAVa/PsU8MrUvyIfaHaAp6eX0m7FYe+UHyWnXFHs5m
 kLv483xhxs+30Dy+AR/o9WP4uZ+Fg+2MopuzK+iHDGWYhbQE/C5LZK5N8sjs98Q5qQrQmQrdvCN
 ij5klQqZi4GfpOJv6nL8ew8afB0t25LFI5DA66MlYCMZ9Gp0YAzF21Cb8SAH11SwAttuZ4lTxs0
 maRS18G8Te/BpEXJ5crDUno9Eg2f/TWEY8H5Y0lChxyMtaWMBVTpFHcdnCM4TSKMNa8xuGXy8gD
 E6NwtRNzrdEE8CC5OMXO+FVHK7vg2nud6LUvOoRcnRV5MqumKgAepu2Vge9JXqIMwXA2xGK7l7B
 A2UJTH7UAJ9MPhaaCXKk5djWEEwoEiZ7Mrk/2hj+LB/GB8GasPk8UlKywa/vAaJysuX4S1TRpdu
 bDN+A3RTvTeX96tVGZw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1011 impostorscore=0 spamscore=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200073

On Tue, May 19, 2026 at 6:28=E2=80=AFPM <fangyu.yu@linux.alibaba.com> wrote=
:
>
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>
> The RISC-V IOMMU spec defines IGS=3DBOTH as supporting both MSI and
> WSI, with software selecting the path. The DT path already behaves
> as expected by selecting WSI when wired IRQ resources are described.
> The ACPI path, however, currently falls back to MSI even when
> firmware describes wired IRQ resources.
>
> Use firmware-described wired IRQ resources as the trigger to select
> WSI for IGS=3DBOTH:
>   - DT: "interrupts" present, no "msi-parent"
>   - ACPI: DSDT _CRS Interrupt() descriptors
>     (mainline does not yet parse the RIMT Interrupt Wire Array)
>
> When triggered, rewrite igs to IGS_WSI and reuse the existing WSI
> handling. Keep the existing behaviour otherwise.
>
> Fixes: d5f88acdd6ff ("iommu/riscv: Add support for platform msi")
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> ---
>  drivers/iommu/riscv/iommu-platform.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv/i=
ommu-platform.c
> index 399ba8fe1b3e..bd7712231140 100644
> --- a/drivers/iommu/riscv/iommu-platform.c
> +++ b/drivers/iommu/riscv/iommu-platform.c
> @@ -71,6 +71,21 @@ static int riscv_iommu_platform_probe(struct platform_=
device *pdev)
>         iommu->irqs_count =3D RISCV_IOMMU_INTR_COUNT;
>
>         igs =3D FIELD_GET(RISCV_IOMMU_CAPABILITIES_IGS, iommu->caps);
> +
> +       /*
> +        * IGS=3DBOTH means the IOMMU supports either MSI or WSI;
> +        * the spec leaves the choice to software. Use the firmware-descr=
ibed
> +        * wired interrupt resources as the trigger:
> +        *   - DT  : "interrupts" property present, no "msi-parent"  -> W=
SI
> +        *   - ACPI: DSDT _CRS Interrupt() present  -> WSI
> +        * Otherwise default to the MSI path.
> +        */
> +       if (igs =3D=3D RISCV_IOMMU_CAPABILITIES_IGS_BOTH &&
> +           platform_irq_count(pdev) > 0) {
> +               dev_info(dev, "firmware describes wired IRQs; preferring =
WSI on IGS=3DBOTH\n");
> +               igs =3D RISCV_IOMMU_CAPABILITIES_IGS_WSI;
> +       }
> +
Won't it change the DT behavior as it doesn't check msi-parent
anymore?  IOW, should this be made specific to ACPI
by checking whether the device node is acpi node?

Thanks,
Sunil
