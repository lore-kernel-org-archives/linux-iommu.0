Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A76F493621
	for <iommu@lists.linux.dev>; Thu,  8 Oct 2026 10:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791454782; cv=none; b=mHexOTC2u9pEeIesnEQVwVJ7CXxNEZQAWZDJ9oWXfJWV7IvYGVynRjywuvBA7GlOQS8OugsobdgtlU9JXRv0wEh87dGu4UNqw3r7IpDpvp+UW2mtfnn0Ofp/o+m7EIy/GOUzPcU9cEqTzeOgxr6ENDp1djyA2i1ovj3hWRCwU3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791454782; c=relaxed/simple;
	bh=9JUQwRHtrh6LmF50Qf3hpplRunW+nkMCw2EY1xv1FJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSYwlLz7mFvyx9NVtRS7clVHhFoZGGJjhyj/y9MGBl3UtmOFVivASFXm9nEAYU6UfETLtRUtriqpf6gYJf/1YE+ZacTKCsV7mkzZ8K9jL/fDqzND5YxBMGU0Gai/lcgr/yQEPOvt9/0IofIsnmdjWalvxrmXZa9O8xigoLBr8RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FKUASdn3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kSA0wyM+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FKUASdn3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kSA0wyM+"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6987KXPA1170001
	for <iommu@lists.linux.dev>; Thu, 8 Oct 2026 10:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6H0T5U2oCXzXTsGFtUQLvc/D
	2nAGb9ZZvKdVkWJRxzg=; b=FKUASdn3Eirs3A8B94DY7bYvm62UlnXIqh0r3GUP
	JOE8B77vnW3ORkvmFUHEIwmE/RwrkCsAvsP/AjlUN0kQwy553S/mVydYU5FRA8G9
	5nqBG6gPQdJlKCb43/S9LpMb7u2kiHQUwz6BBea+fH+ahYVpdJ5c8hRwGShfEfZr
	EuZQN5oOvFyEpOm363uWS7d3K7CBiYEWMUrVcdBahRf0WuC3jyu2PPq1tebZ/85d
	LF2ZCCmeWpoWwuwJpegT8bbVk2l2AX5KCpRv0X8l16QJPWPRszpYFgkHa+iHEPaq
	crBY0LOmd93zSKzL0q6NF1KbieDbVy/AlDRG0TenWu2e/g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe3acyf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 08 Oct 2026 10:19:39 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cbf2fd504so953194985a.2
        for <iommu@lists.linux.dev>; Thu, 08 Oct 2026 03:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791454779; x=1792059579; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6H0T5U2oCXzXTsGFtUQLvc/D2nAGb9ZZvKdVkWJRxzg=;
        b=kSA0wyM+hoSxul9Amuge9L7m7jFDVemCTebIxDFdXF8LY8Xo1GFMJ8kvciJl6tBsrJ
         drCufRa6a43Jemg5Mf6oKcimJrV8cxmYsUuo4R25Km8icasskbJjgv7O3UIHAOvdJ647
         mxtVS1j/SFnESZLck3fJWneP++7ov+fbHecCQYBwQSAb2HgxuV6O3YfkFeDJfWcDamGA
         H9K6zBTr1/N/DqcEaE1EWALkQ+9gO0rGP2Go4ZmVZmNtowTpThrU50ayipvEye+qrQQp
         +eSN3YyXpLvYAOD/rKXPfxyvmY5i+54o2mvK7r+ifL0YSHOCvxj5N9iXtkl2TOv2cKqu
         FkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791454779; x=1792059579;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6H0T5U2oCXzXTsGFtUQLvc/D2nAGb9ZZvKdVkWJRxzg=;
        b=Nc/qWZDbRygBV57C3yvXDj1nYVyY9khmqB9AFE203bDKEVXqP7jIeee5xsw+nvcBxd
         223wbSFQg7gC/WEzYPXrQqOH8KoOs42yC8j1jki3q3kWnlSIc3RZNcCgHGwWcBB2hORT
         Y8ZCOahxqUcCb8Kep6xtGWA4XWyoaj5AUST5xgcL4cX7/jKLbqEzFhOv9bDKKs/fbtBh
         v01O8iTox4O6JcoCHwq659wHYi08+eMZpDiSUiK4/sjmG2gYWOMXsUELayAmHzuS6yEX
         RzK2CHSR6E+HIxZtUiMZPadVL3WkCNE2hsyGxG68eLmTPIHuj37s5fV8tzQznCflytB0
         mGAw==
X-Forwarded-Encrypted: i=1; AKwUvBxa0AMqhI+6YoSFIhef6jmz+CwFrugMSDGuQ2XlV3caedIaIBVkJWmwYDtTcJ8G4u0OeMRtEw==@lists.linux.dev
X-Gm-Message-State: AFuF++nPQtocjg/UOpuFtUXlReHdJLeMWKIlIXZl6AeA1/VQ2/gJkabw
	1+xW4H96+aJoo5BiqIf/+NezUJJWeEQzm78X6yRm/1W/JgEf9B9UrVv5/wt4mw9dAtyNi/gt0Bt
	BiuCqDfhjKH/1c/dKY402dj2KtbHcAUerKpxW/0APV8CqplvRcEox5MaKVQ==
X-Gm-Gg: AYBFou16LnqgUL9Xwf4j6iC06n/D9ztq96OVPom7Vpaf245VMP/qEBGEGoBQIQkeGlm
	CtlzWxGIGOjUxp9fvn07pvtOVi4gZBbQce0pLYTpJFp7IY4VgxCK53Sf7ZE5oqKSxUvC6PPWBk8
	k8ydwj6yaY5FgCSxvMAWd2AHLEc/43Bg2Nq+NPeRtAGDgXY+EJvchO3420ebU+vOjXxUB4TNpEv
	O/H3vyIXSXUhSmM4/jkYq3f1Qq7pH1dEFvYmxw9blZBSuNYaNEhmyJu0cpEJjTU1+nvzIuuZ6Uf
	9fNomnMhADYR8veqseVLXOpBn6FktYIfPgm+YqzUCAKCMZn51qbTy7lqlbIt+i9/bR+SxSh4Pgd
	efVtD3QQxiVX13QXsWes0z2TVPMxcIf39bGAbE6gZtkI455UHCQ9aLfQgS7rLo4+VbOSMwzIfHC
	oN0NR2gPGQ/lVy
X-Received: by 2002:a05:620a:2b42:b0:93e:980a:88c0 with SMTP id af79cd13be357-93e9b8bd28fmr863820285a.79.1791454779221;
        Thu, 08 Oct 2026 03:19:39 -0700 (PDT)
X-Received: by 2002:a05:620a:2b42:b0:93e:980a:88c0 with SMTP id af79cd13be357-93e9b8bd28fmr863817085a.79.1791454778768;
        Thu, 08 Oct 2026 03:19:38 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bcd309c569sm1064326e87.64.2026.10.08.03.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:19:37 -0700 (PDT)
Date: Thu, 8 Oct 2026 13:19:35 +0300
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
Subject: Re: [PATCH v5 12/13] arm64: dts: qcom: sm8650: Add Iris context bank
 subnodes
Message-ID: <p4b57fqad6dbwrk25v3p57ksvbhxujrggixy2tvbzfx2xbthlr@bnbw5ysnycry>
References: <20260926-vpu_iommu_iova_handling-v5-0-0322ca5dc10c@oss.qualcomm.com>
 <20260926-vpu_iommu_iova_handling-v5-12-0322ca5dc10c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926-vpu_iommu_iova_handling-v5-12-0322ca5dc10c@oss.qualcomm.com>
X-Proofpoint-GUID: 6GwB9UUvkHssX8ZfPz6VfWjwEEPczC2U
X-Authority-Analysis: v=2.4 cv=QOz91QLL c=1 sm=1 tr=0 ts=6ac76e3b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=e5mUnYsNAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=G2U8quZLHxfXJRKprjwA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA0MCBTYWx0ZWRfX0cqwfIz4Jab5
 gsUg0QdmXtivXLqPh+GsScswpYo7yFtKE+MN4PcwAuFDs5Ejzf5bZ//FiGCYN4zbgHLdOotdeOZ
 sD+nchQtAFqD9Uba3MsV+nVVHvrIDxs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA0MCBTYWx0ZWRfX4U38areSuSlM
 K/8070RVJl4s/qzAYl5ejP9Y0D0e0L+WCEB0zXyL2PwjAPfX0ovZDvOn4sX+pYdHZeMGyLIkpME
 cHSbPHHMtSP/+UFPq0HUA4lanL/BwtR6D2ogL4ST5xXxXMeabKxlbcs8xX8KiiDalj96B4EDh9R
 jjH5Kv7d0haEL4M0V4GNq1SdxeLfviXK26mL1pKhBlaexrzx4L9h1bHsQ2PAUFXevkaI7WTYlsH
 owSYIviAydrp+U0bFdWHjcVgKS76nqvBp52S3o18wLVE4CPVbUNvfuFTbfPMqA0Gv0cqy/ILkJN
 4AGtwmNHpt8oxqhg9hQpByvQTAjWxrml3KgsUyffckPY2ilQmRWBQc0XABbtxFA/vRdxpGFKQUL
 XGiChjxQ71/O5ghEkH4+D/xUPuL9mhcmzTPjyoceOJtf1q8GbQpbLOAnUXRI5VCrgMgt6V96dHP
 YljCzVn/b10B1M9O9cw==
X-Proofpoint-ORIG-GUID: 6GwB9UUvkHssX8ZfPz6VfWjwEEPczC2U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080040

On Sat, Sep 26, 2026 at 12:04:11PM +0530, Vikash Garodia wrote:
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
>  arch/arm64/boot/dts/qcom/sm8650.dtsi | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
