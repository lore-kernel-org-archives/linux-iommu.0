Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795462785;
	b=FppG8EG7cJfASU4ZrDcjxliNn7W+aPgnXZE83CZSiTAT0UiugyAOGWF0dE5CEz/WAC95
	 h2CbpvXEVdyyGpZTT6tTs4Yh/PVMD2IkTyYoUpnvd9aIBY5Pqcx3FiUSrwI4jRNmiJPJG
	 1Yj3os9WP0BCUcBD7zhJEJSbRmjk5e/bwqV6NIYDJXAGmBCupCDoG1UPuv+aEdWylTKre
	 1jru8HVJPY6QSQLMxdGj9vwFoI+4xGvCaDgOarxb8sUFEf4FqL2d6x9arBYf1tIClcNqC
	 3otPQmMp0dsagNL04gP7R2guDPM+B62qW4wieB5G9T7lHtmz3MhsrC6v07FRqTP7fXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795462785;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=/AsDNaCeIM26uy2qCHuktfXaKod4efoeozdBzuVQOi8=;
	b=QozsGuUfCkHEiFb9Xquxof28ouHdUh9S5BUPXc3OTkGgDK1KuykaUQ7zxY/3zeHkYt7l
	 Nkklw388WtlZBsM+fzHkWUu4pP6l0+FRIftYKp8+3gp+FgdC1S666/SnK7LoFDRvEfgv4
	 oCi0PGnfOeq6h4V8gTu3zPKAEaM/bGVJ/7NTPXeBF2SVfZFXhwRLbHFklXiWucdyhui04
	 xFeHcswv0citzgZ6oGhqSv272FhOk6qf4uVLFpfujgoLoeiPpwsOJsufwgtdN3oJwiv3N
	 5JAOZeq6gL9ObIeKh3V31lt1am9ZT4CRShULfS+lN4FJFSoJKX95fgMa5ylrR2KIYmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dCy04Ggb;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UM0rACdf;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E53606A31F
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1E53606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dCy04Ggb;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UM0rACdf
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANGH6Gx1093937
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:39:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/AsDNaCeIM26uy2qCHuktfXa
	Kod4efoeozdBzuVQOi8=; b=dCy04GgbJinPkzPCZYLQfsGaaerS4ZPo0o+h7QxU
	Y+cCSOzW9p8JUeiaSEkcfHdy8Vec/bNGlEOzsBhXarz5q0uXV8sjetqj0MUXVLRf
	CpFPwIVs3D9xjiDK5GX/8C0az5rsW5YjOLQdBrk0De6+GomJ7bqjlgEwTCEstDpq
	EcDYufpvAd0jwa6rWIJjnwJCcIttAtSDoTB1xaCvtXi67ULdBSZ74Kpyo1FeP6pR
	3J9uq+XSeZkYIhafRuPMBP01XPN4DQBjKBdHxyrKZVw6nn1zX7zQFSNueJLoTOP0
	BYB3oZ5uqtUVuKWJw63dPIqMoHFG4GFSC4TC6dNgGzgpBw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4ma0t2jd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:39:43 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-949b0d322fbso534336185a.3
        for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 11:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795462783; x=1796067583; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/AsDNaCeIM26uy2qCHuktfXaKod4efoeozdBzuVQOi8=;
        b=UM0rACdf1vSOBt97mdAnfPkneWGTuhWDJXtDc+n9w3Bmr+AXZCG/p+O220irH395lG
         FQ3ZZkar4E3YO2kHZpxwhKSQ3X+bxfoYfiELkgcg960EwcGM7DlhO9RsNuEH01eVT9Q5
         GogM9jnFr5644vnsAN6vdZRRCVjMxP38AsCImkpDvZGdhzwFeio8/Gr8yDUsy1wfLEdZ
         lRztLvZ1NoQVfcCoJwjYWO/cGzajA+E5kyrXX1beuuSPCnrLTrJCsGl+BqyhkzluLlwj
         1L57Lw9dhHziAcq6hx8Rkokga8pMPlkoQrQ6nLRt6WJb4DOeTB0dp4nzHDCJaTILmcWB
         b2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795462783; x=1796067583;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/AsDNaCeIM26uy2qCHuktfXaKod4efoeozdBzuVQOi8=;
        b=CjLXS94dt2CYpJ6r0zol7Ooud7V877VWXwd078o5NMXkbUmPJUzybuouLW4ifrPrIM
         lXr0iOJ31vaxO6zTAsGVHlH39Hcw5qVrt336zX8Ni/jpXczyXBaHpO2CDmD59NnWBLKf
         K3UkLjrw796Acvdbrn/I03BOvp+uQkM7sf/TibFFrMHIaDlN9LtLYmlsq6Agto6ZVa2y
         lEzRk0JGOZvO8L3AQTgz88kZUU+sjV+jw5ZQT/tWpRg2CFthqjduRv91n6dn0xES6+Dx
         VhAYokvWSAJrFYCS41Zg8kcqUCqp5UFh0QDHYG8hsJXNsUZEQ/hEjUmoA8T7e+vXz9rl
         FNOQ==
X-Forwarded-Encrypted: i=1; AL+hErG1TmvSIMijD8yTA2/sn2KboMbWydG08Kt+bH3IbNvPJ/bV5omuOKRSc0si5p+q66kLi7AXCw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/psK6JLwvDFmEu/FDfcmX/L/kmVJ12dN23fReBaAOX6HzezPsI
	hDzFpllCUPnHxscr0ZsCikLZllr4dTStjNK1HRuQ9svACUXyYD3xZL8LPZ1bq7nfXNdLCRQenp+
	qPYcp8a7vpHeLhTxI+XBFCg0OhutWU5UUTt7G7rh50ETYPVAM9Y4/kQ7ObA==
X-Gm-Gg: AZFdTZcbTYknNIeUB5IsLV94qjpaB2fLPFsN2Lb4e74EMcwkYM9/Vsf94Hx1tF90wms
	2Dow72JV5Wt3TpWaqyNeLzHZwgGZz+VbrbBlFDhSuaQSTZBPkEGchtDicR76hbHNHAUrpZQaliT
	h9xI2mmP/UVTmZlZIcuGUEp9Omdrr6diMV08d9bAgiFO6LDkZgPDQwzPaOoDdpqoTuaLMejZByX
	q7fYl94zy6510c44pALFV2mms5xTTipSYPK4iZGlIS+SxaVEfovE2prj4X0V5GNTOTpnCDpFaz9
	jrQtKPzojbwvdLxS+xR/576GGRe7+Pb6WFTQMt7wjXJsAajQF3VJfubZoB5RIONJfb7pnTuvSdX
	LWZnKNGQR3LntJ+U4muqvke7X+dSVQ2dGDQxEvNGEuGOAK/QlLqtdEm+8NnQFrBgl
X-Received: by 2002:a05:620a:1724:b0:949:71fa:5b0f with SMTP id af79cd13be357-949baa053dbmr2113159185a.61.1795462782798;
        Mon, 23 Nov 2026 11:39:42 -0800 (PST)
X-Received: by 2002:a05:620a:1724:b0:949:71fa:5b0f with SMTP id af79cd13be357-949baa053dbmr2113153285a.61.1795462782173;
        Mon, 23 Nov 2026 11:39:42 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c340df4sm27574990f8f.55.2026.11.23.11.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 11:39:41 -0800 (PST)
Date: Mon, 23 Nov 2026 21:39:40 +0200
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
Subject: Re: [PATCH RESEND v4 07/20] arm64: dts: qcom: sm8150: Add GEM_NOC
 interconnect for adreno SMMU
Message-ID: <itpvl7qrxxa3ccj6e4q5uaveerqcitp4frv4gmtlxj4y4lxv2q@4tk4mzd5ieim>
References: <20261120-smmu_interconnect_addition-v4-0-be30526391d9@oss.qualcomm.com>
 <20261120-smmu_interconnect_addition-v4-7-be30526391d9@oss.qualcomm.com>
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
In-Reply-To: <20261120-smmu_interconnect_addition-v4-7-be30526391d9@oss.qualcomm.com>
X-Proofpoint-GUID: N1EXSN21XPmKYTEZEEbMShIrOltNeKTQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfX5XgGmoY6/qqh
 /YhE0TrL+Uqa+MEWQbx5eQNJtlu2nrxLzJOeN7ttfvTucO8H+YUONGfdt1MjOVRgly5zA1CfiNl
 xALfLQPMg+NHSY4t4XIl+BEAhawWbck=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfXxmg6CE9ul5nH
 yQPS8a5KRqttd+66YudGcctqeS9EbDJOKns6SF3tZO7mq72Q8poeV1gBym7uiUYpELEWh9tmO8k
 9sQqrC3rGKLhIFf/nje8sQ+8JkGdj0L+KQ1IMBnRYpvWq/x4uDaa8QXs/L5YzF/gAsvag6KVRA3
 0hOGPHUyDExR2N4me5Kk2KviWMXd2AkUT5EsON3633Y0fMCVJT7U5W6IOjUWeR2AZ/JwUS/BWzO
 q/h1RTpEPxZA6GB2spF75bMHlrGhRXehT+tY2b84CC4pVLM+PIeF52s7yzqJb1iH8Hng7CO9Fdc
 ucMlCf4ES9RELoAMOzbo3WeNTAFv5zeHU1MUQAsQph5TwQkOYSyCEkYKnUgQwgIMavz1Qd9rmFG
 97pcJOL9T5P68qpxXHQ3MKcuwweYLtkL8dSpt1VNjxRlCHZJFV7oTtWhirb9Knc8z7ZdcirKvgc
 hZAUUOHY4uvIMgA7MaA==
X-Authority-Analysis: v=2.4 cv=Yr+a1IYX c=1 sm=1 tr=0 ts=6b049680 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=fpZYgbz1ZAxLTqytCXoA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: N1EXSN21XPmKYTEZEEbMShIrOltNeKTQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230078

On 26-11-20 19:11:38, Bibek Kumar Patro wrote:
> On SM8150 the Adreno SMMU GPU TCU is a separate hardware block with a
> dedicated alm_gpu_tcu master port on GEM_NOC. Without an explicit
> interconnect bandwidth vote, the GEM_NOC path to DDR can be left
> unvoted during sleep/wakeup transitions, causing intermittent SMMU
> register access failures.
> 
> Add the required interconnect to ensure reliable register access.
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
