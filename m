Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5B9495514
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 15:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778858920; cv=none; b=IilqkpP5aSc6x5V9TpTr+D+zBKPqfQUgXh1IIyRPPLZJOjL1gUikyqs58/W2dNtW0/Vwsah68HJEIkSuAiuXa92KPGYwj7DfPc8ba651Et0kpzTvHCZ5MzPgTIwVPMjSy+Ov68yhtwxZC2SpSPpWBi8USLDxR0prOXePut12g0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778858920; c=relaxed/simple;
	bh=rc3/KQHbD7iPq+RAzZOqNKPnZqPEf5/8Mos0tvVnP5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G0A7AkNwqKXmbW80kuvsNy6MwYZF9zFi4nS9sWsWfo0c0dJiW6/aL0MoYNtllWT3IITvTIKiK91hjL0hRycXDu/eu/lHzOB+0s9WWO5sKtnn55dD1i829K0nnb74RCu6ehofr6J2xhq6VTvAgz/QnzX/Qwbgl1xBmYXIxMP+iVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c9kRNYmB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=chWq+09r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c9kRNYmB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="chWq+09r"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FBWxru3197600
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 15:28:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yBktAiJ2n07zR7RbDMF1ANnkKUO8hFQpm7YthU0eIUU=; b=c9kRNYmBGZKoL+XI
	isAGNqehczL0RMyfEb4Tbcj4gpmN4O94rcKAM2rtC3bbCccsaQcouXz6PNzKyvVh
	BsUvQRgAFkzsk4P6mtENc0OmiHELEiN57g65kaIRBvWw4IHHpvOhRd7aTcdfvCo+
	Ot2TLDbZQwB9GKp/Ha5TWY2QnWvYo7MGJ/BO3A0MqzeUgEGOKjba6CJkMFaf43HG
	7BTGQJm54l707h6oYErYK/j4yY6FlWGLNQJ8OsafxWWPMrXvuHVQ/k+4JrYP3GXk
	kb9LcgMtKpay9aGTiKxHjUtppk92NEX5ayohUTTgEWQ/DeSZWCr2FbpZDdGMZ8ti
	BCAAag==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1qbtug-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 15:28:38 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c8279604464so7566914a12.1
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 08:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778858917; x=1779463717; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yBktAiJ2n07zR7RbDMF1ANnkKUO8hFQpm7YthU0eIUU=;
        b=chWq+09ruCVo1RXTbDP8vlro07Vbun/49FTxmjSntmUIA2nPr/WRaBJyehmRBa8EZx
         tVBGnq8UrQZJMMul9QJv8BxSI6WCnpSQ/+CekEw/pPhzmDtOFTaRgQVwH9XQKNdBMKZU
         twlgU5wzuI1QMrJD1xmc0JeHlY4AYYmnrMLUeYZjXY58TuNRHScZg3HbMVoldy5KisMB
         ySdMS42TwLxEdnjQWe18+/NDOuhOOpBLXcrjBH62KZ5VLOTeRsWO6ihCeVdzt2GPMyT6
         zsKp6xxu3oMEhPl5g4ROsrJzj0HDwUBNr6Ybvz8yfoHW4mizq7LRPjSts69wDE0FLkO/
         qDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778858917; x=1779463717;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yBktAiJ2n07zR7RbDMF1ANnkKUO8hFQpm7YthU0eIUU=;
        b=B+N8hOZZnm9KY69S2hBkN/T/hvjQjnkkO/UqWa9U81Z1vPg7hcnx+caDNTB5L0v7M6
         3mYv4NwgLsEFSg6nwp3LHa7xsM9GNh4YrhuIbTmtKKwx9XheDy2yO/Ptt2Dv8JHe5bk3
         i2HWbJNL4Fnho1wa9aAMxDQP0iPwSDt+I1fO6u5nF5Lb/esHH2F4OmhbvCX006NupH39
         4VS43WJNV72kLfmqlizpvDBebF2MnvIVyyE9MpyMqrz7GOGyiSXWk0zrhvYyJ8S9e9+R
         R8O2d6Wr0uXGrSv5t7OlrJsxGdslmQ7jBJOOSLcqO22dBYKNDkZasbmE6Zmukl0bky6F
         w9PQ==
X-Forwarded-Encrypted: i=1; AFNElJ/C+gw4IxtgtRWKi0Alwn94sMWmiT2NPQP7BK9nHhwsxk7AgVGuhCThSzCH47h75PqvPTIK/g==@lists.linux.dev
X-Gm-Message-State: AOJu0YymA5hjPI1Kn/refLTPsOku3+jhur6Tb/GNOvPGeJxsudaly2ni
	eMMvA7ptZD77OuC9+3Huh+7d3yE469MeT2+UjzBPKmeaO+FDDsKKUrrJB+fJeZEh3aUz3LnkG3k
	WSNrcwkkB7VOWh40oLcYrTwYIUfKPfaiJP2TjCvyMkER/HIZR8W+02/o4PQ==
X-Gm-Gg: Acq92OEQhiD2QatjOWhBuNea9f7nYuV6cQtozvjuTTtIEbvS34dCMfyYHafq51iqgpQ
	hZEuGh+m2Ic1/gWVFw06YbS8xQzwBmjusOh/IAPN3vFG49ptijGA2YQNaRsBsGKwuKZlRk0+zU5
	Mw6gio6I2+ITiVCi5+oP+AZXzdOduWz0xndKiVqG8UM4C3GzJppbTekpYzjxoX7lPXP1C7wl04p
	pVfTOz+1rskMzHMUZxVnbOOG74dK3hFTvGxNgx2b+q0X75F68wm3P7t+KOyHjRNihGskjLnOaNx
	kOZ270fW5+LAqL1NsPtDEHjPAbJNL2mXlgKELhbLgNVwtXzQdjEq3jveHkHVBeZeUIO7hctH9yh
	gBZfvdKiauUfv0OX5Edl5mE2plH+QcXorPfrSSy9Dluyan/NTNwLylvMsB920+I94iYQjS1EKVz
	0OIw==
X-Received: by 2002:a05:6a20:2454:b0:3a3:addc:8f47 with SMTP id adf61e73a8af0-3b22ec64553mr5222447637.42.1778858917398;
        Fri, 15 May 2026 08:28:37 -0700 (PDT)
X-Received: by 2002:a05:6a20:2454:b0:3a3:addc:8f47 with SMTP id adf61e73a8af0-3b22ec64553mr5222414637.42.1778858916923;
        Fri, 15 May 2026 08:28:36 -0700 (PDT)
Received: from [192.168.1.10] ([122.164.84.236])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb123986sm6209094a12.32.2026.05.15.08.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 08:28:36 -0700 (PDT)
Message-ID: <cb78b09f-e3b9-40b7-84a5-8f9217f4fa6f@oss.qualcomm.com>
Date: Fri, 15 May 2026 20:58:30 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: arm-smmu: qcom: Add compatible for IPQ9650
 SoC
To: Krzysztof Kozlowski <krzk@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260512-ipq9650_smmu_binding-v1-1-04defdaa140c@oss.qualcomm.com>
 <b8f02a31-b175-4dc2-9b2a-5765774b4d88@oss.qualcomm.com>
 <39588541-b6f8-4697-9787-4b42df21156b@kernel.org>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <39588541-b6f8-4697-9787-4b42df21156b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 031LYzumgLooIcQuvFLXqMbv6NAiGS7-
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a073ba6 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=pcck7Iv2+kD8UxzcD71x3w==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=skYpixVSqG8Zg7K71KQA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE1NyBTYWx0ZWRfXxM4752xSmf9a
 iVzJR0tYP7+azuilNhcDFl0yC19GHg6BX0Z71g0cDL0kjum9zZN/7feV6LyDHoWE7PsdWzwds0e
 DB8qTiddgVdnYYSXO7n0ZL1KtDzojzGBUCC8YE7Y8L1zpWv7H5146ETPN0P4dxcO1VjgKF71kTw
 TtvnTRb3HaPjvZQh96c6OiIGWRWdDbdTkFY132NzSOZXhRF+A5aSJvaGMzniofGGff0yA4oMvfP
 b+xk86WMkkx3/zFmiQTZvjd7yxweouvtDPQV6Sl+4kdumooQkdSL+RNUa+27GhGQibllCmH8bnr
 0X3RjkvrUymBTfZ9hn++wWwZQOAulRyemaL6hmURa4Gu2RMGcMiHQgvydWIseLZN0Og3Pa45rWq
 D5moRFPhLjhhDHLYt/avoLuMhyV9SUzb3iuKH43ChejywJ++LNUbE8PUI5IoTlk/iclTWKBM5YU
 LlAbgK0oEJ1sp9xpWVg==
X-Proofpoint-ORIG-GUID: 031LYzumgLooIcQuvFLXqMbv6NAiGS7-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150157


On 5/15/2026 8:46 PM, Krzysztof Kozlowski wrote:
> On 15/05/2026 15:30, Kathiravan Thirumoorthy wrote:
>> On 5/12/2026 12:17 PM, Kathiravan Thirumoorthy wrote:
>>> Qualcomm IPQ9650 SoC include APPS SMMU that implements arm,mmu-500.
>>> Document the compatible for the same.
>> Kindly ignore this patch. I will repost along with DTSI changes once it
>> is validated again!
> Preemptively, I dropped all your patches from Patchwork based on earlier
> comments. Now I have proof that I should be doing that for future as
> well. :/

I understand your frustration. Apologies for that. Please note that, I 
have validated all the changes before posting.

In this case, when I was cross checking the HW doc for some other 
details and I noticed that SMMU interrupts are changed and HW folks 
haven't notified us. Hence I wanted to re-validate the change and post 
it. I don't want to change the binding (if any such case arises), hence 
requested to drop this patch. Hope this helps.

>
> Best regards,
> Krzysztof
