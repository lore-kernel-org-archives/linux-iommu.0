Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795462881;
	b=z0fLEJW2h1Zpp+dK02FnRnB5BA7uuWIZ8guvENLiDXldDf3hUEVKVw5WkFxGmHDqVtNP
	 1YL4Uc27dONVdIEPijoLBsNa9aT+cgbGX4wAEhMNClT4vNfXgEUhwnFC+NIdG/EHobaT3
	 E+aR1EyBt1S/x8MxTa0Ra4ooiiFZEjVzfFJ9QpTf6OQsBFls8GxrIEX9TCmbX45O1C8yH
	 kGiE0a3hs9Gf9eZ5imMUEW3Il5hQJSiUPcNGLkRSN24ijpxB0LcFnM+HpitjH+o9r3sk7
	 6NmbFRCipdQz2s6NCL1lHXvpUY77GZfHsWjn1HQg41kj4sC7x3kETyiDBDxsT9mLNmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795462881;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=vUxC6ouspxhWBpss9anyN8/bpVZ3ii1paTC8Jy1Fd2E=;
	b=oD8frd12+llHl/Q/z/LjRxmo9Mjzkwhg1KGy7Eyyjwxo0+hAsEiPfKrabTLfQq7nBxk0
	 gOj1hb6ZZO2LQUueotRWjoREERo2Rdp78dxaTRC8T5giIWBVClQak2ebVUBUSDN+1alSG
	 8/JVXVLZmUxrVp9XNSbI8Bp09U5AoNuTHj8FQpiZOu43GGFofkUl5XqlZkgdhupJFmuSb
	 fiFvjoi7TWSYCBMrBBEdA2ShNd1mmOen5vfCsvXynhZTOo+AJuDl6lEwnPzxOF+yhtglz
	 Dv+ZRzohhPD/uV4O8GUKPfOOSM4uD2zLU98grpM+z46Pz660HCDFpq3Z+lldX8GS0bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gwmsFTUb;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GuiG6Ux4;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CF9606A31E
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75CF9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gwmsFTUb;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GuiG6Ux4
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANGH1TR2769438
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:41:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vUxC6ouspxhWBpss9anyN8/b
	pVZ3ii1paTC8Jy1Fd2E=; b=gwmsFTUb59Zlc/gg1IMdg77AcKGA2SPYuhe1s2Nl
	e00LRSFZUHuu92szoKHByqwXiKxGIB4AQNljm3o49yyhK8/9ImAeHMGZcLVvkmiM
	ti6br/HGCe5iVbeQ7ldCmOhUUxf6v/MZlWhkgSRGoOlB5hYQFQisbuj2GVIZvjxS
	C4HaAFhERQAAYk2ktkBBn2itn2sydqBOzcNvDrN/t0X3n0EzYiesLa3uVmxIiN7o
	XjaNwU8jKPfBwO1DMbNj5DZ4PzBDla/MFvne+J/fZyYgUHEvqbT0NQ7NoE++VACe
	I2GHZuAK+4p4lNdv90dhhaBhJ5FnFinUWCFrJtnKJ+9VNw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g1pb46s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:41:20 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9495af07676so574894285a.2
        for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 11:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795462880; x=1796067680; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vUxC6ouspxhWBpss9anyN8/bpVZ3ii1paTC8Jy1Fd2E=;
        b=GuiG6Ux4br5z6Wm8kkkprIg9l+i3S+WRDc+KHTRnALNZ6mSo8rBtIn6N6gvjnXE6nU
         QhzVncaVOy+RQLIhtGGdLHWQ1AT19fE0Hmr1yZS2XYmGveMBBclpFM9V6BfLdNbQSFlE
         gyk1gv45q7gxm3bEu0iw6S33XeIhk0wZqUo6qeorxIzxDSq4ANkIMtfg5lWFLUPwTDLS
         bzdWt2EljLFkIbVa/dgCMaQ7111QMyHKn5EkViNm6WWt1x6wcMNjrDODtWd2KQCer5YT
         B0bRT/RSbPZErbbTpdlNblCTCdTRIFwBUM3e9QL1tpp8z49ocL1tfkFb7Km7Ksy0i1Us
         9UOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795462880; x=1796067680;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vUxC6ouspxhWBpss9anyN8/bpVZ3ii1paTC8Jy1Fd2E=;
        b=soBZB8YF305zRmsR+eHdbfPGvll1He7O8MRHDPwA+GWvcIq9if6H8DD6ikv73g+5CO
         MtyxYGqowPDoIDRWkjYnMv6/kd2VdxaW8P05dX18qaQc1E79z0a/ksNwgEuFAoj1fKxZ
         tZfm2573+dSVyBQfE66zWxaqXXbA9kDLgyEB3qFQg4f0JZ3Num+lDAuNxb3hafWxUAUL
         DIhC3V19HDQvkWv4h6jk9CCypSsxJkdcV4AMro8RSqA+uiXXYSP1EQoMebqKMfKlwjA+
         qTEZOqB6+aGR4qLiAAkP+uniH4krRu9uvbkloursKNSpxdxtEShks+iIjcdKb1w2FzKd
         RE/A==
X-Forwarded-Encrypted: i=1; AL+hErFQ+rOmuRaoLLUPs2FuhqGuDAW2hNiiBh1uWyhFdRGs3XsIGGevi+dxQpaQ8HIEVHICz95aHQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9P70df0Jj3I4VNMxeln3sOKSyKmqxzxaeBr4Bn0ln8VVc7DJFM
	G0nn6+UnGC9BzVS1PZ5W+oVRBZnXZ4z2ltPzIILVakpy9LPmRNgdfZc1yJNliAT8z5KISM3DtpW
	OqwxI/olv1Lj885JG+xm3EJCxExcQ0eEQ4nQXf3QF/CLgcvEGeOnoZ0EAMw==
X-Gm-Gg: AZFdTZdqlLNF2/HYngymXIFlRqGlFIkiAAyJ4+xr7UEPIwViBp4c9NgVtP5dQ1HL6zV
	M8Y6Lz6Jo2HeNXrccULN66fbQa6KpoV1V3Z6ywfwP5H+AHE6vGz88utuxFCA8I87v9QEEt3Ep6h
	K3CZUjKu6oGQlabjebN2pRPvRu7Do6Y0sN5aMfazmOMcBsJWcmoKvDHJSjgapdMx5bsbRFzci5u
	6S4vd5hXAxaGj4LYkHcBNhIfCeY55xV1K47IKt4STfBOu3AVAgD1wE9EiAQfOfVpMVgkqRP9QCk
	ZFhmgEZTXP11IayD8+DCqxhfa2/4IvsCQxwgUxckkwUQt17NtqT+yJD+/4unJWCWsIyNAjvCXJF
	fUt1mbOmkIwf1b3W23csJbVmNeXPeVdJYsExXYXyBTx5Owdfr/EIY0krX5YBvjxPW
X-Received: by 2002:a05:620a:3914:b0:949:7acd:3c43 with SMTP id af79cd13be357-949ba7cbbf8mr1832794085a.3.1795462879638;
        Mon, 23 Nov 2026 11:41:19 -0800 (PST)
X-Received: by 2002:a05:620a:3914:b0:949:7acd:3c43 with SMTP id af79cd13be357-949ba7cbbf8mr1832790585a.3.1795462879048;
        Mon, 23 Nov 2026 11:41:19 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf685asm23327384f8f.20.2026.11.23.11.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 11:41:18 -0800 (PST)
Date: Mon, 23 Nov 2026 21:41:16 +0200
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
Subject: Re: [PATCH RESEND v4 13/20] arm64: dts: qcom: sm8550: Add GEM_NOC
 interconnect for adreno SMMU
Message-ID: <ytqrakhhpmy6zdsdpqglpkm657ymg35xuhnmukifcwzowdokqg@2c3dewjxefcm>
References: <20261120-smmu_interconnect_addition-v4-0-be30526391d9@oss.qualcomm.com>
 <20261120-smmu_interconnect_addition-v4-13-be30526391d9@oss.qualcomm.com>
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
In-Reply-To: <20261120-smmu_interconnect_addition-v4-13-be30526391d9@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfX0IMLD7FbY9f/
 CZZ6Td24vGwgFxZH7pnZVjPKvoPA1vqneYZRU0twU85prq/in1ymgE7obZpz+1xq+0FqO56kv+o
 ATk0KW80sTHQjTqZx+xrk36QLAR1ktx/BsKcXc6qvWAnDCgXAAmvZTb3/cQjgZk990RoBBNyCmB
 iyft1ytqzkSR6+0qMtNwutZosQRIfqjvv5QyxpY5RhhhLiiPlrv+aWM5YVA/sQ266HGePdWDwb2
 zUq4sutegrFv7f5fW29zQh9YGMmr3HlP/vkPnTbAfRxz6qP39gGiFv2go79UUtYiuvme5BJstm4
 Pdfk/3nmejBzcP+U+gFUNcTPstIcxSHwROsnNbLoWbXXXrmts1WvHFcLMec76PM5oJBPnRFgxSS
 8h3SeUFi2xZA8tZPOSRgdC24jqJazX/SB5UR4RG8wKTwjnHy+cKhVGzyYPn/bbNK6svlVgM7Ast
 REjnxAnpX4IiNh9XW0w==
X-Authority-Analysis: v=2.4 cv=AeIkjHXG c=1 sm=1 tr=0 ts=6b0496e0 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=jAy75CqWmSRsgNc4pWAA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: wKY6mmIWBFgSAZN7a5ypuEc6hs9GWdyz
X-Proofpoint-ORIG-GUID: wKY6mmIWBFgSAZN7a5ypuEc6hs9GWdyz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfXwG32HJHCT/3p
 NHMTFveb5mBBzISoiMjW3rWaLUGkjkSsMM6/SWBpRHHi3s6744W6EVAMxvjAvo79tbYBqB02mg5
 SVQNHHkBSAjUQzLiIy3Cto/ZnLjMcZI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230078

On 26-11-20 19:11:44, Bibek Kumar Patro wrote:
> On SM8550 the Adreno SMMU GPU TCU is a separate hardware block with a
> dedicated alm_gpu_tcu master port on GEM_NOC. Without an explicit
> interconnect bandwidth vote, the GEM_NOC path to DDR can be left
> unvoted during sleep/wakeup transitions, causing intermittent SMMU
> register access failures.
> 
> Add the required interconnect to ensure reliable register access.
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
