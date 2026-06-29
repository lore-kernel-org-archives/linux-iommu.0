Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44EC3B14C1
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 18:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782758422; cv=none; b=SOuVQiQu/tM+KDEA8W2umuaVuDFEZ4EQKgBmeImDGh+1kadRqVYK+/59cd33UDJCzJSJBe0RrlKNWzV2Z8zPctysJKMQ3NvRmnJ4Qzll7hcNQZZXRHRBj1EseYjiUXAnwZvupvjjVg1QJCFCPsiWBLi5Mh9PZnfa8vl2UH04uHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782758422; c=relaxed/simple;
	bh=q5tOmL4fQXLf6rF97LL5TTgbz0UYUqEg5tRWbsqLlfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nltqnFXcWJL8OO4BiBc6d5DJvGC5J4ugxXXBtCYnG+OMkM+zjQda3fH2i/0rN33N4S2Izc1RhGpTmX3P51+PLZ5Q49GUVNOQ14pbPY4zhTt5jC2ZJHVMhYseMtTXFytao2rCGU4ErOnVKsB0Yy/RL2b880YcNi5xBgLYBl6YvlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LPCtJUpy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CleovdUU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LPCtJUpy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CleovdUU"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TGK5EC3380400
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 18:40:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CffFp0WhGRj+vqvsuwqU3TnnmViodZOWqRxtTaxYu+Y=; b=LPCtJUpylBlNWhDv
	0fxXRaARpZMPwhKF2iYU4JQJPrVJ4CHxfUSHbsGlRYH7GA8iUEc/OPHgQYnHK1fh
	6RLWWHzuDVzHZ7KFJNM8LqB6jiZm89AdLX85iQTgaCdin098Q4mfyUcJPxUuFPl3
	aSajWkgso+hCNB2cZvPakgLxy+VsKmVM1Zz0X7de3gAyD/H3UiQ+sJi4BY/5Fznb
	VcIHb6dtwr3PAdWbWjraUV704k1U5tGziQrbzycM7GloVacTvb2KplJAB9EiHT+O
	ij+6fqEX8nmmDpiFssuBthRdCrTZDcq6wGCozkeIBPl4NLFanW/DczUgf/oAfqdf
	DGm80A==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kp7k2ju-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 18:40:19 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30cb5001ed8so3549805eec.1
        for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 11:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782758419; x=1783363219; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CffFp0WhGRj+vqvsuwqU3TnnmViodZOWqRxtTaxYu+Y=;
        b=CleovdUUfcPio0FXsJ5fuq2qvcCIzgB0kW496MNuN0woOBpufDTvMIwtoHf0THq078
         dG595A6QsLOgJum+zJ7Aha53jxS8zTgtBR7spYVurIo8QGiHTnzS5+T5hJSmTMbD9g7E
         gcSN4+GL9bJOHKgsFqdpDRKXUZNfh2audZjXLRezR6OYuSponrf+ydXVz2dcMA8Cnmp7
         lM7bc0POxmbtERP0KIHozsAzQC+actfz6nqfJlqhylQOJbzBkrgiM0GhYGAAYWWDd6l6
         XlUmzg9+ffyQEVjCTShx55i0HCzsM1gzy5nHzxYEZ/BDnr+lSiz9l8ScrdZQCc2SJml4
         REwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782758419; x=1783363219;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CffFp0WhGRj+vqvsuwqU3TnnmViodZOWqRxtTaxYu+Y=;
        b=qCqj3AVBB3q9+z8XtiMKUfZqPTuWEEiz4s4+DbfkbJ1VMQfob7Au5dBDjJFUcHedd8
         /LxJOstRMOTd95LXJdWnzMGkENZofbooXm91ksu5cWkJKftzVPZ/w4JLL/v3nN5mEDkL
         uJqt2zosT2rRNdknpye7YHzw8H50ydFoN+eUioBfxENeX1txbTQEM8x7M9E1Cj9rY+N9
         06/sm5wJc1+du8PBKO11gjKlG516/+U5gkJheA3Fb2QCrpKW4uv+sGs2A7g5X7BhpFHu
         4uqpDvFou6CRZPI/Ql08V+bYIOmP93ft9cG/hHz9qVxsmPfVZGCnVaxCoYY5eQWGLxW5
         YmpA==
X-Forwarded-Encrypted: i=1; AHgh+RreV9c2hZq6tDedJ44gwEDShMbJ560kj7TuzSxx4I3XhTNgT3JRsBccVFe6eduL8RldK04gIA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzVhZI5c2yz3UWYadZxf+ALkemV7Ow8pA6PwGFrBTR+2fIGAuHN
	xHsQPqQSpiPbf2+60TNJ1UZSW4fbbpTWhPc6F3NJSaaebtyDUOj0AXTTTX5/WYBu57qb7bqxeXo
	58xK4/8oaUuGCyBJ5U/S4covquO8T3TIbkBfbEv44XBcu7arBzbrNEMp5DA==
X-Gm-Gg: AfdE7cmXULEVEF1P+d288dOwJ4bk0qSJIgI3tMZHYFoGd+aAMYDsv08J/EefZOqa9oq
	9+tDF5xcXRkycrnJp5/CeudSzYyrNQS+rx/2rc+il1Goz17ybd2m9HWHiGnczii6Zk7CCNAl3qj
	okZ9CvFZ9G0IrJbSvdNVAGSj6Ci0cRndIw2lHxXfvsLPLUDKhTpny/tUG9p6IbQF2hjWeVT4zxE
	CfOjBksYiD5uQDGTZgTYkaTevERRqkSErsd4PJo8wZJVF6SJ4z6L5htVpM3D3e5uvjFzcdjpMZP
	8RSdF/e5b1CVlkwE/xfKas2c1oCcMo7iYbK+zFTg9Qf5X92zPklx5F6YhiBScsLVzrJPT8gotzp
	MA3S+Ta0PnPP5p62HZLEbHnj/49q0LpImaw==
X-Received: by 2002:a05:7301:6190:20b0:30c:116b:42a9 with SMTP id 5a478bee46e88-30ee1489a13mr269171eec.26.1782758419302;
        Mon, 29 Jun 2026 11:40:19 -0700 (PDT)
X-Received: by 2002:a05:7301:6190:20b0:30c:116b:42a9 with SMTP id 5a478bee46e88-30ee1489a13mr269143eec.26.1782758418783;
        Mon, 29 Jun 2026 11:40:18 -0700 (PDT)
Received: from [10.91.118.212] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee316bf4dsm128143eec.17.2026.06.29.11.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 11:40:18 -0700 (PDT)
Message-ID: <4e438b43-33d2-4cde-a5a6-67e7f8c53787@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 00:10:07 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] arm64: dts: qcom: shikra: Add Adreno SMMU node
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Bjorn Andersson <andersson@kernel.org>
References: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
 <20260628-shikra-gpu-v3-4-9b28a3b167e1@oss.qualcomm.com>
 <3ac0279b-105c-403a-90e8-822c28a6dcfc@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <3ac0279b-105c-403a-90e8-822c28a6dcfc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDE1NiBTYWx0ZWRfX+fuLCXbXvI0r
 nNua9EhHfqWEAWBjmTaRg6IYcDdUXD9e+NcqsLbo0aLfu5zxLEAzJHEYKP6v2qJDADdpzkn9bYY
 5ag1yf4elgnNnhHRdACoNG5l87gAN/8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDE1NiBTYWx0ZWRfXwPD865O8RawE
 to01otRBR0DcmKmTf/FJPihyCiLkcqoKwEjyoCdP3EqBfjYBNsQRsjhT8df9q8gJ5YNBrcomyN9
 xzq1RiadBltc2Fts2JRaGaYrncXsSndZtk9Y1K8VwEn0g7ejwSM50xHD9vIhczvaspu5c1BZFRB
 Jyn/XY4VcsApSgeNbou5GJ7vNxIpnbxSbsEWWAmPwGPaUNSCX46Sb/1v4F+2HmMtp2rFBWqrgTi
 e+bg6oSv2P6V3IwdW0S0jKDUzb+u2VP3FeaqVAEl2m4UeVuH6zrkn9Y8+D2HesfdcFZTUP0ZFE1
 eNSWwbtjTaDtSTI8OIUZD3y4+1LuFLph6IP6AzGCo4Xi1kQJ2q6HPB3iKKLvGAK6G7JxFf+1w0l
 twTxV11trNTi53DaxNQxkmJnp9kyaOqVxAoINli/50G6VDY878IdMF0SIgtla9XS/oxES0GaG30
 X0ljYUuS1oTaaMjrdIA==
X-Proofpoint-ORIG-GUID: xvFs5iZP5Woj5NVO6JJuHNEKUHn6odwf
X-Authority-Analysis: v=2.4 cv=MZJcfZ/f c=1 sm=1 tr=0 ts=6a42bc14 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=l0uZIx2wMuzZ-h4bkHoA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: xvFs5iZP5Woj5NVO6JJuHNEKUHn6odwf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290156

On 6/29/2026 2:16 PM, Konrad Dybcio wrote:
> On 6/28/26 8:23 PM, Akhil P Oommen wrote:
>> From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>>
>> Add the Adreno GPU IOMMU (adreno_smmu) node for the Shikra SoC.
>>
>> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
>> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> 
> Drop the sign-offs that don't apply (presumably applied as part
> of shuffling around the handlers of the patch in the in-flight
> tree OR missing c-d-b)

Ack. Thanks.

-Akhil.

> 
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Konrad

