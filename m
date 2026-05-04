Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91B92F9D98
	for <iommu@lists.linux.dev>; Mon,  4 May 2026 07:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777880433; cv=none; b=ZV3eLKNbUHTxvXO2yzokdYpG0xmifFGP6W8mRN6Q5maC8c3W2rsGCw0oE3jeHlIpwLsCMt5f8wnhI0NzISHayIzjHyWHx25Lgl1bLzwP9CFY8Eoph0R9dFpo6l5uYHQ5l4yzrfMZkC96wG7UtoxwrQ3QW893uYGIkfYQqD8eQG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777880433; c=relaxed/simple;
	bh=CxHY4RvIZsFVhZ+sfhFRyOxtKsGuxa202wmwVB50kfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CkuS1aBcGvjQYlZdymp6bw0IDwp6CtS2ZzidKGEMM4SxB0tFVqJvBJ62yj9GRR3E8fDDPJhyLZoIyxzqfze5Nrgc4RjPqGmIGQbN7INxRw99y3kmYiTp4qxOgbU09I1p4WfK4Cd9JmLCSDfoqDRIIg/MOG96n44jh0Pkb7yplBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XoaomhBi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NT+9WcF8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XoaomhBi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NT+9WcF8"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6446D8gh117903
	for <iommu@lists.linux.dev>; Mon, 4 May 2026 07:40:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FwIM1jl5XWC+65YTaCeocqS1G1wiQx57VLQE5Vf3BN4=; b=XoaomhBii6vH9AqL
	D1IMpS8AEOAFl8pbpgOoft5D2QxekEvTVYC/iMlgyDaCZOY6153eEmRxIH5CiPwI
	WIuJ9AF1wR1KS3AiGm6XpZ5+qAtRrA4GDFnizPStVshUHVjkLEdBAI1zoNllPqQY
	i0tPlv4tOyth2RQdpbrRbPq7C94lTTMNz6vLC5JLQE/qHJZNm6Pz4G0PG0mzPA1h
	MRPrIdmRb7qkhshtoITuuQUDSGMBARjthU4BP38IOqQkGjOOKnbI2OA2VQ2hZw73
	7ylxoOGy8UHoN/eQEGpobrQIOzJicKlK7YoU7HhOVBc1QjGFa0TXZbHX4d+685Zh
	9o92Bw==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dwaejmpwn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 04 May 2026 07:40:31 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5751d137d42so43553e0c.3
        for <iommu@lists.linux.dev>; Mon, 04 May 2026 00:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777880430; x=1778485230; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FwIM1jl5XWC+65YTaCeocqS1G1wiQx57VLQE5Vf3BN4=;
        b=NT+9WcF82D5KLAb90JrIYbjIH4eyRS4s2mcfuBAIPcDZJW1YgGqD1mDb0btNe15Lxj
         K7/nYDHbqWzRR3Dt6ndiOxWA3JNXJ7YI0hYh1TlkBYKwdL5KikGk0m62SxH9PCYiqHyb
         e4sD5EzlfpxJOkvcXSNNYmcPJNw+KzOMWdOZz6qsC2kk4k0gu2PiRoI2lTxHJu4Zha7C
         rcl2eeJ6j2ZFeOzA2/FWqkP9Q2xgUonB3NfIursxoI4/A6Tv9VB8LfIUoJ3jOUWc+VN7
         N9dKj0nl1Q4hPyFCqkOKaa8p5sGErXVZexEoDNqlJf0p1LE2CUNPalVfhfE0jSvWP+qP
         vPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777880430; x=1778485230;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FwIM1jl5XWC+65YTaCeocqS1G1wiQx57VLQE5Vf3BN4=;
        b=iPvKxiu1QevWsxjFoFIkML+rZ+G2UgwUaUGhbQG71jI+bPMA+JMNdbi9GHKzyc1XGa
         dNlzJZTkioyjSeSjO2DftREJ80zD75SPYnnXiH5yLsMor0j4hHI3sRPnN2PI5InGAc3O
         74Z49PwnRSkzibUYTEmV9HTHot70bhgqFl/umN0oGTr17ADJJmzLFRXMpDdGBh9d5SKN
         S9EhCwFCfSVS5cyAqta8fHcGN1mUOsLU4kCwcuQ/dHJMwn36fGBY+Hvv82qEBttfY9IL
         eqwpZXzsvt3hnohtaVamc2frPF6+Ds/ulzB2HZ1CLvNkhuMna7dxjmISl8+ZCbqAO6mW
         6UeQ==
X-Forwarded-Encrypted: i=1; AFNElJ8BWJDZQ45lWSuEBiCdWZUnothrb/dqbsXvoQzQGH74WhkOL+VOllO3dTriGvZzOrDqQZjdOQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxtOFVCUMuAV+jIEcLn31eiIgxxxftIvbTSD0SuMG2nOUT5jd82
	4+e7U3G3UfW+MZTZhkDEN+9aPSsQ1NzYWaUGOO7kr+7zTzwqPZlIyAV0Lk7B6iuRGlskWORcARg
	UxM+67Ivvv5WL8fXCjoc4JpDBjjxo/AvE/8L5VPe9s2qv3Srcxw0KYX3D+Q==
X-Gm-Gg: AeBDieuXd7EaIPvXcJUIFcjH9EC+8OYigXQeTwofc2VtiQhTbJ8yYfwAcXr2DtVCt6A
	wrTfO/Qzgph8+QEOv9N5Wjl/wVTrX9cUQJz7pebkLYepQxPxZQeaf/htTwAJAiMDFZz+PnKN+cU
	h1JuGGAStJYqV9EAyEJj5wviJ0Voy/GdVo9mNtwme0Hdxf06GiGBZGB6ipfr66jQTrtF9TLKDDE
	Jh9pTAefVPkAJ/TjPWftCL4g9Q/4xryIUDGXBlWEce/ipYXV30bOndB6VD/0iCBksIBkz/q3Bti
	YX7zlJWaYPKYJphuEq4OzorQTwb2WkHZdWsZQJAKn1ouBxLHUsW3E9Nu/jcf8sLZnnsMU0obeAx
	OacjbbFH0JbaAlnwF3dL0jQxpN5JI9ctXScaE9UX9Ou1R9pyDOMRTLbE3o6yc5dQiIn+xJJOXn+
	1tJ3u2I/yRUCPIfQ==
X-Received: by 2002:a05:6122:1216:b0:575:1954:4396 with SMTP id 71dfb90a1353d-57519545c81mr773078e0c.2.1777880430000;
        Mon, 04 May 2026 00:40:30 -0700 (PDT)
X-Received: by 2002:a05:6122:1216:b0:575:1954:4396 with SMTP id 71dfb90a1353d-57519545c81mr773066e0c.2.1777880429549;
        Mon, 04 May 2026 00:40:29 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bc20825b337sm93249866b.23.2026.05.04.00.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 00:40:28 -0700 (PDT)
Message-ID: <fdca4d01-eb6b-49a6-86e1-b6d582af4ba8@oss.qualcomm.com>
Date: Mon, 4 May 2026 09:40:25 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] ARM: dts: qcom: Add Samsung Galaxy S4
To: MINETTE Alexandre <contact@alex-min.fr>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Guru Das Srinagesh
 <linux@gurudas.dev>,
        Linus Walleij <linusw@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        iommu@lists.linux.dev, phone-devel@vger.kernel.org
References: <20260427-mainline-send-v1-sending-v2-0-dcaa9178007b@alex-min.fr>
 <20260427-mainline-send-v1-sending-v2-8-dcaa9178007b@alex-min.fr>
 <97969bf9-8eb2-4498-90bd-9973fb2bd638@oss.qualcomm.com>
 <edbaf71e-6a47-4294-a8c6-6b356bc336ed@app.fastmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <edbaf71e-6a47-4294-a8c6-6b356bc336ed@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDA3NiBTYWx0ZWRfX0l/kdq3s0Okz
 8iqlP767LNIBUZGEPWOtYLChQ4mK0hrNP8LyU5UeLnmznLMWQHCIZ8kkyqvwlnq5aWHViQ23Edo
 gUeiE5koLMXGEAKzd++/BntJVL+3/7xVmBCKnAojFBKIC8a1ZDmCLqDCJlthQHo47KRZBcuB3dr
 Tm8AlUj8LhDKczsIhOThw7dTYDqwUMvEx/gkGNhMf9sP8rNU7pMN4A7Vfo+A33ol+G85Ywk34IP
 rwU4zrYa+ktbxBhG1T/TL7lF8bIA9qwA6t5coCZlUiJtsb+Q3o6XLyB/kl5sk3GoRgxno6fd/YP
 hmGXBHOdjaKEda0Z99GSby41SpRpBFKMQnLprBmpCwYy6T3QxA2rV/PNEwPvAXk4cnykkmb79Yb
 8cS2arnIMl1EYHn4eaXAtL57dEGSopXEHu+PyvXyVZUcDYVFNGuTpCqiPWDHuNGdQ8GayFPJRqf
 9AzLSWwFNNNbW9rvjTA==
X-Authority-Analysis: v=2.4 cv=Wa48rUhX c=1 sm=1 tr=0 ts=69f84d6f cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=DDlRktX6VRAlMvZBBbgA:9 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-ORIG-GUID: YThqjC5vwIy3ai5eVBt_iPeiT7H4XZyt
X-Proofpoint-GUID: YThqjC5vwIy3ai5eVBt_iPeiT7H4XZyt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040076

On 5/1/26 9:41 AM, MINETTE Alexandre wrote:
> Thanks a lot for the suggestion, I checked the downstream board files
> and it does not look like these buses are wired for GSBI.
> 
> There, the MAX77693 bus is instantiated as a dedicated i2c-gpio bus on
> GPIO 22/23, and the AN30259A LED bus as a dedicated i2c-gpio bus on
> GPIO 6/7. The native APQ8064 GSBI2/GSBI3 I2C pins are different
> (GPIO 24/25 and GPIO 8/9), so these two buses do not seem to be wired
> to the GSBI controllers on jflte.

What I meant is that the pins that the i2c-gpio nodes reference
are actually wired (inside the SoC) to the GSBI I2C controllers.

You'll notice that in drivers/pinctrl/qcom/pinctrl-apq8064.c,
there are bits like:

PINGROUP(6, gsbi3, NA, NA, NA, NA, NA, NA, NA, NA, NA),

which mean "function 0 is GPIO [implicitly in the macro], function
1 is mux to the GSBI controller"

Konrad
