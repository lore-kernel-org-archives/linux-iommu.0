Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB3A42CB10
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 09:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330764; cv=none; b=RrC1A2O0+eLwjBiRod5Gw5Pji0O8NV3HLSov8PGIQlDJ94lFDK1zWqPMpJN8mSPkkF2Wgyk/frKYIlD57j3+dffSj0Q1zJ+OTniN7SI/oCdDS3NpjXhYw4CBxz3N708t1FNOck6jtEWaBglTga9NjlojwPVxwqzc+4UpYl9Apdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330764; c=relaxed/simple;
	bh=cCCe5OkOXnhSeHqZSZl1sZiScoVnvd1Ki7EsboP/TAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y+7sN426xRF3XPxdZ1NUU6RYLwjo/XVFn21I70OtOwy7Bua/4g/6X8CAF35V3yxrn9MxOoJyupP4Rluf9N5G5exd+2rJfdpCGlxZzvoy3hTQjI4TUlC9aSmazLsn3kht4HdcKAlLnyQVMv6LFrmGqHIUGMzEjhuhDKQ+eONbBHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=igSfXDSG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HDNxvDbK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="igSfXDSG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HDNxvDbK"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66693rut107424
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 09:39:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SbjCETrpVj4j77Vo3a/oe72PsOFxot0+LxVY86kScYM=; b=igSfXDSGDXZyx/+x
	3CJahP7NvHEriESw1Af3soF728wAkm8m07BTNRQTpyQV0fid7mWNRl02gXhYnqfK
	bcBuMpD07adRfZTDp0SxSdh2UShWruleWpw/E6BQdNodE7o93BBEDR0TdVM2WKrf
	1sAnRmnjHO5SaJ6Q4pjJWO3/NatVmggzTxajWuTS3jmic4RD3cl5WNsW0MZXgEup
	FksPk3ls5DCyO1vE6BYGTqN0SoTKCEIAjVASH6ujrtF+CXDZZw3dcXIQpjCrIT1D
	2WjGHPvi6Frnz1luwacQfR7vZbQ+uCjC3pPXQowDURBYYqvPTNHnn+/JR80Jfrqy
	A0PsWg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f891ur7ew-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 09:39:20 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e5e21552dso66412885a.0
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 02:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783330760; x=1783935560; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SbjCETrpVj4j77Vo3a/oe72PsOFxot0+LxVY86kScYM=;
        b=HDNxvDbKvewZgO+7sjs/T/OBwA19mdCf2pM2A0xS3cp+otshU0UBBW8QnN4W1hz2h1
         leuRSsqBk0lmD5VStNU+bbJaurh0Kre2pz9EFZu6MIQLV6UGAN6C8VysQbFBm7bvBktl
         9B+wmKHqqfuwCnxSbVzW2WvZfyZFui37XVc8nbKCAJHe5khDXgWvJTes1udpZnkw5FFR
         S0qdjxxyBKc1RWg/W/LWCo13e2AloEc1A8I1plMPWXZoup3kELLhhfgpeAD3bX0zhFks
         NZdGktFE3jPuhZZJYIjesSTOgMhjtRHYYgbzJJUO0cgqvCD540fvV6tyX1gXhc+6zALV
         55sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783330760; x=1783935560;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SbjCETrpVj4j77Vo3a/oe72PsOFxot0+LxVY86kScYM=;
        b=peSBJN3ivM7KX/8gYj3P3LL/N29sRqZl4mfARKkGS1UqlDbwHVtcJORo4nXBTKgf+I
         Kfbeiiu6IYbXftICoUOUgikTaL+kpAAMxususSC4rpznxPp5uc/ZMQE8gcV/vL+CO/Jw
         nZMhd3xuO4WlxJq1VR0MMvhWzMb4MDhiK8uabnXUigZkFTDQArUH2JQItrmHT3DibGpt
         C4mPJZEUb5F9NzU+k99unkPsrJ3OiDGx5GaGcpH6Fz4lE98UDlkergg+SJ5g0BLbQXC5
         bTbwoQ34teM3wq6zvRgj9lnHbft4AGkBEeoUGB0YBqaTbMWj+w7prxOHHVztQyjLOmuc
         1vKA==
X-Forwarded-Encrypted: i=1; AHgh+Rq3BXWTXQKbIEBfVD+RC6uAn2fsw19YJZB1Kppbg2ZzFjw1CZtDQ/aopvan3R7Mzq53X++QmA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyHKf7sJ/irKUfqigQzQmnJh7G1eeyziJsh3fUhXfgBWGhwJfVD
	MCSMEe9xVD1PXofwp7t4nlO/Fhs07OP/Sg9BtjxbOBaa06089En/xEvpd4OnM5zPfk23cGQZIzX
	rEcIVEeitZ0+fsSgnvoUoeuXzNsZNlmT7kRqIhHwYKm8PX8UsYEfib9Lx3A==
X-Gm-Gg: AfdE7cnBcPkMviyly10rElkEhaPNvFD2NYRkdEeIXHWf2UQtqyvRXcrElqY1KOzxo/a
	qGbBNH/fujDoqqkb+2no8vtx4qtB8VH+sbeRVj3mJZ9MMmis/45+P7xKQERSue6XvFRLwOm2MuJ
	ALohQ+CAlMuR3oQfOn2k8Dae5DnPL+y+KdEYdObvwjm2RpvwK2FBhJyX3byDPKUMeeDQjnfJWpP
	NFsfQv7g17RcjgeM6QsqMl4y/xTIneBlzhAtQm1E6dOG2jFs8V4FSAVil6dlvFFlA8dHw5MUo4X
	MFPjvsyZ1td/8TRx2/EHbD3TiyXbi+6ejdO/pwH4RhEiokko9oOssCeu8BA+GHBHtmC/m1JaxWI
	u5AQ5w9QFzTNwQrHbNIwLWgoaTyKYBJncKAU=
X-Received: by 2002:a05:622a:8b:b0:51c:1c73:51a6 with SMTP id d75a77b69052e-51c4bdfe4d1mr85762621cf.5.1783330759866;
        Mon, 06 Jul 2026 02:39:19 -0700 (PDT)
X-Received: by 2002:a05:622a:8b:b0:51c:1c73:51a6 with SMTP id d75a77b69052e-51c4bdfe4d1mr85762291cf.5.1783330759458;
        Mon, 06 Jul 2026 02:39:19 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19daea67sm3674475a12.26.2026.07.06.02.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 02:39:18 -0700 (PDT)
Message-ID: <2304770d-a752-48c1-a11a-30978a834b0c@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 11:39:14 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] arm64: dts: qcom: kaanapali: Add GPU cooling
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
References: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
 <20260705-kaana-gpu-dt-v2-6-6ac53de56314@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260705-kaana-gpu-dt-v2-6-6ac53de56314@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: YpeSifIktL4DGDswMpSwBzl3LTePTxui
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA5NyBTYWx0ZWRfX+/nyLm5sU0Fg
 apQco8yvETdWqMq6md9ZbzpQ5JrIF/6AYSoscy9yPynYR+cpTdItiLNkeCT+3CE+CAMjiz2bMab
 xyDru7titL8q3WdRmHt1/hgnH2p8yvU=
X-Authority-Analysis: v=2.4 cv=Mo1iLWae c=1 sm=1 tr=0 ts=6a4b77c8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=K30R3rYzCv3NiW1yJugA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA5NyBTYWx0ZWRfX7GW2ivoCPuHd
 d67Hh/bm7sTnem28ETXcyiPourA6dzst0k0HNeXkF/OfGhjiYMFjGzsyPcp64F8myHV2jsq86If
 m6AZNUdKeZt+oVNAQ2TG0JFh7MuZ9cZCiCDHP4B2mNgmmJtJLENoDPnsIxIyN+eCCmyqa/KeXs0
 wEt/PtOUwfDlVy7sEzdINktuPoAxNYv/W0AblTC6xxqOFDodcXVsPD/I0Z0uzg0UieXqZBHtTKt
 jrvy9TmgEZYsc/VMPeV8SzMy9x09cpdvXRF3FcwRGCAH+0sp7SWP+yHuGIa3oJd18ohzNWQe2KM
 rwTxDSD7KHuij/SLoI/EfLYwLQ4SPlqBWgTPt2EgvG9zIEXaoN52Cf3mgleyfua+pGyf/CrrPFI
 1wO6b+mUd8egKeEWVA39yM1N/sjK9NEbmKBQUBxWGOFzFqtAdfgisoBCUNMgFFeqcs9QpW6Mjqd
 2CDau3p8KqxMjy5AVWA==
X-Proofpoint-ORIG-GUID: YpeSifIktL4DGDswMpSwBzl3LTePTxui
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060097

On 7/5/26 10:00 AM, Akhil P Oommen wrote:
> From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> 
> Unlike the CPU, the GPU does not throttle its speed automatically when
> it reaches high temperatures. Set up GPU cooling by throttling the GPU
> speed when reaching 105°C.
> 
> Introduce a passive polling delay to ensure more than one "passive"
> thermal point is considered when throttling the GPU thermal zones.
> 
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
