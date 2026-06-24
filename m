Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612E63AFD0F
	for <iommu@lists.linux.dev>; Wed, 24 Jun 2026 13:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782307691; cv=none; b=dRhb0A0T79t5rZmPUpiTlyVg0CK7ZqmNv8kI7mISq8yjt9EcA0akBEZb2mTTtofvj3zhFk0VG/ST00AXMOjQBqQsa11AcW5weCBii+xAFFlPF10DXXXhwE7U0lwt0pFGyqpTMVKcFJpH4jZohH6/jGNBizc+D0FAxoJFXn3Ve3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782307691; c=relaxed/simple;
	bh=IYaiqSwkKhKq2oKq6noG5azMdI22xDjR53P6dIK4/TU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hwK4ZVpyPs8yDltrOvv7HD/Evd2xW1wYk/EH43/N8lzTx4/WRT6XXZZQN702sVW30PUuvAf/Atzc7iXjYofTxxckFLMo07v5imvpgfzEC0GyPdyL1keHqDk4Oo6grNpSp8ZYy/CQvfsHoxZamBexkwMk+ex2kxoAJ6/mkssa2WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iBbDXkoc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LlY0/fjI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iBbDXkoc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LlY0/fjI"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OANRTZ2501699
	for <iommu@lists.linux.dev>; Wed, 24 Jun 2026 13:28:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cE5e32Jq9K4Qp/o2vpwbsBEqdWa2a4rwdZ6gyyitcTo=; b=iBbDXkocA62hP9V7
	NbHB4LoFdsZiL2otz5aw3jzwrXx36qQLZWf7/vqCY2x8+EXDDjspyiW0lzLq2L01
	qNSr85lYtheKTlkoJtUG+w3EzA7m6cfsmzulBKT2E5LmCqdrgH4An3LKSyP66mtT
	WkyAzW5uyKBlbeXGzIG6s9lljBO168d4nYdQOPT65UjWBoExCYDVOmj3ZzJXjhd5
	o6uAbLx74k8Zt872yfh+XavqcKECFWsHcbWTw9awIb+E/jWYgjAkEXzTbBTiHBiy
	Yv5LyOxJqzMm5kaod/XTqQrkm+Wd06p4uZVB3OIIR+FZ9zfT6edBhphdVHYrb0ZF
	1VP3hA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0d450t6y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 24 Jun 2026 13:28:08 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51a07295d67so3472171cf.2
        for <iommu@lists.linux.dev>; Wed, 24 Jun 2026 06:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782307688; x=1782912488; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cE5e32Jq9K4Qp/o2vpwbsBEqdWa2a4rwdZ6gyyitcTo=;
        b=LlY0/fjITsnasU77njLQfuI8EeDnpaBqfCTyxvXoBsVLWBgVy3C/Lg79emv8117gFO
         Nev83M3opTRq0mNHEZdPgD2/j3JrdlukboKtdgvfsKb6t6H7QONM+6nPN7a1+vNBrSYL
         1f09V//wJ/gnQUVoWI5quwW79YSacdfhysGJyyl5xHIkpyAIK/oNBWnBMKIuOkfmdsz6
         DtofreJ3NBibJs92qjHz15fKDEmAf/tA5yAY9S2bZoli+oMJskLxm3khxMIPRcWIvJ0N
         0dzusr8auwdAMeAJNmUL6hgtFQKqDru09OvbTHtqIjKGQZryGshBe5Q41hkh1AjXF1C8
         feMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782307688; x=1782912488;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cE5e32Jq9K4Qp/o2vpwbsBEqdWa2a4rwdZ6gyyitcTo=;
        b=eHi08PBlEFQMUXuucM/XvaX0Z9kqJdFMkCqkQcXT9aKAWF7AS7xLFNfC5TMAY5lCC5
         msid6FwfOBi2eEasZIkSm+XGFQnm9hHoWzJxKxyuZsD77MGyXyGTJdezlTNPavzEku3y
         V9klxtfOqbWExXAZ9YvR03flXAEKRVtehI9ckFK5UeRLgvYbt+VY02ZZ8tCaC6OYzLqu
         KloQsBZz+Tnwc63oMxICNJwjOV4JOLywA9HibiOeJp7M0WlWWIng9pNf5sbDNu25YH0p
         vmOnGgCP8RqPF0WBCUS+eP1AX7EEcsI9lXm4BaWuiTdElMo1La71NuN0aqQPc133n+kZ
         9p0w==
X-Forwarded-Encrypted: i=1; AFNElJ+br7u9rmaa+2ET/cT4+d99pfLIiqziwJnTVPOR5wzRpW31tq9WoudnEE3tm9oMMc1EV7SbmQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxytHB/nbgih5WtZfe5JI/4VFlkwuNZTkHtWrn43SRUMxJf4+r6
	txP4jsQ0BN3GVBzyhzTeNaXQm27oaEVJWvL93XAjkcyLu5Q4CvHIWwDK1coc67DQY5y+9bDVLrA
	WTfePupwoIhH9eaMccqsy7qKbEe3wiobFsftC+4H7ELxuwiKXb/vaaZ8Zbg==
X-Gm-Gg: AfdE7cm8IlUwYx22fyfjC1eO9dz5RlWcqorRE9XKD0Q9Vvk8x3n7H56oWqEcpEQveSt
	hBAjq2T614xRrKQkwniqGQr/FdkrCclZDyRwvW13rcO4zuqzHuePDeXrr4n79WN3YBlXYeUqVeT
	33yyNX8Am4NFg5GiIFqsLhddVqhP9EiTQ6mGCJxHajEdSgSqQBgCTKNPqWyvvpP4obm2hvzuH9O
	1HeRJSRy4KDjSHCaCH1XZBAzjpDgqrexnYwlew+LrnAlRQVg24ec5mhJf0YST01FgWiVPZFH0At
	SE8zKrt/O511hFFInpaXigWgjrFdO93uf7i6t6JD71vxznMh0iJHSNUloVUJtkY85obpnx+xZro
	zEzH0vhknVXfLrfVay7B9jfkBIGJsxpz5hfs=
X-Received: by 2002:a05:620a:3185:b0:915:8197:4490 with SMTP id af79cd13be357-925c95b2466mr942762285a.4.1782307687811;
        Wed, 24 Jun 2026 06:28:07 -0700 (PDT)
X-Received: by 2002:a05:620a:3185:b0:915:8197:4490 with SMTP id af79cd13be357-925c95b2466mr942759185a.4.1782307687275;
        Wed, 24 Jun 2026 06:28:07 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c60ac7c1bsm661168166b.33.2026.06.24.06.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 06:28:06 -0700 (PDT)
Message-ID: <53cade89-1fc4-4ba7-aa7b-815b9e26d88b@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 15:28:03 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] arm64: dts: qcom: sm8450: Remove unneeded reserved
 memory nodes
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
 <20260622-sm8450-qol-v1-2-37e2ee8df9da@proton.me>
 <e1e492ab-884e-442b-8410-cc100c54fd5f@oss.qualcomm.com>
 <6123a923-21dd-4f69-9ac5-02165963027c@oss.qualcomm.com>
 <b3541802-3035-40ee-8327-a65bd5d2dfee@proton.me>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <b3541802-3035-40ee-8327-a65bd5d2dfee@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDExMSBTYWx0ZWRfX54EElrp6pEmp
 K6QtJxe7KNwIN607ZYyIjHfu6TzpUnSKhGRuoEMdEPAF8CrZ2LKBdb+0xwlkPhf86Ga4Yf8z5+G
 I/YdbviKjI4RkWf6EOC0Qkjh/cEw9vQ=
X-Proofpoint-GUID: hicPTrW3LPIuZDoW2CP9g9k-tnwwaHbN
X-Authority-Analysis: v=2.4 cv=Ar7eGu9P c=1 sm=1 tr=0 ts=6a3bdb68 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=oK1bmnR47wnCuWhRGskA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: hicPTrW3LPIuZDoW2CP9g9k-tnwwaHbN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDExMSBTYWx0ZWRfXzhblT8Zn9r0y
 eGi2eTMFc9cDnslqIK1quzxPEyZpEdX2iUXySgL7Q65/TjM7Sk71Apx4SEvzYxzoIjNi/OrWpsW
 FnAP4c6oynUgtzYqeIa+dK1bx93fLheweN4vnJbYYKuo7zatZGqwwx4f7fuTRlL40YjcIM/i5xa
 p27TfzOgR5iS24hKpPK4x7ZGTpoD/j6sVyoyRtc+Xyn4Pilk/lRMZR+1ki5XEhyUGp0lWiRg7Iv
 gIV/jynzHoBjRPskfVzjZtnt6A4192QLophWi9e8FlP3CZvEA7NuT80N5vmxMPM+5MAq6zmu0Q2
 SqNwIPaE5kDfMzBQaia4CSoRPAGDPc3bxWqmIZmf0c1uJ7Ucd1e3wzJIVjLGIWg4KNszdPt2BGA
 tmJ3om6EbkTZF+mKRz4tRPKwJkxvUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 spamscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240111

On 6/24/26 3:26 PM, Esteban Urrutia wrote:
> 
> 
> On 6/23/26 7:03 AM, Konrad Dybcio wrote:
>>> This is mentioned in the memory map description, but is not part
>>> of it.
>>>
>>> I booted up a 8450 HDK and it doesn't even have MTE, so it's
>>> probably valid
>>
>> i.e. it doesn't report MTE to Linux. I don't know if it's Gunyah
>> trapping it.
> Then, should device trees delete these memory regions on a case-by-case
> basis, or be left as is?

I'd delete it and reintroduce as necessary

Konrad
