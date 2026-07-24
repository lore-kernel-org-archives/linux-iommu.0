Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931A240244F
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 11:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784893010; cv=none; b=Ijufo1ymZTZiw+7Y1En86ZgajA0OP5YOEhWluperq0VjZEu789uLx8sznRTiagSdo6VHjRU8C/oHQFsiuHzQb9wKdJPtwCKv7Qu4u7R5cE+MX9dFtfMcStJERjMMBxI1jkWdllDeplfxxWbzaFO0A7riCeqcD9+9JkI46tM91s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784893010; c=relaxed/simple;
	bh=lXxs0CZ6rxUSFR3HmEQeb2UDDzWI+tDVu+RHPZ5dzJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eSUFfbQjKtWYafUy5metuKSH2SPLIeS7KNQGby9ZnOwmiIM13w8hPcnXYh1bbQQvQabRKhcQHfcuJ7bCdLjXJKbxNkPuwcCisq19+Zqjt76USxz0yHCk+4ZES3mbkOmqc1QjfB+cCr0OqaMRGy0XkRC9WSw02dL8DUsD6XD8fio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TY+g7MU2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DJs6H4NU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TY+g7MU2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DJs6H4NU"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OADx5e3032522
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 11:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MTHkZkbsC7pZb0dSKl6kRc/qxWFTxguyGDt2nRbO8Fs=; b=TY+g7MU2OjXqdfaW
	L9JF9viidT679LOWsPu5p9/dKGhzbyz98zyt3F2n92ll6hsAjOMPQVxirYq/p9Cl
	R7A04mEkUKP8G+djCg3ueSOVwHw4aTDjWHrf/3ynjGHN6/l/fzK+Ayu0PgD9avDh
	AfgtkuZC8k8iHQKCzU4zDWQ+PjHw0Sgj90sKo9UvTh86ZG9EZTatQ3F/lV7U3MXJ
	0NbuaOtxUFTcjA47ZSjbaQ9v/nq5Q68bYEJ+Shda5vzjbhBc+Ciu8ThzpyNSYFJ0
	RRUMbZ/VSQnj15mDS1pEEWOfoa53ZwwzWtPKbaG0cOBcPdraUAsl9z6jy0ICdsg0
	s64J4g==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkqa0bjes-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 11:36:48 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-ca8aee88725so559802a12.3
        for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 04:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784893008; x=1785497808; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MTHkZkbsC7pZb0dSKl6kRc/qxWFTxguyGDt2nRbO8Fs=;
        b=DJs6H4NUE/pVEQH9L9HrN7IbX9YzDjeGh6O4U68mf+o4bAJdVzhDTBw79y3OBhqKC7
         O6Ey0WbWXSPo9T7HdaGCYi1lc8slm/HMw15sl0qvlctUNO8d9nMT/t6aOghStK7W5/Rz
         TspQPjxhnubQ1W0J0jRYjuUPpwvxunBrX9xqkjyiF2+GDx7+eCpMW7NC3Jgk49Hq7NVj
         Wd2bHfkmWK2Sf1CoKih4ThtQQHhjfTpKZWaWle7lWXr/vjVeJiD529hWnwKZXdjFGoX8
         jc/VHLYaHdKZJhC+0e0Jh8VE+wB5Q7b/MYbbujX/iDM4q4AwOcaAn0zqxBTXAeDCzIa5
         3A8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784893008; x=1785497808;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MTHkZkbsC7pZb0dSKl6kRc/qxWFTxguyGDt2nRbO8Fs=;
        b=kU3skxWuRHShueJdbwLmm4drk/PGVyuLoB53DTKx7rlt5xKrI+GALVKDTJ2uzX5jRL
         aISAyoTGe13WZxttLU4nUUvZSdQi0FIDd4O5A2iSYzgRBssdHAqdMWh65Gw0KJ1nfLg0
         8acSDNf234TCwvHoCpIK8sPl/4riqo4LuHo7apvRa+CfVjV1IQ7xvyLKBk/EJgkY9YM2
         sp159O+pqgCnikF2jUuIXJmQMT0iy/rIPohzpSt9LntdeChmmCBA/VHDM4mVtc3OpK9j
         Cv2Lw0zxD+/C6kWsUaGWtJwKc6lcKofI9p9RSfflYRYl84hgps+iB9vM7nGkT1Zg/Z3Z
         HbOQ==
X-Forwarded-Encrypted: i=1; AHgh+RpEyglTLgigc19BuW/zHbilWcKIhKbgwOMmoj5bYLqVuM8GHBglxBKzefeYJlKlebVqKJgutw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyF2Z84gEZOYSRjkKVT5DDpY8H96I11xnXbCk9+qLxMadVZw9j0
	S7Z4Uy+cmn4//h/Ye+vs2HgXpL6rpWxLV8AN5JgEdh26Qgq47QeGTNnFoSmwztnPM+ZAIeUNFiR
	BNHzGx0FqhTrh4XfjmoeQhEStYxgmAEQje9IKSbs9xGqOOjzVGcPDAFnsFw==
X-Gm-Gg: AR+sD1179Ihs7o8r7i+BZ7AZylcTk2ciK/KEhKNB6ViUsLF5WI4iRUwStKb9sw4e8t5
	kboHjg2J0Ye8Yuu6XxBcyGcqDtcRgPs4rxOv9jc9/I6sGGmpPSgNIXeXqhOmIs+X9gzy9Ax/kCI
	raKb4Ozg6Ch/9n6HisUWLey4farIf6l+99wW/yQRyRtTPcKPkcPEYsCez76R4EJZkHt2E7ohowA
	qZlzmFt0L+zwI1sr58u4CDzOMQjyJsV5Wcrq4hw3C8INYHpQDLKnpQx2cusgUxdAzrFy4J1JHMw
	HzNVNkzdF9rdoYo5zH2VfnDB8H68td0Etl2AQFFOtuUcitaLIkU9/ssyQPU6bu17qxmfw6/jIpT
	sQub1YgY6sLtmnp38cXslofwhT35Jg+ywPJU=
X-Received: by 2002:a05:6a21:6f12:b0:3b4:5c70:ca3e with SMTP id adf61e73a8af0-3c44b01327emr8111662637.25.1784893008027;
        Fri, 24 Jul 2026 04:36:48 -0700 (PDT)
X-Received: by 2002:a05:6a21:6f12:b0:3b4:5c70:ca3e with SMTP id adf61e73a8af0-3c44b01327emr8111628637.25.1784893007604;
        Fri, 24 Jul 2026 04:36:47 -0700 (PDT)
Received: from [192.168.0.173] ([49.205.251.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147df06864sm30499011eec.15.2026.07.24.04.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 04:36:47 -0700 (PDT)
Message-ID: <accf8ee6-25c6-4bf1-87ad-d53a11c86264@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 17:06:38 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/14] dt-bindings: media: qcom,glymur-iris: Add glymur
 video codec
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260715-glymur-v9-0-8cf2cbe12a07@oss.qualcomm.com>
 <20260715-glymur-v9-1-8cf2cbe12a07@oss.qualcomm.com>
 <frmpjyrk3epa26oebskil52sony6k672a5mkcamviiz3vdjlj5@eenvztuikja5>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <frmpjyrk3epa26oebskil52sony6k672a5mkcamviiz3vdjlj5@eenvztuikja5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: uATd2cdo7Ns-g4ArS6jid5OZEIs7UHuB
X-Proofpoint-GUID: uATd2cdo7Ns-g4ArS6jid5OZEIs7UHuB
X-Authority-Analysis: v=2.4 cv=e/k2j6p/ c=1 sm=1 tr=0 ts=6a634e50 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Am0+rXbGVt9FyytbsJdRwA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=M1l8uzcFE2QXb2ngdGAA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEwNSBTYWx0ZWRfX0j1x+YfeqCnq
 3hJKOEeypbPHxtZ61scqbKTIMIpBFyHXSJAbDUxntC4m/hmkTKLXsqP2tz3T+qVSv/3uKXpbG9m
 zZ7pX20ZtYZiwWjMPNgqV6KdyNau+TcuEp6NR38bVgMr4zQ8/Bjy+hPbfHHgFGa9HzBN9j8ODNt
 l7kfy9Rw2PosefjpXkzMWjNfGeQLSxwMYmPATQCHK3F5iqM558+l2SxlfvMG7VUpkQvQ9USP51G
 RPB+g1IRWvWtkPpw5bkiONYJJiwlgTVeB0VP5YMm6B3/JMKA+7E2moJ4MJImjHh1jElsZRBPbSN
 9Me7THM/D3reUZkKKVfViDVtmGQsbd3A8XSl8Rb4yJUibPSGjIU4uSdqWL/JT93tvfH6JYjJ3DD
 jUvNs1OiXtOoV/VZDlho3vGnJZ73FNsL5tveFidEOZ2+4GSKiUT9Jmt+4mHWC107r6t9rAVRy9h
 EAzjt6IDp0tzHzAzUEQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEwNSBTYWx0ZWRfX1OgQcyu5lyfO
 kZ2j5NUK1SUBI1yWzRQgthehuUq7xPORsIiQrB4ifTs16nhgHQvRwCtO5KYdyUp/xkQwa8ekmlR
 BvnypbHIWX09m9O/dYmEwC9aWEi07rM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240105


On 7/24/2026 5:00 PM, Dmitry Baryshkov wrote:
> On Wed, Jul 15, 2026 at 07:39:55PM +0530, Vishnu Reddy wrote:
>> Add device tree binding for the Qualcomm Glymur Iris video codec. Glymur
>> is a new generation of video IP that introduces a dual-core architecture.
>> The second core brings its own power domain, clocks, and reset lines,
>> requiring additional power domains and clocks in the power sequence.
>> The current maxItems constraints for clocks and power-domains in the
>> common venus schema were sized for platforms available at the time of
>> authoring. The glymur platform introduces a dual core architecture
>> that requires more clocks and power domains, exceeding these limits.
>> Raise maxItems for clocks, clock-names, power-domains and
>> power-domain-names to accommodate the glymur platform.
>> The glymur platform-specific schema have fixed constraints for these
>> properties, so the common schema only acts as an upper bound.
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> ---
>>   .../bindings/media/qcom,glymur-iris.yaml           | 255 +++++++++++++++++++++
>>   .../bindings/media/qcom,venus-common.yaml          |   8 +-
>>   2 files changed, 259 insertions(+), 4 deletions(-)
>>
>> +
>> +  firmware:
> 
> video-firmware. Please follow the prior art that existed for venus.
> 

Ack, will use "video-firmware" while posting the regular patches.

>> +    type: object
>> +    description:
>> +      Context bank for the VPU firmware processing domain.
>> +    properties:
>> +      iommus:
>> +        maxItems: 1
>> +    required:
>> +      - iommus
>> +    additionalProperties: false
>> +
> 

