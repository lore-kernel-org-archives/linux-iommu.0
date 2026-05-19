Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD08D37C10D
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 20:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779221238; cv=none; b=S7MKwnpF+39i+0j/GAO0FTOLjAunzCsV932nbcU/WSuzx0NN8nMdMePZ9khT2Nis1kBIaV6K8SAgUumCG7Sl1zk6i/v2RwDr7hppterBvRcMRrjlOx7sMvffbJvT4uisM9HbOdWcEde2pQbvy6WoA7ZbKL9VWI86eT96u9Dz0ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779221238; c=relaxed/simple;
	bh=I3qvf3gT0P0uVoQM2XWb30Vlt4Ack09Ywc4NZ7C3l9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CgcuDyNb+GsjThP5faxxDN6+uTun8Jaz0YvcKUKk+p4c/XwR8cusSGPFf1jrc9DywIbZWDH0Skd7+AzM6LvEEVw96KkfTeP2yCrLR6E9ZFmVLiJD/b9ADjP9zF4F6evwh8mjJyhRA6x+Y5Sv3/i0J/T6tcuySK4qoJ9Iy8/XlOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KsWt/+Ay; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dnBsHk5R; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KsWt/+Ay";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dnBsHk5R"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JEwl7R1636916
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 20:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ba9sE4umteuJuCK8CmKc37MvnxwnoKBH6bwhBFlN/h4=; b=KsWt/+AyyZ18HDOx
	3R8LW0sLoYxT/yBK++2NzOnX6QsXBuM6qaIFxOhY9uM0QMxP89hsXS+STtIVIjZb
	q6Q+66jkiZi6a6AKeFu3gMWazqKWXFocy3QtkjQkRc01JXxcGT1V42WmLUq7EW4u
	c5DVIvmzOBUshd7rFamrs39ROOZ9oi2QGNO57J63HrrglLeeMaqeRUHznzVrYKop
	4Y1viN1hJSt6mj0IHah6oSkP7Q4D4z7+hLGJT8DEM8R2btZAPkrUCgywyxKI2gZK
	udS1x+f4qzqBb+KvCsEay/rZSX12ClS+9THvcYLnynXzpb8IEKMkGxDOHhHnn64L
	syErBA==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3s9900-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 20:07:16 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5752402f5e1so10976341e0c.1
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 13:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779221236; x=1779826036; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ba9sE4umteuJuCK8CmKc37MvnxwnoKBH6bwhBFlN/h4=;
        b=dnBsHk5R7KlPsocn3jF4p+EkRAqwYm568hxnT7DDkl6kFar6AsFWrjhl6VlX+B0K1F
         ZpZZdhjNA6fTG/Msi1ZlprjIyDTunwthyUxUtVFFKII+o+7mBw8St0rUMdzTiYbtCYiR
         9gFB17vUqa8fuPDbS0D0utYKVra+07GRbb3sfwDZqwL/EQyZGwV2NemjqE2nJgM5bmdF
         Qj+kXC2BeZfd6wg1thViMMVUeABfjlXgcMFxhhK+C8CrU3cCL4koEcRzUDsGYhmfRDkx
         DypY6HEgqszFrFP+pAQibY9NOJ5IKNKcKpeLl2kpwIaSOu/SjdntJncPev4oQD4828/R
         o/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779221236; x=1779826036;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ba9sE4umteuJuCK8CmKc37MvnxwnoKBH6bwhBFlN/h4=;
        b=dSwfRTC+FgouCsPKe6mjL4GUMiOkeXLhnqw8d9JigvJKM8oxr9VE2Awalbat+d/HWx
         /RpYEDuLi1R8GLcuJECpwChOozqshVY6lOSRBXlZI3Jp3S3rBpzRKcwsuye39uSeU2X6
         2dM4upTuEmF776jSH5qNtFFgowI0VNmUWLMPNa7P6bJAkg+k37Hg9dy75kp1Ni4iQsqz
         ZMN+h2iF8xJE73byfEVCB1MnMcPmQrVKyrp1OkHCXcr3AQ+hDWsU+2elFM+0rk0VMbNG
         rmwe0aRyenueYgCr0FQRFg/ur6YpN0NxjT6wrFhokwG8k9ED2WLiHUXOaBIED1QF+ogg
         DN8g==
X-Forwarded-Encrypted: i=1; AFNElJ+d5JcsAAHm/ruX71jFbK5LDSK6y2ZE/zi8X5gTe58F5XReZxWyTVuejKqY2bFLkkyL8IEtvA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxfucb9b8DsB+LYLgfS7+L4YEZnTsNahzd9L84sQ+aiC/buDSlq
	t5V97UU2Qz4mc8BN3cfvcckAiO0fBbvNTjtgz/H5W5KcAUtMwrMurMEhga6bpfNU9P0UmS/Bcfp
	VtksSgqVKY8my4a00MCrKg7xor/GJ5pZtmWoNErgpDsL+USrtSW4Z38UFew==
X-Gm-Gg: Acq92OHw2K43TK18+FAhRf5ZH/n4K+pxoRj8zqy7ZkFYpFee0TMguLmsfEaaWpUjrcD
	MOXJEK3ngu2omM2t+UokzoT2RJQ8+FlwRXLUiIHha/nF4UdGvvlFtV6lBCfYbPQhMB8mGLB026Q
	91k4pacno00b47O3chwV8PDQ5KEIb9hoZ5k0lsEXawX54n999ZdFfFfY8uT03n16y697HDFkuZU
	bHMSqcjVFgRE+Uq6TC+6TC26fYcBNygQpXHdo8VabA6nIEsYxF8mCnlK4Fist5EM/6Wqeu6+K2t
	3GCQ95JV8b4SRYlwzWtwOo4tNZxGDNCfFq+sU/3it9Gn+Rks5Dx1btfJNLVxVBYeB+pGl4iCRC1
	W87Co/wFf4GV0Vk3RSJWNG4du4pp7B6xvb1JsoKFZhDXr7uVuPecK1mtPFls=
X-Received: by 2002:a05:6123:128:b0:575:d035:8cb1 with SMTP id 71dfb90a1353d-5760c096bc8mr12568321e0c.13.1779221236350;
        Tue, 19 May 2026 13:07:16 -0700 (PDT)
X-Received: by 2002:a05:6123:128:b0:575:d035:8cb1 with SMTP id 71dfb90a1353d-5760c096bc8mr12568308e0c.13.1779221235900;
        Tue, 19 May 2026 13:07:15 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feae166dasm131131645e9.9.2026.05.19.13.07.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 13:07:14 -0700 (PDT)
Message-ID: <e8a78a17-7ed6-40e0-9da1-2e70be5560f1@oss.qualcomm.com>
Date: Tue, 19 May 2026 22:07:11 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: arm-smmu: Constrain clocks for newer
 Qualcomm variants
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: catalin.marinas@arm.com, kernel-team@android.com,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
References: <20260519074059.61405-2-krzysztof.kozlowski@oss.qualcomm.com>
 <177919680700.851863.10253442471292780349.b4-ty@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <177919680700.851863.10253442471292780349.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDIwMSBTYWx0ZWRfX/K6i1jbBSDOG
 JR9XQX5BbYdw5+MutQtvFFXGFeyBVWilmZB7Lmfs4M+M1OvcJl1QZ8IYMcdBr850c8ZZc77bWP9
 vrs7aVMbDAoVSIQBmQDO/Mm0CafbJjjI9WLtVVEUJzjPKO53LOuGxtenKjfR4/lfnTkYGYpxiyY
 mgEKDaAa1sAcUf1wN5V/YZiti1fKWrCiQ2TAbxUkMv//k+R4XE2d5sBM2e9h4RIsT2CNu9fHtku
 ng5Q4ykWBsLfRrhHA03eaDukOlVfQOGyzX/Ed0w7ic/F/JLigtgLoQ43xWTtrjZrKOCLQ5qudqt
 ZArtncstyYdKCPjz0muQIm378eUamXayL7E3eqXGVg97hTrOM6E1DruMTtlxuwi1ziByfrkbSGx
 1nkBhP+RV4hHOU2qRBemSI7xSpyLWbPOPH4rTmOSSP5JeplhIOGdBvcGLcbwQifGeXroH/aimDD
 86LLrKB8LzSYU0Bmcug==
X-Authority-Analysis: v=2.4 cv=Oc6oyBTY c=1 sm=1 tr=0 ts=6a0cc2f4 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=-VkZa0qGcWT4bW_tupkA:9 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-GUID: B3jy33dVuwR7v0gpd5WT79Na0qWBkong
X-Proofpoint-ORIG-GUID: B3jy33dVuwR7v0gpd5WT79Na0qWBkong
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1011 bulkscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605190201

On 19/05/2026 17:23, Will Deacon wrote:
> On Tue, 19 May 2026 09:41:00 +0200, Krzysztof Kozlowski wrote:
>> Many of SMMU on Qualcomm SoCs come in two flavors using the same front
>> compatible but a bit different fallback:
>>
>> 1. For application processor, usually without any controllable
>>    clocks,
>>
>> 2. For the Adreno GPU, with some controllable clock(s) and using
>>    additionally qcom,adreno-smmu fallback compatible.
>>
>> [...]
> 
> !! Please note: this conflicted with the Glymur GPU bindings update. That
>    was trivial to fix, but I've also queued an update adding
>    "qcom,shikra-smmu-500" which you may want in your list of platforms
>    where clocks are disallowed?
> 

Thanks, I will double check and send a followup if needed.

Best regards,
Krzysztof
