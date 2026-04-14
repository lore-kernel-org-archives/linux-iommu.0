Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E0A3E869E
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776175803; cv=none; b=BEkEkeXhUiwFFCODl4uoYV0ndF+lNO2p1bA4f9TLffRFqdzKTb8kNjbZ93YmRt8uVQHlnl+MKGgQBe32wyRPoO0CXJUUmcGxP3f9gZqBRMNNeU+iXQ25ZnwGVbgHEvz39syMm83Xh1/UoSPaxvkcbJnyMbCjmYTTvnjQmq6qKIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776175803; c=relaxed/simple;
	bh=v7YJMKsGDlh1XdUvKRSZvUwbcwUrfvm0ci5obZxzHuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ETUwHzM0dabqYTPh2IvqUc8QIgblUSzbC5/r8vVBboES1ypoZS3rO/Ho8wQv7MIjPS8Xv/+UZB+ghb8Ja8DiVh2ctwki2yJMrh6KWRmD8mfpgEUkqbPNw4r+OUsYMr8qanVbRIt50mqvWS6kSZbYcULXA962+4GOKoBGlL7auO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NZbdmApM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BgY67KDA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NZbdmApM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BgY67KDA"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EArRfv3425651
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 14:10:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ODMoVBUj25CjShpTfa2WXnly8YJTIG/0z1viPh/qBBQ=; b=NZbdmApMwdxzai/u
	WqM7682GFk6zcPLl/7afKamZ6/yMqrHypMQI8yBtEOCEn0k973OxTctZjQ+ygjdG
	drGQzBI52syqQ1KEzr9w3snpgvUWwHzyZwgwiRUpkqoYF9nPfVsUWT8axRZOdmO5
	3v2qRvwqp1mh0zGGcNZRtVcySbbmQNqk/yzV1v0sG7hAJS8jrZuvQajp7tUxrPJm
	6vDjrjlvVrgFb2OyiY+oi1KDPsIXYw1YfuR00SJQWwK7h0QsBTcXpuGeNk2bhGO5
	cgJMqCY2W3Rd243zeUeWsZSjHJJy16DsFYPna3kEGk6Ys09eFnwvA1tDO7QVK+9h
	oadbHA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh87fb0ph-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 14:10:01 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8d56ae62e86so167945585a.0
        for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 07:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776175800; x=1776780600; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ODMoVBUj25CjShpTfa2WXnly8YJTIG/0z1viPh/qBBQ=;
        b=BgY67KDATTnR0liKGGPHNaJfJmSsOBcIGSgrZCYTTuxQiABW/ARF/7Pv+6a8jWQKfM
         amAMwW5NkY8mFcFTyVCK8v9BQNlUFhxzhDHqtsqHweyTuqk/R+M6rES+wm3Ae3gylo/v
         vOQ5OFPKnIhgKKJM7NQkQV0S5FM2gGhM9VEE+stHwT+n4K4bCtfgJJKSjEYiiCbDIC5F
         QuhUJC5V9KlxwfsRjvxrNxpP2C0jiMVEqUKO6fOWLFG7IkIPgVH2ODHiQ+Q69VD8Qq5Y
         ZY9+ug5q2/fr51fHGvVTLaOo2dhfvX4pvOhXRYhNzA8oZWsuL0ey7kiHfmsPBWB8lSs2
         kfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776175800; x=1776780600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ODMoVBUj25CjShpTfa2WXnly8YJTIG/0z1viPh/qBBQ=;
        b=C0X8nvBAeO1PP1hA+m2J0J97n0piwpzNOzUemF9ZwE9/XkCwtGJQgQxNU0smLG9ToJ
         l2ET3CKCf90wvntoC5EnBnZC76PoTwCIRCbYUDK0ic47NVPVe+FUf6mFWr2SfOVbvhts
         muMfzznidvNh0f+PraNT1eJactprSxvx50Dc1kdBnzZpJTBIzXsWoHlv495ykA1tZE/H
         T0Nf9t0XhoqdMJifSNxLjBAu5vSUX0LRpD4Zndf0kifXrGaYQxtHC+cC7JYmc8hDp9VE
         eBQFY1nVUNL/W9VJn/j6TQl1sq+rfKchuwFGVj/duU0EbLjmWbYo7IHd/DCEpXoN+quE
         9RzA==
X-Forwarded-Encrypted: i=1; AFNElJ//rd1EJwBsCylPT5lhCHe0LP1tnPq5JNk1jNfxfiers5OT5Iu8APN4REiOMkLvtfgtNJM8vA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJ+XjouufViBzNYX+EOsc4voFuL3O54y0ij4JswCWnqmWkftfH
	w12ENba+Fbv6qlKDnAdDYmhWtpJyhE+5wIYecQtOfmIZVPtokIgw4BzUypPkzOG9T4oSiPMhhq6
	ZpntzuDfDmTjGafTsc3sMy057h9EJMe4oOofLDEPC1yrVyU9zbqh9gtrZ2w==
X-Gm-Gg: AeBDiesxcOHsZPfiPOIF77EDj6C9R4zj9tDsKCq7Y9O+oZX6CDFlsz53UYLu9TJjg5O
	goPyDrcjbGtYAOp4BnHCnn/WNSvsQqJghd9MJYwZi+EQ8NCtkBLbU10kgnOwUZq3Gc8lOMIcUv/
	RGY3xX9kQ0QZfrh+B6DdVETuc+VZzmqb0pdwXXSTDpn4e/HJh9WFiekuNjLNkurP3ZRwQeEEVrU
	qCpcYiU8DMRTCMs7+CDD6eWJKBkMuHlmt+Z4Tyc2GvsP5+Sl+Fy2KwOT3OrDh4n2yYBqxF62/eN
	0x9acrnWgbmKMgZuUxGwbqlNiPHRq5ESXKuRS83P6iKZAYZx1hwo2ZwvRXrV5F13iAwGmR4P5wm
	KyC4r772FXTqbwyA2AddQCTnBwFawyjM57TZBkxXHvdbBm63K5nniP+1JdFC1bDE8BLWxgL863I
	BjxgVnsemwDq8bdg==
X-Received: by 2002:a05:6214:ac6:b0:89a:7d14:66cb with SMTP id 6a1803df08f44-8ac8629bcfemr204974716d6.5.1776175800061;
        Tue, 14 Apr 2026 07:10:00 -0700 (PDT)
X-Received: by 2002:a05:6214:ac6:b0:89a:7d14:66cb with SMTP id 6a1803df08f44-8ac8629bcfemr204973926d6.5.1776175799410;
        Tue, 14 Apr 2026 07:09:59 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e5c5824sm403077566b.38.2026.04.14.07.09.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 07:09:58 -0700 (PDT)
Message-ID: <809e2ad6-258c-49ac-9f3b-4ced32807203@oss.qualcomm.com>
Date: Tue, 14 Apr 2026 16:09:55 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] media: iris: Enable Secure PAS support with IOMMU
 managed by Linux
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260414-glymur-v1-5-7d3d1cf57b16@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDEzMyBTYWx0ZWRfX3KWLEOBNJ20Y
 Zt3/kvGUMeiQX7XJnJcH5xAOCzn+MRgf9n0pfIOl/eZ3egVHLxvcXA94gbY5gbAiW21x2K01uP2
 lk7KrHM52WMOO0+rBcofJhWrdCDHb3pLOEugKtPDMCBj11LNj3W3oVVlPzOlO+bqwK/IMQEpQqJ
 6p/IT6O5XP2UnL3HwY9HsBX2JwIDsYGueqdO4f/RptYqG1011tzwA8fuyDZPyLBtTLfLzvoGtrz
 I7iDmgd5eYoljpAFjMJfSwam8d75FOBMGaBeJdl9oJTjT0+51DzwgpfOamNcjXkDmIHq0sE+p9U
 0Gk4oNiiUI1OpWHYRYfkWRdV9KpNXuudoJbBqcPSYfn+N95Q2wRkYBj4pL7Zod3Zyulaag6sbsX
 XRC+6Ck37XrmEFxzeSr/GIJUFfNZ2HaSmYmg3pa1xhtwE/w0QQ8wMjbYX5pkXzktOIm/9/K4z98
 t335wu5UriEsDZiMXbw==
X-Authority-Analysis: v=2.4 cv=DaYnbPtW c=1 sm=1 tr=0 ts=69de4ab9 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=BowHXwPdtatiOUMbaTwA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: pTGX2Di2ajthHnkjutPwQUEZZXXMUGpz
X-Proofpoint-ORIG-GUID: pTGX2Di2ajthHnkjutPwQUEZZXXMUGpz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140133

On 4/14/26 7:00 AM, Vishnu Reddy wrote:
> From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> 
> Most Qualcomm platforms feature a proprietary hypervisor (such as Gunyah
> or QHEE), which typically handles IOMMU configuration. This includes
> mapping memory regions and device memory resources for remote processors
> by intercepting qcom_scm_pas_auth_and_reset() calls. These mappings are
> later removed during teardown. Additionally, SHM bridge setup is required
> to enable memory protection for both remoteproc metadata and its memory
> regions.
> 
> When the hypervisor is absent, the operating system must perform these
> configurations instead.
> 
> Support for handling IOMMU and SHM setup in the absence of a hypervisor
> is now in place. Extend the Iris driver to enable this functionality on
> platforms where IOMMU is managed by Linux (i.e., non-Gunyah, non-QHEE).
> 
> Additionally, the Iris driver must map the firmware and its required
> resources to the firmware SID, which is now specified via iommu-map in
> the device tree.
> 
> Co-developed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---

[...]

>  static int iris_load_fw_to_memory(struct iris_core *core, const char *fw_name)
>  {
> +	struct device *dev = core->dev_fw ? core->dev_fw : core->dev;

Maybe:

struct device *fw_dev = core->dev_fw ?: core->dev;

and preserve *dev to be the main Iris device?

Konrad
