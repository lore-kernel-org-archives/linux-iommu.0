Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795462699;
	b=a5+CPEQIZjGqsaIezb6g7k+kw2yujJKnk+RVRnn1AMzxNzhHt3ZvUbnI7LVXDG6hy7Br
	 XJLDue6Nz8rdcxjVFQB5zLFfxyaHd5a1FdSRka8oO1D/pJFSCC8p991rShrvXCt3Ovjlb
	 FRLlWU1ubNuxilM/0BKvkA194Jqz2A/iuqUO6h6h9LE7c/LzjNSbhfEzsWBCGoRQmsrFb
	 fnrgEJCqWd6//bNrfARoqJ/nBQH6SP0kXoWDAr0UE9nGeBNKGtQ8V8RI77w0Cqhn1upGw
	 mN4kEml79tyuWoeMB8u7NH4HpGpW9HPGPiMDLWQvc8cy5DJFM5hU45XjRb+f+Zem+Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795462699;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=mMQUGbXJMaa86ZgCyPHuQDcNhrKapcPCs2WtP/7YI/A=;
	b=rq0iz706SjgjOwmzQXq7IGElKm8atrIwsmytn4sOEBEuks3iER3mxURZnWPFC8iPEjEt
	 Ok19MlcdNelxFx9f0JwMQJJGQQnR1vQTNX4Gzm7iI+7BfqgRwHmnVb+mYDK0/SDXHAWPN
	 e68iVnYzvik0/BfMSjaMolmsx41o7/IQmV4qiV6IQWcb6Qwm5O1jRGdZKrqV6H8oRdc9S
	 V/3xQIq6QfqZh83Bl3YiqPdADYZIt2A3kf8P2alnuWryV9kkUYhqs4fR8WnkSEEPyD4b7
	 qrlOvqM5dTaMwpG0lan/wlyu6x0+BIwduzsloGh/wiKK2Gc5EKaA6Hc6afjfbMim7yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZaT6D2F6;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KuBozxk5;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC19E606A689
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC19E606A689
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZaT6D2F6;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KuBozxk5
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANGGr2b2769190
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:38:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=mMQUGbXJMaa86ZgCyPHuQDcN
	hrKapcPCs2WtP/7YI/A=; b=ZaT6D2F61c3tpeFzP1M0/Q0nDKwT+BVfrEyV3B5F
	1j0oxcpR889WG9WT0HCSPPyS2ur7dkrCRaVUW69pD9HmcMBGD7N6dJ6zErYcnVUJ
	t6RI/rXE0bJ9XX3fzGxAUypVTVjnVNVWHtlubj2KpWWdKC0EOGjvKEJtFvQ9YM8s
	6kLRQInrOO+of9zzfr6tsdJktDrmAQ+mAP8JhWPC/gsi/fAegyZ9degluqiU/J5m
	raupWZP6uPhkciD/8WF27njC4+VUfc81VImaGvkLi3ohj3tbVCk/lkne8AH1FQaB
	b0x2P/XA3VHj8hR/wyauyTPno4FwQLlg8XpPo1OFxImB5A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g1pb3qr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:38:18 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-934963b2bc0so692028185a.3
        for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 11:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795462697; x=1796067497; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mMQUGbXJMaa86ZgCyPHuQDcNhrKapcPCs2WtP/7YI/A=;
        b=KuBozxk58r0e3SaI5KSZ/ZmKiBQ+4O/uixQ6+LWkJxIiXZigyPigYVe6Ga+vGIrtro
         ZI6QMKHy+Ny7nZ8CaaNFhZWcq7oAwGneB71btfF3uwilEhn6uCP9q3qxkR02aderKN2Y
         pN/V8Ob+9qmGAYJRtbZZVuhxGqUoNP+kuKqHydEb0WYAdTz+QlGDJTgHz6My+zD/oLhC
         TgWXoy+9orONvSEVXDsZNMamZ5xxMJZEPvQLUJ0u+B5BSCxGT8VnDtWQFfgBDeVVGrQh
         xagSpvlxUKTGVHHHh3xH2etY57/c+Hw513dE6tFag6k94BRwhUb9XPKuVSbpMMVXKuLO
         y6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795462697; x=1796067497;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mMQUGbXJMaa86ZgCyPHuQDcNhrKapcPCs2WtP/7YI/A=;
        b=eQPGj7mKgm1TAwSLO2HJj1i1TI6Mlo2KnF1yWJmuTvi+b9wTaUXMBBG/kk5WmRZIOn
         nBF03QJhsbUVb0SB+5VhoNaRh+MsZo0KExW29ZZt77iHfsfWWyLlUi3XdtgnXhufnpT7
         hQeHMcjBG7hVQb/pGUXD23Gg3jKL1keRwcd1o+nUZLDZaR7RaxJfcxNhQGjLSrJKHZZ2
         e4mFxAcrif7Td/SCg6ao0qVv3h4mdsmx+H7J/f9IsqDAOcWZywk3Sqju8PVAjAa90pkz
         jdqxjP9Tnc07NWEk+2/B/L4WFc/H/CQYo+rwy37mlpnxUGZ19mBgAhlshcHtbAymwD/C
         WPEg==
X-Forwarded-Encrypted: i=1; AL+hErErAnjPSNMG7pFQaMT8aNuClmGr5Z/tWj5s4y1ts3+OrGWIfyIF+h1Jrm/GFWKIwghMx6iaqg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/Pmtr6VmDHw08DWPsyXv6y4Adb9xP2u2JclRlWQ6jKn5i1klE6
	ut6ReD5+IPvaAg9XR8eBdt+RSQpf/WJbQ0iop2PHIkNr65nqXeVTu9xbfjHLTG+zmsW4Uig8Vig
	XrvIPiFw/3SxIugjph+gyPEifyVx78n/+hoMBQh/ShVclCSR+XlgP1VSDoQ==
X-Gm-Gg: AZFdTZd40xlGIuJjehh99P/d8+Jxzc1QlZYF6QU5/Gm9czHPTLE7SOIAul09Zj1L7Ca
	rU7cyaIzkr5OH3uUflGUeyVyEQANJT31aLaxzFakCFg5vy4mev8YpK6wNbygvfKaAz1X3Q5rRPe
	p0u0erL4Ptf697hfL9574ebFTzpgcS6xpeiEREuRHvJQEdqpFJJAtCGMPECWDZ1mMhDDE9QBf18
	qRCCVGWh0PSIswKV9cNg7N9h6mEw6VkgmfdMDmerSBr/YPO/2eWbkWwREke8wvq4Tq34sxNDzjB
	ClZBaVB5PrG2S06Jg2AfeUzHSBfoK6/j5noyIX0y0yVRyhiUyK7daG30kcHTIl4CtAFiR2RL/3O
	4LPO4k3r97w97EOeAr7fhUT6RAXdkeywXv75hXE75YqbMdtYWJhC+0YO7LkmYkx0D
X-Received: by 2002:a05:620a:700e:b0:949:b8b0:1b11 with SMTP id af79cd13be357-949bab1df30mr2390116585a.44.1795462697066;
        Mon, 23 Nov 2026 11:38:17 -0800 (PST)
X-Received: by 2002:a05:620a:700e:b0:949:b8b0:1b11 with SMTP id af79cd13be357-949bab1df30mr2390107885a.44.1795462696430;
        Mon, 23 Nov 2026 11:38:16 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe75sm27067764f8f.24.2026.11.23.11.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 11:38:15 -0800 (PST)
Date: Mon, 23 Nov 2026 21:38:14 +0200
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
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Val Packett <val@packett.cool>
Subject: Re: [PATCH RESEND v4 03/20] arm64: dts: qcom: kodiak: Add GEM_NOC
 interconnect for adreno SMMU
Message-ID: <ovctaahjwayrio7glzjdtdveo6si6ldiddunokpho6w5ipxrve@ef254zb3n6tx>
References: <20261120-smmu_interconnect_addition-v4-0-be30526391d9@oss.qualcomm.com>
 <20261120-smmu_interconnect_addition-v4-3-be30526391d9@oss.qualcomm.com>
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
In-Reply-To: <20261120-smmu_interconnect_addition-v4-3-be30526391d9@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfX1jEppckf7Kc0
 DQuw4mA/mGPzVgNWOQFfce7OBh9hfU4wl3tqgAnynL6sFcZqyNiLao3MpSlnRDSWnyysedObzLl
 V1tVJ8EmZy7w7IoUR/TcusG4QwI+Yq5n1C0JskdwIC+85v9c5re5m4AE2UdPBwwSRRheoJWOpdV
 Kv4qMKREApY4sO7vHeNJj/pXpldUHEJ96KbzunW5ZIXbwXIpJKSOPbpzjbbTvKPVzf5741sLElK
 8CzJ42kpBkCf1xqFPirdMLOOldQ4HpvUgL/BjyHULI94fouey977uGFEGnLevkztbxC+vl4G+er
 uh6/1weUN1HlQhGyiMM6RWkovAbPDIQii6SEbULGjBhwzK/sJpLOab/MQw8ZZPAxH/fqK3UVOta
 V81RKko6smrlTJnye3Z5S0Yi+sbEB6EE8b+qInDsIg63QjGFskSQQTJY3B32yX9OfsaPisXgOn9
 vRdRJWEhJXk7+hs/NiA==
X-Authority-Analysis: v=2.4 cv=AeIkjHXG c=1 sm=1 tr=0 ts=6b04962a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=ukIheBjJDxOVZQT4PtwA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: dlIiKF8VO0Nw52G5klCZV_WZ9w4JQYVl
X-Proofpoint-ORIG-GUID: dlIiKF8VO0Nw52G5klCZV_WZ9w4JQYVl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfXygh8l888x+aX
 ygwc6TEU+BLRH3mRsCfo1TmK/6z2cP8S6k7BDAFI0VZtpnM1jbuW3K55xUKF+ta1560nq9AGG2M
 pw1eu8qNXBpQ8NLu1vEtn5+uoTQxdpY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230078

On 26-11-20 19:11:34, Bibek Kumar Patro wrote:
> On Kodiak platforms, the Adreno SMMU requires a bandwidth vote on
> the GEM_NOC path (MASTER_GPU_TCU -> SLAVE_EBI1) before its registers
> are accessible. Without this vote, the SMMU may become unreachable,
> leading to intermittent probe failures and runtime issues.
> 
> Add the required interconnect to ensure reliable register access.
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> Tested-by: Val Packett <val@packett.cool> # sm7325-motorola-dubai

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
