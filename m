Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795462806;
	b=UvYlfhzAicxdG5QmUFQNNLZr92VLfFwp7qghNslaRC4hM0oIwI5LgeLtIKltqnnsPQM8
	 FcB97LxRRC50poeC3dlzO2qzR1lDJyjQG3u28yP0xsHg/vbdHY8xmIHjVVmz3xB4N0d6H
	 Vos8o3cNmzoXD/CIZ4RRWMrPbRF0nwJq06GzRPDfeoSElc2OgroAFlaDVh+VpPf4JSh1H
	 +/irSuUC6XJpaKl/kypylamJi880a8pL0w80agTXpu58Qbpl/kkmp4k8oADr3rylvhJHc
	 B6AUEja4Ded2ztOU0qTSLVhi9OOYQRr7DroSi7nJD7OC1GvQgDdY7wEQcF5NElY8Kqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795462806;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=vbTovhPnqtGY+9gis5cd+giQqlIKSt7958zVNJnBgFo=;
	b=bcifNoGZJEMDWnE5pPpgSrM+gJ5Lfjdojb4tUIqbs2e9jpg0l+3yaPHQWrJPdQ3wl5H5
	 nEmEGPmABDsEPtHc00zmg/ktRDDVipUXM/y7ouihc3dqp4tuHB9H+a+ifciA0QiIaaJQm
	 IAbq+49B1U97kdAZosQX0raO8h0ybemEEDUtIs5UB4VsRIab5TYoEOsqVDZacjZtFTICI
	 LFB/DkrbkbCL6LU4EmzEamNpX2r+pgK7LNXGf3hRGpnYFVUZ3679o65td4mV5ZG/hl+HZ
	 9L0TX8ptAChwF5h1gdefU0UZ0kpGed/HTfWyGzS7X1eVU8XYEszhVvANw2t0ZoX/KAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WSf8nLax;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ap4eqvAt;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802D9606A31F
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 802D9606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WSf8nLax;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ap4eqvAt
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANGH3fo2487357
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vbTovhPnqtGY+9gis5cd+giQ
	qlIKSt7958zVNJnBgFo=; b=WSf8nLaxYf+BtiJytkdELMlLjzY4U8uDC4sNk2Ia
	R8UENZ7x3KeRV1NFPsgOMV8/o177s801pff3P9uSxgLjXM1daAGoAl2SNuzvCFJ0
	RcnxYbplrZ1rWcPEBMxbJXUFcBVqi8iBX8FD9VmNJCyB2MLRDTxs3pqT7xIpW7Fj
	CQlbtV1BQLewbM3+DleoXMV7pzKGjMn3BzFJ2HwwMf8kwn0l5RCr+Hvjpo94o406
	Q34fI1SdJg3aYlHiobthbcMgJY4czgF9t9Jc9F9GpJq2K06gVnmveaxGd9dqBgbJ
	H0tzJ9iQxpr0o8MfffMphYr/zL5pRJqQKQ56AhP2ChLhng==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4fy0365v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:40:04 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f6f4fe531so589403185a.0
        for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 11:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795462803; x=1796067603; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vbTovhPnqtGY+9gis5cd+giQqlIKSt7958zVNJnBgFo=;
        b=ap4eqvAtPhyREkqlrOmSWpZ9GtVST8sRuwIOCGnLrO6hHDB4RF1LOy4pCRlOd2Zce7
         5/uxRIw6cR6nuRG2PB3Ht+N7TXyXl3cBb64ENN4yrvmt64e0Vgm/GptFziPzL9vgsw11
         KsFCj1wG4yVvBb1S0uLbPteqn5Mykch11EpHqNugqoidoadZ9EDtTAh91bcIZZkksi11
         YleeyDIqCkh41V2GWsdjev1UVfQrxStK/d2W/KH7lZLR49WfLFbBaH6BryvDH2MyWBFY
         PUBeoo8jwf2RfHWQxbstx59GoPZHJIEzqak9HAlLjIWEUP5n8ijzT4bI41gqD0AXu6az
         EKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795462803; x=1796067603;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vbTovhPnqtGY+9gis5cd+giQqlIKSt7958zVNJnBgFo=;
        b=at8rvdfnLiai9zrePO4xGJkOaqFxwBeU9uKf/Gh7DLwjf55H4bKR0Ef6sF0rvCd7Wl
         RSR5fTPg1EWyTWS5KgHmjXt+h6TOh9DHE+1U6EpV6eg1LvjfnG9rxLUkJkkTV1ch6ppv
         vNTuGTukMFIKCwcfQdBs5HNd6mVQOCLjPN7yOVODHaxD3W/CcMqWhntDVWGDhjJjpTjU
         ykWynXN2RRe+zx6eqbbqtBEF1rW2KknyvR1VbM0Y7hUJn2F26fk6WTkZtIXP3xunqG6b
         T4KXPOhIWywAxuCWnuzx17tYGoFWrRZ/KIkAYu/eRR4WydyIzTqt5PU0tior+9Wrcm+s
         Z22A==
X-Forwarded-Encrypted: i=1; AL+hErHv2UCv+TjdcC2cILzhzkvGV3yrEj9rYY+Go6vW2FZ8tc0BzG1Ky5ITdbBlPL2oAvMqic7zwg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/OzSFeN4A2VWqzya2/Bq2dX1+ccAQYhJXGTaPC7T3GzyHUVZA9
	SVifjQ1fH8eQKhThdWwdkZuJj7Mb9S1jfmu5Pew8rssN7sbwUOK5C/wbeeMgYNd4JPBUrYIFdG0
	HPOJ/s+c6ixesO3caB0Hvm0G2qEkox7tPMxC3Xmm+KJLKH13eoGbnnHvUoA==
X-Gm-Gg: AZFdTZcrhCvFAsl0TMLfvM9xdu3QwJltqNwwhhXhcsZwm++m6psFqXP4t4CcvXgdl0U
	oj+pqLVmCpLMKfG2ewLvOf50xbu2i+afWW7IuEGuDp4FSVVhsLDO5YTCgDrVUBzW/gGBO1LOvmU
	CxvDGJu+DBE9UjfpZFt0KN32AONp6gyglxetKErdic+XZrhPFAaQ8XQW2h4iQJc2tlDnwOWhEmx
	X7lrWVASOzr4GVnYGLWE+CwjVX7+ETVmZTuTnrLqz+vBphFUbXHp3FPC5sL5QWwqAxa/hrRAk59
	7LiC/xmwAQVgqjZiRB1wDdWYpGGiBWWm5y/bC3CkTWn7/ROz1+ZoO6g1NCyF4Se3u5Y1HKczvjK
	iDEeDIdokpJO5JsYaxd3t2Xyzi97lZsdhbdF2Ie8ZJv2HRAtOypp1yqrjvkqqj+Lz
X-Received: by 2002:a05:620a:6011:b0:93c:c1e8:6504 with SMTP id af79cd13be357-949ba9555e2mr1970758385a.23.1795462803339;
        Mon, 23 Nov 2026 11:40:03 -0800 (PST)
X-Received: by 2002:a05:620a:6011:b0:93c:c1e8:6504 with SMTP id af79cd13be357-949ba9555e2mr1970752185a.23.1795462802646;
        Mon, 23 Nov 2026 11:40:02 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6baa3c4dsm19966670f8f.46.2026.11.23.11.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 11:40:02 -0800 (PST)
Date: Mon, 23 Nov 2026 21:40:00 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH RESEND v4 08/20] arm64: dts: qcom: sm8250: Add GEM_NOC
 interconnect for adreno SMMU
Message-ID: <rybbgcckx5s2gqnzqya3kc3kbsqvyp5qqwd6ct4cl6dre75fgu@jxlgzjkork3v>
References: <20261120-smmu_interconnect_addition-v4-0-be30526391d9@oss.qualcomm.com>
 <20261120-smmu_interconnect_addition-v4-8-be30526391d9@oss.qualcomm.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120-smmu_interconnect_addition-v4-8-be30526391d9@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfX78T/hCFs/q2K
 K9wtNFBUhLKuLrjcNEobRV/sHzelob9ZVl5y09JaabcdmW0iTzt7Exz0BCZLrg+XIobhbgoRmFu
 unIRTV4yIlfOf4ctDMaf8/EVrEiMYm/oaIH5bio3NPpB4TdKxgrC3gWlG3kN4By3DaahVBASoak
 hXh9CIfVZB2GUgX0DxMEbE6MsEQsd67/Z0OEOkytwpoMJJ5rcPS4yUnUckdSuCuY3CsUZ52qJw/
 uk4BtYkFNcpTfapP2y10ZQNF8rXmLjAG6qm3M3aK++lvT/RyUjtmFLbrZ62eWMx2ehP/8Cb0DDx
 eA5WwjXqNR43WWCd3bXSuOzCgwTqqnO5X/vxkzEKQTFzKYbqHSDe6Z6zf5G7MwHOobukJV2SCZa
 TXApiBE1ZyZ+DiU0tRuYFeE2tZukc68QU7vkeUiwrZWYPt/RYH5Pz1oVnl8wCS0wNOXhSlY7xDV
 yrIFVD+GnOnqj94l85Q==
X-Proofpoint-ORIG-GUID: Fc7gv94zP17t9gghd5IvkpQXVP-jzJLc
X-Authority-Analysis: v=2.4 cv=QrXLTlyd c=1 sm=1 tr=0 ts=6b049694 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=1L5Fs8CdhlNCfOXFGWoA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: Fc7gv94zP17t9gghd5IvkpQXVP-jzJLc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfX9NUcpalC8hyW
 VBFjHrynKF3/ytcKlcPxtNUEk/l+dvS1Ylf4O04vPawZ8XLTXhGrgI0ue79c9vABlX97K3CQBgT
 iHyCrOapo/ah9ABQLSJEoEN3iO75VKM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230078

On 26-11-20 19:11:39, Bibek Kumar Patro wrote:
> On SM8250 the Adreno SMMU GPU TCU is a separate hardware block with a
> dedicated alm_gpu_tcu master port on GEM_NOC. Without an explicit
> interconnect bandwidth vote, the GEM_NOC path to DDR can be left
> unvoted during sleep/wakeup transitions, causing intermittent SMMU
> register access failures.
> 
> Add the required interconnect to ensure reliable register access.
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
