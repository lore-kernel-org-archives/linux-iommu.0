Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076693D3D1B
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 10:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764376; cv=none; b=CDpJ++qOZauhY7uxyojg/lUcU+ozT1wzbe0sgqVHKOEehk4yc4Kakppdv7EzNBcE/WXB9D5XcwFgVt95DulGBaOEOdwqqLS6r4YypDxNQ1CMHjkYCPQop27u7V5y8reWHCsh3/HxyVqf9zaoEq25CfvLMaby/+2ENQBwW2MKh4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764376; c=relaxed/simple;
	bh=K9mLTHUMGbr6BKmkS0Hof+NTL55zplajOCmN+l8Gqco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C3BH/BSPVCMoGTa0AL3wJ9RU+C//YwRqdLl1gglEugXiG1oOCudvZKg6YIOtlKxPlOtuUpbVXxdjQlxCZpD6j0lN3oTWKFFFGPNGO2MgD0s6rsQzI5L6Fkg/ofglGs8ddy9z1X3xBlocx+Eh16oeg5jfROwlpz7y5zUHK6ie+/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HYmEqs9W; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RexXB+Y7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HYmEqs9W";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RexXB+Y7"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68U7ddTa3489291
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 10:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K9mLTHUMGbr6BKmkS0Hof+NTL55zplajOCmN+l8Gqco=; b=HYmEqs9WutxOa69a
	OmWATf9BkDwYYv4FkJDlY64AaUtirh84PFYtB+CNWdzGQcUhE7oi6tCqbiaXaqb+
	6r/Xc+L+lt5liw4SbqvkO5r+SSOsGmIghGx1H0xv6oxdeNOMZM/BiCWZISknnGv/
	gWdH+Qfj004GR6fOl7WaOGuIEHJy8ysn84IPJvVO4VP4QfIp4sV3izuSWCG0cP/X
	1LVXk1wBT6uianUh4/6lS66MH6B8QrVhYioNYoUC2ptvJWLXI8vG/A7S7igPK0Im
	yQZJtRCpvYyc/ivq1h0nRHQNiNUCFPbCTh/+0HU17sKCFjBpbCpak5cHDegT53kE
	7U+JcA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0j97us2u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 10:32:51 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-939fc317691so100812485a.3
        for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 03:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790764371; x=1791369171; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K9mLTHUMGbr6BKmkS0Hof+NTL55zplajOCmN+l8Gqco=;
        b=RexXB+Y7+pXRnabSztxVzFh3c/pMTHRcDDZR5pgUhvnCdw91okelxd7cEr1m6CC1ky
         +VaapK8E+UTSO5Qn8lyX5FWyzEh8JvCZaQvB8+CVBRny5lCmYKPrKEIdJPhOapSnRjZ4
         5XVPDPox8eM6t4/EG/ukZBJIWRmaigrlNI/HJFBt4CCotfV0/mi6DnyyZkGjqetfg5fj
         WLmtZd2IzYcOYeAHK7uSDvksdn1QJQcPm4IQlsnbFyVjb6n0wTJGdBdyGOczaGlbxR4Y
         +i3Zp/B7O0AOcJNL2/UT41hW66Wg3wG9TMUJysx5WmwmMPOGOXXAGKEGTK/cXJKUiA3h
         FD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790764371; x=1791369171;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K9mLTHUMGbr6BKmkS0Hof+NTL55zplajOCmN+l8Gqco=;
        b=z1P9RA+eTowLRXs5EpyVwN0XqXzMACh7YXEtYPVLoeLSJzWXHIgrak7X1S2l1Lw4Xl
         b+SFBQ6TohBt92FGHlL6zqoBQvKpXgWje7o3FSDYETfO6lYUeyALke+1yBm1TEMiLaaj
         2cGo+J9HBtGQQdHwuQho890uf5cFjIb1NyNVIgfLL0br5f6DQW2xp7/bRMpaKYaNyq+y
         zvOJG+pXziYEa9C01bOWYA3RTuo12DMn7zmDrMAhnIH4/7z81PtkeEuvaYOtpwABTMZm
         aORSKP2F5tC3JOFqVtkpjL+XoJtHac7DAAprS5dDCDb7CgN3z7PvxwDghL5wnNRiOHq6
         G0JA==
X-Forwarded-Encrypted: i=1; AKwUvBxHlLXRh/14qL8DOsq6iXTWZ9HvnluQPmmmnFkM9VLcY1DlV2Nzoi4Eb1nW0evQVl7XCvz3Kw==@lists.linux.dev
X-Gm-Message-State: AFuF++kMEzSXrQTVCFyK+sTCb2vztWBIaKxNTzyPX3X2iNegVaWsu8JP
	5R6u8bN3eWiCTvSY4qgUujALEFU3uu/aS/kenmHCA04KDp/47QHLqx7xxIfRGHw8KT4bPTU2uj7
	AvooS/A8n5+6B1LqPfVccSXCpKhppJCfuaB/Yhcuex3ectLm3advfWZVTUQ==
X-Gm-Gg: AYBFou249HwWnmRy4Y2h1KjyyTe9GAW8prA9mQTHOxctzR0BRX+r3B8ECXL6W6FUjCJ
	U9vTOVrmkBgvfoUVZ4/gnAmrmlwaxRa9RtPu6TMJgCp2OE66rV056bKbpX+AjywLXX5HpD8zYRw
	TZT4IR5Gfi+A9kbdUwXV6KKBRETYX6QMPBZ08Yf4yimG2Zqs/MGxD3y3bTTtbNjgOrZPMrmoIBW
	bnbRiVCdNW+oy0KCslKqn/201KX0VSASQD5NieyvDP/STBvClHpjCCBk3K3OHRz6h6jZuX3Usfg
	DNygfjthPjv97ybyhAy8EOu3j3zOVrOgLQYd315WNTuEZzRxcSf2B8mDiOwMXtC+VOv/tUfcPl4
	U5gCQh7eKe+O3eTnBdw7RrA==
X-Received: by 2002:a05:620a:40d0:b0:93c:6a0d:762 with SMTP id af79cd13be357-93ca93365f1mr131779385a.0.1790764371097;
        Wed, 30 Sep 2026 03:32:51 -0700 (PDT)
X-Received: by 2002:a05:620a:40d0:b0:93c:6a0d:762 with SMTP id af79cd13be357-93ca93365f1mr131776485a.0.1790764370645;
        Wed, 30 Sep 2026 03:32:50 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e22f7f26asm44710266b.42.2026.09.30.03.32.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 03:32:49 -0700 (PDT)
Message-ID: <543bd0a0-e0ee-4bc6-8988-00f595334167@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 12:32:46 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/13] arm64: dts: qcom: hamoa: Add Iris context bank
 subnodes
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux.dev,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
References: <20260926-vpu_iommu_iova_handling-v5-0-0322ca5dc10c@oss.qualcomm.com>
 <20260926-vpu_iommu_iova_handling-v5-8-0322ca5dc10c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260926-vpu_iommu_iova_handling-v5-8-0322ca5dc10c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: SF1l3cgOGtHwApflVde1vkYVXz42YgDB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA0MSBTYWx0ZWRfX7E1/B4QBujsg
 jGA+Q1Tm4D6C3keYfq63DKczqdaV1EtrRGT8aExwjdIcksF+lNg686HZp+NXGZPF42MvyITEtOH
 hnWtKappKqcLbIJoSvTF4BhgSULKanpRT9aPZRK+kvfD7hgh29mZFGQyU2p0XIlSqsmAhSPuB75
 UDoapCgWihS7cutXsfD52C7TpR18teXFT4ZCpXmwSvYLuA1Il9rGmEEaRLF4yC1EABvuTTYFwVP
 gUT8F/v4LlPibYQoRB66c1sLA0CzY0XvI72ZejDJvxp/5ImnVkEG9tPkO9JWsBaxNtVXobXU6LQ
 vDBnHjuBe1tjBYlPLFYpzZJaoIUkMWpwQJLhcYt0I7x0US/3PMOxUvnJODeEzhGPdIJhz0ygEuh
 T4rUUD97vJEJG/mRok8VZNZT6ulFscXz6F6nU57MaxV/hzKO2aRMUotL2j1bLGEzOnBh3aEqf2G
 rtYLCrfmsEzAjZxCD6A==
X-Proofpoint-ORIG-GUID: SF1l3cgOGtHwApflVde1vkYVXz42YgDB
X-Authority-Analysis: v=2.4 cv=BPImP1QG c=1 sm=1 tr=0 ts=6abce553 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=4BULcDCo1EIeXDFKsSoA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA0MSBTYWx0ZWRfX2+KxUcxtsKhJ
 rFJPnsyW+JEWnktf0XWxWcNLOSRrrIhH8cYy9zaW1GZ1BdDYiRR9+9ZaIFqez+35LwHT3uSJGB1
 DITjWt1hC4tXXFIwN0VEtDI5iKNJHlc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300041

On 9/26/26 8:34 AM, Vikash Garodia wrote:
> The VPU issues DMA through several SMMU streams, and the hardware does
> not give every stream the same addressable range. The non-pixel stream
> cannot address the low 600MB of IOVA space, while the pixel stream can
> address the full range:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
