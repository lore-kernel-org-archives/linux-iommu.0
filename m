Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446C733891F
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 16:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772210958; cv=none; b=Wbk0Tcg5gx0XqpAYmWSq50AnwcSbcDg+vQVqE2OxKWegmV6FFQtH4hBtuh2txrMs/6PZ50L4bebJTp2Fu6m/EHfYFLsXq3B1XkjoI9lXJJ4Au8aDjdyQ9IMvWJrBGGTqVHR4IFo/Cq/yR+1OveDLh/uSSh+R0sLIb18wG6Pb1Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772210958; c=relaxed/simple;
	bh=qS+jq1JrvcU5hElzUv5cMkCRMKosDacHXQdATwP+kLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I1pk8mXcDVjgqHctBPFZcWxafnPuXIPHDZLBazjwnp0pbfnhsy2NfRLCsniUaNW69pImRZjjEk1RNxdgBwkjcObddEIL2FW/NfjmrP/vmLVjzxETkfisSjImYxsNj5vGZSx+ejqO+kLHTQG2mjEO4BjYUkcSx4XeDkuKYXqOZdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Htr0BPJy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VNvoBn+j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Htr0BPJy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VNvoBn+j"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RGjL2Y495097
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 16:49:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GF8gzs0Y2ObftuKtilXKIdvF2o6qLBxvxxDd8LVJ5J8=; b=Htr0BPJyfQzNZWnH
	KGwS/K4b90TqkpIVkjY0WQe6wv7osT/++zLDbJdsOlQu1wgmilzT7eDC5LNmjtBu
	IlenPEPLjuXuquEQTglM37TkAYLMnDs4mKZWEg8xDM4bioZKTH3GWGBSwnOg7YyT
	7w/lZ2t6yKpOev3+azKx/xeNjxEfSRHZmAxuUaJlcYXapHUVVbO4FoOs3OAW0APm
	mUdv8HKkeat8x4wHvfBDsRCDcApnTWrd1OWtuU6Q3zZ/7d9JCyteLxHjzql7M7e2
	hL5NP0g0Wal1Areu0rTQ9JeiMT0iYJfEBo18krSVBCKFe7r8wdIqrsoOAVXh+Wkx
	/OmJjg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjw23bjj6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 16:49:16 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb45a6b860so162584585a.0
        for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 08:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772210955; x=1772815755; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GF8gzs0Y2ObftuKtilXKIdvF2o6qLBxvxxDd8LVJ5J8=;
        b=VNvoBn+jq1Rsxug2bN/x0F9QgvIFmmkO2E+IiZ17zEbbP4yLKFr5i2E3OoN9LMMkwm
         Ug52GrycSlDnAJKB6V4iqSm/ry7/qxg4wF6GTdmlj3Lfg7Bm67pZaManrKO2dLsndGsi
         IhIi4uyQco5dv7PexJmZmuJOKT4pS7c//WdsELZtXdwZoQZU5zy4jNrtypAaMMvE/MOf
         7vZ/6gRer2gzS6iz2FYwZwN5vEYqN132mfR/MzKsaJ5j7Yiz+Btg4A1MxTIkY4pZy8Pd
         COPkrWZXHTcNjuITmZoNuWUpxLyI5iVy6y6WtVAasc3HVZB5wcWb+L+Uv2RDvnUg15Wq
         zrNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772210955; x=1772815755;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GF8gzs0Y2ObftuKtilXKIdvF2o6qLBxvxxDd8LVJ5J8=;
        b=T7h3k/PV6vU9434bzNO7SQydN9wFGocPTdI0/tkki0q22b1Emzu9016pkxi0v8WuoV
         RNMRo7JG6kOqDk2JlwOReMvXltGx1brzV8SUmV5qAy5W9W1iELYTREpMZqGPy4HOBUL6
         GDRx2d+ee6siteazPHEaDLZBF1v8fBHM7V+dGfY2opkerxl5+lzuFPVZvaDq3WLuXtYQ
         6jnLntG5Vw2IdqDL8ssnO/m8ZxYXlP+CAM0cNjyWAJeJ/ODPtttpYI8keRTnsxhR8SAh
         nFnNiHXSRyqDML5BxkRANsP6V52/rR9+qvqKwC5PsQvrW2hxJWmDoisWbCrFinE8Fh1m
         LNZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHns/OQ6Cc+PyU7edvFHnI2snq2ng7bw1yXa8430lVlVej3wusPcaEvS4iZP3oC+A0trlLZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzsIFQh7PMHQv5BxoDin8F4D6jE+ZyjmBWcLVDn/ijt9VLu2n/9
	f75GckhSFZpmcsnt71ZQa5FyC84Wn+ocnU3Ad/OzzgTY7Grhth5CU4b3Yf/c8cE0vxhEm2JrmP5
	cgKxJlW8OnMrLtsWiJ/pAolF4GBOiB5uGOToJAibb7pWnML1+4itO6/vtpg==
X-Gm-Gg: ATEYQzzuSnd4V14xMMteW0NzsdPcTeCxoodXOkhlLsKM57FLl2PQOHBDegmNDbS+yDp
	qVe0meKifjaOkP9f2G/BX0bOReZahhixaPjDfaLPXV10IDbRs/wvNEomBIbfM0A80TPz8Y5c15k
	zhOsyP9tjY36ZGR0jKYJZCOqalfE2NdnZgExysmJbER1OTIbFlBYITPH4WAj8mbOR+go4LivFw0
	TmVmrG2eTlZvnXNjvPn28lCFjWUGIKBLTe4DOxq+JKGjkQvJJmzNT14tnmb1z0775wvZKrn560d
	kuBY4sPB9i5jgcE+WdxTU2kMI/vt+l1jbGaxAuyABOzz++NM/+S0Bwy/sStYZ8bTkt0RSXKIez2
	C5z9OEbEYpiPbvRZyWJQ7RWR0mEm4vMnBBoRjeMXJZ5MlN8NKvyS7f30K6nSEpqBFf0dN8AHTZ8
	0lsSQ=
X-Received: by 2002:a05:620a:25c7:b0:8c7:f61:eff8 with SMTP id af79cd13be357-8cbc8f5a1aamr328586885a.10.1772210955371;
        Fri, 27 Feb 2026 08:49:15 -0800 (PST)
X-Received: by 2002:a05:620a:25c7:b0:8c7:f61:eff8 with SMTP id af79cd13be357-8cbc8f5a1aamr328583485a.10.1772210954927;
        Fri, 27 Feb 2026 08:49:14 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935aec4426sm162355466b.56.2026.02.27.08.49.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 08:49:14 -0800 (PST)
Message-ID: <6fe3a1a8-46c7-427c-abb5-2e7366a43392@oss.qualcomm.com>
Date: Fri, 27 Feb 2026 17:49:11 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] media: iris: switch to hardware mode after
 firmware boot
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20260227-kaanapali-iris-v2-0-850043ac3933@oss.qualcomm.com>
 <20260227-kaanapali-iris-v2-2-850043ac3933@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260227-kaanapali-iris-v2-2-850043ac3933@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: X0GHggqsF9oTGonagxKogxYUwK-C7vFI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE1MCBTYWx0ZWRfX0eCq/3o7d77E
 JgobqB9xBmC8d1MusylOrCBwE7YCYQ99Z1DGbPnHcN9i+DKhBIdsHykQFGax1Y88pnIbVf9i9R9
 bXX3u749CS83mru/FtUJ9iOKPVZZKGSE23oJkKnUZXxTOVV2IUT7lsH2Nt5BqwO03nA7dyBVanX
 ug+l0CjcuZectM8I2xxc5Fowhp/5N8GtgKRqilvNZQvWG3fHV0TzZlQoItJwFdGkAt0+iHlqWFN
 EUgUkx40hA56EXPnLnUneAEFgo2Dymg2FJqpMc1UdxNl77WgSJ7R/voFcVc7VjnuxcaB1xJ50eU
 /Q6l5cBJ6DCegNsEs0YBT/bsY6iiLREQcyWKqE6GN1IhviYLXUFm8+Moh2uK0AAGc2MhlsVghSp
 yuETwoJoNOrRxNZFnNBLb6C6+4mBRllzCOnplVRac/cCELuVkzr+Mi5iCvrdirJPxEX4rN7lecb
 VYTMTcKbpRK6Rb2Fzgg==
X-Authority-Analysis: v=2.4 cv=cJHtc1eN c=1 sm=1 tr=0 ts=69a1cb0c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=uMIPjMpX8He5E15aO8IA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: X0GHggqsF9oTGonagxKogxYUwK-C7vFI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_03,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270150

On 2/27/26 3:11 PM, Vikash Garodia wrote:
> Currently the driver switches the vcodec GDSC to hardware (HW) mode
> before firmware load and boot sequence. GDSC can be powered off, keeping
> in hw mode, thereby the vcodec registers programmed in TrustZone (TZ)
> carry default (reset) values.
> Move the transition to HW mode after firmware load and boot sequence.
> 
> The bug was exposed with driver configuring different stream ids to
> different devices via iommu-map. With registers carrying reset values,
> VPU would not generate desired stream-id, thereby leading to SMMU fault.
> 
> For vpu4, when GDSC is switched to HW mode, there is a need to perform
> the reset operation. Without reset, there are occassional issues of
> register corruption observed. Hence the vpu GDSC switch also involves
> the reset.

Is that a characteristic of the hardware (e.g. also seen downstream), or
is that required with upstream iris only?

Konrad
