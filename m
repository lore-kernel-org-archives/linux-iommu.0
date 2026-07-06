Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A1F3AF64F
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 17:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783359549; cv=none; b=Bzg1wWSSpJDEiP7Ehq7SQ3/C/Leu576J9eacEDkjBjLUXkRpE18Y9+FMZGFP7dwPHUATWQOAb+V2kwuhHfQ78DBRk/AzHJWhVIM4PtBYAAsHpIdxCgWwNzcn2yJTNC/F/A/a77McJEmR3wdPgMhkCYpi3mnDJanSNAskuHBSkHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783359549; c=relaxed/simple;
	bh=xre1ylS24RKmpgFEAZDl7Niim2XnBTvW/DrmPOJ6a9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NpmjbiDLKfrVBjpvL42Ikob7ovw/eXg3DrtOzxHtvlbmZ4PdgfTBtvHg4jA10iOVrU7gq4iQBofgilgHuYgjYfOZ5xktsivQ5IZBxvLJ3787o/Oeve3GIhI2LYSBNqBIUaITIkk2ciDNeXr+FnKKfxCLa9IqD+09KFoSA/Ajm7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WH0qJUeN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PjRaYXda; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WH0qJUeN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PjRaYXda"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FF6Eb982438
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 17:39:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YGOdWSibWy2J+WMzG5kjYx1/
	GW5ewADeIBUplqEh2Mc=; b=WH0qJUeNVYS7Hd/3LByKsTPskXpLO4fmyO/Y3ydE
	IqVkCbncnX0WmHjSLfMyDdk6T/Zy6uuVUaSSY9492sNMmvdaMcFtLFd0xPvzzLrc
	rsouCxI6KHCQ0MJdYSb4ILsgh0qy2mSoz7D7+Ly02Ee+N+D/hJ0sIZ3d1F7s2L5p
	qym5hMMAOTODns2f6b2r/lcRmvwTJLxJ2fMRngyLx6YwR4Of/7OARmvm7R8EENq9
	fwBGw2HAo219wcBF0Uyn807adlS4Te/FLJ9iaXC/2D94MjzWD229OgBuO8kT2Xuo
	VhN9KWNNMqnGdoCvN4BcGYBpdfEcjsXOIvTlQR6TkbjlCw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89qpj7fb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 17:39:06 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e53b8a302so310374185a.1
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 10:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783359546; x=1783964346; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YGOdWSibWy2J+WMzG5kjYx1/GW5ewADeIBUplqEh2Mc=;
        b=PjRaYXdaehev1E3n4c1YyhyhjtzYuabtrKkBxReXoT33LI/saKVc9IkJbPXwQoDyax
         GHcRng3lslfKZCoFkJKitVzfBJninstPomhpEAVc2LlqIyoPd6MdoT6mWWzBoq+uO6nU
         K7S6XN36LrmlF7RgR/I87qJH0lnE2It4rOW4/zoqYLkLvHFOxNX82cYwvKXgzMZgLF6K
         GXTwiYB2uWNADEi0aU66mhrxYrDf5udRI31Lz++GO+bXojI+U8alI+Z3PrpQjUXSZukG
         jeJ/a3qpBYIpybbntrIo7pII/AEFtnEd4skIUym6AUlFcP8ZwGDg/AxcPGhqtHtAM9bl
         J7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783359546; x=1783964346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGOdWSibWy2J+WMzG5kjYx1/GW5ewADeIBUplqEh2Mc=;
        b=fcrzuSG6ZxzBFAhGQCqRdAug6tCNGEjXotdwSEvd6LFAC3ZhdpEET674+d6gx2okUN
         IFAKyrThZSQXoWhMJkVQCTmPVZ3KnRPNStmInCl2afJ4sBGvRCSOpNrWp+Zj5U925GuW
         fkou3lMYqJ7+YMSYoQb92EEjh4bb7WoRem9ICpji70c9uf2e47XT5BbPY8tQtIGL66hW
         FPifW7YiKs1V4GOmjysTvDrrLfNCSFtb+1V2liVOo4ZhKY9dwLkWTUYHaQScYtazre7S
         Y2gGSaC+IMyYQxZ0eTn5UB1rYV4IBqI/QtJ3r6oKMd/0AbIupRUf6FShog9J17L32MdB
         2JYw==
X-Forwarded-Encrypted: i=1; AHgh+RokG9MNzztwOdzhUwKC005y+kZrq5yancgmlyyPpEowoTm6xGvkxmrSnccUqqDYomPx52S04w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgxrxNRwpRcTLKIUrnArr29LlR81j3FF3dT88gx8euYR4MGs4x
	MgKM4/XO8BICQMyxLMukhlLThuPSN/KmD05TLpkKLL7Qzmmqj/GyFt0XlbxU3fqKRPHxssyk2o7
	iWtDY8yC1Rzs7/inemsAt1gGQEXZnI5ou/ceRttalSDJ+bd8tg3O0ToWaMA==
X-Gm-Gg: AfdE7ckdG9qhhBmIYKH9paHrJQEReHdAxEODGzPswis7VB2snMsCT1kgm7B4O0F5xs5
	ewcl+/Ko7SQiDxughDrep+Ln/31JG12j7jWghAifFp/QvK0D9P/5Kfa2mWMdaXl3vzDjVBRv/kR
	krlPHJA0fagZPtHssh1hNpQwzSSFypV0lmrh0JKx2q2JX+g/vTLxHMRYtnahTsbYPT7gumTWxEv
	uhNtdrH8NVXTXW6v3bnKTReuZUaTNYJ8X5GBfT0KuzkuBj1c2mh48Iw0axQTkmd40ske2AnG5Np
	8lwe32CJKPQ3wM34ZmgJOTYskCKiV205ZDnlHqtp21u8JofyvatFPpB4Dy3JnPMly2kddo6Tn0a
	a/CcFBfmf49cCQN1U/75Rj+BDzT27XE447Vd8ZAskVZsX7RNjtOksDZVOclFljJ7KxvS+oSGaJO
	wNNnwdtHXz2SyRtTXgOtPxS08n
X-Received: by 2002:a05:620a:2904:b0:92e:84f0:d3fb with SMTP id af79cd13be357-92ebb529002mr232274585a.15.1783359546201;
        Mon, 06 Jul 2026 10:39:06 -0700 (PDT)
X-Received: by 2002:a05:620a:2904:b0:92e:84f0:d3fb with SMTP id af79cd13be357-92ebb529002mr232268285a.15.1783359545628;
        Mon, 06 Jul 2026 10:39:05 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39b4ad18af2sm20869461fa.7.2026.07.06.10.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:39:03 -0700 (PDT)
Date: Mon, 6 Jul 2026 20:39:01 +0300
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
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: iommu: arm,smmu: Document
 interconnects property
Message-ID: <nrht4irqtvt2vk3lrqvljonarc4kanht2nrwjt7pppsfhozffv@o4xei47l6gcj>
References: <20260706-smmu_interconnect_addition-v3-0-afdca0125a65@oss.qualcomm.com>
 <20260706-smmu_interconnect_addition-v3-1-afdca0125a65@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706-smmu_interconnect_addition-v3-1-afdca0125a65@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=c6qbhx9l c=1 sm=1 tr=0 ts=6a4be83a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=3fmthTPW8Nr5gDDPHxsA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: DyZuiuJcol9NzLZ7puKPDhwEF4sSND7Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE3OCBTYWx0ZWRfX0bOJE0MF+1R6
 UTEcdehgL6sRoOeG5m3U1MDzhmg73ZW52YMdeufnCGhdIzmysPxZ1AW2WhXqfl1nJjUC1cVo6gc
 BZXuo6LRk4e1v4+uTtyFps/MukAgskTc/vYBmf0mlMWA7S0PzFaxenx/c3RfDj2e4bk3snW0HWT
 ysLo/N5/aoKoq8gwo6FRIXiA42MCzC48NI0b/ymtUZW9wQ9JcwVD9uS6824aUsLoERuGotJkaJP
 vMkUKXYIFIhUUWOKs4Af6QBqH2f997zbDp7bKn8WWR6TxazuT6gQNOYauZUJSg6/wlFeVkMmfK0
 VbEQBf+tl8wHUAtLutYXZvETVYWqQdmTi0NzEfML0x3JnGIxyn217lnf9y85vhknXcnsJDvuZo8
 5r+3tnasQKiRpq+FhzMJ6GIakFIsJxXvcw6nYjRqhIyMRxYK3WfuXsg6vbxx9lmYTFYF9LL+ixc
 OT5W+5LthBd/Wdb9PDg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE3OCBTYWx0ZWRfXyt5Gfna63dFV
 4ADllGAtVVzbiitVezTbeTxjtvAGhNkPrBs3Flkx5c4khlWWeGz1GbwXY7cXXVGK4a4NgPgDmTP
 s/sa4W3+nOtwleGKiQ3FOxro7CGhX2w=
X-Proofpoint-GUID: DyZuiuJcol9NzLZ7puKPDhwEF4sSND7Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060178

On Mon, Jul 06, 2026 at 10:26:34PM +0530, Bibek Kumar Patro wrote:
> Some SoC implementations require a bandwidth vote on an interconnect
> path before the SMMU register space is accessible. Add the optional

Why is it limited only to those SoCs? Is it also applicable to other
Qualcomm SoCs?

> 'interconnects' property to the binding to allow platform DT nodes
> to describe this path.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/iommu/arm,smmu.yaml        | 27 ++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index a701dec2fa0a..fab8944d7b63 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -246,6 +246,13 @@ properties:
>      minItems: 1
>      maxItems: 3
>  
> +  interconnects:
> +    maxItems: 1
> +    description:
> +      Interconnect path to the SMMU register space. Required on SoCs
> +      where the SMMU registers are only accessible after a bandwidth
> +      vote has been placed on the interconnect fabric.
> +
>    nvidia,memory-controller:
>      description: |
>        A phandle to the memory controller on NVIDIA Tegra186 and later SoCs.
> @@ -644,6 +651,26 @@ allOf:
>          clock-names: false
>          clocks: false
>  
> +  - if:
> +      properties:
> +        compatible:
> +          items:
> +            - enum:
> +                - qcom,qcs615-smmu-500
> +                - qcom,qcs8300-smmu-500
> +                - qcom,sa8775p-smmu-500
> +                - qcom,sc7280-smmu-500
> +            - const: qcom,adreno-smmu
> +            - const: qcom,smmu-500
> +            - const: arm,mmu-500

Can we be more idiomatic here?
Something like:

if:
  allOf:
    - properties:
        compatible:
          contains:
            enum:
              - qcom,qcs615-smmu-500
              - qcom,qcs8300-smmu-500
              - qcom,sa8775p-smmu-500
              - qcom,sc7280-smmu-500
    - properties:
        compatible:
          contains:
            const: qcom,adreno-smmu

In the end, we don't need to list the full list of compats. We need to
specify that it's Adreno SMMU on one of the listed platforms.


-- 
With best wishes
Dmitry
