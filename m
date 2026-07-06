Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7F4302742
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 21:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783373479; cv=none; b=EQRIQL7Dk8mt0x18rpi2xQ1f2FnOX7oC2CNo3lh7nMBpABBViSIW0cV22dBLPt9Fa5xD9eJcnJuyhZAYXTmnYFhBsQcpfMXroJKzPmWJI4wVzp/+4ODv3IPtufLty+/WIpJPqWPKos2hiHoCLc4rvsaNHGJoLMzL030FlK7ZCFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783373479; c=relaxed/simple;
	bh=xBky2n9+WJ4//uNEPF0wJ+LgSzOYLiJKpO4h7lh9jyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8+qZwenwY5ji60jbC14pPOy73PPV58dlqFknMw20CuwuXzR5DcRS+G/yw8jpxU2X/wL4CdFh8cYOFmGjkWNMNRFH8i3OYXjEbVQQDjzi5HBXI5qs+J3IUmRDKMNmNR9hrDERkvnH7c5Pcd05yCNv73F7b9ktwhrGI2K8fmCCgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EM4BFVw1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JFtjYCBZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EM4BFVw1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JFtjYCBZ"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666KEq0u1614936
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 21:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fzc0UyfTLrZB1zWo/aKngVCr
	9fX2cKPgrJwdh7m6pAE=; b=EM4BFVw1U6C44bzQw34O8jRKusvwreqOly1nZt1U
	oUhDEvwvB84iMe50TpYtYotIRmv6LnsjGV0QrJlnDBBMdEGm8fJuwvUR2G7hXQDw
	sh5GgBKavN6YTF4EHHthKno/Sbckz2rDTTyEtWtmYfUfuudttKmfTfXp4H2BeP+3
	QlFwddHyHWpvXpQr6bE8Jp57G4SbtS40GCN3Qy5/04f1pSHm+4PkBsUmQAjwpwW5
	j/FTha4md5OulfNuShjkXnVoz+PBxXkxtV8Fy89xQAUilimimyGvgJp1W21383Cb
	q39IfzkWdNNWJRfy8bbOZqXLtMps+PbzZhm8Q0IYgKzADQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h53c64-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 21:31:16 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c12e43b98so42977431cf.1
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 14:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783373476; x=1783978276; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fzc0UyfTLrZB1zWo/aKngVCr9fX2cKPgrJwdh7m6pAE=;
        b=JFtjYCBZmMTPsO6lfuAgMh9rxkW+QH6DOGdduWo0DHVv53UfeTwCoJdQR+hpIJ1o5I
         Eup4PFBwnDTzF1uqOYv+PESYlhUZRavNzWoOI2tv6pAvjmVoFtG8LWc7R7RoYbME+Y6o
         KOKJE+1Yx/scmYsgR9THhUfUcFEQvkC7rmO+0YEBt+CmuCqQl2pTO3/pWeFg/VW/hfnA
         mhE7og7XyZ+H1awz4PSnxTI6FY8l4MF8nuPiDyhfklAFbUnYpitk6KypmWcJOyb3cvFL
         bkIlaQasHxQeXMXnt/ULfc5zOLKZxSImSqSFhd/trd0UXFQb3PzIY6HoNt9Ft/Ibrb/W
         DC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783373476; x=1783978276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fzc0UyfTLrZB1zWo/aKngVCr9fX2cKPgrJwdh7m6pAE=;
        b=s5myjd7IL99h2OGpvmNsp817J1g2KEk7oOp/18/HKYJHtqaPmPcJAS1grcnOV9/VCN
         tqWPWIQzkrXjqHY3N0KH8xMILhiQdf958EYFQv/Rukxjyt5ls5Gd4evtgaiNfMZ0AOQX
         h1EGZSBk5fMoNAzAsZotO6DIg0Tg830IOV+aeY1z728yxRk624HYcrKosg6FJy7vhC7D
         0KHWc1IaILkTsVLgj8PcE/jY6lAztfwkyabiyvPrvQ1+bZvu2MhNsdhhkAS0ulqDoonj
         OsFUoufUWocMxeHCxmTZz+USR7w36DI3DJLmJoALpheokdUnSQbUfxtMD+LhEddRaxkE
         A7EA==
X-Forwarded-Encrypted: i=1; AHgh+Rqm0GiEVhRVQRKcB7nxD6hB2NIK4CnCqlaBITMVzA2eineuW2qZHsy7UUZG1BI5K21HubOBWQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJSB7UNrMLjHo6stk++ujvftd1JUJjWUZGfD3U+NXmwlrl7zy+
	Sl+LKaUyQWhafcw1UWjYI/n2qggAKud8Jtgd985S1UMWicvEOpAdhlT01/pWeBwrd3OS1oJBhf7
	ddlnK1Ka40QdXsrr80PNHL0yhH0IkE1HS60M2BhaEjoC2LfHX6/ITuBEHDA==
X-Gm-Gg: AfdE7ckI2XpYh+UHuKl0/BLiBHdqF329BED3uSWYu53vUqX7vuTc7/pdSD+wCmqf/80
	z29eoYfqHKwnshElP4Imwvfe0c0hRTZGSJVyXYq6w4ZomYPqs5VHPJ5m3K881zntr5QTGfEyRFX
	Lwy5AlvbhblY8QW3eQ9TP1HF2Es2QJKtNYL0oQhPkaMMmE9OiJqYhZgu51pX1EQhkq/BkZaewf5
	G5x9x+lbJlRACMKpg5id8DEjjhIZyrMyzc6y+8USpvI+qqQqSRq+JHBzJK5FsSy2Tbln9fUALq2
	I6pA2haZTNXxdMhD0G25VUEuKVlUk0iJL+GLLjOf6r1mywxEgBKrEe6BqKe5ZfiWvCyXeVYzqNf
	lsRiGxm8MnAr7NvU5Zvmrf6G8obgG/T3/YMhU87eW9c6Lz3dhr5kBVIkvTECURZLLHLdgpBgbQs
	xw5mKcXZUH0v/n9us2i7CXcjMO
X-Received: by 2002:a05:622a:248:b0:517:8011:3a4b with SMTP id d75a77b69052e-51c747be066mr29060471cf.21.1783373475877;
        Mon, 06 Jul 2026 14:31:15 -0700 (PDT)
X-Received: by 2002:a05:622a:248:b0:517:8011:3a4b with SMTP id d75a77b69052e-51c747be066mr29059761cf.21.1783373475081;
        Mon, 06 Jul 2026 14:31:15 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13bb417sm3124713e87.50.2026.07.06.14.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 14:31:13 -0700 (PDT)
Date: Tue, 7 Jul 2026 00:31:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Qingqing Zhou <quic_qqzhou@quicinc.com>
Subject: Re: [PATCH v2 3/8] arm64: dts: qcom: kaanapali: add the GPU SMMU node
Message-ID: <u5jvkfixrm23gugwlnpwq3ov26gf2yqf3pjntcl3k5t5wormet@powdt4jkmqmo>
References: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
 <20260705-kaana-gpu-dt-v2-3-6ac53de56314@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705-kaana-gpu-dt-v2-3-6ac53de56314@oss.qualcomm.com>
X-Proofpoint-GUID: 4cHGh85oTtJZkLO7wdRIVy2hwfU998yg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxNyBTYWx0ZWRfX+PXN8jDqOn5v
 mXVHu/t3Nxf0PaDEu58VWTTfHiSARztpBHwz59qvnPUcG1ZaI/FsBMqMPmh4AIJMTSN689EtkN2
 ySKffF3k8D4+SK2hBwjLhBW9PRjKnD4=
X-Authority-Analysis: v=2.4 cv=EPU2FVZC c=1 sm=1 tr=0 ts=6a4c1ea4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=8h3n1EBGBd86Ebf8828A:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxNyBTYWx0ZWRfX4SskayZ6LN/Y
 LyXSRfXFEtktOAd1GfD8wAkdF+sxFl59yeYmpMDUm+IDT7pK90O5RZ8JNQ1o1lM5uW2U6ZlExjn
 Wi6aq1HOQCCHfQhPrnijOdP95RKHtGPBwP07W/6CmQBjmll/HgEFbBI4RZ1U0sO1H5G6PXxwHct
 Zdw/BFCgAqLPz7/orW/raGR6ozw0NiimvnT27zU7RPt4RGJDi7BxsqOch6hUZwfSBPo5rrx28K/
 MhA1iS+QBQUNqGYRGSnc4k64PkR6KIYMIyQ/nBA8Oh/QnLb4c2cTiMhzuMfm9BcaG/cEGMF0yvH
 yoHkhpPhywEWjpmTmUv4Ufi4rgPOf4KhBGd+7ynWAtdqXrBrAc2OaJGunMp7Rk3YpkY7YDOuD0r
 FSaYj4iBbMxxQDb2bzT0l/nRfrw8hRbZmu91YebrGAHpF4FDITfkp1zeLI8UnCaJGfGi78IZKlD
 Ytm6WsSo9bmpxiVQ9PQ==
X-Proofpoint-ORIG-GUID: 4cHGh85oTtJZkLO7wdRIVy2hwfU998yg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060217

On Sun, Jul 05, 2026 at 01:30:07PM +0530, Akhil P Oommen wrote:
> From: Qingqing Zhou <quic_qqzhou@quicinc.com>
> 
> Add the Adreno GPU SMMU node for kaanapali platform.
> 
> Signed-off-by: Qingqing Zhou <quic_qqzhou@quicinc.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kaanapali.dtsi | 43 +++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
