Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9878B39B971
	for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 11:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773315778; cv=none; b=rTrZcEVZYLik10IL//mPUJU3iK3+FwvlTOquFUqgeOsFkef/5Gd/fhYOyyzBMcaWAjBn14211+1r8y6/UqtMRqETIRiHRu7OBl6ZsX+aOFC6gGICDu49NEHPbRWh+QLFuJqU2osflXymOq5Rcypvg2dKg5vujdoRoMq9fra4pOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773315778; c=relaxed/simple;
	bh=vuDtbFLrMiurzB2+xC/ot2IB+T1N8Hc0u2jO0iC2vG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bWWxF6Opa2DECz7zHydzM9ETzAjVIbxmH+mbMIRmiz/5qZM3mMfd/L4Uphu/hCTlmq1HljVPnWo6Nu70Q+BZUMwvNcA2s5pt7ffFgSp7SzmJjQrn99UvFjVKE3Z7CoWHW8/23+HS0411bMTjLqdlXcwwF4zo5YxzhNVHCkSW6hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HmaP0o5E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gAZngkY/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HmaP0o5E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gAZngkY/"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C9XS4d1922480
	for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 11:42:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W9ejYWHNwRhjPiGAgnplcOS8lPIHbm/6D31/N+auTSw=; b=HmaP0o5E8kDigSFa
	alJVniCiNF7DjBpO3slqiNJ3tC/PYMDuDwHYrqAZ6m3faf3xBUSqMLfpUEiT0ME7
	uWWAeSVIZ60cNAHJhwuo6Vb8dOptnxFIZD2ZPlI6SJHGh0bEalGe5AilAQjBoaDU
	QZVlr/4PFlZA2kIerIpl0o8Gs05Rqi4LvYe2xoN8EAgrInA5+6ymKHj2jVoDFZlX
	twDN9GpYJxK9TErk0jdzr2qqWM7kBKQCbwArOlfCHOrYnIloY9u/so8cENTOFlPK
	42iYYDiTfRSrfY3aZO54lNm32900MmfmU17DmtlRZIiqhD4bfqXTlQnqegCK9Mod
	59ZCww==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cuh4wsxu8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 11:42:56 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ae50463ba8so80717515ad.0
        for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 04:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773315776; x=1773920576; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W9ejYWHNwRhjPiGAgnplcOS8lPIHbm/6D31/N+auTSw=;
        b=gAZngkY/AY2SZ1AJi7dmZqwk7nniTCKpqTbkJpi0wX/pcGZxGqY4fHDNJFDQBzUM8d
         H3+qfUzthHmWfQ5oVRIDLew9dF8BMN474EM7J8lN2xmLBrB1kxrre3Hp+rdU6nxWsE7s
         vAQhXMsu+eHbGSuOwYYxTZG6727Gab7mvb1FUGiIeAB5MaqTAWiLlB1P/e1WBs4Ry57N
         d9QuxxtA1Ki0ugs/Fme4pOIa499ffrXbpVXV9W0aHIU+mEXHw29I4ZWXDZjOO6WefL2B
         AtJ44FJMkuAF3currZSg1mZ0UomKT8boCa9tGeEoaGhbJI3vj4rU6kr4NbsDQaje7nGm
         NWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773315776; x=1773920576;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W9ejYWHNwRhjPiGAgnplcOS8lPIHbm/6D31/N+auTSw=;
        b=bpziYGDTfrVX762ohl5D9jwXr37qQn422FgA1HjHKgDcfm0kO6IprgEbgdOPlbO395
         DjzxF+WHD8Lxl4FbOfKqs75WhKY57YE8d52gz0131uGDXxjs+JYcXh6YgrlczLn82N4y
         kDNT6TZacgNkuiAaqWKpv3gcF85F69aXZQBfiQ8mODPnJ/hXdJSyo7FwKkd9Nx8tdUux
         ZmZ8HMfxBscqmuQAPlz0jWce1SUO2mkQm7AQWfMTOO1mJrvO0FXTtAqFHUPL/+g2lvNq
         WZphCwyX5pLuPpOYs7zIAfXtxumO8u5idKw94LwkXKIc7UxOJGN2V5nJ4F2WD0D8OGcT
         O9pg==
X-Forwarded-Encrypted: i=1; AJvYcCUAU9oV0TM+IvuUR45KOax4RaeR7tAuRW97NET3nX+3SBJd2CfshMlCHyOOkBYdLXHostdNSA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+oGcgw6+3cSggvAQS84OPjZa6EPnc+Ae57jTLK+E8vMB8iEMt
	BiF8cjJGf4h7CdgXWzgRaQYNEShBXx7KyKoutMwpcdHe5Amk30ZXszynrw9e5wlMjpCcF6X8G5c
	sYRxrr4/Z2fqVBi7OhO49f4uk24vIzn9TT8bU8uz+o+JC4jWs69ZwWHdz1A==
X-Gm-Gg: ATEYQzwUJsbR8ru7sjGeflydU+f/sTksFkThxZJhiDjS54i9nZxgJk1gHtFyjJWnfwS
	DQivvOJhTYqssu3DAw7ZCnvLg8YaBi1L6npN0z812AIkZhfoxeJvgg3Nd50FmkOYgM/aDs1qWvY
	lA/H8Uwa7vJp+eev3TD+wEIiPXoL09nTJCiJtGDrQF73amUe2HHxS1oRWyG8Z8p8AbPF8mQee45
	HGJX+GD2FVba7hs8M2y2JDf2ihE99L3g23a7x2OKt/H3MdZnjbXiqfgbcQCTYhwgEeuFpb7bwcY
	CRmA/EcynQCzWWdCTCbVh8xFL44tYU9WHu80A7VFuZG6CX6UVdiQbuE45pfBBHzBdp1GS+bNWoh
	DPSWu1s3ao+pQpPXnojJZBkD6SdsrXwLScHz1/d8IPCh5Xc7XIj5SA4Qv7g==
X-Received: by 2002:a17:902:db06:b0:2ae:3fb2:ec9a with SMTP id d9443c01a7336-2aeae7ad446mr64958765ad.16.1773315776343;
        Thu, 12 Mar 2026 04:42:56 -0700 (PDT)
X-Received: by 2002:a17:902:db06:b0:2ae:3fb2:ec9a with SMTP id d9443c01a7336-2aeae7ad446mr64958285ad.16.1773315775895;
        Thu, 12 Mar 2026 04:42:55 -0700 (PDT)
Received: from [192.168.1.10] ([38.254.186.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae25cd67sm56194955ad.38.2026.03.12.04.42.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 04:42:55 -0700 (PDT)
Message-ID: <04eabe08-f339-4d9c-8b61-184241d192a4@oss.qualcomm.com>
Date: Thu, 12 Mar 2026 17:12:43 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/3] of: Respect #{iommu,msi}-cells in maps
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Nipun Gupta <nipun.gupta@amd.com>,
        Nikhil Agarwal
 <nikhil.agarwal@amd.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas
 <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Prakash Gupta <prakash.gupta@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, imx@lists.linux.dev,
        xen-devel@lists.xenproject.org, linux-arm-msm@vger.kernel.org,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
References: <20260309210849.GA591344@bhelgaas>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <20260309210849.GA591344@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GcoaXAXL c=1 sm=1 tr=0 ts=69b2a6c0 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=FuYIH7Xx0xzBSkYrynBYgw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=7CQSdrXTAAAA:8 a=2oAOsZZM3GA0Nya8fkwA:9 a=QEXdDO2ut3YA:10 a=d1F_yjlUjjEA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: _827XQbylkytgvX7UXYLr162Ne6KKLUN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA5MiBTYWx0ZWRfX2TS3gmfGcLkp
 wC08CjTFxzS5vlXz+id+AXYwDFibwaEa4TB3NfmiRE5Y9CysAXSdAEIYgQS8j74Jb5Zg8x6Prsj
 A0am9q6097a9kOE9T7yToe8xMYum0KsEryQ2rU515OwGd3M9irzDEklUTgWpkDpQY82tkjkwx23
 7YqA7VzfIea+51OIrIxY4AiNptXwPBdjWQtcUcePhhmj9reubPhcdr9yKq4pKzgGE0yr28/Oi6k
 7XR0eOzA8ZgwiS2Bj+lySidqyvVRz6DjyfG3xxGZ1r+GspIjTnl/MBIeSfIoEVCDA2sT10+lCYH
 rxZj/mscLoXZyg8XxoMs2Hy8G4j+8P7S6ML/irBot2MClqGmz9b1O64CCjZGd0Ze0sjwgycieeh
 DcuacYXSA/e89fInTbeiYOD9zdxoHGNFgkmgWZIKTKdGgw5TQBMG456dhq7qtKeQjJM3nYiic8s
 urdXTwdfkI8gFE5TNSA==
X-Proofpoint-ORIG-GUID: _827XQbylkytgvX7UXYLr162Ne6KKLUN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603120092



On 3/10/2026 2:38 AM, Bjorn Helgaas wrote:
> On Mon, Mar 09, 2026 at 01:03:39AM +0530, Vijayanand Jitta wrote:
>> From: Robin Murphy <robin.murphy@arm.com>
>>
>> So far our parsing of {iommu,msi}-map properites has always blindly
> 
> s/properites/properties/

sure , will update.

Thanks,
Vijay
