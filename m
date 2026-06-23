Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30261220698
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782230434; cv=none; b=Pvd7ah0nO4shp0wIoSFp0XYi6kN4CW35SWzfku/f3+JsJgkgmA4UhCTwxlkAV7L/e+1gcImaD9yYd3j4j8Z6SZnlBLHzi4nmd5rikcuDo4EuadFS1gwGebmxy8UdvgxUMYsBVEn1NczXaVE4u38cJl6lgNIS8KyLZeCB1N9fD9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782230434; c=relaxed/simple;
	bh=z2Vxd/2tM2532gtQ1Kzukk34nRBbD4l9UDtgLjNDRXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XWcYiUBpVLIm+q90tEgIk/Yx0A+J/DEywtMaDyCux05JDMW1rR67m23QcbFTw5UNQRt8Y2KN5wUyeLmv3W8ZxObyteQTUpycjAb0jeMI1+ogujzL0xhdGblfm/H3IenSMflAHDNK5ddDjomLV+qTVkqX40FH+cn4rpOjm8QWRxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EIyIx9f0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eAlvI1eN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EIyIx9f0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eAlvI1eN"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBXctY1155240
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 16:00:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	984yqp6xp/UoBF7AK86FvPHitvhzVPhDbtSUmWGIqgU=; b=EIyIx9f0zBiXE/ft
	GvJtD5yz45oJ3KZ5VmYdMAfQqMW13fA3Pyyd1APY3fKsobzmnG7zh8k+1Nio20Hg
	IR0xNNCAvytNmFFeSqihmoPDkDPbaF/NrM0g9GbMbQtkuyiHplpyXecbo+fp/7no
	N5F1LLC20LsKLGkM/9rc1R6WGu4fZN4bcuqvL668lG9QA96cmxmi+wEMb+QGuhp8
	RtllTQ3H/N3A+G2KF7xYPnCZnVMZsxwOha3SpguietOBtTU66JxdRMti1xVQdfKf
	AHRHq6KK90t5MJUa43i0CcQi8zlgXmZBuGbxrox8ffDCE9ajtL2u+AtL+YyBd9+b
	Ru7dFA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyr28seqa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 16:00:31 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-920f826bcb4so65751885a.3
        for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 09:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782230430; x=1782835230; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=984yqp6xp/UoBF7AK86FvPHitvhzVPhDbtSUmWGIqgU=;
        b=eAlvI1eN+UdAaA6+DMT0YNwJEZ135MIUlxH5QUU1tw+Xx+GzEFdG3/Y+WibUfWO8FM
         UfdbOAc3aIudu1l94/5+WY784hNlvtLwT/LObSQlmGY1ZkysQSmUvnyOAN37woqTBpmj
         N86vbysYU/apjO4tVdM9j0GE9LqdysM8AYvvmXqvH96OmtG6V/85NTEKLVS7R99wgPl/
         yZa6Ggmv+cuuJEd+dNwtmbjeiHmfFOsKULKQcwxN+NZBHdE2JVNHAfgR47AJVLcYI/qd
         6eDG/KxZTT+q7dYg8k9j1uPVdwrVwKwU+NapwugtiKcMpBpEuHtGPNWtT2dp6TsSwrd7
         Q5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782230430; x=1782835230;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=984yqp6xp/UoBF7AK86FvPHitvhzVPhDbtSUmWGIqgU=;
        b=KGDFj7tGNQluWsE3tS5GwvsqMDeGqXprkNtprCkFokN2sFsaBmUxWstJULWP4i4kYS
         q2V73REShnH7+G2lz8Yis1uj6B7v7elGProklWkUP8fkg0MiWs/J/16FEl+TpQLWdEW5
         Tbo0I3ZYlp44NMs+5B7ibjaJ7kI6He4c1SzQVVL7eRW5VM9U65TQZbB3BrPQa6qdSbVe
         7U3x+iDwhRs5jtKK3gjHRbONDFPmWpue3UiiJ4Zd42tVoTkOXCf5eUJALVXYY7k1cJIM
         dt/2OQYlwOExV23yDmYasfxUODxWMyDQ3ItOAf4yUW6VqT+bfHmGKAJ6eBhVSTAdPp+6
         MR2w==
X-Forwarded-Encrypted: i=1; AFNElJ9IJXO3CxohS5BS/bHbOgu2HOlQd970qlrnFDFSWiZXhV438CJa5PcnjYuwpv5liT1e9h7FGw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwC2UTdoMN8/xqkzzj+Id+ukrEFfcpTbDeU74x9oxROMtiGRsGZ
	7L62FwCjDIzN62U9jAsCbd8ic28Lggi47/2JagRkfF8YrDMkGPbJgMje5VayvBw6GEpGCuTMpnj
	knaWPYlf7Om7SOxvyTAkt2x50nWf7ZHeQgomFtmPk6nBwYwiIASAhEi8bvw==
X-Gm-Gg: AfdE7cmXhzn1d3x/zZReFYKvm5doiL6FF05nHdSgEh0i2i8jTPE71O7S3xcRqTTn6JB
	P3r3G3NaCBR1cGOGLO5CSNzcqeP5QQGLIn52YjS/lrr44rSXPRmKBcvAw8K5b6FvsVphXTgI/YN
	JIiZepK/OOlTZC4D1V48yICcIPapeh0avhdMii1RWMgFtb8VeersPKku+LnaCCl+lwKMJnSVsEX
	7wrcRBJUTxbduinSY2e4jMbFurbTBjgUc5mRMJEXb+2aLfwoeof28EIBx3PVk0dboR1gxrJZJBl
	lyMClTsz+AlRfQroGAmzVRjONzBaALLptj4bH2Od3o8j274GkOrAkvZ+8HAiBt1dHbkq4as3aL7
	ipHZq2kMuL1QJ3oIzIaUZDP68jArki4KjXjs=
X-Received: by 2002:a05:622a:1a85:b0:517:6a56:accf with SMTP id d75a77b69052e-51a4f417e62mr59007271cf.1.1782230429988;
        Tue, 23 Jun 2026 09:00:29 -0700 (PDT)
X-Received: by 2002:a05:622a:1a85:b0:517:6a56:accf with SMTP id d75a77b69052e-51a4f417e62mr59002911cf.1.1782230426876;
        Tue, 23 Jun 2026 09:00:26 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c60aca46csm540916766b.36.2026.06.23.09.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 09:00:26 -0700 (PDT)
Message-ID: <d334e36b-5857-4d2f-b493-08f48398c02c@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 18:00:23 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] iommu/qcom: Fix inverted fault report check in
 qcom_iommu_fault()
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260623122034.1166295-1-mukesh.ojha@oss.qualcomm.com>
 <20260623122034.1166295-2-mukesh.ojha@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260623122034.1166295-2-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEzMSBTYWx0ZWRfXwbs15Pd++fEw
 S+EUObvkh99i+7jvq/nwKTahC3uxyevmsrneq3NN58FII2BPM65Urnyul1xP8TjSXLudUPyyaxU
 FkxT9VpzXchqQcnXZLxTj2LvC48MNIY=
X-Authority-Analysis: v=2.4 cv=b4KCJNGx c=1 sm=1 tr=0 ts=6a3aad9f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=yRyykpyyrqY15ofKUHUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 31FQUgTg2U4A0G8oAQ3BYlsxM7iCPg40
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEzMSBTYWx0ZWRfX/uZEVYdRytUG
 24xzU6pEYvb284B4h7+Axc4lCLEb5JKSmmXKIX3u7k7Tu9KRcCpx0dELewKTtyDg3fEQwD7AkaE
 RpbwW9YqxC0BKsRVjZmR/csxtR+3VZapp+lBAQ65j+lMsAD0pp/oPzssPhCvdosncZh8//63dIJ
 HKhoPlwQEKWOKSy7e2o2LNoEFWwjkMiPCDE63DXFm2s7PQqKOXcswVnPBfmrruj+pzvZNlB9n88
 O38XHaEaqs+5ndodv0+aF08abQX3b6DXNOMwxaZnFBsP6B8XMziUz2iT6iiH1qVe1Vu6BM37SiT
 VGNiigxKnNaSFgLJq2BVXAmUUIHRKe580nSo2vS8dk8lK7Pw9qbFrEfrY+vVeB7LaK3vUBKW2e1
 z6WxOa4nUoRjSlbBkpss4q9kWxCLrRxosRYynH8oXj1RdYipprRbkrEFbgi6o9/P3hSQ9gZfpbI
 KVP8azMqfrmZKJ1gfXw==
X-Proofpoint-ORIG-GUID: 31FQUgTg2U4A0G8oAQ3BYlsxM7iCPg40
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230131

On 6/23/26 2:20 PM, Mukesh Ojha wrote:
> report_iommu_fault() returns 0 when a fault handler successfully handles
> the fault, and -ENOSYS when no handler is installed. The condition
> '!report_iommu_fault()' evaluates to true (printing "Unhandled context
> fault") precisely when the fault *was* handled, and stays silent when no
> handler is present — the opposite of what is intended.
> 
> Remove the '!' so the driver logs unhandled faults correctly.
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> index 32efef69e72d..09f2ee6be988 100644
> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> @@ -200,7 +200,7 @@ static irqreturn_t qcom_iommu_fault(int irq, void *dev)
>  	fsynr = iommu_readl(ctx, ARM_SMMU_CB_FSYNR0);
>  	iova = iommu_readq(ctx, ARM_SMMU_CB_FAR);
>  
> -	if (!report_iommu_fault(ctx->domain, ctx->dev, iova, 0)) {
> +	if (report_iommu_fault(ctx->domain, ctx->dev, iova, 0)) {

Absolutely hilarious

Fixes: 049541e178d5 ("iommu: qcom: wire up fault handler")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

>  		dev_err_ratelimited(ctx->dev,
>  				    "Unhandled context fault: fsr=0x%x, "
>  				    "iova=0x%016llx, fsynr=0x%x, cb=%d\n",
