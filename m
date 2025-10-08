Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF06F22128A
	for <iommu@lists.linux.dev>; Wed,  8 Oct 2025 11:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759924021; cv=none; b=BTH/swB/m6TMhkchWKdlobhawCE+njMHRQpwCWyT61oMHI5DFyfM0SI/nObaOPDqRdLp2VBTzRHt4fX2XpQH0XZ8BO2IYJqhQCGTCyz9/8R9I1Z+h+8pun5w1rLyCf/7o7YH5p9fLLkViVYsXCf41Jyot/+C4ag87C1A9PEe5Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759924021; c=relaxed/simple;
	bh=pOLsyu91bA7BFOduTPfXQwDrZ2/gTjYFrA2eBRm3r78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FJ4NZrg7I3tbw49MtNJtTM1Fd5avphmfQ7l4J+OextPJ1552kmscyeoOxdRA7JwTGpCZ1TXKkiMtfJkQJ2kjIDPOWHr8bpo1H6UOAdcKMRBGxi8+MiKaXooJNIajqpzspyS0mgrfZmabYuD9el9nQHOq3o9cd8AJ+Y9giGdR2eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UProDiaF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UProDiaF"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890egx027414
	for <iommu@lists.linux.dev>; Wed, 8 Oct 2025 11:46:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zmZqI/hK2QIPAuDXDoC713x1X6hbDw/7hyjWJFFNTE0=; b=UProDiaFd3+bNfr/
	JAMFmeTOf8+SkbvblGKTR06dC1qYCi72cCccPdz1X84A0oBNXWSbJ8NXXh02KB72
	WfE0bPkXgRm49IMMYEmrxBpBP+nVx6z3K2iO45mzz7Wwx+HukjK2twkuu8CIxbxw
	WTBE+B2H7tc839FrzveOhRa4zPiTRyyUbGlBqud1+orHif/6xN8ni/W5G0lZm5KT
	iPJ3GfxERsvCOkLRpg+Sp9XfAasDi0khKs3qMt1RI5Ihf6Oz+xK089HZffFb3er6
	qVOeaokX/617+OZxzQQ4C/tq7XTxpDaE/NiX0t7D/T5oLvwppVw3wlEzzeVVFp/N
	/D25Wg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49n89hj1fj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 08 Oct 2025 11:46:58 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e56b12ea56so14282441cf.2
        for <iommu@lists.linux.dev>; Wed, 08 Oct 2025 04:46:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759924017; x=1760528817;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zmZqI/hK2QIPAuDXDoC713x1X6hbDw/7hyjWJFFNTE0=;
        b=ACvz/spqOBLADfdoKbvPHwwNvFu1r6/LZUIt7pdEdQpV6ptK9TDkF9mIed/2svHxSu
         EX+opJbnJCh325DXUrnAK5+WNHM71TjYS1v7AtteJYAsgWQ1HgUj06h91HMjxXT++Sqp
         hjJeWbwvd/NcmDKtx7aFB+rgvc6k3YJglXETA+3znu/d/GF+ieOFDeWq5D2kYKHsRF8N
         CubbmA/vTBAcuQDnzFf5H9JVrBjyPIxGRVbksH8ROtpGZlD8xIVmA6thHluMNdRStgUl
         DQgxUcHc6VEb05pn8T1C5omdywXbicpYY3LCO0GzTKHSd2iqpNrnL0a3VPSx4ZXv1yUN
         PVWg==
X-Forwarded-Encrypted: i=1; AJvYcCVopdsbkOC49UV+EN5t53B/dCtuXm37+lrLcR7yWFyDS/sFnuYBHacf5HuqX8YA8b9rACHsOA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzyQix7Mj0jtY979hyKxSNFcKGKYq5LrFsVZ8N1DNPVCt/CZRQ2
	j7An9zwzFmcHs9/Z1smcIJ9rCK2s0s1ARBG6BEajXXuS5gjTnCdYqXS9vh3miI0nZIc84HJ9ISs
	JhbXOuPWj2TJ+yRcU6vG1qf7a6HFIVDnPiXRfCF06Q1RsVGftX5UXIX8GVQ==
X-Gm-Gg: ASbGncuIMSEBuddDGY2WDs+8QB7/rseseZ8a0O2CG95W1a81GBHBKuo9CkhRJNMvFsv
	N9RM1SkjQOdw0DwjzMZvw5OTcR8kYpALMwE6UmsJq8rNBM0uIWf9o9yqgLwwqohlsqkWaOSNQ8G
	QsdX5xlikjLWxtjE6uWJ0q03L1m6jS4ivku5YKgdzEX7GllzM6pV+VPGiQLfXDZsTwlMRRX6u/y
	pT1kLseVF7KfJ3gsX6CT+D/0GphysFMWOepkFIpdCoN5tWlvFdpft7iqa6mTkH1K1rYWp0F8ciH
	nG85bSW7xFcmaMryiRqfQiGVDCploo/m4WrFd6ZZ9gritP3fzgv0Ys3nd2s8gdvwc7SggBC09V6
	T/J1BJ5Gw/gAXbO9w64LnJlbDOb8=
X-Received: by 2002:a05:622a:4c6:b0:4db:1bd:c21c with SMTP id d75a77b69052e-4e6ead390dcmr28341871cf.12.1759924016820;
        Wed, 08 Oct 2025 04:46:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhzBijvONPiblMY5efLfCzWLUGbZqk/BjrQ0UR7ejEdPzLuUFe2mN6EtMi9WvZDTQu1j0KPg==
X-Received: by 2002:a05:622a:4c6:b0:4db:1bd:c21c with SMTP id d75a77b69052e-4e6ead390dcmr28341691cf.12.1759924016308;
        Wed, 08 Oct 2025 04:46:56 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865a83f5fsm1649154166b.32.2025.10.08.04.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 04:46:55 -0700 (PDT)
Message-ID: <fd49f3db-560d-4633-ab59-fa80f9baf698@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 13:46:51 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/17] soc: qcom: ubwc: Add config for Kaanapali
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
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
        Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
 <20250930-kaana-gpu-support-v1-1-73530b0700ed@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250930-kaana-gpu-support-v1-1-73530b0700ed@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDE0NiBTYWx0ZWRfXzUjl6vh6g27d
 ujqizFQWw+XyVbJs6R1GBdzOliMNDo9SXqXiM9VWVVBHyEH329E+wjBxXLanOydLa3aioHXsEPX
 hWQFAkCxIJoVetSCdJStKBwQ0HcPSER0reVagjMV2b753gH2Kem0r658MRGjwFjwHqciaoDLQsz
 3OHLQjxevL3S5316Trj3VZSQg9h0YOs3nQ8mLN2T8B6pmPmWEzvEgGML68jcWt0sHd2H4HbRb5S
 OIk4XuZgtk0Ojf5HWqX3AH7nMd3xYITCNz7dVgdOvFM1oXxTabUTRhdmXBaapSdCDUHDZI1hmKM
 ehlxC8M7Bf2UNUbUyYry0d/0Dm84ZHxyX25baCETPO9IDHd1tZRtDIEil4BFhyilHPfznS2FA8K
 u5XX4jepbdbZatmyRJxj5Irqm0ww6A==
X-Proofpoint-ORIG-GUID: u7WqYN1KkQ7IoKVnuTDRIjhPU8q3_poi
X-Proofpoint-GUID: u7WqYN1KkQ7IoKVnuTDRIjhPU8q3_poi
X-Authority-Analysis: v=2.4 cv=cKbtc1eN c=1 sm=1 tr=0 ts=68e64f32 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=WkYBtKvuumTgCfpkg3wA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510070146

On 9/30/25 7:48 AM, Akhil P Oommen wrote:
> Add the ubwc configuration for Kaanapali chipset. This chipset brings
> support for UBWC v6 version. The rest of the configurations remains
> as usual.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
