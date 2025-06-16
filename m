Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACFE23AD
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 00:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750032682; cv=none; b=mAjAYg8JW3VhieoTuSi39QkmQb5Ysssz7+ewi7d0BPPJ/HzVBGA5nEMvoXykeugqfqABhS3PbXnTQ/KFOVB8UDLOrf6bYAFmVwMSwvIvMTRCNK17+atxMgkdWkbKLVkTn4yM3R5xnYwfRmEuYuJ1k7pJ6+m1OWQqdqcp2n1nL+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750032682; c=relaxed/simple;
	bh=mbkkVgFYRVW7IBPbu1Cg2y20fCsMjcz3upWXASAHUPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DD2ryCTp2XHIQIu84JXVKyGkTbc8eDa99+oaeUWxRB8YUrm34nA5F9H6ehuHzGLGWL6TbhP3Nd2Y+PFb/1an7aBxvquRF5vnAWv9dESvreoXpJiaB7YFGLmWBsm5lcsQQxAizOtK7RZRLKfnm0QyKJZ9NREMhQszJHv/3a7wS6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QOwC9Y4Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QOwC9Y4Q"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FNiigk006520
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 00:11:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=QGemQSnd+YjmPoLsIXiSnMUG
	hACJiUpHSlGPF4aQmUA=; b=QOwC9Y4QgzPoAIrn0bA4HgO6mxvb90gK25lWV7gV
	G0D7OncQoXfJMZeX/nN2ZXtYjRUNPu5hahwvSVsZPZ3Y/rPOo7qd+gpV2eVQpQXD
	k7FPM/dHX1XS1QGsR9YCsxVnqW/Vqs0QKiWSJ/OK5SjyoqEsETZu+Z6Q0eBldU7a
	wv54188WyiWoSvR3uEsh8WLrW6IIhEkAae3f432SbqJatUbovgtMVnBt6cUWnwrP
	NuDNIHWxpy7dvrtXMoV2lu7ZiiYNVtDCBCdz6vl58XfRVQOdNh0so0g/WblFkqyZ
	MFONlRKu3+SAwXyym+3gJf/wZN0/cxQGbsrKOwiWLKWXPA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47928magyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 00:11:12 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c7c30d8986so1397116985a.2
        for <iommu@lists.linux.dev>; Sun, 15 Jun 2025 17:11:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750032671; x=1750637471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGemQSnd+YjmPoLsIXiSnMUGhACJiUpHSlGPF4aQmUA=;
        b=D1q7QK9WXrd3psRQfOAerlUDEmzIjNVblIDYORER/oGka4rjyU7ntofTaSRHikInM3
         SyT0c5AuPZD+AQO83WwZxIZsfIB1U9aansKKqevXpSaCHM2JBpjeGbM2DQRRqiKcBCks
         V+KCUwapzA6pffU6Aa3KFT0GnBL0qZlczENmKybp2RhB2PqGecvuBMtLB/Mbo1r8obur
         3I8mOyQxD+Ob3/oDGXH5CNHPl4M/Bql2JnDhFjIxpNngfmGD+k8JMM891Cf8/HAsOC5S
         3vc3oRUNw+BSGUUOnaIPAnLS2KrV0lwRCQ+NhTp9a9PzOepWA9bLXey+PulwiG/22AU7
         yB3g==
X-Forwarded-Encrypted: i=1; AJvYcCUSI+LxlxiIyr/syxJ/wQaZdd1rHgwLlJb4hPIEofi60Sqz1AhJX8XWRt0EMaZs+OZ08wFYlA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyI6EvOW7VxwpKcwQ8tbqjExolxcakhVkMdA7pa2nl0iz1DBWjz
	FzxPcJIvHrKWXVWr+kBgN4EhRBRZuIvne4o9U2NWJ2ciVHsQNmHfdgO3BOMwXpZdkR8aqbAexhc
	2J1UEcym8ZS7Powx6f/QlpHIoVIgePPfmdPJvMwBquZvj6DeSLehJaBhQqp2qM3JpB6Rp
X-Gm-Gg: ASbGncuLUVcOBMRpMIhgkYq+XlV6CI8D10d/BBtIvQOtl/h59+l8ASijroBUe1lqWaQ
	SeqhiaazulhNltTZl/ofzWxZlFE9VYJtWaR78zuogHz7aYDjp5KFtg2Y/L/2OTejO9p+jU8qdAI
	kORpw84iFP9TyUL5aJibj56rESZJz5FlyknXu8qVS+QFj6bHIV/xKlUc9W+1uaFzwbqs26gSUg4
	+rguLJGcSRtuvBlGLh8cc2Vg/Qh85AEpmxb6aWMdIJBwU9bvJdsuaSl5KzGcJAKBN053hAvP2JH
	NYKRdloA2VgEuplL6CZ//QUVUxxDRixl6ie0XBVMawc7GmcBNOhAu9rtxt0Dw43ZixNgcACB37T
	cVk9O8qY2IgZ52ZYSQgpRVlDB82a8ivDyMUg=
X-Received: by 2002:a05:620a:1a05:b0:7ce:bc1a:4902 with SMTP id af79cd13be357-7d3c6c16d6dmr1294940485a.13.1750032671269;
        Sun, 15 Jun 2025 17:11:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbSkDjTNs/Dr3Bi6RCwQRdoGGC3GS5fEbglwoZQ8FxFoTXhFx7VD+QofnLhJtsly5onZKa8Q==
X-Received: by 2002:a05:620a:1a05:b0:7ce:bc1a:4902 with SMTP id af79cd13be357-7d3c6c16d6dmr1294936985a.13.1750032670871;
        Sun, 15 Jun 2025 17:11:10 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b378371e9sm13076831fa.46.2025.06.15.17.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 17:11:08 -0700 (PDT)
Date: Mon, 16 Jun 2025 03:11:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: robin.clark@oss.qualcomm.com, will@kernel.org, robin.murphy@arm.com,
        linux-arm-msm@vger.kernel.org, joro@8bytes.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, andersson@kernel.org
Subject: Re: [PATCH v2] iommu/arm-smmu-qcom: Add SM6115 MDSS compatible
Message-ID: <bodnhg576oaludi2icuodo5ycjrplkjxpci3yh6sj62bbfj7ry@z2hm4cg7dclb>
References: <20250613173238.15061-1-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613173238.15061-1-alexey.klimov@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE1MDE4MCBTYWx0ZWRfXwTnQ1kNxDW2P
 K3tqEytS8Sc+VUVPmLN1iK+OSNVF19SmgtzqvZoFVWhJj5B3m1lxU3se+0FKuLiLeychrjIcGxQ
 HPgUhAOhyLrgt7qpPlSVWdpCPyhDRWODyyCMiqz2Q6Cz2YJJw7IGBqSmzxc+TPdmF8UOe12gYZv
 mL2zCCu3a/peagHyo8w73efVN9J0ED3xgsj0WB54M6uJEfu1MKEkn9zGcaa6tSBWTwzdLBzWDn1
 Kr2IcdcL9eJC3NMjyXcZIGWZsVlnV7UiGrHir+gB5j2mC2rORxHJyGVpgpy6gxuz7xx1azn+hVx
 PJIIumeV0Mot4IA4mMJsDfffBw3vOB9weYbF9mOHeHfqht5n7r+CrUzDqE1RW1CLIAi1IKsVJfY
 cMGNRIvFL2oeKo8SimMuu+a0dNPWTCU9uDKi05CmbotY8K5rsZWp+uJql/QMi5cBIZzZ6e/2
X-Authority-Analysis: v=2.4 cv=fvbcZE4f c=1 sm=1 tr=0 ts=684f6120 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=7TFj5ihdlhLXfTPaXogA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: LZc5yAPenzM7IluG3GkoC2mE5XOFIEty
X-Proofpoint-ORIG-GUID: LZc5yAPenzM7IluG3GkoC2mE5XOFIEty
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-15_10,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=601 phishscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 adultscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506150180

On Fri, Jun 13, 2025 at 06:32:38PM +0100, Alexey Klimov wrote:
> Add the SM6115 MDSS compatible to clients compatible list, as it also
> needs that workaround.
> Without this workaround, for example, QRB4210 RB2 which is based on
> SM4250/SM6115 generates a lot of smmu unhandled context faults during
> boot:
> 
> arm_smmu_context_fault: 116854 callbacks suppressed
> arm-smmu c600000.iommu: Unhandled context fault: fsr=0x402,
> iova=0x5c0ec600, fsynr=0x320021, cbfrsynra=0x420, cb=5
> arm-smmu c600000.iommu: FSR    = 00000402 [Format=2 TF], SID=0x420
> arm-smmu c600000.iommu: FSYNR0 = 00320021 [S1CBNDX=50 PNU PLVL=1]
> arm-smmu c600000.iommu: Unhandled context fault: fsr=0x402,
> iova=0x5c0d7800, fsynr=0x320021, cbfrsynra=0x420, cb=5
> arm-smmu c600000.iommu: FSR    = 00000402 [Format=2 TF], SID=0x420
> 
> and also failed initialisation of lontium lt9611uxc, gpu and dpu is
> observed:
> (binding MDSS components triggered by lt9611uxc have failed)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
