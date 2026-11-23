Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795462819;
	b=hMpsC4mZmxAcpXqHk4GnGNmUUgU2kCFfo8JV4QIqDYNcWvJt9I3vvWy2ERdZ0ZR2dFob
	 2/Lok0n94ocKd4Df6NivF/Mshlz5llPhqV/jOz/xgdFpoJP5QjEj/iAm5aGRYfGIupS17
	 68JHtAGEsttzBX3qxs+xKqsRevQAN1MQmr+uOeOrRgJF34KtRFIp0bH3TpWuXfU0P2TSb
	 TuDpc8oe6NSoisKerFwRBKUbniW5e0OFT1FvHULAdoUc/fc0lMhY7fNvBq8d9vPb19MHt
	 SqVD5zxZAtxTTX7hbnu390BIQ8MRhaUcDxcALaYAgO/jsUzQ5OYk/0bwlm9pB1nyD0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795462819;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=gQHF8sxJpg0r9mXjUhBjnOoWS+bWertP7VU7oU3l54M=;
	b=RjssiTpxWfNxv6F3HUZ7txj3oF1kxNPSvbksjeNWd9tJKWgypcJBI8W2wVsW5nwi3cM0
	 IgVBYN5g0cM+KKWmcCL8tywHoZgfEN1wqa8pfrJGzzzYW9z/DDLKXYT5hgMnCceU3iNaC
	 ouBj19ahZf7FzciktBtSyNuvdRZO3vsOFPK0NuG9GwlQWg/VV6VhQlDuiu1/+adL5dBNo
	 3HokeZkTug1rHYn20q3mz1uaKLzKsBOIMWyefNGyd+iVf+YEKvejtDvn/xPY55JHokO71
	 nxZzIAyHmD/OUgfTBLTpUHEJu6Usa4HYAfvyqqBnjUHes8fbJ/CZ0+hWVV0VtPPoNVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FMCyqOPk;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="F/VVS2oD";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6072606A330
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6072606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FMCyqOPk;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F/VVS2oD
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANJNDHH647005
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:40:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=gQHF8sxJpg0r9mXjUhBjnOoW
	S+bWertP7VU7oU3l54M=; b=FMCyqOPkDlj6tsqZjM4E0RAqGGWIbRdO/5LunG3P
	9fW+J0svBtb6tGe0T4vZqDc8Pzf9UpWwPb7x7ZpthN2ksxxnHTdMJATjqCbf813P
	IftAagPQoY+mpj0VrfTDPMQnrfJk5H01S7I40JptHJjtiSBK/zmQC5Uy3/3Wjrgr
	mHAaAXspWIXHJ3EXQWB37e20TLmONF1kZweg9rhR1lrTE3xNK1RmNu5eAvHQX0Il
	h5tcCNfDlPLC0uXMq3pLE2ccqCiQ/LNGmcq02aB58MtfabrlKp791lgDI530WMlo
	zh2svND80S96HZZYj3i2iex+6M5ldQSD/XDbeO4hiZpV6w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4ukqg1xb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:40:17 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-949b0d3232fso539512285a.1
        for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 11:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795462817; x=1796067617; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gQHF8sxJpg0r9mXjUhBjnOoWS+bWertP7VU7oU3l54M=;
        b=F/VVS2oDO84C9X9M9iUlrUZ5y5alcf6S3FuBGjgDx0fza9Yzw9tCjFc4bMrU6C6B7N
         7F63SoshJyWIvCfU5ZDoBBMSGldgtHEOaVXNZ4Gp1T40u8zO5s+yN05fgFXExpVjb3NG
         YeTxnteWrR0ypyS5uzTWtxvGMHJFqBDqV2VBnOk/1BRRr60gm6gnfa4ZKEzOD0PJC2au
         ROWHKg4oWL8mS/RN18WzNUWMUMi0W4QIBQYn3hrmOldVThskQEWz4h1jFcFctyddzwhp
         qBP8vxlGp/R08kHxmenR5TmUBdTUu/iZsnb/b9AgJaRINGng8/X0FhdNmyhsY+Xw+vJc
         bkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795462817; x=1796067617;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gQHF8sxJpg0r9mXjUhBjnOoWS+bWertP7VU7oU3l54M=;
        b=QPM7Esb+Vl0wObZ8BOO0pAi+VPSQ5gD1Y9ZhPX/dqQLbPlJ8fRZa8tGx5HtROhNvgm
         cGXI0o/IOj4PYTWyEF/iAr7h5R8pDKGQyneZl1tGKYFReccav/PMOqcVzgXyJne7fHsn
         VJcFgzIE/87t9vwvVe7WhvBjvhR1lgsTPZ3bnnxBjcyuBmIZwfUGSQIBzI3HMk0Pr6cD
         ZZb1KOyxEiWFIct4timluDlHZgaJ+5KQyNwhliotEUWXhP2Eb8zprvZHTY0HatLEcrxf
         rmoWR5KD2X/AWig75tRaYhPng2pzLM81Yud3TNMjpogcFbSrag3XP57JhmZM49M84k0X
         bbHw==
X-Forwarded-Encrypted: i=1; AL+hErGtXWFGGXym/Nd8kChfC8YhswD+YzPwuDM+0SLMEYjPYE2B+dvfOBeZKIysakIqBsvLUvKG0g==@lists.linux.dev
X-Gm-Message-State: APuU4Z891TfeKMTAjUItQW2Z++q0Etu+mGek0EDrvJKbrT1KTe2DkKtE
	I8uLWvz9f5HqFgDrqBTCWpSIO1NFnz9SxuEsW2DTlb7x8d/uWPsP/exIy/b5l6O/qQcfkK+HyBW
	klMcFWVnWSFVsa96Z/iJEDhsreRG8LFfQCPT7AQ/BbRrEMLEqfu0TCvpjog==
X-Gm-Gg: AZFdTZcc6FYll32RiGSCtkiMgMQd8eOfr4bcwdgyMPLzlDeM/+PgMgexpr+O1Kjhrpv
	ozVcFzss8CpcfpjYG2U8LoPl8AMr0XbpytZy33yYIvXwLvUXClHYQ4vswBiVLpl+aJtFEIVRsnd
	nVDB6HQALPgw7cy1GDHDIFBPo2YcUr7he7L3vgBQhX+vDGFFdVc0rePnndCIPtvEG0uQGPKw753
	AG2vTnxYcfWJQ5OPNcN2Vi1+Mhahxd+IMveBjgv/obc3eK6AY4lg7qVHH8SPlu9efanz3EKbufk
	qZ3AgRVzn9VLOv7evJ8SbNVNmUQjCdaTaEDXno/KBmgndYgoYjCFxanrFUUxS5ZwP7D+sJrR09J
	xsIwK4aqIQg8nic8nMBCtOh85MOLTbprQrzXkRD1ph+dK2QlZYBkYtAj0po0v/Xxh
X-Received: by 2002:a05:620a:480e:b0:949:816f:cff8 with SMTP id af79cd13be357-949ba823573mr2256929585a.3.1795462816936;
        Mon, 23 Nov 2026 11:40:16 -0800 (PST)
X-Received: by 2002:a05:620a:480e:b0:949:816f:cff8 with SMTP id af79cd13be357-949ba823573mr2256921985a.3.1795462816158;
        Mon, 23 Nov 2026 11:40:16 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67f204sm27856759f8f.21.2026.11.23.11.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 11:40:15 -0800 (PST)
Date: Mon, 23 Nov 2026 21:40:14 +0200
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
Subject: Re: [PATCH RESEND v4 09/20] arm64: dts: qcom: sm8350: Add GEM_NOC
 interconnect for adreno SMMU
Message-ID: <gcgah4os654tusrceekh6e62dlgmtqggtlgolua4zewglhrpjk@4rnokaj2tzlf>
References: <20261120-smmu_interconnect_addition-v4-0-be30526391d9@oss.qualcomm.com>
 <20261120-smmu_interconnect_addition-v4-9-be30526391d9@oss.qualcomm.com>
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
In-Reply-To: <20261120-smmu_interconnect_addition-v4-9-be30526391d9@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Wu++otfv c=1 sm=1 tr=0 ts=6b0496a1 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=jAy75CqWmSRsgNc4pWAA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfXxcVl5H8QFY4E
 LYbi8k8SMC88OWxYl2TaGPg+cEQIo42IG1BDS8z5rpeAevaJlg/bPkF+v40J2aqbdvg3WATW3WC
 yAnlCJ+fAdZaWcekAX7gd5GUTD+k39xCd8PzdFCWpT8dLL8Okq52s13IMNMJnFmrYHAwT3RsDB6
 JEFyre0/njCrLcPHXsjXr6Z5VqiV4j18vO0WdZb7GlD3lMfze2N25YduGh1JBPiPD9ENpJmUDXA
 sDq3axtedQFRE9hDCtiMmPtRtJtK4b8JnDG9qW3C2mvJlHpMTK629roI//7QjfybXC/vB5Dyi23
 4mhUAPcMz0vdrvrW0QK5tnQlTqnL2yh+aXaUSEVbyNah0x2ugQ1FYLePbaXfxJ/ANhp2+OQXGLZ
 oQ69VMoNQQXH4sJdUPH4ND70WYVsdFN5P8mHbEqDba64jOujjlZWrV6FT/qy2NDiBcwToERqnCa
 DlxOUg8vZsMmdm/UUWw==
X-Proofpoint-GUID: huWDirfKZoRh4PZg3hLB0wqUEtiN7Pkd
X-Proofpoint-ORIG-GUID: huWDirfKZoRh4PZg3hLB0wqUEtiN7Pkd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfX18JpU7Pu3BU9
 3w+IRYnqSWZ3l1mNnmhkZMOCvIPNwkfBhhWBwIyoAUhqWB36FBstoTk8lS2rluRoUEvSSluFDpA
 Ga8iEo8+EtWRyd+rODEX1S99rgTtjSA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230078

On 26-11-20 19:11:40, Bibek Kumar Patro wrote:
> On SM8350 the Adreno SMMU GPU TCU is a separate hardware block with a
> dedicated alm_gpu_tcu master port on GEM_NOC. Without an explicit
> interconnect bandwidth vote, the GEM_NOC path to DDR can be left
> unvoted during sleep/wakeup transitions, causing intermittent SMMU
> register access failures.
> 
> Add the required interconnect to ensure reliable register access.
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
