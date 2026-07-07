Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1CF3D88FA
	for <iommu@lists.linux.dev>; Tue,  7 Jul 2026 10:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419171; cv=none; b=aQZEWOl34QKSrR3ATrX7NZS+PJ9ELTOjnjd61Sq0zmNZz3Opz1RZZH96nySvj+CDawlywauniU0chiFtrmhCXXinQzbmZaOLp+vd2Q8Em6Oc4P27eQCsXUTewmc24/30Pmyuw2OZC8CKT6YhEc8y74MKq2W1ysRtNssuwHwjsUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419171; c=relaxed/simple;
	bh=ESxyEB/tDsAO+oi+pSDFTqjZIxjuG8H3dDWNdmAQcac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oNgJBDv9cWNTnjkzVJtTgoTjF2l0K0YgL7v8wxp9FUJG4cgSc9ZD9pVHdavIcuHx25truAWFteAeax1Z2LRyYFlc3XIAWRoS75hU7Ayjp/KdHWoAnfv+vMZK0BJZ66qUsbCilMRYKA//GNLASM4iaEGQLkvy7Ec8QXJQ7ugR2ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VpA58R8J; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HNA1cg0Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VpA58R8J";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HNA1cg0Y"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6678Dboq3219300
	for <iommu@lists.linux.dev>; Tue, 7 Jul 2026 10:12:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ByMXdijkHl9hu7GM8jt2AMzJWtpO0+9CnetiEbvOVzc=; b=VpA58R8JiSlVbUdY
	S6MHesUXfkwIBo3HzMez6adaN2gWzDQNMFVx+ZUl6tnES3W6Tj7pt6rjlanvjnT2
	o/GnGIDyN1LLdP8ZAQjUn5H9g+jqKQbT/8WiEiA5LlB8OHGlELSDOY7sXwVeBuxM
	4EIFlwi4NOfosfmkcncRQYCNxqXSP+S3tGmodsagdfWod+a+tOVUPuh34/QB30AE
	Svx22pQiSPcvtll2QpJgf6rGYIdQGtYXyJ1ve+H4FGtlD5ZTHp/zXAGmt8JO4v3a
	sa++8xf7Ka1c5Cwq8TOl+nzZsUl2njze64TKgSiVxSwg5mWPewNTIrc0pgltRBFb
	Q3pCtw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8wep0jvh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 07 Jul 2026 10:12:49 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1e777a15so7618811cf.2
        for <iommu@lists.linux.dev>; Tue, 07 Jul 2026 03:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783419169; x=1784023969; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ByMXdijkHl9hu7GM8jt2AMzJWtpO0+9CnetiEbvOVzc=;
        b=HNA1cg0YKgKHiISwd554vL1pYPo5+8jSU44Z2ZZHbNdh34c1UCfHPtZwWWi0ZQvuMk
         o4H32IhFKvsnbkY8s53jled9w8l0l2gRSAszlRo0FXqXDyQbZfP2bV+qP9JO/s4XyKe8
         DyR9ntCmSVEgjGnUcYaDsEneQOjKusnMOQQilSq+ywTdSgX7o0Igk+VghrUqvGbkkV3L
         1mkrzhEQwspAsztPX7RO7QgiPREsJ+GiuBbX8ipNxp4f7gj5HpL7cl5OyNhjz9gx4ws9
         0NsoD5ivBWNKa4MTaH3mjk+ij9YfduoZ7QM09FaxjnZv35IEShs6Sg3A5tkyNwOQIGCZ
         D7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783419169; x=1784023969;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ByMXdijkHl9hu7GM8jt2AMzJWtpO0+9CnetiEbvOVzc=;
        b=AcLWK7hDELS95jsOW+YDHa19VMERQJtLc43kHkzCt56wFgq+caL57wkpb9+AZaiOHT
         ldiM4w2ZAZlZkoryOj6atgGpOGEdIl8KQqBEBkU61JxRerERjQU6WsDODxf24X3iCnVc
         D/4Q11fav7ebeA3ucylp+vw830AhgyQZZyoRR13F+OVG+Qctxdc58xCwZTcgvq2hSt86
         ZGi+oQr9+9k092EQRgp5OJLBOKPDkebTkcmqXxpUOLpvQ71AFVzGBCsG0QStTpp39ZQm
         1/46MFT+TZr3Wx5JhbHFZot9MYRd2mf6aAHjn2U+nUpUYUDWiNtIr2AcUrCnLgUoOmfY
         QeuQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp4peNaSjNcr6WVS2vtPbNFyPOFedQSJD3CEQHC26SbpPXXN5T+wQGC/tIBBoemd2wLR1G/jA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzP4U37KdUlf4PAhyBhc8k2VFkGNlwdwxS3T5QGIkxeqR8QQ9it
	Al+c1oHc5Xy11fWPWJ9YMdUQtXoxpZWBrFEeLgTD05ApL0MfV5TkK6whnw3pX3d4CR4PNFlwnCy
	ZsdN92NFJ3rbo0OHWZ2Mn5K4GODgxY6U12HbZJAKrnwcwDuHPQChIJ5T3Pg==
X-Gm-Gg: AfdE7cmn2NYN9pKZpIxfWf+oe4lOX0CnVGJ+Avb5SpGrp6qOGuTceoxhLkuM0XHHsKT
	ofrF5egLRCpSC6YjC0+Dg5nxm83cXVQOF/OheqDuDf79BJJkaW0HMZXBwY6v7x8wJNpkyTtdy8B
	ZwFsQ51PDOXZLyzN1yjy/D2Wlv/No1wn/v4D6B28zo3qTbyNUa+TxMiIy08HyGHj3Ng54afwjHf
	XgY+lG/JQ4GOgIFnBd2ePR5WTDDqJO6O+dHYbelxi22+nBknQAZdsqfxn6TmoHdG55XosrTicSL
	vz/S1QwykxoBI7onnqyK/PzsRjoqj2gwwXmGRhnp29AmMaRN74z70Rgt61ZjiCIhNkwBS2efuwp
	yT+wP+7jWzgBLO++mXcZHI8fzfyIM53i8S6Q=
X-Received: by 2002:ac8:5a0f:0:b0:517:57c1:bbdc with SMTP id d75a77b69052e-51c79ed34b8mr20269431cf.6.1783419168905;
        Tue, 07 Jul 2026 03:12:48 -0700 (PDT)
X-Received: by 2002:ac8:5a0f:0:b0:517:57c1:bbdc with SMTP id d75a77b69052e-51c79ed34b8mr20269231cf.6.1783419168432;
        Tue, 07 Jul 2026 03:12:48 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15ada057bfsm98437966b.43.2026.07.07.03.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 03:12:47 -0700 (PDT)
Message-ID: <36f4507c-2524-4a9a-b38a-7d061d13cd4d@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 12:12:43 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] arm64: dts: qcom: Add GPU support for Kaanapali
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260707-kaana-gpu-dt-v3-0-8dac9a60dd5c@oss.qualcomm.com>
 <20260707-kaana-gpu-dt-v3-4-8dac9a60dd5c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260707-kaana-gpu-dt-v3-4-8dac9a60dd5c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: NLUCESrx3ggTqoCW9k-vjS3uatkF1xIV
X-Proofpoint-ORIG-GUID: NLUCESrx3ggTqoCW9k-vjS3uatkF1xIV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA5OSBTYWx0ZWRfX3mmWhaP8245y
 5tOIseSKTn+qr6IFEdFvJkWG9TooYNe9ivcFQh3bN5xQL4IwxQB6hFw71QOvqyiFtR4PbUiwQFK
 YmsW+fGPtS4zWibMi+8wUL/bL9o7hfD5gafu5qUMfrzk6pIMhJ2/hEMZ4JbhLtDywPzTsu/sMFY
 lg2nj7usbbgSb4Cf8r2sbjkF1PXU+BUiARNcqLHoNVyveZ/L8Axzb/O8JPDXWaq7xjOUE9HpMXp
 V/rz7TcZFEUMXjx96LTuHkPl/R7MjTHFq+ro3ms4bZ7FQWX7buxG1jnWgyfBWZe+wByBfJoUFtz
 anRvs3gQ+zgnAnAXlPInRuMrVS1/oKYAoAmzeuPj67QNEihiZngSaVgIYBvpxBaR24P7aDBTLhP
 z6GfIE9dU2t3Bu5+aCChHY7nf2DLzn6Kpc2ozF+oCvEDkAtTYtU8qz3GNQfV41E+TrNhgfOp5c+
 VFWRs4bsxOIx3yxByFQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA5OSBTYWx0ZWRfX52TmBQgS2QNj
 CDSl1mHxQUYgnpI7PT72lWg+PtUJsWt222uNbK0+gbbYrN+BJCsTjPvBauZQQaeO/vcdevYqOhl
 kcqNXSLWeK3TzUyFxaViEQ/2+POXkcs=
X-Authority-Analysis: v=2.4 cv=atSCzyZV c=1 sm=1 tr=0 ts=6a4cd121 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=z65YV3W3F_EkYOo9s_QA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070099

On 7/6/26 11:40 PM, Akhil P Oommen wrote:
> Adreno 840 present in Kaanapali SoC is the second generation GPU in
> A8x family. It is based on the new slice architecture with 3 slices,
> higher GMEM/caches etc.
> 
> There is some re-arrangement in the reglist to properly cover maximum
> register region. Other than this, the DT description is mostly similar
> to the existing chipsets except the OPP tables.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
