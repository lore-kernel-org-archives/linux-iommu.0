Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092302DE6F1
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 01:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776822220; cv=none; b=V2k3hu2QKW/QAEx3iF1i3iNkJBKI1yVY2lYLuPzL4ssAI1bGY9eVE/eM9Yf3SYptxoh1KQvvF+5xlHxjehnR2Ao3p6VzPuu8I5geCenBl1rNXXw54CSCwc4Vf0ZTHn1SDJpS2xJc4719jF7Fz8eCNKJPbOdfYZYjzipxmsOMiro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776822220; c=relaxed/simple;
	bh=OXH8DH/ui8xW6txaS8itkY02XzsE7K7pwEs85oFzs00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/mfFvaJDJyGRxThGJ3Ntx3zgj40fWt59Spz1lOTWQA888TieAlWPTYGjuWRBzIsb+yk6A+AoANHh0j9vsRGYPXxUHKBxrBzw0gINqtmsg62Nm7QWuNChl1v39PpVB4KyltgSSXchS6n7MnjGepzxXVOiuVjecylh9RNywboETw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U23XLmAB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VF5O4pkg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U23XLmAB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VF5O4pkg"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LIZukh4051197
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 01:43:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EzMWH3llJFQMU2+MWwxLHFCk
	KmB6DC32H1dvf8Nmf0Q=; b=U23XLmABdobPkxFYtmI8j2BGwsaJk1LImoGE7BER
	clHppV67jKkvNDK7anLP8roPOy/hGKplGiJFGSr1jWoJUBhemTjlEOw9EwvsBlIj
	UFtOeny3jpAS+WxYWvPfg5Rl4JV481wxbyX2UfqRTCVrXqcJzw3sUQXxH49cnc7d
	UoCHODQFpDxCElMc/gD2/Dcxtq3wwrl9Upf3iMtg5osGu9iZFtjTmMJSvBftWpBg
	Ge3vtt/RIXTuBpv8CEM9PDt0vtt/kiuSLR9SEq9Cc2TyoIQtyCcLPUF+99+SGXmw
	X+3T1FQ0x2eDMuK/pM7IlXRUQlIllGkyl8n9xrYmt1tdng==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenfh62m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 01:43:38 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50d826ed6f9so25923611cf.1
        for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 18:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776822217; x=1777427017; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EzMWH3llJFQMU2+MWwxLHFCkKmB6DC32H1dvf8Nmf0Q=;
        b=VF5O4pkgcZM09V/FUdC6F4DYmU2OnVyUJ7Z5m3h2FcD1ZukM5Dck16ecQxawZjVUiD
         fghLnUw8P/nTK28a4CrqIjFVkg50wpRd5k90b2S35phMgSVbrbrA5lT0/2bjBEghMNi9
         aCThcZVEN6PBnW2P+8tCixkuHq5aHE/p11hxcDZleToW7dBHJylYojQUz4FM9Q9ziAsN
         ddaWKBwv0RrzAg52EAY2UOlhTCwrUBCPT5BEZqWDC2IZ9KKoUgWC4LJppjhyXmG1FNrC
         5B2/3gCapni9tza+oU46myj9EsWCoiRn0zguciX91QJYqFLNWohJQJUO90fmFD5mtkGv
         V1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776822217; x=1777427017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EzMWH3llJFQMU2+MWwxLHFCkKmB6DC32H1dvf8Nmf0Q=;
        b=Cs4xOfGPEWTFt7txg1aj0FyvQCDjb95MDfeVk7+vxIt8dQVGaaJtuupd87WyUGxpLr
         KyP4lFYm2F0Q5Yea0LPfr7qMfsQKIWa455WOM3iA5+0aN23teRSY8/lFJfZEvHK5CiWC
         1AAsitmXV6k3KEx99T2MRl2W8f8Bs0V0pE9L/Hm6EQLAiNvUld8iKSaqFsKqLRikXphr
         /IzlGF3CHm7jPwCuP2PAINdQtExPGJk2lYEGYKGuEWCsKcgFKB/tnaABmpSd3+RmNwnR
         e2pJNcHoOjHOdQfFcyodC8waGMllFLjfG1SSy5M3fDecXe92FS/8iDqRk3PqSWcvqw+G
         6K1w==
X-Forwarded-Encrypted: i=1; AFNElJ/I1pjIG48/iFaCn0b5XPAVpvGscmsQBT8z5+5J9+P3mrV2BT2KjsH/9SGnTrPSndElpxpmRw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzn/e8CxL2f41HlIMP3fAS8KlSD7eJ1++RfPIflwkpBjHNOEDLV
	Yc3aB4XhI2Kpc6fs+IMV2NyBuGZLZ4Qj/4ikt2hhH0+OWgZkM63XpITgbuO2Ga15jLKNpE/+rFn
	4IpPZQU+UpqAmmDVbvkMEYqMQsLOSN5oNji6RGXfnKwFU4mYclOy2u9j6Ag==
X-Gm-Gg: AeBDiev6ec6KmDlXCRXMAVdppoCDHzcR3Ig0T78Hdd2AAR+/d0qOmdnR1HtNZPZpP2x
	O7IHnlZbS9HC6T5MCvtnnkAvsRuFQ1iIn6CJodl7h2WsvsML5XH70z8BmxEgTiyTMvD06B3VWE7
	I51dB7bOYPIxh07zb8hgtVBVAzG+g6AizDwGwWKre3VSJB8dyDVlolnepusJ/pJ+9eZ87L0lshd
	WzQLMQwGXXLcqYehiYlMJmmKF5fnlqlrSBZz/+pq2Af0JeqHHLkB/ifd/puEk8CKeADwo3nZs0J
	EgvHtNP80rmgOGc8qUJYMJA85kY6x+/EYCGdnGHEAq0xhfCIBpWQRi7d6xgD8S0dOZmNNgkrSus
	+ReHq6wsaWtfn1HZZB9BYzZxjtLFgoZfHRV1ExUOQ9HQ9kx6//s689gW8ruAbvfeXZjwoghJeXf
	MGlwy4m3uGym9129E9+/MZ+xKabYkdvq5IIOwtCjnApyeApg==
X-Received: by 2002:ac8:7f55:0:b0:4ee:1bdb:a547 with SMTP id d75a77b69052e-50e3664bc7cmr277776661cf.14.1776822217233;
        Tue, 21 Apr 2026 18:43:37 -0700 (PDT)
X-Received: by 2002:ac8:7f55:0:b0:4ee:1bdb:a547 with SMTP id d75a77b69052e-50e3664bc7cmr277776341cf.14.1776822216746;
        Tue, 21 Apr 2026 18:43:36 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4185bc297sm4026483e87.18.2026.04.21.18.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 18:43:34 -0700 (PDT)
Date: Wed, 22 Apr 2026 04:43:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: contact@alex-min.fr, Bjorn Andersson <andersson@kernel.org>,
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
Subject: Re: [PATCH 2/8] dt-bindings: extcon: qcom,pm8941-misc: Add PM8921
 compatible
Message-ID: <7zumbrohiu255tngsebrm5bd3xthwrgugqa2re2ewgxydzlflx@j53a5zj3yude>
References: <20260421-mainline-send-v1-sending-v1-0-bcb0857724de@alex-min.fr>
 <20260421-mainline-send-v1-sending-v1-2-bcb0857724de@alex-min.fr>
 <46a322f5-db18-49cb-afb4-ec1a5bf23717@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46a322f5-db18-49cb-afb4-ec1a5bf23717@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDAxNSBTYWx0ZWRfX9v5Qk9kFzvOT
 DNUrGOUCGnq+bfw6edXn95NjBQjXYQ+o7XPbwgHl8dK0h1XhhVP+6kcgrREHP6gwQx4p2fdQQF/
 /UjQFixGGXo49jB4ULV/T6UmbgI2tiYwhcloSVB/y29XUZamqWtuHXIHyLHd6Sb/INbx9U0VoBm
 IQqotoHsQ+SC5HoA6W02aiyZOTTkRUDUZH4LeCdmM/2Ff4MA/E2gwrRuBY69ydSEKtF3QT7pzjS
 ax7xm6ySa1LuM0UBEwL6g5PLP5PoKiTPnbK/hiRWyWa9TtJ7jOZnNd444Rmw8Ya40/fU8N75fvw
 EEztQ/mV3uphP6Al4XTE60BvA5PPjKZcLAMqfaIsBpo1sa8C04s5T/Oo3kK94XWITJ3W5omU1TH
 FczvREU+gPi+WRsvfWufZDZ0gW+Ig4c4RjncZuefmX6z8f/F3pz/LxD/v/iioXpV3Cb/DsEOvde
 DgAQ1ON3ifwXSzVxcOA==
X-Authority-Analysis: v=2.4 cv=VMrtWdPX c=1 sm=1 tr=0 ts=69e827ca cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=F7yC289sF44U6c_-gYkA:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: 9sXFVio1pKS0Kyxpsd1BwXBHAiI3CEN8
X-Proofpoint-ORIG-GUID: 9sXFVio1pKS0Kyxpsd1BwXBHAiI3CEN8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220015

On Tue, Apr 21, 2026 at 12:03:36PM +0200, Konrad Dybcio wrote:
> On 4/21/26 11:45 AM, Alexandre MINETTE via B4 Relay wrote:
> > From: Alexandre MINETTE <contact@alex-min.fr>
> > 
> > PM8921 exposes USB ID state through the same interrupt-based logic as
> > PM8941, so it can use the same Qualcomm PMIC misc extcon binding.
> > 
> > Unlike PM8941, PM8921 does not need a register resource for this use
> > case, so allow qcom,pm8921-misc without requiring reg.
> 
> That suggests this block doesn't really exist on the PM8921.. I
> can't find any information that would suggest otherwise.

It actually exists there, there is a USB-handling block in the PM8921 /
PM8821. The IRQ is present and it is expected to be used in the same
way. I'm also not able to find the actual registers. The closest one is
OTG controls (0x6e / 0x6f).

> 
> Perhaps what you're looking for is "linux,extcon-usb-gpio" or
> "usb-b-connector"?
> 
> Konrad

-- 
With best wishes
Dmitry
