Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5291C466B48
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777381887; cv=none; b=QL/REdaRYRiXsThtLa1HrjfjOMNpu1xOFI3mZoTVs/OyNpHRHOkv3r0AeYahgXLXJ97fbSjBfTDbIrvFsSTaAtbzCDUAlgmIM2J8CnfSYtayKab3fbWqt/2EpoKHfmy4XsIY57oi4L2m0dRiiNPoaDIBR42+ZMEmF6whbf5Ipjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777381887; c=relaxed/simple;
	bh=ZV7gQ+vFpTm462vRo27QptIK65cykKtJURR/0mqEpwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzNlHGBOd6EH9AC4WHk161cybRxC+q8TY65uF8ELNdFQ4b3ozWVFXGeiUI9YYHgfA80qoibzikmWKqPYfrxJAUqm3Fp1/OfZXwCUMYNhK4Wwx/OH4uq8e49zuP2bHrWUB9xfqRArDo6R9iTpp8uHgbQkfsU8VaNYEtjpPFXR5CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IuenkFNs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fot877qj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IuenkFNs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fot877qj"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S7vqtS1744980
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 13:11:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=blI+99Sh7Qr7qWaUiHcHIJCf
	MzzoY5IQsQhu8lkmxlE=; b=IuenkFNs5yI+oKkt0osCDt0wUaVhV25n5hAcHF0V
	URW6M3IHAWQnh7kQQkqHs+a1V4UV0e+ts5XYjdYbDUhiDg8KfnKQ3t7zLdzR7XkJ
	9y27+IO7EoWvTVNwtaa33TRmedPPYbU0xSvMMdedStAImjXzh6ej66x+LOeZtYKo
	uJpBYAE4vGtXC6MvcDgFquPZ2GtDsyrayRy9M/e2EzIQiGWskScZ78idBw7FtOIB
	LNMnB0h7JX2CILYrhQu6+MoRFfPYhZLHU3Ry5mo2SMbrCLYZ+7mje46zDc2yT9Fq
	5469fIzGP2D0p2xksoI5P6FLbWQ6GKya5hJ3FDtJky7fbg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtryd97ny-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 13:11:25 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so13782109eec.0
        for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 06:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777381885; x=1777986685; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=blI+99Sh7Qr7qWaUiHcHIJCfMzzoY5IQsQhu8lkmxlE=;
        b=fot877qjpFJB54ZE/lUGNPW8vzfaAac8D7m0r2dMGJvXYhhYz/bhp6mqTpABZSr5XI
         +uV4Hw5ky2kOXzKehOFzrZUT/bwINgEB/viRspcXLL45I5We1UqSKqFE8myQhm9si8QL
         UrMkQRnQOFDex0byr1kzaIHeQL0JvaZpIm8QJG+nBUKYjdw+POiwsXGs36eGHMAJQljn
         MSssVG06YGUmCA9anT9NSG52GawKrZoHIjXCq5WhrGoFV1ew3ImeoLV3khwuvAmkbSwd
         7tu6koXyKpM+YtiudLpkKxEBjiSoY9vIrTOGxlyl5AqsGvmjDrh51oGPwqx3cbPIeACw
         iq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777381885; x=1777986685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=blI+99Sh7Qr7qWaUiHcHIJCfMzzoY5IQsQhu8lkmxlE=;
        b=NLet1gd9ADr3kr9HZaJ6tMhNEJxKTpgQLGDOfeTT9GDrXEhQXb3umu8yhcoM5wo+wu
         v3dTAp0CJLRHn77mZAaHUB5YPM9ZV9+wOp7GSbQ+CPVm/7Vn/taowVzEThfKF/j0CShn
         8GTP2dZPPtrVJtMXVHXMuIsN/T/boVaeAtolkfX7b+aFkTEuw/+Q4JHujsq3nHTmyyGN
         t5f9V6uz5vkc5lPGwhDTQvCVQeHCoggYSHmdppfmZlqLoCPWvE8pI12To8AWTMCpJa/a
         b5tZsdmi73O2p2Q0oqYY4T9qbuy7NE09hOMSSdrjkyAdaIrBBvRawKzdSpYSTuHocKS/
         vAmg==
X-Forwarded-Encrypted: i=1; AFNElJ//cNYSg8TuX1aH4ftVGgonQQws650N8K6ddXMhFBeAGJsrvOADymnO6oB7rxZ0g23bikyLQg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgAfk5Y5fgyHFAsnlJitsHokBYarULONQFSMXdMhW+7bia61EN
	LnPBdq+AXdqKXqlw2ft0cPC02oPbeCa0pTtkmcDz9ZKyGyI015x+3P+A3zmVp/hNU+tJ0p9JQ2B
	5Jan0jBazjXSbtSoNMZRt9K1yPDKYFZg8fawTDnE6qQdyMXtAlaHX2eYBOA==
X-Gm-Gg: AeBDies5hz5QZHWBllBqMmHymSdEyBGqzAO1Td7IvCW/q7tbrOwBwk5LjB/60tMccP8
	ak5DWeuL2wpZmro0Ne2ZRo1ZYftL0B1OLHG0cIN1Z8o2UzjnYnISZbQ9bHXNQixoQehrGPhV+AO
	W17EFOLAbpHTL0Qz5JUWFqa+s2yBzdHAVHJZJTMIbvPS1dTeDLVactyKNAgQTIEX4ddbBbq0Asc
	BhdAQI2LGknxSXxkNflm/6H8hdcvU8rO5t2Trsv4zK6PUFObQMrhzfD6MsJhTQJwYJ2NkpEY2ja
	eYmAlVOuf+xTOmJVCqfjEF5wh6AiUxVJTkK7hM5VtI3eehTcsIjoP4oodkjp5cdzOq/MG/6abU6
	PtUfxEHINlMgvT3kmS2UwXDrCnb2P/ciAD51cyQW8Yw3osEjSS8J3/h9eD7ZBwaFymRV+STNZLr
	I=
X-Received: by 2002:a05:7300:e9c9:20b0:2e2:185b:87d9 with SMTP id 5a478bee46e88-2ed0a200d8amr1091280eec.20.1777381884652;
        Tue, 28 Apr 2026 06:11:24 -0700 (PDT)
X-Received: by 2002:a05:7300:e9c9:20b0:2e2:185b:87d9 with SMTP id 5a478bee46e88-2ed0a200d8amr1091253eec.20.1777381883972;
        Tue, 28 Apr 2026 06:11:23 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed0a0ce761sm2214447eec.15.2026.04.28.06.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 06:11:23 -0700 (PDT)
Date: Tue, 28 Apr 2026 21:11:17 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: arm-smmu: Add compatible for Qualcomm
 Nord SoC
Message-ID: <afCx9Qwb9_gffTtK@QCOM-aGQu4IUr3Y>
References: <20260427011728.231026-1-shengchao.guo@oss.qualcomm.com>
 <20260428-tricky-magic-koala-b21fed@quoll>
 <afCus0_JslMgwdlg@QCOM-aGQu4IUr3Y>
 <b65fd25a-7175-4963-b623-7805979984b7@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b65fd25a-7175-4963-b623-7805979984b7@kernel.org>
X-Proofpoint-GUID: H3zTQ6QFWjliJlkjf3j2GENFu0W3rw4Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEyMyBTYWx0ZWRfX7j0zXngeR5/9
 uhwaEhJ3Eog2LGWG32mno2GkMXiXm8IxLG6VkfPh+HBQOBTbWTD8xAyebDutj2jpOmlRC/Mz5dB
 ZzQcmWgLukyP6kmq1oP45qCcW2+SjD06n1HWVXoxFwrdXtcrXP+bfAauKMLvo8ItTmJ5RK1NcS2
 4RjI3kZaRs1UpXQr8hr5vWYLMg1e02yRmGp4IU7EcjfJE+oECXiaOeSGwN9+glYBCWVK+Cl7FFN
 l0M+j4zsYeCpTal5v7eqlvCnr1H13oELV/rhKo1a0gggNglJTcHXBE03RFbu4sL1dnZ8GJNiUm8
 iZAfaxPHRwgZ3UabING2oobpvjSp/wswg9XjHQiKyvSIeVwb+FPg0IqKPzy/kLnFvd3Dn0dpoSz
 4exP/yMlEoQ51KugDluGT/G+GK5IpodLQOapy8GaCHXVK34eT735Y1wzZ3t6E7Z2xm5EU+tzIA8
 WFFvzGoZqUDOiHKRgXw==
X-Proofpoint-ORIG-GUID: H3zTQ6QFWjliJlkjf3j2GENFu0W3rw4Q
X-Authority-Analysis: v=2.4 cv=cMnQdFeN c=1 sm=1 tr=0 ts=69f0b1fd cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=nc39diHjlmVoUhwZKG0A:9 a=CjuIK1q_8ugA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280123

On Tue, Apr 28, 2026 at 03:02:13PM +0200, Krzysztof Kozlowski wrote:
> On 28/04/2026 14:57, Shawn Guo wrote:
> > On Tue, Apr 28, 2026 at 08:20:35AM +0200, Krzysztof Kozlowski wrote:
> >> On Mon, Apr 27, 2026 at 09:17:28AM +0800, Shawn Guo wrote:
> >>> Document APPS SMMU on Qualcomm Nord SoC which is compatible with
> >>
> >> What is APPS?
> > 
> > Should be APSS.  Thanks for spotting it!
> 
> True, but what is APSS? Maybe you meant AP, which I think is known to
> most of the audience. Qualcomm names are not known outside of Qualcomm,
> so question stays.

Ah, I will expand it to Applications Processor Subsystem.

Shawn
