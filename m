Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795462870;
	b=UsDWDJnc0W3QCgCKsLQqZPrQapKQlG0+P2iCYh0+9ooP6MATGG8aJYdtv65PhEg5e33P
	 ea2D+3cEBWhFvAWLz/9fE4fXx+fbe0Gw1foVFxp7B007rCwFnjwnxZC20OIoesOjr5CjW
	 vhFG4ZdqMBMYk+Zb9nZ70xUwZNSihyZNattHfVDlFjD1sA6MrHuxGpeZilZzgeHzTx6Ly
	 QfQ3tKcq9P9zn/9wwPOvUOmbzm6/R0uWn5tomc9IpxAI+fr+duzbLPGAB8fJu6fGmiIyE
	 Om+e6kBrl5KqL5HNamPdKlwifEWF4Iz6/vDx3IwC7Q3/93mD9CoF26au1iIXbNAKDcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795462870;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=okCL8kgOe4YWBJzwczqiUxr3lV/zkclx0rToDi20iXA=;
	b=iJiXcXfzCcgdJ+hKIIF9+2iFHpjacMzJLvI3Wkruu/Vm9I6EM666Yntj2jpz7IaQiBuQ
	 K0m/cIU8ivQyTo/ys3XYFCfTE754x+LM2j6AJbCo6glPHjKetQjCujEqoST0mVSnMCCoN
	 mZrCHDRkUvLhnXwJce27wDWD23B6LBwzH1m2gmbVP4Yn0/lDgR6+MqcYjAa7dkKonSKIV
	 Zmuyv6bS013LBx9w3SJdi/mHIBvP0lgA6YXTyI8F9KVr6uTeiy9N1y+QwQqlH7dBFiLTu
	 16BvOjPMIwGafDqHHycZQfOmy+CI+aHrn4U1oYmAo95j0BJBc1pOGerzHa4+mO3SBpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="kX/EhceN";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y5dD98uJ;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70708606A31F
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70708606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kX/EhceN;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y5dD98uJ
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANGGlF63730160
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:41:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=okCL8kgOe4YWBJzwczqiUxr3
	lV/zkclx0rToDi20iXA=; b=kX/EhceN6e5M1VQxr5l21L+n06WZzx/2LLMIL5Ld
	XtIA/5riM2Jl8wuizaO0P8XhHrgtUOsA8yaZ3t6/a54JhVHAA/OLh8WiCHIXESWa
	hIGoueXqk0vHyoxCMbcbsgsdWZKyNmjQsBeuz5yVALNFUJKPfWT4rwUWdhZ/CGT2
	dQeCaqxXwj6o7inhvLyl1E+qhL8QzNK2yqtMPBT6744PH3eQy2ERUNGI0zPd/Sei
	F7C5J11ioBiCjGE80iTA5BWhqBXhMooxqJbOYhhL+yVn06Ak4Q/pYF49bARcWBlx
	6Thf8jHIuTWjRsi9e5Nvzsw+p/wSSaEBlFmBSXoac0ChLg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4fyd36b1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:41:09 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-94960bd17b5so614737585a.0
        for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 11:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795462869; x=1796067669; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=okCL8kgOe4YWBJzwczqiUxr3lV/zkclx0rToDi20iXA=;
        b=Y5dD98uJGcLUYSuuy2mJkUAjIJ6G/gnebkH4ZWBduYqtq9+TwE/53N0XHpnIvJVX6y
         BUeh+hSO1oOFhP12n92xruM0RObzYtRKD8Zi0lUAc6+nF3zqVcpthX2VwhlJ1RxIDzIS
         mk/v36e+2fluZHfZ0Vhn3roojf80zJiw6r5AB43p7WHLVT1poIURgizlyxyz/Ux8QICO
         71EOnN7zVkIIC7omJAJJFv3XzPq1yt7OOBhOWO8kVuMgeQ9O1siUGIRivoTsUg5T315h
         XRzkGab7p8WZm9L37hk2qHEJmtPJRiZPP6mhkVi4tHUeLtcvBRe52HXlNOD+cJf/SEP3
         v3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795462869; x=1796067669;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=okCL8kgOe4YWBJzwczqiUxr3lV/zkclx0rToDi20iXA=;
        b=nt3EiGE68jZ24GaMvb2jlu+kMGon1kIggVFqMyzbLCLOMEFi1gUAZ+QJUbWOSINSq2
         5nOZFeZrJCVhkO36yuQ2in3iXukLzMbcuRilH8EHrE8HPYmHJXIxy4yfk8yBRZekiyVS
         b4OB23hUq7HS9IwYITCqKQ4sVnkPVYPzYPPH7KPxo9mVOjsaAHIiNea60o0vCkRm/AWc
         zmEiD+FP87v5MxEuH6eTytSquI3QGhKkqFhVPxfZ4/4OtydJsiQE6wyPID2zLJEDKq9m
         Mf6uHb08/5gqsJuP7O+SX6lfCBctJCvr5js48q3k2rK7T+B4Gpz+jp5rcpiPcjeSQfiJ
         X1zQ==
X-Forwarded-Encrypted: i=1; AL+hErFgB3N9LGNBqn3DPmKD/lCkKiyiGuGC54tpuasCsuIpGr/DckPsuZL5NoPFUzxS3RuG+5PmoQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9hLLT0RleqHhmZZZYtLWZbK1MqM1DuYf3AkHmvCYVlLzRIs3+J
	ULKI5IfZ9ef1XOYV9Ho8TF7xrL6M6NTqlkACTp5B98jw/XIbv+xtUUd1LCRe1yDNn79+PFsUT1n
	NWT1NjckVRQ83CUjDWSqwigYPfLNk9ob2Pqbj5ONCw7Vi4jGrtyRf7gNUtg==
X-Gm-Gg: AZFdTZeBm1ziui+8WJT7ANcBPBhVny34oYhl9KOThlVwimw1MuiObqeuLQr7gAAvPNr
	McSYtjr+M/Jo+HbgkH7tiCTALl/sa8j+YAyEH42y7NhbT93ytrhdBARDa8f4qvzBKPHZrLxEuVN
	DTd08fTSvduq9CzEvoRLgy4kAJThjSaZpNlRNl2o1dnXwNhy5HVFUEOpkmtD/plkRtH7dLPYYUY
	+LYOSYY57DoAj+m25uVfkJHEaNLgbBv5QmvuG3pWdHNQ9/XSRm8ZIn/Ypkv8esFZadjwyyw61lX
	lfCeslFCL9kLw06A23tYJrvmc+Mwvhl8/kMOPd9lK0JZJWHjOGqrC1OdU3a0XEAHjUPz/elA8RK
	M8jYD7UUV0VHMdA1RvGiWNoekcDCweAHm3pZW0bO0XJTMdrN/JsyNbKzWwpKfLYqM
X-Received: by 2002:a05:620a:8812:b0:949:78c0:e186 with SMTP id af79cd13be357-949ba95de77mr2032516485a.25.1795462868657;
        Mon, 23 Nov 2026 11:41:08 -0800 (PST)
X-Received: by 2002:a05:620a:8812:b0:949:78c0:e186 with SMTP id af79cd13be357-949ba95de77mr2032508985a.25.1795462867959;
        Mon, 23 Nov 2026 11:41:07 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8526cbd0sm490807405e9.0.2026.11.23.11.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 11:41:07 -0800 (PST)
Date: Mon, 23 Nov 2026 21:41:05 +0200
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
Subject: Re: [PATCH RESEND v4 12/20] arm64: dts: qcom: sm8450: Add GEM_NOC
 interconnect for adreno SMMU
Message-ID: <lljflqhizl3wlw5pusaslpxwmfe4taxadw2prfogsxr77voe4v@ggolvdeja6op>
References: <20261120-smmu_interconnect_addition-v4-0-be30526391d9@oss.qualcomm.com>
 <20261120-smmu_interconnect_addition-v4-12-be30526391d9@oss.qualcomm.com>
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
In-Reply-To: <20261120-smmu_interconnect_addition-v4-12-be30526391d9@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: WeMGcmfuna4icqmawbmW7gJYEsbnYicH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfX9ULJaruhkbev
 VNlWnp5Yt9pomEoJlXRvJSiexVmbuaoID+ljp7TIhwShoLa2794KUrhtwnlps7rECvZWjIP0lKz
 kxOy1QnGFpSbPkbQNEmbMuhqAX/rRySHu+i9yBTO5MXZcF37Txyt1OLAVyNXthvF6peWC2TswAe
 0lrcsvqgGPUjbnQUrvKEi/o9ECpuN2BBSTIP65nV4izPtwERlBRJPR0qL5hz0WO6A5G5xsuldLz
 ljkaB2m8fdG26cFeQH78lg/iDIh8BpJNsGz2iPFSKchNWGphhUs29iNHGl6V5nCuyOruDP+t92x
 ueKL5KM6dgF+1am27R26A7cmrFp2Avk6WKaiXNaqsFcYJiojNDUlJWcPLzOQ+FmpW8otpI53o1T
 YgffQvI2NQQGt4LB99PleHNc8htSgIvsIrMCCPxYjPhcrYohdm7LmOIattW3Il1XDxBLaIfa8aR
 fU74GLIH2BXwPp00djQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfX+moyI1hhWygZ
 EX/aV6kE7nONNwhfYnFo43ngSlZWXM1yF1KvqlhBC7XrYoM3CZT4SH6YIrI+H+gZhuT3bSSZdAW
 GhecUvQKrj9ld6QbsBl090Xmj7Hvp5g=
X-Proofpoint-GUID: WeMGcmfuna4icqmawbmW7gJYEsbnYicH
X-Authority-Analysis: v=2.4 cv=Aol7T+9P c=1 sm=1 tr=0 ts=6b0496d5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=jAy75CqWmSRsgNc4pWAA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230078

On 26-11-20 19:11:43, Bibek Kumar Patro wrote:
> On SM8450 the Adreno SMMU GPU TCU is a separate hardware block with a
> dedicated alm_gpu_tcu master port on GEM_NOC. Without an explicit
> interconnect bandwidth vote, the GEM_NOC path to DDR can be left
> unvoted during sleep/wakeup transitions, causing intermittent SMMU
> register access failures.
> 
> Add the required interconnect to ensure reliable register access.
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
