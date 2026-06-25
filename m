Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A55937FF6F
	for <iommu@lists.linux.dev>; Thu, 25 Jun 2026 07:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782373106; cv=none; b=tJTCVD7L39xiSDfIvs1yYlAXC0d58QtuQSK1VoeCiD0dj9ooPqzZ4JSXYuoMWbpFSDHVqSTMJidxH5RgrpCcZTZ54gc8+RqQVNTe+oqmEuZw1YcZT0Y6FbczQq0WeNkTG1MAW1/AiwlVEahCvNrPBhdVOs9BmPjiNIf+n3ljz7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782373106; c=relaxed/simple;
	bh=94BLnJu/Y44ro9VZwEjhoTWgcdouLHYogTgolaSAjHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SoeWB+eW1iBD8d0XBcohhz+i1xd/Qfm4MUqfkIVY2jbRjGKFh3rWv1yo02dExKeOs67EzdwpE1JUDWnPtP42OF7ufg04HKQBOzB4mqilb1fm5hx4+w5Qj67ukD/i2yiu07XBfONx4SFRkEr0QvxK+DEEliBP/z/rKr0A3Naw31g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lrOc8xep; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LxC2rnyY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lrOc8xep";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LxC2rnyY"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P6gmis1527037
	for <iommu@lists.linux.dev>; Thu, 25 Jun 2026 07:38:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0kMOW4i+4XV2WgAdnsOAr0reBkKZzZYazMDcvSB30UE=; b=lrOc8xepROZ3JvYm
	Blh/tVWTxMfrAFsytf47oi2cXGKOnmJTQBAHBS7WDEWC1oFwIpeo+fJAbnHYlUVt
	0NPlZXMKXmMffFqWIx6gYoigCVYtCcnekQxAjj//4dWuFi97QZ9+3+FsGvE09mR3
	I5hug8Lw6ujgZ5XE6773IU8y7J8UG27FOycsotkLXNwxRUR1Z8Uz1GPLwx+50QcC
	iFySBP4eSgnA53OsKtsQlahGfTUkq6lIMLUsBG60NyGscxbTGKZfJSSh941kx8DQ
	xhHUeyl5ZF+MNKZX/6LoWR9f5qOz2li121y+hkS3koONnjTBQrLmVC5cnV8NdMMc
	FOI7MA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0ya8r6uy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 25 Jun 2026 07:38:24 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-920eff1439cso22922985a.3
        for <iommu@lists.linux.dev>; Thu, 25 Jun 2026 00:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782373103; x=1782977903; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0kMOW4i+4XV2WgAdnsOAr0reBkKZzZYazMDcvSB30UE=;
        b=LxC2rnyYJSmXZ14JPpxZFNMtFxvg/0XOvT5muDXVB3sNNU4ElefLlPFymLR5H2bYAs
         kMbtaKoNq643mZHiQBmiBVGilMYIi+w3sAczBXutqfcid8U90n5X6zw+/ePgqL6T7hc7
         fBu1WrpC4zSngrHDe9bUMOPsbE3FkvWy20/G4sCcP45mEJinHiiSUD9W6/Fo/ZV34Vfd
         B3GiKh6abqznDj5JN/3zezSIdIL1nHNVjOczBHdFZq+TQ8dgcATFiJaFHDnWmYw1xLLI
         a3zRuC79/mzPZs2hCMopzyzuWrb8UfLKpg01qiFpbe5tx0v1QXRpq5ha230zSq0VTlSO
         71cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782373103; x=1782977903;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0kMOW4i+4XV2WgAdnsOAr0reBkKZzZYazMDcvSB30UE=;
        b=G4xXXXPdDVuXlQTtNvVReyym9aZ99ZquyZZFTCuVWpt43oxHInpmd/zs0bg/Hj3+3i
         tfFCnU43dvDfNGgZVBmCt4uA/upsyqW3owco1OXudj70xIxstr+MqIQCQjMrqE61q7Gb
         HL5DP1UHO4jONxoVubbu/IpXT5XkEiaZbSy8Kj4AAtRIsnrf7n62n1eebgxpRjisOjqu
         IhsdEpUQaElty51zKFKf7mbFHnxX5qFkDz45XpapQpvwaNja13WPJrk3AX+YAO/0OwFK
         gqYPPV1W5/tejdecsEjMFWGrfu1uB8guUA+QWoWehlCCTIeY48D8zMYxVaMDDsnCLPGS
         5uog==
X-Forwarded-Encrypted: i=1; AFNElJ+ASzYnBODeiSA8pvWozmiMRMWgy24KUDC2buzYp5mEMExII0cWvwTq5GLirpUenTNgdr3rKg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxE31l60gBg+tgn0x33/36+6ignR725TkmhZ0iZUZcCWakWM50P
	m+QJTD0y/2bLMv89j6ABIu680i4aWXdMhiN0Ya0KbEZ4hqf46VIXZjv3KJouAz44OrfofL2EhOF
	5WvqaF0ebagryB0MgMRCcsmyB6kAjINaRcY/cvJkKzTs81GFQcBA4PeiLaw==
X-Gm-Gg: AfdE7cnlqHGsk0QdY46viPY4peLQbnEJQwS9mXQgAuVwbCPqvpLdNzlokU9Bejmu9n0
	XVAy2gg8J1NWdbdGu2BOdKUTIPSUvXKm5h03pZUfvOcq0dKlhZf8mrsguUgX0/X4RuPZzPpsCXl
	JSi+LbB/GpI1zF7Lu3jYzJUp6iUGPtj5BvnVSjCrnjO2ditetpncMooOhfKFjMHbdOQJmiM4TXT
	RzTjZ8sO5vESw+C0hD16cWKrL9U7RYHt0BKkYVAtwNLX3ews+x4O00cbM3ECfb5fftfiW8qGw4P
	uLGDi5nKTiMpiL8I5+DEL+sp1z2CL3cSioHalydpbSqILepK/kfWTr89ozJffDKPSi9R5d3t3NE
	9wcQH/n4e2iy/hekEm+M4hu9Jdm3YH+gfVEM=
X-Received: by 2002:ac8:58d3:0:b0:510:144a:636 with SMTP id d75a77b69052e-51a72ad2276mr10886151cf.8.1782373103373;
        Thu, 25 Jun 2026 00:38:23 -0700 (PDT)
X-Received: by 2002:ac8:58d3:0:b0:510:144a:636 with SMTP id d75a77b69052e-51a72ad2276mr10885901cf.8.1782373102900;
        Thu, 25 Jun 2026 00:38:22 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbedf971sm120256666b.62.2026.06.25.00.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 00:38:22 -0700 (PDT)
Message-ID: <ba15ebf4-ea95-43ce-b612-8df25a9f179a@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 09:38:19 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] clk: qcom: dispcc-sm8450: Fix mdss clocks
To: Esteban Urrutia <esteuwu@proton.me>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org
References: <20260622-sm8450-qol-v1-0-37e2ee8df9da@proton.me>
 <20260622-sm8450-qol-v1-1-37e2ee8df9da@proton.me>
 <65873506-1a9a-40ec-ac67-60f61a0b4b4c@oss.qualcomm.com>
 <9bc524b9-c6da-47a1-a7cf-abeb131416a7@proton.me>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <9bc524b9-c6da-47a1-a7cf-abeb131416a7@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA2NSBTYWx0ZWRfX3ZRByB+4mEBS
 leR9siF2ktfY2z/2WFkdDH7nhP/ncXKy01am8ns/EDyZMlznELIijoD8rw7VZYYgKzBdXgepuOD
 3PFJNsxLcD7xFPPedAs0s8kkVZKDTFM=
X-Proofpoint-GUID: Dk8eHDI4p9DkL5PivBzkYbjKQx0f-PEl
X-Proofpoint-ORIG-GUID: Dk8eHDI4p9DkL5PivBzkYbjKQx0f-PEl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA2NSBTYWx0ZWRfX5OgersXQ+XMD
 op0hdoE4/dbXrRfmRfbqclZ8Z6S1lP4bedP1UKgeSbuPcTooKKCSPuR/aSThz73a31LyBLRMpyA
 U0yiGx9Rjn5I0a7VwIHVLe0PYRjs4lCvUqgfElvUguA1G+b5Ci4uixPK5G5T+lGzReXMdvn2rzV
 rCBzOUxF5q0IZr4TmNi8dD5nNYhUrboH5x84Uw0UB9EpdoKPpgWCMJMCsoUlDTweA/bmAllFbgl
 w1CzPwz5hF3dj1bTB2jHfMhIol5z7EGTzxVn2lqXz3Ml8fMfo82eyCOSBDNRgF9I1zFZlrh3D3q
 mOOk0rVxHyN2hRQIFXYZL8RqZw+DIFjtqhoQOKmzcpCFYDfKHVMPNV/sqQdAizGwL2QI2elQeM8
 q6XqKOpr5xLiOexFVWNtWvxqAAaE0auzcj/tTRLAELnq2F/B/gQ4kkmRCiWp6mA97ut3ZxkG7/D
 zXom62Ucd8F0KYxUavg==
X-Authority-Analysis: v=2.4 cv=Z+Xc2nRA c=1 sm=1 tr=0 ts=6a3cdaf0 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=yUEngxm9hVyLX7FlFv4A:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250065

On 6/25/26 4:22 AM, Esteban Urrutia wrote:
> On 6/23/26 11:50 AM, Konrad Dybcio wrote:
>> This can also be fixed by migrating to use qcom_cc_driver_data,
>> which takes a list of alpha PLLs to be configured, and thenthere's
>> a switch-statement in clk-alpha-pll.c that always assigns the
>> correct function
> 
> If this is done, should a patch that migrates to qcom_cc_driver_data and a
> patch that fixes the issue be sent, or should only a single patch be sent?

It's fine to just have one patch, but please mention that this
actually happens to fix the issue in the commit message

Konrad
