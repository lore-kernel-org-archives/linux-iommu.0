Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E73F3033C0
	for <iommu@lists.linux.dev>; Mon,  4 May 2026 07:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777880508; cv=none; b=lF5BvdsURP1DUNW4YDkqu7mWFEZIC6Ob4FSFBGJzbCq076mIHxnbUfz5BEFpRpuf4ObmEAjBO0BK+az3MRfKl74ukEJdKdsKIzXKqd5LRKKTjEOOUn1tgXV60H7F54ACFmGR6+hGMpLsD8y+6gp0kr5TOQjQ81eKOCwlLjwJebM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777880508; c=relaxed/simple;
	bh=QI33Pz7U9UhsDa9ZD1RZtVFTpWOVF15tMOBDX8QVH9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IaReicEo1ppjm7ndEmgtkBECTYmQpXLPyHmc+mPrrveD7uWzjLhzt3YXRuuhd9woAEPg8yf5pWGkGyYlz8RuedJ6rrRAO0pJKFFWa42+kS2seqvx9wN4JmeTHlLG2e+XIm4uKzLphSX02mOsuY/rL6OlLsa6RQGrw0GfMis9YqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lz4VL14B; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=chmtbeet; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lz4VL14B";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="chmtbeet"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6446DDdV2431707
	for <iommu@lists.linux.dev>; Mon, 4 May 2026 07:41:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g8ug/Zd9gtpfs2PpGhjlFATeBOiTKIDePAY4xdnfttk=; b=lz4VL14Boq9YDRng
	2rYZveYVby4c1eOhEMWHlRcgRi8n/ZhGlFM/eJZDfrqSG4gtaW0FUTUNzQaCK4Wc
	Hn++H3iqCnICWnLVBnTaq7dRhltDY6J3Na05nQbCruDvqb3tfOuzRxztXGe1fqf5
	Zust1XExI/dWQZCMVCKC6eN42UEgBRQAVYdBqerwh6pfRbDXkHTfhNPL0cjHClv3
	4Gkw0EiHNzEVY8x1ChPmfKK0HSqy0zhnBNZ/zTOfNS1efQm51+pdcRgTMdZukBsv
	YBHZqOHRzxi8Yhx/jl9+x6aHclcmf/MItRMgaWPxGQJOTXQAozZUhEXWVDJ8LOfR
	krsdrw==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dwaj7cqkm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 04 May 2026 07:41:46 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-575296be5b1so30281e0c.0
        for <iommu@lists.linux.dev>; Mon, 04 May 2026 00:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777880506; x=1778485306; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g8ug/Zd9gtpfs2PpGhjlFATeBOiTKIDePAY4xdnfttk=;
        b=chmtbeetp2YmKWblH30HyuALog/yMu/12kVKK7iaZ3QoTOLZrNtBSs0muOXOvnvZGo
         xZzNEjAVHQM31X6TutSJ1mrlYsOCGT2+2J4z1SMfDy6nmQDu6Ituo9FqqAdE8uhkDpPs
         t71j4v6YN6gUsLa7AxKNSXK9knEnZLgvj6BnH2WHpXaX/C+b2WrDtHfmxbPdJjFSxgQx
         6g5i1gFqRufw7R0kdKRWCNyrc0dhBnGK3+1YxvheCkU9HgwNG2uuYAcLuqAu8t6592nG
         80m8/7sRp2E4IaloXXOip1w2mU15EqsGpWZsagoXslKMWviijOPWnnZhUD2H0zHITmYE
         oHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777880506; x=1778485306;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g8ug/Zd9gtpfs2PpGhjlFATeBOiTKIDePAY4xdnfttk=;
        b=J326XPumzAXsegtLdiNCI3vCbBeLWAos9oGmcKRabsXzkxYaITDNnFFHojbQCTNd5/
         sMJKAIbopzI5VXUlCB06XmJQ13oLMzl1yjOM5g4zICZWwoEXhbSgJlriVTYnsM1RYrlB
         sVyd/Qtn2e0RsKHwb7lKx3tllrLDQWTYqkgNHbII8FRHc4RIcqu90+71QMDGEvHasIpF
         unS+PytEmkXHMunHVU2Ov6cQomkmoUu5aqxet6Oo4Q2dtICFszVHAQ/WYxFmQTEUyNRq
         A9EE8+UffX9pWyG3u5+If6p6ptGk3cDCSBXv4AiuFtXNJONARESHDa1kma9C2JomFxBq
         UjbA==
X-Forwarded-Encrypted: i=1; AFNElJ8NtxB8Rvb5OQmJQlb9dA0hsCUnr9oB36j1vP+8BTvrNXiTbh7RXHnxCoEbjU8qkYOzbXk81g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKsRUleCgc5KxixzLnZQqez2NmZ4YlEeAK6pFdyHClChW/QbvX
	0rOd239UP6U1JAnWbS4Gt/nad9X9hrTu6aom1TeojGfJmPt+mGsYNYii20cajV7BJvKvqbKfpk4
	c6lF3tYyjFSuGatCce09UyqH9Zpx83ua718wdRWYt8rFK/PbMRTK3n9utrg==
X-Gm-Gg: AeBDiesZk94mt/P+fLk6l7lrjw0QQD344HBAA4RDm9BgHhlN+OHuIQ8VUXu91HW89r8
	OmsDqIp5QaIRl/X9twI9QCNZXAb9Y510Pakw7SaJFq1I49BaaVlPjT1Z8BUeWhgIzkbZvEvQkre
	FBEt4YNaumxMzvWfHGZLTD5EL8s9UZFWZhu2Ca+kxGWd6AAuIc3Qm1K2+ZP5BQhPWwovwj9l0UR
	uy2I56YjIcizSxBsdBAasN1xWNTGAiQOc1QhF44rtEjaHmahlBsFPRXZxnOIeIKgJys1TFybN11
	DQmUS6n31zKXRyJKyJVyyB5HO7fR6RtK6v9Tob3yTFFSgT6RWYEQTkYchCrAnwxl3ae7vfVK/AV
	cb8XYO1LN11sjGdttiNUXAdt2F19+HwKLIMyNR8/BEjVeosV81WzxeX2c1aeRLdVh648nySXXPR
	xVuzzo3EcykROktA==
X-Received: by 2002:a05:6122:41e:b0:573:abb5:7d39 with SMTP id 71dfb90a1353d-5750c6aa09bmr1061243e0c.3.1777880505448;
        Mon, 04 May 2026 00:41:45 -0700 (PDT)
X-Received: by 2002:a05:6122:41e:b0:573:abb5:7d39 with SMTP id 71dfb90a1353d-5750c6aa09bmr1061221e0c.3.1777880505049;
        Mon, 04 May 2026 00:41:45 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bbe6da73a9fsm361006666b.54.2026.05.04.00.41.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 00:41:44 -0700 (PDT)
Message-ID: <bb8353fe-29f6-4902-9c7f-67ef61676f2b@oss.qualcomm.com>
Date: Mon, 4 May 2026 09:41:40 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] ARM: dts: qcom: Add Samsung Galaxy S4
To: MINETTE Alexandre <contact@alex-min.fr>,
        Bjorn Andersson <andersson@kernel.org>,
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
References: <20260427-mainline-send-v1-sending-v2-0-dcaa9178007b@alex-min.fr>
 <20260427-mainline-send-v1-sending-v2-8-dcaa9178007b@alex-min.fr>
 <97969bf9-8eb2-4498-90bd-9973fb2bd638@oss.qualcomm.com>
 <edbaf71e-6a47-4294-a8c6-6b356bc336ed@app.fastmail.com>
 <fdca4d01-eb6b-49a6-86e1-b6d582af4ba8@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <fdca4d01-eb6b-49a6-86e1-b6d582af4ba8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Dp4NwLa48kP8cXAzTEhipzxBf8lxo3ZQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDA4MiBTYWx0ZWRfX9J09GxvB8A5o
 LaLpfpMa/8eOCW6uAA+HSHol+5833KhYRla0+j/pMFJcRnrLme2EdUVOdNMaS6h/kUgP8ROSulw
 IKqXA6v/mnAPFx6bOGlWrbvcFinPFtGRM5RP6Jv4ZZ3F1VG3B3SLvJVPPMPBD4idE+Mp8NbV8vB
 iJob9qWyOrCr1HN+iSMBAgCF4PMFqxkK9GkjfokF4UBGiQjwkD/QNPJmnGLq0v6eNeMu7utXU6E
 ZADIzgV4u3f3CKRt68QdIbQSkwwcXFPN44Cpikjr2E0cXfqgyzjcU4mr/BH7RQn5nU3kFs2N0Pj
 V+PrHopma3xqLANUU5lNrJzQpO6wPgcjlUIdSfBJQEp/x73mHZdCr3KkCbUXHhhmVd04iwfULgV
 nw72bwYeuw1ZTnAoWwcuPgXZrzjGjgpIp4XCcsSts45gudBlF3RvtMKS8G2Jw2ImLYHEHqRYaRm
 GgG9B7CccgW1byOuaYw==
X-Authority-Analysis: v=2.4 cv=csirVV4i c=1 sm=1 tr=0 ts=69f84dba cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=XNjK35SS1xEl92Reu-YA:9 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-ORIG-GUID: Dp4NwLa48kP8cXAzTEhipzxBf8lxo3ZQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040082

On 5/4/26 9:40 AM, Konrad Dybcio wrote:
> On 5/1/26 9:41 AM, MINETTE Alexandre wrote:
>> Thanks a lot for the suggestion, I checked the downstream board files
>> and it does not look like these buses are wired for GSBI.
>>
>> There, the MAX77693 bus is instantiated as a dedicated i2c-gpio bus on
>> GPIO 22/23, and the AN30259A LED bus as a dedicated i2c-gpio bus on
>> GPIO 6/7. The native APQ8064 GSBI2/GSBI3 I2C pins are different
>> (GPIO 24/25 and GPIO 8/9), so these two buses do not seem to be wired
>> to the GSBI controllers on jflte.
> 
> What I meant is that the pins that the i2c-gpio nodes reference
> are actually wired (inside the SoC) to the GSBI I2C controllers.
> 
> You'll notice that in drivers/pinctrl/qcom/pinctrl-apq8064.c,
> there are bits like:
> 
> PINGROUP(6, gsbi3, NA, NA, NA, NA, NA, NA, NA, NA, NA),
> 
> which mean "function 0 is GPIO [implicitly in the macro], function
> 1 is mux to the GSBI controller"

Unless you meant "these are indeed GSBI pins, but within that GSBIn
pingroup, those specific ones aren't assigned to SDA/SCL when
proto==I2C, to which I'm afraid I won't be able to find docs for (too
old)

Konrad
