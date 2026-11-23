Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795463054;
	b=Kk+D5G/iwhsWTCMs99mRdgQa6Z6IdWFCS/mlwWf+KY6vYAZ/xhyop4+GfeMEWzYT70IT
	 wUCQLngcNyRoi3mkHm77WrVQ5xuLE4vIyFI6F1m0+yZctAbFM+4ZKxevNrFb1S/nZrwJs
	 rKN6quZ/KunGuOqr5x9/3/OvV25avUBJH2WbtpFeE3im+pq0qYf3tjBqAqd+4jKmC2mFz
	 p6NXohO5c1Q+dgHXJ0emP2YdHMUxurUIic01MLVhSOV1PPmId7X95qvR4IzuG0L5hYRsw
	 71a2ebiWvqfWr+JTyCAZ++UQA2Vxux0/SbysLrzoY/rywZOXt+Rrx23My/ayml0nkGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795463054;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=jmqs384t4urG0xO7kZnecCDgSxT8h0KsuOljD4Hr4ko=;
	b=X0r0s1LzZc+NFeIiVcxR6z09dTSoKwcykLJ7IxBFP3kqs9b/rUKSgE+bGuh/Vv89tBeA
	 Yc+TCsydIcLoabmHV3CKkmXG5wxv3j87s708nOXg3JP1Q3lgGp792sJqXNkXI/KP+F4Yu
	 BR3HkOh6dQeHoKvo0081Ldc3Ahgpb6FjNN/XnMaEU1onvMD4OQaompaJPYlMBfbHfOnQh
	 E4XL/5TJZrMgW3xSb+TemxTHk1eLhqzktwqNV+cYtNQDp3DFEza/jSdX3dxgSCSYlRqYT
	 HSv1ouUshyQxd+MrFANUCN/82fzOA8vqr7xNBcLXc+H9AV1MUBxROIxYDIAqasaXUrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Yxzx6m9m;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Uc8RLQiO;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF21606A31E
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CF21606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Yxzx6m9m;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Uc8RLQiO
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANGH3gg2487357
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=jmqs384t4urG0xO7kZnecCDg
	SxT8h0KsuOljD4Hr4ko=; b=Yxzx6m9meyKMWzTUoV4ZM00fA/PyHef1MQwgy++0
	RsvNxCLo4tLsnC2untVDjNHHdCQ9VpYwX5wEUV/++y0CugsVH50C62mvbhDkqYtN
	WsObSAYlGtkK8b7emb42vlaMjRZxilMbLZ4afLPRoE51dE8zanhqyuVJnGu20bxR
	tBfO8q37WsXv6bJzgMAAElayDj89NcOUIajq7PWYVdPaXOeMBhaFW54DESkD9qgI
	TR+irxyQpXpqKCFCc0RFn7BepbJAEt/iaiKHZjXzriyAH6D3O0umBbtlDlMsGc8g
	ED3iJAs96p+kHNqiozocaNlcP5qjyjs3iTh+A6kCtoGgiA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4fy036ux-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:44:12 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-94961511b61so623834985a.3
        for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 11:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795463052; x=1796067852; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jmqs384t4urG0xO7kZnecCDgSxT8h0KsuOljD4Hr4ko=;
        b=Uc8RLQiOcUyptrryNF/JoqT5UF6dLtVlJBQGUCGPtzABVw+eTrTzZ52o1vJg4HaiGc
         3cvcilZiu6HD/sixeLxfS2s4y6ijYNwLLxiRTmGwtBO+ho0B9R0DMWoFnP+wJVJK6t/z
         0ccED0/LxoItYnDDyTdTXIJwAMYiiu5NLP/KmIaX4FY/RosAxcqEp+3dMItMjub/6U+H
         /0ouhJxU7Rxro2xvfWLc12tT2ybZDOdjGlF7wi/6xUFsq2gpzzlK0l1gtZKXeA3Rf7NC
         a7PCtjpa12qUud8pxnzsnJysknA/NSN7gYfgJ4Wj1Z212TH33VdHDC6hhgsHMkMQLa/I
         TNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795463052; x=1796067852;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jmqs384t4urG0xO7kZnecCDgSxT8h0KsuOljD4Hr4ko=;
        b=zO4mWr9xRncocPhG1w+B3RojB6djPo7r0swtiKgSkIB7yD0/l2A1TN/IWOZeYMpk/W
         ilJN+MxfW+iM6DhXhFxdYLvQcqDVdyLPYRqeSA8UKlauS5r9fHZmFQ94urtx8HZfM0/x
         uspfH7a3AtP1IOFhKN57vxZ7deFHdoOZFsknBzgyewS7TM1nqm7Ggi4gpXIRJPZymK1b
         XlN1fmd6gYm7Bg/mWvGCc0GNI0Fe0yOYX2z3EVZhdyuq6yS6SyvRu7Sw4BHRg3FcEhh7
         h5n2lgtbCi3iKzGxjWOOcW5JhxbCDxXVFt+ti+vniNNatjhebVFiNo5EY4MlP6hoh4Hd
         mXlw==
X-Forwarded-Encrypted: i=1; AL+hErFmQmQ+g/OnHNmf7kHM3W7IUfX6VQ/VakgM4lGLuNAcQdK+7NpTTijgRgXq7331sBNqKIf3dQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/zdBzJnGSE/hu5+y4iK77P4mpZ+5a1z35kdMbjrKxicXCFAvig
	gxkMRjPNgOLRTYdcFUldbsSvWNwtVbepDK6CGHUDXbKaqL1RJCbOLsd6MOmVCQFKPZcgZwMuzo0
	pfojTouXJU3Ena41NxdN4tvWki7yIPzt3tV6ZPpgpNQ/feDawSZRM9L2dYA==
X-Gm-Gg: AZFdTZcbC1x5V/oVgI1ICqOO08DA3YvOwoGgld7vblfVv5o9r2sMJmXm5d59OxzWHiD
	H9GY3HW/sEjK9UpSKWNltw3yaOqi00c1Lsha3B/tQyjdZNHpJL8VE89dWYhidTjrqtPRmLXbq63
	JnCOewWtM9Ry7uJa9Z7QqwLDLKrha10l5qe/Ss/foPtzCMdM/rqsxn0ermcPGOMESpX3udwG0Jh
	y3kloyeFTKJrfA/nceECuY+sdkwp8NlwjNCP63xMaFU1o75a/UddIdG9cZ/+S4+C9mznt0TxchS
	tB/nl3nMwnaCgQna9KRQATulLda2VdlAAlom7cbDgNi9aFi7I2si/qJIqkEIloDQXiVdJkaXWst
	Gwst3Fm1qZQE1AFOscaZQ5mxZOcX3xgcsUBn76gxH7yWtc/Nf5xs1L0I9mU+5wLSJ
X-Received: by 2002:a05:620a:6481:b0:949:90a3:3ccb with SMTP id af79cd13be357-949ba9fe6e3mr2063646485a.61.1795463051693;
        Mon, 23 Nov 2026 11:44:11 -0800 (PST)
X-Received: by 2002:a05:620a:6481:b0:949:90a3:3ccb with SMTP id af79cd13be357-949ba9fe6e3mr2063640385a.61.1795463051048;
        Mon, 23 Nov 2026 11:44:11 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c340df4sm27593394f8f.55.2026.11.23.11.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 11:44:10 -0800 (PST)
Date: Mon, 23 Nov 2026 21:44:09 +0200
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
Subject: Re: [PATCH RESEND v4 20/20] arm64: dts: qcom: sar2130p: Add GEM_NOC
 interconnect for adreno SMMU
Message-ID: <lafjekmlbln5uccdgrqqrclgoeu7mrsgxbuze4cu7u7zoyrplq@7qdploxt4a7r>
References: <20261120-smmu_interconnect_addition-v4-0-be30526391d9@oss.qualcomm.com>
 <20261120-smmu_interconnect_addition-v4-20-be30526391d9@oss.qualcomm.com>
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
In-Reply-To: <20261120-smmu_interconnect_addition-v4-20-be30526391d9@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfX1GSD1mrIur4u
 DFr/QkXcGQWnALCXGdTmryMk8mfy0RCyh+Qy+r6lgJZWzUxlqw+Be33XBTv3zhl6/WgJtOJ6ymj
 j9M9Z9FzOwitTgsxHwi0lf15d8a+k4FydsZYF7XgOXOZzGEUm5iwxgASvoDiqszNcprPXRDXese
 3uDVhB3RnZ0eV9QZZ9Vo3vKoytu9Xgd2squmEP9nYbHbE2UjgJ5pMK0n/GMgCi2nGgD9ORHV6Nj
 nHCk3rCoyGcnvr44IXoyyiH2i9B5zC8RQRXG4lZDPbtqHcHJ/Mbd8dOXx7UaTTHHyXvVkm1bbXp
 zJkCF12iAR3c41vwouzqDVQjDi5trZcfFIWL1LC55A6NaDxv2YsBNNRGj3NVbB5bUWX+XM+BAik
 2qo/Oi7kgKVbJW4Prb2/LVtoGE+CukVRao+cpNlqfP99WQkaMFAeWB9iut3GD/+J94ODR2Qoy9Z
 BbE1lmsCO+0gy49jl/A==
X-Proofpoint-ORIG-GUID: kFJFw3wWC2jAQiyyFcimmHeBse0MWrvD
X-Authority-Analysis: v=2.4 cv=QrXLTlyd c=1 sm=1 tr=0 ts=6b04978c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=jAy75CqWmSRsgNc4pWAA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: kFJFw3wWC2jAQiyyFcimmHeBse0MWrvD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfX1EX6rZcmxnee
 8ws11NI8qvB8qnGYACKX01+YjBoN84Tnj3J91bIa5umCAcQK/WEOMY3VHj164dY7/ni0z0UgF9v
 oD3DcUYYTiBqQN+oux1rUSBxuGdykVA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230078

On 26-11-20 19:11:51, Bibek Kumar Patro wrote:
> On SAR2130P the Adreno SMMU GPU TCU is a separate hardware block with a
> dedicated alm_gpu_tcu master port on GEM_NOC. Without an explicit
> interconnect bandwidth vote, the GEM_NOC path to DDR can be left
> unvoted during sleep/wakeup transitions, causing intermittent SMMU
> register access failures.
> 
> Add the required interconnect to ensure reliable register access.
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
