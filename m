Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED51E40B6D2
	for <iommu@lists.linux.dev>; Thu, 22 Jan 2026 11:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769080956; cv=none; b=XksRyd6aUhw87Y/pobbPMxtNTk5a9FFKUbQQ3rvGi9RGk6O/aa2qB/3KNlJ/yBfCUDoiQhN1/dujR2S9SKGqz1liICHAKfHyFtHB1hXrJr972afr2qHYQ1wcn6apvcwJacSPLSuV9UxCmP2hdhKyubCPN1Hf6raAitXerwu6d2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769080956; c=relaxed/simple;
	bh=AonAwppZY+pmOaM85y2+m/hUHR4TTPWbi5lYkG1NrGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qa8DnHE6bRNYR99K9v18N9Hq9+RrvTy7GTRUThRKZEKkl01oACGw+8nw0Wt0pV83MM1oZEMSL2tfIAfYjKqXZ/z4shnqy3obC9XqiVgDruetK4OgcI4ItPw1I5vdytN+rUYtDExjmO9RazYYzXag8vv3BSm8tftEbAVmwiB06/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hoHzaE0d; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g8G5FYH2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hoHzaE0d";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g8G5FYH2"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M7n6t8107348
	for <iommu@lists.linux.dev>; Thu, 22 Jan 2026 11:22:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sT7Nth9tTPT+v5Mske4oo0KiXy0HY6fe5ia6z73pBbw=; b=hoHzaE0dFfoPb48/
	Kx8F17/AibFC6vyMzCPCV//vIzXKnSzAH6neHGGyUMqXfh1HS6KKYs2+21az1GAz
	7zrgmnbHt8cOuy2mgjBprMN0hWABpzSWZxXfKzfFPXHcC6AWlFkCrYM3RAHP0u6p
	4yBR27l6LdJizJ9MM16vCZB+mkZ5tmAd/tIQ4Q29fjdPzf4xaFAt9qc8VJx3TQjX
	Jcju3hR9Z88Ky75aEZuP69EXCFI6AWYV07J+EFu1ix1rKdvKZU2o/PFi1OIhr0YL
	XIcz4kkYvF8Yh4k7XiRxJLRbgWmXlTFGSZ1B9ahd6TmixRaADCkjtrHgqT6+D5Q3
	jtthGA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bu6pgt7qp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 22 Jan 2026 11:22:31 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29f1f79d6afso9414515ad.0
        for <iommu@lists.linux.dev>; Thu, 22 Jan 2026 03:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769080951; x=1769685751; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sT7Nth9tTPT+v5Mske4oo0KiXy0HY6fe5ia6z73pBbw=;
        b=g8G5FYH2IogOeG54XAcICZn8OGGv15hB1WBCjwmKoRQ+1eYd+xSUUTHsg8YQ+t2Hh6
         HV571bWWZqCUtR3W/HOD3AolbyovDVdQv1HPU97Vq3K93G1v5VoFi1WPHtTIfPhkrA8A
         VvZBvVF7iG9mTXVrgtaVdz3c7MbcgdlrzgvkaaQjEISKQDKBoSFESHOmzpUkzXCunOoC
         aw2+WFhwYV8oKDlHomURZx9hgJUk9l96/slxPxVzfCyJRoPH3tD97H9DpI0OtNliTqUx
         Us3lVFU7sBmX/a4vFCXSNEgAKqWg6SsPvQ9FbRK9JDyYSY5ni29jDpeobIeseh6ASJmC
         JCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769080951; x=1769685751;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sT7Nth9tTPT+v5Mske4oo0KiXy0HY6fe5ia6z73pBbw=;
        b=T0dCiKJbW3f5M384YmfkOnLML7ziwb8Ww5zzvw/nmCiE1l+QyYlNJnkmzoHX97mrm2
         HjU6XI36MnISc3mE6HkmSk8kOfWwMqDqJ0P44ECyNWuLRWRoTxDKusgqszjvD2buNJPp
         VGF3jzef0I+Q22JPjkS0CRWebdj/Wsi+LlYMzUFhNTzuboDeJ5JIZmFv2CaJZcRLPB/W
         bmNUqL6HSHzQZnOjsC4jgp6Xm+ia1vfpo7E/R6G8nzCpUxi0sMFH3sfYEFGR7M4dk6OS
         PYojVjY1B8e2pW/HqZBwmctTym6lqr7ykWC0GzudcAlBk205qHMU7QkQadqQxKNZjuiG
         bPyw==
X-Forwarded-Encrypted: i=1; AJvYcCUSRhokhh4E2w3NaniRwVzrtZo3wgbZ7/rZrbhzv4aiw2sJejsY4tMzKJpLNzFyuOJT5mVhdw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyhsYAYbBCAumKhU5AsmHCVqSfZNOkJfjZSDURD+np7HQ1xfOmS
	JOZBLlfLGC9uNXwQ4wZaScv3oXQL13upxcUh7bWzcW4JMcTLo0ZN/GhxfpzqgtTaaH0Wju4rnD1
	0BCjOpzW3uyKpi6OIGG1OBxhFPQyEFbuniq4l3FIGog6tSVSUXyEg8oRE0w==
X-Gm-Gg: AZuq6aKh5kUMBgP8NrIiPZq954DbOzDQmWuXvkyv5UrdYsJ8Ki5iIqBxC9re1cG5mww
	E/OWI7ltL147V2AyTu1KG+qjxBRB4Wu6mwnndGZ2yXFqNtxnpM2clUFZNDoLBq+6boRUdQh8HP0
	M1jBX633JTb9iDB1jclb9CbxqaAS0wmBnRSQGgZJX1+7fVOaWkukKjZity2o03i8z6vovXnhtwv
	LAftC1pKeb8Pviiwud7+qXhzWh8lIj0iOhKYYlEY9JMq/wP/bfSI9f5B8aXXBr6woqF6R9CmNb/
	/Hpx8QO3cWxG0g5VULA/zz3Yzi31lUrrjnG07pPEDpqowALjky3ZOpuZx8g4RbDvz+HBYUwEiQ4
	BOlNLyLBQRdkfw9xh1VFdYT22zdo8cAqZgPFO
X-Received: by 2002:a17:903:2bce:b0:29e:c2dd:85ea with SMTP id d9443c01a7336-2a71885a283mr200620955ad.11.1769080950632;
        Thu, 22 Jan 2026 03:22:30 -0800 (PST)
X-Received: by 2002:a17:903:2bce:b0:29e:c2dd:85ea with SMTP id d9443c01a7336-2a71885a283mr200620585ad.11.1769080950109;
        Thu, 22 Jan 2026 03:22:30 -0800 (PST)
Received: from [10.219.57.14] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193df75bsm164936365ad.54.2026.01.22.03.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 03:22:29 -0800 (PST)
Message-ID: <5a8fc32f-0a4d-4b76-8093-faf9207a4938@oss.qualcomm.com>
Date: Thu, 22 Jan 2026 16:52:10 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Restore ACTLR settings for MDSS on
 sa8775p
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: will@kernel.org, catalin.marinas@arm.com, charan.kalla@oss.qualcomm.com,
        iommu@lists.linux.dev, joro@8bytes.org, kernel-team@android.com,
        konrad.dybcio@oss.qualcomm.com, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robin.clark@oss.qualcomm.com, robin.murphy@arm.com
References: <20260120151105.614792-1-bibek.patro@oss.qualcomm.com>
 <ctdfmzictrjcwugv66hmk5pouj56qviy5umdo3yrmhvfexqoni@kmtozbt53sdv>
Content-Language: en-US
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
In-Reply-To: <ctdfmzictrjcwugv66hmk5pouj56qviy5umdo3yrmhvfexqoni@kmtozbt53sdv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA4MiBTYWx0ZWRfX9dw2mfsYvaY1
 mP16LLGwSLvOj2tL3cheUxd9kMCMQi8ehgsuud7CnCBAFDkAsTYkCtUUYjK+Wj+mfr8EbyO8m0c
 KP2OdqD5uKXEj7G8xweeWES+Im0FKSGCMhLHCNQfYXUfWMHVATcUH7JS8VbPm/qPxDyqOQxzJ3j
 1+DBvq6+kfotquyJxlfwY7aXgQfkoSyM4ou0im0jWb+HotguZVgaTvpTmCox+qLOVNUm3DNFNSj
 Lg25QiLWdsial+kprj/WYOwlDvNqDkQ9krHrvWpn0HmLn2m6T5ZkA7em6noSrdaFF4SKnyPioDr
 iwZ1pXWsAflcmarffa2f6QJm0VWdNRdN199lWmV22VGEynX8zlB3HyAMEOO8y16jGitmgd0QobH
 MUqlkUzdAgL7LzfGPduNs/fbipCBfZUdG/rvjtBLzfIAwjJACsGIlcu3Mn101T0JmPUNlhDcFXh
 dLJB4wySjWsU/R49k2g==
X-Authority-Analysis: v=2.4 cv=OZGVzxTY c=1 sm=1 tr=0 ts=69720877 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=90QGV6kl6MXzLp6kim4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: iq5l0SjslnvwILuRWTkICWlWPSKJW09b
X-Proofpoint-GUID: iq5l0SjslnvwILuRWTkICWlWPSKJW09b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601220082



On 1/21/2026 3:56 AM, Dmitry Baryshkov wrote:
> On Tue, Jan 20, 2026 at 08:41:05PM +0530, bibek.patro@oss.qualcomm.com wrote:
>> From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>>
>> The ACTLR configuration for the sa8775p MDSS client was inadvertently
>> dropped while reworking the commit f91879fdf70b ("iommu/arm-smmu-qcom:
>> Add actlr settings for mdss on Qualcomm platforms"). Without this
>> entry, the sa8775p MDSS block does not receive the intended default
>> ACTLR configuration.
>>
>> Restore the missing compatible entry so that the platform receives the
>> expected behavior.
>>
>> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> 
> Missing Fixes tag. Otherwise LGTM

It looks like [1] hasn’t landed on any release branch yet - it’s still
only present in Will’s tree, which is also where the referenced “fixed
‘commit f91879fdf70b’” SHA was taken from.
Given that, do we need a Fixes: tag in this case? and should it use the
same SHA from Will’s tree.

[1]:
https://lore.kernel.org/all/176764799410.1451727.17568755330994660848.b4-ty@kernel.org/

Thanks & regards,
Bibek

> 

