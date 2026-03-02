Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BE0342C8B
	for <iommu@lists.linux.dev>; Mon,  2 Mar 2026 08:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772439164; cv=none; b=fDELhYkq1gMQ7UtYBBGKoF/v/NR/Uh3abrY7rN2J+n8VWv+rp0hTyyHlg5Aj7YZjfCuhgLWQd0/xUTyUzH2014Q112rRpDSq+yRc5R79dEVLIYgugTRnslsn7vIaIpWI6oBZ+g+kQeNmNP0YN3R5J7ipmQRm02CoTq2zFAP6w/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772439164; c=relaxed/simple;
	bh=YsoqRWEnmbezHwWXwK/cDOGeLeQ6w9y75yey82wwwm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dmngPhoWkQJzAJx1Hy/cl5W9AYk7xWIpZVNw2ClK4+YU3aWQeZqeaw4zlWUb/v4Cx583U03qitvLPSRU4FeAnbL4E2MpmkLCMC49qXL4QuW2sNvg/F1ttFZoxM8Q5bIxKptV+TMiXZkqgUgtZnWWFTrFB6RnjF+7GOikq6GeOdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zcdf6M3T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hcR39Ko3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zcdf6M3T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hcR39Ko3"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6223vRD2185296
	for <iommu@lists.linux.dev>; Mon, 2 Mar 2026 08:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YsoqRWEnmbezHwWXwK/cDOGeLeQ6w9y75yey82wwwm4=; b=Zcdf6M3TDZSqgLfi
	2fOACi2y03BjI9OAyOXRdu+xMXNoPtWdj6Ek1x0Qy/8C4fGtH76ZW/iXVF3mWHAA
	ztFRrpNZLG/8+C5HjF+ze1OXv5Y42H48tv31J8YAeKOdKDxcmE2vUM4XHdK1SH8N
	jqX0S6BVY+TTHOKa8leb4b0QIf0+mKpOvK/3mI1ThRJe9zUEqvEukp/XDr4nbxUA
	jTo+HvAOgYjTVPbYEgaxGiCkubU/Qs+Ysfngq2+QgLtFbQ/5LSG4vly1R6QsXvWS
	TMUF1Drizz87ppE9SsMzmlkgV+Ggb5Rd3yAQJTIXDHGPAD5hIZQufb/rTITsRA5J
	nkpwuA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cksg74jxc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 02 Mar 2026 08:12:39 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c70f8010fc0so16540500a12.2
        for <iommu@lists.linux.dev>; Mon, 02 Mar 2026 00:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772439159; x=1773043959; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YsoqRWEnmbezHwWXwK/cDOGeLeQ6w9y75yey82wwwm4=;
        b=hcR39Ko3qUntoUOsVpk5f5LVVBkQc0OZuZEVW+NSdg3eTABPfRXmAuzmyUd5l+2Ywt
         mWUYq3QIoBf5dwqwEGNrGJV+04btuQD7bxlC2jeLLRB3nw/B+qy+TL2bZfppBUSxGgEq
         2p8exL6USU+6woghu87KNLr7D0rAL3GADG5gO2Yy2aMzYWN0odsy6tV07EwEZtyyNrWC
         k41hfE5L1rZPvtnXFVXsPZsrbRtq+ZgM+DbzSKQOWCgXkgxTN5ALrBt9n6RuSz5S0c62
         PdJPFUidinIljJqC3S3eqFlAzxZFXBRZrYBt5rbE3gSyt5SUgkCuN7ZsuPOKFCWPlcmT
         dueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772439159; x=1773043959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YsoqRWEnmbezHwWXwK/cDOGeLeQ6w9y75yey82wwwm4=;
        b=Tty7M27XZUWyNsAaz2B6bBdSW7NOhYeLtuIt4qzoc1anTpE+zkdZkjLu8MClBCFnuO
         d1PwZ2fZeDv64lZPdIYUYsak3FF0BCuvv9doZdFgVHB6UP4o8GNKmlTRKhKL0A75rL2Q
         /dFHK7wek9hPKvReNAWv9kPHBo1zK1Qj0dBxaGpgk6QRwLypD0LiqzSzWEU4sRRBPBIx
         CLNPdOwhAggXX0t21CfvBQZGnmTfZEvZm34uvc6/MwHTwtAUzb9asmMXlHL5L+iCrBpL
         1ryzgjiF3U8YkdGnzDsuHG0qQpxZEweA4f7kvOwPviZy043W3yr1hrtc5vcNJWZ77CWt
         ixfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxdvSAB5U1RCRbrV62iPDiQ0Q6eEAWlwkBWkE/3ZTFgc1RXWLSHe+lR41M1TlMie+xVovInw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzTBsN+3pXZGEdAdsBWaY04BIxxzhGhRXjd2tTZuyHm0hFm46mq
	0AdM5Ode7A4T7dk4VoUekRxLbusUCkgWljPN69ylmatobGxqK0/95Qq45wsWZK6c1nGfh0xC7e3
	/C1bRCDX6W1a225qCD4MhBbP1UqTtAVO7eTOudjh5fS8d5AxgtxJH4patbw==
X-Gm-Gg: ATEYQzwSQ2LnIvucJCjkcFqZeVBGDByPh4G2zHVu6ADKYEmuQKnu0dRwN/NktYgrydW
	0TwazceFdhDRXqqApHd2VSrGrhg/qxNHdiVAsIcq8LTIxej71UaK4PMtmVQv2Kf6CQISjdbo43H
	M3tMcPpAufGIiSwe/J6R1C+FVN9HC0bzQogqFnQ360RH7tMvAGrUcGEUDoSTNjtN4ZPJ38fpViE
	8WM/tb0a0O8ffh+1pFPCi0QzWaAUV3KTjX/rgHzYZjmoRAh9CzqYRci85FYHJk+qNvw3OBU8Ot9
	5AeGWwcRaocSq0t1KGvlgqYJEEEuvROIT18yzT4ZQZRcu7RV/3wweYbNPENh676/7ltZD/Q001e
	BoUzrHzW2XoDvS1qdO72mGag0VbgCOsJ7357YOmuETBdG1t5vhw==
X-Received: by 2002:a05:6a00:414a:b0:81b:8872:ae10 with SMTP id d2e1a72fcca58-8274d8090eemr11013992b3a.0.1772439158706;
        Mon, 02 Mar 2026 00:12:38 -0800 (PST)
X-Received: by 2002:a05:6a00:414a:b0:81b:8872:ae10 with SMTP id d2e1a72fcca58-8274d8090eemr11013957b3a.0.1772439158150;
        Mon, 02 Mar 2026 00:12:38 -0800 (PST)
Received: from [10.206.99.28] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a060071sm12915292b3a.63.2026.03.02.00.12.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 00:12:37 -0800 (PST)
Message-ID: <7c795b4b-3a3f-47fb-9ef9-0b13601f584c@oss.qualcomm.com>
Date: Mon, 2 Mar 2026 13:42:30 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 04/18] accel/qda: Add built-in compute CB bus for QDA
 and integrate with IOMMU
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
 <20260224-qda-firstpost-v1-4-fe46a9c1a046@oss.qualcomm.com>
 <ox7jnqkjo3frhbgpp63sse7ram72obihe4qlbbn4z22wbw4szr@7pzoeecdvsyg>
 <e82443ff-f6c1-4b8e-b573-f4620dd0f17c@oss.qualcomm.com>
 <x6zseuf7g3ngtdlszf3vxj3nqexlkbtrp5kifo4tg4muzdef4n@5rngfg4gu47m>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <x6zseuf7g3ngtdlszf3vxj3nqexlkbtrp5kifo4tg4muzdef4n@5rngfg4gu47m>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 1hcCV6Tm3dR8vw6w2PWYc7W_Y7WsASMB
X-Proofpoint-GUID: 1hcCV6Tm3dR8vw6w2PWYc7W_Y7WsASMB
X-Authority-Analysis: v=2.4 cv=FaA6BZ+6 c=1 sm=1 tr=0 ts=69a54677 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=jwkSyuDCPDQl0KFoS7wA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA3MSBTYWx0ZWRfX6S7PYVRW6X9x
 /nOjUulj+HIqaZTKeQ2eC92eGwjcypWAOpJ3HIDePxa4Yjx2fwIzl/P/05PbF71E2jp5vFJzLwC
 IPdx8PJ3GKM37tvBv0jhPUsJYeDtpCrsnT9asufrJxk9huLXIe+ACfLmkP3+n5KX/9DORUqGECe
 iAWEbkXsANOe60ZFR6+G8Hs+IWMtBH9B5Vpi3wGTJlR8Mz+UyM1tOUh0UPBO50pTx06ix7SLw+c
 6gbUu0Wg02yB0AMTHS1uKGStXb2+eOiRMSIbUPMZC+c5A7lvyeEaegyVLB2j2IGAUL7HUYnxfoA
 jbxPcdJUB2kCtMB+TL6w8KMfiOh8vNasf7h7crXpfc44fz0JnMLkUYRWeZuOwKMlZ+J0cz2nMq/
 yVFi8vleakurje3KF+tUlQ9nbTV+ESw+Ggjg2ZCS8dobzTmaDSkzY8Fkox836ZL5/QsoFcu0dAY
 w6hCgr+H+DyOP9MKRDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603020071



On 2/26/2026 12:39 AM, Dmitry Baryshkov wrote:
> On Wed, Feb 25, 2026 at 11:26:52PM +0530, Ekansh Gupta wrote:
>>
>> On 2/24/2026 4:14 AM, Dmitry Baryshkov wrote:
>>> On Tue, Feb 24, 2026 at 12:38:58AM +0530, Ekansh Gupta wrote:
>>>> Introduce a built-in compute context-bank (CB) bus used by the Qualcomm
>>>> DSP accelerator (QDA) driver to represent DSP CB devices that require
>>>> IOMMU configuration. This separates the CB bus from the QDA driver and
>>>> allows QDA to remain a loadable module while the bus is always built-in.
>>> Why? What is the actual problem that you are trying to solve?
>> Bus needs to be built-in as it is being used by iommu driver. I'll add more details here.
> It's an implementation detail. Start your commit message with the
> description of the issue or a problem that you are solving.
Ack.
>
>>>> A new bool Kconfig symbol DRM_ACCEL_QDA_COMPUTE_BUS is added and is
>>> Don't describe the patch contents. Please.
>> Ack.
>>>> selected by the main DRM_ACCEL_QDA driver. The parent accel Makefile is
>>>> updated to descend into the QDA directory for both built-in and module
>>>> builds so that the CB bus is compiled into vmlinux while the driver
>>>> remains modular.
>>>>
>>>> The CB bus is registered at postcore_initcall() time and is exposed to
>>>> the IOMMU core through iommu_buses[] in the same way as the Tegra
>>>> host1x context-bus. This enables later patches to create CB devices on
>>>> this bus and obtain IOMMU domains for them.
>>> Note, there is nothing QDA-specific in this patch. Please explain, why
>>> the bus is QDA-specific? Can we generalize it?
>> I needed a custom bus here to use for the compute cb devices for iommu
>> configurations, I don't see any reason to keep it QDA-specific. The only requirement
>> is that this should be enabled built in whenever QDA is enabled.
> Why? FastRPC uses platform_bus. You need to explain, why it's not
> correct.
Ack.
>
>> But if I keep it generic, where should this be placed? Should it be accel(or drm?) specific?
> drivers/base? Or drivers/iommu? That would totally depend on the issue
> description. E.g. can we use the same code for host1x?
I'll evaluate and bring this change separately for fastrpc and host1x.
>
>

