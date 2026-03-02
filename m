Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C1F30B50A
	for <iommu@lists.linux.dev>; Mon,  2 Mar 2026 08:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772440929; cv=none; b=DT2ms7WXXjcrZIAUoMNmuvc0r/l+G1Dollb9xe+MqSKHdPn9FdiJBMLuQyFODfRlIPn1Sz0HUC+CYGAI1gPjsnM5tqZ18CDsFiPJJl/jMQefXNRvKqVoK58dOrk87OXCdC7iOltWef0KnF6csVCY238eR1L5BtFiBx6Eap1F0zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772440929; c=relaxed/simple;
	bh=b7/GQlQqA57Sa/KgKkOW9sXVkTVLiqDv7U9/FioO5W0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jkDRJ2MRnm46D0nXrRGF5gb8si9bs0Iteq3lGZRcDf9oeT8a9IXc4O7x287cKw5VA40RfDIzE8culwZqvIsmSgZFpAvoSX3OnMwwJl2euBw90JChvjn5TKEZxpoOMTM+miMx/RgMpODrrPh2nhmWRawLeBSid3U1Kw3vFxHp6+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nLtkOm2A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b0q3AXyu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nLtkOm2A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b0q3AXyu"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6228HZ9f046597
	for <iommu@lists.linux.dev>; Mon, 2 Mar 2026 08:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	piXcJzMeuC1GQTW+z56AL0+ix8P0FjngV+9YFbX1rVM=; b=nLtkOm2AHu9HoX1v
	oa1xnNMoezDDTz1ISvqkk7cJbAS2xyrhLYLVIWnZA80l/l2cOkEG2/KpwDkvyB8e
	jO9I8AvstnA0YOlfbm6jKlc/BfzpNQUQhO7M8CbWaa/iIZBeku+grClltUlY1Vmq
	EJ6/mh3P31+KsvQppLQFGemEp5R+T6T9EjirlueknNDz/uN5Sn4RQbIV+FM9Pxe9
	NMh2Xtqnbbox/mLdZoK/Lgp9YfcRJXJI3/0cn9RIf2b9mRwcEszcYeBDUGaFcd79
	IYruUus9C3cl6zA4w23dEUx1wOHUIpN9YKm/kH6d1tiKBMgLjt2l8AYHTe0gX2wj
	6+eHkQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cksf6mqan-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 02 Mar 2026 08:42:07 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b6097ca315bso21575202a12.3
        for <iommu@lists.linux.dev>; Mon, 02 Mar 2026 00:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772440926; x=1773045726; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=piXcJzMeuC1GQTW+z56AL0+ix8P0FjngV+9YFbX1rVM=;
        b=b0q3AXyuVc1lHAFL06SAwNbZh3uDQpsQk3rp1F52Xc035Y6h7D2PGBou8iYGIfd1UG
         LLcdYtaTWLIzeiu/9iZEgdVKnG2lcj4rWToiFpZNWd9bthHIy79r3i+iNP6Bw6ggqMH9
         +5S1FhGCfTYVS8ccmfk7cWPJ8GpYH/sL82n/ChOEHLdrMXMQZ6MYcHIIXFgqY/kSF2TZ
         +DUIdDP5jyA5IwjxOsq9XmWjRTKSgankM87scsU9KqI0j2S1D8uueq1Cjiy3WYeUOh+1
         Ev0WOGKFKDCk0gLtZPmeRkVsBd0hOt8DNEITu9fAf6EHfGxmoqTf2p1RGamEdJ+ebZaB
         GcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772440926; x=1773045726;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=piXcJzMeuC1GQTW+z56AL0+ix8P0FjngV+9YFbX1rVM=;
        b=nkW8pHpo4qsT2GATMlpHXksWx5nnfWQVKgW4rK+gmPkkF04rAABxgumVve+PorAeWT
         b9rx5i7iq9dvjWizlF/nCfL6J8E+I7FcxYzRD3EHKIwvjsHMBBnfmcNUe00+7XoZ7p1+
         5oOR2z3P/ABD9NX+KGbwzunJA84U99LJKLnUXzoko/NX5nDq1ovstiHpPl/O8ktUlF5j
         yVnRIrVXdpRdWCk+SUtXPYaGSAUVI8ciciczhQw7kIE0khb3Wzhigre1jUoXLlvtRWB5
         e76K50eoNc4VOCMfKhsk4MbLwlUnhnUSBQ8y1/bqXGSgZyCPPiJJ4OYXlqKRRFiW9qWF
         NRvA==
X-Forwarded-Encrypted: i=1; AJvYcCWoZlt/JALY8TuUOEf2Rx1L7zedklO0s6iPpe4xyJ2x7RIGZOpxfCGLRwLAjS0zoHb02Hpyvw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzSP1X7Qta4QLfBo1nhsoW7HvXgXm6HpaLI6G61viCslSwUv4xd
	SlltnVctOttZGaABEBR+wdg31/N68Qjn/eOtxMM/xtbxBrnra+w4U1xWLIeJ2hUQDY5O4V5q3Yy
	JU5KIOIUrD18bpA9obX1qOQtOQpqb6fn3/ZBC2iY3ETFo0yYGsR2gkpIGjw==
X-Gm-Gg: ATEYQzylmPvriHA/ZjWsdrqj8azuuDHydhPOU9YoCckbWDOpV5mB5QCGd4RUkAh7R4g
	gWnWjp2FWIdjxR944fuRNerTB/b1LbhL6S7KnIQ6MPaoMkeUjTY2nPl+MxRA97nFXCNQS7/YVpL
	VjbW5CiVOhHx6Uf/nLHuPUp4N3c+xcvk5pQxvNSoZUhJO8bsXK8cFJGY5CNmZevhbQCJNHE2XKj
	W7q5Fo1KughCbtcP5QLqr820jyi90IhfCGwA8Z1NXKKDfLn5LfWCR7JnxZ3TTLxz5e6zArWN73w
	prmTWt/gG+2//rJQ5avP/yJu2jge/tz4O4YNm5U0WFvx2fjB6CBX/NI6+q++kNVEtk3AF3Yxv/e
	M6bnY8SStpF7P161nHuOk7g4hFn8QUzUMI59nkgdjQdp68tqebQ==
X-Received: by 2002:a05:6a00:2d09:b0:821:8492:7f73 with SMTP id d2e1a72fcca58-8274da7a78fmr12008597b3a.63.1772440926258;
        Mon, 02 Mar 2026 00:42:06 -0800 (PST)
X-Received: by 2002:a05:6a00:2d09:b0:821:8492:7f73 with SMTP id d2e1a72fcca58-8274da7a78fmr12008567b3a.63.1772440925746;
        Mon, 02 Mar 2026 00:42:05 -0800 (PST)
Received: from [10.206.99.28] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a01a99esm15377234b3a.47.2026.03.02.00.41.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 00:42:05 -0800 (PST)
Message-ID: <207b4008-b32e-45d0-9ebb-a32b2a5edfd1@oss.qualcomm.com>
Date: Mon, 2 Mar 2026 14:11:57 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 18/18] MAINTAINERS: Add MAINTAINERS entry for QDA
 driver
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>
References: <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
 <20260224-qda-firstpost-v1-18-fe46a9c1a046@oss.qualcomm.com>
 <zideovhb7djvsbydqmdyxbgh6cte7xc5ouhm6gsreww6klqqae@o6w6wd4tic4r>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <zideovhb7djvsbydqmdyxbgh6cte7xc5ouhm6gsreww6klqqae@o6w6wd4tic4r>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: n0oLnLssTjkRm29uWvlNVE3jsWC1z32K
X-Authority-Analysis: v=2.4 cv=JoL8bc4C c=1 sm=1 tr=0 ts=69a54d5f cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=e5mUnYsNAAAA:8 a=f53fbDee1N-zenCa03cA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA3NiBTYWx0ZWRfXyKBcmK10hql/
 O28l6LU8YjHIDtSZHxsQEZWjRm89nGSxvR3uRtVGSz90kgypJ03BCghDjRtk9XxpDkc2NMIUYGS
 BN8hZQwhaLwYEITKDYwh1PHxMUZupZXait3IW55CTYMxi5oXyYncqICN/mCvBAnZcFc5sowshZ3
 wahxUfay1odsO6EVXhfdL+g+irU6zTlUBz/saFwp3VsCV+Ho/VjCxjpE5at53eCvm/4u4ZbTLoe
 Rlqi/6hFjZAlA6k8e0flunbLvZovXfDtq0eCGJFTyiIcpr8s+WC8y/J2lvJjZbrMV3ciSBeG0vR
 LiqJYhst+f571nr2yuJDv6sYmp8SqsvT0ZUWH0tXWOpoSYxrTvEbham25RQgZ4gAv05rA3bvxAE
 6Fj3E9ZCy7+VrJ8nULDYm7pSeypGLVjtwSmE1/IUbsQ1yZWu+Vgb7VV+WVqxVO+bZG3wq5U34DO
 Ke5nIYeEhNmGvr9Osxw==
X-Proofpoint-GUID: n0oLnLssTjkRm29uWvlNVE3jsWC1z32K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603020076



On 2/24/2026 4:10 AM, Dmitry Baryshkov wrote:
> On Tue, Feb 24, 2026 at 12:39:12AM +0530, Ekansh Gupta wrote:
>> Add a new MAINTAINERS entry for the Qualcomm DSP Accelerator (QDA)
>> driver. The entry lists the primary maintainer, the linux-arm-msm and
>> dri-devel mailing lists, and covers all source files under
>> drivers/accel/qda, Documentation/accel/qda and the UAPI header
>> include/uapi/drm/qda_accel.h.
>>
>> This ensures that patches to the QDA driver and its public API are
>> tracked and routed to the appropriate reviewers as the driver is
>> integrated into the DRM accel subsystem.
> Please add it in the first patch.
ack
>
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ---
>>  MAINTAINERS | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 71f76fddebbf..78b8b82a6370 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -21691,6 +21691,15 @@ S:	Maintained
>>  F:	Documentation/devicetree/bindings/crypto/qcom-qce.yaml
>>  F:	drivers/crypto/qce/
>>  
>> +QUALCOMM DSP ACCELERATOR (QDA) DRIVER
>> +M:	Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> +L:	linux-arm-msm@vger.kernel.org
>> +L:	dri-devel@lists.freedesktop.org
>> +S:	Supported
>> +F:	Documentation/accel/qda/
>> +F:	drivers/accel/qda/
>> +F:	include/uapi/drm/qda_accel.h
>> +
>>  QUALCOMM EMAC GIGABIT ETHERNET DRIVER
>>  M:	Timur Tabi <timur@kernel.org>
>>  L:	netdev@vger.kernel.org
>>
>> -- 
>> 2.34.1
>>

