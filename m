Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFB82BE7C0
	for <iommu@lists.linux.dev>; Mon,  2 Feb 2026 10:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770029804; cv=none; b=ShBXRcZ6BLOxkW/gnZm5w0jAR9bT4UoWoaDy7SbvreJQawbEfWFEKd3ios8snNkwKDABox4h3EiIh30m4DnNpNoGVwkMwH9phQHb0KgGt2IN0rxI3O2aA8e3t6EmL09+rPjcuBHulvh2JTYgAsNWZyoSXw0PV8xrFx6sEQ5aniw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770029804; c=relaxed/simple;
	bh=q66RPD2oOJwfCVDjgotrvDTzNwrnipJAVBK9XKsirOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cYvXptBiMomvnlTPrvLuV+svCLurapFH+aFhVRSysNUIOmTC4/Nhnrt3fDUNxXXfl5z3iIrfx+IqHh3SxA0xoUcFM6O+Wi4O++voI/CQm4+URbett3PW5Et+GGlKJS9snkUcIFIn8wWNZw1lvvICXM7VxGyQxg4xf/tcLGDrIjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UlSP/4XY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R1bEgo5W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UlSP/4XY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R1bEgo5W"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61284Tob1997319
	for <iommu@lists.linux.dev>; Mon, 2 Feb 2026 10:56:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7w2p63ZPTwKUNcs0zkPpFjjBdO4n5Is3TFmtV2iGM3w=; b=UlSP/4XYPoQ9fx5v
	0AvNG533wA+WA3Ye78zPpERxE0ShGNyad7qnrA/W0pFr5MEUVzvMsoitzhRfbL27
	NcpUEq7sczlohdSbVIfOLo1qWNtbz5egH+csgU+5kRBNmEmOX30WMvsdhxIgHCwC
	9JvEP5U6edT2Erure7Jlcjcri1knST/85JNU565yFeaONVSY0rOcYHbkqUD4kEKh
	n4bhfwFO8/42oC0zhn47geVyi/kAn6Fo2HQyaiD6bqQ0exR7EILFEE13JRjxp3FN
	g8y0uro5E7Vua7cEO4epR5jahs99y3TqNeeG5s7oPDNGjs0BOq1sCENFDD2SedGT
	0Jbclw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1avnn5c3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 02 Feb 2026 10:56:41 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a7b7f04a11so116402145ad.3
        for <iommu@lists.linux.dev>; Mon, 02 Feb 2026 02:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770029801; x=1770634601; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7w2p63ZPTwKUNcs0zkPpFjjBdO4n5Is3TFmtV2iGM3w=;
        b=R1bEgo5WlL4Fbqm2AH5WNULb0mzwOAONtj2bsnDtxznrqJrCJFe7tgP2ig+9xdLqO6
         dbdxfxxr/wjSY0A8DNwHHKfXOOJ9NtX2fIiomDNyZ8J83OJPAmzOsQAdFwl/QWlW84Yb
         1CQTi6Bx8M67BhTaX95q+zzTgBF+zupmX3agAn1zvh2uv7igF9ZY8HlVFz7HLnz8wW0I
         DK3mpU0mIo37b6jSIoV8bpFzP/nqnIb5qtavhGjdGapySl3t2crs+6Odb1fctLmDq965
         LDto52h/5VwH4eW9r+VlSaLeYeGyR6G0oZuqL9zkbGW9UXEtORZHU5ALx3ADaZl1itzQ
         luyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770029801; x=1770634601;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7w2p63ZPTwKUNcs0zkPpFjjBdO4n5Is3TFmtV2iGM3w=;
        b=v/yRw53qpkVE14XJRBgcZawxMDbi4QqbDXkg07PQ/fQmsdCKOJLcgIt/aGk0dMajD4
         jXtRdryQy0kCSWX/KoXffnJR48oVIjHiTTDyc6WhBpK5CCgvsx9mH0we1hVQeO/Uoy4n
         q2OV6tavqpxzg1xXQsHiHq+BDPVK9v874un5H+SP4ySc02WnP1Xxqxg7ZIJXitRwAWuf
         zJthc/QIOzw6plWylAX1qu+mUzFwFByINTIlQJjMhWj4UxZ1yGYLyIgmmN1edypa1qyc
         476zk9gJvLZT3RyPgBpBwAH9kg5MZZBqV1D1xzWDHmkqzg2NknCczKSYuKFuODtdOR2e
         U0yA==
X-Forwarded-Encrypted: i=1; AJvYcCVdB58F4TBbXySkxXo+xox17LUgUYeIjZIGQrrmtxtnqC6pj4gxPCyun1kg9FDoFneK5VO7UA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/t0tsF6g2N+7gZG7GWIWC9WtDHT7RUM4P/CLUgCEqiQZH8Exk
	s9tTqOOBZcN0zbHVP0YJsi+gDzD9VMHdByfudsbf5lMDMuaqqBgdeg/swXARY7rY87cXcrxae0H
	1//HOpK9O/Smk9A19Q1dApC4SLfiZkyg474qgYYroETOAl5DeoFhqUNN5Hw==
X-Gm-Gg: AZuq6aJ5YPaYggQ5kx0wRBjszExFeEGCKRrQ8NCwH2oRXrB2lWxB2BZYhvhNC6ShJEy
	8pdlzZ9GpFzP/LVK10gTa/lrCyRinTR8I5bkfuXauMs1yWDtQfIVWkcvARVal0GwV0Nh+Y1ucPB
	+l3FvuzM6GpY4hh+QFyuHy6ycCvgNDLlwy+D9N8FrAHMpvK1q5bb1YCtSrRZveTAsN/PQ9Zesq9
	NwnqTU3AzkCGnvF4G8odffwlUckrpjlVJGhpjPR3OpLTFX+hMU7xIHHemzdJnodemaAolMio/oI
	J3td4nakaVL/E3orUX8rPqzxUTi3gEZ/nPI14FfI/SNtf4eCRDBHGO4M08GEL90UC2jFs/PRk61
	WS2VwQ114yH7Uy+qSIZmjD7fskf0iRRbvunxC8VfTkO9/
X-Received: by 2002:a17:902:f78f:b0:2a9:410:2400 with SMTP id d9443c01a7336-2a90410270amr48497865ad.28.1770029801018;
        Mon, 02 Feb 2026 02:56:41 -0800 (PST)
X-Received: by 2002:a17:902:f78f:b0:2a9:410:2400 with SMTP id d9443c01a7336-2a90410270amr48497625ad.28.1770029800618;
        Mon, 02 Feb 2026 02:56:40 -0800 (PST)
Received: from [10.219.57.109] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b41390bsm141408555ad.23.2026.02.02.02.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 02:56:40 -0800 (PST)
Message-ID: <10ea031e-b803-4a4d-a0fb-c18a34b37e47@oss.qualcomm.com>
Date: Mon, 2 Feb 2026 16:26:32 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] of/iommu: add multi-map support
To: Robin Murphy <robin.murphy@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
References: <20260126-kaanapali-iris-v1-0-e2646246bfc1@oss.qualcomm.com>
 <20260126-kaanapali-iris-v1-3-e2646246bfc1@oss.qualcomm.com>
 <hunwsdkmeo6efpv3yt3izkgmarelnubd74dywj3scryxrreq6p@njijwtoyjh46>
 <78ffd1ce-5408-4bf5-a782-0c4ca14017b1@arm.com>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <78ffd1ce-5408-4bf5-a782-0c4ca14017b1@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 2mG7_4X_hbe2b-TecB6Nr5AreQK7KDgg
X-Authority-Analysis: v=2.4 cv=bPMb4f+Z c=1 sm=1 tr=0 ts=698082e9 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=dOfmg-3FkkVntAroJ4EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: 2mG7_4X_hbe2b-TecB6Nr5AreQK7KDgg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA4OCBTYWx0ZWRfX2OKSSznkG0XO
 qZVwe/vxjf/spVA9LmPs9HNu3da1S+3WhcDy3FJP0M5MJV3D9kDSYn1u6r70/Zk2aGDYbkpTU3g
 ubmUycAbCF2X+rH8EKqz7iSWwk9IGK8GltD1VvoEQWZ95zyo2H7agFUcBGtEMN62fGxkGKYgAA/
 EmNdaLnjzW/j4ag/qz5bTW9b9uNoaICoXKCMjGldnt28Xsmb5oa2SArcNxJH1I0uyQRTfs4YWcQ
 nAlKs0pk/HdRTxgGLjIvytLGSt9DCH26aw816gxVbhht9DMfCOCpqyHMTiJtHksVRMWWqLwvX48
 A9FC4MT3S1uPyHS5RSqbbPCqHyueJD+TRIWzEEwwWgqk+iHRMFvAy2XQHALbj67v+D9qfotcNfy
 lznaN0ix7gxpTUDcG88a/V+iRYs34MSPGVwjhCmth/XMWMTSJBi3Txt0WXs+GIfeMTndemoMfyZ
 0W/+kE5cOyNi7C7CmJQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_03,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602020088



On 1/27/2026 7:50 PM, Robin Murphy wrote:
> On 2026-01-27 11:45 am, Dmitry Baryshkov wrote:
>> On Mon, Jan 26, 2026 at 05:55:46PM +0530, Vikash Garodia wrote:
>>> From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
>>>
>>> When multiple mappings are present for an input id, linux matches just
>>> the first one. There is a usecase[1] where all the mappings are to be
>>> maintained in parallel for an iommu-map entry of a same input id.
>>
>> This contradicts the IOMMU idealogy (at least as far as I understood it
>> fom the maintainers): the device (driver) doesn't control which IOMMUs
>> are getting used. Instead _all_ defined entries should get used. For
>> iommu-map it means that if the map defines several entries for a single
>> function, then all entries should always get mapped.
> 
> Indeed there is no concept of "multi-map" - if a single input ID represents more than one thing then that notion of "input ID" is fundamentally wrong. A single *device* may have multiple IDs, as in the case of PCI bridge aliasing, but in that case there are multiple things to map.
> 

vpu hardware do have video decode and encode usecases that would generate multiple Stream ID's.
So, all these Stream ID's would need to be represented using single input id as mentioned
in dt binding.

Referring patch [1/7] in this series

iommu-map = <0x100 &apps_smmu 0x1940 0x0 0x1>,
            <0x100 &apps_smmu 0x1a20 0x0 0x1>,
	    <0x100 &apps_smmu 0x1944 0x0 0x1>;
		
Here, IRIS_CB_NON_SECURE_NON_PIXEL [1] is the input id.

enum iris_iommu_map_function_id {
  IRIS_CB_NON_SECURE_NON_PIXEL  = 0x100,

[1] https://lore.kernel.org/all/20260126-kaanapali-iris-v1-5-e2646246bfc1@oss.qualcomm.com/ 

Thanks,
Vijay

> Thanks,
> Robin.

