Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795463036;
	b=DWNiqZYaBRVg+TlVsMGtFV0+TG7yodDII7vxWJXcYSsc3mc352hZX3ck1CN+WHwBIII6
	 qcDOgeHh/wMH2zStfu4kuMVd9iSc/W944ctICtF+FZ9Q3wG1V/dr7aG6IvZ43jCqPSvtg
	 dGtRdm4leB2tMlKE3mpiIJodhejWxXK2iZp+sOC39iNCDY5c+LrbqyZiJIkLr5vmWm8t4
	 ID+HiHrIqvJ8/Lf7Dy+CltaBVKDg/xuNefAcN4kH4reCqjWt7zvGaYOI5xSYEHKNwNyiI
	 ck1tktUga3RMVByWFuCiLVa4/gj5Hat5xFFmiEo4c2HYrkUJIsjinBsHuFuG+W+3J+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795463036;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=fcrUVABBd5BeMh3yq/6enDr0xTKRX2RD7vMv5/wMSTg=;
	b=xZ64yeoa8W46Wd+RPLNDSKJ6K892kEK5juouzziqhCZq5auv7JqWCB02PcSZ6AnEulg2
	 QPlUzFc8JdEW1wQGF/5Don12actzrq1SXnX2gLSyZTBIAElPxnR5cMtaNHMFP6RSWR8/D
	 I4Hh32hXLBy/6JDdvKHAGPGKIIX+fRBQj6pysveAbcr0fBqZ12QG2nxK5cLpNArjUgLiw
	 rJeCtKtkKsgLfwrvSdE1FHlS0TcNuH8IrdgDtM7duA77L25tPtDhZyCtA9eEmhGgAezE7
	 8VRKjXOxPopg/6DQOoPWxdcBHzF56q6sHHx1qVcwHTr9SI+M5MDfYUzrZsXaGiBy7Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jlR2J6Ge;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IdoAnvTm;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68278606A321
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68278606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jlR2J6Ge;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IdoAnvTm
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANJNEPw647026
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fcrUVABBd5BeMh3yq/6enDr0
	xTKRX2RD7vMv5/wMSTg=; b=jlR2J6GeUOvDnOTPhh3wO8ea+tdICFP0OpQ2btOC
	O5un9FGL2kd6S+hOypQb7vGG18+TcYQvUp5jr03s57D2m47fW/1Q6hYTr14jEcAF
	Gj6Rh9x3xtTdw2PteX7tjHkeWGXAPZHW+Dw4NexuvA9hhYmO5033Kwdq2KVL+K2u
	Ns6ja+cE08Q9ygOHZ74KsGKHFtVYNxvwHbjtIgcZOmeQBXK23gNCajT18NHaeHY9
	f3ZpkRiJf4RTGA6IDuWEPG3Jt1MQIK6AVBjnQG3uyYvwHSn15O/O2rGFrIx9LRTd
	SLfth1XV7FJADTB6bqovH0S3yNW79HiHeOl+oAf5OCC4iA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4ukqg2h7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:43:55 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f33438950so657797585a.1
        for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 11:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795463034; x=1796067834; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fcrUVABBd5BeMh3yq/6enDr0xTKRX2RD7vMv5/wMSTg=;
        b=IdoAnvTmmdNDMdw0Z5g7HP7sn9YNGZif11bHU5jdGSFDQe3y34s/e2bNbpPmBqWmjD
         VkV2W5pem9KW34bvY5hjXfzdIpefk60l/KrNPPKKJd50XOdJZ2fJ6OSJVFzE7MCSMwHa
         wpKp6WCJTkyz5hsqVpoJbNewEe9zyxbRc9iqMPOAbvwUMSRK1OSE34XjA3VVCq+328N8
         oJpBtD113bSs1vGFH14WIBDtoFGCoDgP7KUcYcoT9+LRzE9CP6oWw4JvqZ3MHOb4VP+S
         Bxpf+kYSuXVV5++tiyd+Mg4HETvM6yLMKx/mMf7rLresiHMRdyAvaOUjq6LwjilJ2TA6
         btaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795463034; x=1796067834;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fcrUVABBd5BeMh3yq/6enDr0xTKRX2RD7vMv5/wMSTg=;
        b=udr7j+J/cMVvuSPco95CLjIYMiNmFo7TUV2tP7I5shsmqAf9+p6nI6GGbMAmmqz022
         IB0o8rH2oSEBM5VQoj9Dq+HqKZwcZN3EVAa78nyPO/Nb7oKNUSVvpLRKpKSJmgC3N3bp
         m7sp7zr6ZlQI4Ssyv1jt0T/nQNxiZMEHcNpyMHUK8SeeFUwl1nzi1bjHo1mNjPiVk+bS
         YlQrt+DweT31z50l82Wto/JG+anuQzvhwDBZJ4sOdwOxGHLdF7dvNCQ6+lRy6ZMPfo/o
         yK847LKv2TGfYJbXaIr/wF6IH9N9Bcd3mmM1pNOvIpWzARDbusVF8QqYVXii3O+QWhcY
         vT0A==
X-Forwarded-Encrypted: i=1; AL+hErGrVL21X8qNbmmGCbvT7UgM3o8UnOzKJedO+Fn8UxIFF1H/0QwYOsBGAnXgN9Xv7b/80nGG8A==@lists.linux.dev
X-Gm-Message-State: APuU4Z9l6fPK82iCGMG/XgmG65yKOEHiu+tYvKprZwH0a8ib0z944MXd
	MUb1t3/4t7HGO8TDIU2EuSqQD9ezzZ1/rc9ySV97AJlnQcRhNumjDecDv+4fEnckFxsE11ybKA5
	15baa2sH/1gqL4wxu7NCrU0YmUkyENAX9gC3Pgn0+GQfmErKVnBMVLbuhyQ==
X-Gm-Gg: AZFdTZdCK3W6CWPncHkOYe+CmA8lN0lHC0V9e5vFLv4OvV2q63EZx9U45PNo8CjyUAP
	vmlG0v6R9TfwcIjwoyP1jyC7F/PcCQGWld8JbX1IBq7N1RxGHW7aofvbwvAdq9HBJi/yzE4u5hE
	CqCyn18mrDhSUR6E8lh7fDkyHikrwQiTGwlMLsMCOWpFTHsUFATSdU5yuNuhL0ULEnVkoWdKrji
	Ju0GZinSePKUd9i9oBEtsQC0o7EGQYucQeu7m003CG6NuPH+0VIwIlO226SuuHxLSlc1hZyw5Vl
	4ovHcBJfoqcqTqfh2TNm3StngJTevRWMWmOWRvkqDGza8wCzEcv3HB/zjDbJofnz31i6eNysnL8
	x8K5N6vxe6YlEyKw5EJLT1QJOsisstm/dTmCC6knPqmPMLa8Q4YYpJ1QCIQZZQAr7
X-Received: by 2002:a05:620a:8396:b0:944:192:85ef with SMTP id af79cd13be357-949ba95dfc3mr2013018685a.22.1795463034443;
        Mon, 23 Nov 2026 11:43:54 -0800 (PST)
X-Received: by 2002:a05:620a:8396:b0:944:192:85ef with SMTP id af79cd13be357-949ba95dfc3mr2013012885a.22.1795463033726;
        Mon, 23 Nov 2026 11:43:53 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf685asm23340306f8f.20.2026.11.23.11.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 11:43:53 -0800 (PST)
Date: Mon, 23 Nov 2026 21:43:51 +0200
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
Subject: Re: [PATCH RESEND v4 19/20] arm64: dts: qcom: hawi: Add GEM_NOC
 interconnect for adreno SMMU
Message-ID: <6yjftfrc3e5xsxqpzpab53x745utqey7ivz3hws3l34qmlxdho@jbcmzbhdq4aj>
References: <20261120-smmu_interconnect_addition-v4-0-be30526391d9@oss.qualcomm.com>
 <20261120-smmu_interconnect_addition-v4-19-be30526391d9@oss.qualcomm.com>
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
In-Reply-To: <20261120-smmu_interconnect_addition-v4-19-be30526391d9@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Wu++otfv c=1 sm=1 tr=0 ts=6b04977b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=jAy75CqWmSRsgNc4pWAA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfXyA357+smO8IO
 VqrCzuAAxr8Ac4Lh/YhqGKcf7EVUaEfuaC+LP3E17ZUWemAabRGZ5ggP9/ce3z5Po0S2wAmDlQH
 d6vYxADU57JwX1Z5D23xnv6WorcVpiri3dhlY+v6gb986vKUVxV7BhZUfNIdiw4HI4U5exdQjQB
 LzEr8Y5Huviyu3O/xA5+1oXDnxGwVn8sAun0qK3vwBXzKmiAq0m3jlEhG9pFu0I5wB2L0zYqKTB
 BtFNQmlwCJ/nL6GTkU3Wa8YcDjE5vTJgl4RsQekrHBaK30sXAUqubugm/NK4o28Eib/AKfDW4Vu
 WKyzknWIgJm8tXQVHAnLm2yXeGs+9+x+MDSx2ML6U/a9iYQZUUcMJ7uHtW5z98T4YygEO5qnl/m
 DDgyE6cWykztO9q34TZeChH4xFtSU2t3RUJKXs7O0rPetKOMrqUAq6OrVK2z6ZsWEVNjUMcgZh+
 7ZbtETp+rsEC2ZcXX2g==
X-Proofpoint-GUID: E80XhSvPuxzeUO2y5MTP33zKcoYkLRZj
X-Proofpoint-ORIG-GUID: E80XhSvPuxzeUO2y5MTP33zKcoYkLRZj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfXyq+gTk/Cyivk
 L0CZAM12j+3XukyHrfgntPP9M1g7DuU1CVTy6ePQLBPCb1CYE1zSYlbDFQGO+nyjjH2TE7do8cO
 0afP1uYwtTWC6Szk9/gSnVwahuyg+yQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230078

On 26-11-20 19:11:50, Bibek Kumar Patro wrote:
> On Hawi the Adreno SMMU GPU TCU is a separate hardware block with a
> dedicated alm_gpu_tcu master port on GEM_NOC. Without an explicit
> interconnect bandwidth vote, the GEM_NOC path to DDR can be left
> unvoted during sleep/wakeup transitions, causing intermittent SMMU
> register access failures.
> 
> Add the required interconnect to ensure reliable register access.
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

BTW, can you please check Eliza SoC as well?

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
