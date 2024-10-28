Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5217E1D79A6
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 15:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730130403; cv=none; b=Dtiu0ptLT6yvUnLJZTNGi12uIGVtJMEJ0Z91ArmHi0eW1xOvSPdFrwHSjrji+nM2LnDlmj/DTdVfjhPu7QsPgdLUWezRfng3F0phfns/Blpw07LmREokv+8NLCzDmFO2vzWXA8Wn8r5WISQplmVpGGjgS0l88fUE72s4VBfuaPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730130403; c=relaxed/simple;
	bh=eA+WK11+5F7kgjIh0WfNQgfuO7WaLXIuJapswCAe50M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eJQnKHsgwCi/jX7zdPKDG+yM2OrV7HytFCiXFw59EYzemiXIDLr7AVK2/SDlceDr/a2EtXHK7BaECANVa9pH5gtj+LUhMIgDxyF2qbUGxHy3jK4c68xpRJhSYkfhVDobedwONoEFaZkOzI/cVYz6Gp9IpJ4Xp2Fagk17p495qk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i0lO/c0l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i0lO/c0l"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SAYB1e025437
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 15:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uXWv1L1P4AyDVtxCnG5hV6KjhukSzud5DuZcj1J/S1I=; b=i0lO/c0lj65gCLx/
	Rw+HnDTOZjAHjwoiR/1uWLAy+Xd2Ii3yz7lI/XzNhWh+k5IfGb/dBmYeoqKY8WCA
	6TonMl2y+gEfjX5yhHOVDA7cO+HpmdkqNlVMfwmGIUi2B04BkOP0cFrRMah/8sRe
	nFHmqI6VqUxANIxRwIYDbOn6df/aJJ+/z6TLKffu0l9d63aI8mYwu6J0mWZVfD1Q
	+4h4XNg5CDO3zuVQpQ3Qkd1jDxqIK1UGpOkfvpFAPyGGc4dPuoq99dipM/sYizfR
	BmejYfwxWWAX2h54rVcZecdJL40WP6Zr15axUYIb3lAwYD58zF7u1gCRc6Q7OSJn
	jp7QzQ==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gsq8dgfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 15:46:39 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3e60838eed4so75927b6e.0
        for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 08:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730130398; x=1730735198;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uXWv1L1P4AyDVtxCnG5hV6KjhukSzud5DuZcj1J/S1I=;
        b=Yi2x0913EuC/Y1faBri3mG3NbfcFh45yVzo9pL25rQN2XSfjROXlKHVgsAWM1m+6aT
         o8kqKxy4iJJPAqS4NP4PeoDERiucvEqYozoahBn6quljqY3wFKhRuoZP2NZ/wmVw1Cz0
         7MqeQrO2MbhQEyNs7tsn+0duIy99gw8HjAgYGuZkYtPT4eCi8mE6RQniwDEsF0ufByex
         ySuuY9zZuIyNVorxL93FvGICg72rttriGXCr02Twm+3ZJ0aUxetq31jOlv9J2b6iv4qm
         kHYA8BQfZ3IZNWwGzYeiWQD2a5eS3dcH8A42wZUUBtSG4Gv6Ef6nCh3Vqw96gKPU4wDI
         UY8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEv86bDVgi2ZdA9ZBHQ4pROW9d3hvqgcparPSAm5Xyu77JYTfOLjHF+GMN/46ZghwBv/uZWg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwksnP9Z0b/+TyUPiM0/dqZ8C/GDSr7n4UpkUq35SvM8AFIl76C
	1I4wvuYfuQsVIFVEtJIHIjch+D925hWuqgDSXSYKUm3yv3Zlt8fTQjRdbUsU/eyE4ILBMIF/fO+
	+bUqnUQV18KmhnQ1NLd6sPAFxCpklv1KY5j2pSVS1lt12CMQS2bFjCw==
X-Received: by 2002:a05:6808:2117:b0:3e6:40b3:b37b with SMTP id 5614622812f47-3e640b3b64cmr1231586b6e.8.1730130398544;
        Mon, 28 Oct 2024 08:46:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaiv0d3Uy15/pqVCF75IboJqTQkwfHGPAlVPiwCgQJsKOla/IcnRmIUCLBabNT1fatrej9AQ==
X-Received: by 2002:a05:6808:2117:b0:3e6:40b3:b37b with SMTP id 5614622812f47-3e640b3b64cmr1231566b6e.8.1730130398245;
        Mon, 28 Oct 2024 08:46:38 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b3a083466sm386476166b.193.2024.10.28.08.46.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 08:46:36 -0700 (PDT)
Message-ID: <828c465f-684b-4257-86cb-d9c753fc30f1@oss.qualcomm.com>
Date: Mon, 28 Oct 2024 16:46:34 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] arm64: dts: qcom: qcs615: add the APPS SMMU node
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Qingqing Zhou <quic_qqzhou@quicinc.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, robimarko@gmail.com, will@kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
References: <20241025030732.29743-1-quic_qqzhou@quicinc.com>
 <20241025030732.29743-5-quic_qqzhou@quicinc.com>
 <8a60b729-b312-4afc-835b-a18060ad3f03@oss.qualcomm.com>
 <zsphor7rpbwx4km6uxpepky2h7atbgjn2435puygmpssfc36mc@wkquqxud2yij>
 <8c9804f2-ef4d-412b-97ea-f521dfd35ec2@oss.qualcomm.com>
 <nhthg2rlfatc2pyhsuoulvo5447cxg7buv4aq3r7r5amsmjjoq@pgfyvvegfron>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <nhthg2rlfatc2pyhsuoulvo5447cxg7buv4aq3r7r5amsmjjoq@pgfyvvegfron>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 1sjcpnXTtjhe_RRdKMOT6IzNfC5QQd_h
X-Proofpoint-ORIG-GUID: 1sjcpnXTtjhe_RRdKMOT6IzNfC5QQd_h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=669 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410280126

On 26.10.2024 8:18 PM, Dmitry Baryshkov wrote:
> On Fri, Oct 25, 2024 at 06:45:01PM +0200, Konrad Dybcio wrote:
>> On 25.10.2024 1:06 PM, Dmitry Baryshkov wrote:
>>> On Fri, Oct 25, 2024 at 10:54:24AM +0200, Konrad Dybcio wrote:
>>>> On 25.10.2024 5:07 AM, Qingqing Zhou wrote:
>>>>> Add the APPS SMMU node for QCS615 platform. Add the dma-ranges
>>>>> to limit DMA address range to 36bit width to align with system
>>>>> architecture.
>>>>>
>>>>> Signed-off-by: Qingqing Zhou <quic_qqzhou@quicinc.com>
>>>>> ---
>>>>
>>>> You probably also want to mark it `dma-coherent` (see e.g.
>>>> x1e80100.dtsi)
>>>
>>> Is it? I don't think SM6150 had dma-coherent SMMU, at least it wasn't
>>> marked as such.
>>
>> I don't think I have any documentation on this, so.. one way to find out!
> 
> I don't have qcs615 at hand, so a purely theoretical question. But how
> should it break if we mark it as dma-coherent, while it is not?

The board will hang rather quickly

Konrad
