Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5518847B43A
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 11:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778843937; cv=none; b=b9KCsvq8i703vcLol3YTqZ3jZ+V65QFi2qVEtR+3l3Ek08iEAjTjjGRMwuVAtUM3gCE1L/L9C2keRbIBlc6LxtMoM7+3nTsvRoA87M9zOCii3n+qfSp78bJc6kGNcHJvYjmRCcTpPvMsRYA/z6kPy3kyFQrfJhP51CG40Qgg7qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778843937; c=relaxed/simple;
	bh=UJVYFLt+7s0EoA6/cGgIfQ4tKtgAjAXLxZYsq54yp+c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KyfpNB2+K8VrH9uXBi0IPnUGOvbC3lnraPYrj7bw/CbF5hBEdyGtUKZUN9qHDfVVzVOU0IfEA3FhGNkqwcLbY7OnieJiubGfyDLmpFxLbn1vhezZTvPm56akQtaV9ksTwdWDbEdt+CpTGldfNUN289LKeBLCghfhX97k5LmgE0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XBbZAao3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O2k+9rNj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XBbZAao3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O2k+9rNj"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FAMBOe3671009
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 11:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KCGXkWeRm3I5kdOwASc8lBJELQDGMPw3e9LMXhleB4U=; b=XBbZAao30viDbXZj
	xpKBXDPxtl8gV4AlXbfxTZ6nVwKhUCVCKCKmrGDWJraArwh8WKLIzMERe9wzhytj
	gcU/noia15CYHRUTYz4KMOWBYffz3x2Dog6OrHMxNYw2qm0fVDRpgUgsnstl34ZG
	8TroHqRVjRhS617HCfJfwzLbsgCwgEER/36Tzq2rtyCAxBDw307b1+uAcRIPoTfz
	5hms5Bn5u0r27SBl83+EiG1KT9z06Fl20bTksqImeBdT4b84SLVmUs/bq1eyZjzO
	C+OVsxYZ/15p9OTiV5JNGUA0LVw/ZBPb1FnxGequrAGfl3yBDQxyyB7ES78zdc71
	w+A/ag==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1s32j3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 11:18:55 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b7aba0af02so94375705ad.2
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 04:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778843934; x=1779448734; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KCGXkWeRm3I5kdOwASc8lBJELQDGMPw3e9LMXhleB4U=;
        b=O2k+9rNje51Ks21+C+SLSI3S+3ki0sg8mevdE5cmmFzKpTsiIyLNtJyFoG9epsBqGZ
         lyQ7G3MwPLsodPMASxewiliWi/wnD39wlVnConI/U712pLb3YXS9PLXqpycKPgqAmZqC
         Ev3eHyyoNYfK2iUcROUmWJjYxA4OTSxgv2jGMIvHMMLZRMk0gP4PrS5zPn5UBzCG29RS
         +fPl1Dt2v0B5ljSOBBY/5a+Zg9/8g8e8XVabvNdj/WsODNbvzLKLmJ+56JNaR6uHicUT
         H+XPATVXU3VxIBrM44LcyE44VX9i5wtRvzFNjGrG/R4MHX5NmgPfHEJvSmixRuy0Hld2
         /Rkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778843934; x=1779448734;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KCGXkWeRm3I5kdOwASc8lBJELQDGMPw3e9LMXhleB4U=;
        b=ekXG6kQY+aLCbLyreb94thk+5njM7gJFW5GgfD0tSlAN433tcy9N+ru3V78ktLa+iG
         dVcHnTP/jiAyyFOJVZW0Umzauyzxs/OtaMC6OMg1O5i7P1YZsth9M3QHQzUQgxjc3LFI
         /6rs3ZzDQRjp8gRBL0fPT/byyM3sIXG8qIpIWyoPT2Y5rJtZM9bcXE8tFOMcsqFsWTPX
         W/UpRak93G677J7K8UUL6QI56PiT6fd+Z5vZPKWtf7V6rjHT7UaLulkbrQlWfKI9es2Q
         adQMm6Nn1Xu2l+sXN7zFP5PFSGRN5nUY84+Qhm0MiOEcFRfRBQvmHSJ3Wp+0a16Nbr3O
         OXCQ==
X-Forwarded-Encrypted: i=1; AFNElJ/7Y1+RGdelbAbjntgO1c40mzz7sJ0DnnGENtOndAmTLFS0cDeKYaQssMhqxsOTOChZh53Pqg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9JYsG1YxswVcfbzKLquKCXOFk80anAmKr/how+oj/1gwyyPmD
	S8yBED09L0GuHLKjcbTMXPx6JRESTzIBn8FEYZr1JR3uyUIi9Z0V7jSbtczqcWjvNnqZWtgW4oK
	W9xNE8wgf6048rxk7soc2SjpbEXBcn2+p4QNDMeGuLJkkaFx0sLDoRxUx6Q==
X-Gm-Gg: Acq92OHFYV0J0ID0Agok82bZq/kEpdGwZKagNjei2MTPk4NgKbMI7BZihPhsFDRubVW
	D8PG52CQSTF3tgIMJHl0XKZAo1FznqqkEH5vmrNBcEnaCNkhZc/BeUxTY8n6+Cfr6WzOCOvk6h1
	48c3aJ/llx+37DaS7g5U86LSArlZoDGDsJ1mxeSWdKnSkhGPXt748d0oRCgcSMWnVQbjfRmPFqU
	LAdGHqzHy3QxqeJkaKQGWYkp4en9bGZp9WYEmh3SStYD0eC0jp5O2F2farNr5DVB7pJDdBDKNl8
	LH0cMzQ6uCgHJD87yZ1eGwa31lC3JFXwOYUHXV9M6giP7T+7kC1E9sOUYReftB980Vxj5UCIszI
	OxK40Gnwd+nF5tKAw0oIaLhvYEpDrgSdySqUQCltb8sfEapXmiVp1fg==
X-Received: by 2002:a17:90b:38ce:b0:365:fd4b:24f5 with SMTP id 98e67ed59e1d1-369519c513bmr3273083a91.8.1778843934513;
        Fri, 15 May 2026 04:18:54 -0700 (PDT)
X-Received: by 2002:a17:90b:38ce:b0:365:fd4b:24f5 with SMTP id 98e67ed59e1d1-369519c513bmr3273045a91.8.1778843934003;
        Fri, 15 May 2026 04:18:54 -0700 (PDT)
Received: from [10.206.105.200] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695126feabsm2470123a91.6.2026.05.15.04.18.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 04:18:53 -0700 (PDT)
Message-ID: <11c63862-5e8b-9f3a-5479-706e672879a5@oss.qualcomm.com>
Date: Fri, 15 May 2026 16:48:44 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH v5 03/14] media: iris: Fix VM count passed to firmware
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
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
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, stable@vger.kernel.org
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
 <20260509-glymur-v5-3-7fbb340c5dbd@oss.qualcomm.com>
 <zfh3hb4gowxejxeip3l24jub2z3xh26pzl5xmjhjos634c6e3u@y26yubeb7v33>
Content-Language: en-US
In-Reply-To: <zfh3hb4gowxejxeip3l24jub2z3xh26pzl5xmjhjos634c6e3u@y26yubeb7v33>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDExNCBTYWx0ZWRfXwCAfUszVfwWg
 PawfN7xbNo2j2kNRqULmBwRK6GIPG3R4ZRhJo3iDddT9eF1+1QaWdlQAH0i8ls4uL/FZvd/lIQ6
 0ClrMH5fFsfNOB+qWC2aNCLZJXo67UQtVSd+UpFZxKCsu+bvPnZkUWlI3q1aMwIrtFOzbrVSMoo
 /ctT2oXrWrThZqa670YDL5ykWqWXxL40JCsjF6Rd1qESed8FvulHiGZLeALla0C7vOudkLE7VfB
 WvpD8KeM2r869vsMy3srPIeLby9AfeyE8r6SLyRZUv6M0ntjlBhUY9nTuc7knerWSIG2jSpgl11
 d2gSwTQqjsWJF7KeDMtwXceNlw0l+nQTfYnwO8OL9oNoUl38O6bmqciGd713n5P9G1H/lsVE1rj
 r6R9gDK2i0mAdP0ewQhpPu0t422avbTA2uHaMURKuFl7gr+7qVB3HXhJYEXUbbcqs0vq9lr9FRa
 Oe9IWAxx7PeBScvIaDA==
X-Authority-Analysis: v=2.4 cv=Md5cfZ/f c=1 sm=1 tr=0 ts=6a07011f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5Xy_6AgtP5T3jK3p2aAA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: Z8febcgGaxylsvNF5fJbsLWM-3peWv0b
X-Proofpoint-ORIG-GUID: Z8febcgGaxylsvNF5fJbsLWM-3peWv0b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605150114


On 5/9/2026 12:50 AM, Dmitry Baryshkov wrote:
> On Sat, May 09, 2026 at 12:29:52AM +0530, Vishnu Reddy wrote:
>> On Glymur, firmware interprets the value written to CPU_CS_SCIACMDARG3 as
>> the number of virtual machines (VMs) and internally adds 1 to it. Writing
>> 1 causes firmware to treat it as 2 VMs. Since only one VM is required,
>> remove this write to leave the register at its reset value of 0. This does
>> not affect other platforms as only Glymur firmware uses this register,
>> earlier platform firmwares ignore it.
> The explanation is pretty suspicious. I can see this write in venus
> sources too and it was added in the initial submission, dating 2017. The
> driver targeted two platforms, MSM8916 and MSM8996, so this write
> predates Glymur pretty much.

Thank you for the historical context! I checked with the firmware team and
confirmed that this register is not read by any of the platform firmwares
currently supported in the Iris driver. Regarding MSM8916 and MSM8996, those
are not supported in the Iris driver.

>> Fixes: abf5bac63f68 ("media: iris: implement the boot sequence of the firmware")
>> Cc: stable@vger.kernel.org
>> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> ---
>>  drivers/media/platform/qcom/iris/iris_vpu_common.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
