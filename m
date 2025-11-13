Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C09A23184F
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 13:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763042135; cv=none; b=i/iwYN1s1iX+6k8eEcTWomsevSBEbtIMAYb4sEWDm7RB4xTWgHCJOXac5HU8vvSqAlCTjg6iyJJcbT7XSPfJwKiOnL7u5Abq5ogqWg/dkpClsl4Q20tT6thv9Jk9HxWNes53rt7y5qQnTbN/YFdE7nWvt28AFy+hGIH5R/PGmL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763042135; c=relaxed/simple;
	bh=BWyO42d1hYYLVvQCQ4tlS39gf3pek+5rN+OLpq5Jr90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g0gxqM2gGOxCCYQAP7QDlHdkjrTp3On5raAVXQu8desigGDhkNnCe7TmWG/cv/GdzaJ7L4przXnHJP9vN5QyZb1dGWSuhqwcbsmJckKE60BnML/MGb+xGwwHo4XrPRBGzrbAzOoFP9qn8LJY0zk1SUnPizU//P80kzg3NH0FZXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J+LpV72S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AS0W3EHB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J+LpV72S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AS0W3EHB"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD8bjP12993469
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 13:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PYq90gPok05Ftan3q4LlS4ySOfx7eLDR6jvQPaWFLaI=; b=J+LpV72SJATiLwN1
	sdxH62ruSbqsh8Ic+tb9+6OSbVfKojMtQ9Hy5e3qylgM3nE8Foxy+CMV7PJpRfl1
	9g469/SlTULJgYFUJ4FXrskSFLr/XCjU2JraFCHDLP+TGY0iYzHgS3LRBvGEEWAr
	ZegyHa0zEhrMAw2K6xm/0oiTYFw7++RJodiCPb7V6hWkfD8qF/zbEDCeT2xAHJNE
	Vpp530YmDV4Q/TXy1oR6ixQ6necnTQFHqsueeVhAJM4BgEIwZz+SHQhaiPEOeJIn
	MVOnfZuQF7iifHbRAVX9Cy8RdR+57iBBe+PrcffE4p6GZFYo3BmKYmkX1r7z5zi4
	P5JNXw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ad47jje05-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 13:55:32 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-297e1cf9aedso23342485ad.2
        for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 05:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763042132; x=1763646932; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PYq90gPok05Ftan3q4LlS4ySOfx7eLDR6jvQPaWFLaI=;
        b=AS0W3EHB9wwbVDxuZrg3iyLlcTqLx18hMQKhCsHnPOhY1BovWqDVkozj9sf62uoZ5o
         hDEQY19c+ALYtrWQP2sPazT0zFfaBVyE4thKkqDmxfc+GmciFbGGMyQCdxm4V2hQZJ4/
         kcREg4E/xo94babbjhuIjLlGB1JXjyHGENOP8nmRnTk7aat1M6tPuJT+7LurqW34sPme
         T0WWK1piWwA+SrjeNKzcf0q2KijXRpzf9y9bzoJGNhXoBtWnl91RoZiJD5Zmj1Qxwx4z
         21BqGpdx4zz1CMQV8yAX3VWY3LoZ+zi3lkcmoHjBgSwpMLcrERU1dYXCeKKO5FvjVXP7
         w7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763042132; x=1763646932;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PYq90gPok05Ftan3q4LlS4ySOfx7eLDR6jvQPaWFLaI=;
        b=qm12qhyQGs8diDSi7s0qk8HMEFZOzXnsk0WvCv8L3xJD1aOl11tRX60inruAL2Z0Dm
         SFph5xld4otswGWMZM+Y0XmEiKto9LjHS4svV7+a4MOkHxSkAG+0ks4irBqDGthhFGWT
         HUDJhhXnpDlnxXXmjVk6Zujjmnki47WbcccQmvox4Jb9qBoDKoAYgXof7XlIMd9Nt4oR
         V2Ufq996gzCvu/QpvvMY2Sp7swg2QrwRvJBZjYnfbBdy3YD5i6Wl3mWUfslOSN2+tiKs
         y2fcB7yFTqXEaQ5xJBOSllhm/Unp2QQI1PHBbZT7T74m9xRywW2poCW3a5vEW0Q8keZk
         KKfA==
X-Forwarded-Encrypted: i=1; AJvYcCUSlUipmkb965xpNVHMS1PsoX/1+M37Y5QAzDgfhAylceStnS/Zzm3eAst46AfCrESje9UBqw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzcW9Vp0YC+PzP4xZzGlfOdQKIB+NPwRySC6kEYAs+oJ0Hk9wVd
	dHIm8+1klBy1B4FhxDWqXc96aFfGZLE9ce/9oxmI1xvAS/4Xp4NlDGsxyPrHWG6OGhLmp0b/6Mk
	PrpmkcquDsS9+wUbef0ddWTX3Q5Kl6KvgJkBXf2m38HaLTNBGpGlGahOXGA==
X-Gm-Gg: ASbGnctNP6bmCImHDkSXBPFFtaNM0cZtr+VURslYewqj1mZFqCdEWfH+oRd58h1nDZs
	ZKswof7DoyxdaLNPeqKiTdj7kepidyWpujFx/ApnccARYMWTI44F8tu6lVyfa1R8YudegVJmZop
	UwzPeZXEKJwzpbGuhlAbHLaAJO+/en7+DBGPWawWiUPXW1m4sOMvF6ypGzqI0j72I1Oqpd/cSrn
	OHDNIp48+tbYxUavMxAkGWMINow8OOPUYGgfSPgrvUfoFy5JuN+k1ThW+yg4QurTEWpRwoFkinX
	zBgMGIpMVOPfxI9/XZ35l9ZGq2Mhad2Satj7qZ2yT7ZRjKxvtY0NuMEgwLFFX2c+qJJWzTW8xwr
	7GMDBxeFcfHtdJOimaB0wdMHhnbso
X-Received: by 2002:a17:902:d583:b0:295:592e:7633 with SMTP id d9443c01a7336-2984eda9ademr94497275ad.29.1763042131769;
        Thu, 13 Nov 2025 05:55:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHT1ffqRPXlTOuOE+KE3Wz2kdPEseeGi4tLYYplf2iHM7EojlOZXfQ+bTEJ192e9zzGd1U2mQ==
X-Received: by 2002:a17:902:d583:b0:295:592e:7633 with SMTP id d9443c01a7336-2984eda9ademr94496775ad.29.1763042131113;
        Thu, 13 Nov 2025 05:55:31 -0800 (PST)
Received: from [192.168.1.5] ([106.212.255.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c245fa1sm26803425ad.36.2025.11.13.05.55.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 05:55:30 -0800 (PST)
Message-ID: <1db3d7f5-0cdf-449c-bbc3-dc40c89ab27f@oss.qualcomm.com>
Date: Thu, 13 Nov 2025 19:25:22 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 0/5] iommu/arm-smmu: introduction of ACTLR
 implementation for Qualcomm SoCs
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        Enric Balletbo i Serra <eballetb@redhat.com>
Cc: robdclark@gmail.com, will@kernel.org, robin.murphy@arm.com,
        joro@8bytes.org, jgg@ziepe.ca, jsnitsel@redhat.com, robh@kernel.org,
        krzysztof.kozlowski@linaro.org, quic_c_gdjako@quicinc.com,
        dmitry.baryshkov@linaro.org, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Eric Chanudet <echanude@redhat.com>
References: <20241212151402.159102-1-quic_bibekkum@quicinc.com>
 <CALE0LRupg93WsBVc62Lqt-T9qmK5MdEYoScxyP7=ttKJYXAsUA@mail.gmail.com>
 <33826089-54b5-47bc-8a5b-6004c7a276b8@oss.qualcomm.com>
 <5a1aaf4a-c5d5-42e1-9044-d12a6c231904@oss.qualcomm.com>
Content-Language: en-US
From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
In-Reply-To: <5a1aaf4a-c5d5-42e1-9044-d12a6c231904@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDEwNiBTYWx0ZWRfX4Id8icRmS/eL
 YJKsnQ909aKrJOjMe5RAzw/oBsQGX0IkA7A+gavVMYQY78idN/Uutea4QLowUY45K6E5N8AkEwX
 CNceQ77sLs9Ls5mtggzplhnHivMyTx3PS7NW/odU6cHFNGoWOmFhA+/4bF3HnbODCMeDXlYSPqE
 QXSGVFeITUD0ePKzyV20RHuT97YiSpRber8KRZx6nFGBRY7wRxgtjtcKQnr85DdwLgdZvXHLdQX
 kUk3F3asnJY/Qf7FM72dCWL4Olq9o3Cie+ZTrFkQdhPMeSD1PPvQcBsXj/ZNtFQwD0h+pEq916M
 55mnrH4p6887Civ59I1EoKWM9cD5HydDjI3C91Ug8FFoE9etG02eMBqHZU+7DWwN96Us58co44Y
 FWlVf43n13i6mmQ1DFWUURmlvQNRbA==
X-Proofpoint-GUID: T-vfvZd12ben_LUctKyFnxoC_TaBFwGM
X-Authority-Analysis: v=2.4 cv=A5Fh/qWG c=1 sm=1 tr=0 ts=6915e354 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=pJoDNl42m32kJ7anCML+mQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=UTFmerWDhw6whTtWHmAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: T-vfvZd12ben_LUctKyFnxoC_TaBFwGM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130106



On 11/12/2025 7:04 PM, Konrad Dybcio wrote:
>> Hi Eric,
>>
>> If a device has multiple SIDs, all serving the same functionality and grouped under the same "iommus" field, for example:
>>
>> iommus = <&apps_smmu, 0x2141, 0x0>,
>>           <&apps_smmu, 0x25c1, 0x0>,
>>           <&apps_smmu, 0x2161, 0x0>;
>>
>> In this case, all the SIDs will be associated with the same context bank. Even if the three SIDs have different ACTLR settings, since SMMU_CB_ACTLR is per CB setting, all SIDs attached to that bank will share the same ACTLR configuration. This is why we designed it to be "per device / per compatible".
> Does that suggest the settings may be slightly suboptimal?
> 
Or it is limitation to use the ACTLR?

> There's some work being done to allow more granular association of
> the passed SIDs:
> 
> https://lore.kernel.org/linux-arm-msm/20250928171718.436440-1-
> charan.kalla@oss.qualcomm.com/
Sorry, I am unable to link this limitation for actlr setting with the
work. Can you elaborate please?

IIUC, unless the SIDs are totally separated per actlr settings and
attached to CB(which are limited), this can't be achieved...but may be a
question here to check is it really a __valid__ to associate a different
actlr settings SID to use the same CB?

