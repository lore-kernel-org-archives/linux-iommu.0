Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7D333E37A
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 19:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783972227; cv=none; b=XfruXya7T1kAWBjylJVeaHPJOjgvPc00JYv3aXZXoBPeSYrQvnNeKeVSZdQAljF3eU9eA+73FYkEq7eJH8luuJ6mRFcu46RmZKnYVyin2L7tuYpMrE//NJg976UN+cR64AEABncUXyC/A9ukozONWWsexmtI4+Ap1FQmHguMNng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783972227; c=relaxed/simple;
	bh=Za+5766RAtEJJPh6njpQsTKgzNJxRSFfxFO6pDVF9Ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=or2LU9OHhupxLbzCGKWJuGuBKX2tq4H+80ojnk0FwZsV0Ol0q/CW4cEywVdksuwglTIJPXqsvx+6bHKU6yjym0BYn3gF+mivXipXX2l5tVqCkC5XYYgaxJuWCyy3ZoP5wDRt0T0xGZ9mLXtGr3H9GPCzIMXcYWkODQx51j60DH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LyBk6hsU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WH7gJoIW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LyBk6hsU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WH7gJoIW"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DJ991N2519250
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 19:50:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2ucGZQxg2reJFI939JSAKmdJkAoKn8gx0mJoRPr4qic=; b=LyBk6hsU5QfSEQIl
	a7iKaaVJ5egLKv+CBOviDq4gAmwGWqnQFRWUdVXsrX8zU2EvXLEiI0U3NkuXTQB1
	5XJrafTzPcublpd/6SMcJd9MpBINSDU0ImV2FVCq0QRMZKUUFTm1Gdv3lR+1vD2e
	ibmSEsZG9iGnKsHvxw2JdzmMOIAAy0KolV3IbxmFe5PTM5no8OE1IxDcdkhMldRp
	Cem6cuxLQeiuu9BmOsMrOPW1XbChhmz/FX/W+FSWa8Q18kT2W41Mbih0RZM0er3s
	ICvrBCD6y0CsVOMNM4j7L4tqvce9Jc3bgALNRi7wCk3OY56Y3NEZg7FEHzCZW3fw
	aDwIXw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44crk3h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 19:50:25 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c9c26587e67so382698a12.0
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 12:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783972225; x=1784577025; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2ucGZQxg2reJFI939JSAKmdJkAoKn8gx0mJoRPr4qic=;
        b=WH7gJoIW7ZuCzvOZ7KIQA5GNFiDXDkuff2VZmwUxtSAvBuhoYejQdee9Ze0W4fl3u7
         yuep+dKQW4fRqG2QNhZEpZFse9fmJrHi2eLzBqyq/1WflYk4WsMcG96yzwwTOb51i9cU
         cypfseCDDBw34wC3tIv+SxR+OQE25+VTLp2X6mdz7QFE7JWf52YiiMriq1GK0HAY+UTP
         Sx/B1jWYeAhzlwIQFb+8PyFw/kBXz44JyQREPjZCx6eSFjo3n4pLbIIxSGEdsRmeQhRZ
         VKKcYqg1RFvdonIv/aaysgN3e/Oe7Y2flPQENDxTej3B3nzOqxwePxhenHNBrpnh46zK
         nIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783972225; x=1784577025;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2ucGZQxg2reJFI939JSAKmdJkAoKn8gx0mJoRPr4qic=;
        b=fCWXKGByGezTbcP90AOC6meVFY2RJeL2KPRvkXCvxt7GT0lOdlmWDGGod8Mbl5ph9e
         I4bnUnG66uMfo0u5JLgDvNB7EXa/KPakc30E5nFUvHMtXmk9TJ0iEB3cwk8jCKlsLFip
         kfNilF/nKZ9hVwLdQBm/V3bETu8ceyIrpsocUBzv5CRG/uCjQ3ZQaSsiHuHao0lkmuMr
         XuXrJeyj1fOWHaobhCpXmGJL7xYCywYGYFdSIndGwFYM3G3QTgFSHilMP5lLGzGshx0y
         r2sPBSI6NKSfkZ+zrJgUcSCiOIvxg3gkdiN6bpX9UANZgrLTibDu4Is4VIE6NBJIjwHb
         6iiA==
X-Forwarded-Encrypted: i=1; AHgh+RrCyuOTn2fFcQED3h0xA1OsGMmIVEEq7PtCAepOSXPN2uLZ2Hys+s8CoTod85XNNkVEcdu0Dg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywpj96kFA6GJN/ODoe+VfXQcLhH1n/hE75KSkO221WK2d1rB5T3
	jeG4Vx0RNMVBvKz4uDx65dEE5BfoNYNGalxe2AsT7PUCslbU37kI1O/4bpIlMIVzD4ytDeep1Cm
	JWQGnW9qjzs7iX+OMQhluq/frE1SVHC1Jn21FISM0ZHd9AnekaNqDI7tgFA==
X-Gm-Gg: AfdE7cnXbYPyI++6mCJbllX87HZoP2NiXRdcR7BtlJF3H4iq0o/1nc/JBDNFjQtHyIk
	9HrsT+U0JQC+Fk/k5ChK/4HyJMGXk8tYyRz2UuMUzPlP7q84rlEWAkqE321PX7D9i3S3edK4egw
	9n7ilZ4K75mVG9b2eiTapXVYDRS+P66tmNKSNcIXeheXnC8AaubmKmo+jT9om0euI4ap94StxVO
	3GnehwLfzepad+JQCOLgd2f82KE4UdKEXTwbUI/fUUlsb6UXImxP1jfMMfPXUbYooNbRzhb5kvj
	zmr3gUeelfuDKKSXeh8D6qWte7u52PlC9eDueghRAx8p0PksSAkiUL2XSGyjBHl3TV41YllMtTp
	MwoTWPfX3LLbotVA6sh0GKLSw9DGvXDfkzJ8=
X-Received: by 2002:a05:6a21:6e43:b0:3bf:b7e8:68ab with SMTP id adf61e73a8af0-3c0f08602bbmr16998104637.2.1783972224692;
        Mon, 13 Jul 2026 12:50:24 -0700 (PDT)
X-Received: by 2002:a05:6a21:6e43:b0:3bf:b7e8:68ab with SMTP id adf61e73a8af0-3c0f08602bbmr16998079637.2.1783972224229;
        Mon, 13 Jul 2026 12:50:24 -0700 (PDT)
Received: from [192.168.1.5] ([106.222.235.180])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b924258a2sm57081837c88.1.2026.07.13.12.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 12:50:23 -0700 (PDT)
Message-ID: <2d9d6724-a3ea-42ad-8cb3-ef08fd0882be@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 01:20:13 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] arm64: dts: qcom: eliza-mtp: Enable Adreno A722 GPU
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
 <20260705-eliza-gpu-v1-8-c9f1354dbd29@oss.qualcomm.com>
 <clfy5lvz7vm3ogw7pvyyidiujqcjxftx55p67szwgc6ivsq6r6@xrrcbfdkqkjo>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <clfy5lvz7vm3ogw7pvyyidiujqcjxftx55p67szwgc6ivsq6r6@xrrcbfdkqkjo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 4aCF8pR3tQtwwb0PcxAXARDnjT3BpJmC
X-Proofpoint-ORIG-GUID: 4aCF8pR3tQtwwb0PcxAXARDnjT3BpJmC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIwNSBTYWx0ZWRfX0j85w4aj2/a2
 TkhVxyHOwK/K/AHvbuj0ZGzEJsd8MvNnfB808QsDVHctpWBxCKfccjKMUyIVZqDvMHlLY27ZrZd
 RsDaZIhkK46YN5NaX4ktdwpD2hl1FYU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIwNSBTYWx0ZWRfXzgnaYSNNfiiW
 9t3W2G73GYM01S+KnjgPx9apEF6B5RLtYc8NlpC4ns+87lz6VdJnVJ1P5sAK7M+X6IE/XoYj9Tw
 4ZilRtP+3UTRt7TVsHS2XeE9D07GpnvC5Sh97fS+0miUOYIP2wh/AAgIK44rJdNLO2F6N7U8/eF
 GGWXYBhef3hlKDf6/n3qAqvdrEqK24hkBoTeOpmKbUjoJD+K47YlwveSLBmDTLvNGhzI45JCn9P
 2a7NTh0J3tEflk1TYJzyLyb00n2IEQhYaCLzS08196V9vTZ/diq6tRdVQKzX6CSxvMhsndgApLy
 S3IBDFfvoV1tJA8ujrTngEuANyV1IP78g6bW5Yg08uPSLxpLMIsqzhtiVJtXWE3rC7okdNSc15L
 tl0TtFg7DOFYRFsjvJA6IQHwZM5+iwLD3P2Koxa3rc5UomexCD8My2qh8YqafoEv20tH7NhNIzS
 ufs8jtgLP62M0vC6x9g==
X-Authority-Analysis: v=2.4 cv=P84KQCAu c=1 sm=1 tr=0 ts=6a554181 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=yNfbWwvibup9Ri9izU+P7Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=JoE_KpbED9LNO2fW3XkA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130205

On 7/7/2026 3:53 AM, Dmitry Baryshkov wrote:
> On Sun, Jul 05, 2026 at 01:44:23PM +0530, Akhil P Oommen wrote:
>> From: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
>>
>> Enable the Adreno A722 GPU on the Eliza MTP board and provide the zap
>> shader firmware path.
>>
>> Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/eliza-mtp.dts | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/eliza-mtp.dts b/arch/arm64/boot/dts/qcom/eliza-mtp.dts
>> index 1374afd9d14e..b280d8e845b1 100644
>> --- a/arch/arm64/boot/dts/qcom/eliza-mtp.dts
>> +++ b/arch/arm64/boot/dts/qcom/eliza-mtp.dts
>> @@ -417,6 +417,14 @@ vreg_l7k: ldo7 {
>>  	};
>>  };
>>  
>> +&gpu {
>> +	status = "okay";
>> +};
>> +
>> +&gpu_zap_shader {
>> +	firmware-name = "qcom/eliza/gen70e00_zap.mbn";
> 
> Should it be gen71700_zap.mbn?

Downstream uses gen70e00_zap.mbn as this fw is shared between Eliza and
another GPU. But, for upstream we can rename it. In linux-firmware, I
will keep gen71700_zap.mbn as a symlink to gen70e00_zap.mbn.

-Akhil.

> 
>> +};
>> +
>>  &mdss {
>>  	status = "okay";
>>  };
>>
>> -- 
>> 2.54.0
>>
> 

