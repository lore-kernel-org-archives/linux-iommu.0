Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795462896;
	b=KI8S2sp9wjAHwF2sXeT2GTefg01/j4gM0PL1INDa5aNPjQKJinTWYKMaS8CeueQTImRH
	 jdJNoemqvlEBR5Glq1SmTkKUhjWbF/rreMrr92t7tqEcIuxEEPE+RoHPIeTRU5GRRQPyZ
	 dUzsIW8TEitI5Pbqy7NsxyaV32sYxkujDKWFYsDOjqEwHYfLwBY5ukkfkFkhXem3AAD+p
	 YvYnviWrqgbxc2UTTYSvQEQaJ9uIYOV2AOyvYjIjP4yeKpJzNJU21gehVofz6ueB229Nv
	 SyjCYusRZZHn6xHHsu0HpoUv/x+51PMGygpa/takuPs0gtZ5osgKAysxT6B5O2aicyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795462896;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=iWoAxW0ABYsS0zE9hrZD0wqatrqG4QOz/0q/ZQLBBik=;
	b=RTpmepDPYogVxQg/uBbLOaUmHneLT7emINSMoRQAhXAybP4e7VD/kiTugJLTHgt2LxO3
	 L5u1+jP7q2/gNnTP+b4RwCWkEPKpd7t2Zkq4LRloc5H2S23g35N0EVbGsWJ5UeQqgR6/M
	 g/HHaM87iExav5YQDz64ZjvJRv+4gliGClLa9/nRaEy+R9RQjdIeUnscqW5Q6toDRyjyt
	 otS7TvK66ci6yCDBHmD59Re4chTg9G2yzWeq89sL34BQkdW9xid102J8oZNcRGQpo4tjF
	 Qe+fUcSm89jHw5/+O+Kqk62k/0LDMgzYrvklccPM5gEaI1cTmVxxqsGzYNnpl3pPXqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="jWmHI/tX";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PNf+u+od;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE81606A321
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAE81606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jWmHI/tX;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PNf+u+od
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANGH2pD3475192
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:41:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=iWoAxW0ABYsS0zE9hrZD0wqa
	trqG4QOz/0q/ZQLBBik=; b=jWmHI/tXXYpGKgSop4Rgj1A2WikJEh7R2Zxyde6T
	0t9hhhftHUgi+qC6ulIhceR7XS6XkcMFifkOgZCVCu4jylzs74pybTY6K911PAXm
	k2DqlshdqwQZ8xoA3Wsra6zHhFZ6HExXgaCIKf7k84P7K0MWtU6R+NaTllVBPIhe
	aaDqmnwc1NV7AE5jzRv8/JKKRi3T61wBO9/pFDpJsmPZzPFN6EYJKqFnpSHaVF6/
	AU5FigJDqdkjY6NR6P+5NP9q6VjJHXSRiFcEvH7UEcyM54/sOkoiE5vdxO8amup/
	1H9Y8ANMNaZVklcQ4Ik6ReDEaSYt8Xhr8dsLsOYKsHdPbw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4hn7ttjd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:41:34 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-949b0d322fbso534616185a.3
        for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 11:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795462894; x=1796067694; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iWoAxW0ABYsS0zE9hrZD0wqatrqG4QOz/0q/ZQLBBik=;
        b=PNf+u+odEcaO7yS/28xmIj86V/q8ZSUXc2ea+0ECALKnWXHJP9Mty/o++uzKYAns9u
         7amza+WfbBzNQgU/jmW1+B4jQyMW/NSBfnUdUM5FImUY73b5CjXUcTkPBaytzj+UIkrZ
         MbKwnaEBlmxrfbvJJuy5eDkFAg2usraFS0w2I3AbxdCWhhAVr+NP0FBdOJINlYriANWn
         PsGHOITP4bNQnwsaToGba/gqXz/DnH78jSX4+sSrcMQAGSa7lyMhfnHVvp6P9ajzsvVn
         X4/HLLK6PBnj1aLUvuli8GdGbhEnNavKTTwLQnf4p94xV274ju9c2ZVsGLq3jX4LfF9q
         Bgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795462894; x=1796067694;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iWoAxW0ABYsS0zE9hrZD0wqatrqG4QOz/0q/ZQLBBik=;
        b=uK+5uzTyier6p/I3r1/WWT63yKISp1r7yAC8c8Jp9wz501zNaHqGvS/oYWCWA+r1sD
         WUgdy5lZF6Bkw4P4gGIyTGJIWAwnFwIiE7NZKAPZ0myCtxm8YgrsX5xyiyzvWAJnQPMW
         M6r47ocOvv8iHcVWgCRvd3pn/KChMGF+Ya7nbXilq9dhYXVxuoWZVcdyTHU9PWlHv1BT
         sgPvLDoBkiOazyftf12ODye1LsJv38nsKpx3sPbo8Dg+LeptCNT6yR7jPcOlFpyHfvjR
         GvthY+6sA024oEJ1opusGFYuLuiWhduZaczAjRwT2g+ixbXfo0zZYAB9+LDZ1+Z+xqtm
         t4Sg==
X-Forwarded-Encrypted: i=1; AL+hErGDmiSihVip5VqA2VtoU4wvstPSE7N8+YiRYMtwgCrNd/zG0AhxgUNvapnf6pBN3kMy0d/Nng==@lists.linux.dev
X-Gm-Message-State: APuU4Z/+wnYXWiken6fVkPqAZighi5CL1UnurtyyJ8cCmCwZ6JQi8Ku/
	aNdmg5DhkTjTQ2baT4VZQhng34/2DQX/XPchflIyh5EOWZ0f75/xDGlsMRARjxeYvxegdw/3xyr
	/0BbhKm2illP/Fp888eM1JFJRmzTj0JaaC63g2GtZKBBmuwxKg0xcjUNDVw==
X-Gm-Gg: AZFdTZf/IjfTps1eFIHMjZUdJik39InEJEbQRlojZs7DZG3GyhSPbB3e7w/uUH1lMvN
	BPlMy5voMBLXHdVk33jxu9kyBH0JvOkGktLfEGUMdZXdz3Id3H/e2pAtv5Ve0X24ugXfhv7quYZ
	euvOSfm409GHiI5GXgqBc8pQ706Yv92cmjPqUBRmhpmdR3juiZqiKTY1JBkhHiFKv5PbyIv/xD3
	ZtZxzG+F6Mc8blrUv33E8XF0NyEV9EdN4gONHBXBCgXir3NxQCpJ4ZKFR0pEYqXcGS4xgfdfE3v
	FWIs8IOMc6DFp02Hdf9Tr+IS4+Eo/6zTfc78KYAgQOi/WCVNVjSsSEwOIOmtNBTEox65MrbNE2H
	K366A51VEczKFPv4vx9qUDaZhIAJrbYc6ZcW9/wCHxsCWFfFlwjL7uD2MDn+vMGJ5
X-Received: by 2002:a05:620a:6f0d:b0:939:6dea:374d with SMTP id af79cd13be357-949ba9d1fa6mr2093265485a.49.1795462894013;
        Mon, 23 Nov 2026 11:41:34 -0800 (PST)
X-Received: by 2002:a05:620a:6f0d:b0:939:6dea:374d with SMTP id af79cd13be357-949ba9d1fa6mr2093260485a.49.1795462893448;
        Mon, 23 Nov 2026 11:41:33 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67f1b2sm22227959f8f.25.2026.11.23.11.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 11:41:32 -0800 (PST)
Date: Mon, 23 Nov 2026 21:41:30 +0200
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
Subject: Re: [PATCH RESEND v4 14/20] arm64: dts: qcom: sm8650: Add GEM_NOC
 interconnect for adreno SMMU
Message-ID: <tll35ljrujo7sgz6fesshor7idu7ujoyhh76crbe6xajc2sar3@6uvambereae7>
References: <20261120-smmu_interconnect_addition-v4-0-be30526391d9@oss.qualcomm.com>
 <20261120-smmu_interconnect_addition-v4-14-be30526391d9@oss.qualcomm.com>
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
In-Reply-To: <20261120-smmu_interconnect_addition-v4-14-be30526391d9@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Ls0HWXdc c=1 sm=1 tr=0 ts=6b0496ee cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=mDVvi5Pd1DWatKlo6wUA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfX8AmsdOqrtoGI
 /HxJbuBq5JYQdsHWa9vJMbSgy7RaGsMGSBsMsJ5q0BcA3j4ygliojJtrF6rjOgBtcaS4fnIrujk
 TrmnN5Sip5tVKsiL1YCszHuazAacmwZUi4NRpGB8am4Ud4mVdpmwLpnGZNbdHs4pLxH/xWYgl1e
 IduD1K1OeEJwHDRgIvNzpSW5Wscmo5DvaQwSH6Z2AyILbnASJUAN2VOQ11BwzlTch2HI7gmGshc
 ZbXjIPUyosVqPt4qJLELnvbWIfgEpjEKkrmmFUMnlpnLQwJSTgXiOp+7BIo5sIj/4jOGh/YPhaK
 U/QNNNcA1d93GDY7nZGLzw69Vzg9Fg5lllwAcGcRe0XxdSJ8uNT/nPJY7p5If7ouNHc1f9hS78a
 vcYdeN34X0SioHeMdkhN+WHZZa2wlWX+1Hcu8OG1HUTxfWLVpSihQ/oGp1q83cx/q7dLpJlVTTE
 heakJRkYxnzyl+OpCLw==
X-Proofpoint-GUID: Owf12FHU_AK5-IKSqnw6wUspkeoQQ1vT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfXwGV1M/QZ9VEa
 I57gm8n41zKUl36i2dtqTn1Kz19rdBUx7nTETaCryHLuWyLBT4PlaDQflcCnFGSpld5y4bsR5I6
 8nxYdS71Ad70RU805kUqcu0dMs7LSUc=
X-Proofpoint-ORIG-GUID: Owf12FHU_AK5-IKSqnw6wUspkeoQQ1vT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230078

On 26-11-20 19:11:45, Bibek Kumar Patro wrote:
> On SM8650 the Adreno SMMU GPU TCU is a separate hardware block with a
> dedicated alm_gpu_tcu master port on GEM_NOC. Without an explicit
> interconnect bandwidth vote, the GEM_NOC path to DDR can be left
> unvoted during sleep/wakeup transitions, causing intermittent SMMU
> register access failures.
> 
> Add the required interconnect to ensure reliable register access.
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
