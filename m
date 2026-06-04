Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B793CEBAA
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 06:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780555943; cv=none; b=R6sBJ2Py8+KWENkW9eYCb9PQUdMcp2yxnVJ82p34Bfa2b/DtTXtgDIr7nhWJDqzfw3uoTfmg0fR3fNkNQUAkjyvz3IzR9JNV6RRSaDajbMCFr+zim9Gzsw5RkzdKr/oE92WVLg5Dbykh8AhY0+qQ2wnEF0zKa6O5HO8tkayqyoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780555943; c=relaxed/simple;
	bh=GY9HWYcYN2vZxgT/IMPbqLYpuIufDKnKhahxeGgORFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m9QTFuXxAvtFXWRNxJVYj85PDyIQBAWWJLGawHvgwk9KuspU8m5oMROROcUADbjPiL2wsUiYbQo5hPI5Oy1417+6EQWa3Yl7T7yI6BTqqK4/+FmdA/APzdkKrVu6CWcbRxVh6FpU6GRrhlYEmlioykCwaL+CxFI0Qb0YktuG62A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UsvTztIu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZR7Fc+UN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UsvTztIu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZR7Fc+UN"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6546mrJZ1476762
	for <iommu@lists.linux.dev>; Thu, 4 Jun 2026 06:52:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QH3Q7a4QvIm0LvJnWjiUGy2awEMq59GNhr6w+819oZw=; b=UsvTztIukAjLYmBe
	JIt0gPAqHJgHNuaWhw07hXE6Yj0D0umA+iNeSyjT8pdpP99BdENsPRlLPNm9fjBM
	CCz8+7MuuUsT9z4V1D0wyXO00okNExyq1lJn3s7p7AoegTBharldE8s8kvu3dH1Z
	YreOzaJ3q4BPRyjwfjKdiPnRxxx5zbuuZ/kdey0z9vbJ5hrwLrSzFl3lGPCxfz2O
	CJ2+iw8jW4iaHMFMTGHMncjzecjEjTnY4de5A7EwFXn9qSsIHeuoO1/2e0XeTp16
	J3ilqimm6Tce1w0yMDxOVlWZtajLxhKAvZdc1SHWrLfk3jqt+7jJ7ipxAMtwDVob
	MlNeTw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejp6nudkg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 06:52:21 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51768072950so4851201cf.1
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 23:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780555940; x=1781160740; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QH3Q7a4QvIm0LvJnWjiUGy2awEMq59GNhr6w+819oZw=;
        b=ZR7Fc+UNpwLe2HwZhv8DRQyT7Ta1V9IMBECs7N618nZoW31B843h8B8bYS9uOABRe0
         7L+7dTjF3nM7hHJ7PC6ZZinGrcJZSzAhWVNF7hQDrC3aJykyEEstvs0BigTUhpoo0bEs
         3mW2iwPqHa1kr2yudxPBt8M1PGqNFb1kvw2+N7Nm5GDv7yeKXtpZxd1SLqKXf60wJx9N
         0daDX0z/dBo7rlKN1VGWiHjt8Pm72tqqPHXLjcKX5jc5LswifJmhY/tSxBzVm1ndzPxv
         PZOC0xsLoqOIyRCP+hikWsSe/snwBMnQB8X4Mf1ozncKllfcCH8osg8naDye/RctqOwA
         +hnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780555940; x=1781160740;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QH3Q7a4QvIm0LvJnWjiUGy2awEMq59GNhr6w+819oZw=;
        b=BlqWcF6AyJI50rAK9Xx2GtwmFZgTvHQEjukoJRKKE/wLKPzO1Xe/GOmspJKXmcORwX
         edd1ld5b6hMCNaK4F4mXbmG4Us8M3tp7NLRbj+YfZe+BfN7s0rzOhVS8yQ6RmRyydlKU
         FRaFg+ORtYgUCtFRAgTRo590QlkkJ5Gx6I8PFr73vtYgklHfze++/yiTyZoS7+ve+boM
         PsBhwgrx1dE15n+USgq6AXvU0RQiXQsJ8lF0oZJTzLKvzk+hqzQWDdCJwfWakLhnrmTC
         Y+UPHkPW7zN+nYdWmbnzAXEpejf92nWVDirgcBCbOMEVBQgd8b+88S9zOuG8IJ5BlFeV
         +JCA==
X-Forwarded-Encrypted: i=1; AFNElJ+2TXhw4duBsBm3a5/WnxroljCw9ertWapFrUuLDobM7/y6iB1MO2N7VLreFKLQBsWOJk79cg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxkgnzNjnoD1gXAgU/VnlDI9TU0sTzRg0qSJB6B99HW2RQ7fNe+
	KS5JFqFOeUWBIK1Cq7qmQgDTEHWNPURlBSmtNtEoi8sRXPBZrr8HFUshgMROVfPRHjEe1Jm6t0d
	1zvu2lWI2fkvZ4WusqIlyfvVuDDyhl8lGHwZqbM9xiDxH7Tz1PtMVP1TtMQ==
X-Gm-Gg: Acq92OHZETIzwUMlLgjR7aOZqi8D1RKwTvV7KGXkcFbZrEX82r3Yhb17VetrDWu0LXJ
	hVVF2rY/+bCHxLmFFcWB3S8t1Yz8D+x2WyR4r/ZE4bNPEwg+0gxrGWAdsEejcwZe39fa73Nahxj
	D2tx8Rgn5FEwkrHDp1UOODh3+8aXNHpRcz2E1QAhpGuXgA82OOKD1uldYPu4zO0tfpWQPBV9jrB
	gVUauf9tJDCFiNxsJEV0OeR4939Tq8AhVheEN+v+pTsjsfa6ZO1HwqgarC/7XcyGG6hlN5DgGyJ
	YFOGWlO2FpljjbGLCznKvyt/heRycTjv//5YbTF+g5cY/U+v/7Qc0FMiXz7DV3q5+zTbYHC0CNa
	SeuYmiMU89BxzLRFs1+PCIKKtuyC7p5bgkp5kOQP7d5BTVBOMXK+OSp7os7HHcEPV+nU=
X-Received: by 2002:a05:622a:d0a:b0:517:85d7:f5cc with SMTP id d75a77b69052e-51785d7f8acmr41866481cf.16.1780555940304;
        Wed, 03 Jun 2026 23:52:20 -0700 (PDT)
X-Received: by 2002:a05:622a:d0a:b0:517:85d7:f5cc with SMTP id d75a77b69052e-51785d7f8acmr41866271cf.16.1780555939874;
        Wed, 03 Jun 2026 23:52:19 -0700 (PDT)
Received: from [192.168.0.172] ([49.205.249.168])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e06dddsm262483066b.36.2026.06.03.23.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 23:52:18 -0700 (PDT)
Message-ID: <9d0224f0-efb7-4bc2-8f09-70a9b4d62810@oss.qualcomm.com>
Date: Thu, 4 Jun 2026 12:22:05 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/14] media: iris: Add support for glymur platform
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        stable@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
References: <20260515-glymur-v6-0-f6a99cb43a24@oss.qualcomm.com>
 <kunwuij4ntmh2hwxdrfwlpiza7kbcwtdlty2cai3xlxybkn2er@7wmo5irzum44>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <kunwuij4ntmh2hwxdrfwlpiza7kbcwtdlty2cai3xlxybkn2er@7wmo5irzum44>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 585RTK56pdvMiY05PiLO5tFNE_ScLUor
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA2NSBTYWx0ZWRfX9iPlQehtI/2r
 EclWOtGgGK+w3S38viI5SiEC5UboaJDTk2WfnA9bBD8TKk8hOGxEB0qd1eRx++FxhIGDcE4jxtg
 jWsh4HQ8+voUhA3z8FtKuS03BAYjLUh7uEn0w3QnFsOjJHz6VZk2ftKMZ7VQfegzGfB2AwA1DK5
 +k/6TUh/0gGWmWo5M6rgWKuluDK0Pm4+tTetmtU3dly3CTpTHONLvBrOde/RtCoJW1UgWZKTXFn
 YS2B8egPo1bkUczXTwaFuK3e5CbohHNnIc7WitzHOa0OXoLajd1r6TJztQSLXSGVeeMuTioLHNd
 ygDkhCKABjp8Cc/JvcFUPUbsixb0820UDPdJtAkblv6bgJrtQS+AeIQZ6iHMYvxnVjndqKtYDDI
 AorKCnAM+HU7cWYscLZfXXPGL3Th6jgjPKiQE1BoEW8vx6MoobP9vnL9S3vj79Z1WYZrrAivaHF
 ymXQ2wDw1f70d2HbAPQ==
X-Authority-Analysis: v=2.4 cv=DbcnbPtW c=1 sm=1 tr=0 ts=6a2120a5 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=QLLTW4K7kuvKcNWOCmVsWg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=MmbEFYbivRMSk88UmGwA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: 585RTK56pdvMiY05PiLO5tFNE_ScLUor
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040065

Hi Robin, Will,

On 5/28/2026 4:24 PM, Dmitry Baryshkov wrote:
> On Fri, May 15, 2026 at 04:51:15PM +0530, Vishnu Reddy wrote:
>> Glymur is a new generation video codec that supports dual hardware cores
>> along with additional power domains and clocks.
>>
>> This series adds platform specific support in the iris driver to handle
>> the extra cores, power domains, and clock requirements introduced by
>> glymur. Add support for firmware loading through context bank firmware
>> device.
>>
>> Dependencies and merge strategy:
>>
>> Patch[1-2]: IOMMU maintainer need to apply and provide an immutable tag
>> which can merged into media tree.
> 
> [...]
> 
>> Vikash Garodia (2):
>>        media: iris: Add iris vpu bus support
>>        iommu: Add iris-vpu-bus to iommu_buses
>>
> 
> Robin, Will, do we stand a chance of getting these two patches in 7.2?
> Or should we use some other approach?
> 

Could you please comment if the patches are good to go or any 
suggestions you have ?

Regards,
Vikash

