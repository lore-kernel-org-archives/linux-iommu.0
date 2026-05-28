Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F893D3008
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 10:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779965659; cv=none; b=IqFT7q0tfU1r3xtzRafNHJjd4G7MJ+ae8xOxVhkxLU+1PGE/Dkyx+DmX5BfsBjP5K1Q0Q9cALKAQFuWwNNjdFpRLTKrpX+ATOLwFWsZae3G28tQK6cjfENLSV8Yn3ZnJqaweIZ3BrqqWtRsl0C1bNQhr7t0QQdh3e0/fgpMmW2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779965659; c=relaxed/simple;
	bh=9/6mXFAAhO2tRIOZlhxhLb+vSG/NojXk9g/I4t0WrRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCaIoOepPnfi8Je9K2wQ4YhWZIS5X0R9716yD7maH+igUDc33jVL2hAXfiYwPiCzVyxm5AFQ5VVKHRxAUeZGyZomXcoVt1buuHr1ax1G66qxhvm24bI0SvPYoQ/2tMzeeVaIiHhOTIAZtvGkQ7lBAEahIylIZXtcgRmVrm+5XMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SCREy35B; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EDcG+7w+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SCREy35B";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EDcG+7w+"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64S8vqHU124459
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 10:54:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=c7H5I96ycPpsQxz6/8ab0XAK
	628/IR++y87MWPDak78=; b=SCREy35Bj80/2+OiHhJIHsKys92exUs1Iy8E5gvu
	9ybzNZR87KvN0D+n+POE5LHbtddZwSDcNC9jxlRu/YZxGVx4xRZAXIAhlBY0ZkTR
	VebdrD810dHjJFaKXDF5YVN2tiDw5ZARcxWScqiqXLucKvxs2/w2rj+M9kpkuXGq
	xAGGN7hc8fDFw7dhhrCYMbG9tGpWJQAKVfpum3JUao93PigFNUF9vVPAuinAxw7L
	1JpzffroblRJpqg9kt7R36IBhDpJ37Qw/+kpI2iwISiWVljkXR/foaGZIUB9HK+F
	29LMut6d4aJFFYO3EJk7i9yFH0IN6/k8xpHGPQpinfhxJQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7ycaep8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 10:54:15 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-516cadacf92so105492781cf.2
        for <iommu@lists.linux.dev>; Thu, 28 May 2026 03:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779965655; x=1780570455; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c7H5I96ycPpsQxz6/8ab0XAK628/IR++y87MWPDak78=;
        b=EDcG+7w+8AfCgdGqu8gkhTxUhlZHWoYrH7uAYlF91tj/RV/ANm0329v/z+adLP95zV
         nHABoM0iLlrHm0xTVNgLSeWccAy2dr0WAVzaD53so3Yiv2w0EXVzL2lB1Btr8Bt87Sb/
         sTrTXBe99HjN2hLmib2W1MowILNKYY2wSfUhtTgqqRUf2oPQ8GukGT8tyJAajVJu0kzs
         /OTGFE9xl+7D4nszl8ijW/t9Dkqb8ZXO9JGXocmFDkhShJyyEFz2Ac97eFlRP+xXlmy2
         oVQKxkDVSI044NgxNxIzFQTQfOJL7INuQA/Y4R2YNZidwGkpJTcyKdO8nE9QAvZ9gIbp
         Ol7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779965655; x=1780570455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7H5I96ycPpsQxz6/8ab0XAK628/IR++y87MWPDak78=;
        b=Gt+9z0cggmmrPkUHpXMwAnbbXgta1ayfAgdEd9NC49WYTf6C7k/JzMUiKvdq71GOpe
         ++wKIciRe1dVR7T0QPWoQl+bj2TG2PPnx5TYu4/ZeLT+C+D5Qaw+sJDL3RwqEvSWjDVx
         WtHCybuuNF52/GeUuAQRkKi+DLdHnjq225kSr3HNll1SeZPL5NHF1WZg67qRiAY71oN4
         n1go2vW5i4Tfe6dXVtxChqodesEj1dKu56iTetWvfgHtedsq2CVf1WccjSHohm4ndJIB
         Ta7O4UrxPyUF1DLDxgYhVK6137YC8II5Iu2+kX54/RKUQCXKbP086eUiG7cRvTHwXHeX
         aqnw==
X-Forwarded-Encrypted: i=1; AFNElJ+MsnTpdtRbQkIXd/eExr50n8MBf9Jy4Of50+QtCmMEWNoMXA4tq6H7dP3gOdKi7dGFCvA9yw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwerWdoIokn39WSrnkVTSBkXLywblYHFKyTEQpcdKdblF4wPbPs
	bxDx51sZF040SRleam+bH/1RLuNERYHLIUIChwLxZMIpA7Jqdc+UQKrpinIPVOGYMRw3ufctDz8
	AAG05RmoeYnkUw2EqmgOxC37B6C6+nqan9+fUbhYeA1J7pcfD3Nz52Ni1yw==
X-Gm-Gg: Acq92OHMALzp7stomIwt7QqP8AOT3AMN+24dBwv75lT6uKK13dsn4b0rFPtxCv3PK+n
	fxYmpAD9VwQJjD3K7DyWg6j9omri00rGhDFOKivtozNZ0GMuhdR2Y0GgV75Q8aLXALxK8oEq7Tj
	xPW0MhMsOzeF7/s/Tpjwt/ELVvk52YVbgmk8CKpnZbca53v2N/axavng0Zd0AAO+DM3vnjIyBUv
	AFkSznSoNyqoVDZCmmnXmkw/57NvPvYEwReacLFo/9mcI/UVKTeYzaM5+l8LRbgtgiOsKEpN58k
	/9p59bUnUHZNDfK2XhiM+NWxY1WB7XGjGNiuo7ttOTp1B4Bdh7CXu2xDLvEDkimFfpiX9EPE4V9
	ZvQlCHo1Vfg1Wqxljg2YI9VALo48iRZbO2IBYVIQhqdSFQkGog4e7IYr/Zw/37EziKoJ8AkT6X4
	2KIaaVM5/69ccuduXXzOLlGgr1jiYvv4JlWkwpczMaJyNp9A==
X-Received: by 2002:ac8:5d51:0:b0:516:e031:9343 with SMTP id d75a77b69052e-516e0319e2fmr321610051cf.11.1779965654795;
        Thu, 28 May 2026 03:54:14 -0700 (PDT)
X-Received: by 2002:ac8:5d51:0:b0:516:e031:9343 with SMTP id d75a77b69052e-516e0319e2fmr321609681cf.11.1779965654303;
        Thu, 28 May 2026 03:54:14 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa4623be9asm1834795e87.0.2026.05.28.03.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 03:54:13 -0700 (PDT)
Date: Thu, 28 May 2026 13:54:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        stable@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: Re: [PATCH v6 00/14] media: iris: Add support for glymur platform
Message-ID: <kunwuij4ntmh2hwxdrfwlpiza7kbcwtdlty2cai3xlxybkn2er@7wmo5irzum44>
References: <20260515-glymur-v6-0-f6a99cb43a24@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515-glymur-v6-0-f6a99cb43a24@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=VOntWdPX c=1 sm=1 tr=0 ts=6a181ed7 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=0MEm6Huftf8yFbl4pBYA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: DoMyLWI80M5GnF9DwJjRWaw66B03Oy00
X-Proofpoint-ORIG-GUID: DoMyLWI80M5GnF9DwJjRWaw66B03Oy00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDExMCBTYWx0ZWRfX8mWetLYTKoUM
 y7x5C+gpk8Gmphz9yHM0p9+Jv5RLbk9u12+PAoSlJYZRmGG0nWi4t6Tv4YE/l69Np+miQx65/Vs
 QvkbkfbObO9AZQBJRzkvzlUbqEbhfqd/SnUNNM4sfb53DW7X/iFdml4kRPXzqh//sThfMhhJSCg
 cg2zmjZbY5hDgOJ9AYA3ZQNBYxmE+2/pIdg6qYkb8xYtaAusgX40XBxvq1h1+X9sGWsBTLtonhO
 5wIIkSG/2sfArW0r0RgCo2q2GlbACjh5uuaV/LnAhWyuENuiLToVagOEIi63ufG0/KIgMJOlhzF
 w8JinQ2ApEO7gTicNr/LkQO10VXtfwkTZGwfaf6ezr94/z2Ih6L2FzEcfJqm/XVsCGvhElWHwRv
 8CBV3lkvJ2Cc2AAd3shWj1rfCpCWkbVqv0Uqv7rm2YnQbsOAMrrk19poETK05xgPlCR2WUHJ/gO
 A/Etb/1s5v2siJ1vZPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280110

On Fri, May 15, 2026 at 04:51:15PM +0530, Vishnu Reddy wrote:
> Glymur is a new generation video codec that supports dual hardware cores
> along with additional power domains and clocks.
> 
> This series adds platform specific support in the iris driver to handle
> the extra cores, power domains, and clock requirements introduced by
> glymur. Add support for firmware loading through context bank firmware
> device.
> 
> Dependencies and merge strategy:
> 
> Patch[1-2]: IOMMU maintainer need to apply and provide an immutable tag
> which can merged into media tree.

[...]

> Vikash Garodia (2):
>       media: iris: Add iris vpu bus support
>       iommu: Add iris-vpu-bus to iommu_buses
> 

Robin, Will, do we stand a chance of getting these two patches in 7.2?
Or should we use some other approach?

-- 
With best wishes
Dmitry
