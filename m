Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E453C0601
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 09:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776158989; cv=none; b=szdpNdOWLka7J4fdEzcDTd7KwGJVSN9oBzLWYDflJENUwH7/HVHdJTdM8Q1kc4z9E9cXXus6jmgIdcbkkFW9gkwtnHJT5E7wlIPnU7QB/mFgrkm2pp1tkjrPHx+J1uj/jovBxfPnoIm9OR1jH6j1v4fujvwUJ3d7i0yZhDxyQrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776158989; c=relaxed/simple;
	bh=7HquVGr9hSVRFnLZAoPF8/BbbTKUZHp/Ha1/h6tCv0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bjoNtkDFMe6em8pqaoVmJOip0wLHVexcX1XVX2XsM9KXP/XW27L7hhBHfKdkkY7hV6K9PkYwsOnLjIVsX3r6zyAOcmnKDNqj2xUkbktoqjdI8K3scqF/DKZt6qSXgRFHKHWIuENXJAR+udrKvhm5hMoUIzzoaxst0Jy0LlbAQmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UUkLiizj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ayt5ENFz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UUkLiizj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ayt5ENFz"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63E6a3RT3681510
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 09:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7HquVGr9hSVRFnLZAoPF8/BbbTKUZHp/Ha1/h6tCv0A=; b=UUkLiizjAdU27TCV
	rvY9p/8+AJOEPzrIxsfDyxUd7sYVFU9jOJdiXveeff0Yzs50M4uVTj04BV6JBOfd
	qi7GIek0zUwH7vaGWPmHjlYpgnX6FbC++LoCzKttwRAuCFKM1sHBDl4gvxSSnOys
	dZ5qTRQOcV6CANQC3Y0Gt9usgPkzdEKVjZ+cbbmdDyMYdlO8O3tpSy1QIM1qyErt
	avmmpK5uLgDrv/ggRE4OC0C5672Q5uFmLZWL4pu1D+KQ32rmo5UmHV5eIFVtcSCo
	8tjPgPsi17Fe/cgCwg55a1IfrdZxMARDonuZRmU0mqh5bse3kl/CXfC1YM3BgASa
	cpNblw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh87d22vk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 09:29:47 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8acaea1ff11so3984446d6.2
        for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 02:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776158986; x=1776763786; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7HquVGr9hSVRFnLZAoPF8/BbbTKUZHp/Ha1/h6tCv0A=;
        b=ayt5ENFzhDbwb0PEAbTQHI252PH4bldOFj8vxVmRblypUr9+tZTCuPPIh2dNPGaMOV
         rP72T66jxyHUSHdruUAWuQ+a62GDXBqM/lT1tpZCTHzxxSaVDb+KaBGjUltt5KwU4KDh
         BebDps8zbuX92necerQo9XXsNoImEttpGbD37uOnWPdu5Ii1C0WT/EY/ACVbO3NQuzFL
         8T42jYguKfMdvrjOZ1T8u7Q1sUeMiivw9VQOHgZqcdmQZ8R7ts6UypaIS49dAIv6mP9W
         Pk2jfRNX/RPkUSMHzLq0UcZHZ4/t51xrGCwDvmAxu+XA/NnPQh3Ff6LWip3MzaDLxryj
         sKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776158986; x=1776763786;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7HquVGr9hSVRFnLZAoPF8/BbbTKUZHp/Ha1/h6tCv0A=;
        b=FnfJ+e3kzQYktVjaI4hUenN4Q5OMzoZiMAGiQ7YypFOk32m7poS8oVvEUpQdgvmbM6
         XJLDnja7FyB8Ps9tUREbfXGTgGY4vhr5rCwShxNnm1vKO8dJgmd8WyYfrUWAWP+0rDYy
         AVfEzSdOJJKNN4eroUtCRB1sOLGBz6oKVsfHOzySe04IfVv9fUdHxxli10T1xHgLhu0r
         b3oTmj7SrDHzLpU5RPbPJ9UWHunIMF/c7SUiGFstbrD6hmTg09hDoTF74Tho3759KsIR
         kz8DWTPPdTR0irPiBH5sv7+GzJ+dxouU75TcrEOSJSwTuuAPBWc4RnsoGT7xDyrLAOS4
         YmAg==
X-Forwarded-Encrypted: i=1; AFNElJ9KeIIDb6cscA1iVfHBoEcZSO0DP5beDgla1YDS2jRbGMa8qSEZuP+EOJQU/Rf9S4dGLOUM2A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyHBbQfNbDu6whzfIyRLLFehn64CqqGCTWuajdRRJqnAJuhFzp4
	2scU2nGo4e1U8Rs6Cm/RaC2Wv10dwAp9yObqw5tfKlivw2MyOL04Yrr8J5TgO9XWQHV59HrE/9e
	S/yLdyQciGTfdaBXK2cDAJwaGqHh35PnI8nr/gNoYKHmvKuqrxQqPviwawA==
X-Gm-Gg: AeBDiesw7Qq6ot5XpkWI8o5aw+HyjPEBJxnbglgXFCqrSn8ojXFt0R6fFiWHRdjjpde
	sqxoX9kIy1P+Pok/aN1AZ9lcwiSDIva5+2bgDHj8me00C//xhyOcUcoke7g7rXJT/IwDXlfCh1E
	RPsRoogLUdom8eJLnsgdHoF8tU30mOzwOyg6jH7ZcGtjynK3gq3POJLyOO3t/DbKIZJiFAcuQ4W
	P9h2ACCRE1oZ5nJqNvsvIj3z7Tf++WH3bSm+t8X63xWRHfTTDL6JKRAjqb0seIDRSsUDzsYcCpI
	3Ua65OD+C0JG1ZPu7oukDbOs24XWDq3PCYUKRVOSnsX5Tx4E1av1uTJjS7TZ1273W4tYz/r8phC
	jI/+D0Xhq/q4gbDc9Gyz2P/ViY1T3JxqcxLbnQxRx4oWjAIYNOcXUofZvjqMIQ0dxQVCql5DpWL
	D9MlwYaKjG5eaQyw==
X-Received: by 2002:a05:6214:5013:b0:8ac:4fd1:2d5d with SMTP id 6a1803df08f44-8ac86297b62mr188939776d6.5.1776158986581;
        Tue, 14 Apr 2026 02:29:46 -0700 (PDT)
X-Received: by 2002:a05:6214:5013:b0:8ac:4fd1:2d5d with SMTP id 6a1803df08f44-8ac86297b62mr188939346d6.5.1776158986063;
        Tue, 14 Apr 2026 02:29:46 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6de97e36sm400411166b.10.2026.04.14.02.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 02:29:44 -0700 (PDT)
Message-ID: <fe1e2ef2-dece-4864-a89b-a311b3ddbfcc@oss.qualcomm.com>
Date: Tue, 14 Apr 2026 11:29:40 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] media: iris: Fix VM count passed to firmware
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, stable@vger.kernel.org
References: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
 <20260414-glymur-v1-6-7d3d1cf57b16@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260414-glymur-v1-6-7d3d1cf57b16@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA4NyBTYWx0ZWRfX61Rg/nmYN1bl
 qsAbXGJquTIuIKPvKgC84Lm/qTtrVWOzpmfo6J6y/WQNEQtzgMrwNJkYHWVsogqZ5FH3ZJPA965
 A45ulIZ45DZw7f7cnynVHsC+u9b4M74Az/xv2Irn9unrFSTSqQ3PdkFDY/o516xILuNf+Tnw4if
 B9Yky5Dbgp4ABv1xRj1YycGnZ7SAEeEktKiuMZsLRz5AMljew4LkDFadqYxvaozfT+Exw9mV3o1
 dilyLhWH9sNjT3XC6KP3p7hB/uoTMeZNdT4pL/iCWZfLYaUtIn5kVae9XJj7ULv8imD9InBORyt
 xc2aTDatXQTVR/vkcrOepuQtBNHD1lATLT/Gwa/+M9DW7dHtqRpiHoLFx9eAwWXLlCAmLZ0eVtF
 aWn0Y3E9OgiH7t6jAGAuWtVK2c5/Kg2Qeq691RWwfBxDV2RdRljD++FCmadAepOyEsd/lUWU2mC
 nQ2KcKjlvr3iTuThoIQ==
X-Authority-Analysis: v=2.4 cv=N+8Z0W9B c=1 sm=1 tr=0 ts=69de090b cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=UlvO0n_oXqfwqGaIblEA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: 054ejEhEpxroCsWhDp-xSgar4pvRvdeU
X-Proofpoint-ORIG-GUID: 054ejEhEpxroCsWhDp-xSgar4pvRvdeU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 clxscore=1011 phishscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140087

On 4/14/26 7:00 AM, Vishnu Reddy wrote:
> On Glymur, firmware interprets the value written to CPU_CS_SCIACMDARG3 as
> the number of virtual machines (VMs) and internally adds 1 to it. Writing
> 1 causes firmware to treat it as 2 VMs. Since only one VM is required,
> remove this write to leave the register at its reset value of 0. This does
> not affect other platforms as only Glymur firmware uses this register,
> earlier platform firmwares ignore it.

Should we write a zero there, then?

Konrad
