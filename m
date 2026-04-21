Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE9930EF7E
	for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 10:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776765825; cv=none; b=VMaBX+GbHbYIZOq86D/Q29dFMEY66US00mzutqMgopU20Ez2wmfkbx9UfOWEQSyL9XbPRz0P8zTZ1VbXHtEXQ3WqVeV8eUFieQe0umz0IdMGl/iKFH57pFfuqyAQsYh/g18fJlkwetzu2Iv5yANQsq2SXOxz80ZqrpcAqZ5aT2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776765825; c=relaxed/simple;
	bh=fUoxY+osAZD3kce95kAP6oBIib9fL/J8fl6XUc8AkO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q9sRe/y2o74dM46N/GPQdWagS8dDe2tz+eE+DZN1bkgFBGHG8syYY1UuSYUQ5pcRyk1eWbi4ewUwsUKsht7KzEgcYUDUpuAb2T9oPg/bFKpT/cO0qBeAdDI+kQwmkAhqggosb7eCCtI+f6a2IcPeQI9eDZlgBCR1pFLsl854tOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oQinYadd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fNg9Mqi+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oQinYadd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fNg9Mqi+"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63L74LgP1538545
	for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 10:03:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lsBGUUumBzahguNfhdaERVA35xazIx6Q5OSh6tsxb84=; b=oQinYadd4rkxwUmd
	XWTTOtGmXCjbCAW7OKbU3H6PSL29CVypC3IChafirLUkdzfQuj16GTbgh576GN4/
	w31KHH6WQ+g6nZ5bWUNVpdHGkyfhU/PA2KuRsnh7rc6PnJRkXkqacty04PD+3iXO
	LxRnltAtSWKjQk9JSuu4hXEAHniZMFST0tvtk0pMzqiUaAQwHfWMllHZxyTy8EqO
	esyWMgRA92nHb9YMqqzFVg8TysmucnzA6QVqu3GhsHwNn65q7bj+pCvdhVKh/fKd
	MCCewVw7prLFMBUrTwyEdnnJDb0+IGy3YTlNgz6q16j/79X2i+ubn1dwXkvekwLT
	A7J1DA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dp4hagpjj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 10:03:43 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50faec938fcso3542011cf.3
        for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 03:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776765822; x=1777370622; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lsBGUUumBzahguNfhdaERVA35xazIx6Q5OSh6tsxb84=;
        b=fNg9Mqi+DXkG8LcicKA5nnQElJSHXzL9vF0zRcj7/6PcA1sa4fPMUCGFxhHjpVVrNm
         817tCv/AtQop2i/cL4TlnaOkoU9RNSjzuJ+/6cGSbh/U6kEBs78iJJ3JoaP6G6Hqejrs
         YzxH8gDn0QWpEive77Ab2XH0LU9ecLd4pgrwYd6H4W7a1purHeQNY5Ml4yteCS1xC5OC
         DGboqAmKz7AK22BK61pMS5jIhX1lRVps3osHy9VtlDDhqOqCYAKxpJdEIec5waSQmcHy
         x3UlYS/wJ1pouQIWMYPdvS7bu1hy4185jalubftA0sOHFGVK67In/OVqlVYklFbAEsB9
         O1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776765822; x=1777370622;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lsBGUUumBzahguNfhdaERVA35xazIx6Q5OSh6tsxb84=;
        b=Qm/UEqkHgPww6RbvXBMV5sU1TgMiLX7ZD4BRpJuFbwtKyblIneArZTuT+9GkH320Ik
         OoSjTgACu/S3XRbXUVBOotjGccNB10LP6dzH1gf0F4sVL5JsyBFYV+tZosds/5LoU67z
         tPdm5DWCmLkKn06SSVXx/LzB3zQuljiw8WRoziB90W5VhLe0wc6301A5Zu3X5FheZePA
         45xmtRX6rDreFmCoNIODohs3gE6m0TZx0pIWqQ1PcCF0G4NKefqt4TN2ULo63TpK4m8A
         M0ULPNWkbno5H721JZv6Z1vUnxdMGnW+Ce2ouWSrQImkjvTmHI2nbkfljjfrHz+zSXdu
         Yw1g==
X-Forwarded-Encrypted: i=1; AFNElJ91a8ITiaGmgdEvH02G1Vif+I/VmbygWi88WdR3AsbmYRX5Rx7R/uVazCdj1StYGboCYw3+AA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzpY8Gw6So2+46Mu1ajoW98/4eOvBEwV0XT7UUSr9eOjF5waCom
	7PPynT93VxDpPv2bmHpMQeyeTXijSNXtfzM823tB34yUfZ5SHRviqFF7oCO8TG+m8fGeqI4w5iv
	kBb4pj8H1kNWRLZAOHUS1oiTa4KNEFGBliwkRI87ynqgXFmy5OQtmNanMlQ==
X-Gm-Gg: AeBDievu9XOlZ803FLZ2+HX/OUSMAhYTpoBkgxGT+EObnFGtD9V7k4OUGMMNj4I8rkD
	oCWdV1UTUMd8pZM/yKMClOOrseOqD3GzsxkbXE5uS5C2jMjc8usMVhpjIzxqV5ntFC3TARSZDBt
	dfLZ+8natUEXkeHbnaIQeYUbvjPyYZnaP79fFEuHe50ncsJxGZKbJ1Kk5/GdBx1/efvQXh7KcXK
	T2xExWWAyByEShchGEkzjB7vwRIJodzqI5a/MHZZq2XwtlEdo/DTjtN+G9tcOPahM+UChlrvQQ4
	lyZkMSQAjMDJ+U28p3Zzha/k64qhmHPAQdSuLgAaRqJZl8brjOikbALUyKvfXyPwHoH6XGosan2
	ho23IwL63uJwGmquZJh+ZgImSc3rBgPGNcekxdMtqlI57kDEp8gjGwYnTCJr4tMiDZo/nSeuwQQ
	Y32ZDm0oPqMkBNEQ==
X-Received: by 2002:a05:622a:44c:b0:50f:a53b:9d5 with SMTP id d75a77b69052e-50fa53b0cbcmr44662341cf.2.1776765822301;
        Tue, 21 Apr 2026 03:03:42 -0700 (PDT)
X-Received: by 2002:a05:622a:44c:b0:50f:a53b:9d5 with SMTP id d75a77b69052e-50fa53b0cbcmr44661851cf.2.1776765821742;
        Tue, 21 Apr 2026 03:03:41 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-672c480e18esm2586174a12.10.2026.04.21.03.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 03:03:40 -0700 (PDT)
Message-ID: <46a322f5-db18-49cb-afb4-ec1a5bf23717@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 12:03:36 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] dt-bindings: extcon: qcom,pm8941-misc: Add PM8921
 compatible
To: contact@alex-min.fr, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Guru Das Srinagesh
 <linux@gurudas.dev>,
        Linus Walleij <linusw@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        iommu@lists.linux.dev
References: <20260421-mainline-send-v1-sending-v1-0-bcb0857724de@alex-min.fr>
 <20260421-mainline-send-v1-sending-v1-2-bcb0857724de@alex-min.fr>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260421-mainline-send-v1-sending-v1-2-bcb0857724de@alex-min.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=bOQm5v+Z c=1 sm=1 tr=0 ts=69e74b7f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=-ROfvrG1s7MAeRIb7yAA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: AhWH1tBBmL_qeLZFdXaWF-3bA6o46jpO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDA5OCBTYWx0ZWRfXyuSNtfGXgtZZ
 S2+mZ5DHnwkYdidbG5P58gL/vNPCa31KGl5bxQA8a8K+FWSzi+xQr/dXAowjJIdBEMFdgiIyZPF
 eMI5WYqvvlnoFei6xNrWTg5HzvF1HKHFtry7tQ/6Ky4m8Ep5Sd53yC6tXee5U8VOXkTTi8mnALy
 Lt76WvH5V6/3AzJCGVleStASRvs1+PmbS1oREPt468jK0uryPgqn9pdtmjvw9KpS/KVaDvAstP+
 TWcJQOAxLTwGDRSySegN+bv1hY2wdoYeQLwKT9G/Ke7bCcM6iKmrzgG7Rp0rHWvrU4tb7uyKVIa
 WtX8gtaySHP6O4fX/bTLKo63Kd7S44ahhbjFoE33nvPUa7vu7r+pPFNtujWlYPJeQs0ob++/Xi1
 NgvMV6mKMEPxbp+pQTCW32ZXGdRdFj0sjH+Fx1+slrOk28EcFffJ2gZEUNyCbG4SNMeQG2H1RGM
 pDWRc79tZiRRBCsKxiQ==
X-Proofpoint-ORIG-GUID: AhWH1tBBmL_qeLZFdXaWF-3bA6o46jpO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210098

On 4/21/26 11:45 AM, Alexandre MINETTE via B4 Relay wrote:
> From: Alexandre MINETTE <contact@alex-min.fr>
> 
> PM8921 exposes USB ID state through the same interrupt-based logic as
> PM8941, so it can use the same Qualcomm PMIC misc extcon binding.
> 
> Unlike PM8941, PM8921 does not need a register resource for this use
> case, so allow qcom,pm8921-misc without requiring reg.

That suggests this block doesn't really exist on the PM8921.. I
can't find any information that would suggest otherwise.

Perhaps what you're looking for is "linux,extcon-usb-gpio" or
"usb-b-connector"?

Konrad
