Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7014DC545
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 23:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780528369; cv=none; b=pYJVtZ1ZhleILyXoD6HwowSInVXsXnSCb1gp3bE+d+FNpBxIcJkF6zNHr2Mxmql3MfbcfENBNNRd5ZCzRGPGhoHjVfSQr83UEQvKGT57qjZjsxTtLJsa7enbDC2syGYtF/lQ5k8euAQjVYlwqA0H2V16IW6AR2DQTaWOejEgi+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780528369; c=relaxed/simple;
	bh=ik6qRM1b+GSOzYVmRNftG+yVTmBox6vYkCB/RLM8Lso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbgPPL6vkiVRT5o5XT9rdl/dcJ/VaxUO4JofkgJJrQ5zhga4S0TwgT/V3maLgPvbL+dF8tV3MhcvE76vZ1JEA+S/wlOgUHxGQip/cICFJ/oYGmNW6G3wfQy+1XPRPJxbKViqtwpMSptMkGl4Siy/HoqNzFjYpSbnB0rv1DQDlRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AKO0kRCc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fPb5sx8v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AKO0kRCc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fPb5sx8v"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653LeeQH3240517
	for <iommu@lists.linux.dev>; Wed, 3 Jun 2026 23:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=m/Ok5eZP2WT5DjxR3Pgcz9Pv
	ezqkWw2q1gsOHrEJ7Lw=; b=AKO0kRCc4FDL0Exl+w9EmkRmbCgOCv8JV7dF5sf4
	Xzk6TaJzPOo2cmh6tnW6DzwFGBFmYwhKOZ1i2RbCBHE3PmpCueZa2uBNjAdt1M/M
	uUsP17oebLptspUQmUra8ebiwLAr3hLP0ixLkCk8WQD7c0t9DZ5Q66KduzYXG04/
	zSLCshI8fbZVbNFTjuXbBN32KGDnDMGk5D6NZkwJ+tE+pkasYogjvtHeRNQmzJMv
	SXJi0xul8oDXT5Lvdu2Sm3mmo3oWZXWoSZW1XkYefTtY4OFWNMoj109gmU9SHehb
	uhdY+JZpifSrRvdm+leYkLjqNHWy8La89tMIaZLGmyRbZg==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejvd08877-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 23:12:46 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-6c67361f5easo1661168137.1
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 16:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780528366; x=1781133166; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m/Ok5eZP2WT5DjxR3Pgcz9PvezqkWw2q1gsOHrEJ7Lw=;
        b=fPb5sx8vVGHyr8miQfARaFc7znsXGG2grdcUckDTlKK5bm5Va5kNzrqwJs5fgOXEGw
         uzNz5qkuKQ359m1y5PDyclU4ZKfPvXe4CmyDblCpXXjvjCb5dvzKrZIMXCdKlM+B/nhy
         uPBi+Fy9BPwiUWHWHd3BX9xbftpS5NnjsirbcRlBW87lCa+Kujvc/84qKl2N1FaaiU/2
         7Oy3l5T+AI2AEsrxB4FMuev4HY3ECragmPAIQWQo63gAO/1nimgXDNLjDXNT7XXxXV+B
         bDHeIAxBQN8WAuto+1WOzX3k48cA8Tuwbj1kSuTqyVDJLDJhd2JAVMNyyTK4ujTs/VZd
         lvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780528366; x=1781133166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/Ok5eZP2WT5DjxR3Pgcz9PvezqkWw2q1gsOHrEJ7Lw=;
        b=pTrV0s0125cyk74j63sdR/0dNXrs6GtZItesmMvbaBOnuu7u4bOkxAzuK4fXMexnP3
         S/42bm7LXsZ2/Qn7dwQ8GuS5EDJyu5EJtkXHAni0zPMNfxMMlJpwlcfDzs2exBgJ2Gcv
         bYC8VFfL3CM9+FZ1YzGnuRsqW/qrUzris2I1nDyVTs83g2jhhCmMHfyrWv9GlDC8GFH3
         2xB8MVmx66roMiEUiK+KBLdMr17A7AryC7Kz3et+DO4JvlTTvmYVL/7RpBs8QCLr9/Ed
         gE+PA1r6dxl5z3bDyxXc2las5zQ5AwiXXKMv5KtkoGt53ZVVFB1BH8xDjmhOSUZkSMiT
         cHXg==
X-Forwarded-Encrypted: i=1; AFNElJ/KcWcOvjgjv83lWqS7dAGXuIFH141qnZzQpdLU0FWRvzef416MSfG9CSsMlreqGpt1D85+mw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgGhJryXSgiFsk5SstBfX28uWGIJjQ1Sd5n+Vp2zxM0sEEKE+0
	kQ8MRT7wHoRlJNWdMLyKNmnj6S/ZUqzG2fIzpRzb4xep5TSSDXC35VpIG7/JYMKZUZqE/eW7XG3
	XxldQeQDEVx3r4bj+3NWa7Kwdb2yEOR5mEYMPDjDjs6DBLD9anpKEFjK2sQ==
X-Gm-Gg: Acq92OFprglajUlHmYQmiWJ6xk0ftcS3BpYWYYaotyp2/Ak3SY17dAahqYxz9Ub3BBh
	xnM3NUYkApc7kHWUdaTRvgWzsw4hfNgd1gvhC05NN2kXH6nvWhy1Z08KBORxbHiL7TXkr2rb2WQ
	c1BXecIAQ24AknnxS51GaX2RvKXuK4Jj/VwI/D0Qm/JPr7pj6arf8gyUcImOwV0/VEFaLIk/vCY
	EqZcBTTNFsfsumKeXM9iBig0s2sbP8wNDzX7hQ2D7hcdOBMIOahC5nsYf7HK/jgNGQkUxCVYRuI
	DlYF+rSgh7yColmsR8iZNc2ib1kDbb63sqsnluY2+Ujd4VCH9yskJ3hGHvjoFDHZ2KkJeFpOjrL
	wD5/8J9aJbnievSRhjCeRaOeY197wLfKXeWe8jRx2OQY6SYgAirkB3uTbwTR6wcE5FOfi0Bp9KW
	ArVGVCt6LJXdav5XZjiytlRVUdbwdtQmWycOppZ6qOchN61g==
X-Received: by 2002:a67:fd88:0:b0:6c8:c356:16c9 with SMTP id ada2fe7eead31-6f552a06f87mr522647137.20.1780528366045;
        Wed, 03 Jun 2026 16:12:46 -0700 (PDT)
X-Received: by 2002:a67:fd88:0:b0:6c8:c356:16c9 with SMTP id ada2fe7eead31-6f552a06f87mr522622137.20.1780528365620;
        Wed, 03 Jun 2026 16:12:45 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b90421dsm870868e87.30.2026.06.03.16.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 16:12:44 -0700 (PDT)
Date: Thu, 4 Jun 2026 02:12:41 +0300
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
Subject: Re: [PATCH 4/5] soc: qcom: ubwc: Add Shikra UBWC config
Message-ID: <2idag2lmgvmsqjixrjr4y32jfaa673h7jrei6pjjn7gm7ybppj@n5zycvdpmw24>
References: <20260603-shikra-display-v1-0-aeac1b94faa7@oss.qualcomm.com>
 <20260603-shikra-display-v1-4-aeac1b94faa7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603-shikra-display-v1-4-aeac1b94faa7@oss.qualcomm.com>
X-Proofpoint-GUID: ykfToH3L7PG2bUQetlOQkOde3B_Dw4hm
X-Authority-Analysis: v=2.4 cv=M8h97Sws c=1 sm=1 tr=0 ts=6a20b4ee cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=Y4AeZ4K9FrMMlEv3RhwA:9 a=CjuIK1q_8ugA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-ORIG-GUID: ykfToH3L7PG2bUQetlOQkOde3B_Dw4hm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIyNiBTYWx0ZWRfX6Fcv5oLLVHJ/
 bhrfyLnxXw5E+xH0hqw/M1kvB6cRGUHG96gGOG/ocE8fTzy3bfLh3o0Y2Q99BUs0Yiodwddn17s
 B5zt6nvdyV7EO2QXWXfbyc+mvNOQhdvXf/I3K34ao2zgP2PqqN8R7FrtkG5IE4XFztR9lyYwwNC
 pQ78OauelIi3s0nQ9J0Xzivc13QXI8WwUf7CKQoV9/2FPFiIDsNTO8TIEf7MmUlxzf44v0c4c/C
 EoUqzI8u8yMjJ+rH3TbF9nN1D+sbq2hKvc0gNCCyMyn69S1SokKJvsNbwylLJsx8nYgKGdwhTMT
 +0/PEUv64BpN5l7p855ZGzRKKDMKNUiaBz4fku7KGZmCS1O7NuF3F9afPZfJ3fPcrVofJAXu6l2
 bxcd3wss/YG5BXVGURSQoXMo/ANgj4k/Z94hQkuRDJmzz4iaFWrNtW8D+CpcxKWaIkbd3/bO/ye
 OMyeNMX8OXqrbQghzmw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030226

On Wed, Jun 03, 2026 at 08:29:29PM +0530, Nabige Aala wrote:
> Add UBWC configuration for the Shikra platform. Shikra has no UBWC
> support and no highest_bank_bit setting, so use no_ubwc_data.
> 
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  drivers/soc/qcom/ubwc_config.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_config.c
> index 3fe47d8f0f63..01dca97e2671 100644
> --- a/drivers/soc/qcom/ubwc_config.c
> +++ b/drivers/soc/qcom/ubwc_config.c
> @@ -278,6 +278,7 @@ static const struct of_device_id qcom_ubwc_configs[] __maybe_unused = {
>  	{ .compatible = "qcom,sdm660", .data = &msm8937_data },
>  	{ .compatible = "qcom,sdm670", .data = &sdm670_data, },
>  	{ .compatible = "qcom,sdm845", .data = &sdm845_data, },
> +	{ .compatible = "qcom,shikra", .data = &no_ubwc_data, },

qcm2290_data

>  	{ .compatible = "qcom,sm4250", .data = &sm6115_data, },
>  	{ .compatible = "qcom,sm6115", .data = &sm6115_data, },
>  	{ .compatible = "qcom,sm6125", .data = &sm6125_data, },
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
