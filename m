Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA763A6417
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 14:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776435010; cv=none; b=rzdCLBU0sh88xySMryGljV/EjaHTNa6leQ+kwXhea1sN9KRzq9RmdIQYxXgs0I8MPlyds0nurBlnBy6QbalyIx124UNmC+q/lTDd/qXPZegl1X49FjNQ0+MKj6NEhoF7v/yFn04aPCB9AcCaY6kDuVqSjQCOybMe9Jvo7B8frjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776435010; c=relaxed/simple;
	bh=uEuVoD/MvbmrZJAAU4WJMcdPvUB704Rh08cLOWHed1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZILaiCLu+BGO1t6866xZ3XdaNCeXVELAcQ38udhM4fmLmZL8szbAREXjCZwTkLi1VZxzz8Oboalxj5bvoFe/aKM/V7uOzZQuZlYdJtKE6jERTTViFHfq1okHJvYWJcN2Vbw9/wdW1xYM/nEvzrr5ymUeCwru2cep5nUprXdVPbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VChwwG/2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WJmpVz0i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VChwwG/2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WJmpVz0i"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63H9wvUQ1323861
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 14:10:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o0F2o4Dk3iiYwIY3r8uAaLKA55qkddrf0NWv552CW8U=; b=VChwwG/2FWGSCTBx
	Q7wfayNUO7wd03dW3G1G6tSCl+MEf5YnVHCtR/kz8UyuBEVtTr9WrmI3EeRNczAZ
	OmaYCqXLhyvQWwBav1q19M8R/s4OxWOnqm6+GLU8SuSZLJkZr4FXrL1yML0HnxGx
	VchGyjEwRiuWnokUkdF0ltrTOej55GgXf0npFuzPZJu7/w5ihTM/1gaA4TMz6klo
	TlwDUmG5Ew8J6GIxhGrgniMaciwH7mF6awqNyw3DrH8PxJbLAnxb4sQrUe5vJWRo
	pcw/YVgteXrkVDQ1sYg7HNWObdotjL5Crg8tsYM1IbFsr1Zn1uQ91IvdfEi8mB/+
	fI8s3A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkdgy21n0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 14:10:08 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so740803eec.0
        for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 07:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776435007; x=1777039807; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o0F2o4Dk3iiYwIY3r8uAaLKA55qkddrf0NWv552CW8U=;
        b=WJmpVz0iwuTJFt35W+6bupveHZIgNpp4MiuFDAiO3yiNoxjf9/2b53HugGud687Ekh
         aP/e5qbPmMcJBpSUPNzX6uH0pY5XGnwI68+NjRHdYd2QWrJKwIQSjh75vz383MgQbl0Z
         2JEbp6u6YpGsIWJE+1jRgL7Ap8zUqPhgLO71NJqtBY2xdwL+H/lvV4V6sM2TihIlAjrY
         B5XIXvNwUZHGYAn3PpFDudJOv2adA1w52VEBUj7kOuUD0SUveJX6fddE83rKcJggSzuS
         uRDoVIfUtbngobTVbXAoHqv8uuqPTJ+QjhSxTHiGM3eTSQDvt9G+wHlta0ovScMgCl7n
         oreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776435007; x=1777039807;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0F2o4Dk3iiYwIY3r8uAaLKA55qkddrf0NWv552CW8U=;
        b=InYe9rbV/mhtJUYQgZgtyE0rfKtgxEuiVZPjIh2eZGGppK+ayohNm80loUA83Xrrs0
         AXoy6NypAKpG9+kyH6YHDZtogO1kHg1Tcpy6i6SFEcMT41Kjf50ZoVznTsZ7vSXfQxP+
         LAIvoeeb0bBni8pNRrxL82v8Iy4BHY/DdOI/4Yti51eyUM3z5fyPqcunf+b9G2aT4D8t
         XoHnYEWMxq8UayuB5A90VLcvHEuj0+sO2hEc86wMncL23fU0lTB/WrzbQB+QRNs8IDqC
         yNcGz7XlxBwq59fLKtenqRYWZp+O/siJUrt/95OsdWB8e39vHt34NuMSuuaUxAvR/Mo3
         c8CQ==
X-Forwarded-Encrypted: i=1; AFNElJ/yNLvJYoLc7xoB2cm8BER4SIrvy3qxemWv6ArHPFo7JItyMtrtCDfqY2Pv/tUt2qf6y5fzYg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxOsLibEi3LIhpaaH5ge2TfqOp0us52e+tb8mfkLI76rAVWyv0O
	2QStniKk3tO8cDeN2aitjWUMJivQ7Px0PX6UEBudW0/5WJPi+wyGd+SJDJAmvmiYmdRWxqNANy4
	pK4zw4lsqmG3xdnI9FVXlaeOWnE3LIwSjqJbkGhYQShBEnd3/esrZKbZBAA==
X-Gm-Gg: AeBDievvGHijf8lmx8d3BRLj9DnxChskwMMWkYFF6BdHfgzU1b3S5l83j8F0ytT9D5q
	IeZD8oQMLArL+CkAKh5CPfxivvvhyYfTxOPNABaagxvf5EHZicwrgiB81th8lO4hmSAD1+q3lVf
	FODJIuNW1bCUkZ3yvsk2khtmVLuT6dYifgq83MnEx5hCspYpXZasjewVr3VIjuAN8DLC/gNKq//
	b9itlTgRUi3wcnOYz6iCJlX1SgF0p6D1ysvhYv9lhcMS7mZPOpjJp/MKoUM2SwJWCRpOCtxTUWZ
	Lf40Jx4gL9ZG1Npoqd/ESrelhnpLgZ4lCEmb+FdnT8KfaBH3D96wCBixbAenJk/ZOtlndNGfaUM
	2xMWANacfXcEGj+wBdAdaOmaWyoY57zV7MtdpTPHACGIykq46BPXkPpxG1lQ70K29FD+Cenk3nn
	s=
X-Received: by 2002:a05:7022:6728:b0:12a:6902:ddce with SMTP id a92af1059eb24-12c73f75d0cmr1432463c88.10.1776435007246;
        Fri, 17 Apr 2026 07:10:07 -0700 (PDT)
X-Received: by 2002:a05:7022:6728:b0:12a:6902:ddce with SMTP id a92af1059eb24-12c73f75d0cmr1432394c88.10.1776435006470;
        Fri, 17 Apr 2026 07:10:06 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c74a2ac32sm2243346c88.15.2026.04.17.07.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 07:10:06 -0700 (PDT)
Date: Fri, 17 Apr 2026 22:10:00 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: bibek.patro@oss.qualcomm.com
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Dmitry Baryshkov <lumag@kernel.org>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, srinivas.kandagatla@oss.qualcomm.com
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Fix fastrpc compatible string in
 ACTLR client match table
Message-ID: <aeI_OPSESxxz8WMR@QCOM-aGQu4IUr3Y>
References: <20260408130825.3268733-1-bibek.patro@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260408130825.3268733-1-bibek.patro@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: CXDMQCHOqlGCO2Bp41z9xSotIvNoYhPE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE0MiBTYWx0ZWRfX1ZQNEqcaOxWd
 cNo3MMAqCJX+dKeDPDJb403rO9LOXRccaPDsLjkgX6K/E5DqfsF0dWc/RNoYE9ua0RyRYu3S82P
 4cNo4d7ixPFB48H8tozRoK4aLaCcTy8hvyUKa+7/dginYmuVOswLZryYuzRDui4WTNMgslBdaBZ
 u7cUbiYcZ8kHNAT82Vq8HdfqdnmohoYiG6k6CJEHivXx4wyxjnzHEKjhO79N6H9S7/vgos6zLFY
 enPQX2XYYRehHaPprPLUuXD59s2yFJPm9IxHBPsICaWgiBb/FggFPZlCkN6TmV5/BsymA5NsDwV
 Ntt5m34St6CkShBPY2ZEehy89kdHG0Qeh2JWQ3qmxhvG6FUX1oO8ClYI9oxvsITSfU8vu4VY+jn
 kDDm+T/Bj4IwOOuBfOwP+3yq92hULfHWVW5gngnSf2XbzHVIwBXaFcNYtngtdFJfYxykSGbmV+T
 jwrahPbJnUwOvwvmWhg==
X-Authority-Analysis: v=2.4 cv=GN041ONK c=1 sm=1 tr=0 ts=69e23f40 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=pfcpBET5JRzwQ_8xOogA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: CXDMQCHOqlGCO2Bp41z9xSotIvNoYhPE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170142

On Wed, Apr 08, 2026 at 06:38:25PM +0530, bibek.patro@oss.qualcomm.com wrote:
> From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> 
> The qcom_smmu_actlr_client_of_match table contained "qcom,fastrpc" as
> the compatible string for applying ACTLR prefetch settings to FastRPC
> devices. However, "qcom,fastrpc" is the compatible string for the parent
> rpmsg channel node, which is not an IOMMU client — it carries no
> "iommus" property in the device tree and is never attached to an SMMU
> context bank.
> 
> The actual IOMMU clients are the compute context bank (CB) child nodes,
> which use the compatible string "qcom,fastrpc-compute-cb". These nodes
> carry the "iommus" property and are probed by fastrpc_cb_driver via
> fastrpc_cb_probe(), which sets up the DMA mask and IOMMU mappings for
> each FastRPC session. The device tree structure is:
> 
>   fastrpc {
>       compatible = "qcom,fastrpc";        /* rpmsg channel, no iommus */
>       ...
>       compute-cb@3 {
>           compatible = "qcom,fastrpc-compute-cb";
>           iommus = <&apps_smmu 0x1823 0x0>;  /* actual IOMMU client */
>       };
>   };
> 
> Since qcom_smmu_set_actlr_dev() calls of_match_device() against the
> device being attached to the SMMU context bank, the "qcom,fastrpc"
> entry was never matching any device. As a result, the ACTLR prefetch
> settings (PREFETCH_DEEP | CPRE | CMTLB) were silently never applied
> for FastRPC compute context banks.
> 
> Fix this by replacing "qcom,fastrpc" with "qcom,fastrpc-compute-cb"
> in the match table so that the ACTLR settings are correctly applied
> to the compute CB devices that are the true IOMMU clients.
> 
> Assisted-by: Anthropic:claude-4-6-sonnet
> Fixes: 3e35c3e725de ("iommu/arm-smmu: Add ACTLR data and support for qcom_smmu_500")
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Reviewed-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
