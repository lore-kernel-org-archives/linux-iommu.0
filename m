Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A221A316E
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 17:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783359751; cv=none; b=Ta3ArMqZCPExknOHXsXqUKNjBh/wz128Sl6Z5k0RNMFsUvInYxRUnOTiZTHJlTYR/23dO0Ths32pnx1W0IOcHH8CDP+bccpQKGrmMi0de5imGvMQReJIntF2qS5FVQh/O0wBn84XHCXTR1gI/B0qzYityHkuJr3CqqGtgK85DXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783359751; c=relaxed/simple;
	bh=Q0hgKfMIGJ8oQlA0BCvlI9Wzx1l4ehDdzg25X2t6qEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQ2+62+AGeFY4BsgnvIHEhV5hqHCA5S8BUVxu/o5esTNPJ6lCZFAUPIvucat47Fygqal0wy3+yixHNWdwCbQ45BI42VVvGHAHlLdyIyK9+c5qPKqP0/L7GC2ZQ4RvmIeSQiGjiU+FkQ5MFpzIMkXrl0thIbLP3gmZMnMlc39d6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PWSQ74IS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MKgwcpAU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PWSQ74IS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MKgwcpAU"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FFHck958770
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 17:42:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=wZzheGRlsfoWHphf+vMzevyb
	nf7yYRErojFNsdmSejg=; b=PWSQ74ISsra20N0G3LSYA3WMfBSwhAUFaTIdS6Kd
	s7b7U4sT9uJgx/4zLi6Gh+/pDZeAlEpdi8DxP/0Ag/rvG0QAxqFyNzgsvelXXUBl
	KacXcsVNei7i3mZ6PMzcDyCT07PKfl88Y6vHgIOfT/pglQWDqqXV47vP/g/g+8o1
	zGDFxFHVSMPFDOLslQH3DFqD7tD1BvBUnb4MW99E3JRC1Zct9fOgJjhHyO2w0R8p
	4MeC/MfzDfQwCCL+q2dINDgbKX4SfVA3/SPer2vel1P2vzpK3x87pmADDeL9go/l
	oAyLS3PI/H5ImY8q7BmgOQeEOf83kFzBZ0jvrfhTRcPBLg==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h9an3k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 17:42:27 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5bdda66a906so4650865e0c.1
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 10:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783359747; x=1783964547; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wZzheGRlsfoWHphf+vMzevybnf7yYRErojFNsdmSejg=;
        b=MKgwcpAUQBeazlLL4VDmrPQ7jgZHH7eMA+q/LxgJUFfbTfolg6CyJccCfuTYAppny3
         CQo0Wgn2vqCXTQHLAb7FHw3thEjoTAxg3uqE2S0xyVUvdWVUbwy7Va8uhTAHtjyYn+Vn
         RdIvqgIyoi0MnhF796+rpVTxAaNpy5ci21cUFiOzmWdGHomznSwokegqvP/IMVGygDu3
         tX0xMOzFfmT1cNHDpzWMzgexNnHTuSffs+6VzJyJji9qhxHtG/eUvXidWrqkZtMdOyA8
         NQNL4MqJIf4UYm0qzs33EIocYAmcDCp+QFYeuAWDxCetIkg8zCw58uA+dFlHCgOy5A6w
         jFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783359747; x=1783964547;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wZzheGRlsfoWHphf+vMzevybnf7yYRErojFNsdmSejg=;
        b=OK94ER5Pj+OtjHxBULCI/Mq3aSJFX+uu6g1x8NEl/HyXktyn7D68bZ/0kMXzCiyFF9
         nYkhtjay/5pfEYf5130eQiipZDAQiwID/EBxtmYJTeazHXKlodLGk12PIIuH/OptTQUB
         kMfSvT4ESZLDLRNJ+Wy9Mmrv7eU/P+cRVvIrXsEs+03OzVJKckt+t4GOijybk3pzfUIw
         YkRExFFfl6Y5cWSeDfPCcFpybsE2NVxNL+bknxmtqcDvIUIXf4qas+gDa0fAZGdaCfI3
         NyZjymYameyFWfqtLNJTP938hTzXoQwvo51bIHz5VQ2js9/ZgBTjt89p3q/4fl/1yWKz
         irEA==
X-Forwarded-Encrypted: i=1; AHgh+RoEdr07U0tF1t49GfPmNvUY57f/Z22y1oPfwQanHEmH3NGg7ESkd6fHOEnY29sQcAT0Ruo2mg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6S9XJHyfqmOeOqUQJXJ0iJF+Yk1mfZjyGOFY8wJwzDCfrrarc
	Ej4sVmDZ+iHEFwSx20ttx45GAJ7T8vB9Yl+u5AqnJMtY6dmGJwiKVI4i1epmXvraP8164BCxXHn
	4tLzM4pOTSodAVw71d+/DPJ6kpZ96iYZGBOFeToWkWRpbJ/uYu4b7NOJjKA==
X-Gm-Gg: AfdE7clMYhy98GxwnIE2+BrFbD7yLFl90IgaAeIQsIYFmUAB+dSrc/CZcM6EKec8J4t
	OijRY5GR1cqxAZoxO2JF6MvZVDDEwhj907ipy9RRCSYJFl83f54rf+DbkLgonXEbHfbm+iqwBeB
	HMWHwZq2KCreqtT9zaRJNHBAGxko5TziFHvafTK6A1agjiSw4ZiWH/hGbfI6XFuh8cTJFWhwfvw
	VHUQ7ZN1dIBbNyKco/wy4knpm+XMQDP/W2rXgoSMo0NQdeBbVfO+5+QFYd/mEcn3Xh4hLij0dRx
	CbYjo9Z8hSu4p1z2P1aHtpE2F3FNUjBKfzYU3ucBFe+HjgHomY0rHpRfpZchwTRERzzBgTGM6KK
	/9UNFvkD+VVdD5Sm2ZGX4FBl92l5tU/+QUtctlOJgXa7rJTAmw/RnDgSY4mENwc1he9ZECgtz2q
	BF+8iJywMjtb4MW4wZmu721qYh
X-Received: by 2002:a05:6122:32c4:b0:59e:feb7:8a5b with SMTP id 71dfb90a1353d-5be8953a62fmr939555e0c.0.1783359747106;
        Mon, 06 Jul 2026 10:42:27 -0700 (PDT)
X-Received: by 2002:a05:6122:32c4:b0:59e:feb7:8a5b with SMTP id 71dfb90a1353d-5be8953a62fmr939531e0c.0.1783359746659;
        Mon, 06 Jul 2026 10:42:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13c8c1asm3007595e87.81.2026.07.06.10.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:42:24 -0700 (PDT)
Date: Mon, 6 Jul 2026 20:42:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 3/6] arm64: dts: qcom: kodiak: Add GEM_NOC
 interconnect for adreno SMMU
Message-ID: <h6opbtr2ced3sannj3ym573qc2sjk7ek3clpto5j5mtqfrfk6w@34sk2zraoqtj>
References: <20260706-smmu_interconnect_addition-v3-0-afdca0125a65@oss.qualcomm.com>
 <20260706-smmu_interconnect_addition-v3-3-afdca0125a65@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706-smmu_interconnect_addition-v3-3-afdca0125a65@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: sqgEaxftGCwnpw-QCMCwPwE_5vqcCL49
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE3OCBTYWx0ZWRfXzqi9CyniPfgz
 OOSJjsyUN5hHiSrncwgI65tUrPb3XFpDtBLAKbZ6opGVXSBYJTxmq7y+HLF5DwtpOPKhgZYl/kf
 v7eemBix3jxEfveiEOoSBAzlN4DQ1+8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE3OCBTYWx0ZWRfXwfPg+0T/YH1T
 UGytgQKWkP3g7SPfRJHAl9JhA5/8t5WnQEtQ6Q0je7KTzPoJlZuvcODcKelKs67E4Jq1nPmzdhi
 oMZvDej0ex2ZRdY8xlfhq49oKpXcxquru34pIUCm2MgcM/TqzCbaGF0auE+DO0luDy48FBhzRln
 1Vv32EDWE0mFsQRDc23/K53geriSFwIUXvBM5UVDHEkpBuNkkDCB+aTbhakD0E3gzQ8tvTUz3Bf
 2BvHOh+OjtsPeAGdOtzFy35xr5VYeC/2TsnX1iQnS4cBB2APrJ0/CL70/u9fqQNKrS9B4yBHUQO
 78tbM5+hf8A9c2JOkd10ApJPMLm2bmCZ51ztkmPtQ60TDgZ+Soi9PaAkCGrOee4XIv2zTydSsNE
 f9QK1gcDZlkMczN4i6wjOAzDP25D+y/BTRsj8ZoTtzouPcfvUws0ecJ3o4gI4a0ZXzpScVK4yKj
 arX/qS01/z4QZ/fF14Q==
X-Proofpoint-GUID: sqgEaxftGCwnpw-QCMCwPwE_5vqcCL49
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a4be903 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=LVq_GggcSHk3DsAf1gkA:9 a=CjuIK1q_8ugA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060178

On Mon, Jul 06, 2026 at 10:26:36PM +0530, Bibek Kumar Patro wrote:
> On Kodiak platforms, the Adreno SMMU requires a bandwidth vote on
> the GEM_NOC path (MASTER_GPU_TCU -> SLAVE_EBI1) before its registers
> are accessible. Without this vote, the SMMU may become unreachable,
> leading to intermittent probe failures and runtime issues.
> 
> Add the required interconnect to ensure reliable register access.
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kodiak.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
> index 90e50c245c0c..721526f023dd 100644
> --- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
> +++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
> @@ -3389,6 +3389,8 @@ adreno_smmu: iommu@3da0000 {
>  
>  			power-domains = <&gpucc GPU_CC_CX_GDSC>;
>  			dma-coherent;
> +			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;

Why is it ALWAYS? Would it be better to declare it as ACTIVE_ONLY and
then drop the extra suspend/resume play?

>  		};
>  
>  		gfx_0_tbu: tbu@3dd9000 {
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
