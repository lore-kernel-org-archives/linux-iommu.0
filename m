Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F30C238153
	for <iommu@lists.linux.dev>; Thu, 17 Apr 2025 11:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744888379; cv=none; b=LBI238DTjy5K0UvxowodlYVxoapquSHlZonwCZC6zXo2bRsrhJYXEzhiSuEwxtmA6i23VgQojvdWs2LleS2HZuJ4HuE3x+kP75+4GyfQmZvGcad2nNzbz3ew6+jyXSUjmjzK8YK0kJPYSNo7Mro6N755wYVg2g89vQBm2DIPISU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744888379; c=relaxed/simple;
	bh=D+FiOtVMhclsAvlG1hV6jofzj5deZucBeiDODH+PZJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gvF0NoDio0aPKTcZBSxAOiaYiG58B5F29cCSdKlEhmA/EOIvXF63sHtNeLl01iUuj5Zd2+jWYg+GF5waYOS5Lzy0/vPgrMK1YMRg0caiftfN+tCKClSD1xVYVW3PUkd4eWCiFfHJub9EXkyhmzlYc7msvHNm6ev/ZvqC9Of4aYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=adcDkBd6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="adcDkBd6"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H5l8Ft007007
	for <iommu@lists.linux.dev>; Thu, 17 Apr 2025 11:12:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qxLfze/zTU8C+QNrMs305310NbgxbagwueNtXuKqL/E=; b=adcDkBd6wQd9KwXu
	Y5qcUyfKvzgCP77H6O5zK0SV93bKBEX5htjINmUWG/bw9UlxjHHMf1diagE82Jl+
	nzmjGhh4kFl1k7kNcMa1PoD7Ep3nos1gibHRpcBjOztQSAKz3iT2SXW6ebuCwVxO
	4i6d6K8fuAERCOiGwVYnJa4+QoRJCLd/aGFnaoQx267Dvyqercxlb5PsZlWC6r9R
	16fND/5wGGvmnZ1sIFuJS81Ai6iYr3MO8tJyPcfiPd3JfZq9E0+c1d5qRRQWrBef
	qxnTBx/crw9bXR+CCdw51hD/5G68rnzn/9ygQ24oemKZ7nbFx754P58AIIR7jRU/
	JegZiw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yfs1ejt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 17 Apr 2025 11:12:56 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e8fec7ab4dso1021186d6.3
        for <iommu@lists.linux.dev>; Thu, 17 Apr 2025 04:12:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744888376; x=1745493176;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qxLfze/zTU8C+QNrMs305310NbgxbagwueNtXuKqL/E=;
        b=Yt4DKM4Jjh4he0lhEui1b128mS+KY+ARWBFGE7i0g9g3kPAcxKdzSWuecE5DBBxHhY
         ON9XwZQoPu4fySSnNsqgWx27Li2pf1e+pJ1Rub+gHQk2744yxfUWf8EzrDZNRLfLCHgs
         9XzKsBafyASsIJtyWFrNUwJctkPGbrLXM3tu6SLV7srOTIOAuvGC5ZZ3ifDWsxu0yppQ
         vo2emUcGNwbZxL9bxeLGQW8+nXBx3nwWlYYq7cs0R7sx7wLec7r0nyMokJODxga2rdgG
         sJAVmRxVaWnxVlp09rhAXYXzn6HWiY0mz1Z/RZ2FNdbZAKcKy/4YuQHgDqiBxp7tIKEN
         E8RA==
X-Forwarded-Encrypted: i=1; AJvYcCUeEnMI6Jl9Tdcvv2Uo/TOvF4pFA0aNdah8fVP0+e06qmQwUmzXOeyaScxE1LMiw6nkUmYxzg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxiS9HKRXM9N8MmYphPqCKrNGdmURGOwu3NeT2lvpXggSAQplQj
	zGz2HLHXvSOFdSxrVoqplTPHui0LDtl3VLCgmjYnBKrqKbEjL0HFZCWXA/fy94UXuSPQzlOBv8s
	UTiVtdbavUgKzzkkL3+zoMHVf3fTeA/zNhlPss1+FCR22ApDfhxd2fQ==
X-Gm-Gg: ASbGncumEX8nU0r1xhgEll+HcXnj93XQUGLajzIOPexEGjS6NwV0sov8IbOy///3mXy
	YYfi3tlG+V3gAHhitWOJlFrfcbnykxoXBndEDXzXCxRJ3aX78hW3KYHhsuQyUvtL/YNDn5njJpW
	hnKJOqs+RYUjzUdxMT287RNEIlEK9Q33r3828QPPWdCov4oObmbXidn3WwniOQtQDxtk7wDKaWg
	3V+CtN8t7wXPZxwbqc16gbrkrnZuPZDKrN3+EBhWsIuqxOsy5AARkuZTuN00Nc2mTyXTCs7H+Dx
	+7ofQ0ggdn8HjpniALhD9pmIf5KAHotgIUwtCmgnD9CAdGtj6Y70lnjbAonccQeAHw==
X-Received: by 2002:a05:622a:19a0:b0:474:e7de:8595 with SMTP id d75a77b69052e-47ad8159564mr27695051cf.14.1744888375720;
        Thu, 17 Apr 2025 04:12:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPBxjpffnmkirnLBBB0Y2hOG9UcPArMHvszmAnlUI030yse54CdKoXRd2cuVM3FD9w0+N0bA==
X-Received: by 2002:a05:622a:19a0:b0:474:e7de:8595 with SMTP id d75a77b69052e-47ad8159564mr27694831cf.14.1744888375327;
        Thu, 17 Apr 2025 04:12:55 -0700 (PDT)
Received: from [192.168.65.58] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36f527df0sm10099976a12.71.2025.04.17.04.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 04:12:54 -0700 (PDT)
Message-ID: <7b559f03-f131-435e-95de-b5faee37b4d5@oss.qualcomm.com>
Date: Thu, 17 Apr 2025 13:12:50 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] dt-bindings: display/msm: dp-controller:
 describe SAR2130P
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar
 <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Bjorn Andersson <andersson@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org
References: <20250417-sar2130p-display-v4-0-b91dd8a21b1a@oss.qualcomm.com>
 <20250417-sar2130p-display-v4-1-b91dd8a21b1a@oss.qualcomm.com>
 <20250417-arboreal-turkey-of-acumen-e1e3da@shite>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250417-arboreal-turkey-of-acumen-e1e3da@shite>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=P9I6hjAu c=1 sm=1 tr=0 ts=6800e238 cx=c_pps a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=hUMovHauaXhaw1qFzIsA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: XOlGeYnOUAsxfa7fSai4_EXMEF-oEmcd
X-Proofpoint-ORIG-GUID: XOlGeYnOUAsxfa7fSai4_EXMEF-oEmcd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_03,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0
 mlxscore=0 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 mlxlogscore=808 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170084

On 4/17/25 8:03 AM, Krzysztof Kozlowski wrote:
> On Thu, Apr 17, 2025 at 02:16:31AM GMT, Dmitry Baryshkov wrote:
>> From: Dmitry Baryshkov <lumag@kernel.org>
>>
>> Describe DisplayPort controller present on Qualcomm SAR2130P platform.
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Addresses do not match. You re-authored the commit, so now everywhere is
> mess.

It's git's fault with replacing the linaro address based on .mailmap

Konrad
