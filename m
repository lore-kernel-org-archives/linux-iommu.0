Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F353C5DB6
	for <iommu@lists.linux.dev>; Tue,  1 Sep 2026 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273558; cv=none; b=EwmTwo+bARny7o9luNBlVvSNYvxePGhyuk2rSgX+ogAfX1Z+WJYBBOvzkRJlQoJAQ8nDgvH/DE/aDNorTW8Mm6p6riZDR/u/m9DI4BU4iq+8x2dayFvraomF6YfWpFsc7Je0JbWuiaiy/U6ZDw2QC2V8azIfY9pVhzamgzUmIDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273558; c=relaxed/simple;
	bh=8Dl2fx50tBCCW/Z6siNyrOzFG80MjNxpL5r7YPLF1Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfwZappfhI1gKY6tf5Dk5xytWNG3s1xXqsRm2x1FphFUYTy9f5OtkiaCDZILNs2PCNnBlUoe7xTUi/zrooHwq9vtC28FsEDfQYsJ8YO1w9972/KqkyQa1atZW4u3KqHdfiZ/CmqM2JlZ513Z4b+C98FcqhtxLUxs3X8IfWUERcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WqXsfw/e; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SDSPEXIi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WqXsfw/e";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SDSPEXIi"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681E8nlZ2746831
	for <iommu@lists.linux.dev>; Tue, 1 Sep 2026 14:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fV9PRxEUNiN84sI9N6/IsE9F
	UGfoQAhpy34kXAt1Nk4=; b=WqXsfw/e//gIC1Re6XF1fhw4aUFv2lryP5UNewhq
	p9Ys2DlsGUh9gcW+73JHYSrUJ9xfOE57/qVxmVmDLU3nt2fykE9EW8cMDBhgxyGM
	RZ0M3XlJ9j59taRBRUGTXA7kzmDvSTWkKoMvQQhOGl6ChwAULBfI1PexjaxXuSHZ
	FiIxKvO9a/8aNdQGItebxCnnPuJ4745u5/sJVNJJnoD+AyZph3Ju0+F7qqymM3/0
	KSTQ5nZrZmR9sjq6Q6y0Lvt/q+a/ZHnibMG/kYOHUaw84lk6MSK1FV4rW5CQVVCs
	TrmQhb90/HH3F5ikb8j08bPhlWGY5SJVh6LNppQ7nvcKPQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdvmm14nr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 01 Sep 2026 14:39:13 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3968dfff779so1722193a91.1
        for <iommu@lists.linux.dev>; Tue, 01 Sep 2026 07:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788273552; x=1788878352; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fV9PRxEUNiN84sI9N6/IsE9FUGfoQAhpy34kXAt1Nk4=;
        b=SDSPEXIi7N99cB3417XSYWYAQbI9dxM0Bgb61oHHsN6lm94N6cms7fpaOzCMkqb1mQ
         gRW+bl5Z36SFPvx2eYNunhbLbcd8n5uvNiy3x5jIEhE/H+KcxhN5eR4leYGPAxcR6NNc
         kWQVIVsAqJv8WwuCTR8JUbF/G72xUEiPSINFtq6MORx/G7nQhD0CzBlGDT+tuSgMeO9d
         65NeR1LsEUmpfIt3lJ5d+xcvFIZoaTnXpd60MiE17Vl8OovzY/2Rj2NugrPfWI6KM+lP
         yHYuJJeIJQ/Do6bxt7RBgkVB4FKY+ha7JK/T3orPFAvZSrKXDkWRFeefIpPM7UVnrbnV
         9ZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788273552; x=1788878352;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fV9PRxEUNiN84sI9N6/IsE9FUGfoQAhpy34kXAt1Nk4=;
        b=qZxS4G5F23wr99g69eOhpJpArdvVufiHN+3YkIdDtHP+zLHwmr/Z/YqGvgMPxbbnoC
         rB8QAN19rsQbTf9crQzN2XdUvDF8XWTJr+bBrmJGJ9JGopqqm++tGNvHM5dgFRQoBlrJ
         QD7FflVaqeWCIx+VSjHphv6MLvdS4X0zBaVFZATHJIlDUFdSvpbcblSG1AaM8NRnXr9y
         O82DXUiNH/cwXZ9L2Ew60bTnOMQqLeh03CCZIJauC0mOlv7MIjE4E1MZYTNKi+Ev6KKt
         sGK9pmyttpIB/s4Q1Fa/FihW06cpU7Aml0D9MGvUlLXk+SV6/4pMJVfToQvQDdXfruwc
         z7jA==
X-Forwarded-Encrypted: i=1; AKwUvByQAkx7Xxm9nIPJi/2Xk4UqK8frpOkT2/v5wVNbbaD35UAp9cuRAkwfauKGUQg4SMFubVIy4w==@lists.linux.dev
X-Gm-Message-State: AFuF++mU+i7nkqgiJZaKmrgQEaboEGT2ih4DoyLajD/rmF3KOKhyvVZ2
	uXgTQmqkB8K74D8AWpGpahte2wghN6MvunPz+u6MjNwAs193VfpkdN+hG6eC4DaQbXpCtoIEDmd
	M0WrlHddqLwZlAvqn1foRWFESFLk6R1s1V8R+OSq76Ag5vhBH4kyM1aBrFQ==
X-Gm-Gg: AYBFou3fmftIFUtme+u7vQDZBiH2zqH9kftgpYGQDDeeea7f1Jyo4lVPBjG+cE8DyqP
	IbIyd/KkN7juts5RmRj8gE1NEOKMHc9jeiUILlp+pfSrUm+MlmGPha1J90mafERHbqAl98pkxF5
	Jhz29eZuNOR7jHjH+/EgS1pdI/Jjmr1Wy8OsrVSqwdKWZqaON4wAFobRz9pWN9Z7jwcWN31JmcV
	zexWXCvDUEbTeWpJaPdGqS3jEBq+JWFebEreubxQTc+dUhgrbFBWDjQJvJvY+NvESR9GLt7dxsL
	z15OTdI60zk3seil6EPRdmM0QLmGXo7+GZuBMk5ya9dZtrco4TyGndGKSP0WWJpGdvEyEOiP5qy
	P1ayzGYWHkKxiAJy9ZonXw+Yy+bvTlAj4CTH5wOPbCHk=
X-Received: by 2002:a17:90b:2247:b0:37f:a913:1554 with SMTP id 98e67ed59e1d1-3990f890861mr6035585a91.16.1788273551776;
        Tue, 01 Sep 2026 07:39:11 -0700 (PDT)
X-Received: by 2002:a17:90b:2247:b0:37f:a913:1554 with SMTP id 98e67ed59e1d1-3990f890861mr6035528a91.16.1788273551258;
        Tue, 01 Sep 2026 07:39:11 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0d2e465sm59617569c88.4.2026.09.01.07.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 07:39:10 -0700 (PDT)
Date: Tue, 1 Sep 2026 22:39:05 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm-smmu: Document Adreno SMMU for Nord SoC
Message-ID: <apbjid_n68ySR3ji@QCOM-aGQu4IUr3Y>
References: <20260901140816.74200-1-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901140816.74200-1-shengchao.guo@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: UwFqaX4Oy-ArF55-1rHHdZUibEqGjdlR
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDEzMCBTYWx0ZWRfX9PaXfML0iny2
 wQUegCRonWZ7nLQTNc6lBXQ0Wm+MxBKg1V7GEj94JiD7LSAxqdVTBfmgsy3vH9yDAg36/+faGi3
 exk4GjjTqoh//GvYYOlSlFOChHWaIH8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDEzMCBTYWx0ZWRfX4tdRhWK0kwuZ
 J7xGCVXyYLcsmrUJkqOCfXCD0oeEdxg7+gsDI/781sakJHtIJbEmU5O8frRHCJfyTIQlvSGklJ5
 Sp86HEd4hhpc8nfOvGjVki/9n8b8g6K9MEA00BShggvP1DzIppCp0cwmmAqO1pe5Uc36tiggYGb
 29Vc1ymS4WMwvtvy76qwEawMrE9l3dygH/YcpP7ccVQ8/q5swleiF6ymKl3chyvt4uXGklD/ctp
 8Nt5LEGri0fajEAkOZXOco1LCF1zvPKIafNPRNoJb0//gk97+lkXD5a+3co/oEX+LrZg4Kcr211
 MTiz7R7ekrxildgahM3oDSk2r4OwJnK5nrfpWJAz7AYbckhhLyqigweSzZKWZ5gRGj03Fxv0ZNR
 bYLhml80z36823Tl1XDiEPa6mZkCKAmuRxhPFRy7KDoHo15ZYgWqPtjYifx+g+JVAfAJ/e+Pxlr
 CnWdIZ0YeAxjPyPwB0w==
X-Proofpoint-GUID: UwFqaX4Oy-ArF55-1rHHdZUibEqGjdlR
X-Authority-Analysis: v=2.4 cv=GfwnWwXL c=1 sm=1 tr=0 ts=6a96e391 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=gVtPwv5BqHs-4ipWp5EA:9 a=CjuIK1q_8ugA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010130

On Tue, Sep 01, 2026 at 10:08:16PM +0800, Shawn Guo wrote:
> Add specific compatible string to document the GPU SMMU present on
> Nord SoC.
> 
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index ffa33b7f4a96..ea338d313c05 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -102,6 +102,7 @@ properties:
>                - qcom,hawi-smmu-500
>                - qcom,kaanapali-smmu-500
>                - qcom,milos-smmu-500
> +              - qcom,nord-smmu-500

Ah, Sashiko is right! Nord GPU SMMU also has a vote clock, so it
should be added to the clock constraint list as well. Will update.

Shawn

>                - qcom,qcm2290-smmu-500
>                - qcom,qcs615-smmu-500
>                - qcom,qcs8300-smmu-500
> -- 
> 2.43.0
> 
