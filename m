Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D707A4BCAC7
	for <iommu@lists.linux.dev>; Fri,  5 Jun 2026 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780650222; cv=pass; b=sZgFGYg18B3RzCb09HokAe2KuyZPXOK1nBCJMTHz68EDVeJ+WqI+PwccC2GYgWqnH3t1tvuzSiB2sWF4JtkOvgTgatlYZhfJSJE8HAmu8bm4S0PoXx6VafzGDj4VG4rwvcRDRBmy6Et1Jt/Pa+0Kcpcj02tnpPcfmSkPnNcGrbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780650222; c=relaxed/simple;
	bh=JNGNA9KfLEu6lKiLq/bw2EyVuHECatldL352HW3O3Jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lHFfYBJ8wviQcldG0o7S/5VQDGKf4MgWedOd0e7qwN2Mv32gXSYn6ae28EdnsuNObW9MbsEx+KarrxsAhX5JpjsIco8apOWBCj5J68fru+DiEjpVRnTbQjLFvNIwGOgQxyVJp2e0bSiPDPvYh7PxiX+9ACR3RWxFEwMMP2voxNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=msYyxjAa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Nthb6BU7; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="msYyxjAa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Nthb6BU7"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6557ail3528633
	for <iommu@lists.linux.dev>; Fri, 5 Jun 2026 09:03:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=JNGNA9KfLEu6lKiLq/bw2EyVuHECatldL352HW3O3Jk=; b=ms
	YyxjAa60BJo83GWoLx+DOyn9oy4FanODdWgC5P/uXkr+Py13w0W5PZJp6/7VKqP4
	RTzgJJ0UBiekRROIJcIPKAJLBQc4rMhN5pQxuXpXx3FvCKMjOPC9CmeLJqwKNUYF
	qJ1zIC5MBfEAvZ0ixzx5KA7JSWx0ktay1po+N/G7KV5V3CY0Z1GSY206LLQE0rnD
	JBPN3LL5eURVso7RC+I3B3aSFv9di7sajhccj4cTGNcQOYPrY1grz/aue6Cil3Ab
	mr419w+e/umHWh+LrPw4NbNWh8nrAncrjfgsCUdDfKA9fbXn/379GbqZeGRxO2wF
	E5mAx6F2P/qWrtaQ3nDQ==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ekbgdv6ru-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 05 Jun 2026 09:03:37 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7dcd01ca614so33387327b3.0
        for <iommu@lists.linux.dev>; Fri, 05 Jun 2026 02:03:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780650217; cv=none;
        d=google.com; s=arc-20240605;
        b=TczzDap9CdHu0xfOaokfmllrpRsPEUMdAgijwAFDij/FBWDFELvFLbxcM3PNRpIxi/
         ZMm1ypK8vpuCoFiV0I9V9bAj06fEGSh81CUbMZU3W3vuAuxl6QlgE+JeyEXBIohab1Ed
         Hkd2bzWZpCQalnpdjD7a974c/THUTu0GX5dwxFMlmZDd7mH6FS7RVmMdhpOvfNEx1d5j
         ckIhMkxPYIlEI8BOouy4klY7PPV3V44L+AsPSCsbHBoZ9ZI6O6X0iGfhVj6aKsd1sTht
         lCqf0CMtLQiepk5FowvO2vnsGPZEYiUSu4guEUrTb53c3SrBw+undrBnZIJTQy6LjK7G
         ORdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=JNGNA9KfLEu6lKiLq/bw2EyVuHECatldL352HW3O3Jk=;
        fh=xbHhIPGno0uxMKm/DiXHX8FbqxkCmNdSPTDY+VNVSck=;
        b=JmZoBL2L2LyI1vfxiVXLR8iktMcw8POh7lo620F/qZUip+zsFUa5KP+McE2SF5wUE8
         Lz7WDKze/SiL2+kSgab9BPp3fh5bMYVHOdDvlqn0vTaltn1djZ4FwbWVS88rhvAFhFqw
         fRf4Kv4dGMwZzfXiYdZl+dPioMpuArN6AVqju7bYX9s0IFGWtzo78QYgsMLh0ONhN+9Z
         27rinson9DueeFmJgspHhUOFqXf++0onGC7Go99CnRZbM2mQmYAm1ofIiqaMei5iD0vi
         7NNBboANg0+8cmJ1v2ZmOpRk5hXXa7ldrw2ZVzWufALRMpfugWhn+GsbqS38f5wn2H/V
         qjww==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780650217; x=1781255017; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JNGNA9KfLEu6lKiLq/bw2EyVuHECatldL352HW3O3Jk=;
        b=Nthb6BU7+/JiO5N0dLL/yeswyaNkUWfEPERJOWx3YXJOqzg3FHGGuJY//BNPN74A48
         /vc+6jzDKki7KKPN5lRohkvPHl7gl6h5qUZaCqcq1bQUUfBCGs8gmFjycVbrT5AIeP5l
         7CmhfBTJfWW/UOtiF3UIYTrNNbNRIV7O4oNnjXXk0hvxxQ/2aAK/dtQuMUfOXjkVp1sJ
         Ad1DJrvtPTzJy5ghhgR3suh+kuMLHBSw1dwT5O5rUBkxzmwx1IWPXfj5v3ew+buspMms
         3jc4RmyA5cgcBPfqAwbF+4WbiBOqtYZ+mq+CkLf/vgEX6UZPJtX0MC8TiYyiPGpN5pGo
         OHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780650217; x=1781255017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JNGNA9KfLEu6lKiLq/bw2EyVuHECatldL352HW3O3Jk=;
        b=X4lrJ+KrX4iFMFiZfF4ugUKGucN/2tKoXQJmY8F4Rt2ZNKbN3HvW6ntSLPVFQFCeN3
         DK7fU5jQsxSlJFyeXiuiLlelrhYuFSvV99hLOlLCm/QqsZZhYbghUVlVdlR2qP7zUdbR
         yny4abTZy3SA6/ULiDi5tOtPZFgvHLjaHCoTY3gHPGhYtd7mF0Lq5a9MAMsIZX2x6Cdm
         i4gIBDEZKV3FhIy3diLCqMf0COIS0L3t52UgKGXGWyXFdMRou0f6eqyHbGiMusliGiuQ
         jRY8iuJ5ezzflm7SP7elM9UYfyYaMAHI8qLtLARslD0fceP927DLaGqlfo0oYJv9VA3K
         acng==
X-Forwarded-Encrypted: i=1; AFNElJ/409+eSKXictdiu8isoZnMUU66iVes3cZQ+kiZdp+7NQCdkUFSmXlnIITa4iV2xmI6W2c4cg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzkp0KUtLE8P13e9JkxcxAFBv1p4n476+FDxjdUudH6VBGlu9Ej
	s25J4biLjHI+vfk+Lav8shROUohfCCOW3r4eVfWu0WcvfziJzzZ0wX/WmezIfRco2SY3qN0GgO3
	XR5/njZ0UpPu+epOMsPEsOt+kLiY8SFDO2wynizFgNDF2oKt2K6nU4tFJoKen8lh4uksY4APf80
	lTDZxBgcuyjuz2taN7GN0mcp1V0//zq5oQ
X-Gm-Gg: Acq92OFHl208GgXnevEPoASkdwm1U99vW/BfaJLBoANMeZUqY9mpAU9OQWOYH5y+BM2
	Uy3ohViPL5tm2lc5stWk6zoU4iQ7u+Z/l+pXrX7K3wv0PW1JXW7JXy9ggV6M1tihcG1U4jiqyND
	P08nWpndbTSpd8TTuBWUAAgoW444mcLYtASEYUZed51jq4v3nv3mkqW/b/wc/He8M/CU1q0POwf
	n7xnOWzDS93YhUNhw==
X-Received: by 2002:a05:690c:6810:b0:7d1:dd7b:b736 with SMTP id 00721157ae682-7ed0d3c5b7emr25872637b3.37.1780650217217;
        Fri, 05 Jun 2026 02:03:37 -0700 (PDT)
X-Received: by 2002:a05:690c:6810:b0:7d1:dd7b:b736 with SMTP id
 00721157ae682-7ed0d3c5b7emr25872277b3.37.1780650216818; Fri, 05 Jun 2026
 02:03:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260604145510898G2kTwM2Pr25QE5H8T4Wh6@zte.com.cn>
In-Reply-To: <20260604145510898G2kTwM2Pr25QE5H8T4Wh6@zte.com.cn>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Fri, 5 Jun 2026 14:33:25 +0530
X-Gm-Features: AVVi8CeQNoqp6ec-yy76ZQa8OFaMF7NkyuFmoREpSs-Er4z8q50OUmANSqwrxik
Message-ID: <CAB19ukEzQZktJcBAXi8X2Pwz+hO_FcR+iiaK9nsCAumP9BrHnw@mail.gmail.com>
Subject: Re: [PATCH] iommu/riscv: Add dependency between iommu and devices
To: wang.yechao255@zte.com.cn
Cc: linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        sunilvl@ventanamicro.com, rafael@kernel.org, lenb@kernel.org,
        pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
        alex@ghiti.fr, tomasz.jeznach@linux.dev,
        Anup Patel <anup.patel@oss.qualcomm.com>,
        Andrew Jones <andrew.jones@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 79WHCApRdyk0iAj7DnrNRn32wh2HG48Z
X-Proofpoint-ORIG-GUID: 79WHCApRdyk0iAj7DnrNRn32wh2HG48Z
X-Authority-Analysis: v=2.4 cv=a8cAM0SF c=1 sm=1 tr=0 ts=6a2290e9 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=1RTuLK3dAAAA:8 a=8XNXOnQHZAaewqnS2oYA:9
 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA4NyBTYWx0ZWRfX/fiT6q/ppq9l
 WJF2HV8P+whYKArEyrCNu6LjvM14K9FYG8w9IDPQzUKDT5bOc6iL2MmKBE4ot7xcVm1uQYK1xRg
 jiRrRK+noAM6ntVpq5Iuxns4SQdt83ByRiS/R/vkPxRCCTmOU1WT1P5xPivO6w38taaBwRipjHc
 58sKZ4AySZp++1dgpwy++gl6gQ6fAIdLYsSQZ5lVNw6VxOumrBxPkgtbz/TUFCvlyBYR7rItpFI
 bIwdJ/rOIep445scYPUirpC9SuBJXIA62RQun6IhoLWfcaeqvTqSzhks5WIay/sTIlXJU7XAyqS
 V6CNV+I3G6s+I/xM0yzdM8/5hQak+SDwHkEplMjHk01TOYKvFovvPWZi8qBvyyNd0bj7/1OOs1Y
 w7Ob4rHG9BcElJpSOnMCZYT9WPZpttbY+Wd4DKAKgoxL3rfP7rH/fMzZBW61g7vwOEiZbJakX6T
 6bJPooZIN2PTQg8grIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050087

On Thu, Jun 4, 2026 at 12:28=E2=80=AFPM <wang.yechao255@zte.com.cn> wrote:
>
> From: Wang Yechao <wang.yechao255@zte.com.cn>
>
> Commit 9156585280f1 ("ACPI: RIMT: Add dependency between iommu and
> devices") adds the dependency between iommu and devices on ACPI
> systems. On devicetree systems, the incorrect removal order also
> occurs.
>
Interesting. Why is it not handled by the fw_devlink infrastructure in DT?

Thanks,
Sunil
