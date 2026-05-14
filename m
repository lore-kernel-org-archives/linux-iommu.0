Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5213C98A4
	for <iommu@lists.linux.dev>; Thu, 14 May 2026 12:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778762231; cv=none; b=Eo2q1HedXaOOefJI6n9jclNA5Si85/Up1m9bYGUKPnjOrMmYPi1lIH90d0X4DlsRsQ6V9MkcBe78LFGWr9fNLN3fpIxKj0eMCNnm7QgHZdv+bXqQZZsDgOdQBYVt3cuVzx2qm2V573nQf0Pp4R1uOhi9rt20KKCJBisVQeUDFYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778762231; c=relaxed/simple;
	bh=mWZA0swnjoA8588DZQ2qd6kAUz7BB2U37Lx+KCeAKQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KeKU37RgSYkgrl2l0PHlE5VbGcUXcrKwbkqCdzyjrb0ZuLhBVVqEvO3+CMWWvPrJl3Jz3QOcrvwUDdHZYbg5Xo9WLAoA4YxS9FqAnYctxOhzp8UDydD2i3/XY0+oWfSWnHIyYQZg96MkLyEE/2RJV8hLEPcBK9dqiphds3QsMDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YO3C7bqT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WKtCqc44; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YO3C7bqT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WKtCqc44"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EBeqFI2239249
	for <iommu@lists.linux.dev>; Thu, 14 May 2026 12:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iSowrtE5EBA1YxeyO47FidyogDnDbcytlrVwQdLxer4=; b=YO3C7bqTNygIL/rR
	zg77oN8KLtLkXw1o9VI6MvzrB6UO7CpuTxul8EfDF3ylpXFy4PlS9YB65ZpR8uuQ
	kQSzpsFi97NIDDLMkMZ0t0ll/vbQifE8iZE849QYOjqmINbfVtcP+6Lv0uNZEeE5
	plu6CnxD6EGbJNiBU2nfloYUR9laruvX1+mNd0NV2a1tVvb7nSKCyDT9f+4dexqN
	yzbF6ss/mLueX8iJvzhDKN5ao0aRWsgf3waW3bf42B35O14bClIGEm/7/i+UOnB4
	/jpuJ424cuxQRSmIbOQ85vsSTPYulquAkAvnGdj+oaJDobPcarkiAmgVQVK+sGRL
	2NKmaQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e566bhrj5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 14 May 2026 12:37:09 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-573ac60fcc2so650225e0c.0
        for <iommu@lists.linux.dev>; Thu, 14 May 2026 05:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778762228; x=1779367028; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iSowrtE5EBA1YxeyO47FidyogDnDbcytlrVwQdLxer4=;
        b=WKtCqc44Cdmc4qSPdVMFSGmYhcAiXBT+b55gNgTNyLBwyLWWvhYlYCp1vGqYVTsj7U
         Rr0CM8kioCHv5amL/VssXQE9As4BxSNHCQ9VNBdOJgFqZWFl7nLnCE/fQ2hVVm8glDcO
         m1t1X1NOkg8zQPSwiL2LKjIm4aSFcVk2tehSZFjrkV8LH4h150nO8ccivQY56paHZTnj
         cHXnmyJQWuqQ1KasCGkyPmnlHFNgn4Znn3lQwmbuB86+Fd3yHYEze4K0kM3CGgv5ZybT
         0cZfdjdM+7tpCywe7KVMAnnxHi7qUJI4BY9HzP7o9LbEuJkYjC1AqPjGR8imFt2ccRSD
         Wm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778762228; x=1779367028;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iSowrtE5EBA1YxeyO47FidyogDnDbcytlrVwQdLxer4=;
        b=EOJM77Ga6i4Z5QWe8u3F4ALNk45QAYkFMFL9NyEup5+qXywf0w7soIcNogUQkMtDBg
         HLsMNnN/pKmMS0Xbf1xvVGUXKy6K8rZqd5EAKvezbPrB68Uk7tA6Wl/yHOYxUhurUAqa
         6C7VM0peMK6u/ypWpj9A3ECtN9o9yseBLRl0iN+0jbS2DEVtZhPvylPy6fsLqcqPt2wV
         ole/ZWlhWku2bazM6jbW3xSqadKE/N3bhx3Yf3HXLiF1Uekp+dRUTacg/5ptxpee7t6P
         zIywnleidJXhaUUYcH+NR7V969JgbD3qA5V94OPPKk0gUA6YoIAMAIAMOIt1MFZGBbn9
         mIzw==
X-Forwarded-Encrypted: i=1; AFNElJ+W8mOA5YQ9iNlpeJizDv/iZ3Ub61QBVb6vIsUYTTelbY1Lt26TUgJYv8YGUSEJKSq8T0Om8Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzwjrtoG03gvoiaEKOgGvx7agV6wJhdNFgR24reHrr1ou8GDtev
	bU5elRbLE4YdyjlZQjaY3rvhfELEipRKPH07lUngoInGRXy1DdB99rX1SNwhX/CdTEmKmCZ1AlV
	nwQPh7VYlmk+ryi+g6IvB5gylu8ySMt/YfTxDfeBYTNUUrz3xs5gmaBCvqw==
X-Gm-Gg: Acq92OEz1+wVm0JbM1TQkFkimTaQXVsyqBwVF77BYbHtsRAdL5Z4SIBZ7L2jXoSLrx5
	HcfZfWpbg6yTlZ4ha0BUwjNIthuOrYtxxTZ0yQ4NXyP/qZ7IzVyja6zZffCqdsonR7dL8cqYScE
	BBQQm20oVhnRpPmK3wSXimuzrreVJeJYNueLjhdp+0zMhgljX5L1tfc2QkUwqcP5FGOtE5wlDgH
	mwZ4d/xbnM8vDc8X4Bm+9pJdgTkT0I5ZAVEKCJ0v40acAMdC0ji298NzQNawCG6ryr/A2uoRX/o
	TpaV3JwKq8IZqQ5JgMRQiY74mEOeGyz/o8q5XVyJe+PJKYvgE0QTE4td2PJOjbxifULT4gchwbo
	cW0AfrT9PrWtlQN1cdaqz/nSOwsWcl00zt2CotzqXHTqzF5OKVURpXeAMH1UbFAiXwgNenTX0qn
	DdFEk=
X-Received: by 2002:a05:6102:2157:b0:634:b9a9:c082 with SMTP id ada2fe7eead31-637733f0556mr1164947137.3.1778762228439;
        Thu, 14 May 2026 05:37:08 -0700 (PDT)
X-Received: by 2002:a05:6102:2157:b0:634:b9a9:c082 with SMTP id ada2fe7eead31-637733f0556mr1164943137.3.1778762228059;
        Thu, 14 May 2026 05:37:08 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4bd1124sm84302766b.1.2026.05.14.05.37.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 05:37:07 -0700 (PDT)
Message-ID: <2a19abc9-4e73-4e8c-8cff-c2b28100abb5@oss.qualcomm.com>
Date: Thu, 14 May 2026 14:37:04 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] arm64: dts: qcom: kaanapali-qrd: Enable GPU
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
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
 <20260512-kaana-gpu-dt-v1-8-13e1c07c2050@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260512-kaana-gpu-dt-v1-8-13e1c07c2050@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 1ayjRPekavUSPm93qTMI5o_ILKuFF5nx
X-Authority-Analysis: v=2.4 cv=WsMb99fv c=1 sm=1 tr=0 ts=6a05c1f5 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=OwxjEWw48HTU6ZCEJDcA:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDEyNiBTYWx0ZWRfX0rBtpoJuPUI/
 M5tR9baEcH+C+2YtWXPMebQps2MhtlCChPVS+ScthUAdRYbVH0ujKWAP3LgZu9RkVY0GOSR9/CJ
 ihJ5WV4YhOSmjTtJi+wzvv0wf+myQe4a99KZI/nD5WbIWLWvx7TkxGOAvdjK5+Ul6rJlDsNc1FI
 kgQ/TYwyPQIxDSHZUkCxm4rmkCnNo5IVPcZkuAzm6j6GuDY8NUZqeIXhdc6JVUv1Cxbi0+Pw5PA
 t2M4j36Zx3g1TRd1+Iy2l9O0o9XBLbBA8FwUK1Q/FX9DXMkEDxvsB0fS6joUEpypYhE8Vl9bXCz
 nvkYJq1Y4L+0tbPt0M/IG7uu5WZDsgQGqt1WBqNRcWkj2A/qrYUOI1Kjphqshhhx0kUrwSRA+v8
 RhHfZXmzTONjEfEmi5EmdnwCp0N7WCvMqIanB7wRLPfPK1ErnQ2QZFWxhhfyTdJTQZeyAaTdzMb
 p0i6z2kTd/k2Ra2+fAw==
X-Proofpoint-GUID: 1ayjRPekavUSPm93qTMI5o_ILKuFF5nx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140126

On 5/12/26 12:23 AM, Akhil P Oommen wrote:
> Add the secure firmware name property and enable GPU support on
> Kaanapali QRD device.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
