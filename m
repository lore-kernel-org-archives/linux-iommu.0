Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111192C324C
	for <iommu@lists.linux.dev>; Tue, 11 Nov 2025 14:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871150; cv=none; b=kS1NRoPzStlAuMBa4VYb+M6nfk6XUkPLejwZjylxc2OE/k6RSPD4DEdOVA9rQRsnt4f87qJk9Obo7rDIFF65iO1sfdAdBCMPz0j2ZwUsSMlgI5Mb5xAXDNaoGgF+VUR2vSuREz7YJUw6B58vHosG/QsEPai0GYV+DwKSHhrC920=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871150; c=relaxed/simple;
	bh=ZynVm5GTjJ3jV5ewXN1Dx5baeS9+v8p0cOWdmi/XlNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B62sxMDHcvKobIlkpNlNhl0mPn6cQfGsY+ndIO1qu+dqqql9u2RihJmzvb3x1Ebd9VZJT/nt9nT/X1x/h/cum37Brk34btPa4RHzJwboIwMTz0QLa8mB5HbMCFcYsUvOFBIESw9p4NW7bLdoVwGKq1iYRknvBUat+FrcICC+2Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DGgsmsp3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GWlCAJE0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DGgsmsp3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GWlCAJE0"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABBGX8w1937330
	for <iommu@lists.linux.dev>; Tue, 11 Nov 2025 14:25:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hGa7B98r9MqkGDgKlmDgrSnW42cjpgklRI/2tR3rrb0=; b=DGgsmsp3z5Kly49F
	2Hq/3japteXVdZPaeIYVZvju6RwgCftm3mwlfB5kZrBZWou2alIVyDiJ8gra/AKt
	NtpiSahSi/l9VMHGE3iqpp5/Z/mNQW4lcrVFjs0l8IB8Eo0+8fhBQBGUYJR+VO5E
	VTXGwe59agQekoRbgea8fGGod+LVAqjbQvsN7tLsxWYmq9mJ6RpOg054zekzaszX
	7oKmwQjXANhYnkw/Dix/5sc2qB6H/L8Qa6KyE/aKSFYuPecUakEW5SEf70FiMmvq
	9jl7LKoTmdduSKy3zuE+u8GXJV5aNOAFxGyBp4i2KZYpkxWRKK6eNZn9AWRurky0
	kWM9YA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abwtj9peu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 11 Nov 2025 14:25:48 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b522037281bso3158987a12.3
        for <iommu@lists.linux.dev>; Tue, 11 Nov 2025 06:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762871147; x=1763475947; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hGa7B98r9MqkGDgKlmDgrSnW42cjpgklRI/2tR3rrb0=;
        b=GWlCAJE0adNZCaGHmCuaMiXV6LcX3T1IWjh9p1dPwnWLReUhlQ0HECf1hG2408VpEI
         zfPbK9lwMQNfPL7M89TbkjMkaOX7lCF/os6JOKjYh9Id37CNFtL1ylYA/22D1jUZy3ue
         Io/6WJ6mr0pcVRijz9xlj1VEV9VG7D4imLbI6Rw3ccpvO2Ir4nB7PVwnNhbA5AarYvfF
         fEh6HPsOz78oADAOq1FelLUnXWT1N+Fj/VEcPIVPX19XPNFYWIlChL3p+0q1SqZS6h6n
         oS3OJL7lGKzNMx74IPt8YE3Pzpt+nU7VNDJ1uiaNMovn+Vci1DZZuUJbdeNP9I6rw7V7
         /LSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762871147; x=1763475947;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hGa7B98r9MqkGDgKlmDgrSnW42cjpgklRI/2tR3rrb0=;
        b=vd6y8HTGvl+1rIGcSJyeSgN0fJizzfyx7Ejpt75UeO8/LuV8FS/sD3NehRVX5XK4n4
         f07FCT5FJ3OQuhxHuMb1y4STdqGCIwQ30N5Tk2kj1hR4GeB7ngGsvKYJBK5HpDUSwAbK
         197GXZRkcWeDbKV5uXrfSa/FndzbifZ74YO78H77s1rYOHyRKYzWKRAPzINlM9mnmnNy
         XxPPu84AK+YO9phrYb2uQaXaTkCzROsQYAlk5rBrrfEb0jLUEjWmLu6eEaKDPfWvR9FZ
         DqDn08jpVAlCSB4h4S/i+e7AN5xIcaP5A5BWsX2618VaHYo0KNv6ky3vuSRgaytIXnkk
         KkaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcM0GFLfPYxpgtx0EyFnUAgNuAsAdhDQM+QoAM3h+OXSOZZJ6rVxlDXJ0TADaGUBff1S/JKQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw0uuvcIVF+FjCy5fw/Id/iFVwl1EXrSy14SJEoWS/OKQ1Hgy9O
	4OHgS6Zxk6U7LqyeBBaHdFyYtMkuwB8XrearOENFkqzjKcCjvAapYD1nPCYDpXPrhXevoASpjmw
	SlybUl9/Ue5rHwjF/5iuy6I0WZBrAqrdVFS9XntHUomb1VRjfKsAhcLjdgQ==
X-Gm-Gg: ASbGncskDodZUkfE8CZei3QcNfXy7+dw/QJqBODEC4QDYGXJwI4a1fMRzXKokhyXo7p
	KPlViHxuXe4bs+2xUuG6liO1T2/U88YCedpBCfwsUWoeJH7ull0oS7QG74ubwYvypfrx8JIwxdH
	r7LKM9lWHuZLpnzEJQ8L/YsjNAPAdX0qNfdOkj7g94JH+TtgL3x+WaY+CkBdBB6Xg7tXwFHGQ8I
	BeuMvBnZnXj9P/JtNpx81nYBZNgTUbKrr5b8JLMxQTfBzP3SLDR5dCug1wCUVTht1GOkApdD/1I
	GyXR2YpMEtXD4gXsrpXfjypGnNU6Vh8La2Gp1AI5Oumf52tuXw7AfNKq7ZMTCI5+NM0Ra93c+d/
	rR+uata1lUtf8lZZdEmq5xQ==
X-Received: by 2002:a17:902:ea0a:b0:297:c638:d7c9 with SMTP id d9443c01a7336-297e562e197mr179715525ad.13.1762871147466;
        Tue, 11 Nov 2025 06:25:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkROrZLUIRrbkgoTAgkprVjqaX7dHmwbXmMslaYaaMrgNrailMFiy5g2vGuUSJjGn5syzSxQ==
X-Received: by 2002:a17:902:ea0a:b0:297:c638:d7c9 with SMTP id d9443c01a7336-297e562e197mr179715115ad.13.1762871146970;
        Tue, 11 Nov 2025 06:25:46 -0800 (PST)
Received: from [10.206.103.12] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c740a9sm183312755ad.53.2025.11.11.06.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 06:25:46 -0800 (PST)
Message-ID: <ad372979-adab-4486-ac69-90a9df1ae512@oss.qualcomm.com>
Date: Tue, 11 Nov 2025 19:55:37 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/21] dt-bindings: display/msm/gmu: Add Adreno X2-85
 GMU
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse
 <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Connor Abbott <cwabbott0@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
References: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
 <20251110-kaana-gpu-support-v2-20-bef18acd5e94@oss.qualcomm.com>
 <20251111-magnetic-jasper-slug-3abc3e@kuoka>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20251111-magnetic-jasper-slug-3abc3e@kuoka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDExNSBTYWx0ZWRfX0+y0NC6exFx7
 u90H9JlmVaN88OVWRJ/sx5XarQl7nrkHI86i8n6yIajevp1wgorz6eAw8Q3elCSuIduyXrM8Bjn
 ei69imA5A4PuXbPdkXCWtXUSjoOBX8ctEvyNAm5kFD610bimvyf8ibaGGpI1Cm63XXfQpAKI6fw
 xTC5XaBKPRpgkxTuvurNDZWO7KNNPsdGj1+9LdN8BisZZE1Mib57gBnOzXYyfQvuGNIB0hhwcsR
 HGyLUvF9e3MrxrQR2qaufRiYdrZeWxYLLg+7Uj6C9NPmDytEjkwvm31KV8wC5Er5v+mI4FrNNfi
 l+Q5UTz60sIYgt8gUlJ0dIvXaD28c2mRdtdSz7bn7nU322T4RN1GzDRj6D+qBmn8DZmrNZQcbrO
 lS0mI3wBqQi+94zb5QdDOPJiCb3ovg==
X-Proofpoint-GUID: UAlOFA_jzcLhUyRJyfmD77RHxYL4d4i2
X-Proofpoint-ORIG-GUID: UAlOFA_jzcLhUyRJyfmD77RHxYL4d4i2
X-Authority-Analysis: v=2.4 cv=UI3Q3Sfy c=1 sm=1 tr=0 ts=6913476c cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8
 a=3RWeJ3mqlPvKrM-9dKcA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110115

On 11/11/2025 1:19 PM, Krzysztof Kozlowski wrote:
> On Mon, Nov 10, 2025 at 10:07:26PM +0530, Akhil P Oommen wrote:
>> Document Adreno X2-85 GMU found in Glymur chipsets in the
>> dt-binding specification. It is very similar to Adreno 840
>> GMU with the additional requirement of RSCC HUB clock.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
> 
> <form letter>
> This is a friendly reminder during the review process.
> 
> It looks like you received a tag and forgot to add it.
> 
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions of patchset, under or above your Signed-off-by tag, unless
> patch changed significantly (e.g. new properties added to the DT
> bindings). Tag is "received", when provided in a message replied to you
> on the mailing list. Tools like b4 can help here. However, there's no
> need to repost patches *only* to add the tags. The upstream maintainer
> will do that for tags received on the version they apply.
> 
> Please read:
> https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577
> 
> If a tag was not added on purpose, please state why and what changed.
> </form letter>
> 

I think you got confused. These are new patches I have included for
Glymur support in Rev 2 (as mentioned in the cover letter). Did you
confuse with the other patch for Kaanapali?

-Akhil.

> Best regards,
> Krzysztof
> 

