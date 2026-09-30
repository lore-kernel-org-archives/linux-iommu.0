Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF79364024
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 10:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764446; cv=none; b=GE5r85z2/if/IaJnKZvW5uZHxYdmo8OewLpUYAgmDJ9btYkBfMQ5GutFsJyh0Wne9b4BGH1znz1/HOe3LtPfYeILO5nO/gpO7fQX3Cvx5u+pBl9zGvVFLuMjXwFYZ6cRPfz2cW8+LfTZHiBhL2LdYmG4dCTD43kEaVw3zNPG19Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764446; c=relaxed/simple;
	bh=B5M7ExAdSYXfY9Ds6hbircikXslMTP7HxDS17duaV3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nue3bwt+W/JjhECni+jRLSVxWmLwLViLRof62fZsQxjkF/q07XClmgW/9cQk2xBeZRVTU7s9Gl6/VzKfKU4XwBZNz/b5nb45yXZUxkczZ6lQcsy5/uqInFAVPwdepv5ekgHDbkNIiBOn0a5JQY5qr7ZlvHuKGDIrbR/RaA7FkYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mcuLfzas; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WVRVgm7D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mcuLfzas";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WVRVgm7D"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68U7dS662666965
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 10:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mna7ZMPQZMnphcYmegEctv72t1rRymVguBHz0zldzK8=; b=mcuLfzasxShQJgwb
	mMbKqSxFaxJ79aQakGIq9OtLRDQi6rPc6aLJ2alM2KjKJayGEjR3hcE7TadMmAUp
	ZBsE7OQ13BrqwC7nCT4cN7SaPS1szAs/jTaq99+p8EKaM8Dv/O+7uAa/CKJl8SuR
	D7bVPAp+cD/oUvG+e1/hDfOB2oBCJuJeB6UuhPZHdcq/vS7qK8kPTOOtnKn9+yA/
	y0sTaugqJX2ccet6gdX4OhEGQUKzCtYmDA2Ul75joLl10Y3zBoa15Q2yxLVLwOAm
	qqqePi2Edm1AyDfvrsBpDWsoX8HNbTzO8fVQXLxc7Y1vh+0e4AIyJ07YNzUWBxiO
	n3sSVg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0x27gu25-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 10:34:02 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-530f1b3dc86so11671771cf.3
        for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 03:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790764442; x=1791369242; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mna7ZMPQZMnphcYmegEctv72t1rRymVguBHz0zldzK8=;
        b=WVRVgm7DWAhw/TzRE3uKcp6S+wYRsMbwhmmZziUT8NwPcjSSu4NH1xFW3j3r9Lgpxt
         OA8vScUGpXMV9gs/hyfDKiIoIM+IX6h3nUmISBjzYDoKynB5bPrROVqtsHXbfISQCZn1
         AGABZcHhcPuCP612J9dIFLk2bYoAXFeXzHblLBVf+Z1YHsXRuelatxXjWEkgsa9BlTqz
         912F0amM/ERLXC0Z+/vvIRiqDUSn7II/hWLYeoEyly1utaEJWCgt5MFGtQGkgXkRxlmh
         JBg0z4nMbKzVuOTGNhFFShxv5n8CeJ6mKNnzpClMNc1MW/qlZmt+kcl+wI62vHdY2f2D
         +VqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790764442; x=1791369242;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mna7ZMPQZMnphcYmegEctv72t1rRymVguBHz0zldzK8=;
        b=jzZfn90F+zFlmyxbXV/dhP0ofvpxO0wcthwg0BLCf6BeQJn/O+I8ckpq7HM3umMSyR
         6PeNO0aKaKkd4xOj4rOrnVYF6wMnvdiAVjRC+8uVq7C4u1exe9kbp8TX1vFzMSS9Chpa
         pT7zWFGr1wFj/3Q67g+MeKn/C5wSsx5mMltU1PRJonPDxXaAW7k6odOGb0eWb6f1QW10
         Z9hh1EnYL/hFWT5IYTtlIU93D4dJhm/KOg+rJCkOTRzQnQv8YcIJKE2HzCClFZAyL/bk
         v57J6VDrl9uaFOEhA/B2t1I3mQlF54umiF1/+u40IPOH+lhictXGX4tHvF0h083bEXk5
         jHpQ==
X-Forwarded-Encrypted: i=1; AKwUvByi39OzKi9Q2pILgWqMlH7kfHtmYoxGR3L6hxA+8q6PIZa8yhI7o8g9V/a+FhZ4ZUcvNJxTBA==@lists.linux.dev
X-Gm-Message-State: AFuF++nJ82CvaXmUGBwjU1fJAwUgJzQoQ7pInjFfuvUQnDevVCm/UJ9c
	3RCEaKSGzNUkBhlR9QvMEHFTXwNdsPAFutYAWJrqN3FQHifEMou4vSJ2yZxWOyonZWCPfIN1cB1
	zUtAaJFIpSDLnlymi5NQDlRroac4vBfbLa6RMrdYj1ZEHZQ0U3oSqlDc3MQ==
X-Gm-Gg: AYBFou0A6y0xTnxaPxaueim0BGCeK3E3HOJfOHcSiTudk6D/PQGgjZN64Z7V9shD+vx
	jTO+Sm2U6WYQu3WAAb6bVwwoybLa5WfD6PDJOLYKfBvdvO0TIceAq+3VTVT5g0ogzwPUrVU3P/Z
	2gEXCn82+kma3Km9MRu/VOmUk9XGdHJEDlzoKpnFcNpG+Vltd+3BiRw4nCW5RknUpiIwR3EjdnY
	eyzdyd9x3maj2/Ajew3Ikqupkra039KeYwerQ9QDhdiva+4np5h0H5Z+UtC7FJQ1ZxWd8/GSeWZ
	ihpnAuOIe6mjbLEPwQnz1LO+MD/B986EoC81AZy76pQB1WG3/d9W987jJYW9v7GNF8eVTarstyz
	6SSVNoP4GuFC6mv0RYgvfFw==
X-Received: by 2002:a05:620a:6506:b0:936:2f59:dfe4 with SMTP id af79cd13be357-93ca9418c15mr132549785a.0.1790764441819;
        Wed, 30 Sep 2026 03:34:01 -0700 (PDT)
X-Received: by 2002:a05:620a:6506:b0:936:2f59:dfe4 with SMTP id af79cd13be357-93ca9418c15mr132543985a.0.1790764441219;
        Wed, 30 Sep 2026 03:34:01 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e22f42da8sm44604666b.19.2026.09.30.03.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 03:34:00 -0700 (PDT)
Message-ID: <4f56045a-a2d0-4c3f-8e69-9ef8d933be8c@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 12:33:56 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/13] media: iris: Migrate iommus to iris sub nodes
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
References: <20260926-vpu_iommu_iova_handling-v5-0-0322ca5dc10c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260926-vpu_iommu_iova_handling-v5-0-0322ca5dc10c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA0MiBTYWx0ZWRfXy3pVRaSDPoYy
 TRyygPnxB2TmEhSPekCzIwJ/yywFdPmvu3LvF3GSIxESacifFhzhQrQ6mN9/fvh73uc9AtutieU
 +K/nyZsi7I7JB2ZvRSNco5DM4wAgaIs=
X-Proofpoint-GUID: zltiFj35PQD-BkN9cM03GN6MfxH8dEuv
X-Authority-Analysis: v=2.4 cv=W9GtxhWk c=1 sm=1 tr=0 ts=6abce59a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=ekhMd59VzrWsTOqxRA4A:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA0MiBTYWx0ZWRfX31hIqbpILpjz
 CHBeFus42JlvJ24RXrji61Mx8r2rojW7UxaVl+utzn0LGpvu0Ua0Sx1f5lAdISsi4kMXNzWWBQd
 hqhvJvEXs2GjhEJhaQJ0oRAqnr36dNy5FEWUuzOGvh67JUpw4f246A4IG8Rr0J4pb9HFFQH+5JP
 AsiBIgc5gQKFZ1O4wY6u91l7RVn/Ciy3igabsSVZpQtu7IIKB/mgm3zSrTcyYPtDLcgc0H6kLxg
 bMOnmJkD6znj3dV0GmFDO3Xv/wjpPZ9kpu1jm8Pulw+B784on89HEsqkig+D607SKTUOddyre2L
 yxQCwCc77t6wnsW7l4KQsDLrksqdK5Tbnn5YHdrs+RwlgDTVv5fjNjAVsv0s/ye7Uqq5qBsMfYA
 aRth3Aa2Zg5vE15GbsW48JYX8pUH/7tHqMTHmACn6nFnIv8JwmyDJ/mqlsfXgVGhBW0BynfRiBy
 u3jlWZzB9oUvSuzNs1w==
X-Proofpoint-ORIG-GUID: zltiFj35PQD-BkN9cM03GN6MfxH8dEuv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300042

On 9/26/26 8:33 AM, Vikash Garodia wrote:
> The VPU issues DMA through several SMMU streams, and the hardware does 
> not restricts specific streams with specific addressable range. The 
> non-pixel stream is restricted to use 0-600MB of IOVA space, while the 
> pixel stream can address the full range:
>     +-----------------------------------------------------------+
>     | non-pixel stream addressable range (600 MB - 3.5 GB)      |
>     | 0x25800000 - 0xe0000000                                   |
>     +-----------------------------------------------------------+
>     | pixel stream addressable range (0 - 3.5 GB)               |
>     | 0x00000000 - 0xe0000000                                   |
>     +-----------------------------------------------------------+

Please address all venus/iris-enabled platforms once this lands

Konrad
