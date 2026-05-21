Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7DA3A6B91
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 10:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779360126; cv=none; b=FNc0s6KhWna+qYP5XURUVpa1kk4bzzbsZuw51caGO3XwJazBVS9mCOKvVRpnoHpqleCydAbYWb6hqB95qkWnhaNyrG1pN6w6JMDMYqIDg7pTwB1/zLfhaqhX69N3dEzkOTVFt8sVdIX/XGwJ+vGhMGPaEqwoYmOenR2Uy6fLV0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779360126; c=relaxed/simple;
	bh=OoG4A/nCjg1WGRfiXsW3OEJxdp06xTQX/WTx768OiUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RFyMu+39izqU6KNFVcd/GwYtaBZJk2LtRBSIC6c/vx1XamdZS8l8IFNCk4vv96uad1vBOW734lIFaBcWSgV1lZGH3n8YM5OxfGeaBnvmDVP7TV6ARLu7o/yM65Lz8HctqbAvjyvh5H9EzRMh12cZOwYV7PQB+qvTvDafGe+SlMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cDxGAXEG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QEO4SgYk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cDxGAXEG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QEO4SgYk"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L99nBd517710
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 10:42:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TRweg34KvRj4taH5vYY7egOAVrFdTyCDwa/i6eW97uY=; b=cDxGAXEGlCfUNI3P
	aRwNlqP+tB4kbW9UakvqPJNYMgSji/RS+EQEN1JApVu/K4ArR9yx6psHKUxY6QDE
	tihgbXOIvQgqDR+fqoMKMnqRGShIwLNxguMLXgK8b1dWBffpyY4z1EENWdVRJW0K
	sU1Z2NZVOOen1r7ZTM8e6gXHi2yrHQxFUbszz449NYFAwSPa2SMDCDmuFUbSvC/e
	PatLI1zpYDHHLs7cmVN32oecqbZ2Z8f5akQf+WHOdybc3Y6mpkKuxtcGxeIeE2Kb
	Lv2XiN9oLGC02ALr4PUE5jcKriA96rTEFw9sYjkTVRd03elxOIsnCRArN6AwmREy
	RMMllw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9saa1tv2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 10:42:01 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-91345d517bdso125398185a.3
        for <iommu@lists.linux.dev>; Thu, 21 May 2026 03:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779360120; x=1779964920; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TRweg34KvRj4taH5vYY7egOAVrFdTyCDwa/i6eW97uY=;
        b=QEO4SgYkF9pU3FD93Hyu+L+bGp2mJA4VB2YZBaRAgsSHvoNLeinsZNhQkctjXQxXmq
         tp2GFbsuuinALcYC5oANqptfjQii0ZLv8MkMlhCWqNdRtC2x5G1jPJEPkES+gwTj/qlM
         h1rOnAqEAV+JsLCm8z6uGF61KO/9+xO4Jigxuf8d32F76f07xhUlPYeEqF6Ye9RpMVF/
         jKRQVaFXxml+yy+oBUKtbQV/pGUS03UPVLwo49ZoHShIIO8JP8vMXtdj+eZdeThXoTyo
         Qgk1lwdLHsLR28Jhg1uRPcu+28Qt2YUM6N+zbwewOwz1aKAM4ItoyR4CB2WNvdUDbNR1
         cT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779360120; x=1779964920;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TRweg34KvRj4taH5vYY7egOAVrFdTyCDwa/i6eW97uY=;
        b=J3T1xDkSX06pTgPAM3aNcoP0brI7bU5RLk3NJXdbofNpUhIxzBKImFio9CCVLlS19m
         C+jP7gu3u4pI98acwtAiD2u+c/SAb04SnYta4dDzmLmrtXqF8YR0eYgIsznYP+EGV91Z
         cTUmjHc9DZThjcZ8LBtzsQ49TeaoH/cWYzk2P0mRmns4K3mSbNi/lh2JNyFFsci3IPYR
         5ec/MgdLm9NCsJUikQ7+ewWWqijhx7uaknbMAzaXUfcqOkQI4U5PV8ViIA2ryPNM3ve+
         vr41Si97fBF9yKDCN/XUjPterhGYCMdkbMGRaaD352TNIB5sUZQl555iOq/cnIkB4U5M
         wE0Q==
X-Forwarded-Encrypted: i=1; AFNElJ8xnENZVvXfwAJnWX0eb9YocXJjlYbqqI2bpnXXnEZ4FwWRs7CST56Qh7mnnC3rm16qeBcdYQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxpoWMYJaP4wDKDx+MmL4CnDrfnxEPNXuELFFRtEux6cZmIwL34
	gk7d7MbLnxOIf2EdY9BF4+4R39Xp4jz+sjW5ghOD2eYRaIIUiXvJLMUyo4hTGPr/uK/P2+ja56G
	B8KkeVM/LkoDpwHJuz4ZAxuYeDh7lkh3QzGDooIdsRrpS8TkaP/jls9OaNw==
X-Gm-Gg: Acq92OFal7Ut8xuHDPtSa/SH/U7wZ7GivSwoqLyj5LpcfBC/xbX3qzDkaZarxBB8qHn
	9VIH5c6w0tLTXc+YWYHJMCqiXpQUG66U2df/+/Rw41PBS+NYYJPwY1FEYADGxodSdy9lujwQZWL
	PNpBKBfmdb1uzUX9pb85OYfZuyv+sN6NDlFHGpWa+QkDPY3pbsqgADYpIvmn3Q5vj+KXtfvra3y
	Ohl6rn3hY5+rvjWvMpfhWzvM85P8G6/lr3i42BK6oVOWzE88+qz1o/T/c29rsZa2O8lkGu5HxNT
	Y59jCcLiOIy78GPCRQ1QJLjtCSnJ6MuboRRWV72poBoLTPxj9QGyv2e/a+uXWccwUsdGGVtIDPO
	/LW5dMBUnkcr3bqU/2TQaAb0ywUN1+ZkhD8b/wbZ8sPSVUnbPgn2+QsoPKmh7IbFbS6gc5lrAli
	HsyVeWBOoqx70hFw==
X-Received: by 2002:a05:620a:c45:b0:8cf:d289:d0f3 with SMTP id af79cd13be357-914a2cccdd1mr195784285a.4.1779360120569;
        Thu, 21 May 2026 03:42:00 -0700 (PDT)
X-Received: by 2002:a05:620a:c45:b0:8cf:d289:d0f3 with SMTP id af79cd13be357-914a2cccdd1mr195781785a.4.1779360120084;
        Thu, 21 May 2026 03:42:00 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68311670e02sm8737368a12.22.2026.05.21.03.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 03:41:58 -0700 (PDT)
Message-ID: <406514ab-bb74-4e5c-9348-64ededafa6f4@oss.qualcomm.com>
Date: Thu, 21 May 2026 12:41:54 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] ARM: dts: qcom: Add Samsung Galaxy S4
To: contact@alex-min.fr, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Guru Das Srinagesh
 <linux@gurudas.dev>,
        Linus Walleij <linusw@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        iommu@lists.linux.dev, phone-devel@vger.kernel.org
References: <20260519-mainline-send-v1-sending-v3-0-3dd7aa125353@alex-min.fr>
 <20260519-mainline-send-v1-sending-v3-8-3dd7aa125353@alex-min.fr>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260519-mainline-send-v1-sending-v3-8-3dd7aa125353@alex-min.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEwNSBTYWx0ZWRfXy16CE5iH7vrx
 NfTeoZv4zSn2CpLzFUWACO9gvPzk2CRK1jG2uFNr8bov4WPUGHJwrk4Kr/EdpFHDNz2bEeTUwKc
 zgr4EU+tYlsT9pbmTC0fY9Qw48/CFWA8gy43RKjz2Qiz1wDE1kuJPKJeOX/trBh7ALaPcxm4hc+
 vWr6UCAi4hj//1VsjyK/CgrGaE39EoLZLNAoJX2SY84+N0BaifMVRKTE5lqeA+yaHP84nxOq7Gg
 Nfwpb0d+Yy/BNnH3cxZ2QjxF19bDoOeMiNY+39UhbmpZZekr6xOgEIrrKBUTq/pdmoiisLvRhOI
 IBiTHMRGjkH/iOBauBOx4VXixwOFxhsuNVoNWfMq2Yda3TG/VeEPGwdbqNwi+c0CaTDGkCObW17
 uWR6Pubi5/oT6IfEXkAMlG8hIBvakKnB0rHhVw9UdJt6T1q/JbuyuEE2K2XAGKTG1nVm0+kAgyh
 c+cphTJwGBgLTyq6LTw==
X-Authority-Analysis: v=2.4 cv=Qe9WeMbv c=1 sm=1 tr=0 ts=6a0ee179 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=3BB4LYrPl4bHvSfQcI4A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: rXMhf_x9BEksYmRECIbE0jJg-F5n3w5y
X-Proofpoint-GUID: rXMhf_x9BEksYmRECIbE0jJg-F5n3w5y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 phishscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210105

On 5/19/26 9:16 AM, Alexandre MINETTE via B4 Relay wrote:
> From: Alexandre MINETTE <contact@alex-min.fr>
> 
> Add a device tree for the Samsung Galaxy S4, codenamed jflte.
> 
> This has been tested on a Samsung Galaxy S4 GT-I9505. The initial support
> covers UART, USB peripheral mode with USB networking, the front LED and
> the physical buttons.
> 
> Signed-off-by: Alexandre MINETTE <contact@alex-min.fr>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
