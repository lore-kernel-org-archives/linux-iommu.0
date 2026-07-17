Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C6A3F8ECA
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 12:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784292897; cv=none; b=jdxM13CTwhfHO8ZzFnjCtmcrJYA5urGZ5sMjjVkLxt88KdbQyewa31/Kbdudk3kZ5S/26xSCx+FjJr3SJ6+7euALyGH7X8sdKBOIFzWryTUZq1gxSxJ09HBiPjwslq3RSaJbFUcvNVljVGs6B1S1Q4FCsvui8gRRaEX3PHi7Nro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784292897; c=relaxed/simple;
	bh=FMQbLCZIVBlFvilgBWXJ5CXf6kwmbRy28h87UQ9QJMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EcuE9I5mSPeHWLVnigu5K90iwt/3ygYsHTA/I9dELP+asup7mS+Wv10/P6klpTVeUklgyeiM20tJVsCzn6wezpdtQGMT87Ogk1Baw0ADAWTuIc+Gp5CPRbtIYll+7txMruyqqN4d/H01FQ8DQJ8rymxPa+ptb8E4cV/DnwmvabU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PRrKUIGR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DZMcPk8H; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PRrKUIGR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DZMcPk8H"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HCStCp1900956
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 12:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/I/1fyZeVVo5EmsKe3AogbAV9WwrxlVkfS7F6TW8TAY=; b=PRrKUIGR9xdwudUW
	9fDE/gw5+B+sqwu9jOxj1pQ+tX4fy8h62bDQnkrwIMoDDxSoDsf2VO3CKerPJg+Z
	uFo9eEQlMlL4VVUFVXPt0eihD/aOD89dLS2bbgAaRqogx4WyuQxmoISfpvzW34ic
	3dKehvy6AXVW5nqSf4v5pN5EsGJlZmXd8lcvI6O8h7mQJz/5QRvCybEUzpVlXfTi
	wQ8ndfqMGcVF40NjoIBK2C8ZwB6ZQsIKEMA0a9nAQjIOPtqmAcTJvpCk/GSGx3Gt
	gv2aO76NZGesmji9rJrJDy8+TIQn45/2qOCyO28as980xmppQNO1tYyB43YgvCVJ
	sKh/JA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffe0usprm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 12:54:54 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-930b81c13b0so5967885a.0
        for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 05:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784292894; x=1784897694; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/I/1fyZeVVo5EmsKe3AogbAV9WwrxlVkfS7F6TW8TAY=;
        b=DZMcPk8HLqlU3CLN0M5I1jfWr057YAwtAUdt+xS6Ht5ushfqc7dv6RGpM8muARzu1F
         zQveruM+yai45pyw0ECsdcN/ICeAVxDKwPb6+VvatTzDZwRKdUs+CEaHug/aA9jJzRNs
         vUftynADF6jJ+U/26RShPKkIxPRciY2NMnvLxtCn6ESZ8xJl4B2U8ekBOvIXyI7Bbhz6
         c9kkohCUKhUw2PAKCUlAH6BmKIZytagfemlamtK272BJVm1VGU91VXUdCTpBb+pFAdYV
         pYt0D2eFUrtHHDdL+8GCDFYQnrsrsB691NDV6T0Y3UtQ1O37vDtVwz52zITJdJ5+B2Ap
         Q6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784292894; x=1784897694;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/I/1fyZeVVo5EmsKe3AogbAV9WwrxlVkfS7F6TW8TAY=;
        b=hSqmFqDAafsEB9vYPT4gr0aIM93XN255EmXg917o3geWYM842g69VTFzNmhChlMxjb
         yJH13tTGqGd5gQ4ayIrap6XbjFX10XksXPdhfdyNytJZj27D3xTcHGbFORVnP/owAzfv
         Oezn76vTgQM9eGgVOsNMdBUGq+I0/ia95oiSf27tr/eI7EobfENcH41HRF9W3GY97Tkf
         Lrx+vhM656mQCUIQ14RhyEqL70Ng0naKjfR4CtNA34+Q7uRQrpeFg/4KlRN8WNvqvG34
         hNLSa64vZAKgUyoVPRhGRBCcBfCrekl6O+i1/kgIusHLTjp6xk6t7o/T52Yv906PlBWt
         9H4w==
X-Forwarded-Encrypted: i=1; AHgh+RpI9vKvqDqB3mVxpRc+cR/ERHvjbsZMuXtIIxi54TLyfnPWgucr46jOLtpZyqhQJnBSFewgKA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzrcab/2NILmXIuC16ZqMZH389U0oCQaAYeNu8zeRUh9sfpXk4z
	LbGXbNVszeZeA5D5SWGtLVmYwIzwyKsy9EC5ectgpOHi2o2KBE3PyOKv5VQguG7cmfFiBrBjh/X
	sCn8j0S+HneAfmng55KXfRWhqSbDcICT6m6ek2rjKgvCwflFoyPmQFjVpdg==
X-Gm-Gg: AfdE7ckeONoGkc6SwLler/wTVEaHq2kPqdLMnr9FsuQ0mC/vK31HDC4QCT//Sq2cvHK
	DVv4aigOgjfH7Q6x5c2aKoAci2JFJlq9WAo3LX75aKHRlDbt9A9E9yZ8cFG5NDX4dSGBjiTt72f
	lpIfWUwGOSH2i82/ULDYHSaCyz7DRQTd2NzO/VDFkgA3+nGEJvehTH0RnKtEaKmkgtewM16wtkn
	/MDMS6LaOXCSXinAb/1p573v+iB4HUYSvawkKUlyq5sxbB8sDjKBVVZHtyUyp5Zk94vXGy+BN3y
	sSxVf/ed8DXt0srjgyMup56mjAZgFMLHY732QG6FvXY/Cqj1w/BlcyNnV4t35pNQimiPfyaQrn7
	fglVmsZ6bWv2KoyzIWqUjlSXK
X-Received: by 2002:a05:620a:2711:b0:930:aff2:b1e8 with SMTP id af79cd13be357-930b433be83mr209108485a.8.1784292893671;
        Fri, 17 Jul 2026 05:54:53 -0700 (PDT)
X-Received: by 2002:a05:620a:2711:b0:930:aff2:b1e8 with SMTP id af79cd13be357-930b433be83mr209105585a.8.1784292893257;
        Fri, 17 Jul 2026 05:54:53 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e6fee3304sm673740a12.5.2026.07.17.05.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 05:54:52 -0700 (PDT)
Message-ID: <e6a6c504-40f2-4510-901d-77d88ac4ac5c@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 14:54:49 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 13/14] arm64: dts: qcom: glymur: Add iris video node
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org
References: <20260715-glymur-v9-0-8cf2cbe12a07@oss.qualcomm.com>
 <20260715-glymur-v9-13-8cf2cbe12a07@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260715-glymur-v9-13-8cf2cbe12a07@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=deWwG3Xe c=1 sm=1 tr=0 ts=6a5a261e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=xYufHl49NKEuV1FEiosA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEzMSBTYWx0ZWRfX7VEJsIiB//6I
 QgUAV5pVG/e4fHGODxyExPj5qsIKKUVtbAAnYPAcR3U/pYqqOWlSEmxRAIHoMROj6JyXHlroi2k
 hK1eATFuOPH4UDv1BqwXjsNiYYXgwJZhAAoURiclpY0os4vUfygx6XckKYrGfc5F+oVOM7XUBhR
 QjXemkdTwVpuGxUZGAnRNkHuYuINkApG0pdw0MGj9H8Vw1fYd8E/KrvPA8QCFC+WJ0RF9cBW0BM
 LyCKQbce5iBAdb3R1u3QoXuB4iLFiuPpvgoNh/vXQ+ENHQg/kHEBCDchJVXLtzypFBERsRNGMBq
 3w0Cv7OdlO8zj0zNYLcH2NmnB12/d47XQEaI8+oj5Elcggkc6B9E/oHChPLXOZQr0adQmZwC/Fb
 j9Ap5LadCclSSlcszNshBzpmjsQYNhupdjdZjc3LzuulHNfYB7du5R0ZVkLgdYewacZhttSR2V1
 HEfXLyDXOklsd5OITYg==
X-Proofpoint-ORIG-GUID: k_GoFuHLZlmseywqzH6xUbKF2xiEUn2A
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEzMSBTYWx0ZWRfX9DWYwQnEvjnO
 UpZuD+67R2YlOdI4m8XVazp7iZCl+psgrxQN8HvjvHB0tJlOcTbUh/MUyV4uZmfQZ50WQRMtI4U
 5ZDFk4gjSgGcfjPC9ukcDVmBHCOJHv4=
X-Proofpoint-GUID: k_GoFuHLZlmseywqzH6xUbKF2xiEUn2A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170131

On 7/15/26 4:10 PM, Vishnu Reddy wrote:
> Add iris video codec to glymur SoC, which comes with significantly
> different powering up sequence than previous platforms, thus different
> clocks and resets.
> 
> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Tested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> # X2E94100 Asus Zenbook A16

[...]

> +			/*
> +			 * IRIS firmware is signed by vendors, only
> +			 * enable on boards where the proper signed firmware
> +			 * is available.
> +			 */

I still find this comment not-very-useful

Konrad
