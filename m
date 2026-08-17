Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD7C3F44DB
	for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 11:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786966852; cv=none; b=gll+JwdVqFPJmAgl/lhVt6B3Heh/kgeap0Tg3nzO3ssDJHuak7JqKCoA+XGFsxZnvCVsvBmfVRaO16Gi32BYvKbHnGRllv+Lq69AfiLtnMuC6MlCjBeSLpJlDVa4xlhZFe5583mUQJAxlUJSdolVnHv1nSQQN1ipsgx+RcTNhCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786966852; c=relaxed/simple;
	bh=Y7OjEwilJrsfE9L/92apqI0vRrbbUF+OOklPwF7x+YQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hGsbIM0PRYMOR7nB4OUCs7/FNhCE2DfONnoJg0QjPiNhWEVG2hxxdVgcBtbZuIFG6gpEphCGIVUI2X1lBeNIbu12BGFbQn9SkvgNlDyNV8x2uX9srE8GrqBusG2OnE04O534msAKXcxgEs8WaUi3Vs6a/M8g0J47hhGz8SEGwic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N2dM5Qvh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ha8MNK7F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N2dM5Qvh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ha8MNK7F"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67H9djwB728000
	for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 11:40:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IGcPbfwzVeaXPPONPxtiLfIGqQcm259ZEgiBE509QLw=; b=N2dM5QvhPUnc1rIt
	ZtMx3Hnd/cTSmFUgHQirwStzDGxxb9fg/Rx4pPgYjXRoszWu6NEo1+ZEdaOl1Oe4
	9h4Q9PELZPOALSzhjViddoyVje1I9U6FMNIbMFG4PCxTkFCsIsc+5C0lkm2ty8V8
	8oemZfMjZAMxe2YRnB0IsPpDPfRahl5MV781bcAIR77yeabKcTugEuRULhLSnaGg
	1AMj66nIDMumJRt+OTo16D41F3zlPUw1EkxLGBmAdcinA1V4RO7N6ii4p/Hej5Rd
	9YYtTm+QBVEGiczZzFvozw5snYnGLPF3iOg9r62dlntyv7DVAvUGD80HCm8Qe6zs
	lhGtyg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3wke12c6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 11:40:49 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51bfa45b280so8349491cf.3
        for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 04:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786966849; x=1787571649; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IGcPbfwzVeaXPPONPxtiLfIGqQcm259ZEgiBE509QLw=;
        b=ha8MNK7F339MaQYhAaBn47tY7jOZwkoGc6/WnOyfI7HGnj9Yi/lCxp0Tfydf9JsOR4
         BiSj90DQ/5JksmYjbx6QVBipoFBmU2yh94W82DwFByxPM751WAVZqY+9zX3xwQSQM1h2
         PBpE1U7TnsZ7YgW3oPLtQlkY1r9BYyYBZzKfqI6lXDhNaUwEccBTb4V9LDpobgKgLgv2
         b6kC97rVk/z9uWVj2uDk6xu6oAcB/HoqbkFBYnZBw2LGU+KlnjnMPzDGrT8gfoKZuC/f
         5AlV3TvLOYAl8lgZugIHAtzu55kxOHH8NXQGRHjSZZfgOTZS9fLjCCpa/3AdmBtobMmr
         BhWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786966849; x=1787571649;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IGcPbfwzVeaXPPONPxtiLfIGqQcm259ZEgiBE509QLw=;
        b=IeZvgt9YuOqQxQ7HfWZMphie0eBm/jZWjW9cgrZxV9eF0OQLY0BYsFXC3y/GDbRK2p
         88MVUQR2I1xjA0D55GFDO967RlDnxmKjpIXWcPBakvkFDltRMBqrsjZS6y1YV/GvBFXK
         XZDsaNj3VpCUxw95HMO1AU52Qut/HICzY30KWwbRQ1Nn2SpWLRYj3rxaLGWrQt0spSxr
         74OIWYYhH4o3uR5IkQ5GTQ7GhicKgkqzK+CC2Al6ZzDiJpOLHa0wmeZbYy1QqUr+PdWk
         ntvmJhjJrJjp2K1U0WpONkMyht6MVxJPIIJl8ZwIv/bwSbt63pUqk7Dit6YoW5oB7+8r
         5DHw==
X-Forwarded-Encrypted: i=1; AHgh+RojxXUobmJwKD2CfqvKH37sQnGbw3pZT1aVc1VU3Xelze8/uUWC8Lz0SL3uVVBF43Lw8LuGMg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyp+v+DX4XINGh+d8JGDnCwxsB9cBkyajYZAAywfZ8ZGFuzBSyw
	lqQZ+VlV9uA2igOMj0MJgCT+85vsdAOXDMmYgD7Hp67JnRjyF3yjEf/KrZeGIOKTqeO0/hYhcNy
	OiLR13OCgeRQD9QxS5ktc6YK4EPXXxlq8ZFGFmiYE4y0KPV/LhrTjmrBlhg==
X-Gm-Gg: AR+sD11pijAUUovbF0jHpNRr8PNgKvGH2QHiOUjGiH8yZNVh7zAvxyuFJT2wbp1NgYo
	geI2U2Dg3BbZjpAaF8fGNMZIudUm/EQ1uq9o25pyFZSDPygN9FNlq+BGg9j+2xYq/InezpaB30S
	ZVhwIBWj6VmMXmnisWDX0ZAEWLNkCfY6s13jlpzYhvDfz3CBR9VJOLhCsgSMD9F+M5URptAVdTd
	oOmuYQCxZ5xcePKY1HYcDEg9+pqSQMQU5RWGTLzubXQkm6Nl4a7VuSTyd0FzrA2vaCCJJHCTdbq
	PXnxRg9s+o1W7cMuVirKshEM+WzERG2ZjuS3fEn2XarYzKzTUDV8X68BsigYJ4Z0MhPjlEVYs/6
	dxEsEmKoDrMuUgHbgl/CiFN6B
X-Received: by 2002:a05:622a:118f:b0:528:1ea6:eaee with SMTP id d75a77b69052e-52d852b4f2bmr165577491cf.1.1786966849230;
        Mon, 17 Aug 2026 04:40:49 -0700 (PDT)
X-Received: by 2002:a05:622a:118f:b0:528:1ea6:eaee with SMTP id d75a77b69052e-52d852b4f2bmr165577101cf.1.1786966848755;
        Mon, 17 Aug 2026 04:40:48 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3d8588499sm543504a12.14.2026.08.17.04.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 04:40:47 -0700 (PDT)
Message-ID: <08bc7c0c-4e15-4e76-8ed0-34dbee36a6ce@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 13:40:43 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] iommu: qcom_iommu: support non-TZ-managed instances
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20260809-msm8974-iommu-upstream-v1-0-87f5cd492560@oss.qualcomm.com>
 <20260809-msm8974-iommu-upstream-v1-6-87f5cd492560@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260809-msm8974-iommu-upstream-v1-6-87f5cd492560@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA4NyBTYWx0ZWRfXzCRtvdHvNYO3
 4e6YLzWPQ5yfdlU96171Nummv9p7ke8+dTFoOxdpk5vgwWTd3b8wo4zfOnOMIWRWRZdbaIitaVX
 Ufs5Q8AgYvJuXmSargBpBYBXq1o48V5Kn8xHUJqz1Jb4s/1kRVZQcgqmAVBzQp1dBye020I/ZWb
 x//kdHd/fXxFwE1ANT4ujuN/6zsZi0Gwe6ATmlgtB/+M+AARPIhCknmuTVpnktS0S1rDuXD8ayF
 ploNyTNNqjinfWduY53QSvxiifpx0ajZ8bgCRSgrkAMKtzZdGFUmauBuek+U6Tjz8J50hgepkhT
 euzKFja/4eiR9cPAZKeRURZr8oXW6uwqD5GmkXwpd2cGzGtqEKw/42gz22b+jom/K6+M7y76UCe
 HCdJMRPfF0jyXHcHXZJkyFj6aSLg8t2WCtFO8fQf4IWQQEKOHKeQEq6Qism/V/YVh9uJO9NGjFr
 3sSlUvZQjmdSYqHsoCA==
X-Authority-Analysis: v=2.4 cv=QetWeMbv c=1 sm=1 tr=0 ts=6a82f341 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=DBckZHbuUVvodCrkklsA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: fz_nnf_tzKe-Asg-Kj6fL9bRJP1CsnOS
X-Proofpoint-GUID: fz_nnf_tzKe-Asg-Kj6fL9bRJP1CsnOS
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA4NyBTYWx0ZWRfX4Ch88zIWMX0x
 UiKzve8uLCpWfmPYh3T6+55QkZYUsag3yuSeff0835mAVvKoqe/IuYD1hQYDsdsyYbUoR9bw38B
 vemkrxojgg7mpRRUbWj3RvCUHT/U/Qc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170087

On 8/9/26 10:15 PM, Dmitry Baryshkov wrote:
> The GPU on MSM8974 has never been usable upstream because its IOMMU
> cannot be driven: unlike the MSM8916-style instances this driver
> supports, where the secure world owns the SMMU global register space
> and the OS programs just the context banks after a restore_sec_cfg SCM
> call, the MSM8974 GPU IOMMU is not managed by TZ at all. Nobody sets
> up its stream mapping, so attaching a domain leaves every transaction
> unmatched and the GPU faults on its first memory access. Verified on
> the APQ8074 dragonboard: restore_sec_cfg is only accepted for the
> secured instances, while the GPU instance exposes its ID registers to
> the OS (IDR0 0x78034404 / IDR1 0x10000003).
> 
> Add a non-secure programming mode, derived from the downstream
> msm_iommu-v1.c driver. When qcom,iommu-secure-id is absent, reset and
> program the global space at runtime resume instead of calling into TZ:
> clear sACR/sCR2 and the global fault state, invalidate the TLB and all
> SMRs, install the per-instance stream mapping (SMR/S2CR/CBAR, with the
> downstream MEMATTR/NSCFG/VMID/IRPTNDX values) and enable the SMMU with
> fault reporting enabled and stalling disabled (sCR0.STALLD, matching
> the downstream terminate model). The stream ID map is per-instance
> configuration data since it is not discoverable from the hardware; the
> SMR index allocation keeps ASID == context bank index, which this
> hardware requires (downstream msm-3.10 commit 4d92ea10aac3 ("iommu:
> msm: Use CB index as ASID")). Also set CB_ACTLR to redirect cacheable
> requests to the L2 slave port, as the downstream driver does for every
> context on this IP generation - on MSM8916 TZ owns CB_ACTLR, so the
> driver never needed to touch it before.

At this point, would it make more sense to retrofit this atop
arm-smmu-qcom.c given all of the differences vs 8916?

Konrad
