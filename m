Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27453C9ED6
	for <iommu@lists.linux.dev>; Sun, 17 May 2026 17:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779039083; cv=none; b=HYpkNC9L28ixwruP24ZwxG17QNauHouH6YuxiKHFos2Y3yOr09sQxFOzx0OX0cCvJX0PyKOvbHK9SA94s+Yd3gTDxMmCb0Ez0hcWN9Bz0B0BRH76rJz1TluBS2xenOZ7e+tHwwT9Oo6zhs+SulJpsZrsD2We8wyAnPoEegM+1IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779039083; c=relaxed/simple;
	bh=ddpK/1fQ1/ofrCYfSocIFVjNulkretdPKH0F1topeuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9PYe6XtaagCfKOHS2Zzs9H9G4mLU6VwJjRlRUotK8I3eQlK1oHgtFd3LUuvMM/aDXnTOQkI4ucsZOaSyCBgLcgybt1TVy+R8AQBxFj8r4CXKMxDyOQQMyxP1LSmeRY3VHv9mikO8jVEAkmLPDmNizSDtXXbt2qemn5g/C/NbR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AF9oZJxh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VgJysod8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AF9oZJxh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VgJysod8"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64GNOwcX2269860
	for <iommu@lists.linux.dev>; Sun, 17 May 2026 17:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=KbfQWTa4JGz2bP3xz67UN369
	baMaSiTTAvAd+IsVkZc=; b=AF9oZJxha6L/fXzvJoYafBp2qJZybWVLfVy3/Ief
	Alzi+ZUt+mYo8hKNWfyOamZ70IvvKBJoegHSxV5n2FmZcMB+ORPHumXogHV5KKQ5
	gpwXQ9k1OFaJkQYXpeJqf+rhV06Ec8B1EpIbVvgPV65XQhGXBGp+EmYyBx8JMOoI
	IYuX+RMACQCwIvWtpv1cxDnZdLbXwRwCY3PKCXVodKbWKrwTZlWJe3Aq3Gx8pU4J
	80Xoep0rqA6NjJxj7Mx1aIFc6jMLDBZwtIGe7EtdGwFR63SBkZfRj2HE9GZz8NUt
	OYEYHh75aKt0vr94gplsDeyppvrzm69du2WSQJL1DpyjsQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6h0qb9jq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 17 May 2026 17:31:20 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5162ee45a77so43622941cf.1
        for <iommu@lists.linux.dev>; Sun, 17 May 2026 10:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779039079; x=1779643879; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KbfQWTa4JGz2bP3xz67UN369baMaSiTTAvAd+IsVkZc=;
        b=VgJysod8grbr2uuLZzZuDTxX/AqfyuX3ufWHQ/Sh1bEkHnuTbMa+cui1Diex4kZ9kL
         uNYWXPkuWj5Y9YNZEJIhUHQapTT46jUbTv/k3/4JseL1Y4WwMSesZGjgc1/9/01qgcSX
         GEapFtrixbpSnWyT7hhlevGW3Df6HJkyXZO1UH5kNrn/RzsBs1pD8HPEEIcWoB4vKBRp
         CxjHDTJy97NVCm5vOA671yCaYjx+cSevC9baWwKlJDfi1o0p1ciBovjNKY0dvx6ey7N4
         mcEckxGHDUxn7gPDgXoIC1WxsNI9VfkcK6VTH3YSe7n2Nlh+DkDN1N6onydBjVqdNcA/
         cM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779039079; x=1779643879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KbfQWTa4JGz2bP3xz67UN369baMaSiTTAvAd+IsVkZc=;
        b=OWqWCksKkcQbxiIEtYJls51815qdRPpSCkF7a3TaX1MoFa9Vt3VD2DnN++q25bSJ5x
         b/XvzCmYCPXWKG7Ou1vugKdLa7M7a0Y8RswMrnT4LflNkRw74qTvGipBToM0UvkpJvTl
         t4kY9C5CsrsQ0E77Nr888zRIztpYUPoKycr0dsdmHF2LqEAv/dC4qsLzEPAHh9FQ4Mmn
         BSKchHwqM+KBF7izubU/z75xsnsmiuVPd1lYLKsDwRz9inqmnENrcrIDOrqcKe/GAJLP
         mxBUx5elU+M+8UU4f9exRK7+mDsqXUhbH3659WFG6qm5xoPVLA6Y6Q6fchZGalS8U5SX
         ABGw==
X-Forwarded-Encrypted: i=1; AFNElJ/df6zV1ox5+7LWOfLyScvMt/Twp2nhRF2cL8jOoDbIEoCGk/DQj6YHpt6C0SD7sgdWqmxOwQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzRoFl+WBL3vomq5tro9OuI3eHtPFR8/SdEN1pf6PXI0M2nF//P
	ZcingCxM4O7406H87uJbfx7a7iXUxxQyLNGioUcuH1Wff5iXa0e0g/K98A5/LvV763h2OfZGWyN
	v5CcrOJdrtpE/nHP0E09Hq3Fa7QeKT9+OQduaIaUCwJgTwIRjPbGJpJRrDg==
X-Gm-Gg: Acq92OGyXUzCRTPSKH4qcHu3xxKXoML2sQf//Eki8a1gp4CsuFKMZjdJRC2fYjC6WLX
	cS4oQad4/eskgxtc8NdZflX8puKDj/B/syGA/YtPu5oRjZ/B4sYxk7skeqZbMHm0jY3BYFizFcG
	i1WHL592BDqZj0pzyPRx0Wn05Vf6DTwZ7KGajWc7+BBd9UooYou3L1gG4VpzZUvtCe3jA/n7rRa
	UFtBsP9Ht3LMjk4HHQQ+BwUPsT8UK6KWa+CTep9GuBYMcGR93cLL4SXM8c6qaC5dgVXKsFS3UUA
	FNRzZ2so2WcVftL0raWNEEcmusdv+alonSm1GeYFx+/FS9oukzjSKTrzSkObSAATlupfb49ktp1
	X3mNv80ixVcAmPvZheHh7HCYuov5rNB94lyJDpSe0ViDP1H9ZebYbjWIJgtXGvGdAjG2zSL/Hm6
	wHkiwl5Juu2cbq+smRBSNl9RS+MNktWPEkUijxj2gRcUulsw==
X-Received: by 2002:ac8:7dc6:0:b0:515:875a:ec22 with SMTP id d75a77b69052e-5165a0022cbmr183435431cf.10.1779039079332;
        Sun, 17 May 2026 10:31:19 -0700 (PDT)
X-Received: by 2002:ac8:7dc6:0:b0:515:875a:ec22 with SMTP id d75a77b69052e-5165a0022cbmr183434871cf.10.1779039078744;
        Sun, 17 May 2026 10:31:18 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395887b6cb8sm6534341fa.37.2026.05.17.10.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 10:31:17 -0700 (PDT)
Date: Sun, 17 May 2026 20:31:15 +0300
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
        stable@vger.kernel.org
Subject: Re: [PATCH v6 03/14] media: iris: Fix VM count passed to firmware
Message-ID: <gabnkc3nmsat7bdevnpgpba2fwvv3juzwut2n6emmyudrntht3@poynzfrdwjmm>
References: <20260515-glymur-v6-0-f6a99cb43a24@oss.qualcomm.com>
 <20260515-glymur-v6-3-f6a99cb43a24@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515-glymur-v6-3-f6a99cb43a24@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: GmG6Q622O16WDrRVvDgwdtAkjfaI5ffm
X-Proofpoint-GUID: GmG6Q622O16WDrRVvDgwdtAkjfaI5ffm
X-Authority-Analysis: v=2.4 cv=fIMJG5ae c=1 sm=1 tr=0 ts=6a09fb68 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=NngpiPSqF1r_w6X9nHoA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDE4OSBTYWx0ZWRfXzUEh7wxt8L7F
 shaibKzXKiS1jIvgcrzMTivOhKVVF0kXBygwA2flOx7TV5ZqOjYxOXjUJo6tH+DaY1vFsNTHlcG
 gnQo7rd4RvggwV4Lgcw3qjNA90PEBqpFiSLWRlBmtS8twO+cw02ftlog0qITufMUad8dfjiFCWB
 JN1W8Cr8TyY8++eEchF56O9ciSceM0bTzaFk7fJXadDaCmzlTS5B01OCw7Z5AoAtBXMTwjC7bcd
 CUJXnW94f+/ZzbjfNQgrY0uAJd5eO+gtJjdq/XZo4FLSXG+SRvbtCbTSJMF0dchKczk3xUDoh01
 H53HC6hLa6ZPqBbdJuUPsr6sOkVsRn9cxy34AXL/3RBfjDaq63vIzec9EduQqHcyQIt2BuPvnCc
 p9Swn1bQt/zZ+PHLhmUh2xVlWB8P9Lqxw1oBfGEMjN9//sxXTvbmKvoZnl7WdMe/8dE+8XNICTV
 t7YQgjGqIylt8vqteog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605170189

On Fri, May 15, 2026 at 04:51:18PM +0530, Vishnu Reddy wrote:
> On Glymur, firmware interprets the value written to CPU_CS_SCIACMDARG3 as
> the number of virtual machines (VMs) and internally adds 1 to it. Writing
> 1 causes firmware to treat it as 2 VMs. Since only one VM is required,
> remove this write to leave the register at its reset value of 0. This does
> not affect other platforms as only Glymur firmware uses this register,
> earlier platform firmwares ignore it.
> 
> Fixes: abf5bac63f68 ("media: iris: implement the boot sequence of the firmware")
> Cc: stable@vger.kernel.org
> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_vpu_common.c | 2 --
>  1 file changed, 2 deletions(-)

Please settle the discussions before posting new iterations. Just
providing a response is not enough. Get an agreement of the other person
(or a timeout).

Until the discussion at v5 is settled, NAK

Nacked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

> 
> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
> index 7bba3b6209c2..df76530be809 100644
> --- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
> +++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
> @@ -26,7 +26,6 @@
>  #define QTBL_ENABLE				BIT(0)
>  
>  #define QTBL_ADDR				(CPU_CS_BASE_OFFS + 0x54)
> -#define CPU_CS_SCIACMDARG3			(CPU_CS_BASE_OFFS + 0x58)
>  #define SFR_ADDR				(CPU_CS_BASE_OFFS + 0x5C)
>  #define UC_REGION_ADDR				(CPU_CS_BASE_OFFS + 0x64)
>  #define UC_REGION_SIZE				(CPU_CS_BASE_OFFS + 0x68)
> @@ -78,7 +77,6 @@ int iris_vpu_boot_firmware(struct iris_core *core)
>  	iris_vpu_setup_ucregion_memory_map(core);
>  
>  	writel(ctrl_init, core->reg_base + CTRL_INIT);
> -	writel(0x1, core->reg_base + CPU_CS_SCIACMDARG3);
>  
>  	while (!ctrl_status && count < max_tries) {
>  		ctrl_status = readl(core->reg_base + CTRL_STATUS);
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
