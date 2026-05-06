Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51B540758C
	for <iommu@lists.linux.dev>; Wed,  6 May 2026 15:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778083002; cv=none; b=F/gQDWyn669d1LOc9/pbDxdB4KKW5zxOevTggsz/tFeEqklOYXbx2rXPjiYjdigU9c7MDtVScrraZ60Qn9XaEl7Ks1tGJMcMmlX2zOX/JoF/k7zX1ZmomTHg26SJKvB7b12hilShqYZd6UNu06AWfmbv0Wfz6IFGetH3pKYigDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778083002; c=relaxed/simple;
	bh=slFlcG18qKmRJPdDvfi5FDwm64deTGUrtGeGdyAySDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SdWHWqu9NNdiGBxWdD7VzhRecdn5kuXvzQkXvbeTNIDYbf1XLsa8cV9rV7cBaWEdXNY0xiC+On1hKktIdQlvkQ8utwIAavWls0j+JpUOk4D0eJq+/m5SbSNliFmnABH1jLmTnWmmZoILkxgo0ZAeBWCqZkqAlVEDRTn3fUIJyZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lUxvZK/P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fz/efyHC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lUxvZK/P";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fz/efyHC"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646BQHSx2581357
	for <iommu@lists.linux.dev>; Wed, 6 May 2026 15:56:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0hbrdNEm+roBJyCislrqsmK+OlBVhAX1OhZtfM4e7C4=; b=lUxvZK/PdTXLb89b
	kOoFZzfSwhMEpLuomTDMDCEb9V9gM+reKqMbt8imv00LFL4ox2+0XRRxQQKYs4H/
	NETs2OgFotrUI2GcCrm7MF+nNG4n0jtg7T7bvOAZuMSXHRJO+7I0Ap2ACljVhWsI
	3yk+jVM3ctQiYEa2TFQR/v2V0wb/DS9nkAU2PlK8Dg0TqRLSTlO0wAWbN58oJyjI
	yRpcUQDms2KpkQk5y7fVN0D4TpOkiK+tRcE3nDm+ezn4J175nyy+POEhuepbYwjX
	7ILtgxrunRAwI1Vk/7/V5qzBGZU3w8n/0FS4FbXUqyywjAhnMywFnbo+musI0766
	x90uCA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyyvw2bca-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 06 May 2026 15:56:38 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35fbaada2f3so11937830a91.0
        for <iommu@lists.linux.dev>; Wed, 06 May 2026 08:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778082998; x=1778687798; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0hbrdNEm+roBJyCislrqsmK+OlBVhAX1OhZtfM4e7C4=;
        b=fz/efyHC0r9LXKq53hNjw9mmJtCdBHDgpF7iZlyw9TFBBxTkXcvLc9JIkAbCfYbbOo
         jEqtm+vDOMRT3brgBMksb8Su0MKhUMgi+Q4LEsBP3+SnT14mwQXiMDXVeqqwinCsfq2Q
         7QJfEHuW6csqe+BnRXEB0EyvBJNFp057puz8cioVyZXPPXGrojzQilOXFMnG0IzEUNuq
         zTpnLjCG/hsKrwqHkocj+Y0cEaG+H+wuMBm1Hjom19xJs6SWMVDEuE5ZuA/MuuLS6qUP
         wjgqVcELIMZWWHC0Wf0sMuKnHZI5TGSyMsv3ezmXDtHdr4IYEdvgGF211RZUVcuv+8OY
         1MLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778082998; x=1778687798;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0hbrdNEm+roBJyCislrqsmK+OlBVhAX1OhZtfM4e7C4=;
        b=DrEzcmBmFhxvHAKYfjFQsNbEFhJZAiCg/kFC+mldnyhfs36iUyzjozGpf02SXO+wHx
         wMn6o3eXEEDegVfpGlw7GviTR0cRPOYsNIeOBwaoSw4RtbQ3hAZywKv5/Igv+KZDdTK0
         KP5jJj8PyF+YqVB4KIjDxeBrK0T9iazzn2KnMMWJPVyyIyizNRGN4kjwDYLS4LN4SuPd
         d2AIGgUTqW2doeQw8iAI5F9wercX771nkI9C27b3YrBkI5SLlrvMHTB2aQiwcrZHW6JA
         Yd+oQWaPN+oRDiPIGNcX1vQFe6BMvwZ8pXn51aR5BXWvrEonB2VsgfCqyJGNt2bVZn/m
         IuFA==
X-Forwarded-Encrypted: i=1; AFNElJ+XRFIKCh0x5S7v1aMel+23KC+WZd6grQ6M3iiVoXdfzwDUUfsxr1xPjR6Dpw26AiGNJCbNtQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzLga6fAqZGaPIknHS1i3hPZkRxc16rRcio6lfEc+JNvSzn7Hxy
	Ce8AzayxUm1zJsQBllSNnZtG1qEniHrSQQERVqrB7ZDYN92aqfOql+/gtUyd/ULlqlVeM6AUmex
	XZrjnXNI6ogKaOeXDZJUKPDvaN9R0sF800sBobMWJhN7Ue0Dv68r2DvvchQ==
X-Gm-Gg: AeBDievpT3cKggvm43D0tMiBQCD5bisGTS2ypY0g3fUJsOaDINtHl2RzAbahYt1/Mpx
	WQgsN4DjlLEB9VheK7VUSt2jIZVywHxtseSWEMxGopcuW0ZRsi7k22qg3YtM193atfW0WbsGHif
	jOhn12ZSd9ndLdGEOq9bf4lQ+wuxYk9W0jOff9/FZxFfofAvNKC8z7N7PGj0byawWlHMhO/mKo/
	3qINHd+X5fYccRVItN8rl8GbeIG7yJYtafNvnIwBZ0Sz29cmRpSvklYNrvXrL4wwYNMaYJFFedt
	juMFz1lml6nR9KHkbvvREUwQQBEgJZQt8m2V04AE6s/fCKkiObJP7JZ4uvUbRPrz8Nik63H1mJd
	5G9yyMbpKU9aPcR00rIlmzwdkobCNcWBHvax+Ht0xUvbykOS+5HMMayGhOuTm8yCf
X-Received: by 2002:a17:90b:520b:b0:35f:b293:7ac6 with SMTP id 98e67ed59e1d1-365ab3e6379mr4145725a91.6.1778082997969;
        Wed, 06 May 2026 08:56:37 -0700 (PDT)
X-Received: by 2002:a17:90b:520b:b0:35f:b293:7ac6 with SMTP id 98e67ed59e1d1-365ab3e6379mr4145671a91.6.1778082997424;
        Wed, 06 May 2026 08:56:37 -0700 (PDT)
Received: from [10.204.101.47] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b4bd8debsm2886209a91.2.2026.05.06.08.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 08:56:36 -0700 (PDT)
Message-ID: <47413644-1c3e-4668-980c-e60f7b8c1352@oss.qualcomm.com>
Date: Wed, 6 May 2026 21:26:29 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/13] media: iris: Add platform data for glymur
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux.dev
References: <20260505-glymur-v4-0-17571dbd1caa@oss.qualcomm.com>
 <20260505-glymur-v4-12-17571dbd1caa@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20260505-glymur-v4-12-17571dbd1caa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YYCNIQRf c=1 sm=1 tr=0 ts=69fb64b6 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=2SVvIUmmVaN44YnEgAEA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE1NyBTYWx0ZWRfX3EtZY9E2eaVH
 qGq/fUHto4LxluBsIKvDUQ1GcyC+qyu4BcL48enZorZqHS8ikMzhMFAMuzLGJ29d2zcXjBV5prb
 OZm1KoiOR/Lhk5Mu4xUn2DzPPtGP3tSQGJO8HegcazhE2ocFxKj45LGmqpvTB2f6NKutg4IRZIZ
 Fi6Z2QYL4jaO7+pT/oEUNCiqMnHxM6ammnepRSr7YjsG6//JFytIDgAqoc9Lyt/adQaS6OWlcxe
 lPGFo7QCF4ZhTn3K/UzzlwA6Tqa6T8B2Bhx18NtUb74YBJEDkKv2adSc57K++L4hVBsrkHfF0p6
 8jpTXk32QyUhNJdmS1b7MX0fR1soUBmDLg+HXJerCW6/9/6Wm2Ba3ni5lfMO5AkEha8sTkHzXTG
 p90ehRfVl6WJUoSTa4VJrXkelqatEf7X+N25B9mhxLyaei39QZ0DMpuwYwhI11plJW9z+d2xQl9
 wsJP1xC00lM54iZNEdg==
X-Proofpoint-ORIG-GUID: vFpzTDKheYtx98HDmWJ4i8SypbbTa4zE
X-Proofpoint-GUID: vFpzTDKheYtx98HDmWJ4i8SypbbTa4zE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060157


On 5/5/2026 12:29 PM, Vishnu Reddy wrote:
> On glymur platform, the iris core shares most properties with the
> iris core on the SM8550 platform. The major difference is that glymur
> integrates two codec cores (vcodec0 and vcodec1), while SM8550 has only
> one. Add glymur specific platform data, reusing SM8550 definitions
> wherever applicable.
> 
> Signed-off-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
> ---

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
