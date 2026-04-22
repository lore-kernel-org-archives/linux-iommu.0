Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F881FC7
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 01:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776822366; cv=none; b=HZc26aMYzdhsa2X/+PnEXd7iDXnYlJd3HbJewvikeDXqQluPoqP20JJbMx/Lk2CgV+0bgKq9E9AkfiSAvnM22ZI3YMW6Zpr7nEis/IxegzJ2qFgD2itXpF3HKUT8qxAJptozwYwnuVuR9zhbsrWFVFDtYEmvDC64oKaaLkna8u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776822366; c=relaxed/simple;
	bh=J4wTpoeaO9WLgzP8Jpje86KjuxOS1HQB4mEYRLZ+P/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxlEfWIGlGD+67Ek5axBZgghFTiUDtOY1HOumucQX5VdHGLDwywueysbJ7+i0m8NfGzf6d0soA+M5EWF6sH6LtNAL77DChfT6ur12KaDdmgzpqD3/k/B4tm/WEDGmLp+XHwwot/x+YOizLWEw4goiKBvup1IqckR89pnOQ0p0DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QtwuHiCF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O1sykAY2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QtwuHiCF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O1sykAY2"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LIZtdq727958
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 01:46:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=d6qcSACXlaQj5b1ggVkdYa0D
	KEGMgEtnXT9U+NqrGGo=; b=QtwuHiCFZuUERNAn1f54hVH34luiWnKIkv+1Xwoe
	zzLEiV9z5bww8oPa2bneh88dqsZ1XdLTVfcWKoXs5aYDLQou0Ll1U+G2HK3K3ZD1
	GUoddhDQLvIKoFsxd8W6W2nLc/HMReIsQSkkc8WadJFTaBB9QDtKAbw1gQWt72yq
	ROF6kj8wDGJ09Esfb/rCYzutUz7sh415P5MBLLnUvCqwE5Z5ON8d7ARnBiR6hJDm
	p0oR8JoK2ecq/FHElgc2X1YtuVFgDxX0/UzHp/zQEE7PdYilWwN/UEFFkxDWJFpb
	sKGXarwpsVtlk1ChsTMI24bzJMjVfvteOOoXnWQu02lxRQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenh94wd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 01:46:04 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8acafc224a8so128722576d6.1
        for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 18:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776822364; x=1777427164; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d6qcSACXlaQj5b1ggVkdYa0DKEGMgEtnXT9U+NqrGGo=;
        b=O1sykAY23kJ5q1pnuuv3iaJ2ldQl7ANsB1ymeCuFYoXhzwG71lfjqkOD7kpHcXZjKO
         OVquBNiOYnee/yNfiu/Pci1TZ2uaFKsbZrf1cTt5mu+up2dTtYlWssakmqf/EzYrHWK4
         dGGQZM/GAbKbz6kNl9J42kHPpt2ZiyARliiBWRgjyxNQeBjxJsI4d5E7TcfxWPE8Wz3C
         RE/YPB3q4dYv1+YFBk4/ZftWSl/VebCndUJv1jS6+c8ARi3Wsv5954Vg56eImP6Fn4MZ
         HfSWwo3f1+Ld0LdS5737tr/xBTeCfpNslNS5Po1HVdgDAAiA8CNakFV6mbmB4vFkCeiM
         WT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776822364; x=1777427164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6qcSACXlaQj5b1ggVkdYa0DKEGMgEtnXT9U+NqrGGo=;
        b=lXi/78uO7JCBoWl5ktcTJGrqsnNtnZbnkky59aV6Aq87JpSjfJi2dVM4vSt1YG5saW
         TpPwjjc4hfI4k1IPO7NE/SiRxuwx/1oL4Z2yQx/+sAMticHUa5K60K7PjSKJGhk6P/nJ
         /xIhZMBMdKRaQETuPCXccED5t1iDu5JuyS9zE5F4KBGCXaeqhReqw50EqOuWQtgTExrA
         gMrrNqH50GBEmb1EF4g9ze4LNOsYr9GDDDwM+KTY1ejCpUsenYqy6ny9GJ63PCmKRi58
         HdZQl8y/V/WGLWNq7KTLEYXT2F1QUppgV1ZX5zG/W0OYJI2x0rpwOLJkc6ayeCImuwNQ
         9jFg==
X-Forwarded-Encrypted: i=1; AFNElJ/MAOrKxvqhsBUlBvgZWM8KSTfd9KOKYtu6jPaFE4SiZ5aYPR6uGyas3gEc/yrr+OOu+s9WbA==@lists.linux.dev
X-Gm-Message-State: AOJu0YycrVGEvdhr+bFW+z9YcSUkiGzHQiaXbnZ20UcIp5IKQZxyVEKD
	tQ5DRY0/0FLndvG1B9fcSGqaQtfCD/24pPRRkBj5z9NbTaLRE2SHaw6VFEsneTL+uLl7+giTgg9
	KQQ42bTjxs+ONyINq1BiG+9ZAhP8ZD4N5KOO+v2Cb3AgzSLpC4MhwGIaZ5A==
X-Gm-Gg: AeBDieusVsIHyYcNAUp9zHszmmSF4EhlcnSvBGuYOZ8MtN174vkPFappOPUCh7R69ld
	OzJcP8QgMbL01wkLsuE++6Hq3htRi5y70A6Bq6srwNyG0T4j+mysy3ssABwCMMRRgwSEQpkAOZc
	IszwwPtNh+L68aAPRXiy7+hvDogkUrcj13IrBT7E1EsPh2mxeQzrFC2k9pOe8W+TfSj4Y1LSRvl
	/aqWnQIIeboONKBn+eQyBFzM9bobm2SY3RVl5t28y13q7r4vWu5AaE5kp58RozpW5GfLcnnjJ++
	Ft35ASBotrUJdBe1GJ7jI6Vn4vLf1TA/zT5vWWdzlkxpBsfD66pHMzpwPb4oIMP0wJDg8LfCbST
	3pStvpKiUvek5GmbiomAi/YfwRuaqdelPE2HLGTLw5HLIwjk+IiX+MRhZl4Q3bz3biWOjOUPtGK
	MMcRIdgSkr4SAbG/unWGTe4zqZvf5JyEFcymvMbIQ17Hpq3A==
X-Received: by 2002:a05:622a:59c9:b0:50f:b790:96ae with SMTP id d75a77b69052e-50fb790a502mr69541591cf.22.1776822363754;
        Tue, 21 Apr 2026 18:46:03 -0700 (PDT)
X-Received: by 2002:a05:622a:59c9:b0:50f:b790:96ae with SMTP id d75a77b69052e-50fb790a502mr69541231cf.22.1776822363300;
        Tue, 21 Apr 2026 18:46:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4185bc333sm4131426e87.24.2026.04.21.18.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 18:46:02 -0700 (PDT)
Date: Wed, 22 Apr 2026 04:45:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: contact@alex-min.fr
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Linus Walleij <linusw@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        iommu@lists.linux.dev
Subject: Re: [PATCH 5/8] extcon: qcom-spmi-misc: Add PM8921 compatible
Message-ID: <g7gbtckydu2avjg2on2vx7iez6btgywfid4wxki7cvzovs5m5i@x6uo3ghjysp6>
References: <20260421-mainline-send-v1-sending-v1-0-bcb0857724de@alex-min.fr>
 <20260421-mainline-send-v1-sending-v1-5-bcb0857724de@alex-min.fr>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421-mainline-send-v1-sending-v1-5-bcb0857724de@alex-min.fr>
X-Authority-Analysis: v=2.4 cv=HdUkiCE8 c=1 sm=1 tr=0 ts=69e8285c cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=yfR4zB2R5DhERghfh4QA:9 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDAxNSBTYWx0ZWRfXxSn2drLt32vF
 ChJ9OCXoqVljqGuXQxdAa9mRgMnisFgqpT29LESHhUV1sI7q1GvOGgHERA1yd9yODzH5E1cf+9a
 t3x7a4elaZYOT6+BvEFdHP3av1AkmDZokDMIA1Jb5LqlvK67pI0rXbdxDX0xhnEf+kfSS29JcOi
 qPf4i+GvnGxLoQvbS2wqqt+9jHVYc4J4SvbCHCnTEr3xDVr9tFwQ6dCdnlQb/j5obwk/IrcKW/e
 9fi5xRql2v9GX/8UERkJnYY9108/P41yLRa0EmC0Lxwm/0zt+JMP2E7JAq8HG/KxKEpDca/TlgR
 nzokOFnnNQXbZ1f6yHTcjhh0DoLX/Y9wnLp/5vHIwE/CP/ndSTMvz9fytivtfJ1Gy/WoHdjiS+8
 aRMG2XTQMez21knz2B6wb3JxNQLnglPBEryNQIn6hIODEIDE8vJzMeEnRkrKxH3UmIpngv1tzKd
 t93HJC5VYcEhjOuJ1FQ==
X-Proofpoint-ORIG-GUID: imvPxsF14yJfKKykvpecr6Dx0j-Mc-RJ
X-Proofpoint-GUID: imvPxsF14yJfKKykvpecr6Dx0j-Mc-RJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220015

On Tue, Apr 21, 2026 at 11:45:11AM +0200, Alexandre MINETTE via B4 Relay wrote:
> From: Alexandre MINETTE <contact@alex-min.fr>
> 
> PM8921 exposes USB ID state through the same interrupt-based logic as
> PM8941, so it can use the existing Qualcomm PMIC misc extcon driver.
> 
> Add the PM8921 compatible so APQ8064 boards can describe USB ID
> detection through the PM8921 interrupt controller.
> 
> Signed-off-by: Alexandre MINETTE <contact@alex-min.fr>
> ---
>  drivers/extcon/extcon-qcom-spmi-misc.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
