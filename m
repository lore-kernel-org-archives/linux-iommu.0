Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411062749CF
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 01:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779154007; cv=none; b=NGYXMJCjE2WwwqxqtRSMhHj4tmEkEFMfKOrgRJiSBHXgWE4bsmpB++I2fLmL2B5sb/7FjgWzOyP49niwiYBsBWc757NsW62rkPTtPu0/vHxcZ1Ur7fDSLx301UvV0OfrlM9i9OSGXzKbairdNbR4fYrh5ebWDN8WdEgEBfr3cV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779154007; c=relaxed/simple;
	bh=g5ntTcRjA/DRx/Tc6WHE/ZwjZgOEEGC5sk0DCBMjbUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiuIptDFWifKxaNDS1brYay244qNzxY3wXG2Y20Ko77Ii6Na5y4MPDLpfdYv6HmheC5gOnCZ8Zmqgvz+8hbH21cdq8rosBoOD2NHkcUcWqBErkcBXrBYjH25kzK8jDX7fqorcjeY52BeQc7SSYxi9S69gwYANQllHzKrdbOvyJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p5cDsLgo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VCG1sTKj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p5cDsLgo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VCG1sTKj"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IHKi422685229
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 01:26:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=1Pgq1DCRhxh3w2geotao8iZx
	v8LzDha+tYB2biNcGVg=; b=p5cDsLgoOpzHCl4Uy7kxrXdGkGxwM0wAuq7kU6zo
	hWMQMPDQ+K/B/qVz95z2RsflJTgTgBEshu4IUfA2j91V5FN5brqHcQTCO3u7QMK3
	nha85kfzDR3iN+bmVFFLw7qOfqv4vojnoM4k3l57kMopBKmZV6z1Pc3HNyulVrjg
	nDdpNf23VUlHaYupZrRLsnlEEgQqc35haKsPAm3B0uPdZfdmaJ/umbl74HJFGHeb
	rbLTsUFRBnXg6HikIy2gztYa0G+cqeYQn190YRBgdr5hocvTkDygFWEfsikKGShK
	znmFL4dCr/IJput/RclK+TBjf8bZjakqL3sV1gEWt1LuYw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e7vrbva77-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 01:26:44 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2ee5b73c5f2so1562538eec.0
        for <iommu@lists.linux.dev>; Mon, 18 May 2026 18:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779154004; x=1779758804; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Pgq1DCRhxh3w2geotao8iZxv8LzDha+tYB2biNcGVg=;
        b=VCG1sTKjk7zhb7zr4ZcQfgbVlC90teeICopE1TbJscq9JkiTsb4a+QYsfud8cFKwXD
         MEI1MmOwsr8Ki5qcqnguK50n0Ve1xLgo3DaDowa68iIPrHxLOe2E7DJgDec2qrS3fcAK
         MGeC2S6z4bJip7x4+gVdHUnlow/Hm9gz2SURFQGo3+MLAJsF6+B/QlzFD9vUYQYxI3nU
         mZtxtPEbWK6C8tfA8Fe98YO6PGiQtp4N5ppThRbXE41n0/vbWaMQh36OLgCaaF5MZkaf
         5Rs+mVwikmOaNHI4QiYAX05YNDPNZe2vMweOYCXukN12S6wEBglt5u0QDhcnKXHty+CT
         UW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779154004; x=1779758804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Pgq1DCRhxh3w2geotao8iZxv8LzDha+tYB2biNcGVg=;
        b=jnvFvPJXf1FpR/xXUrNyCORgJz29wko9lYh880QhngO/2/AXA3I4wwivftpeYx17cx
         vEkhNqblQio7CmVxbzBoHB5xY41uvu5e4RnDapBpR9A+ZQiKCc5rsKDAso/NZGqvHh9h
         xSEwiN9hopNya/B4q8kPK+Ksvz2oqiJdn8YcQbhbJL5cjbjlhurW70D3b03KVnIfkq3F
         nCyobh/QnhM2cvODd5iP8cQHo13OBod2tg/SRUdbEt/omS01SPRQVuILhPNrFcAIL6Yk
         aGnW11yhGpKeTa5/hWt7rm0sGyMQ8IMqdsZh7QsZMuFHy1odNLm/glkpoZQpr8ZdS74A
         3m+w==
X-Forwarded-Encrypted: i=1; AFNElJ+nt1Hd/ClRY5kS1tDhETzN9hGBtPg7VojhH0soM2OONVOEsUAn6DszTS+W2VlSStrNK9mNRA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwNqOLmdJfvo436lT4nF1/uSwxUb9uRCwqajyyCsjGwBCTQz8wL
	+CKwhDtASPQXWzxapV50m6tneDzwUUmxUOc5l7iYmil0UrsY+4II3Ft0vOi7z5MIm9npLy6R+JL
	w0tDtPJCzQptdeLgTOe5XXlf0PokY8AddvBTLmBK+SPrlIAGFj4vXh5G4rw==
X-Gm-Gg: Acq92OHcJht1iWEYw7yeJ2IlfV73kUsj9CsAfspFLKxsCzeYz9szWkNsj2ZS1pySAQ/
	7WJDD6LhSczJTHqMHwymUXy4/XM8n3YJv1a8F1j2DFlzFxo6eCcsr2uVHJt8HJNqNNV5QUumxLs
	EyOa9vs0bdx1xehp+WLLvAqlZCBEmz2kWfLTwRCZb75Mo79+0NYFEmjR/PM6O3cHUxytuLIjPtM
	gdfBOziNLsiJW8sl+tkTy8Yp7soE9tz2ebXET39lJu/xjLjW+wryOdyR0iKgupQB9HaPsqQUQA7
	wdHLYG6p5jBBwJvWCv5uE8SSEmAgurYHo6Y0vSf2szUqFWK3IWrxdngpa5e0ARv8gknvoqVOM2P
	3kNlhl5RUqqL1+Vwxx9cIfVKY1z2H2fzimAXVTzlizL5macyMY1V/zTSdGdQ6KgYl
X-Received: by 2002:a05:7300:e125:b0:2f5:6d9c:7156 with SMTP id 5a478bee46e88-303986814f8mr8376361eec.17.1779154003779;
        Mon, 18 May 2026 18:26:43 -0700 (PDT)
X-Received: by 2002:a05:7300:e125:b0:2f5:6d9c:7156 with SMTP id 5a478bee46e88-303986814f8mr8376345eec.17.1779154003281;
        Mon, 18 May 2026 18:26:43 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302978b1a79sm15050372eec.28.2026.05.18.18.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 18:26:42 -0700 (PDT)
Date: Tue, 19 May 2026 09:26:37 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm-smmu: Constrain clocks for newer
 Qualcomm variants
Message-ID: <agu8TRpjYRqs0Sja@QCOM-aGQu4IUr3Y>
References: <20260505071453.34000-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505071453.34000-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Proofpoint-GUID: ZbjyjxmkCzLp5uwrBE06xOUtmlIaZthx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDAxMSBTYWx0ZWRfX5AcJtFtwiO2f
 6HTfRZBeQCBD9r5ZrW1RO2uZk86H0roPw7rJc8IMnMkKekgBmQdrW2SGxvHM1A4Kns1gHDia2ey
 MEu8i2BTVNiTSur+IfyC6luvZOpKk7gRZkIC0/LgEi/XwjAt9+08g9znoKz3RwHhrf4bsGB7+Bx
 04EIE8e4lfZ7ZeVba8HaDJ2d14olz91Gnf4cF2F17N833hSvXy5h1OrG02kl0zH+k9yOmeY56ut
 Zl9gK4u0m1OGJL07+IHd6OalUaU10RLK08ExmYsifl340wx/d5YnKtkc6SikJJ71jSvAfGcUJ/L
 80Jl7UIkcbAE/nmVG7wtEfz1NnXluULW0c7r/XrzfZtPINZagZ2dYr+sqlxTdnVDzrYAt22FOmj
 MMUkMC6tNgdV48uAcUCeFVPpIHpUBgIGPyWrPhwppOobtdcInO8rqldiMU1MB1aBWEgAXnuYchz
 v3hpoYPHXHMy/7apr+A==
X-Authority-Analysis: v=2.4 cv=KZ3idwYD c=1 sm=1 tr=0 ts=6a0bbc54 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=I7k1zq4nAz8js2EDA9IA:9 a=CjuIK1q_8ugA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: ZbjyjxmkCzLp5uwrBE06xOUtmlIaZthx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190011

On Tue, May 05, 2026 at 09:14:54AM +0200, Krzysztof Kozlowski wrote:
> Many of SMMU on Qualcomm SoCs come in two flavors using same front
> compatible but a bit different fallback:
> 
> 1. For application processor, usually without any controllable
>    clocks,
> 
> 2. For the Adreno GPU, with some controllable clock(s) and using
>    additionally qcom,adreno-smmu fallback compatible.
> 
> Add missing constraints for Glymur SMMU on Adreno GPU and several other
> Qualcomm SMMUs for application processors, to restrict the clocks
> property to a specific value.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Reviewed-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
