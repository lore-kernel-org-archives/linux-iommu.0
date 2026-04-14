Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C243D7D93
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 15:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776179775; cv=none; b=gzaQAyvWNAayXxl+PFVdxlkA9LW4PfC4sXpm6e0KEl8gPoVjpQBho91MHlYiofFcxXlRq69WWU/Dky1llloMRmBkeVS6SYvWv4b+X9SPleAhOGNZu7ictno/M995jXdw5fMSgdO4VrIrdK0R1HkSnp/Bh2EZkeu83mF/I4LLMyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776179775; c=relaxed/simple;
	bh=GudSgVh5zGLUJIOGCDbMHamjSv/lulJ9mtwapINd6Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=paURDUe4VwBoFnqgLjNpWM8OGAJ+V26iELUwi8PtA0c3rZWDlSSKu6iJC7tQq7+mvE92wW3xlSUJvMWoM6RfFWQ5GMjQkfVjYueuqCMjt0OMxO9e2MwkNqBIE0NeSiGJ61II3ih+vqtxpA85ZyoRM6h4/o465bImYS5VZ/COlik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QbYhIVGT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iVh8tqEp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QbYhIVGT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iVh8tqEp"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EBl8Xf3505282
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 15:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Y2iIaBupa1ZFZoZaC493mfOp
	0zJnBLl7xcKpovJeqPw=; b=QbYhIVGT6CYES30c+BcksIQO4IoTyS0q0AE9Rgk6
	jbF6f6NtPvwVCgHojdo7aoSf1LxqwpLYwszQZsO0f58ixnO5TKRVjtSK0ZIzlqGM
	xgjj45B4VmaZn2fWZFTWWs5SYbKO8qJWJbqrmtY1G4Wydv+J/eq82EqAaxclu6Tp
	NHsqDvrc3HlYb2mQy0zNogC4ZW/qGFAIDnpguGH2lAbaH6RAJbt7mR0RD7PGIJ9j
	rWkJUvYlLfYYYgi5prNfhOK1qUYhfY3NmW40K0yRv4AH3KRp2J0aTz5nmH+XbPbG
	TIsPM7Ynj4n5uVAa/SGOQBWNbo6B6wQCs3Bcsx6KlUEGug==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh870kb2w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 15:16:13 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-46f083f82c7so9346100b6e.1
        for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 08:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776179773; x=1776784573; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2iIaBupa1ZFZoZaC493mfOp0zJnBLl7xcKpovJeqPw=;
        b=iVh8tqEppqtVrFOVrLxuRcphop5yNKP1CWg8Qa1GoUUvKcKrKJKleQ4mvD6JpooXJt
         AZyQ5ALS2t5rhdqWFjHxYP9Z+tmFAPqYoMjFoV0UlRz9lJdKrF0f/oWP/Op5EnDIQ57B
         rdmeWc78+a1a9v/C+HrJCqoWaRfcI2n49bUHCRmpHYRT6IrZ6x+zbjYumCnjkVqGYKWJ
         1NmDYSc9yEbfeAxyJKSNaupkhcCcredQG2+h89dJ4kINxFWw11oWTdYVMsaCovov/Xp+
         +vfTl1l9QQT1HOnrN1NO1kT2EwEely+GuwHG+nD6U1BXISXdqH1SIm4/YQDy5vVj3Wxy
         wttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776179773; x=1776784573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2iIaBupa1ZFZoZaC493mfOp0zJnBLl7xcKpovJeqPw=;
        b=YFQpYzZMOIzOv4nyMD9Ua3cRn3xJpuJQxgoyRHyhLWCBQ9qk4qoDhl2iZ0hjmwFbjV
         ynj2kP1EnfiZ2+req3N0zsnTuxochMmsUKNEeGuD7NbGp8M9HUFmneLKmmUvWr4vR7fR
         RMEuSerGPret+4RApSpvZmAtzAB/3MKtrv16gkckYwV6i525YRhlJSRS62ZiDgCLOxBh
         RZSU/x1axdOLq8d2kwXmW/ovLQkZEAqbGfimnT3s6YBbgMfJ2oDecnYI2B3Rw813CP3+
         MB2cpxVGiz2w/fQHmelBnh29OusVqofNhftt2XIw6SaNnjwYpSnC1HKAzF4x0PegNeyj
         Q0qg==
X-Forwarded-Encrypted: i=1; AFNElJ+nRBayIhX4bDObrIRu3/i89oC2g3KJU1qlv2blnPYw43LuYPZWkgWz+svaCuLDFsdWKuf7/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxj3nhI7bLUJHAq5BrqbEbDbR/txgldJRTIapGv7muq1zSIjfca
	tikS4aN6qPieOz3uz7iKTGkhl6LlRpYJP8SyI+nXgAcQYdZB0EmxiJfBVWzFpDk8hSGlOZFMuts
	c4m9tVP22vBqBNfRpbJGmk/a9T18pbRP4yGk0zxvVc3HCBoHlfYi4SvEtRg==
X-Gm-Gg: AeBDiesbYPoIysJDdchuDrmfLQAEw3HwVBdOW/0dOUPy7zA9WpcVui9eAdrVOIqLH2i
	YWUeUzd454uML01Dff+4zV75lMraMYyKfHtT3/UBY6FPIZKWqK13lTHQuQOTl0zv0wORTXqRCPr
	dBngVw4GNlidC0/z+3NuCgduMb/a8Z3C7kpaXN51x6wROJO1CZBAMDN911HtnmEseehtXglG3V+
	xNX93hgF95QIERQ8Z/nN9B1+WTl0RpMTVY5gR7exVcSdysBqmz+zXxAJojxDaL2dHPQuZyT6nZW
	G8ybZ+zh5PJ0AGILs7r++0F+qvqvwKBreS3Ac0Ar2W1PNKfcl1Y3eqBu+wHNVtc4i56/NZaYiwx
	mAEwxSOHBRaOA3h2RU0M3Vqmn/kT4eCqScJBpFP79GbYgWmqmJUKqSTyah96NM71hTFMTcEs9N3
	19PF8HKt/DpKg/AD+APTd1qUdVAeBrlEbCXgjoqOz39zaDvg==
X-Received: by 2002:a05:6808:f14:b0:467:f56b:5267 with SMTP id 5614622812f47-4772a866badmr9869326b6e.10.1776179772774;
        Tue, 14 Apr 2026 08:16:12 -0700 (PDT)
X-Received: by 2002:a05:6808:f14:b0:467:f56b:5267 with SMTP id 5614622812f47-4772a866badmr9869302b6e.10.1776179772241;
        Tue, 14 Apr 2026 08:16:12 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a40006d23dsm1131145e87.25.2026.04.14.08.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 08:16:11 -0700 (PDT)
Date: Tue, 14 Apr 2026 18:16:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH 03/11] media: iris: Add context bank hooks for platform
 specific initialization
Message-ID: <3vuensoscjzsjuh7c5e3jff5cej66iwboiau7vhnpvtmqevexf@ouox5cize3fn>
References: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
 <20260414-glymur-v1-3-7d3d1cf57b16@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414-glymur-v1-3-7d3d1cf57b16@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE0MyBTYWx0ZWRfXw9GcthjAmM4a
 iGo81pUM45qmKUtF29YFHT/EFPasElthZHPiVuDs8ev5kaLnKC5eMIezfuXHQkjARWOCTkPrJfp
 jZqRDFAT/3YMSgcFwhnW6iIaPFJ8/I3bNLAm6zbslTf/zxl8JxP9lGMVAkpgBIFTXDCW2Mr5Z5p
 UyIH5PRShL9Jh1KT9TIWIH7TmiYMlmatYrJ8gnN6hCZEGT8jzYmMvwCrXknPS/Wh52YjBhkdoMM
 sJSE543IClR/pRnEtUfbH8/9NsgSUUVCef7C4WxAnfYBdG0dMYcU8qSOEPoCFbGFJFdK54b8/uT
 H5cgC+yw94Q/KNFm4KJnfAoKn2r82Aq86x2xgrofOMH7dHlEDBaIf64+cetd4WlFmKCJepNIoU+
 Legxk5vgIDjOG/ISWJ8M1LkrzNSlwf6pfoDK5BXG9rKg2uzeLfwpCMqBASvv8j91rvm6QgxIJVQ
 PMKpG9N3LO4K/pHq68A==
X-Proofpoint-ORIG-GUID: dEHn_Bev6h5U4-nFqzm1w2fX-gzPA742
X-Proofpoint-GUID: dEHn_Bev6h5U4-nFqzm1w2fX-gzPA742
X-Authority-Analysis: v=2.4 cv=btZ8wkai c=1 sm=1 tr=0 ts=69de5a3d cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=Y-W-850UrnaCaRLArZcA:9 a=CjuIK1q_8ugA:10 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140143

On Tue, Apr 14, 2026 at 10:29:59AM +0530, Vishnu Reddy wrote:
> Add init and deinit hooks in the platform data for context bank setup.
> These hooks allow platform specific code to initialize and tear down
> context banks.
> 
> The Glymur platform requires a dedicated firmware context bank device
> which is mapped to the firmware stream ID to load the firmware.

Change the order of paragraphs. You should start with the definition of
the problem rather than putting the cart before the horse and starting
from the solution.

> 
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  .../platform/qcom/iris/iris_platform_common.h      |  2 ++
>  drivers/media/platform/qcom/iris/iris_probe.c      | 23 +++++++++++++++++++++-
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 

-- 
With best wishes
Dmitry
