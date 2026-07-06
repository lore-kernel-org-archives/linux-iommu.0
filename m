Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC279431493
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 09:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330519; cv=none; b=bX3GOsNsn4RkNY21KeWBDYrg8Usb5HpVIJARn9Zxa+pHzDhlJyG8Zq4tyCbcfqIjppxtjswFP4vGX+eaWSFMdWrEDWZV1FThgWcw+nMRxJL136gqh8XIuHZ/T2VJr3WkXYNA2x6klICjDgNz+aPuS32FGMA+ysSXoSZLzQvGNF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330519; c=relaxed/simple;
	bh=zbSdvGnPsrJuxoFmkT+ysJkcGRbJBde2G8FtEcwduhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oVG1Qzdx47Jx2KS7ZvG2OUH5TJ9q3jQ6BmSHKiao97ppaoaUWTsK0Pstwh8PLptz1qRjyENV/K/GTtfMi2Dpf5CGAdNEuiAt5q50uSkOThjekKTIIAOANNx79Eib7zmqp09XZhYSj8JkWRc9Sl3HS1Pju6Mjepp6Km5Ubh7ESJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WaFTSykR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hfSmLPeC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WaFTSykR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hfSmLPeC"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66694GW1142700
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 09:35:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QTo6r7Q0G+3mUeTWof/QQHuOa8Dto24iGRfkDVleja4=; b=WaFTSykRMZ8moz5w
	cJT86o/XfgpM2XMCIH2HCskKeqkKUFiSrDoSQv8gl5Oblg3e0tgetbxsRxRf+tIQ
	aRSJYuXP8tXITqmGenuR3EsdSIOpMNoopfaUcHqmXgz+eggZvg3GF/tDsrDf1j97
	xW6uvKwGtO2168cb2js9VGiYbGR+hAxkoIZvD7XQnFoJMoUjkUhY8X+j7S7zak9s
	Tpdn6GoZx3OETA6Fur8WGB0Xzec5u1s3bO+V27hizCcfui4XV7f75lEn5EFyKooe
	c2awz5EHD/7scCyteBHvYA2MGoU7YjHb56uBbsi+KnyCUWUZAx3U07ZFcoJmCMl4
	qe8bDw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6s4swpa7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 09:35:12 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e69a569ffso9860785a.2
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 02:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783330511; x=1783935311; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QTo6r7Q0G+3mUeTWof/QQHuOa8Dto24iGRfkDVleja4=;
        b=hfSmLPeCqVxl8U/SZIgBSBZWcQKkSF4CjySBQSTVsJS6OlDp56a0OGUowdKaU+rrlF
         rej536qVyPCfSgXchiUIwnGhmWr6Ynv9yCeNZRtUe2panQSG3sQ256AihKbZoTnn0pk5
         f6+zfugKWLrGBIfMgyZTlmcX+A5rvaTOGIVEMK4vRIpEBKjMDtL9/sxPZLF7kUsl9l8c
         7tf6tcmvLSjwv19STy3BXa5B0F7lOHx6PXQgA876sv9rxS1s1HQv7K1cR6rHfDLfu9ml
         2Y+UlpkUfHauJH1nYrwbOW1SUqCGx/uBKjvefs2FevOaHnZLqDPZjs0zwr/Zk206MWzl
         ZT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783330511; x=1783935311;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QTo6r7Q0G+3mUeTWof/QQHuOa8Dto24iGRfkDVleja4=;
        b=KlkyJD2kSFg8HGvPpT12Q9PNz54kkc9eHLFLhBHvvNSn/J/xuTQp7iZiWL8f51X1eB
         jGOAtG4+zu64vBwn0zHL7mHCKospB7mrqQVJkGaWRZUsrNEMZCzy0jn8FP+TD4EEHvaz
         uI6gaEGSqMPzh8uml3k1nUACcss4oYG3qq112C5zVBtHWpebpvfDPsVF+Xfp/+UkWm6v
         kLBM8tHa8/Eg39/jkDtlOyGUD+0k2zKlb0ONt+29u6KrCB3H5LcLSyhRJemZ4NGumg6E
         3UXeb70gapUYWhb+d4Fwjh11CLfP8bUtBoIjvxBtchNdRvUaoiCSBDJ+QFS46+6ADU4w
         yGHg==
X-Forwarded-Encrypted: i=1; AHgh+RpsBv+q+YNTnJkmHpXvcvDCKBQK8mUMo+YlfVx+SWRrfKZePdcohYLH+Pi/Xy5BZBvub3HmSw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyOF62CH4EfISFBmf2VTNr8QJteAH9u+UJqpSNzlJ0g9gC/Bm4P
	dGrdFkkXidRecXLJNkqQgfOuMmvr4lQVbub64npteBUxkhgaI6NDMzRQYjXmsD+6E9OgjAL/wc8
	jM/1Z+AsNOc1G+xDdV6INVLv3/+wJngK0+k+IA3hZJkO1U5Dq0F29Di7UIQ==
X-Gm-Gg: AfdE7cmLd5batPJxxDDbYazbzTglp3Po2L1+IAdB3PdvebhQKAgWki+u+ZZieKzBANl
	t5fHuRofff31lTiIH3wMH6pmfhkyT9+sgxsgkmOC53vO3WLTxJLTp0pBG0bIccGRjVFWvOMBscf
	IWZoYDUcYTT/5c7LAWvyVGafjdsSumotCX3uiDCbGhmx4GHIdz+FNFByt+t6q01zL0P8NUXszUC
	5SJQncg8Mu8j0JVvnE48XKzkTg8G8P0eEu88nP1vgu+YieJGsZHHFfHUakqnrPHkGm9XOjqqAOv
	zwW12Y6DCb4F8xr+8i5DmzIGX5QaFZXOb3SD4mKkbGf/IPABf5OGLM+fwNt1huXtEq687BSQ90r
	VRgVsiETiNizqEvSLVrr33OeHDN/VhWlgtbM=
X-Received: by 2002:a05:620a:468d:b0:915:fad5:9096 with SMTP id af79cd13be357-92e9a0c23dcmr868735685a.7.1783330511357;
        Mon, 06 Jul 2026 02:35:11 -0700 (PDT)
X-Received: by 2002:a05:620a:468d:b0:915:fad5:9096 with SMTP id af79cd13be357-92e9a0c23dcmr868734085a.7.1783330510946;
        Mon, 06 Jul 2026 02:35:10 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b62c6f5fsm717445766b.51.2026.07.06.02.35.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 02:35:10 -0700 (PDT)
Message-ID: <706ff852-1b61-412b-8e25-9ecab968361b@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 11:35:06 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] arm64: dts: qcom: kaanapali: Add QFPROM node
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
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
References: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
 <20260705-kaana-gpu-dt-v2-4-6ac53de56314@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260705-kaana-gpu-dt-v2-4-6ac53de56314@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA5NiBTYWx0ZWRfX7l9EYE1stnSb
 9Us+G44iiopgdioem2z9kzpYha4NXgPtIgmZ1C7VVsbX64XiuW0B6WI/bDFrNPJxolTawhHY3Nl
 A73/EMVW8/dmeHG7TOUZ1MA7hABoMfM=
X-Proofpoint-ORIG-GUID: LCLxgn0xngiO-bo5CfU_onht21Ems_k_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA5NiBTYWx0ZWRfX8TAzFm66vweE
 zO9ueE1iDZ+A9rVHxBACROSdHhnzKrmjkoQA+KXHD3ERm6KMv989XMQ9ho5wbb0RpH/xQH3fSpI
 qIDnDpYFRaKnG5BiiCe1K1D3fy+iQ3i2FcZegQPqV7t4AFTgZC5hRVvPN2X3zcExfDsgyauUaWv
 D5DN0bYTJRUr+dKxl1R7AkdAEzwumtlIIRv1b2g+K5bOECSC5zLGRZfLf2TQXRINN1a04oiRgne
 4Zkdx7/EW4Sbhc6ie6NhIV+w+eHvPscRc6K+DS9czvqwzbTgT7DQfMC7Bf8oWhdGFB5CSUvpNy9
 1sHcDdWcvxqVIsrRESxGT9lUHA7spbLy11lUQB8RdGIbNp1mxtsPDkolLJzvJMeN88R3mxw7jPu
 hMFLZL7UwiJcZGX73600/e1ds+7/5p/t45QbWIcwhTbX0LiXgqw2CUZJfcrMW7crRY6ePtulGYi
 JBR9+SXVNu1MSIgsXIg==
X-Proofpoint-GUID: LCLxgn0xngiO-bo5CfU_onht21Ems_k_
X-Authority-Analysis: v=2.4 cv=ZfQt8MVA c=1 sm=1 tr=0 ts=6a4b76d0 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Z4vjmEANuloM4Dk0XroA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060096

On 7/5/26 10:00 AM, Akhil P Oommen wrote:
> From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> 
> Add the QFPROM node and GPU related subnodes on Kaanapali SoC.
> 
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
