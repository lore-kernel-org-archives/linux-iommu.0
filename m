Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB0943B6ED
	for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 10:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787825641; cv=none; b=Xf9u3ILkVhLwaTP5lQA4q0H56biSph2H0aPmsLBw6fUlGNekBX7Xc1Kmndt5uwkbIlUqllOmytNFj0XjlbFLwZXxjiQPwBUFPGO3Yfkz1lEB2Pf+zRrwgjwBeUuGLJkNB6ZPbpZ9UbzJLG0veMA3dykoy/U1miANK5ZPUyXW1OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787825641; c=relaxed/simple;
	bh=bCAmFmW4eH9KsywosXlTGHx0uzAhktmc2BCUJbmrHY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jrf1mjth53VEHGOjRHtQ5KTKUpe8QHyRpODQ7+TioG8s24e0exg6Hs5Ncb92fEaQV9rnViLeeqDv6kyArBDzLuVx1IpHPGWv6kB3SDQFEmvjr9jRbPCmU/MOGGuKpoyqzFjLHuRszK2T7TdHwL0elFfxXCl7u0v7krcT6X7teBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SxU74tfD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HzRCWLVV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SxU74tfD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HzRCWLVV"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RA3MCa3525831
	for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 10:13:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	08PVDrdFiMsGhuzXt0QxvkpAr/fHXOjfdnZ42eGdeSY=; b=SxU74tfDR7Ldyy+I
	Woc/VI34LT2Cx9PectxKNWYLzMfjWRo2D5JcC0br7wev4WnqZkDrjqIOiF5VgvF+
	N3WB57cWfG16U1Gi4L4PfVexpUA+7GJpXmkfkvV9CtWPjLpzse6ke/HOAtqrl51u
	L1UnFf3nQjVaIEPCSwaFB/YIwifS+Aqqk6ZgV+UyBtmKUIYwxH5Is8kRM6NvdAJ3
	T8Zol4RMD3dCxOz/LXlmQYy2+b+W7NElEAHF9/0F2ZtRiNo877zfaVzH/jLykgBD
	srQXNHo033NhhsHOy+LzjmLnaIKLBnODyUn5tAmsQvPgmc/TIA3cv0W4nc7R0hwO
	RVrO8A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gak56017w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 10:13:52 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3950b1371a7so1026820a91.2
        for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 03:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787825632; x=1788430432; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=08PVDrdFiMsGhuzXt0QxvkpAr/fHXOjfdnZ42eGdeSY=;
        b=HzRCWLVVNLq+e9MNyOx4tcy7QqV2NxZJH0QKDh6OMHq9A8CsbSvdBfvwWdl1f6E9fp
         RSFmfBfoEcME5+K4iOHwm1xabHbQJzrhxarTFIoa5pw7pWAyQ30cInXnngn0RCubXeDw
         nSBGJ4rD+f0waYbv7OoSfVeGaRrwSRc8U4gy0PVwCzdli0Qdvd6UFp4jEY08+j3RpMVz
         K/PPzsWyxsHsjXAIp9DAyx5vzufGepcTdzhc0FwDqrhF4lCkYRsU4OgsQ9pEVGgwED/c
         x6THX+7F7/GzNB60oBrQdDU0ISBENYTn25wJr5Vg4zWoozVWJaXw4GqR7HXkNq6K4pEY
         R8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787825632; x=1788430432;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=08PVDrdFiMsGhuzXt0QxvkpAr/fHXOjfdnZ42eGdeSY=;
        b=paiCF/GtdSUQFK0lX5WszSX190k/IqnNve0VUD9MDcGJZ4EGoqYZ2qjMEcvEViLGdm
         vBpPq+s0NZ8yxYYZffhwoPbvQiOeHvjkAZJ2GhSQMEYMjLshsyqaP2iXB8fm/85xKULZ
         psc8SrJFePlEeQmPOiHmvAoHyq/0mb17jouPQ9U7Jpw94QjIQuNdm1GaFkFjJXnMuTE6
         oSquFOmtSkSVd8s+Gpxjq/e+k/ydoVYzjV7WWdUtvWq1wZRy4bzAoSvFmd2t3VGFTH9Z
         S4P7a1/lQr146CGA6WGccU3rwFdQnrIlHtKXEff4THwiP9AD0y8HtFklPNw6tIMGsBNb
         k7MA==
X-Gm-Message-State: AFuF++kJ8VWllbnTV54Vj6IYPGNoGP0c2PI3BVxzvrpQGgBXvV8TEIuL
	MLzzIRa7kOGbySm7bdlU/EMIFC5/A8wlAWNnseYDh+4ro6TXNaEiy8tMlPu73sJdZpuX6fusOKK
	mG7joEMMy3vk67WPk451H+8ITwsjEIIyizGhINu6ddmBKHqELqOVB9++I8A==
X-Gm-Gg: AR+sD12UeE9/oOoIFSb8ntzNE3B0MXXwtOmIGEPT+GeqM9jVO8qAtlowLsKUvyv+9uo
	veeEjzSxHn+0PT5eM0h6YVrQdbErDiXeMVB6VUa1pFpaNJJxTOFz6aLyb8z0qJ0lPPOwebV31e3
	SrGUap4zhgLUgK06osBNMwNOo6BvSNVMsei/NCafeO0QBQqOZXMFJd7QWRBrhkKk25vRWCRzk3D
	qrhmDsVwiZhyblIHuLPgjGkAFbRo6ggd3iZt1CvfSa3nF8g2w2Ba4RBjQ1c1zl/Z0uXNv4GndYS
	nnrHUbKzr04dqLnGhLeFAudmrvtNrvttd1IELEXIbjQpn53vuld3DcwbHMbNY1sR5vUXuVO1KMT
	KTOxlKYtUvhZA1pdHtlFkfy67Z3Mp/A==
X-Received: by 2002:a17:90b:530c:b0:396:635a:9b10 with SMTP id 98e67ed59e1d1-3966d3dc393mr25974510a91.11.1787825631712;
        Thu, 27 Aug 2026 03:13:51 -0700 (PDT)
X-Received: by 2002:a17:90b:530c:b0:396:635a:9b10 with SMTP id 98e67ed59e1d1-3966d3dc393mr25974405a91.11.1787825631238;
        Thu, 27 Aug 2026 03:13:51 -0700 (PDT)
Received: from [10.218.18.30] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d60d25esm20318655eec.4.2026.08.27.03.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 03:13:50 -0700 (PDT)
Message-ID: <5798db8e-4c26-4208-ab65-16ff3ad4d446@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 15:43:45 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amba: Fix driver_managed_dma check
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org,
        Russell King <linux@armlinux.org.uk>, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Will McVicker <willmcvicker@google.com>, driver-core@lists.linux.dev
References: <20250425133929.646493-1-robin.murphy@arm.com>
Content-Language: en-US
From: Ketan Kishore <ketan.kishore@oss.qualcomm.com>
In-Reply-To: <20250425133929.646493-1-robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA4NCBTYWx0ZWRfXw2ahbOjKeoGe
 ma/DDTYQhrw18Kfpqh0JOb76FKCVdOK4lybW11pC88jh347x+QEFp/SKG/3TsfCdhCgi/eJjUYJ
 MPEnbBUfSLclPv20W+NmhxPd4OMJWk8=
X-Proofpoint-ORIG-GUID: JJDfjhLExUcFSaia-JMEt9h1kDUPI6cS
X-Proofpoint-GUID: JJDfjhLExUcFSaia-JMEt9h1kDUPI6cS
X-Authority-Analysis: v=2.4 cv=G+Ms1dk5 c=1 sm=1 tr=0 ts=6a900de0 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1XWaLZrsAAAA:8 a=7CQSdrXTAAAA:8
 a=C8WugiQ-6VtP81x-AMAA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA4NCBTYWx0ZWRfX2YgbUzxkre6N
 dDM80x/+b2xdlfrbEyb1d0xMg1ouvLYxcbjBKMLbK6muc9vfFN2/4JIm/2GDACIuqY+qiMt+DQ7
 esSd6n6XkvB4OSt/udxgMaEF95ki1+ERd2sahUfLOgYiKKb1ZNVOHsNO3tCXQpzfIZNY0pt4xZU
 lHN4q35pBOSbYZU+ilk69LQ929ha5cY2C3OcEdT7K1fPaZ9ijJPwRjFYQKwPBKkRXIzyAWE8Bvw
 4LazuToUKiITZjeA/nwFmuJQtrwD2TkT11Ww3vFlw3Jae08ZZ3UluF5P19bESMHvV8MTkDo4kg1
 sit0nATculfV3ZaZOAi1tn0ZkGjRCwh+1duV8QZP3SVBe4he7g3T+UYdPpZ12Zqs6mzfQZH050I
 EUWPNL8O8a2zkQdBmDGOD9BjwMn0ZYSEbHE4Wu2TFf6da5ZejjXIaJwEjRTUf48d7y1TVLsSc6C
 aEAyuqCARb8dQAcvNxQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1011 bulkscore=0
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270084



On 4/25/2025 7:09 PM, Robin Murphy wrote:
> Since it's not currently safe to take device_lock() in the IOMMU probe
> path, that can race against really_probe() setting dev->driver before
> attempting to bind. The race itself isn't so bad, since we're only
> concerned with dereferencing dev->driver itself anyway, but sadly my
> attempt to implement the check with minimal churn leads to a kind of
> TOCTOU issue, where dev->driver becomes valid after to_amba_driver(NULL)
> is already computed, and thus the check fails to work as intended.
> 
> Will and I both hit this with the platform bus, but the pattern here is
> the same, so fix it for correctness too.
> 
> Reported-by: Will McVicker <willmcvicker@google.com>
> Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
			arch_teardown_dma_ops(dev);

Hello Robin

We faced this issue with amba_dma_configure race internally as well:
Call trace:
   amba_dma_configure
   __iommu_probe_device
   probe_iommu_group
   bus_for_each_dev
   iommu_device_register
   arm_smmu_device_probe
   platform_probe
   really_probe
   __driver_probe_device
   driver_probe_device
   __device_attach_driver
   bus_for_each_drv
   __device_attach
   device_initial_probe
   bus_probe_device
   deferred_probe_work_func
   process_scheduled_works
   worker_thread
   kthread
   ret_from_fork

We raised change for this based on already merged changes that fixed the 
same TOCTOU race for the platform bus in
commit 95deee37a123 ("platform: Fix race condition during DMA
configure at IOMMU probe time") and for fsl-mc in commit 152f33ee30ee
("bus: fsl_mc: Fix driver_managed_dma check").
Link: 
https://lore.kernel.org/all/20260825-iommu_races-v2-1-49de6de71357@oss.qualcomm.com/

We later found this change you raised which was never merged.
Can you please help to revive and take this change forward for merge.

Reviewed-by: Ketan Kishore <ketan.kishore@oss.qualcomm.com>

Regards
Ketan
