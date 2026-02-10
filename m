Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF72F2FB965
	for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 11:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770721805; cv=none; b=flwoMb4LhP38IcSf0wmJLmbleL83o4uvYG+U5G/b4fPXgzXn2lNN58hQNjtqdMPAML/9/NJ34+5js0leTm5afx7/GCI+/m9riLWz0u6e1wNBt09yybydKhaA+xvefQ/Wi2naRiqzSGnA4SmwJ9e6chWUBIh3afHCouSughsnNqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770721805; c=relaxed/simple;
	bh=1w8xc8VCus6Qr0Wfc6mOnjPJ5XW3KYBH6lwESXiLGzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hah3r5Od+aeqLSJ4qIxy0Vw7+QYeiZ5a/SLSoPbLAmnGqUa+WnAfV9GPkW67DV7M9wnYVxLu7T+iGGFyR93UVAKnqNsJDYA9AwjhT04NyHiyiAVYHjtOWuTO06RrB6vbWuHuifmA8FdBE/yB5E4XAB9JWIKGrmAUDSXVapkftpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fZnNimaS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ycsk2pC1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fZnNimaS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ycsk2pC1"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A7Io9B441723
	for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 11:10:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xrae0P7gUt75AhWHmiemIgjk6vnyOpZYcSvfCh7M7I8=; b=fZnNimaSKkGrjM+X
	Gnc4PGcLsrm8DHUPlSFUV0qwPyDXk7f6PPirnHgGqnfP2SD2x5YMkuRx7VIA9GBR
	OlkaSRO3lNHD0wNrCOBB4vFSs8IC7x+e7YGSy8nVmHJtCMRypxNJ6MEBMCap+5PR
	NDJtny7fF+sAf4Bv5Pqt2lv4Kb7QD4yByniRjC9nC7f/i80iWcMq8cz9YZ2MiQc+
	np+J6/vHvu5RtO7/SGu2wC1IQu2ls6hTZV5CT40k7ULgU/VayzkZbikDnmYnCFZQ
	Gjfbz7+MgHAWaqdmMkjS+2ImOWlP8a7+VQzw656j/LBuMOeLS4lwV43l6jmaokdu
	RMk3fw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7qp9jbqq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 11:10:03 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a79164b686so10026415ad.0
        for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 03:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770721803; x=1771326603; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xrae0P7gUt75AhWHmiemIgjk6vnyOpZYcSvfCh7M7I8=;
        b=Ycsk2pC1uaVUqK8US1oND/hIcTw0X73jBUFLpFjgpwc2EDJE1kwy4YPkuuk3ZBZaw6
         MhSrSs2auhFpEwQksHSVj9ubhzqYroyPZmQN4e48ev02hbWpYDRZud8wAGKioL5BpPre
         gggUU0mDOiQRo4PRyfGfGpRFt2CLiscDmqYHurm+i/x2zbVftxyE2UogCDd6so0j8a2U
         AzDOccqym2SobsJln/WJBXfOA8i4AMell4dWImZBqIuQdUXrXhM2MiQ19g95oIaYOWV0
         ubhT5yAzCTMoVp/OtjN6YcvWcePY0CLfVnTSfuWqYXiZSl+hOyVeBKbxeCPxdx8HPmYY
         TtrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770721803; x=1771326603;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xrae0P7gUt75AhWHmiemIgjk6vnyOpZYcSvfCh7M7I8=;
        b=shinw/wHrPRmDpTWoiGKHHVP0EHjBEkdqrzQpY66soBfDWOnj4tkChd140r8MvVHkF
         C2TStC4eFpSQudWiFsHULJOanAh3DoQAqtBMdIgTgNcmLYQyel81FKoMrSEZljfdGaIh
         T/vzyZXBbTNeZO3G4SR/mhR+RwgMtJRDZnA75t8fkYTZ3XUaoLwOaOBCXRBSTgVZ5nYt
         Z5YHFPMMmNbbek3bfQAlkY8n3bzf/YlURSHgZ1wGbkKJkPurl9zquktJN3njBS0/N7X+
         x/OM27DuPqo78bzbWlDrdjb8Z7V7/d2y0plW1AP5/rlsLpe8EkmeGXQg2fjz5lGxXoZc
         USUA==
X-Forwarded-Encrypted: i=1; AJvYcCUFflZvE+SeRwsO0jDoxX0ZOxE/Xh7F74FceI9D/DeACmStn8cYDCsVLLJAvx7lgn1Lvx7tDw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwqDCvofiKauO2BfBz3PTjvBAQnFbezRKpRdviEBY9nvDQU02qw
	ccJ3Miva3iUMajAeSBmHCBSVT4C9j6caZwwUbQeYNaeaGjOwp3TFUNVhaOzqiCRSNaM+e4ToWQs
	tP36ve7TXVpZ/DhApg0JQUilz0wMm/92Yo5yysCC3djor1uTYIq2hp2TtLg==
X-Gm-Gg: AZuq6aI42/17TUxqYaH/pbQn1N1VePE44Ln0k7GmPgPnBmgE+30+fRvB4f0Ojlozm/H
	z9aeItk+1vaSKw4KA25MvoiTXefylZDzWp4sQXfeypLOOVmUr5LoeSoi85cJg8Qyr+x7kgYRso9
	vdH4qfnwmmeexukkx3OSFmBWg529fUzzrTySw5w13GXrehm3YogL3M7jSxN4PMi0Fndd8xy2WZ/
	IUaUZcg3MCEygmCyG7XnUSfkfh8u1aN06l05cp6+LuX4bBt25PISat9X1lYLePvBMvJATnI3rp8
	GEEVpqVijbwRxxmiyl1DTfagGd5qPnZ2dSE6O9hy33lM3Brah4Rku6epFzFAFGzoXYv52fYRoCa
	Vn0frp9qT2g5MC7AyQx0es0QhW2vg0g/hQpIFTJsKEztIjo3efRxr
X-Received: by 2002:a17:903:985:b0:2a9:cb10:42d with SMTP id d9443c01a7336-2a9cb100bcemr94582675ad.61.1770721802920;
        Tue, 10 Feb 2026 03:10:02 -0800 (PST)
X-Received: by 2002:a17:903:985:b0:2a9:cb10:42d with SMTP id d9443c01a7336-2a9cb100bcemr94582105ad.61.1770721802081;
        Tue, 10 Feb 2026 03:10:02 -0800 (PST)
Received: from [10.219.57.215] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a95dce24f0sm119367945ad.32.2026.02.10.03.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 03:10:01 -0800 (PST)
Message-ID: <7720d215-9f92-4f0f-83af-c992e1cbe531@oss.qualcomm.com>
Date: Tue, 10 Feb 2026 16:39:56 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu: Use pm_runtime in fault handlers
To: Pranjal Shrivastava <praan@google.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Connor Abbott
 <cwabbott0@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
References: <20260127-smmu-rpm-v1-1-2ef2f4c85305@oss.qualcomm.com>
 <9fb8f661-a235-4f86-bc10-f80a21a8fa9d@arm.com>
 <00fcbcf2-3f48-410d-88a3-88dc834c1ed7@oss.qualcomm.com>
 <d6bc7f38-b41d-4e89-b484-0e699981b8b4@arm.com> <aYEFop8CJiLYzhLw@google.com>
Content-Language: en-US
From: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
In-Reply-To: <aYEFop8CJiLYzhLw@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rDDrfAfxajMjZdlAvTETJr6QqgqJ5kku
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDA5MyBTYWx0ZWRfXwJMyK0Cbk8Ax
 v88flphVtiFNzcn671KEcEzCy/IkJAJMsh+OMaMMSdA7qI8hwGM7kYvX9LlI/jaNXvPhKgXZjhX
 bu6TeUi5uPO8grnPJVrJU5XJ9ArpjVcLqe1zgMNoIsuNbUsHCjpfeF9/X54URLYlCqctB1+v6Ld
 ef9y64dd/ygghCvQo3RM2XeqFdDSHgtn6Y9/DLvL1AJcLlwFGfbbiGJsJBVahgje+FkwR+W/Lv9
 svzpKdYpnruY4pG+hown9WS2qpa6dOpPMgSbACwjB2zckOrOqMD5KBX4sjMoXw+Z64grO+wKKQv
 ol7vfDJ+Ifgczu4u+GxQX8RRQANMbLZNlCV1VPEzAJNBN11jh7V2Z+AviQO2hkqB2tsQ8KvfIzq
 F8/uGgueXAoOljMeXfT/8HSJtR6YHHfFKQ/GEPrGVwlZXNfa4YlTvC8S4CFJfVPdaEOrqIp/At1
 lPTc8aunlwqoNopV0uA==
X-Authority-Analysis: v=2.4 cv=dP2rWeZb c=1 sm=1 tr=0 ts=698b120b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=oqkVm95N0dxC-dYrnX4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: rDDrfAfxajMjZdlAvTETJr6QqgqJ5kku
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100093



On 2/3/2026 1:44 AM, Pranjal Shrivastava wrote:
> On Wed, Jan 28, 2026 at 06:44:35PM +0000, Robin Murphy wrote:
>> [ +Pranjal as this might matter for v3 too... ]
>>
> 
> Hi Robin,
> 
> To weigh in from the arm-smmu-v3 side, we’ve attempted to address the
> "can of worms" regarding power races by leaning on these differences:
> 
>  - Threaded IRQs for PRI/Events: In the recent series[1], the PRI and
>    event handlers are fully threaded. This allows us to call 
>    arm_smmu_rpm_get() safely, as the handler can sleep while waiting for
>    the hardware to resume.
> 
>  - GERROR Handling: Since GERROR remains a hard IRQ, we handle any
>    pending gerrors in the suspend callback before the SMMU actually
>    powers down. Any GERROR interrupts received while the device was
>    suspended are treated as spurious and ignored.
> 
> Thanks,
> Praan

[1] refer to case where SMMU state is not retained during smmu device
power down, this I think is equally applicable for both context and
global faults.

Since the ARM SMMU runtime resume triggers a device reset, any pending
faults would be cleared during resume. Here the solution can be to
handle both global and context faults before allowing the SMMU device to
suspend.
With this approach, any hard or threaded IRQ scheduled after the SMMU
device has suspended can be safely ignored.
One concern I see is iommu fault reporting to clients while handling
fault during smmu device suspend.

Thanks,
Prakash

[1] https://lore.kernel.org/all/20260126151157.3418145-9-praan@google.com/
