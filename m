Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C416348FF6B
	for <iommu@lists.linux.dev>; Thu,  8 Oct 2026 10:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791454749; cv=none; b=p9tpA/y8ykEblp8NR5d+uWw+6teVG8tx7ovVXSFM5EUHrC8jAnvh1g9+h8cL3cqzBm5CyWDqHIzjyFNqbP62XVSNhuyQTw8pji3GO1pEF2UE8RAV69a5WO3B0nRfXbW3/Q3W9RkcdGosODd+r7ahSPHTe4DPuw8K406DJ3Ysh2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791454749; c=relaxed/simple;
	bh=5LU13KfgFXRPyhvtXeB/ZnseghhFOP9LqRjcDUyO6PI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEW1EM1MQAg3eN9SYoO6skBUYnbg0QHAaIawRi/zCzouNecG1pakmhppEbh8WCiIXgNBdjL00+fG6Z72/rhgAR9OhqryTAcHDYAGwX658VbBbirFKKIAkZeMd5ewDTaU8Ir3aXv/5OREeyjUbgqlix1hgZbmLoQTOyTifkSBGao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YtKWjJYC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S5N52G0W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YtKWjJYC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S5N52G0W"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6987KXkd1169987
	for <iommu@lists.linux.dev>; Thu, 8 Oct 2026 10:19:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=UkM+beajelMKU1xQC5kv9yQw
	N/dbQsQv4z/I89UF0bU=; b=YtKWjJYC5P2A8i4bZrOagWgkgLSsciJNKEA+iWrX
	tVIsXfmgmPCcgUmSqgPKX00h5RxKwv36Mp+A3fdyhIYko92N0ErFQp2IJBG/CDEi
	I/t85C3VXnww6PQX5MXEVPmndHNL5FZva7ks4WylpVZmEmkic9E6TI57Ow8/O72B
	2dUkLYVkdT2zOh8I/6yIL/5VnNV82m//iCh9ecIn7FhtMa8k0hBBWqS2RAXack04
	Ap/AtcQH/kY9NgFAQFxNBj6lqpnybCT7XvHsqIGGwKjI/qW06pcZ7ObbzoeN3vnI
	0PVTDrH0TaiSPaTy4Ah4XLOeKk75Lx1aiHBUuUywtrzQiw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe3acwc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 08 Oct 2026 10:19:06 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7bf5c02f7a3so879132137.2
        for <iommu@lists.linux.dev>; Thu, 08 Oct 2026 03:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791454746; x=1792059546; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UkM+beajelMKU1xQC5kv9yQwN/dbQsQv4z/I89UF0bU=;
        b=S5N52G0WsLY2ZPLAPkv0lPvXcTt86W3rrnzzPr4fP0QoltuDWeI7/bimPczdE+0AXX
         v1V+BTUMsA68zIS3hJ9vqQwxJnEuAwnuXPkuyYHfgWz7EIzynKC3AHACGz2Vy3BY0HsG
         itHuYbAk7LT31rJtJNW99fqu6ZwaCSbAtekx6BObSBqFlt6pzsyYUq9/kCBe5vjyIvbG
         LKkUSGNlrxwJIYT7FPWeSov9bLnff0gmTo2cgckDduCJnxwz7DdD6D9/PklUWk4h8Ujc
         KFdf0SbTSpurcLpIwj7lLkxVEcKDNYqjmHK5Ese21Q54ChsrxdgKOtmd/QEVxbbR3Ilc
         Bxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791454746; x=1792059546;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UkM+beajelMKU1xQC5kv9yQwN/dbQsQv4z/I89UF0bU=;
        b=XK25JBhXrFr3aq9rmQmOocgGzQm50XwHTal2TVHa4nDZ9Rg/YMswdzz17JGXS56MeX
         xXom+lKz55t0scHHJr5XlOCDPhctBzXGqHs9CpEgs8ha3s+6UpRfQ6yXEpvHWvs5X0WC
         SwVJE38S6o2ZUO71Z8a3WsGiZsD2MTNZbDCtJ/mxWwNtGZEDPtPhttiFeuEa0wG0LEi9
         A/gTPsV2xHol9uLDpcc6RQsZGqgYvuFCxm5/Bdm0Urhj5lu65axbkJaZAIUol6gW3YO9
         Q6FRnoAsfYU6yjau2HgaoPtaI/YYNYyAh6RIqlaSkrSZRWEVBQa9k1cMa3AzLebQ8tuY
         S09w==
X-Forwarded-Encrypted: i=1; AKwUvBzFKARBI7UuV5Fk8G2aKKdvWslmfv95fdmP96mOOXNKbJhlB6bdn0hft5wCFruWbJqV4bozJA==@lists.linux.dev
X-Gm-Message-State: AFq9FYLmb8KMiG0g3HS4mgjNkNRAX2EPhUrASSkzgsVMqRbSuXgTzdrF
	ZztTj8IcUb9Y3ugBHEcEhLDlzNwnIYeY1cChorPwzPl831KZ8rlJvcy/cLX6f5xAmhqBhKhDMcU
	a5+CqFpaAPMd9QBtoklz0ZGJfi4dhoGuCHI4zvkNZyElNDMGrv6Z68V3zOw==
X-Gm-Gg: AYBFou0VwxBpeUoN1Qf8jSq7U0+f/xUfEHeqdP1ptTjZv6fkto972zlZ1E2YOxf9xvj
	NzIvdjibQnitgiqc4w1VnsC5Y8DIFyAbfy7TRW+P2KynCkn+r2crZkygPgGOwTreb2CTBa0N2CM
	ClSaP6FHt50sdaz0LftIiNx54OUKSaA1rXN3g7tQmhHpFkjKM9geFTHAQYmK0Xy7Xzg5zea9vMb
	Q4v8y264nP56W7Hd43NJAD8MHIOWRBp35VbIhgd72CUVTuP4zbUwbQGNpLabZda1ShTC72656fW
	LjnLlpm1k8f/Z4NqV+RSs9CtQeDTVMQT8RzYlN9k/2ueH25lT2cvNweLukHdgEWpA8IgYowtAmO
	e4wUB/htd0163ODXZYVbNjvTCZLrb54qE2qIlMgnumYP+s3Js6e/S526z8U5RRtVNzYMSnHaU2L
	o/3qhlqOKOWReK
X-Received: by 2002:a67:e70a:0:b0:7c0:6659:bd8d with SMTP id ada2fe7eead31-7ca38dcf3bbmr1113573137.27.1791454745932;
        Thu, 08 Oct 2026 03:19:05 -0700 (PDT)
X-Received: by 2002:a67:e70a:0:b0:7c0:6659:bd8d with SMTP id ada2fe7eead31-7ca38dcf3bbmr1113555137.27.1791454745340;
        Thu, 08 Oct 2026 03:19:05 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a9a1b96764sm14911761fa.3.2026.10.08.03.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:19:04 -0700 (PDT)
Date: Thu, 8 Oct 2026 13:19:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Abel Vesa <abelvesa@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux.dev,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH v5 09/13] arm64: dts: qcom: sm8550: Add Iris context bank
 subnodes
Message-ID: <li23csmou6vilrlvuthjakod5fep3rcfyd2pq4zgt3pvfacqym@fe6afeau5lin>
References: <20260926-vpu_iommu_iova_handling-v5-0-0322ca5dc10c@oss.qualcomm.com>
 <20260926-vpu_iommu_iova_handling-v5-9-0322ca5dc10c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926-vpu_iommu_iova_handling-v5-9-0322ca5dc10c@oss.qualcomm.com>
X-Proofpoint-GUID: 11TC8955gD-CMkNgAtQZxnd_UJyLf8s-
X-Authority-Analysis: v=2.4 cv=QOz91QLL c=1 sm=1 tr=0 ts=6ac76e1a cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=e5mUnYsNAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=G2U8quZLHxfXJRKprjwA:9 a=CjuIK1q_8ugA:10
 a=-aSRE8QhW-JAV6biHavz:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA0MCBTYWx0ZWRfX5NuZBb+8k0Of
 S6FYQK+mcQ98j1T8rA2EOFGo2q+8yNrkndxvheasBzLPjNmIV0q5wrp3M/QoTxH6GlqYHQbRoP2
 ZuSh8NCEFP2ZxmMc+wgemuzQk0Cex3E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA0MCBTYWx0ZWRfX6AL924meE6/e
 4xD2lH7kcRPPK+vNgSsmU/l/Ys6suc3gBDYQqeZ910XjI1tFioMQABTfpJz7DyPL/J10wL4oarr
 EkXc9B8faLoC7MJdTBiv91tI+WzZM0Li68MahRXDENiXQwmam0WnGXERxLEEKDTVdh/+loTx7kq
 xr2N6H7rGKWkUxpZsYW+79yfZzwwEK8p4vm1I/Fh1F35j9DkVthTnImtN1gN+as3oCk2ZJfPTlT
 wYGnVQCVaRNJFdsASQZg93sgaGSOxvVrFWWuyp9qz0iAreZCvjpguYct2OwwcjlaUABCfJvzOD3
 qGEKlDetTVELfPthEbeM3NZ60n+iQyjGvdI9Uanl6Lg/ZFfEMyHnmtGbp2klZXxahpeM3h5i8YI
 pZ0Q/pB6lqB9XGP4nV+/S33YkLMcoL2FjI62ZHPXG8sgWzVUrj30tRjmSdNjAAzbZ6+WB3fQ6tF
 QzExzjAeV9oNQWMU5uA==
X-Proofpoint-ORIG-GUID: 11TC8955gD-CMkNgAtQZxnd_UJyLf8s-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080040

On Sat, Sep 26, 2026 at 12:04:08PM +0530, Vikash Garodia wrote:
> The VPU issues DMA through several SMMU streams, and the hardware does
> not give every stream the same addressable range. The non-pixel stream
> cannot address the low 600MB of IOVA space, while the pixel stream can
> address the full range:
>     +-----------------------------------------------------------+
>     | non-pixel stream addressable range (600 MB - 3.5 GB)      |
>     | 0x25800000 - 0xe0000000                                   |
>     +-----------------------------------------------------------+
>     | pixel stream addressable range (0 - 3.5 GB)               |
>     | 0x00000000 - 0xe0000000                                   |
>     +-----------------------------------------------------------+
> A single "iommus" property on the video-codec node puts every stream in
> one IOMMU domain sharing one IOVA allocator, so nothing restricts a
> non-pixel buffer to avoid 0 to 600MB. Once an allocation lands below
> that boundary the hardware faults, which shows up as unhandled SMMU page
> faults and spontaneous reboots:
> https://gitlab.freedesktop.org/drm/msm/-/work_items/100
> 
> Given that the address range restriction is for specific VPU stream, it
> should be ideally be moved to that stream. To achieve the same, a subset
> of streams is now represented as subnodes, so that each can be
> associated with its respective addressable range. The design was discussed
> and agreed by mainatiners here
> https://lore.kernel.org/all/c7b956a9-d3e8-4e18-b780-5d08f5cd2ca1@kernel.org
> 
> In the past, this limitation was addressed with an iommu-map approach,
> with the iris driver dynamically creating the devices. That approach
> was later concluded to be a hack to avoid having subnodes, and was NAKed
> by the iommu maintainers. It was discussed in detail here:
> https://lore.kernel.org/all/c7b956a9-d3e8-4e18-b780-5d08f5cd2ca1@kernel.org/
> 
> The video-codec node includes address-cells, size-cells and dma-ranges
> to declare 1:1 mapping for DMA translation to the parent.
> 
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
