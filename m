Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812372DFA48
	for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 17:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764178214; cv=none; b=dWLpUcAOviTV9W0fkcMnfmkbH12GI7rbRXY3nagT9/NSjB2+CrPGdfKk2Kj1r7F/KBCGUNXlchOmw0VlnMdEFbFH2lM/Upk/kwAIV1xydhixv5JmWrLtLw6C6WV7kl7/lR7oY2CL0wol4sQzTGggvZI6OAC0kZJ1NvP6acf9VFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764178214; c=relaxed/simple;
	bh=Cl7knpSbUZAC0/CoNr3UsqLF86lksrDHgOcfcFynZEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sUlyy7fp28r4vEHPeGROrp94AfkHMHjM3m0SyHDrfhPTsfSntHPH8XHAORJ1wUb6dQZbq7i2frMuqQbnk93gjqjWeKMKSmg0UeAzQMtCqPD70IpI3NR5cP+ZznHyJDShUVzRHp1T8q9psunoiKkW/teVpl9fBOF1VeBEcZxfcLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ejmWNOck; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SITpCHMq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ejmWNOck";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SITpCHMq"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AQBNePP1849261
	for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 17:30:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DJcjXg1+RvjOx5A8hSzA1CiyWHl8XyDYL+rBPEwr07o=; b=ejmWNOckF76MxY8V
	rNu641AM/RJrkE7i8ZXqLBlJM5pn5g9PuAq/Ocub9ingeNFKsqXamOTeClr4A/M1
	cDkVWxzQ5q/p9qqYyvUrTAn2dfSI3erAhAg8j/UGDcKVQ6dEhJ1dDVsvZ/avuGpH
	EVEW/DU3WLAY91P/hBiqWsAWR08+MkMcV7X3W2Wp3ZZD+pacT87Pday6DKR31VgR
	a3u5+un/V7VD0AKW1FQYpZQALL1tGs6Y3ZEGmNBaiWp56bUCOhphwZh1SZ9DUpYR
	8sed0tL7q4w2vRvwJXhlsHqYk9yErT//dv66lIJ6BpyjfrngoPBjXSPlqjY78twE
	nRzwiA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ap0mss1f5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 17:30:10 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7ae3e3e0d06so5257604b3a.0
        for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 09:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764178210; x=1764783010; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DJcjXg1+RvjOx5A8hSzA1CiyWHl8XyDYL+rBPEwr07o=;
        b=SITpCHMqynKCRQ8Z7Rh/YtKr1YiHL97cnFiiUJWNO1I1Sne8IOiih1hMGZWLEojdcY
         x9mWllxmuWU2Z2GmgI7DQutje7rI+FO5AzlhL1WS/jYGwXye4bbO7E3RkXu46/gRUR67
         CaUDvvDx9D9SzCHZwHSV1fcqPX2r2AbmI+rtYmvYqJncapasHGl2+NkaQWZaIXc/op7B
         HTh9z0NAttP7m/7silU4VUVX9jTyuGIo2PV74DGs1gdU+CYkse6NosqLjdMaNUnWPomD
         3sXNwK/qpJioy2nappMqKXpT7zvw/cXmGfYT6mfAJSwd52Itngday21Yaexu9eJe/AbR
         cfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764178210; x=1764783010;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DJcjXg1+RvjOx5A8hSzA1CiyWHl8XyDYL+rBPEwr07o=;
        b=p2osPAszzCXnHGD+2I+tRqzbjZdC6FIdHPcMKwfx7+flKXgWBSK2+KFcpqjvGtsldb
         taU9L9DNwXiINe7xHjzH7Ew1OWRoZqMUUEiu3Ouwm25NY0TuTZYmvFn+KkC4yo3DFnnu
         RCXkgIBTHZCPVXVZ24hfZ0KF6KMzTBJVNUjUH1uwSv89zzXHOw3GtT5z/6fTosxgMY/F
         fznsHdk30f0TaznVn+DBaR+M1oedkO6OBOr2IlfPy0OWN0/dP5/AKBcXVu7z2HjvqyTz
         5Op2UG7LYcSESAtOy26idXlEmkNn9OdHTEAIyj0kQUzdRX2Hu/hxvs7MxibeeayHLUuC
         gHFA==
X-Gm-Message-State: AOJu0Yz9AxIB68NNyGlf59lDpVBs9ZbmuIqQ7C9K/8hKUAZsxyRu3t7N
	xMrsdGsgQN3JAqAipLfM3Ef1ijKj4PhCMqbWNrWySztluU1WrvlhQHVtXMnIYeNnAniSLOYzS1v
	JxaauZZPtIrSoNwr31LCDFypJZweD5oQ2uA65n2t9XaqtYAONHQQqcJ2R1g==
X-Gm-Gg: ASbGncvq3FL1IFEZtUePugMV8nGVxmoaa8hpl/DjEUI5VGVD2CwiLYvewdAIS1aRZll
	ePZCk41MHKIEYsY3KGsePUWeISj8N02CrCGHkb3uBiS04ZnTqFHYyNaIJ3+uvF6EcneEGWGMEf3
	UQ6NPs193rM5jAhcL3WttuZzj133Ur+H61M0C7ebWti8fiEXNTNF3g0zcDCzJKUp0Nc/EdRkbM/
	Uxt7K22zi/2EwyEUAY+nDuxibHo/lk8zPH6fRd0TCVyDrxF9yWbHDBQpcWMKbO5gsji6AI2YHIy
	q7/tP63XygqH8hNGCV/fwwhOMsQAII1wyx7IHEf4QCglvbE2QeXXYTGZG1AmVjzs1A+4orRrjdr
	9g4uzlyNvPBVR/aK7XZPY0ehciScmatFP+g0lWIxg
X-Received: by 2002:a05:6a20:e210:b0:344:bf35:2bfa with SMTP id adf61e73a8af0-36150ef9040mr23912004637.33.1764178209831;
        Wed, 26 Nov 2025 09:30:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgCht1i3mSdLrutDTv1qMY5Sh4WT+aZBZWLtHCFnjknYdzLSmlNABUFcS+YGaiH/R40Vlr/A==
X-Received: by 2002:a05:6a20:e210:b0:344:bf35:2bfa with SMTP id adf61e73a8af0-36150ef9040mr23911960637.33.1764178209329;
        Wed, 26 Nov 2025 09:30:09 -0800 (PST)
Received: from [192.168.1.6] ([122.177.245.123])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ed892396sm22301815b3a.29.2025.11.26.09.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 09:30:08 -0800 (PST)
Message-ID: <2f0b9803-55ad-4425-85f9-60846fc4bd4e@oss.qualcomm.com>
Date: Wed, 26 Nov 2025 23:00:01 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] of: iommu-map parsing for multi-cell IOMMU
To: Robin Murphy <robin.murphy@arm.com>, will@kernel.org, joro@8bytes.org,
        robh@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        konrad.dybcio@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com,
        bod@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
        saravanak@google.com, prakash.gupta@oss.qualcomm.com,
        vikash.garodia@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <cover.1762235099.git.charan.kalla@oss.qualcomm.com>
 <0319bdf5-0a46-40fc-93f8-30d74cf6475a@arm.com>
 <351373ed-c699-4945-a978-cb35412918bc@oss.qualcomm.com>
 <e6fb7000-7aac-45b6-b4f9-c9efa2a98d57@oss.qualcomm.com>
 <5237fb86-dec6-46e3-82bc-d41f3d537e53@arm.com>
Content-Language: en-US
From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
In-Reply-To: <5237fb86-dec6-46e3-82bc-d41f3d537e53@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ei4D8LKMHPvA7DojHHyKEVTC2digO-vk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDE0MiBTYWx0ZWRfX/Dl+g+qlW6dF
 LrOVDq2U5CmelQ3lb4+PT1THs2W+iiPq3RRZgUAgdnK9dgcw8/+1SgWw7aSkRWcKzOESGVaSb62
 NQJyz3DLtK40zQwwICkbL0/y8tKFzVF0J6jcG/DY8CD9OUTNMWxhJ/jb2e2pRx3KIUXBDyoHWJO
 6ud0ddUqS2teT6dBX4euq2aLJmNiPqECayORSP5PDQ0tVu/n+lnUoqVGbfTo0vpkX2sb72R4GOk
 nc5z26MARz1yVNSvSJ6se+cnQuVD2a2Jt30HnGuznwHMwOgVxqXVNO+xNk0bKhHXcVJKz7Q9kHe
 qNmAMAy+7OAeM7JtJGvVxP3tgnd3H7/h+TSfSMQLrm/dLQUziMDy69JA70NTFHEyW8UC7+1c2fw
 bXwuX+hICsWAbsXp7atF2Cqckq6Cgw==
X-Authority-Analysis: v=2.4 cv=N5Qk1m9B c=1 sm=1 tr=0 ts=69273922 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=AKoc6KOQV6GO8V7HCDy2DQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=ItF2kG97CfwsPVWtkWwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: ei4D8LKMHPvA7DojHHyKEVTC2digO-vk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511260142

Thanks a lot Robin!!

On 11/24/2025 10:21 PM, Robin Murphy wrote:
>> ----------------------8888---------------------------------------------
>>
>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>> index a511ecf21fcd..ac005e70de7d 100644
>> --- a/drivers/iommu/of_iommu.c
>> +++ b/drivers/iommu/of_iommu.c
>> @@ -16,6 +16,7 @@
>>   #include <linux/pci.h>
>>   #include <linux/slab.h>
>>   #include <linux/fsl/mc.h>
>> +#include <linux/platform_device.h>
>>     #include "iommu-priv.h"
>>   @@ -41,6 +42,18 @@ static int of_iommu_xlate(struct device *dev,
>>       return ret;
>>   }
>>   +static int of_iommu_configure_cb(void *arg, u32 *id_out)
>> +{
>> +    struct of_phandle_args *iommu_spec =
>> +        (struct of_phandle_args *)((void *)id_out - offsetof(struct
>> of_phandle_args, args));
> 
> Not sure whether to be impressed or disgusted... If we are to take a
> callback approach then it should probably standardise on passing a full
> of_phandle_args to encode the map output. Particularly given what I've
> just noticed below...
> 
Sure... will make patches based on this...

>> +    struct device *dev = arg;
>> +    int err;
>> +
>> +    err = of_iommu_xlate(dev, iommu_spec);
>> +    of_node_put(iommu_spec->np);
>> +    return err;
>> +}
>> +
>>   static int of_iommu_configure_dev_id(struct device_node *master_np,
>>                        struct device *dev,
>>                        const u32 *id)
>> @@ -48,12 +61,10 @@ static int of_iommu_configure_dev_id(struct
>> device_node *master_np,
>>       struct of_phandle_args iommu_spec = { .args_count = 1 };
> 
> Oh dear, I totally overlooked this, and off the top of my head I'm not
> sure it's simple to fix 🙁
> 
> So it's still not actually working as intended. Oh well, I did say it
> was untested...
I assume you are talking about the .args_count here,  since of_map_id()
filling id_out, should we also pass the &args_count and let of_map_id()
fill that(with cell_count) or as you mentioned, pass the complete
of_phandle_args ?

Thanks,
Charan
