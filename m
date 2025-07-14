Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A216223C4E1
	for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 12:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752495587; cv=none; b=EdcPpfpLs1ufJQfD9SYA/IK+qb5+sxZsv2Dv+SHXqNMNIVwKHGecAZGlHl5VVe6LSrqlzDpCUO/ryFjATMhIZNk2QMTvBy8c2JXg/sSBUnNcQ/iq+FwE1VvRKEPi+9umOfE/5H6PcNNB2uU+MYw+t4j+qy1NYD4v67TED9q0wSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752495587; c=relaxed/simple;
	bh=vg1LPvtok41V62jKgVCViQqz2vZuvfhY4dzciIbvWQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ILk3yUK0N3ByUrYgkOCFXCkQHhSrAs4i5in349kvr80d/jhF5rQkFzC/kwiFZ/5vj75cqQpdv9zUJFeFPRl0i25Mainl8BmFbUaGiZcU9uYIBQSRfte8qonsMZ+jNgeZyxgxy5T953OLHYmi0WaWxRUz6mSqAo8Vqq6pLnOD2wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E1uRVocu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E1uRVocu"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EBgIUu003143
	for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 12:19:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	to+jAqKUwFsv0AkY0GQhPmlDuQ5+LAk2TMq6Z7FQa2s=; b=E1uRVocuyHFzbOsE
	SDOXrepOxttpPH3XsT7PdQ7+jLPEu7tD+Jpmzx1aIJ6UQOKjYW00inJro8y5rIzS
	Hx2PrhXS2FOqeo+g6j0Z9S13BH3dLGvjK8C8Vssh/E2Jyy1biYQvnFdafuUTxYzG
	PJR9dtqhXuuFM+6bip/DFAgMsGiprQBNz9XSHaU99RAw7D++zeXCZo8C3meXl/E3
	sMTN4UDkxV6Y7d6jX+cSasFcGY3u2FFrvS3DzRWpWsllC1jfMb39ccmMQhljPi1h
	vnUjNpph+H/NkD7/pyLbquKzOVqf4RGuBm/OmBcy2flVbY9AC6Gr5e2byhAmwJRe
	XFJLTw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47vvb0s77r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 12:19:43 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7dea65840b8so34721285a.1
        for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 05:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752495582; x=1753100382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=to+jAqKUwFsv0AkY0GQhPmlDuQ5+LAk2TMq6Z7FQa2s=;
        b=gf920klLKDuYNI9inr+0z5Q1rgcD+5FtzmWi7RuORFpG/sRXrX7smJGUckP342ugs7
         tj+erkFAr9NsbZqnsAHB15B8UznNKF5NdQvJXG2oyh9ZH43MKDg4qNKd9drylkubSPU4
         9up2cL7SEL64hLfuHqltgiNKK04v1ztuDOjEvqC/hO8q+B/wmIclZ3jBm3A1E90h7Fid
         7TNzdUq0ZSeei2wLiMdvSymVCN9Wehe0CsMPq14Xhdkhe6FmFommyN+G+NE1f4+g1h0D
         zrjeZOon5nJMhs/JPHhWo0a17olMbUUF3YQUyugVoJSC7lErbQn3sxQNv86wYqj16rEy
         D10A==
X-Forwarded-Encrypted: i=1; AJvYcCVz6M4WNLK9WIWJOhjCKIOJFkGU03cxwMIqXddFah+nbIc6In08qqolONunJ06MjAwA8MveOA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzp/a57fvxRluPOE+xkURGbdfp+L4RUJ3BKU8BR9WjhzN1n9ejv
	Ab/a05TaA7Wgeb9rrD1Lty6d6FsyXea57TjMnFFxwF6w1R+64Fhxoql8H8JE6qZwLB6y7hj+1Nl
	t6bQp59zOe9UFJhrGfHJqCzVb9KhAlMK9m2VqnjsQ/mdRKjAShieKU8ebJQ==
X-Gm-Gg: ASbGncssU/RmSXijfhJ66IzHr12Y3x52Ds0dD5/Tj2pj/Ub32qU0Mvq5JJWWiEUN0JT
	U7F84PaoWpFayk+lYL3/iixkah+Dq4ivwquOzGU0QBAfbKnNDPB0E0w0c0o1UO10ZLky2h2wOXs
	LIWGhug+SZg5NqUnePm20Z17G9SWQnHrfOg5ln1+QPNM7PnquoBDfFt7RpbgZCtO8d1jWxsLaWj
	8GwSRouMZMz57/7FMj8gg9ZUmBc1XLea6fxfcpL/fZJy/hS7N5z8YEPiqiiGYJsEVySqBTMnYi9
	6NRMew509RMwBlVDoMEKsqqk+Ay5QgteP1t554RuML4SG/uwThkYqiSKQSg8pbWbXhsmZE0aykv
	orH6oTwJ/3OsfnsCaq52q
X-Received: by 2002:a05:620a:4514:b0:7c3:c814:591d with SMTP id af79cd13be357-7dde99543ccmr786276085a.1.1752495582234;
        Mon, 14 Jul 2025 05:19:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/vV+coe8tEVfro7qq/0wCJ9/o2FTg1Dgu/ZwIOZQR1tYnvSopD2hrjhYTvFm/GsULL9+YrQ==
X-Received: by 2002:a05:620a:4514:b0:7c3:c814:591d with SMTP id af79cd13be357-7dde99543ccmr786273785a.1.1752495581726;
        Mon, 14 Jul 2025 05:19:41 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c9733e9fsm5990826a12.52.2025.07.14.05.19.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 05:19:41 -0700 (PDT)
Message-ID: <6f8b86c7-96a5-4c7c-b54e-25b173084d95@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 14:19:36 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/15] arm64: dts: qcom: Add The Fairphone (Gen. 6)
To: Luca Weiss <luca.weiss@fairphone.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        Thomas Gleixner
 <tglx@linutronix.de>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mmc@vger.kernel.org
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
 <20250713-sm7635-fp6-initial-v2-15-e8f9a789505b@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250713-sm7635-fp6-initial-v2-15-e8f9a789505b@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: xT6GODRRqKEAq_JPylTFQEzeFRqvoSau
X-Authority-Analysis: v=2.4 cv=B8e50PtM c=1 sm=1 tr=0 ts=6874f5df cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=6H0WHjuAAAAA:8 a=ZwcaOx7IXxPg4YioGooA:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: xT6GODRRqKEAq_JPylTFQEzeFRqvoSau
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA3MSBTYWx0ZWRfX/SWGUflSM/gv
 0XuVAiWpUETnqF2RF2KRfiPRZL2/zD1SR27M40iV9YEQevLwcFLfPGvj86S0W9zDbtMgyY2cTVJ
 R31Hpj1howcV91D3e0vouwNRb2dv8O6SlcDjy2JoSen7Gt2ASgiHofwPnag1VxY4iYAG2sAEWQk
 JftjaXcSCWwHOk562NH+74f501+G6S4o0x7H3IkWnhiA7WS+NAc3n+F3Yzc/O1hVWmv2ggopKnW
 attzaBtjW02zGRYFjICA5CKEIedePp+HZzRGO/GWqkmW22zgH85hD/GQfCMTYmcyGqNLpuzh0sG
 GAfdOH0pyvxx1XBy7z2WBT+ATXPiLUeXe9zBM17pgtwiMAIW/mhKUohWR/jdBx/F1u8FdTJp+PJ
 sxAJOVcSs6IlNAtwn9eySCmx9XuYnN6IBXpWaCakHFosfC1AHKcZMUsylrh4i54x3KVnegN6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 impostorscore=0 mlxscore=0 suspectscore=0
 adultscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140071

On 7/13/25 10:05 AM, Luca Weiss wrote:
> Add a devicetree for The Fairphone (Gen. 6) smartphone, which is based
> on the Milos/SM7635 SoC.
> 
> Supported functionality as of this initial submission:
> * Debug UART
> * Regulators (PM7550, PM8550VS, PMR735B, PM8008)
> * Remoteprocs (ADSP, CDSP, MPSS, WPSS)
> * Power Button, Volume Keys, Switch
> * Display (using simple-framebuffer)
> * PMIC-GLINK (Charger, Fuel gauge, USB-C mode switching)
> * Camera flash/torch LED
> * SD card
> * USB
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

[...]

> +	reserved-memory {
> +		/*
> +		 * ABL is powering down display and controller if this node is
> +		 * not named exactly "splash_region".
> +		 */
> +		splash_region@e3940000 {

Was it not possible to arrange for a fw update after all?

fwiw the rest looks good

Konrad
