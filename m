Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A4A4B0C9C
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790594452; cv=none; b=fiKnZXJ4O9udmnp84snle38yyy5/lhqlfM8b89bMqa5Ga6YZ8JvcCH/8rDEZDcgTj1xJ5SBXOWWmj7pwJXVJma9ba98rrk8XmTiaNdvPAES0mka31104Bck+aDlrIfGi5ZrSSiZBdXjXuizLaitc3l8Lp2qGMW5oJP+F4avCh+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790594452; c=relaxed/simple;
	bh=9IqF3819j2ygp601ofWPZWHL+evCZnmwp5OcBplZl0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLlb+I7Z4K1YTr++Xs/7CzFlxfsSF+OiUcL6YRKYHAN0aIxVhIKVqHv/q2hFZZKhUFtjUJ/+6Q0blOJvA/WB2YPBMbZHmVrG5FglXzV0H+N6VBgw5+DrNo0ByjWpJ5Gl7hX5+EBE7/vF1W/RPRXeHyfra9oB+9Aja6CIlaLidPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dGqUILAH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aakwnS0W; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dGqUILAH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aakwnS0W"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBAOaR782742
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 11:20:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=qPso9G8Y2iqX226aLF2wFKAr
	aeHtAaZ5eheUmmWUNuE=; b=dGqUILAH89LghPjRZ3nLKZq+3Sb6o3v4knl+ualO
	Pfspx1VVNq+ydAq8PaFM5Mh7DXkIg0EHd9oe8WAVMH4tWVRaLtWHt5MBG50DWcTA
	2JpQkJNt7YjhhOcBrpLcnAf+3L+FHNfQ1Dmi9Q0fcYheomKby4H25rKPfJf6QpkQ
	bME9y57HtCfXQXT53GCZswwa/Jzz6Z9PuxauMUURdyUFtER+a26MlhjJxYJX1stB
	PSTJTdied1meUi73fetsoZY/k+3AhX6gdKgfqf+r5RQ9d36VkqnvTOfo3oY5Gb8N
	BLbvfnsawsFk5EVeJCjptIW64NCKX2aerthbFG5pjDulcg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyav4a72h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 11:20:48 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-34318e88ba2so1045431eec.1
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 04:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790594448; x=1791199248; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qPso9G8Y2iqX226aLF2wFKAraeHtAaZ5eheUmmWUNuE=;
        b=aakwnS0WZEVSNvbOjzm3x/uXsyyO7ySeR7RdK306HhSVKM9m9S82TUye/ioKOAJch4
         oiKFpOfQNPDAbdDLc8RlO3VmvvLsLJLmn3gkFuCCgfbqojIHL2wxi0RjoZwQOJlyV6H8
         4ff8PubgOUHMppqLp+EqON/fBDLiGpWuI+hnp69kvIIUlLRRbWS/Ppc9r40KS8t1esGW
         KiYZG92SAnaKjxS/2amzsGH8z2Qs6YHka5JLJTtZVWG0YBgcFFTYvkenjN7M/XOJprkh
         2c0eY0o1Dh8Gf5ORpg7YCciLirI6G531aURacU+xE+8HEbR3tvLyS2sbjRVNbfD1SRyn
         vefw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790594448; x=1791199248;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qPso9G8Y2iqX226aLF2wFKAraeHtAaZ5eheUmmWUNuE=;
        b=DAnJWPUaY0qKlxBo2lh4g+SwNInwGe/ZfVCQZRHGcd3Zz4cS4BerCl72UwHcSQVjNK
         kwDkQskbZ3yUTwgti+nf4FuD5HdSfZzPS7YAJZlvBRErefwPG1fFQjXbUCpad3Kf3nHZ
         2Ktk1sz+nlXvaV0d3t0Ef54ZnGFpkl1xu7sfEwvoc6H8hSV8ppEtTeKNR/Y37qLan+z3
         xZKUBC4Go1uvff3P7uwv/kRtBhQ9iCj/KSkPwV5G0JyJvk1Dn8CmS9AkSNyJY1ChgDAC
         Ks1bppFx+Oe257bckiYD1MSZLeFxrvsXWTkj8m+F/hpdZODTdh0Efe/VgYyVd2fjvyWw
         DOlQ==
X-Forwarded-Encrypted: i=1; AKwUvByogk+xAZ75rpDDNX9bRFnQjYRclsSOSk4KRHa9B/vxG7DjUMMDFGMAXjBCDaii9vXNPkwLsw==@lists.linux.dev
X-Gm-Message-State: AFuF++lUq2zbBLtJvALkFH6Llznp2bLTMvALReOUuiny/isDzExk9BXn
	3s+Yg6uB2Q7JMtzV2Sxz6UzBebzFHUwSf4fptn54BmGI6x20jxvFjhAiayX+xuaEvK9ZwrLTLwV
	zD1kIBHK2jjaFDPsixZkZR4dvzAomEVB/qt9muSTBWoQt3XOr6TfmK61tnQ==
X-Gm-Gg: AYBFou2eB3lJGN+c2mY9V7iO4HyBMMYFVySaqBB6O7huns7SGOQ+UnU86B1h03m0Ux6
	oJiQ00zbpVSw236CBSy3cZ7RmfqQPB2+4RK2bCzfoQO5+uKp3nsjt15SYHjba+MUECOtfuqw2R+
	s31GImTsib4sklYh8T6dTda5XcBo9u9QoK5NcArwcy8OBlWsKDjc+Be8ZZpEPGbyUw0sHltjYww
	c446HnEmMLev1fRDqMfaiUrUPweZ9I0sib3UNLOX5oyO7tYNQ8dh6R+VBM1+qm8ph8keFLDsqed
	vHYDZKBtELmt3Uw5iAMiooVcr1geKWcTJ2azUrEba3Vy2oRKYZkuOyMIg93aj4B5cd0j8GV/M6s
	Wwu9z3XByMHpZjnkzAMH0Rkdn+lAf22ISwFljmAoaBA==
X-Received: by 2002:a05:7022:b042:20b0:144:ed03:7c66 with SMTP id a92af1059eb24-146ce680be2mr9817584c88.20.1790594448293;
        Mon, 28 Sep 2026 04:20:48 -0700 (PDT)
X-Received: by 2002:a05:7022:b042:20b0:144:ed03:7c66 with SMTP id a92af1059eb24-146ce680be2mr9817551c88.20.1790594447739;
        Mon, 28 Sep 2026 04:20:47 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-147913a776fsm20668467c88.17.2026.09.28.04.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 04:20:46 -0700 (PDT)
Date: Mon, 28 Sep 2026 19:20:41 +0800
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
Subject: Re: [PATCH v2] dt-bindings: arm-smmu: Document Adreno SMMU for Nord
 SoC
Message-ID: <arpNicG_jUzh1ZrL@QCOM-aGQu4IUr3Y>
References: <20260902013858.130887-1-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902013858.130887-1-shengchao.guo@oss.qualcomm.com>
X-Proofpoint-GUID: 9aDCTRn5J_XJWO1x5UIGwB5JIVHDhPvT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0NSBTYWx0ZWRfXwcgSC6XBBeUZ
 mm4DgBFSDppIkvwhhLsUPMiu/m4GxczOOyObbsUgMKciKC8hraiGCOShfc1qujUw9cf95KxlFEm
 jZWDBQQTtp/ARr/8KsKLmcZI6+ozWXVDhfQZPduZsgxBTcRvyNb2EUxPr2wYolkw6ZYT7jzmui1
 oB6CCldXSRn5B/1V5lG/sg3qLijTj3MSlHZXXIcRhQ5TXMZ4sjJMuLbjQiU1NErk023zDdQdHTK
 jHgfe23iP9gli5xtuAGU5CsEwCsGTDUuBdGf9dr2hcHAegwG6EmmtNOmMKv1UDYV4ywMxhaKn4I
 Z4hGMGXFBfyJuB+xe8383Q2+HSArsNsmw0dnAN7Wgku5XmnSWL9Snl37PpEb7B9Zwqs/AZUfNcT
 4+ILHO1s/RHHgoxPOFf/TdUbtQ9ShelaG/En+9IKO5KsjsF+DSr6O+LBHH3r7eq36lgReaeOz5r
 qd5SY3+EPGSHpqQm4Gw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0NSBTYWx0ZWRfXzzlnx5TZG5Xl
 GtnHNe/48qIXNJGFd4BPC15eCQSRfPayL//8eEv/iGqSiv1bFJMM4BoNCS1GvIulYOkSH9KlwRO
 iX87DDvOsUHjmYuGfBSV5NItn6tfM8E=
X-Proofpoint-ORIG-GUID: 9aDCTRn5J_XJWO1x5UIGwB5JIVHDhPvT
X-Authority-Analysis: v=2.4 cv=MqLHeGae c=1 sm=1 tr=0 ts=6aba4d91 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=F8PB8KkoD8y9vLVCxn4A:9 a=CjuIK1q_8ugA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280045

On Wed, Sep 02, 2026 at 09:38:58AM +0800, Shawn Guo wrote:
> Add specific compatible string to document the GPU SMMU present on
> Nord SoC, and constrain it to the single HLOS vote clock.
> 
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> ---
> Changes for v2:
> - Add the missing HLOS vote clock constraint
> - Link to v1: https://lore.kernel.org/all/20260901140816.74200-1-shengchao.guo@oss.qualcomm.com/

Hi Will,

Would you pick up this change? Or are you okay with that we route this
change via arm-soc tree?

Shawn

> 
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index ffa33b7f4a96..214a9c051588 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -102,6 +102,7 @@ properties:
>                - qcom,hawi-smmu-500
>                - qcom,kaanapali-smmu-500
>                - qcom,milos-smmu-500
> +              - qcom,nord-smmu-500
>                - qcom,qcm2290-smmu-500
>                - qcom,qcs615-smmu-500
>                - qcom,qcs8300-smmu-500
> @@ -579,6 +580,7 @@ allOf:
>                  - qcom,glymur-smmu-500
>                  - qcom,hawi-smmu-500
>                  - qcom,kaanapali-smmu-500
> +                - qcom,nord-smmu-500
>                  - qcom,sm8750-smmu-500
>              - const: qcom,adreno-smmu
>              - const: qcom,smmu-500
> -- 
> 2.43.0
> 
