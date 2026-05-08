Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078533D5234
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 19:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778267122; cv=none; b=u9jmvAKLAsRut/z2ZNfH2BJKsw4+T6/weBPDuBTwv4EXKmCwsquXRWq7NvYvmbjERYlx6j9kcUJ0H0LspWgQ+z+O5u80ZikMzsjE3tZQ6q8Rl7Q+FMY15sMbWdtucSFcnMdiSVcBzns+VrIvAu4Q3U7Mz1CMwvPou0SMfgHPHSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778267122; c=relaxed/simple;
	bh=E0z9P1Rp8PQEbL1EJIqtI4bjCCcH5p3foBuKDocVrXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k82sspgXSscLR5oTLv/29qqFkLzWgjSCl2YdsW0YjQi0SAGBT38p05TVzIss5KOJqNXt11nIXnvlrEHSvbrNa94TryX32VCDXgGXCh9hBxFHT7+ts/rWtQ+CpSYDVNoV/OUsSReSRpx/Eid2CbYFw1SAmT/dJPitknNaMAWvDxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TF6gG/d+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OlD4MjKS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TF6gG/d+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OlD4MjKS"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648DMa17317550
	for <iommu@lists.linux.dev>; Fri, 8 May 2026 19:05:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JsEqcgYOnuyqrkT3DZE/73T6JDxe1/eanTRXk14TS2o=; b=TF6gG/d+cl1gGsFt
	XhGc1rIC66W5UEL5NFsdR4+RuuU8bFY+GIRLMFCrib7bPBt69V/6G6L8HK/RPDBl
	SpFNXkni0CY6RCZbBBPtFl78RellB1feOoxejuN8LPvDWdmXJo72PwkKAjrQFuF/
	0KntqRjDs9vD3s9nuOngaBeUgJo4dV3Ty+hG7x8QW7xI3RddDG07djp+piPA0iR4
	4VWzI3/R8k5kAyya51dI3Y+UjAAhQFJznFhgYHpuZFcn9W7i/VLjl+ZDH4qV8NaJ
	AF0GqD6LSC1lB59M5a7yr/drfkv3ycL4M951YR+ul+9W92kPUEh2Oecz+p8tWrgU
	zB2sfA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1bc02tws-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 08 May 2026 19:05:20 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2f3eb8f3419so8791326eec.1
        for <iommu@lists.linux.dev>; Fri, 08 May 2026 12:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778267120; x=1778871920; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JsEqcgYOnuyqrkT3DZE/73T6JDxe1/eanTRXk14TS2o=;
        b=OlD4MjKSY6yjs5PAHsJxPc3ikBpP0e4woZL3GIk3bwcUt421mNC3XLZgi1LiZ4jLcp
         uq11wZjFmhs94wsDDAZ+Hyqs2+87zNc1yIl00hMBF3rwOSWFswb5C8AOyRgdHSxPzyah
         me4d76TUyQWcVl6KSFZU6xnXHSUpKe1bkjoAsuwf1EHR037fiIH4hYLd69fUboIfhxjI
         jJCrndLPz3AffgJsG53k0+Fxdlfh3ef2zOtH7Chfgn2NPMKAsqbPl3+8yvdFziDW8EwE
         ar3kwohAWaC8BVBU9Zax0D83NfZpB9VNjKSX4n1Ujd/Nw37w+52is/imBCT6YTOkej6x
         ecJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778267120; x=1778871920;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JsEqcgYOnuyqrkT3DZE/73T6JDxe1/eanTRXk14TS2o=;
        b=WxoVvyGPn76YRWw43z1EpCbL5TF27qplgIQQ1o6acP+hwEiaAvo5aotX0VloT1pTEn
         joKcT0VGjI5kJSWm6/f1v4y7YHMA8rFYuIDy/SSiqFD99C7kxMdogKmKH93kskrBOor3
         Vp7GooT23E695rN1GKqlT1m+nz1qK3NXkMC1jyz2PdBEvq9zt/8C1846/sVI9U5wAR4z
         1zRdSZ1HtW+d4Ri9XE2jyYgWctDrNZl5EbIQayVUYuBw/lDCGkRW994QPqsIQ1idV7OQ
         +2HoVEu3+zAUPLHwbihWf1nXQz3OMIutl6Na+iLSUXdC7/6gNn/IkI9W1kK6Tj859V7R
         xxAA==
X-Forwarded-Encrypted: i=1; AFNElJ+F8JVwwuDPdIsHpJmRYpNoi5xSvlBKaZeoSad23Z4nH7Oz7bKaFsd/Qzn7d0vsvonfKx2W1g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzqvC/V4WULxzymoAxKoSba6aozK2sBxSN+u3tqzowOLhVNpd9K
	fnj56LAT02cDG0tbVRgx0aBza5yVojfWGF/eiD63tGVlHOTi2NWEentCiC9lPFoMFdU2JqaMX2j
	b/41ooD8JdzulXzYUd9BBL5A/tq+xUp8fu0IIIlhN6oW6ZD3jiW7Au7q0bg==
X-Gm-Gg: AeBDiet53SnFrJVwXW1GNDOXk6zmzMBzRfjTNF8jC+2O1N2yu8FcoMKhd5fvGiSdDKU
	7jzG77jIlHbhahh0MpXRl/aLTUX0Fo8Jt2ZQCpwV2YnnmK1nikp++fgSKPOgEjUIZl1DuowY4WF
	FZYlWgc7Bpj8EB300MKk8daTOLhLbGwsua8Q9KuFLEVupx/FAFLWEdFaNDjDEYJJL8sRatPL+TB
	fpSC9rPQjXqWKvi2Ai1zJxu0tFPqV6VXROnpTcoRWPJp0zVZE73bakI//JLaZnZXWM1Jlju+of6
	dgKgpP0QUvP6JxAzCBePdpU/mWsHtuFR0xEtNDE3fwt7he1aNLWZEQ7Gc5VSW5/w353VrzqzO+o
	2E+C+sdqNufNlQhzpxVcO6ibFv6PWJUHeoRbSSMAV18e/cYzJVD54JbOkAAs=
X-Received: by 2002:a05:701b:2704:b0:132:1de0:1295 with SMTP id a92af1059eb24-1321de01ba5mr3350177c88.17.1778267119720;
        Fri, 08 May 2026 12:05:19 -0700 (PDT)
X-Received: by 2002:a05:701b:2704:b0:132:1de0:1295 with SMTP id a92af1059eb24-1321de01ba5mr3350154c88.17.1778267119163;
        Fri, 08 May 2026 12:05:19 -0700 (PDT)
Received: from [192.168.86.243] ([76.176.48.107])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13278210d40sm4131518c88.4.2026.05.08.12.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 12:05:18 -0700 (PDT)
Message-ID: <4e132e7c-ffa0-4954-876b-67b53870e832@oss.qualcomm.com>
Date: Fri, 8 May 2026 12:05:15 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/14] media: iris: Enable Secure PAS support with
 IOMMU managed by Linux
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
 <20260509-glymur-v5-7-7fbb340c5dbd@oss.qualcomm.com>
Content-Language: en-US
From: Trilok Soni <trilokkumar.soni@oss.qualcomm.com>
In-Reply-To: <20260509-glymur-v5-7-7fbb340c5dbd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE5MCBTYWx0ZWRfX9ILBkAy4OO/n
 czUHrBG1tyL+AyH/lTAGrj6Ure5aTqY3EX7gAsPcsbhnYEMoGbbOqg/3Yy/iT84F8uJnLbjCfVN
 tZRyIbxsqRTdHLFwjPX/+XGZIl1VHSOLgEGJ3UIPc7E+u/HzAG2KHjElwhVfLqdaM6fQR1qkgLg
 sjq7pNhlLo8uKMQEu7HTXmv14vq8G8RTtIf7POd1/BXvWcaP0EzrSYCVfQm6qby9AYiigiemWzc
 zTODgokZOHepH0vnNt/piiAA/18fe88n1xG6Lsm0itemAB6kSfZ3j4WpVL/EhTFIonYes3jJ7JQ
 0AaAmVt8dMP6mBg3SDdk/HrJiTc4LU33M+onT2NKlBdB2LTwnrWyoDk5mjIPOyLi+QolZPP/5dA
 FEmiz6idn84ZsZGQqB02ASk0QWrMb+VRu0BM8k9sd2mT3cwY4EH75rSCSQfL0BcChw14kswta7H
 nIV7ibos1/Lz8zoRzzA==
X-Proofpoint-GUID: juDnDGETLz9uQYkPQfFFydFvTjY1eyXi
X-Authority-Analysis: v=2.4 cv=JJQLdcKb c=1 sm=1 tr=0 ts=69fe33f0 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=lsoD3MMNObdLvy1227ExmA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=kHdJLIi08kw_CshnY8MA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: juDnDGETLz9uQYkPQfFFydFvTjY1eyXi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080190

On 5/8/2026 11:59 AM, Vishnu Reddy wrote:
> From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> 
> Most Qualcomm platforms feature a proprietary hypervisor (such as Gunyah
> or QHEE),

Gunyah has open-source version as well. Can we make it little less ambiguous? 

---Trilok Soni
