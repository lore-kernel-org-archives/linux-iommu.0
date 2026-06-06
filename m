Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E1537AA86
	for <iommu@lists.linux.dev>; Sat,  6 Jun 2026 12:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780748254; cv=none; b=RqHm2l7aubRbsoQXQa+2M+B1Hpl1cc1zYo0bq32jypjivKTjRd2FXGZWxuUgn56teun1Um1fWn+0Utmg5XUSe6j6EeXTBO6k68rghcDedXcttIpWPLhoIYmkPZel7YCi6IURDP5PLEJGcPal49PlzuIKJse9S1avJFKQq9we/MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780748254; c=relaxed/simple;
	bh=cb0vdcAh9cY3J15mE5rLya7MP8jlTCeWMKnX8CcOiwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Af0SSVk2bTAxVYBEIk+Tw3uJLoHOae3OsZ6CxfTWrj9f4FkUFvdpDVNT19JV4PAhJefI1xXdTLeCjwUiz1tcE2KJx0fPmS2U3HA086jMFs0bIJQdGKOvODQ0zEhBaujGdkONmHNRu2EjS58aoLSzigArBmKOtbvtddLCNuQ++lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wpo9IbW2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Il0Qpfr9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wpo9IbW2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Il0Qpfr9"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 656BGIf31321688
	for <iommu@lists.linux.dev>; Sat, 6 Jun 2026 12:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vgZvs8ItyoeNzwdrSoQaw7NU
	3tYQCqRT79Wusa/gol8=; b=Wpo9IbW2U2wCrMvLt6Xez0VLv8ki56i9WVHlQUZp
	bZooegCRoCJXy5IX18MVaTLrte5oIcfWoS9qaiLiVqEtwTVNKDPGdej+SKmX/FX7
	dwnxOh5eNKpI0M9t1AcExvxaLEvhZWxOhSJ/zTKsdACXfTr93T7SGknbAcrFXCtB
	lKYI1aL6epM8UXzLhlH33hc3OpiMVEi8I9hSx4Jnr0pbzE8DnpM0ZFmd+8z/YXMc
	KwugfXljpdaQToMRX/9XQaQvO+mAONFvpj0RsabkdtlEOQEsdcg0sEBYRh+fHP5m
	NM2dnniTrJIJrMK2054lywh6lRSYo7JSXRXJ83ZpyP5scQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emaj4s97p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sat, 06 Jun 2026 12:17:31 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-6c47a07f324so389379137.1
        for <iommu@lists.linux.dev>; Sat, 06 Jun 2026 05:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780748251; x=1781353051; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vgZvs8ItyoeNzwdrSoQaw7NU3tYQCqRT79Wusa/gol8=;
        b=Il0Qpfr94fdSsnQzYEXqRXgnEc93+7aA0Dj9OB+USLvMR9uOnWV6Fz8Uw1aSwjhR9K
         fNPQ0SP1QDLkuYwE7XzkrWcCM7Gf4efKcjNClgzKTO5f8D08qh8vhZeob87CVqno+LDK
         5rGQsMya89azi6jJ+aoEfBkka00345GXa7YO5X0mQSXYXz0tbcy/3cWICGQ9fW3J/x26
         38GDiRvdHMJ3KuUnDNsIvS8sw/UDpD4bufjtLP3/PZOgsAeEYTqKfSv0ei/W3AXOaS61
         QE2f0QL9iSILMNmaE7+lJzStdY+8Uxp0R6dO+Z9W+gyVMcHiKXL1FXYXtSOPMJrvxLUx
         DRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780748251; x=1781353051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vgZvs8ItyoeNzwdrSoQaw7NU3tYQCqRT79Wusa/gol8=;
        b=mSbK2GFSy7GG3XzpctlVjrjwbnf9/bvgdc62tfYls5J9xYxqV1ttLzNbFv8ngbeCyz
         grZapl31elqaSoT9M2XRY/hn5wx7rKTawzBrDWSNHib4/kbC7Omz+mWSvNo4yDbvWalJ
         g0MsOz4fJu04Q73dxWoaurjqkivskJLKB0Wo3Jo8zfWpHKtZDvLXI1+plHCp02MtO0c6
         vXQ7jOTbkRvbWU23EsuYmAgYHggTtRQN4vaG84FMSWkXg91PWhC3smRRjH00NPeR4FUF
         dylkW4fE3HkzFFGkVwbhsZEJVpizj+si4Mr8qDupgiSXjeY7oV/h7rvI4f4UGGA5YcEz
         FtmQ==
X-Forwarded-Encrypted: i=1; AFNElJ8+mpM2366MB8SYPA+N5DizF/fNF0JBa6oq58FeXKw9V6ZQN/OUDkj15UR42uyTgVfLFuIJRA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyDEof/RGLEDvOmKHB7RpCOQv0ZVpmdiH+Ph67L8HZrKPMiWG9U
	Vc7RIr5LQtEFz6OGkVy4T07RepiM+/mTA4VhTVNX+aX95L+DcxnzV+CXp1mQgoNIdxjrvDxNuM2
	Kkoy3dSYyBK9Lrhrp70fsjlFFV6u/xMXwME/SQUgjIUjOr+DI2KxSt4N2yQ==
X-Gm-Gg: Acq92OEZTUz79+dfx/T85pz8TymulhEr/YWIh8d34Z59oLQ5pE/BtkCPa2RgZFAfSNT
	WYr2o4xZn22mfh4c5lWh9Q+CE5RVLbKP37QtJXEcegbdfJ0CFyj74fB3BsTGvgsFf5GCHd8RbLz
	m2qs5LQ6fVqE1kKN4+w9tkYfNH9faUUgZ1bjyFCyMCnyojA5BuZP4SopWZh1m1J4ov/dwnl5oLZ
	F+DRjUbDPBMlh7avzrBh91Wu0Xpu4kzh4Cxbwo5P0K29ikLc68njKc51xCVv0TJ/cyfC8kwGB2I
	shTV529IOjArt3aN71F7J5Pnyi2WuCgMVB5FXw6DzUR9FYU6o/XdI9euDHTEB9PhcO2qYKH2TmT
	J72z9lCfQNU0QRsaLptyGj2paalKRrWOMzedBxhEu927UjuJmNKML5dnxifLpQgcSGOwr3J4Thg
	OK4G7WcCt37FwePOqch2fjrqDfPFv59KQXlY4ndqDQZksavw==
X-Received: by 2002:a05:6102:4411:b0:5f7:240f:bbee with SMTP id ada2fe7eead31-6feef48d3c8mr3403155137.1.1780748251233;
        Sat, 06 Jun 2026 05:17:31 -0700 (PDT)
X-Received: by 2002:a05:6102:4411:b0:5f7:240f:bbee with SMTP id ada2fe7eead31-6feef48d3c8mr3403141137.1.1780748250808;
        Sat, 06 Jun 2026 05:17:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-396ac2ed56fsm30934311fa.37.2026.06.06.05.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 05:17:29 -0700 (PDT)
Date: Sat, 6 Jun 2026 15:17:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nabige Aala <nabige.aala@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/3] arm64: defconfig: Enable ILI7807S DSI panel driver
Message-ID: <aiQP1wpq1MAlsttR@umbar.lan>
References: <20260605-shikra-display-v3-0-9846ba5fe635@oss.qualcomm.com>
 <20260605-shikra-display-v3-2-9846ba5fe635@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605-shikra-display-v3-2-9846ba5fe635@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: nnsVX8RsagsAiywb62C2AE5YhQ448l_R
X-Proofpoint-GUID: nnsVX8RsagsAiywb62C2AE5YhQ448l_R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDEyMiBTYWx0ZWRfXxqq7S+6g7lFq
 wLc+/FMxT0+ffEOMM/eLpkU00p968rUSH75USJaWYgfPNxGEUubN0tcb47vJPeYAgoGy9fvZOxu
 f4HgwCUATVVyo4qsGbKT/HbB6o/UkMzgoPW8KHdQvK0MYas2/jH2MrKYqycOB9I5i7J1mFKV2L0
 AHO+A6rjuHwnrXCG+6CNezIzyFBaLLEhDKpNqBw8sgzbJE8xXplQXWe8VXglssLe5xFcwh9mb15
 Hj9Pe2Qtu+ZrPc0Nj9uc1+UBM8VQPI7CsEXjjku0QzXiMFjRQ1rUFSzlYn0rabgDhi0pY9YSTxu
 e3iD3a07qMxDWk6tc9mbdAxF43YruqB4JXmYGmq3CpQz/nVRfa3Wj5BwYTkSLQzmSAIcOn5Hl58
 Sih1B5AE+PTAXsrxCR6PctQgUXMApcON36qt5vCEGfM8BJb+BBvcPeqlfPD3cWZXK3hpZmPLLIQ
 XezL5J3nlrqNB9/xhew==
X-Authority-Analysis: v=2.4 cv=TLh1jVla c=1 sm=1 tr=0 ts=6a240fdb cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=oNl6jLlcSFQHEdJXP8oA:9 a=CjuIK1q_8ugA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060122

On Fri, Jun 05, 2026 at 03:48:52PM +0530, Nabige Aala wrote:
> Enable the ILI7807S 1080x1920 video-mode DSI panel driver as a module,
> used on the Shikra CQM EVK board.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)

Okay, you are really not reading any feedback. This patch doesn't belong
here. Move it to the series adding the actual DT with the panel.

-- 
With best wishes
Dmitry
