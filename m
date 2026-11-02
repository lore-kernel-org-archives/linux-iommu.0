Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793613180;
	b=j5b0Zan7NPa3WSkF9WSUdyL2lfcdymT9PyM+EyS4/bvg9anySTa32KGUUD8/O4yZIYe9
	 BDIJ3nWnOfzky3qFREFtmqJB7Q7ungOah8TpQCza5baLdSPkiXNkG3V58zG+BgrnzVf/K
	 NPvrhujPaBoDM6f17QZTLS1I2pKGSIXToDlsRTdeBhStYRcVbn7LmdoQgkusF2MxIcabj
	 0KEh6h8DZ9NQDoViy65WQtId68c+PiGssGDF7fMao87++Z5xF/ZbDJyL051RNxIpJpWJa
	 ExLw8Ol0M83u5AF2rjjBJ64vXNboDnrcbYXhdYoi2GqCMbCDBenibiTBn1dddbRa1wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613180;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=qqXNNfzdWTFLDTehhgM1nsK5dgUJIXqhK2tNP6C3EqU=;
	b=ippWyGq9YR/htSxwW996nsv0VpLCqq48BaYfT6/fjLSqWnhtnj4e3AjxrqHx8H5l8+4k
	 a9OIQ9Pndjs8eLZAASo7p24aEp9pqBNAmzOpOJNxpWSfG0Wni/kdXnFwEoErENolWqHUi
	 8tHCeo1UlRAKGsO+Y8EC0Rvbe13aGn0HPlMh62gsKNCVWmvbo85tmxxZP+kbP0AxorX91
	 zv6CSP285PrcuXKUBLMk2xBwoXgjXlTqdZ62E+TBR1Lk4rBQxwRlFLgesG5ODGvUSJDy3
	 KIveK4KFCsVZRnpKCYExQQyuM9JZqJyic2K59ReKEhW1kGAEQyRGtQBwWG4UuTMXuLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=A0jxRsf6;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FOFEqgOh;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96A2606A33B
	for <iommu@lists.linux.dev>; Mon,  2 Nov 2026 09:52:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C96A2606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=A0jxRsf6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FOFEqgOh
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29AQKw3440462
	for <iommu@lists.linux.dev>; Mon, 2 Nov 2026 09:52:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qqXNNfzdWTFLDTehhgM1nsK5dgUJIXqhK2tNP6C3EqU=; b=A0jxRsf6GUjEBSyj
	NvAXNYXryBlm8tFkVuBHt0ZA/6r9VkWTV0G5oSYAf/GxFxVWMgZ9wkX2L4GU/09R
	FgcDx2rijX+Q1e4woKw/gN1AuBGu59l2RHrGzUdAmii27pmHlDg5yIImySEo1eKo
	yIeKqdwlbRKi/7JERV2o7QsJj2OAc58hR80VpuqV4kVxZDIZsqHLbpXxBLAP7E4u
	jAMWET0satj3a5D4U4+jaSGia/RtNpU/0QuTFYQEtxY8aHZN4XxUanzRL4rQPk8j
	K3/Oa2IpiYFHqfp/KZXf4nPXBK8nJQm5BmC0a5XJn/rk9IU67Jurew09TnPA8P2p
	fee9mg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpg201rnb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 02 Nov 2026 09:52:58 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91c7fe5576bso20010696d6.2
        for <iommu@lists.linux.dev>; Mon, 02 Nov 2026 01:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793613178; x=1794217978; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qqXNNfzdWTFLDTehhgM1nsK5dgUJIXqhK2tNP6C3EqU=;
        b=FOFEqgOh8BV2s0fTChiRACMyDuXRp3lkz4jOeTuNT7yKe0ldzuLODdVIfIzO4lyJH8
         iaDGT51w9AtPiiUref/yu3+1mWIbkSwkHAN8Mhj+VRSMOt5JXgXAfahj+E7Z5Cj30qaT
         zqoezcnAfyezTwNlApySgwLUjCaItKTWFFR/wMuUw3K7zwZEtZsBE3nlFUJDstTfC3iw
         16yCCSiqXr2qzOiJZuJKUfX2RAhBP509yOdmr43zaJTQVrgimm1yh84GODZfjKJFJz25
         0PXoGjZ9V4QVrG3xgb76QbI+hBuPuxQhApt21PIGJOMVTu7ohmilNnncZ4ZNJpyEKUQq
         59wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793613178; x=1794217978;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qqXNNfzdWTFLDTehhgM1nsK5dgUJIXqhK2tNP6C3EqU=;
        b=AsCkn5aYhdf5BXVONj4p2ngIG9ilMjiHXkXAm1YPrQB1PhIdas9QvwUOoRDvsBaJ0p
         AyOEFaUuHB/lo3cqLTyXi+hR8kfhjJ4CO7yRy/XpRLSmLIZGbds5X/xiVuX9gqKxR8Vs
         1G6Z9H9853uTFIexaF6LdK3lrUjaJF2SY8imXH9ZktaTB54uSidiFR9oOs5WcFZo9d0P
         0ryJWrW6RUHWxCX5efgQw3J0X1N7EELQ5nIxDdAoO30fNg7hocUK9Qz+dGbedDOnUs0M
         rn9mMW4vqt9j2uY1bM0BQx61MLuw9JU25O1ZCEFe3EOcx4AgohAqkgrsoyVQiScb1M0R
         2apQ==
X-Gm-Message-State: AFq9FYIBwI0pnlXFV1gEHFXjYP1RykcoJWCxkYAsBM+QBjhkq9Y++PAr
	aprJ/ETepRXirkv1s2mMlfmfECB7MTutZy3+zjPXU18sEP0knqkX0S98GdUEvNfVJW087vVj4pa
	lEGqMNdukk/znKBjZgU40bU5IcDBFHNzkNL69oZGi0T/KqiYn60VZGTZ8/Q==
X-Gm-Gg: AYBFou298pTzFl4t/iDRUhhyb9OcyiwQfzRqGKJmy6Zd+OvCugep9uXG7oWrRRA2qGT
	hOgyve6ELwprGsp+gJz/naaXJ1izQvvD6ycabS4yLmhQwmMQZUin8yLWgljzyXbZb3tF12Ce9/Y
	3VwwCU3vXcfOJiPPy7O3kIDWfch9jA835xC7/0QGYATIFc6dWU5MH+vQC7MA0TSVpfeUPNLdzLf
	zYJ+gkfNs5PJQtNA2Q9WcfOitLMJ+hOLNKPkCsa1LFvRDjSDC/sPrp9V0rVaSuijIOMqHIBvRWb
	fcsLvuLdSEhnmXyMkhPDeFABZ+tkadx9PdmrBe0s/yEF+YHZzgvXZDq8Jwd7bdzLxquOvNKQTN7
	886l3DmT2/fvw1236MmatlAhQc2UaahemknKJNoBSdQiTM0bWgBzBcUcE3CkrggGKuIVj7Xc=
X-Received: by 2002:a05:620a:3c87:b0:93c:c96c:a5b4 with SMTP id af79cd13be357-94421697192mr1483716385a.4.1793613178174;
        Mon, 02 Nov 2026 01:52:58 -0800 (PST)
X-Received: by 2002:a05:620a:3c87:b0:93c:c96c:a5b4 with SMTP id af79cd13be357-94421697192mr1483714285a.4.1793613177588;
        Mon, 02 Nov 2026 01:52:57 -0800 (PST)
Received: from [192.168.226.248] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabc18ec5sm364558866b.12.2026.11.02.01.52.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 01:52:56 -0800 (PST)
Message-ID: <c8810f27-8a44-4ac0-9c93-274894eced61@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 10:52:54 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] iommu/qcom: Invalidate the TLB in flush_iotlb_all
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261031-msm-smmu-identity-v1-0-a2a70580eebd@oss.qualcomm.com>
 <20261031-msm-smmu-identity-v1-1-a2a70580eebd@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261031-msm-smmu-identity-v1-1-a2a70580eebd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: X6rf1tYm4GvYNofdT8MolSp5eCuNBEzZ
X-Authority-Analysis: v=2.4 cv=fZY4WEQF c=1 sm=1 tr=0 ts=6ae85d7a cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=1ACtxsPTqu74CH8WC9UA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: X6rf1tYm4GvYNofdT8MolSp5eCuNBEzZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzOSBTYWx0ZWRfX1Y9pQpNL9INA
 nuDEHlW6LqRIJB6a+jsoHGy3rOyre749tSfdRcjE6DHuVxJcRTXM/GFzmW5YhiDs5GcIOq3thx2
 CamkytfguLlocsq50QrHZ6LNABQ+JP5ujxQfp37GzIT9y2Kq2e8fcKoVfE7shf6lTMZfA07VZpk
 CB4uc3O0MJagwvyDyJ0zxEJnRX8b8H64jtE4lO/onYBRMTdwt0iY2MUIvAfwUVErIcsK+PBnB4c
 UAQuSARyUHQJahg/Jvecf+N6VrqVNzgRuGLV/Jsmn+xf8ImKv84EnbWFFDmi/EOAHMppwZtZb/g
 7kulNbolQZGCfpjaIMAzuAMVs4bOJ9M6A07hlzD7/znQV+jg1FVLGSpp/k6tQn6iIfK+xF8RSfX
 LHMRjmI8sTWUdmEmI+KAC6QB8kUjO4U5nyQrrX1TmBrpH4CuYcAFIzdPc3yHVrMzBaTu1NFJ2/B
 fak7o60huiSniM/pSOw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzOSBTYWx0ZWRfX0Gbu5Cg/Os7r
 Dqa55Lcy7FydwnWH0oMebn87foYAoaMyrttFrmv2Sgc9UJXbU9BQq56MCDxo+mWynByWWkOCDcQ
 rW/Yytvj+Q0uDm43hfWC8KHDl5WJyk0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020039

On 10/30/26 11:04 PM, Dmitry Baryshkov wrote:
> qcom_iommu_flush_iotlb_all() only waits for a TLB sync and never
> invalidates anything. iommu_unmap() users do not notice, since
> io-pgtable invalidates each page through the gather, but drm/msm unmaps
> with a NULL gather and relies on flush_iotlb_all. On db410c the GPU then
> hangs on stale TLB entries as soon as another process reuses the IOVAs.
> 
> Invalidate the whole context, as arm-smmu does, and keep iotlb_sync a
> plain sync.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
