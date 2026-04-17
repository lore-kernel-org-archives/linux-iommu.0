Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F8C31F981
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776439636; cv=none; b=krMhrP0zaNiPRu2XdqXeS/mbRgMpAy1rAWwP/MtU+Ny/RBX5wbn3aIknWJ5uHCAAyK4YLM4G+rHPRcsIo7vVyONRuxW9bf6nCUIaYF7GxONcow8GajRe3dSyZUZaxzfb20nmCVgmynxWPl8JQyfikwRFREMNuctKy7DTLEyCUZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776439636; c=relaxed/simple;
	bh=8xUoq/FcQMwK95XsLEn5fWvjT6G37wtVq/UJvhQw2aE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iPIhWUNdQAxpEE8a8YxKo4NwTMeD9oEwuB5jq3QAmqijgnJnBNUBJAmSNL8O3NL81JGdlq+x38DqttmGlZy4pfAs8FUalieAbGHrz2BfXprGHd6C+mnkYfLr4KL/00vLASoA3bNHSNw9sCp8u//i9w+ifVPDiKsZdqmMLAi3x10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oSv0OfTz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Yj6UXUXF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oSv0OfTz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Yj6UXUXF"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63H9wvg01323861
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 15:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nGgbgd9dtTM4zTNUJr6OpLpNRnt6f6nmr9bUgf0LEuw=; b=oSv0OfTzab2KnkrI
	CDH9iorgZionOmjok19ij0EUUe7WR70gJNlEHE0ZLpHgRmGxNloBb9KaP6m7Wv7p
	mSdCKTMl5Ugo7VvtIVYBokiuvr6UUffjSKLBdLITsWZ+nzVjBRcaM0pOcPVJf9Qn
	3cu0nPFvjYeOc2FKWmJNL9dCqdPKneZSnqEPY3MsrR7IwnylKJwal8DpB47R+scH
	m8Ou5QrnUM/bsdOJonfyhcAsjN81hp7D7a5DTd/ZCSnzhK/4Ff//aeos5pwRPaZI
	0l6hsj8O3x/4aw7Il+ogAdESllfc5ljMWq2dIsyFPPukw5T493xVlSDro36zK+iZ
	GjbD8A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkdgy2ae3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 15:27:14 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35e59791605so850137a91.1
        for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 08:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776439633; x=1777044433; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nGgbgd9dtTM4zTNUJr6OpLpNRnt6f6nmr9bUgf0LEuw=;
        b=Yj6UXUXFOS31KxAlg4/v5zvuCQdQRbyxW26kYIqccSUJGnw/VpPLBKgIMXsJw2ygev
         LTLPCwWwZhS9t6RoE4QUcApCKBhtr2j7ljCNQJh+7nkmyMnF8zmDKTEvNRGutzFkiBgM
         +uQuxMWlN76APOOTWhN6T72WqcWfviZfwEwCvYPeGb0yiTftPVlNB6r4j25M4p9gwQru
         C64aEJq9zo7Bc+Wa+xAMraUBEDJk+cxWZmX9IPMaut/fDVsmnzYHK26RlCFUhN58KTwL
         xrMrxpGsUO5AMvT8dIp4UBoACjqPgaz1Uuqi3d7RFppPZ4a07QlcmvHCRg+YRI65koFM
         8RMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776439633; x=1777044433;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nGgbgd9dtTM4zTNUJr6OpLpNRnt6f6nmr9bUgf0LEuw=;
        b=mBFCaFF1YHZgLcUOYp7JtUhUFnSbhefLxKrUITCP0y2F6Ba5kAB3KzBuwVFy/O6C/N
         zutKfpqq1SvEWoYe/MQrJ53ZEau8PnK98v0mRH15TbYK6yamC6iIMfvdYYVQjh7afdSe
         Ae/3aylbsJzEeJo2uzt/+RAx2Haar8GAIHQgVZ83VgzA2Nd5gBTgHlSahirnjxhV9F3O
         Cfni0c3rDGAyn/GF2cGAqCcjy9Zx9lK3xwHaqz/fcfbXU+zsZ3jA5ICpP1cfO8rDns+7
         kbUCkOPR6DrjMLI6868gxV/oVmpXt86e0cREMHHVIRPtCWFErrvpPCZiwwzTqhvt94fg
         2CUA==
X-Forwarded-Encrypted: i=1; AFNElJ/oGIT7TuXdtl/ucuxmL2xtP5wIip86M/DbQRfq5EaFVLJ6Ujxlt4aXazYytDBn19/KYAjoig==@lists.linux.dev
X-Gm-Message-State: AOJu0YzihIgYr/C8EMvoFtMe+Q01uXrxTACF7o5Zl9FsU25Ez1NNo1xl
	y+Cp/6hu5MxFY2ZTpagObjzvQIfQiHnydefYThQoICnCGjckd9Y2qTdv0RPViJkJUfzaH8jgxCo
	XtDExoy99X83HS75GaGGbYUsyHskGA2scdUiztE+qa+pQ/9fU6KEak6gCcA==
X-Gm-Gg: AeBDiesj4IXO1/9BUnQaEhWUYkwTiA7KwsXSIjhFbJ7DzhtoMn8mbVhP+bFQPSu1jtB
	zF4Qf70aex7S7dvcwFNb7fvH+7hJB2Akcuc+p2dEN8ec6nN8kndbuoV6UGDuZ0uV2TVo4k0817g
	V/iVMLEwuWAX8SRElI6L21HN1u3yL8HY+YbTLL8+MFHknPqWz6/DfAGcGCVhwx6EiOXowlWZ4vP
	w5CslVA1SY0PsB5ku7mZi15ZW2FqTHlypdjfzclQvUSXsCHUa1HhBVBAl/FjhkG+EZa9YuHNHSG
	yw8rO20o4qdf4UPyLPrFy4cXk0YsMbHaWouta4GUJMKaoXzEeq3PJ3cFpRAXYdKli+2rL6CHOIO
	ohAhubsrtgeCEcUjVcqPdV2eqS9oHLaLUWGtewFdtFzWRXybTkxDhogaHMPJ/cs99
X-Received: by 2002:a17:90a:d0f:b0:361:45df:114 with SMTP id 98e67ed59e1d1-36145df0462mr906269a91.19.1776439633292;
        Fri, 17 Apr 2026 08:27:13 -0700 (PDT)
X-Received: by 2002:a17:90a:d0f:b0:361:45df:114 with SMTP id 98e67ed59e1d1-36145df0462mr906229a91.19.1776439632683;
        Fri, 17 Apr 2026 08:27:12 -0700 (PDT)
Received: from [10.206.105.200] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36140fc575bsm2478649a91.4.2026.04.17.08.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 08:27:12 -0700 (PDT)
Message-ID: <987f1ac3-1725-11d6-d257-9bc7192b2fb4@oss.qualcomm.com>
Date: Fri, 17 Apr 2026 20:57:03 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH 05/11] media: iris: Enable Secure PAS support with IOMMU
 managed by Linux
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
References: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
 <20260414-glymur-v1-5-7d3d1cf57b16@oss.qualcomm.com>
 <809e2ad6-258c-49ac-9f3b-4ced32807203@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <809e2ad6-258c-49ac-9f3b-4ced32807203@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: QBd8ed6Y1cnVwYl3XR58nY9A3eOoizjx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE1NSBTYWx0ZWRfXwWFNQV4GhiS0
 WQ1h2Mwr+VshccmlB9t7vKUwemgzDCpPMfQg0xHgWR1gYjzAaWbArcK3ek8qrzE5GHl3F3r3HGH
 pF5dHss5V3XaNomyY/rHqVUM1/FJsOFXBZfaydvVwDF6zG48iW/inRp3QyG0j8zvVcPFy/fVYIm
 crFcUZm/BkSLwlmt9CbU5PhhA+kXoxgzMvSSosjphXsahLHZ7533bwUVDUCX/yHbjV09RHv4WEe
 5GvzOCGNYrvpTx44S+cEd7aTnoNXOqWr7TcUT9MQXUl+lg7Lrm9t0Hr6GpjIFLB355QY7OLLJa0
 T82FIm4aWCZ9a4XbEx6TMDIQ5dCZkjfPB+n7TPqR351Gukmv3rVPzgwg8AXHN+IGOAqmz17k0Xg
 btpXAwyA77WYPJpK09TFQZu0RY6eMLWwTyMSDthmJRgEoods02nAxt//WAQd09SCS3j1+n2taBL
 XcUk5QseGRdq5u8gFqg==
X-Authority-Analysis: v=2.4 cv=GN041ONK c=1 sm=1 tr=0 ts=69e25152 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=0AyAw_TJNaHdl9VPQ8YA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: QBd8ed6Y1cnVwYl3XR58nY9A3eOoizjx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170155


On 4/14/2026 7:39 PM, Konrad Dybcio wrote:
> On 4/14/26 7:00 AM, Vishnu Reddy wrote:
>> From: Mukesh Ojha<mukesh.ojha@oss.qualcomm.com>
>>
>> Most Qualcomm platforms feature a proprietary hypervisor (such as Gunyah
>> or QHEE), which typically handles IOMMU configuration. This includes
>> mapping memory regions and device memory resources for remote processors
>> by intercepting qcom_scm_pas_auth_and_reset() calls. These mappings are
>> later removed during teardown. Additionally, SHM bridge setup is required
>> to enable memory protection for both remoteproc metadata and its memory
>> regions.
>>
>> When the hypervisor is absent, the operating system must perform these
>> configurations instead.
>>
>> Support for handling IOMMU and SHM setup in the absence of a hypervisor
>> is now in place. Extend the Iris driver to enable this functionality on
>> platforms where IOMMU is managed by Linux (i.e., non-Gunyah, non-QHEE).
>>
>> Additionally, the Iris driver must map the firmware and its required
>> resources to the firmware SID, which is now specified via iommu-map in
>> the device tree.
>>
>> Co-developed-by: Vikash Garodia<vikash.garodia@oss.qualcomm.com>
>> Signed-off-by: Vikash Garodia<vikash.garodia@oss.qualcomm.com>
>> Signed-off-by: Mukesh Ojha<mukesh.ojha@oss.qualcomm.com>
>> Signed-off-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
>> ---
> [...]
>
>>   static int iris_load_fw_to_memory(struct iris_core *core, const char *fw_name)
>>   {
>> +	struct device *dev = core->dev_fw ? core->dev_fw : core->dev;
> Maybe:
>
> struct device *fw_dev = core->dev_fw ?: core->dev;
>
> and preserve *dev to be the main Iris device?

That's better, ack.

Thanks,
Vishnu Reddy.

> Konrad
