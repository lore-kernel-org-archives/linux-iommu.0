Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF85630D3EB
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782230990; cv=none; b=df/UjH8zbjH0kggx1vIGKdWpMNNxImQCET8hF9DMN4ggOAGNioV+IxfOIs1hl4xHDtfdZ0uqQCUE2BwTjxsYocjqr9zhQDluOjzgXsM3OmfAVcWm/xugO80Xd5Sf8piXzirDi+ON4fwZNDXK082SDO4h8cJHTv3Q/UVF/kGIMwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782230990; c=relaxed/simple;
	bh=if7r+uTVqsu1Rz1LUUNR5eK8lGZ6SOOcel9CPceNbVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aEQSH2fwDVybHT3l9spEKZNZzPOeBrVQv+pksHnZI0eBoWbhOqXWZnvPNoXsOyk+NJUXfmOpLZqQRts3Ye7EYJIgXCwswX/zk6lfGv841NzKGXUItKO2V29pZQESZW6i5S8S44xW56cPEqntSi4uidZM+sdagE3UYo633rhR/is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KjEJ4diJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ml8D45ZE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KjEJ4diJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ml8D45ZE"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NDFxSf272757
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 16:09:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fSJH8206N3zXxZb5NwNeSdYyuC4r9dG7EEW5EpoiYlI=; b=KjEJ4diJ/AaJ0SWQ
	yvUoPZwlLY2irWcHoyqoihkzjq7etgTOfCN3X1hS4VT3p1D4Czk/aXnLHHuWfHew
	MIKEs8RiFWGipWvQDCX0y2aNe2GWY+S1wOIgKCcEhZ3eEOjeBh7nLVWUaLDtxs3F
	uE3fu+aghEiLN6N1irlBgVzIfJBheTLeYBLmSIOHKY0Yz/9c0t9baPmlSFJ4Y9lB
	6/ZVNvaY2eHT93FAuHitpQqiOOzjZHUWCtJXZv38JFzHAI3frOoZPZWCsH3+xZX3
	amLiybRjVVD9RTUbuKsdTdKuH6c8hCmEsAvYzL7qp7dF1pdkdG6Hl53kGFwEdku+
	fKONAA==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eytvh0ss5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 16:09:48 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-966c8574759so58135241.1
        for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 09:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782230988; x=1782835788; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fSJH8206N3zXxZb5NwNeSdYyuC4r9dG7EEW5EpoiYlI=;
        b=Ml8D45ZEvJGeDbXsuIhdeSVs/wqlK3PpJkq0QIXkKrodiEXxtNlwXmIUqtaXQtoAgt
         dAf7reWlruaGK8f/jtB76FaR29oVGZw2DDThjO0cxJw/JQJQ27f1kkoid57Sw5UDIfXY
         pHBn1dG/MtXcL3ybH/Tu0sA51opEGY5xnZzQFoXOwqILcPQtUaBzT/a+kM+BALwA8vy0
         NSPyCOZnIxeHFXYMQhqJLv3+GwVx7p4iqjPLFHoHbgopapzI7Q59CWZFGDJ3EcvkgVZ7
         U4Lz6WV0UouGjbfotSXFXz/h/1DK8o+iKG1VxMtckmXDdQ0C2EGHf4ZZ7kl83u9WTKfd
         qhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782230988; x=1782835788;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fSJH8206N3zXxZb5NwNeSdYyuC4r9dG7EEW5EpoiYlI=;
        b=ZWaVGpPN7xxQH5ClZPtKjWCD4ystDL8WQlIgbS0CfDX8aO4pxUxr55Jdca88NFyP/K
         i+suJxW0lkn6WNELs8NFFCUlONaYNm9ppxRLbhDp8hH77iNCW2JdQKfiv+Lq0+U/doMh
         N6V0bElBwyQyinSJJGsc7LbQ9oRpuyLQfCF/yCjAz7upWWkdYp7OYRVYhJZSNdWw192u
         lm8PL1ks/j6QG5KdPAGpi8p5sKas/8u049bUDyw5GtN5VMP6FDn63dAK5PPO4RIbYlad
         EdBHtIFHUWfhlHWVSTuUhz7Ago04zKxCCpV7ybSczY/pQHbLaeMX/SQq/z/c78qbIrC2
         71fA==
X-Forwarded-Encrypted: i=1; AFNElJ/Px4jBj3jABDAPmtsHg4tPX0rbv8zb/JU1PXXKNC5Hc7lg623K2ACHf35+xr+7Nm/BhMYGXQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzk5Dow//4xko63hLFNCRsg+bILk0fAPtxuW0Qtzl0ElcBCbDxr
	nrHfG+9rCWfKFkhV8wDoYA5KYYKBb/mEcDnt8Ku7vfIQC5T2wIqRZKV+R4n/6sHGG1mpSWUyLEx
	GnZiX8TBHQ8f0dO3l1q6DgadidcfcVKCaT0TRNsGA0+D8eznsG0zP0TPIjg==
X-Gm-Gg: AfdE7ck8dgdBsQgipxzZGbkJqdeaQJ7dUmSqCukqp8oJ6Ff/GgmyHgC8jDO6BtsETB0
	tC39VIvqJoUgaF9K+Cfnrf5CGQFeO9jwuUXJEH/cHHnOeaONWyGCU82NM765ugnSYe3TIQr0r58
	gDjD84tLLeP4Vzoxp2AZt6lh4OZbXWoEoge3x1rQA5eHAi6dJ2sGE1HSy4vCzpi+UL/g/KckBD/
	snW4tdRUBDKr8gkHuBCL6HPp5gZZoEJyey6Hz4fqfIrSMqN7qeo8Rl7TxzL1xEnsQy9DQ9LVmVl
	9RTqy1NskdC4Nhyh1/0w/KRYohTX+5S0cLs+pcTjfetzdmd4qrEqJEBGy5WVbg+uaA5a1SeDRaT
	1UABEFOFxBRolfcdc0rfDVKsW/Kz1a0Gjrvk=
X-Received: by 2002:a05:6102:1620:b0:674:84bf:8e0a with SMTP id ada2fe7eead31-72b16d7a278mr3803415137.7.1782230987808;
        Tue, 23 Jun 2026 09:09:47 -0700 (PDT)
X-Received: by 2002:a05:6102:1620:b0:674:84bf:8e0a with SMTP id ada2fe7eead31-72b16d7a278mr3803389137.7.1782230987312;
        Tue, 23 Jun 2026 09:09:47 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c5e99b968sm536990866b.24.2026.06.23.09.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 09:09:46 -0700 (PDT)
Message-ID: <aa1471ac-bd1d-4e1f-b61c-3db86d2e31aa@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 18:09:43 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] iommu/qcom: Fix pgtbl_ops leak in
 qcom_iommu_init_domain() error path
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260623122034.1166295-1-mukesh.ojha@oss.qualcomm.com>
 <20260623122034.1166295-5-mukesh.ojha@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260623122034.1166295-5-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEzMiBTYWx0ZWRfXzSLZa7lfOCOs
 Wsptcbjt/lfO0mDTzKPxFndLINAUR8T1Kd+ssru8ESWHQO+hcpykn0kFkpyqkuEFm4ammjFbbIM
 afWOq+UcpqmILA0rjXsHbMGcvnGqES9AbgoOa5yAPUA+9SmagbvXrFEZuHZCRuiKKY4e6cIXSmd
 ttflH1qY2GL/t2bOaZ7DjTb5CpU2y7fffr2sWux27zj/tUATP2gEAWPF5RfBII5WtWJGNMEl/vs
 d0pbzuHcOeU4sB4DkmrNZ4eC5ZOnTSk4unvU12Moqj4BeFG6RCs4DaZ9rfhQdmHEgx4zJ+qDMrL
 B0QFJciJJrevQbg5W/fN4ttLwE8iGzji//kjU0Sl5IZX0REae7UNjiblbHw+qCqK2cnxJAsKoa2
 jTEz2j9+KGT3G+8ocP4JSWdRI/m95noLlSp/T4d1t8D6h4/hyJccsWgi/lqeVgxvsBWJVzEiiYx
 F93/dGRAH+dA+eQumhA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEzMiBTYWx0ZWRfX0FCvSEj1ho2p
 C1OlPNY8gkXpWbwgx8yZFcbTcV3eIso6OeCkcZG2oqUxjyo7iDeim7CPCAJ9EDwE/8E8tmwzWzJ
 D3FGfeIpKRl5xRHBOz7bSa7wmIOsuuk=
X-Proofpoint-GUID: tGrAwr8u6YsOtKMm_nS0oT-NRATLvUp1
X-Authority-Analysis: v=2.4 cv=AJDhMgPs c=1 sm=1 tr=0 ts=6a3aafcc cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=fzWtvpM4OtHSxDPwpw8A:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-ORIG-GUID: tGrAwr8u6YsOtKMm_nS0oT-NRATLvUp1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230132

On 6/23/26 2:20 PM, Mukesh Ojha wrote:
> alloc_io_pgtable_ops() can succeed and then qcom_scm_restore_sec_cfg()
> can fail for one of the context banks. The goto out_clear_iommu path
> only cleared qcom_domain->iommu; the locally allocated pgtbl_ops was
> never freed, leaking it permanently since qcom_domain->pgtbl_ops is only
> assigned on the success path.
> 
> free_io_pgtable_ops() safely handles a NULL argument (covers the case
> where alloc_io_pgtable_ops() itself failed), so add it unconditionally in
> the out_clear_iommu handler.
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> index 4e714a8e1fac..b6ce85f7f923 100644
> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> @@ -314,6 +314,7 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
>  	return 0;
>  
>  out_clear_iommu:
> +	free_io_pgtable_ops(pgtbl_ops);


This label also jumped to when alloc_io_pgtable_ops() succeeds,
but there's a nullcheck inside, so i guess it's fine

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
