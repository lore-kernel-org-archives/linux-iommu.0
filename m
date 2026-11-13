Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794592036;
	b=WKiXBnwaktER/XUQVLU/GRhmhGR5h6PNebBJHdL0U0wPknLcI+PoH6kK7PKU/QB1c1UB
	 ZnStJ2njv01e87Ca/ZhTRcasfZ/b6EDTVp6J2ME7OPqR6HpRBsMSpHiekJmE1GS2RxkgM
	 n0dcOOwMIklDjRPUQC6vUBY6if8aQdWwYLRI/BmeIuoI8ELQHoQ7H+GR/YWpq9KERvP0F
	 tlhulXPcmliLfXobuTZOOF1/9c3HMtCYa6lTL0c5lKR10OTWW5FZ/aKYWf9d3qHPXEdCu
	 kI0IUn5VkRLLpFq0qMthfzwWmRHF4x32jHn6DF7g1BlTBcfuLYwBW+daog8LJYZgLvA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592036;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=XUtAykq3hDRsL0/US7WOum9GrsDms9AB2V3NWupV8pE=;
	b=1l9q8kSyYOeWLsb57M8xcrSPNON1KBXrt8lo1UDvdErfZVSxov1o2eSQlgkFz+yYeFD5
	 hzcXXy794GGbbgtIonUGkD0yGHYt8mfWuVF+Y0SOhTEt5ERhIxzm8L/nnVZGzijEtTml4
	 eDwx8gKBnUkbB+L2K2TXAYekyEt6hv7MZfz+vFIjzSLdE7gXj1VMml3Z5OupbZdTYaRyB
	 COAffJBM9PEi+MZHDCwAXkuLfA6jXNSZsYs5lTfhjFGuk5wlbX1RpFRvTq2M6hR38EMSe
	 LAyZGoUvtOoP4nHUXbDndOz9f1lj5+eICix8mexrIt2l2/yV7+8SW++LFVrjsbxjxTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XLgYD711;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GjZ6FN88;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B14606A898
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 17:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78B14606A898
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XLgYD711;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GjZ6FN88
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFR4Lr551701
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 17:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XUtAykq3hDRsL0/US7WOum9GrsDms9AB2V3NWupV8pE=; b=XLgYD711Nb6RdnRZ
	pQM/51Q183vY/GeyYUbr8tGR4RkZZkYV2YZLlpgqyAn6ep8vMEH3k7k5XmsTr6Zm
	dg4JtobSMy2N/EQQcfrNKmRJT5MRHku+6LyZ696Kz4uqWEnfZDpGBQIiY5yMuVtq
	/vvumqxB+tt/zkmIDA6XX7vwN/iLx/oPCpTqQsI6KcS5POxjqi3RVrrQzff1UhCu
	qb8l4Ow38i8jqlUuWr8EBtw+dWgLGU2bfB1M33C6drxYHw5GpzI/bDQRlKe0GEuI
	4xveG2iHz8mEJb50e8UCyeyD2PMSmP8dSapmmAeePBNVReEyHsGi+9Eo+37VDu6M
	5P6New==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwkgwc3wg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 17:47:15 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cdb8c46e240so742710a12.1
        for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 09:47:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794592034; cv=none;
        d=google.com; s=arc-20260327;
        b=SakP6OIctbDdqOrr6LP5974z9anMsBdyc525vCg78Okp5y8z4oduPlevWQZWAdfi0l
         j9srqIGFWIXp9yOlhHhL6dx3wkIwIFUu4E0qyPZX5xtKKyKEY5UpBuXmrslAAoBWQnyH
         1Z3BNM29sGtDth1LaGdXp2Re2IB21aOf3M0u+cIt+66jvD0IY9cua+TX5c+yvR0lkK/h
         kUk4o92xW3ecm8J/5sZJNWV4Koz1qUgxcisCB9hMq3pUIDWnYBHn+DXZZfF9w2eHfCSe
         NhYsrhpLmF0ftBBQQSJu0LGCx6pzTloVPgeUFpc1VzhNfw0pF7qfG+j+X/h8h6dfrG0F
         mLsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XUtAykq3hDRsL0/US7WOum9GrsDms9AB2V3NWupV8pE=;
        fh=YeO4ESaiySQj37PkjA15PyWQs8L/pdSL2bxmR9zAKRI=;
        b=Wfn+0wTBGxSxZwhz0eQM5yYJ6kTefKf0IIJsOGvKA/meFhscZOViHla72NPCuKYWnH
         hOBpU8zS1kqFgi1YXEBWelaJB24Js/MnKHxGVqUBl0a7sjAV3gXn8VbL1hcR3sbhFENg
         ygSH6WEr5dQI57hQ2E7qn1dxCYFhiTf1SBdEnOKTz3PuKDJjgUI2CDr+UgUGmnks9dlM
         ueg8qnwc6tTavIRXg3Z7/i3TXjC2wS9CPChVkRuuepsclX51tijHf03leu5bPtXFlOtr
         7TPqfkPCYAWZRadVMFt487WX3Gfhas3Ip/iOAZA53u6SPiZlWXk5QJvVb7v5wU8Vq5Gy
         oEFA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794592034; x=1795196834; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XUtAykq3hDRsL0/US7WOum9GrsDms9AB2V3NWupV8pE=;
        b=GjZ6FN88+sddKWUvkPWOwEykpa6sfcA5Y2pJfaIF68CdSME/SuwVwW3K/T3rJu6geq
         nQdKIN9fylyWg6fh8jxg9MPOVN9AeM2S9yRzXBUcKuocGscYjQZsCGP/RPjdS2DT4IJM
         HG9aWuykDeG0FeT0xK2ToQ76uHaC9/03GxGZZnjUdizJVhPnJ3kPRdmlJaB6161wasQF
         o1G00rZFztr55G3E+hiCXjjOX0GfBD0lZB9Fp31/HHMWYcdciDMbwEZGSzk/67s8GDp6
         R+76t9cmgaeYkzFeYJqy/p/aUN/wtDcLGF6CcVbV5PYfckV35K/mprya+riIvxBqJJRw
         Y4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794592034; x=1795196834;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XUtAykq3hDRsL0/US7WOum9GrsDms9AB2V3NWupV8pE=;
        b=qY5AeqXqPLAi/IHXn60BFeaL1fBNBMi56MAKQNhE/UgtAAS3AtpiXCDmYdEZwzQ6/M
         QHPEIETgWPbLNj34l6r+kqcukI6COGyljZHDEgdlEkW8/uiW1J9PXM+qXrPrCIJjeU7x
         aYPF0nvJ66sGZOOWTmN3DPyQF2a45ssn7rXM1exfV8K5tP2DB8cv5w3fe8Ty2IrZcsYD
         A86RraA7UeuqKPDgOfn0Fy6ZzmEr1fqoAsp0629yNckWg8lVC9UpIJxcBr5iTsfuhIz1
         K7YhBi8Wx1xKgWxc5JOAzPNfCUg2B4wnc94ZEd5IpzXt4jo9CpjNPgARvRETuss1Y/Ru
         MN6A==
X-Forwarded-Encrypted: i=1; AL+hErGSJBnRyY1SEe4KLU5AJn4OY6UhuTNe60bvROHU+ZgqpKNug8TqAwjJgIKCXur3eXrlbmuLlw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/3UWiFmYGe+bDxYyexEClfg6s3JfDI4Jip+ehNWukVOCgP5sBJ
	h6eQS6gpu+OB5l/+gffrPIkHjOrzaFl4GzjF2Chr6MM6TwwEvrN4lRHibMPZL+TWUCczKB1utqR
	iAy++R1cpae2mj7V2oVPRcZ/pazK9E768eOhDfYbl052Dz+8xvVtRN+uXcpezGWyi3UjuIjbNpQ
	purFGsLOewivo9LuZi36LMTz40Vav4j3ke
X-Gm-Gg: AYBFou3x1oSph5fyh27QxPxdveX1KUpcFZp6EMPjeqr0aTk5eu8yMNVj1MmiFC/Syuh
	SIPd2FU0UA98TOmTgwvfFVU+DNz639SQJb536gTDIFw0pray1cD/xLZold2e5C+0Kx2+rSdTNbD
	ui2Wm5w0VFNeqSm9Zz6opXvCcH9NHwXBsxEiHEfn4TSuNnHqH/kxX8e6SFDw==
X-Received: by 2002:a17:902:f603:b0:2ed:4456:fb2a with SMTP id d9443c01a7336-2ee0dedd363mr31379425ad.36.1794592034404;
        Fri, 13 Nov 2026 09:47:14 -0800 (PST)
X-Received: by 2002:a17:902:f603:b0:2ed:4456:fb2a with SMTP id
 d9443c01a7336-2ee0dedd363mr31378845ad.36.1794592033770; Fri, 13 Nov 2026
 09:47:13 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261101082307.151957-1-gahing@gahingwoo.com> <6777074.j6PcuT4dK6@diego>
 <CAPx+jO_gRtipR7iuh0D7G2Wi25GZoqFD1JHVbJNmhd1UyC3Bmg@mail.gmail.com> <20261112072146.41218-1-gahing@gahingwoo.com>
In-Reply-To: <20261112072146.41218-1-gahing@gahingwoo.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 18:47:02 +0100
X-Gm-Features: AclHuK_xZYTfne11hVPWnloCpcRGvh8w3tWYpN49I_tY52oUY-lip7RnFHUhpQI
Message-ID: <CAPx+jO-KKvgRS0br-3QGh6Jt4efWJ+A6YoRZKFV_bcfB+8sm6w@mail.gmail.com>
Subject: Re: [PATCH v15 00/15] accel/rocket: RK3576 NPU (RKNN) enablement
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: heiko@sntech.de, finley.xiao@rock-chips.com, shawn.lin@rock-chips.com,
        tomeu@tomeuvizoso.net, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de,
        ogabbay@kernel.org, zhangqing@rock-chips.com, royalnet026@gmail.com,
        abel.vesa@oss.qualcomm.com, sebastian.reichel@collabora.com,
        sidong.yang@furiosa.ai, u.kleine-koenig@baylibre.com,
        chaoyi.chen@rock-chips.com, diederik@cknow-tech.com,
        alchark@flipper.net, leonard@lausen.nl, jeff.hugo@oss.qualcomm.com,
        rfoss@kernel.org, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, iommu@lists.linux.dev,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=DNgacCNb c=1 sm=1 tr=0 ts=6af74d23 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=s8YR1HE3AAAA:8 a=9GNsruGHAAAA:8
 a=KA_qeCUQCZmkxMg8J8kA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=jGH_LyMDp9YhSvY-UuyI:22 a=gf-oSkQAjqHFJRp-GQfY:22
X-Proofpoint-ORIG-GUID: 5j_Au0xrwKwS6OQA22An7LfmWaDPu_Ci
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3MCBTYWx0ZWRfX1JDKdjpwXMuN
 WCMt15n7ToIC509cpLFrI6OjKU03oiof4wkbf2dJ0TLM2PGzPrTjRrLt9D9Gfi+GhKsGIvS/nPZ
 voiCG4/v6OBSqgpzyC/pwQfzjuKQI57Qj8rjtXHXMS7t0+9TrboHvWEgCxCcnz3BGohh+iqQ3RN
 IHLrRQkeJvyaPyZ+K6tsXqGw00vdctibfCYQ4OTu5K0roB3I6iQz/Xz+jetQEmJsP9/yvaf11NO
 4jmdph+weMwTD1LmVF5UrFbJlIGAyNK48WOJoTlHTEfnkFwDGEnyYFaXGsiRSOh48E+XFwxvbyH
 YUPxmkDBiK4rqDmiSS9rOo+sjNG9e4tSVdiag55/qKPotKkHivqpy7X1Y0B3GJhyraozRh5rfkm
 OCGd+Yx5KL9ZTuAMD6cn5xen3G35/wd9gRUMh3+c0pm7PUaziaSxjqaY9JdHzlWQpCubqZ9i/nb
 w4hMMR8V3BmtR2yKYIw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3MCBTYWx0ZWRfX/nzV7NxbTyWc
 LQLP5d6FnpMdMZBkSgKyiIJ3joKkVZg/y0RCUeCSDblTbSYcufLabwcyhj41RemDLom1KO9lhsO
 aqdqdahx88Qckv2BI5bGa0o0XsREUHw=
X-Proofpoint-GUID: 5j_Au0xrwKwS6OQA22An7LfmWaDPu_Ci
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130070

On Thu, Nov 12, 2026 at 8:22=E2=80=AFAM Jiaxing Hu <gahing@gahingwoo.com> w=
rote:
>
> Thanks Ulf!
>
> On second thought, I think it would be best to drop patch 7 (the
> binding) and patch 10 (the reset) from next. Once patch 10 is gone,
> patch 7 is no longer needed either.
>
> Finley Xiao from Rockchip pointed out on v16 that the reset is not
> needed, and testing on the current code confirms it:
> https://lore.kernel.org/all/ca90a994-70cc-410a-902d-5c4c0aacc9b7@rock-chi=
ps.com/
>
> Patch 9 can stay. I will send a separate small patch to fix the delay
> table.
>
> Thanks!
>
> Jiaxing

I have dropped them all, let's start over! I needed to apply a fix for
the rockchip power domain driver anyway, which caused conflict with
these patches.

Please rebase on my next branch and submit a new version.

Kind regards
Uffe
