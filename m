Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FB341B8CC
	for <iommu@lists.linux.dev>; Mon, 12 Oct 2026 11:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791804486; cv=none; b=Nya7IBCIbvlgFX27yp64+pbdSwGieQDm+zqF+ZibIDN+wRETTlJBiotF61XnIFgLf23//V32c8J4ds0h5To/Fq2RfH23TO32OuUAbC+QQe7kX4G9dE76XIi2XzsZmiidOnZ9dtV2meCIfSNkUHKUkDCu8n2ZHfnXbK5u3PNYd6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791804486; c=relaxed/simple;
	bh=qjLm2iBplbOItMK/nBGuK56LU3E2ytdvfFyzPtdXtAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V0F1Mp7GNp2qQ0HpuhFazZnAKwQhGsxqa1EPDr7D9RhrKWdUz5DsXNNLlFZYDhCO5ciz9y0dGEHlxzQzAE6XOsznrZ4jOLZKdAxx9tLK6V6VTvz38tF3r3+i4sj/7jOdHaaRedQ/pCeGolInIuS6z/4YLiyW+ATCJUDelLLgbHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gImQNbwd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q/faPlLH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gImQNbwd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q/faPlLH"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8KlY12181467
	for <iommu@lists.linux.dev>; Mon, 12 Oct 2026 11:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h2vh5XXOQ95SCxIAFLYDt8jIXow1InAg31g5yBuaCXc=; b=gImQNbwdgJWauHAY
	mD8xFrawwRgpJu+i5pfErJVfx1bc1+jj9MyTZQz31bEl7BScch7eGz+5NXkmeC0w
	K0Nzn1tXgvaVBKEF1L678T3vvNr1hT4/Wsx4apRrwWwam5euUV2lEaHGHqqY+wF6
	iyzNely90CuD/iVOaErHNoKc7+ibJZHxLi2FfnyrjqL8ylFzmZkkPDomzeZStmjd
	m6hLmXBgxmxklByXqNCQJkUGDrB+O4+k29Am8ycEHZfJw1wlZcXqLf3r8HOCMgY0
	wMU6orZA36xouMkZNPBXW1PnUPROFSl5hQWq6hdlJqg7J+U9tpPbenrev+FHVsYc
	TKB9GA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8sd1snkx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 12 Oct 2026 11:28:03 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3515266f6eeso3450664eec.0
        for <iommu@lists.linux.dev>; Mon, 12 Oct 2026 04:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791804482; x=1792409282; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h2vh5XXOQ95SCxIAFLYDt8jIXow1InAg31g5yBuaCXc=;
        b=Q/faPlLHyax6CQsu+3wfPxFSxpXdBJKpjU03XbCNd/9KwQNXHLEHZEk2TSgLsq7+HK
         XvaF0QSNx0JLLwwo1DvLNHjI0TNDT460lS0uzcIjYiAvmfbOikc6mqr3p3XlaEg5NwJm
         ERVaDzUMEfjCTxiE0EyRq7cllD9NLcznNcg3IRO9etc1uGKw9GwuXrTGj5RZPjmwkBZ2
         TCoKxfJV6Z5SJsaRSOJ9/jjIyUY8VdJcTRm87kD0pdz06HBlkPe7hVdFHOFr5GN0NtDI
         Qam0bkMNWR3Uo7Lamy1epjpX8mhWCTZgyuKkEMDiOSm/gzRNJf8t8Ys/MVEcgBWHPLXF
         tUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791804482; x=1792409282;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h2vh5XXOQ95SCxIAFLYDt8jIXow1InAg31g5yBuaCXc=;
        b=yi8ANDwNbrDomCo/eLBddBUbCfB006lCdwzXOCS3WRnIqUeGmZYDOETX8ciumGeAWG
         /N1ILsxK50/DAYmELA1LOBkEf1GEC7VyGBvCs4YbEXxnwpUUxLVe9ibI4rEGYiV2bu1l
         bLpwz8TL7hPL8J272uCdMWzrxS8aLamUHlX33aiHJ+bEaqKqkrwqaHuTZl1IOl87dv5t
         UjsgKwvyAXHbrwa4t4kYTpKaCrelTQClc1wVV9dA7MOmOw+4x24Blwy+uwiAxbedLwNi
         I4WSCo7Wwmdd2m7GJrV5fMAjwUC+Xp7xmGmVUSQPQlbu9o1ULYaKteB7I9jTttoefMvF
         VVYQ==
X-Forwarded-Encrypted: i=1; AKwUvByG2dvvC18E00QEHqV1CRM/HEMwtz4vypaHjCvWpPQwiMiYfDuF7veE7DSBVRMtTCvM4hOPSQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJdi0I95HvT1x1XG8kc9x7avziCZGgN2u3CFXQU7YxGfAaxbHdy
	xu4z4+LvvwNDwuoG51jVJNJnwQVWMGQf70S5T0PopKlDg7AvgYmtMKKUa+m3HRDDVSzsatNyDEc
	7f4p6JA+k75P98Qm2C6q4CDzVXvJc6Dx6bP3WzbqIMuY5YcXjOW8PiqY7kg==
X-Gm-Gg: AYBFou36eJIh86vD2z8Tlr3c+pKzi4XucnWB+R7YoaIh2fb06Xh0Q/3vyA7VBayS3+D
	d7xgMXDp45ZrJwRfX6T7zmN1EcrHo+GkxtOq2vbVIXcu1lt3kHYmmJPi+g80CezOXZ5BaKAkr/l
	ysiCvT5+NDN2sZdrp5v6V8UfI8zRfvcsStNkjq9lnBFN3Qnu49Ps67SFFB+YgqPfHxBRFg1szDe
	ev7u4PgWKZV23lj0t7F3k9sCADwNLLbBe2Q1kf/nUJcrBpYVhgExBlrfrYWytEm/WeETkPykTc3
	MmhKskPaeG33ehCNHZoxoYSdxCsEzEPH/CEyVEzY9RvKrFkV1l4T8AU5y1YZO/OaxcMlRuV9PSb
	KoxpQkg7ess+rZXkrJswCcOBO+lgxxDGNgA==
X-Received: by 2002:a05:7300:4349:b0:351:62fe:62 with SMTP id 5a478bee46e88-3537e0b81famr20147812eec.19.1791804482399;
        Mon, 12 Oct 2026 04:28:02 -0700 (PDT)
X-Received: by 2002:a05:7300:4349:b0:351:62fe:62 with SMTP id 5a478bee46e88-3537e0b81famr20147743eec.19.1791804481793;
        Mon, 12 Oct 2026 04:28:01 -0700 (PDT)
Received: from [10.204.101.119] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3593b8b2ec7sm18128821eec.4.2026.10.12.04.27.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 04:28:00 -0700 (PDT)
Message-ID: <82993933-090a-4306-9d3c-40ef7dfdf367@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 16:57:51 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/13] iommu: of_iommu: Add support for "iommu-ranges"
 on a device node
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux.dev,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
References: <20260926-vpu_iommu_iova_handling-v5-0-0322ca5dc10c@oss.qualcomm.com>
 <20260926-vpu_iommu_iova_handling-v5-4-0322ca5dc10c@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20260926-vpu_iommu_iova_handling-v5-4-0322ca5dc10c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: dQ3sRnHqcGRZKypqdGmc35ehdiyRNrSG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0NSBTYWx0ZWRfX22H2x045wTQI
 4UNTTLm4+hlw1pKNwKB2BeknxCEY0d8jHwQGl4oTm7uwq1e2aOVuldtLI/oj/8Q7n0upBXmDWuV
 0Ej0WMrK9uZ92EdHN+1q+qhNxFXCSrA=
X-Authority-Analysis: v=2.4 cv=QtHLTlyd c=1 sm=1 tr=0 ts=6accc443 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=MjlnR1W742UOhp88nnQA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: dQ3sRnHqcGRZKypqdGmc35ehdiyRNrSG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0NSBTYWx0ZWRfX/WrGMyoWM7ha
 ZIKTMHzAIaCfZF7mnEYxMohkMwjKyKrnvsd45+zCu7qbLw7dsKhVrlvbLFrWxAbJzj22YCOggms
 NbTNsPdyK83rNkpbjtuNVeE4eFi8HvW/rx/voEtpyoWmQoVTkYK+MQ8oUvSW+kRB99KMNCcPkkL
 LUckSABslVgfvXkAXuwAireAp9NRLCjTvHkZ7bnOwtppob+9r6VkFqiEsbmRwXiYOKxYaaSaa52
 LFNicBztzOq0RUpjw5RTmk2jwdoLuk0ILnPeSmDTaMqmjg9vJFLMnoaaeRANJcHknCO2nXItZ+I
 YS+9HGnfpxUAhaecfllS2rERXRKtp/oU+8tpwx/mrrt+HsEbsqkBv1Qp1CsuTuvIQJlpaFuF7xJ
 l18KXtaKTeuGLIKNC2VFHj/Ve8l4B4pMizD5nVF9lJmyaiVTXsb4UHELB/ptoqt7JV+wccP/wBz
 Hz+snFrgTLkGhawfywA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120045

Hello Joerg , Will, Murphy,

On 9/26/2026 12:04 PM, Vikash Garodia wrote:
> Reserving an IOVA address using "iommu-addresses" requires it to be
> placed in the reserved-memory node. But when "iommu-addresses" is the
> only property being described and there is no backing "reg" (i.e. no
> actual reserved system memory), it does not really belong under
> /reserved-memory. A device IOVA range is specific to its own address
> space, and does not describe the system physical memory to make it
> qualify under reserved-memory. Given this, place "iommu-addresses"
> inside reserved-memory only when it is paired with a "reg", otherwise,
> define it within the device own node. It was discussed here:
> https://lore.kernel.org/all/662f7093-fb0a-4564-9ca0-98e03e68ba9a@kernel.org
> 
> Existing "iommu-addresses" property expects a phandle, which does
> not make sense when the property is defined within the device node.
> Introduce a new property, "iommu-ranges", to specify the device
> specific IOVA ranges when there is no backing "reg".
> 
> Suggested-by: Rob Herring<robh@kernel.org>
> Co-developed-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia<vikash.garodia@oss.qualcomm.com>
> ---
>   drivers/iommu/of_iommu.c | 128 ++++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 121 insertions(+), 7 deletions(-)

Do you see this patch getting into 7.4 ? Or, you have any other comments 
on this patch ?

If you are ok with this patch, maybe it would be a good idea to have the 
series applied by media maintainer.

Regards,
Vikash

