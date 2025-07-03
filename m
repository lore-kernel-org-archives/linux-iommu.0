Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297944414
	for <iommu@lists.linux.dev>; Thu,  3 Jul 2025 02:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751509200; cv=none; b=eHZxJspiL/24HgqJJ8o6ii6EEnMtiM9+ZyJ32rDIn+a+B546lRZsOqYxp0do427I3FnzBraQuIMK92GcGJ+GtyMi/kwOMdiJhCqtpzbXXvm/GVgrTPqjQ/QqqPAt/NkoLh/n4Gwe6+h8zdMGhA+6mFvm/r7tRwOsd6EQOKmiGII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751509200; c=relaxed/simple;
	bh=rnEUDMnYf8STp5GPvVbg/Y3l1whTuYYaxsE/wbhNOXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nuNzRQmw0LgLi11L7yQww7kYwLFQE3XEW1vjj5Tyneoiw61gLY/WRsC9viXr7NBoDNqDiltS++8xHjU2IZMd3+i1Wj/4QGwVtPVTKXhWyCbVZLzeJM6i1fADKOOxeRBZ4clV2aSK75fixeBgonn8VM/O8e+qjsT6g9JF6mH1vaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DuHUAMO0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DuHUAMO0"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562LudOR028616
	for <iommu@lists.linux.dev>; Thu, 3 Jul 2025 02:19:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8SgoQMCb+yk35vcEdpnooOFtFCFlzwJMMzcRzUpYFpU=; b=DuHUAMO0wJJ826x9
	2hFz2U8l84fCq0lDxIDdk7LI/JRjI5ffzrJ3OtmkS6dvTo/u/vfAFgw+lSYsNYGj
	lLWb0WgecX2zpCu/9Xie9g/KS5Kh0zuS4QC0ScXvU8EQX+USdX++NI1qvLJxWdkO
	fPQlRDIA5sPgLw27bg0GQJO1jd/gi/J4TjxZOXYZU4bJhj1IG4NS72aE+dz3NryL
	Z58KsHBiGbO15jmX6kMGiElLhEaV7FcMICq+rECbM6QTJhBlGhQFahu9cjGDhstO
	ol85ejBTl9ixSx4UguVWEFuh6i+LWDOitCm1TZEZmzdGniquEM3oX1LpXw/B10A9
	59poJQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j7bvxue4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 03 Jul 2025 02:19:56 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-235e1d70d67so38017955ad.0
        for <iommu@lists.linux.dev>; Wed, 02 Jul 2025 19:19:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751509196; x=1752113996;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8SgoQMCb+yk35vcEdpnooOFtFCFlzwJMMzcRzUpYFpU=;
        b=Pm3HfYi9JfsxyIP6T9XU9+m6NSHLx8UI1w3KXJPubPEG7qq0xpx3CuYAgY05Ima+Yw
         2U5fWkkS8+wo/6Rul3YHtlCTjJUWAgR2UYNNAHbWW1y48oqnI8mOvhGb7JmP7KRnGM6c
         KmCc4x6+4mIyU0I20XsOaZgRusvu5BvWYE7FnubNb1tsV1u595Fo+5Szn1ssjGRlVEI4
         K5MgBectP81YRIWj8U7r62IygURJhnU1mN9i/pn2czbdKl0M8OsMKhVku8XkWDeQj1Od
         MwE4uS9cOam4kJ8eirtdXqj4rqwxyhiak2oBEEdpKuXk1xOvOn9wDtyT24KaahxjhkU/
         3NhA==
X-Forwarded-Encrypted: i=1; AJvYcCWdW3Lf0Xtiq0m5whtTjz0TOpebMbBBVuHomez0mh50ejo+DKBejA3EsjlGSmU0Mt1GwhlJrg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6z+tLSGfKUXJTXki4lG0zEgauS80PpiCse3NDaXAZVYEVoJgR
	JCeY9I07F4wqd1XR2rf/au2Boo8LNm9xGDBDXh9bqXhXuNPjb4PMTgoWOUpvHOzikphgtENX2Q0
	EOhJ01L2pW0jHCDI8yI07OvdDXekHZRbdQtT43pTwQ0fAsJLJRYlRCA5zYQ==
X-Gm-Gg: ASbGncswEE7PVHZj1kJVsdYIislDda2cFOOmtz225LPmwjBcAFDR9s47REXY2/iy3Ut
	ExWBW1f41U9gHVGVQcvXXmxz0sbJTGtoulU+NHjecUYEX0D7ZRMng/Hpyhnid8KOYWkxhNm6Npv
	L5A7PNcg3P5Pt4wolLG/jSnLBKKSljAY5xtfI3wYaVQe0+XhYUwkiq0kc34yXV8mwzSzShP0dBc
	K7SIaHfRHcFoTIfvSV3hpR7/unwN2Gws6PCuXeIPxnJ4Zcx4+GZkTDzgiJtSsMq9hCMqI1OpfD/
	IY7oRH30cXtaJrkuUQe2tLJh8bIjrtcBaCUkFez48PDjwQI9QMoFdGjEwr+gvVlgPaVZlEboFnU
	e3N7g8/tHjA/1p18=
X-Received: by 2002:a17:903:22cf:b0:234:8c64:7885 with SMTP id d9443c01a7336-23c6e594071mr82030005ad.53.1751509196034;
        Wed, 02 Jul 2025 19:19:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTss5kyY0B6320sF3R/MAVC1HUnXlJ+1X/RIYQnabOP0u++yoy3pq4btZm9MwuOzM1nPMzMQ==
X-Received: by 2002:a17:903:22cf:b0:234:8c64:7885 with SMTP id d9443c01a7336-23c6e594071mr82029645ad.53.1751509195566;
        Wed, 02 Jul 2025 19:19:55 -0700 (PDT)
Received: from [10.133.33.139] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3b8ec2sm140834865ad.183.2025.07.02.19.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 19:19:55 -0700 (PDT)
Message-ID: <979be2a9-9d0b-4382-8519-2f6fbcac5375@oss.qualcomm.com>
Date: Thu, 3 Jul 2025 10:19:51 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath12k_pci errors and loss of connectivity in 6.12.y branch
To: Matt Mower <mowerm@gmail.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, Robin Murphy <robin.murphy@arm.com>,
        Jeff Johnson <jjohnson@kernel.org>, will@kernel.org, joro@8bytes.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        1107521@bugs.debian.org, iommu@lists.linux.dev
References: <CAPDiVH8gaBH6o_OY-zUWYpDbj5mhiqmofKGb71gLgHOi4vA=Vw@mail.gmail.com>
 <0ba2176e-3339-4a8b-850a-ca5643939c8b@oss.qualcomm.com>
 <fd3bd8b1-4108-445a-b65f-4769d73e6e63@arm.com>
 <4a13d862-1bbb-4a98-bc1d-219bf78f7c0d@amd.com>
 <CAPDiVH-kVCUY8DKexT9OqAZsvkZ5_CGo8d8nENYA-kD=s_x8wA@mail.gmail.com>
 <e008afed-819d-43eb-8895-2c7aaf24ec13@oss.qualcomm.com>
 <CAPDiVH-xPDmx-KQx7YJY=7+kwJNbGY-rEu-w+cz18p=kjnKFsw@mail.gmail.com>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <CAPDiVH-xPDmx-KQx7YJY=7+kwJNbGY-rEu-w+cz18p=kjnKFsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: aFZaObR_Y0fto_K973M7RZYCUvZSvHFy
X-Authority-Analysis: v=2.4 cv=RJCzH5i+ c=1 sm=1 tr=0 ts=6865e8cd cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=1xDctz_ZAAAA:8 a=x-Jbw-KjGOrRcKConVEA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=1a1P4aADmYxDp9Cj9Seq:22
X-Proofpoint-ORIG-GUID: aFZaObR_Y0fto_K973M7RZYCUvZSvHFy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDAxNiBTYWx0ZWRfX6jaB+D2xZzkp
 bKonTVnKu24tWWmfYQTWtFx7WYGICT0VDc/IsngKfufMF26nUdNr0wPZXI5JoHh3QkGUlkCLXhv
 Byg4eTqNEsSVRyPI3n6lCJ693l89R8O1xLgMCgTrgCTENmB8hcm4wT2XV9MC23Bp474nno1yWca
 36L3bELvK79d6Ydt7J9IOCSura+Wgtertn6FrUfjr1ES+VQXUME64PyxWb4nMWVXE7lFCEIf3ae
 HROLCAMiKxmPCdf95NpZCsAbpTmpstQ32xtOl/655JfamQsdXZlA1eu9QFoSTR2yf8AQB+VzJhC
 IvTdGQaLN3md8AVoC3pRIowG4mGY5l/6iMtcXij7yMqNUN+UqfJJg7d9YAk37TirYqjqnHO84xk
 UR5eiPQMU7PXPMWB2H5VsP6R7wxaII4K5IwTgG2tawj+kh4FVvZNiIUKBNXtYAVfw2cbh7jl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_01,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507030016



On 7/2/2025 10:53 PM, Matt Mower wrote:
>> Matt, could you help enable verbose ath12k log to verify my guess?
> 
> Here are kernel logs with ath12k debugging enabled:

Thanks Matt.

I see firmware crash before IOMMU fault in both logs, which verifies my guess.

> 1. WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>    https://cmphys.com/ath12k/dmesg-6.12.35-ath12kdebug-fw0x100301e1-20250702.log

[   91.625809] ath12k_pci 0000:c2:00.0: mhi notify status reason MHI_CB_EE_RDDM
[   91.625916] ath12k_pci 0000:c2:00.0: reset starting
[   91.674375] ath12k_pci 0000:c2:00.0: waiting recovery start...
[   91.679445] ath12k_pci 0000:c2:00.0: setting mhi state: POWER_OFF(3)
[   91.680721] ath12k_pci 0000:c2:00.0: qmi wifi fw del server
[   91.680754] ath12k_pci 0000:c2:00.0: setting mhi state: DEINIT(1)
[   91.681842] ath12k_pci 0000:c2:00.0: cookie:0x0
[   91.681858] ath12k_pci 0000:c2:00.0: WLAON_WARM_SW_ENTRY 0x14c4e54
[   91.687109] ath12k_pci 0000:c2:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0010
address=0xfe980000 flags=0x0020]


> 2. WLAN.HMT.1.1.c5-00284.1-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>    https://cmphys.com/ath12k/dmesg-6.12.35-ath12kdebug-fw0x1108811c-20250702.log
> 

[  113.621429] ath12k_pci 0000:c2:00.0: mhi notify status reason MHI_CB_EE_RDDM
[  113.621794] ath12k_pci 0000:c2:00.0: reset starting
[  113.670134] ath12k_pci 0000:c2:00.0: waiting recovery start...
[  113.675177] ath12k_pci 0000:c2:00.0: setting mhi state: POWER_OFF(3)
[  113.676331] ath12k_pci 0000:c2:00.0: setting mhi state: DEINIT(1)
[  113.676581] ath12k_pci 0000:c2:00.0: qmi wifi fw del server
[  113.676874] ath12k_pci 0000:c2:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0010
address=0xfea50000 flags=0x0020]

> I captured these after setting CONFIG_ATH12K_DEBUG=y and running "echo
> 0xffffffff > /sys/module/ath12k/parameters/debug_mask" during boot
> (using @reboot in crontab).

Unfortunately I can not tell the root cause to the firmware crash from host log.
Internally I will try to repro this issue, in the meanwhile, Matt, could you help do some
more work to narrow down the problematic change?

