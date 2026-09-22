Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BB3414A1D
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 20:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790109392; cv=none; b=b8LGoRIW6LnYjO5U7hxtD7EtnbAq+QS4Gym9rBT0VyxHi5oGEsCTp2ZT6mwgcrx8a3OR8EkoRXy9zlN9gnG7fl0Stwuxrk+8ylC9aDX+rUueV+4d9eucLN472GQ7ZGNjSV04GZTQd5kfJapYKWAaESef9drd9PVWu7QKKJoiMcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790109392; c=relaxed/simple;
	bh=F2Rmub3kqynxFCpMUaKCzbW3Wn9kxlczWQbB/Q64QTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5ThvcA8vwEUZnCVXJIE1Scpq00Bpn7W4Hcc5+4pJ6PGnsNaJQzxamdb7zrlL4gtS7j8uccG5cGJjpSu7dIv2T+fQKjAdFI8ai4EunEQxe2RZ1JKc0ZxvZqIQM1iKh/tU20FEtnMkhaUX55umQMJlsVWKa+4rbRDJotf9A8orDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gq1bXgXF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aPQ7o3f9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gq1bXgXF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aPQ7o3f9"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MI72wR1153696
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 20:36:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+hpos+oDMvB//kGlWtIFvFC8
	JGuO25mX9RiSy0nVVWI=; b=gq1bXgXF3s8Ra4n02W3SuuXBHDj7XCY1aL1sxa9c
	u2ix9mNTUjoYemXIUH9MUJBag6g96s+TaF3H4UV4X0Wwh4Jp4C+bT1bvRGIefFf/
	evLcj9iy5K80G4tgUlTNm0+6PM8pnK+UlIK/rQHU6HORQq1dobQdsAQc0sOs2yVP
	l6barOdQ00KSB1x/v5eVSy6TCD2xX5HcAR6wERBje5qrpc8jf9qzQK1pZrDDPGLL
	RPaiXl66re5XrVB2T0JhfiWpX/Geoo/8x+tGZHhuAEDzeSmfJIODDBAb9vTknyUK
	jnvkqMl1sq27dq08hW6w+a7KwE/1SdLH0GWY6i24Cmp4Cw==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guvw7hft3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 20:36:12 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5c8323b8464so353032e0c.3
        for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 13:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790109372; x=1790714172; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+hpos+oDMvB//kGlWtIFvFC8JGuO25mX9RiSy0nVVWI=;
        b=aPQ7o3f9iOKkBbHh6ELHrtq0VfUCixltXhnw8EQezupMhAnml4WOn56w4SHz5ICyz7
         4igPVQ4BTgMxwi7WDr9d5l6cA0JbTmZ0lx5Ngntj7yoPZ4B0GDwYF/2B6GGNAhLkXTHL
         f6T4NUwRqoOrdhOqwmUqzdh5xFSFgBtudB/yXBkc6as8pYOltMTV+5r0kdj1+HtS59PY
         rYSqHa43nQh2HqARkjfo89t8P6PvlePJeh9t+Dvq9gb25xzd5o7OKynE9ZzJIZ7nn2dr
         v0QXliLz+tUz7OvycgnDSmtaEB+9lvLUIevWNyb5mH/tB6jlQCt4uaspk8Z4UwvN0BIr
         dQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790109372; x=1790714172;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+hpos+oDMvB//kGlWtIFvFC8JGuO25mX9RiSy0nVVWI=;
        b=aX+3h1P1Fdlx4Ojat1hs2Q4ebP3x20u6phFZQsjqugWGE4GPV74VnyD3QW4xkhgorD
         jhOYAM7WQ3/QLE62nKcad9k8c0Yd3z1PjEjLZD1wkNbmvw69VgLPbOgo5tk9U9unB0q8
         f2gqwakmBkpDuOjSPgdEHT7yHyVACgmp+q5JUmS4tlTWyhwDezQ8nCq2/SZBzMW/OLuV
         HYdxNxB1ykTR3A7neES+8pRNvzpK6yLH/udUMZqkmzW1M4J4orc/wU1S9IBGM71N25VW
         Ca7tC8nNgUTh+VJfcU//ELRjRVexpv4bBgltqO10LIOfPbka7XHzQnLgHpfP03/1YI4x
         l2cg==
X-Forwarded-Encrypted: i=1; AKwUvBwLULm1Un82dZBwp5JwPOQryfL8jYIq3lg8traPdzEZvrTms5/WLxl3EhXZ5Ff+rh+HrYUhOw==@lists.linux.dev
X-Gm-Message-State: AFuF++komj4rw/2MC3zLI/XThToP9mt1Wwn9SL2X2PvHzQXgzr4N1d9E
	3zvnVtg/cIDajrEeXWtq/j6yK58GdCaAxezL7buPLEnRbmOeGFG2OwR/SilbXF63QqIJ2YeoXN7
	uRzKcXPYzkg8lRhmFXLxnmD6puSL2K+xLFLEcwyBJK5aGSUIXo85zQuTwgw==
X-Gm-Gg: AYBFou1+aIy9oPvMNy79+oGUbI6gB17gJu+2Ny2Cf73QiTAIq1aifVVQ3LDBU6MmWWk
	3ZRQvWPfv/pVnDOvOmEnNUG9rYgEvn4sO/kx45pyhXyvTgSC0MNTUnmGZiX8eWt4F/H/Uoe/Neu
	R2J3Q5SWkcfeDmcUjXC02RB0G9z2ZZYVxjWn8yzP4mWY9VnBqqcf685NGMJkq5I6XqT6u7n/mrk
	dkYAfBU1z6JdzSrdaklnx5XWkNMsuUApv7DtRcTlilpf5as+RQ72g4esA85HQzVyeQ6SpSfN7yS
	83l3Aogqt/krjc0gcEfge1C84G52yyhXsjqkugHUJcWgt5X76IQyOzYzkJKiZvdjyf1pJuuVI4A
	LdVLS/k39jltUuw==
X-Received: by 2002:a05:6122:21a1:b0:5c9:a7af:8178 with SMTP id 71dfb90a1353d-5c9f1597c52mr1337343e0c.2.1790109371751;
        Tue, 22 Sep 2026 13:36:11 -0700 (PDT)
X-Received: by 2002:a05:6122:21a1:b0:5c9:a7af:8178 with SMTP id 71dfb90a1353d-5c9f1597c52mr1337277e0c.2.1790109371230;
        Tue, 22 Sep 2026 13:36:11 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886876c267sm965996f8f.16.2026.09.22.13.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 13:36:10 -0700 (PDT)
Date: Tue, 22 Sep 2026 23:36:06 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: muzafferkadir@mainlining.org
Cc: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, iommu@lists.linux.dev, mfd@lists.linux.dev,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v3 02/19] clk: qcom: Add global clock controller driver
 for MSM8952
Message-ID: <c2jt5rpbmys2fguk6ui7e4lwzp55vio3vf73akeiega2wqb5pf@ewp6wsvtxm3n>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-2-b96fd3fe298b@mainlining.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-msm8952-initial-support-v3-2-b96fd3fe298b@mainlining.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI5NSBTYWx0ZWRfXymFwV3HV1NHI
 2gGr5kgQQaJNCvTLU/8Uo9dGI+m6P68uiBAL7pi982AxkUYPeZQrW8zr/JolfVdid6ozi15hp5J
 rPI+J9VdWQM6zjpJm/hz/FYOitKs55Y=
X-Authority-Analysis: v=2.4 cv=ZYqIpcVA c=1 sm=1 tr=0 ts=6ab2e6bc cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=Oh2cFVv5AAAA:8 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8 a=n1RHFZ1giDiXVFLDIJ0A:9
 a=CjuIK1q_8ugA:10 a=XD7yVLdPMpWraOa8Un9W:22 a=7KeoIwV6GZqOttXkcoxL:22
 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-ORIG-GUID: CGt67jwB16b_weX2B17-QLXvDzn9vKU9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI5NSBTYWx0ZWRfX5I5gnq+Oe41V
 SBAyvpJFP/4NeVMwit+/VVNUx694z0kFs+6Zr7qbnMShP6NzIIKIK/8pML9Wpyvy9FQSvFSjVcH
 5iTffraBNVU7taSBvNi3Eci+clsRU1I2qvzUqxF7/yBkU7cMUeLCv7UEReUUnac7R7/9izOTQeM
 GyEIK0MHMli2CVNY4ejjFspdHlimqBBXnW7cwJPm4o1AkJtx5vEdKMKdA4D4EXvB/rLYBPj5T9D
 5lyLKlmH9iT6a5q/J84EC2ch1lNCcrRRBlYrYmQH325GUwmzyGYE03CiNAIuq63zXQId8mEqxhh
 UiU7SMQDPqkRFXS1NFwrOLmOvX2dZM6li1BXW3QOs7RplERqJTYgDhKFLEYzCIE3YSbMfSRy+Xj
 YVtYQauQPFBnBq9wFD1f+OIuk0R8VtTaWD0xca+aDDjjyu6+1JLvj6cGnPPXjHAgBQCdxiDAizJ
 rNSI+/E9KBOl4diZG9w==
X-Proofpoint-GUID: CGt67jwB16b_weX2B17-QLXvDzn9vKU9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220295

On 26-09-21 21:18:53, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> This driver provides clocks, resets and power domains needed for various
> components of the MSM8952.
> 
> Some downstreams merge MSM8952 to MSM8917 and MSM8937. But upstreamed
> GCC driver for 8917 series has different pll structure and ported from
> different GCC driver.
> 
> MSM8952 GCC driver is mainly based on MSM8939 GCC driver, with
> some parts added from existing other GCC drivers.
> 
> Link: https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-wear-7.0.0_r0.3/drivers/clk/qcom/clock-gcc-8952.c
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
