Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733D921A447
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 14:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763388708; cv=none; b=aTBH45kV2Uj49tlemEy1HyPO1QpEB2xbQfTxLrixvpkMFcWs7lW46xhaSzDyzbWlaBf/n6pZ223VY30HlQoWyIX0y274KZs+/FOqVaqbSTHf2ET6fpfivHL/JgyaBnmJgS0v/RBN9461gfcWaexu9Pj49YBhjl83fe6RtiaLNV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763388708; c=relaxed/simple;
	bh=SU7heSg5zapbqrEFBITwtgnp1Q0ghfjt2PmWzfpMmCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NX6j5wa0nzYxBMKTrBV67dESJHZJhI+EgOCaVSGpytqLKlet1Cnd6hw/8OHLvCs3YLil7WdCRPZVB0lgZa098NYmf2rbeUncRoun/gPpGbuW7RjVC9di7/6nJ9tosrfOA1iyg4zKauiA3StAf+dn1zeU26oxdVT6NoLn4E78CRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VwW+gQ1b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LT/9QToB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VwW+gQ1b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LT/9QToB"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AHAptXC3921031
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 14:11:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j31M6W20uEBiKJiOsyxMXe5wI1O9DbfibFtCfzdK93w=; b=VwW+gQ1bZKZ4bchC
	0eJAWTU0VhFxfW1xuIn75ZsOvLyxTQrNZ1t8te6kxDyjM1hZVtlBS5t7caEgkLne
	1cVCEybNvgdIr/8kSF6m8DwZxbJ5HES/sOt8tYmLsbJ9S8TVboE/HkX8gceqA1TO
	/My0IsHahPTUpNJrusBF72DkQ9NgV0eAKTvwYwzIR3Gl9O5KDpIeQiPu8RlccaUH
	a54WhQPVksyZz+wN3Ip73+XBZo6poBe/3quHKAJpSr5j7RGUIS/YOAzBZ4J1dxi2
	6y/XlSMOATHyo7jb5IgPoEfEy8fUy77ri1l0VTdpC4cwlhRQvvpNx5UhHurjLZ+3
	1gEbRA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ag2ay8htk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 14:11:46 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-9352023accaso206005241.1
        for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 06:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763388706; x=1763993506; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j31M6W20uEBiKJiOsyxMXe5wI1O9DbfibFtCfzdK93w=;
        b=LT/9QToBK82hhD/Zo9+Ya++q64d4r8FLvculFa/seOpNrChfFuaPTo1Q/4TW0Xw9qd
         EfL7wqmO0Sa8WylaExWRoPmALHX84Ft4y2r+ciAbMAmIrWVnNEC0cTn1wUGAJzr7coll
         alPSS9x3psgOCCuaSfCzpmgn8CWncDbXqO/jka/Kvdwf0Xq0OYpJctkHyBmSRqtDkQNA
         wBbdGwnI20mFAZnr7CE+0G8j5L+oJd1F3+xMVJenLNje2+hcE24YL4icu0hACy8xaLj7
         ppRceUjJN+8XheHdLrm4IBSg+AyuvzXEZA4DV6hTUGvFMZKDxlisyvT/1RC5e5ZT2BdG
         3/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763388706; x=1763993506;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j31M6W20uEBiKJiOsyxMXe5wI1O9DbfibFtCfzdK93w=;
        b=GJYROOCfkT3o+Tgu6It45P8fUOybjrzQ9xww6IznjBAA7/aZB8ie2aT4Q6RrZaMTkc
         mN+HH7M+rfb+GVH1FUyQGlRNtuL+fzz7j3JI/v7mpVXYM9tzYO/qFmp2mYXjyWCXPKAJ
         lXmO9wzmWGPyZh3A/fikUlsEwhoEBbP485faBz1qdWFbJVgJmuuPp/+BTUXxbCWUwIEC
         iN72YVXq38/8pdtO7MDPDMXKq0nMPRfF1gNuK5HZKFXr64P/QujkQ5r22ia+JCIYTTEb
         2hyO5tJIVuYMqiRjtipXZWQjbYImlODfSca1DN9TJ81Onyh+cFG/6Hbcbt2v1SVa11FD
         2+1w==
X-Forwarded-Encrypted: i=1; AJvYcCXBCOt3hVUHxe6DlMtSl+GWxoBn8SNt6hBnZXE24CACpjqgSgyVLGC0sMyOGESqQoEDmX6dsQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyUKHhNbO+wEXmEvjKVrGjgHcDte6O9/0cohqsb5cxqFJC0ATup
	GUpUryFnpYKRfmPVplnAvLxQHb31RTjbiETa7BqLLt6aDvLG97ADORrLByjdU89fiyj/Skp4d6l
	NVWG4sEFH2LIqALUiTys1Y/xLunIiIlRrBx/2fllWMTTJg1yxpDvOE3N4AQ==
X-Gm-Gg: ASbGncuqje3I5QIN6BT+P2xsLvKud33pfYV8FYLTNGqU1j6rfvi7RWa9ZTHGXBSXSXx
	Eli1Ql8atq/2i9JwOUgsQpVVlfNFrKWaAVvhi/cvCN//HwJzmXJRVibe4ejPHBvjllc78njFS85
	fc1jbEKMOn91Gij92leixVBdh15tFaKyVOBnkFysujtNuGrCMsZR+3zdRyxlT3mFdp/nBpgvZ3O
	NwcApDErtTUHN+2TY+6kBFdKh3ndPzTrVQ8HxJxJDIvRC+YGMGpHHeTXSfgVRrMi9l4dmNdV3iO
	6OQABeeQHXtaMyBVrSs/oho4AVflMzqlk3mv0pzzwjwYI+eXDb+uRRmzVj74k8j9gj1uHUK9Y5o
	jV5FvRXa0Jpp2vVr7g4szmRUCQoZIZ8r7730z1IP7/uXXR+SKzpTkA3Sk
X-Received: by 2002:a67:e703:0:b0:5db:ce49:5c64 with SMTP id ada2fe7eead31-5dfc85a1070mr1838391137.5.1763388705829;
        Mon, 17 Nov 2025 06:11:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENBd0uWmCrys3Bjr4M1SOKmS2/3SUY9Sd2AfbAO69+iQX3Prr35SDtghb4rlEALS2PgI5ogQ==
X-Received: by 2002:a67:e703:0:b0:5db:ce49:5c64 with SMTP id ada2fe7eead31-5dfc85a1070mr1838348137.5.1763388705349;
        Mon, 17 Nov 2025 06:11:45 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fdae69fsm1066684766b.51.2025.11.17.06.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 06:11:44 -0800 (PST)
Message-ID: <e2d50441-bb32-4a66-b00f-7c656c8817e1@oss.qualcomm.com>
Date: Mon, 17 Nov 2025 15:11:40 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/20] drm/msm/a6xx: Improve MX rail fallback in RPMH
 vote init
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse
 <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Connor Abbott <cwabbott0@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org
References: <20251114-kaana-gpu-support-v3-0-92300c7ec8ff@oss.qualcomm.com>
 <20251114-kaana-gpu-support-v3-11-92300c7ec8ff@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251114-kaana-gpu-support-v3-11-92300c7ec8ff@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dL2rWeZb c=1 sm=1 tr=0 ts=691b2d22 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=VffenE3n-DyGx4saXfUA:9
 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: olDMBRfq2lDBuxFejB96_9vaw4gpaPBw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE3MDEyMSBTYWx0ZWRfX+kZw1od4ZQDB
 h29g62BPEEivBGkub2rVrgAfqa3VpGWljYhMfmVE2BLxmzgkram/1QZX+uxwUwvc/+1arBPvllj
 1nnQZRLLVa4dHXfRyri4TlehbiPniLYiIG4vZ319tyIslssxsJpGYcPmAqZZEhtRAjXVU6UfdFd
 Qo4OKicmw4mhp+g5NFcXgCAQgYsDYmAJaPBSxi2sm2A3ZZMaZHyCL6PVW4S7vdhCkEXX0VuVSIn
 58Cr1Wxkvjny3E5iLu6PUBgYaQbhlAnoMHo5dYtyRE6m7H4R5uYGZcuesKy/jPnkqzCrQyJ6B+H
 137fqOiKoAyp+iQf2FhjA8MLAVgrHy15KVVotOB1h7r8XaaLMuUzkLHlDDmT83vbZimnUFdZigy
 NM9nS6FRZKsx4no9y9tiUHrO3Qit3A==
X-Proofpoint-ORIG-GUID: olDMBRfq2lDBuxFejB96_9vaw4gpaPBw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511170121

On 11/14/25 12:29 AM, Akhil P Oommen wrote:
> Current logic assumes that the voltage corners in both MxG and MxA are
> always same. This is not true for recent targets. So, rework the rpmh init
> sequence to probe and calculate the votes with the respective rails, ie,
> GX rails should use MxG as secondary rail and Cx rail should use MxA as
> the secondary rail.
> 
> Fixes: d6225e0cd096 ("drm/msm/adreno: Add support for X185 GPU")
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
