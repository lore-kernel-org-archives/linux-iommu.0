Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D6E31F990
	for <iommu@lists.linux.dev>; Mon,  8 Jun 2026 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780940133; cv=pass; b=Tv7Sf7Uq7MnKwuJMIvmEP7EA7O4iVAj9JPsJ+xeOFEs4vieZ8DODy+5babHUTzS9dq9+hoQFlD4vPQb/r5Pgux0X+kh4fprHV67PMSEfrfEoM/FRfLn4mVR4D9HVCTDn04p7nyVZR87IvY1+mfI9D2wUGR3CmcmB9hCXVa8w2NQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780940133; c=relaxed/simple;
	bh=mlZU0/pgW+ejL50FpauU5Ho0DNaF5PbUOlmB72X0Aj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iXn4XEfvs9yuugPKVYCIYhmDcnalIdaJjOH74PYo2bXjFb/kIyZdl+4zkJ64gWYYM6d/71FChynjw4Jgfa/4cJ0f56mG5np1lU3IOWOotJgGZZUGuSMoib320FxhtWQXdXfGoMMwWDJPlob4MeL/vY8CIYvLFbrheYcAY1gcQLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DvTb5UH8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ej7Cwdna; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DvTb5UH8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ej7Cwdna"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658FFTad3588401
	for <iommu@lists.linux.dev>; Mon, 8 Jun 2026 17:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=mlZU0/pgW+ejL50FpauU5Ho0DNaF5PbUOlmB72X0Aj8=; b=Dv
	Tb5UH8ccM2oDsgKng2asrIeWtqzQCmYGDd08K8abr6WXPMPSilYEE+fNjH9+wLqq
	uiUYbkNN+XYso/8c9e9dTT8mmXVUzailRpo/OSWzz98UFA75e27we0p9IDj0BdB8
	gVaQ40tm+xjpCx9t0vJ4I8I8a75dO3I65N0lSm+eRB+EOX187AbT5nPd/iDYJZIf
	69+ikXT9VQ2Z/1tUQSApeDZG8Xur1SXZVeyNlGqMD8jKoLCVez+1C4PIJPtnwueK
	M6KDdDAhla51X686JX4H4W8G1VlkgYrIhj7+qG3EI++/Ik8lKqC2GaRznlKgQ+Xa
	8ar8m/oRojBK9UhbvKWQ==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enun424d1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 17:35:31 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7e87d888ca0so28226427b3.0
        for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 10:35:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780940131; cv=none;
        d=google.com; s=arc-20240605;
        b=J3UZDZtD4a56aXNN21g8m9UeZQMeo7xzAPuQL0+3MjW/uuHlAmCTnGBSvenzW0XGIN
         qdswc2UemeEUVzm1yh7KSVwy+zlLcQH1jTrBKHCluR9gLCatoxSamiT/wvWJH1M0l5d8
         BsyzEDo/FrmpWJSNcI15zVAKjnjBfEpHroLqamoQWaOhGr8Kmzp9ASgWT7n+wgx/vigK
         704pajDFi3G0d+r+sYE2F+quOi0khYvZb3x93RWayrRCc2viYwde16aPyub/jy8iP6l6
         /hDRvTddBDe3GeHDI+sOrqkqA+0qh0GNjvDSnmNb40R/tSLAFKzOCmbm5sPZ3eaTT+fU
         PGrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=mlZU0/pgW+ejL50FpauU5Ho0DNaF5PbUOlmB72X0Aj8=;
        fh=1hhnpRpzF6PQauQ/cVjHAi/ILxU8lW5lzMwNuukFVb8=;
        b=QnbuBDqVDXZRN8spxdsOgohHPsfFwCcj4Q51naB/zvHdzFrJ71GtI+pBxEtCDLia6Q
         cVyGOKXPm7bpy8mEk503d4sO7BIyIgklznjAlN4CBgmT7i0/0YRXY3kCbHZ/gRsWCLGc
         lmO2v+e/xtjUbOGLMb9gHxtQkQcLq1L7dliqvlDdZekvZrUq1MJ2KEWa9RQo7w0NTC9P
         +sumD5KQZ4MzLDvsh69BvFy0zQpEjTX2yIDs7PolcyvH/oPTsvipi2XqIR1djiigyPtN
         zamlnVbh0iF/2t0cG9DKnvZ390baNpRhuFgkpuOgQ7ywlDdVzuVzFNfGh8bqr1RvJmYQ
         rzfA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780940131; x=1781544931; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mlZU0/pgW+ejL50FpauU5Ho0DNaF5PbUOlmB72X0Aj8=;
        b=Ej7CwdnaTjX2jzqtZm4glJSn6LwoqAhp8eE0a54U1AWD2xLxfxh9Y6njZfQ2wVbqas
         ihlOv/nu3O0i2A/23tSFQqQ+TrTkLtAL3QTY2xwiretX0Hf5s3rcElao0ayoenMQeO9X
         ZeWtvaegxgIwQE/EfeCZE+nwNEmxEcp7My0U51d9TGn4SVUyz4gYlsS4w3OSNQ9TPObM
         y48t0ln+AkZ+SaF9MStRFH8KnuqRWkC1C6NfGn7t834chutn4zop9nEq2sfazNBcdb30
         5dgjmNzud5xfBJCxGwBfuYwaynjMeHVw/1AbolPHTX+YbSmQT6LBaZ62NmlAQabtf7yD
         3nfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780940131; x=1781544931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mlZU0/pgW+ejL50FpauU5Ho0DNaF5PbUOlmB72X0Aj8=;
        b=fFFXyCKE9EdcYnoshKxEjj8hm/0Z5CXvJE+H7J3NWmLaUa2//xFfW+XL0vzK3OHBJ2
         0Mwg1FENxNmmf4hUcoM3wWanCsVHaRwmnxPdzPT2gGLMIlNillklsTSFI9aWEaxnL2A/
         rRilvWaF39ElW7ZF28sG3G7CBvzm2kNClSX2BmwcWbYGwjpUiQH+l4WC1VnwbTUtI3aM
         h15qFhxddvUEYYSgzhX9bXIKpyDnV+kRNWnwpU5EPmbwNVCzmqYcf+MXWZmmmWwH3tCH
         C4swh0kWGqw3mqqVSu4vg8zQZxeySKLlKrNuPPUr9yRvcdyqjwtrQKoDEJhcGdA05gza
         BrPA==
X-Forwarded-Encrypted: i=1; AFNElJ+8ZnokZamx/S88jgEuDiNs7VFLmkQZNt1+E2pgpiXgHYRBStKtdAaQtWcmZO8b1K57q83SbQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQWH9g8mbb1gBMXssIOFlYgN1V7/S6DMvMwg2A6wdO5OgZXSrr
	e4OdD27lqUzhVSzxE9+cMZE+7SqCOHq6AZ8M+MfoysTu/0upHw9OIw3anXZ/X9BuWFtbt2iWAkn
	CKN+IAoa5MFxXeHh16gOaetqbNaHITYkqGv/obNk9ru2GfMwS/2yT+xQWGEUkFmlxldUXy55loV
	DIgwy84Mhf4KaJ/iXxoyQGWPR91hYZ4dBu
X-Gm-Gg: Acq92OEofUXqqKcWG6icdzX8JxTXbMAc+P2GIbh9hTQ5iNJhq7IEqs1Cq3tusnW90xp
	kxm7JDHPaMxCJcIiI+yhdS9tC1mQShmlZeTi6aP38d+m0vLeeZCAx7Tb+ekgd/+LjRdjDyyuMlR
	ukjXJzX6NTjbkuJkfkO/wKldZReW5NH70DPFM3m74DkgJgyM3yC3bwSJwOocaoTl6sStCo4AsOs
	JjEF8quZe8/lQqUFQ==
X-Received: by 2002:a05:690c:e3d2:b0:7dd:3f36:59d8 with SMTP id 00721157ae682-7ed0cfdfdcbmr158839327b3.13.1780940130878;
        Mon, 08 Jun 2026 10:35:30 -0700 (PDT)
X-Received: by 2002:a05:690c:e3d2:b0:7dd:3f36:59d8 with SMTP id
 00721157ae682-7ed0cfdfdcbmr158839047b3.13.1780940130520; Mon, 08 Jun 2026
 10:35:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAB19ukEzQZktJcBAXi8X2Pwz+hO_FcR+iiaK9nsCAumP9BrHnw@mail.gmail.com>
 <20260608142206426CGB5DlYd1xVlR8wrOawWH@zte.com.cn>
In-Reply-To: <20260608142206426CGB5DlYd1xVlR8wrOawWH@zte.com.cn>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 23:05:17 +0530
X-Gm-Features: AVVi8CcOHTT-aaiAsTR3LDPlyvyK1Yv-Td6vF48uAWWN7KC86YUXl0j5J289Oso
Message-ID: <CAB19ukFMu1tW5QkCOY2e=DWbKrehEDv_iO5T7vEfKEGkbTFEEw@mail.gmail.com>
Subject: Re: [PATCH] iommu/riscv: Add dependency between iommu and devices
To: wang.yechao255@zte.com.cn
Cc: linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        sunilvl@ventanamicro.com, rafael@kernel.org, lenb@kernel.org,
        pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
        alex@ghiti.fr, tomasz.jeznach@linux.dev, anup.patel@oss.qualcomm.com,
        andrew.jones@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE2NSBTYWx0ZWRfX9V2YQo43o0UZ
 njT71OzM6oyqRfTfhcl4yId1y/q92RkU8sDaEAy+yZWAJuDKmwCLU022UAagkhjLsbCxNx2oJvS
 IWtti7e9n+kbV+cbRYkLTyncOosIZlu5QUUdj/AaEdoj9JhZMjmgBIH7JyHnOFRPw78q7My2bhh
 ccD25xJg5PvEdZ1LpRxCRl5wUFuXBAEq13+Qrv/QhQt0NlRsyRtKQZdt6I0q8GFrZZucAzOY8bm
 8T7juOpL3DkMZB/ZTb62kE4Mv65w52WyiDZjeCkqn8CS4YaLSgdiAd5zCwcvKNKXXklZDJg9c+W
 cN3paWZRt1MnuRKifkNN4EEk8S305TR1AkpCyDjLGv75D7q2bnyEiGnOVs/kHhxOIarxTtYv1zD
 ZLNDERraW1/iXOf1zRLAHdF4QiEAL1mizMZqvglb7Ng+x8WeorBoiEDhRzoTxFudx1KFqskIHgi
 E784Z2/6hOnW2G7LWzQ==
X-Proofpoint-ORIG-GUID: k-_IqW-vHH0G9A0uSi41czMBicgVQ6-C
X-Authority-Analysis: v=2.4 cv=ZY4t8MVA c=1 sm=1 tr=0 ts=6a26fd63 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=1RTuLK3dAAAA:8 a=90lprICnAGeg8zAacqkA:9
 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-GUID: k-_IqW-vHH0G9A0uSi41czMBicgVQ6-C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080165

On Mon, Jun 8, 2026 at 11:52=E2=80=AFAM <wang.yechao255@zte.com.cn> wrote:
>
> > >
> > > From: Wang Yechao <wang.yechao255@zte.com.cn>
> > >
> > > Commit 9156585280f1 ("ACPI: RIMT: Add dependency between iommu and
> > > devices") adds the dependency between iommu and devices on ACPI
> > > systems. On devicetree systems, the incorrect removal order also
> > > occurs.
> > >
> > Interesting. Why is it not handled by the fw_devlink infrastructure in =
DT?
> >
> > Thanks,
> > Sunil
>
> Thank you. I have noticed that commit e149573b2f84 ("of: property: Add de=
vice
> link support for "iommu-map"") adds support for "iommu-map" to the device=
 link
> supplier bindings, so that probing of PCI devices can be deferred until a=
fter
> the IOMMU is available.
>
> The QEMU RISC-V virt machine currently lacks the "iommu-map" property for=
 the
> PCIe bus when the iommu-pci device is used, which leads to this issue. Th=
erefore,
> I believe the correct fix is to add the "iommu-map" property for PCIe in =
QEMU.
>
For PCI IOMMU, the dependency should be automatically taken care since iomm=
u
should always be the first device in the hierarchy and scanned first.
