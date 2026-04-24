Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8181D3BF666
	for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 11:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777031120; cv=none; b=KZhUlH8AnRdWP9HhAfEJlmO6d+sMMLo6Rmt8B1f5ojZCb/tC2lN+LlGQzDYPLElW7HeH60wik0k3GWhbBUrTWpq4s0et1naPEqUiq9S7PDXI0UI0REFe8HlR5MritK3yVin041vr5uZ2dMn0XVPTIZM+eXgY5hwNkS8/ZTB9gW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777031120; c=relaxed/simple;
	bh=sUwdYkQp1oZ3EzBJbnMVR1gTk663wCA8A8zZnsUbQgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kfdEnM9TyovJdyXzawLBLMdR6r2dyOXdZSOKDkDEZerFC/PofoO1cYUl8AC9O03z1VRUGCPBdOscCPeUleuZEwoZbx8hu+fF4SyWMfKx4A4/pStIjCIc/pJOgbOMXJsCnD5jZv3ZENYKr/yJptg9714sD6EtIaFsnDK4zSTqi/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KEErPifd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DZDja2Ft; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KEErPifd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DZDja2Ft"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63O8BbPN2291870
	for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 11:45:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vKD+oIXo8r5i+72tQbUpEkekMjtbIYtq2yZlf7mfgso=; b=KEErPifdYn4zic/W
	+0SI2Cxb09hK+xb2nh4J1gZerJ3aNlQnxYHaQlbgVa08VCXZ+4T54lQTHE8E487F
	cCSzG0BcBokq8YT3neEZg7zNGhuQlxJR8iVdmo92VrP6mRait0WrN0DJmPMuFfaH
	yjSA4GIed25xK5BkjbDiwWinSrGkrsqst/ZysXd0TZoXuXNBO0hKyZxC9t1JcGL/
	OEQxmiKBTTihMWypvZa9l+Be22bVLesE2xCwtkcIokiB0+B+CY5Y2piY9RdblTSI
	GGmX0WB879Um7NO/Q+CnSgas3JjafGv3s2uw0iEA27A59O2a5BNOU8pikUrxggCf
	QzzUEA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqxbpactq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 11:45:16 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82f74f0e3c6so4981330b3a.0
        for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 04:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777031116; x=1777635916; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vKD+oIXo8r5i+72tQbUpEkekMjtbIYtq2yZlf7mfgso=;
        b=DZDja2FtRfkyYCPauMrAbkqKv7Q7Lc5rkSc9BLbdAPFw0br2J0Pw64Q+ZAh07pdMnH
         3mNeT37O1i1xkUEGy05yKC/+H9pz1mfe8rwoHPJAC7/66KCYItgQQBsNhS7d07gRtI7W
         bNwmrUcZIE6zpcw4sRE7tfYPNSQG0kTlN7v4jlLOus3B3sBvkQCvFu1CvoluXghTUSYo
         6EiWQnCl5HviDtGgIJib5PCquo4oHB2QNTBWLDI9LTqs6fQRIeqIMeqvxyEk38MVmamE
         401KNpXuBK4mu3j52lIFOw8ypk3QQ0gxTdtClaLqyX/TBakNXCVT2inGjqS3ut92tDJW
         UhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777031116; x=1777635916;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vKD+oIXo8r5i+72tQbUpEkekMjtbIYtq2yZlf7mfgso=;
        b=fhIfVPoyQaN5BBYL4Aa0RPRqVTuEKLl+S8AqvENkkhQIyVOYpopWWjEk9MTzt4oJ7G
         V49wOSG8D1Y7LkHO3phgfZeS3HCS1FFLU8m5ROYwYn3kq8gvIK3oNQBbCPcW3ugE24lS
         E4m2HoWgOEn7JwXSlaTD96HsmemoztcJzKWw9MiAGdvt7bRGb1dP8O4mcwhfgMAQL5Fa
         rOwMkGb53PoOjuiUwxCInq8IFDi7M7dIu+xFfeBSJx/IVbOmVm2icWNAbXFFNHvX04CT
         mul0S3VpXLRvoTF+Iotzqu+oin47xOev3UCsrRGKFqttFjZAu9noI1l16xZX97WB7V7A
         6xgg==
X-Forwarded-Encrypted: i=1; AFNElJ/th0p+l8LLhGH4q/XsIutEIx8DRcvivFof27eNipPol5mC2RiCzAmcLMPqh/A4Yi4OuUdl+A==@lists.linux.dev
X-Gm-Message-State: AOJu0YymOz+QKPQko/4DjGpQtz4A8CrcShweNIrcamfrJ409Tk92JKd8
	ozC5MjMym3bMcPOV9Gd+Gi3B0Ji6+4gNQhsZKSodCJXhC1+078rxqkZopSJU+6b2Ikaax9Chfyu
	AndA1yHXScCgGHmPUyqovyorAuNzp++YMms5FaSEtAFAX/Dd8RrLDSEf2IQ==
X-Gm-Gg: AeBDietu/KoFPKH4VFS2LIzSR4p6IhvBxL3ZBGsCRlWOiPm/jLAkw5hlL9zDjryEn6W
	99XPlNN+IBDod7QOW0hOP7vkjWEYEsMBZQww+wOmZqSPMrus3oGP2ynSSCdXQ94ZRQ0yZT/ccCt
	xGBwk+roYH0b8GSzJIn7MJ+HelRXGL3mtE9xPkyEpgIwO2XZtzu8pS+0sPthArFEei59DLYKQP3
	EIRN8pmovbffuZgUfr6DZfCNtB7JU9wODzVrNEbyElP0WLUujgREnrYCRCe8DXZLkbw355RSaXN
	uc5FcG+yNezcwrjj7+LdECdxRvNmjKUAtVwjndtidZp3x150RQQli1GU0l/ATRVunULVux/r48E
	7kIM9XJXRDXiaGnhIay59JLBuIO34c0dkKv278QO01g6ZNZ7b7E+MBDJ5qDmCrmvT
X-Received: by 2002:a05:6a00:27a8:b0:82f:18fa:1668 with SMTP id d2e1a72fcca58-82f8c91e3cbmr31091206b3a.44.1777031115611;
        Fri, 24 Apr 2026 04:45:15 -0700 (PDT)
X-Received: by 2002:a05:6a00:27a8:b0:82f:18fa:1668 with SMTP id d2e1a72fcca58-82f8c91e3cbmr31091150b3a.44.1777031115048;
        Fri, 24 Apr 2026 04:45:15 -0700 (PDT)
Received: from [10.239.60.18] ([106.192.26.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ec04448sm27904931b3a.55.2026.04.24.04.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 04:45:14 -0700 (PDT)
Message-ID: <4c3fa710-f61a-4aad-622d-54909190cb9e@oss.qualcomm.com>
Date: Fri, 24 Apr 2026 17:15:02 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 02/13] drivers: base: Add generic dma context bus
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bryan O'Donoghue <bod@kernel.org>,
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
        Hans Verkuil <hverkuil@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Thierry Reding <thierry.reding@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org,
        Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com>
 <20260423-glymur-v2-2-0296bccb9f4e@oss.qualcomm.com>
 <2026042346-trustable-register-095a@gregkh>
 <06c04947-e72e-679b-493b-e112d693f391@oss.qualcomm.com>
 <2026042422-deem-chemist-8d0f@gregkh>
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <2026042422-deem-chemist-8d0f@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: T9sKgk3PG20gNlm3bWyMdm1un6AOqe_Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDExMiBTYWx0ZWRfXyWCAeG+3JBoh
 lZrfXbvpYXTG8Dhtrr+5dMciwrLYMxOopuXE4C8xq8oV9aufbWux6s3acESGbWpTUgNOFZmA7+R
 y082yo9eiEHPMHcChmn5mY8ePSDfR+T0WG2ZXGeFzsLNTRfrw7JUyGI7oPWXgfKFmoA8S+PAdPi
 +EzQQPQBQcjEFJ5dQ+yF6/+ehnWg7wUJMHi5UxSXPTpKCW1xQmsAe+TfYiQhySMPGM5hOCnAMmr
 bHE0Jk7+3vzpZ20rrmZdcN+Yk+cl9KvBi7CDE30kxYBpPnnXTEZouLiitfm0keaYKn5QIw5kVR+
 dlsptJvcQV6Hgzx5YG0Sn7+cm5xd7ElbilgLwVfQvrBNbNOyDL2b2dmtKOCjNxOdEh/xwyFO/BV
 gOQP3i/d8+mzunesVnYBLSyxf9B5ES2k45z7hXaxLvvx+s3b3SR+53tvpuBgO8Qo2uhTgpJcTIo
 0m56aqtvj6OpwhtIZEQ==
X-Proofpoint-ORIG-GUID: T9sKgk3PG20gNlm3bWyMdm1un6AOqe_Y
X-Authority-Analysis: v=2.4 cv=X+li7mTe c=1 sm=1 tr=0 ts=69eb57cc cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=K3jt3zD9TrcZs+Uyli2v9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=qtrQGJdHBaugJqU6AYUA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240112


On 4/24/2026 4:43 PM, Greg Kroah-Hartman wrote:
> On Fri, Apr 24, 2026 at 04:01:13PM +0530, Vishnu Reddy wrote:
>> On 4/23/2026 7:07 PM, Greg Kroah-Hartman wrote:
>>> On Thu, Apr 23, 2026 at 06:59:31PM +0530, Vishnu Reddy wrote:
>>>> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>>>>
>>>> When a driver needs to create virtual device at runtime and map it to
>>>> an IOMMU context for memory isolation, there is no common bus available
>>>> for this purpose. Each driver ends up implementing its own bus type,
>>>> leading to duplicated logic across multiple drivers.
>>>>
>>>> host1x driver implemented its own bus type to attach an IOMMU context to
>>>> a dynamically created device. The Iris VPU driver now has the same
>>>> requirement. Rather than duplicating the same bus logic again, a shared
>>>> bus type is introduced under drivers/base that multiple drivers can use
>>>> directly.
>>>>
>>>> The bus takes care of creating a device and attaching the IOMMU context
>>>> to it based on the client inputs.
>>>>
>>>> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>>>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>>>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>>>> ---
>>>>  drivers/base/Kconfig            |  3 ++
>>>>  drivers/base/Makefile           |  1 +
>>>>  drivers/base/dma_context_bus.c  | 77 +++++++++++++++++++++++++++++++++++++++++
>>>>  include/linux/dma_context_bus.h | 26 ++++++++++++++
>>>>  4 files changed, 107 insertions(+)
>>> as you can not have a device on multiple busses at the same time, this
>>> makes no sense to me at all.  "dma context" is a bus-specific thing, so
>>> please add it to the bus that you are wanting it for.  It can't be a
>>> generic bus as that just doesn't work.
>>>
>>> Or what am I missing here?
>>>
>>> And why is DMA somehow "special" here from any other hardware attribute?
>> Let me give brief information which was discussed, in the initial series,
>> the iris VPU used platform bus for dynamically created devices and we got
>> the comment/suggestion from Robin to implement a proper bus_type with a
>> .dma_configure callback.
>>
>> https://lore.kernel.org/all/02b3d0f5-f94c-43cd-93af-97cfcf7751b1@arm.com/
>>
>> based on the discussion, implemented the dma_context_bus and used for iris
>> VPU devices instead of platform bus.
> Why not make a irus_vpu_bus where you can do what you want?
Initially iris_vpu_bus was introduced, and it was made generic based on the
discussion,

https://lore.kernel.org/all/20260227-kaanapali-iris-v2-3-850043ac3933@oss.qualcomm.com/
>> Here, the device have only one bus (dma_context_bus), not multiple buses.
>>
>> Regarding the "DMA" naming, the core operation of this bus is its
>> .dma_configure callback, which calls of_dma_configure_id() to map the device
>> to a corresponding IOMMU stream ID. The name "dma_context" reflects this
>> purpose.
>>
>> I am open to suggestions from you or Robin or anyone else, if there is a
>> better or preferred way to achieve this, I am happy to consider it and
>> rework the implementation accordingly.
> As there is only one user, just make this your own bus please and do all
> of the needed bus operations for your devices there (i.e. don't hang an
> "empty" device off of it.)
The reasoning behind to make it generic was to have more users - host1x,
Iris VPU, QDA on the generic context bus, instead of each of them having
their own. Let me know if you suggest to have the iris_vpu_bus.

QDA -
https://lore.kernel.org/all/20260224-qda-firstpost-v1-4-fe46a9c1a046@oss.qualcomm.com/
Iris VPU -
https://lore.kernel.org/all/20260227-kaanapali-iris-v2-3-850043ac3933@oss.qualcomm.com/
> thanks,
>
> greg k-h
