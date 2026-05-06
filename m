Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E483E9299
	for <iommu@lists.linux.dev>; Wed,  6 May 2026 09:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778059961; cv=none; b=G6srNSx2P1uim8JA92UAFq+MYlgldqmTNF5rJdGJ97XV4xajpTy3zLkbWYPT+2aYvETJQG7k+Wwy6QB0rWK/3N2Lvfp93GfSG3dnnLMq0lrM7ZgaDZFEMzcpiURGns1nFyMp9HCkgGMl37B7ep2D/6Z+us96FpI+Tv8IA7r2HvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778059961; c=relaxed/simple;
	bh=f0FQAS1GD3dN9uwV8F5vKw0hNMRhc34lZFSrPLYTbjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e7SNR1M8EA9lwSkMSVDuYm/KfMezQw918vGQzGAZX6okuFWi3yCg7p/maK6UFuuPdAW4Gw4c5CDzvalRfClzg838JSFfGQNQOmS4oO9MJAdXc9OHgBlG7JDD+IF5M+0cZvThuOiNnB8VEVYnwgRH19hnqa34sBmOdS8cKyMUSW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XBrBBIeE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i6dl5URF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XBrBBIeE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i6dl5URF"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6465tTW6152028
	for <iommu@lists.linux.dev>; Wed, 6 May 2026 09:32:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f0FQAS1GD3dN9uwV8F5vKw0hNMRhc34lZFSrPLYTbjE=; b=XBrBBIeErZn1ngc4
	lvmrsupECFO+P0Qp73xN2be0BwwzxheaW2Fu46M76lHtLISshYm23wjtootAwnPK
	UOVWOB9yOQ2RW2ZY/weXgpvw6ibGCTudakdq/bvOYr8GEYB2JwqoT+QC8tAkAXlC
	bpaSi6ROatTzs++iP0ttFRx8C0T57JpO19s+kfWH84kl/s72B5eKC8U7TkLjlry2
	A33z2hUctu0DyYso+8GyXpSG684Y1u8z0ns9vAirOT5q1mlQ09wIU6kg8ggkwIAf
	LAeneRU5rlXdcs7KLDaSg36lx0J46pE4O7I5bWnfZkr7E2hG6T/LHYEo71bo0GsQ
	Cki22w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyj80c2v2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 06 May 2026 09:32:39 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36512f223d8so7973698a91.3
        for <iommu@lists.linux.dev>; Wed, 06 May 2026 02:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778059958; x=1778664758; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f0FQAS1GD3dN9uwV8F5vKw0hNMRhc34lZFSrPLYTbjE=;
        b=i6dl5URF8SdHIwogiVCQH+gPYN8FsE731XCxN5ydMWlPeAqTlKRTAy/DVaYBLj4sQ9
         skJzNJkXZiw0/9+cIPVpajsxG8x0Yf/c8X9Qd/wCNKT3pCeP8dJp0vB0iae7sun7VZB7
         OXWejMrhylAwZLCmQGOaH36xbXQjdN7jgSbIm27Ytv8vQ8GShtfwe4mBfZyAUF3sj7oA
         nuuEQnkzfk6SU/J00hDDV8ODSS7L8sGc1iz5R0cFsPRcgGlqHliY8MgjfmPlaYJpTM8h
         ziimvxJRN9TsD7v6EWwG8JeP+5ilowbI0Tg8IgnWhPpyV1MJI+QfiCIUyxocpzLkcL3j
         MqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778059958; x=1778664758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f0FQAS1GD3dN9uwV8F5vKw0hNMRhc34lZFSrPLYTbjE=;
        b=Bf+s4lXMwo+6nOKP8Km1rD41e8XqqAz8BhbQYJJeqZDXvyMtQ0jJCmrJnedwaLQDbO
         9957eJhrVAMxPTyT1K1GimDAt14fbfFAMr3U4vxublLFnUOX8+T2/tYKL02GO2yAgGHb
         awYPlHBOFTSkLx1AmaZplK+Ihn6SzJIA+3hNq6ToWNtnS1ljcVReswR+hTyu5BfpQDhc
         RvBSntjukY3eQksS2SaUBZV9xo/k2PPTcFo8FLJT1CNWUnz/uYO9e6TYwft1W38EgFYr
         O51YKiwj5uHrsfSgUYDTXMFT0FeLDqd1TrvnbbjzAuHASDLEP0me/uvOjsNwp02zo4hB
         I5Yw==
X-Forwarded-Encrypted: i=1; AFNElJ/oVJSRn1sRY8LSQ0npcG+CU/30vwYwJAmZg9HjUdGfVFIrR2qL8b9OzQ91ITi0SRDJA9BtHA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQ7y52gGLQdDeHRZPkQlBAYpB+P/qWl8r2B1MLxSIr3aaWKrtT
	O9WyuEqNXZtUkNYS/SxQJQ5AJb90LNU31SmOxB15P5dyhttYy1ygmyrTnw9OmabtypV5ma2T34j
	pu0AH8Nz0yT/ob8L6FLg2RlQDKBhWRgc3iQJO1Zcj61IR0EDjyzWbthcMGg==
X-Gm-Gg: AeBDieuRQbzlQsX2gCRbpCI0w+nCOxjETF49B/4IzCd5QPgv4Qjek2VJp8UNygqRO8i
	2MUW0ysJwwMed/ZZIYhUe1tZOvcf+Fq2eOWWnY9akkL2fC0FutIhrBPY+pRnn+IduitiNp6edRw
	WiwtgHG8ynBIJoPiI2twLLFZVA19BhGAS+5YbUSykiKNdKcFma/m90HlWEu383WIZsEUGYVQYGR
	g0ondLGO+efP929zDSmULjZRTGQNXty0sfsTe7BHpeTJfN3RHrtEYiDsXRPB44PwgMbPuvUGBV2
	duTHJibXp2xKh9Z/yoATfIYUsMvJd55rtUlhWHKTf8iM10HnAD7MZrBSpMmw76xVEDdYnJA3nyA
	9Yc7hFVKIhiDQtyltzyEqKOqkjPOgAxyUigWi8CDLBA3P18NO+ME2BxRtlRTRFaW0
X-Received: by 2002:a17:90b:5546:b0:35f:be35:fedb with SMTP id 98e67ed59e1d1-365abadb3d0mr2543394a91.9.1778059958530;
        Wed, 06 May 2026 02:32:38 -0700 (PDT)
X-Received: by 2002:a17:90b:5546:b0:35f:be35:fedb with SMTP id 98e67ed59e1d1-365abadb3d0mr2543361a91.9.1778059958052;
        Wed, 06 May 2026 02:32:38 -0700 (PDT)
Received: from [10.206.105.200] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b0058b30sm1020810a91.0.2026.05.06.02.32.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 02:32:37 -0700 (PDT)
Message-ID: <455376f9-48c2-e663-3be3-fd310afb7f7f@oss.qualcomm.com>
Date: Wed, 6 May 2026 15:02:29 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 02/13] dt-bindings: media: qcom,venus: Remove clock,
 power-domain, and iommus from common schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, iommu@lists.linux.dev
References: <20260505-glymur-v4-0-17571dbd1caa@oss.qualcomm.com>
 <20260505-glymur-v4-2-17571dbd1caa@oss.qualcomm.com>
 <20260506-inquisitive-wondrous-lori-a9e639@quoll>
Content-Language: en-US
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <20260506-inquisitive-wondrous-lori-a9e639@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=XvnK/1F9 c=1 sm=1 tr=0 ts=69fb0ab7 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=TQHRF8L8_Bey4eUWYNUA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: f24VM5mUbxnieP5PcquqgUYq26gMP5xr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDA5MyBTYWx0ZWRfX6roWLH8QEsOd
 DtPbQ8a+jEahZVgMAFPKjOpm6LKfAKpc9X/0/jC60fDOCV2IipLTXiAUe6e3Jw++8ooJ9OWEysb
 iQAa1zU6If6Zi5410bZQIPEW5zrh/hdlrwlNTB0NQzDANs7Dyl9BS0tpNFCvLoOuJKJchpslEvp
 2OHSgRR9jyhlj/I4HXIyQQhh+pQc53CIDcpEK2LBW1qLdLpq/7mSYA//tOhsodXSGDopgGy5Vun
 p3WuE3cG0+WUygwR1k9f6zErBIDzSNPlj+ZmwGm5023a0fmECFNRUeFQ5TmoJyZe2nnl/LTIcWQ
 z8R+M7HdT5Rx5Tp4RtK9JZv8HHKZlKSuvTp5rzpgGGM1rvJZU3EhK9QPP3Q/C0Alg9rXHjltfG1
 23te3XBjH3qbVWDCWpEAFKjvgQ6JYRqonBTe83DNENVR4LwJg7eSXSdNJ7juj5aJexy8hnP88BE
 +uYZaOzNgan/kwT+gVA==
X-Proofpoint-GUID: f24VM5mUbxnieP5PcquqgUYq26gMP5xr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 clxscore=1015 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605060093


On 5/6/2026 12:11 PM, Krzysztof Kozlowski wrote:
> On Tue, May 05, 2026 at 12:29:23PM +0530, Vishnu Reddy wrote:
>> The common schema defines minItems and maxItems for clocks, power-domains,
>> and iommus. This suggests that the number of these resources can vary,
>> while in reality they are fixed constraints per platform.
> OK, that's interesting approach. I am fine with it, but then you need to
> remove these from "required:" list as well, because requiring properties
> which are not defined here is not the most readable.

Ack, I will remove them from "required:" in the next revision.

> I still do not understand though why you cannot just grow the properties
> here. The point of this schema is to define common set for range of
> devices, because all of these devices are supposed to be veri similar.

If a new platform schema uses this common schema but does not explicitly
re-declare clocks or power-domains, it will inherit minItems and maxItems
range from the common schema. This gives the false impression that the
resource count is flexible for that platform, when in reality it should
be a fixed constraints.

If a new platform requires more resources than the current maxItems (e.g.,
Glymur due to its dual vcodec core design), we need to keep bumping maxItems
in the common schema every time a new platform exceeds the previous limit.
That makes the common schema a moving target driven by platform specific.

Thanks,
Vishnu Reddy

> Best regards,
> Krzysztof
>
