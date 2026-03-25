Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534A03DEAF6
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 15:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451472; cv=none; b=g6WTXFTZKfMgL7AjulLc+BmaO92uSZziK5AVB+EncTnjsV55hHMolV5pjNVjKghZLONJKA2AfX70eWYnMvJh+4LHGpwiXE+qsbAFdo1C1UeGcM+TR8GVPmhr5Q0W29yguKla4z2/lc26sDuA7sdnvMp8WxmZ/WLfAgfoLzye8WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451472; c=relaxed/simple;
	bh=5YXZAMuhAv9WIGptBrNb0UA7Uho52stASuF9QrHVfi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OEuf3wiU7h+rRFqgE/sFO1Vp4Qenxp8s0H+b7RRvsavZvsd1B432KZgg4qMQRzYrBC4FSf0Q+f7spP+amhhRUxC4XakEWdEaZSgKdbuU+0VTxPbZtmFs1oHdh1R7G+pBsFviETeGNbQwh76b2/a39OM/dbyQOGPdtTvbaU8v2OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MZAEc28/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Pvp42cC0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MZAEc28/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pvp42cC0"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PBGcqW1626551
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 15:11:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p/MED86hyNcrAbl5YZCxGVVNAkPNVeuRHWU9jWYdAHY=; b=MZAEc28/Fylae5kh
	ZHAzIG6me6yMJVAHJUesiD5+qJyLvYqOCqyWf58Gj4oG4Tqh5gsC951JO8BWY8NU
	mBfbiaFt7pGuJ3oiMxGPpWP6cKOaMF/FrueH+AEULVu96axtmAj/r07QSgdxHT7l
	hWlcNS/7jQLUpu7XhVManmrODFllkSo16XIRtbT4UBlC4OGVA2YYYBZW/MEkcvN+
	/bIJ4jUZqqKlryKg69TXUjVMmTn2sxPGq4wuZYyWS2tEKZXnYvPrYae2TSUFIX+2
	TD6NcoJWePs8B+rf/HRyFDSGE/hjfWvbxh3og7vvayWacCVJudhAMMSEI0ENapbm
	yVDV9Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d489wja3y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 15:11:10 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3568090851aso20275098a91.1
        for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 08:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774451469; x=1775056269; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p/MED86hyNcrAbl5YZCxGVVNAkPNVeuRHWU9jWYdAHY=;
        b=Pvp42cC0qCnNIcepFI7Uq9/RpmMqEtXvmb85tXTrRbUSOW0+n2I4taxI0vAqXttqBT
         /7Ct9NkoAWnC652fkEL9QurrN1OkF/gRntjBmRIzOOUqWWYzKpaOnWjtdjpMTErB6C4w
         68Q6SnsUsQ3RBSOJaurFdytJfga3S6r9Lrp0auWOtJd1C+PyDfPExYHIcsGpDB6q8k9/
         djl0YIhCMENoE/t1nopCfmZ4QMhJC3f+NbVmLH3+NxXpVVkp+TzwAFHlJF7A1jCPc7kC
         ILpDm76MKlagze7XMvPqo5YVxw+105e2gSgtQaySoB/9gqgYbNVHzLET4mTHiJpSaJNI
         WLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774451469; x=1775056269;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p/MED86hyNcrAbl5YZCxGVVNAkPNVeuRHWU9jWYdAHY=;
        b=E4iGSJTdhHaI+G6NXCf5BU3RIX+tGcbVE1f0xOsMLAMjVSFnh888U09+gEZkkd9X+5
         bHJzHgz8g9JH6SH/fKMcGWTlrNxxN+CqKVDRwRMv9HkDRMi+tuTf/ZjXjlNU/hfAspea
         3lkwqS2jBIRf3euVEmfEnCQiNLLi8To5wfzaSLF8l5woKjO/3/5ibrE+jjZz0FrIxWhz
         Vvzz9+pPcTK7cErux2CrH57JSoGNtcFlu9V76MoJcm87oRnaJYlhnI/l1DEiKT1/60jG
         dHion9QoUJkTz/d0T1rEtK+i82cQ+72/5aHDCxnfaRmHo4HJGTzslMLz67rguDb8++bZ
         cZjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcKjIrng8fEzMWTh3Mp9zHAyLpAJkHEh2zNeITnnE1R/8yN8y4LHj4Yi6jLOb4k7JKFoHjcg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwQv++RWi6mwO4jf4hcMTgeuuF8SGN8y4KGcNmfTcpnRHIvfcmA
	o+osEUJHt6Jg+usl3qpAbi1Cq2JvvarCJtntbIU9nL9tw44NIY4bW19EbBjHbfgQb4F2aZJaymT
	tWjw2xUsBOlUZuw/SR0HE/nuunGPBXfW9btl57kTtLnFOpfLRK0fbIK8GpQ==
X-Gm-Gg: ATEYQzzS8diWfCpqe6VQnfqEDZBD5HZ1JPypp6693bDFv9zNJhbD4pVNrrg+WKqi+xu
	FNbR9LIEQaLqMhP6Mx5XGNVb3oEN9fNEkHuGEXCyMNu1hbTiZHQXRCjXpS5jd9WkVLEyexqrPqY
	3fWJaX+68eLylftEfO8HX+sJYWafSkDS2V1fDvbW5j3NeSaleWvxRRL1bV/wWOU/uT7+FKxGWJO
	i/s9YOyDbeiGaa0K7hORqUdxJwiO/Quholbu1e4DECsJuJKu0mzFzymR31h8ybImsDYD0KU+sfu
	OifRBbUf+Gj9stHIXyg1kTv7Elg+igPdHS0TBoYayv8LW0BgUTD+To5PWWr68C9p4reofgSGiwr
	o534lPFQTL+Kxcc6CRkuKivW6/dHrrsKxuZzaUDjG1ozpSsl+3meF8g==
X-Received: by 2002:a05:6a20:958f:b0:39c:1f90:284e with SMTP id adf61e73a8af0-39c4ad3a74bmr4220704637.53.1774451469066;
        Wed, 25 Mar 2026 08:11:09 -0700 (PDT)
X-Received: by 2002:a05:6a20:958f:b0:39c:1f90:284e with SMTP id adf61e73a8af0-39c4ad3a74bmr4220627637.53.1774451468518;
        Wed, 25 Mar 2026 08:11:08 -0700 (PDT)
Received: from [10.204.101.77] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c766e9758easm1193710a12.13.2026.03.25.08.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 08:11:08 -0700 (PDT)
Message-ID: <39d765f7-ae0f-4ae3-84ce-55b419ba3969@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 20:40:59 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] media: dt-bindings: qcom-kaanapali-iris: Add
 kaanapali video codec binding
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20260313-kaanapali-iris-v3-0-9c0d1a67af4b@oss.qualcomm.com>
 <20260313-kaanapali-iris-v3-1-9c0d1a67af4b@oss.qualcomm.com>
 <b4115d76-d3e0-4f0f-8ec5-697e116c6584@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <b4115d76-d3e0-4f0f-8ec5-697e116c6584@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: DjzJN4QxuBFakF3zCDM_7I2egmy8ck6I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDEwOSBTYWx0ZWRfXzF4hXbm/qYTv
 FAbrUHPg8c29t1N+6EeC1rgZAZvhVhX6pRSx3/k7q4Bwjr6ShsenHHvC8tGiQNgOoGpLTyIQ3Tk
 Y5THB67KcY1FH3Mvx4R+L4t8fPGrZCvRwjPIGYDN48zGGV9/JE4XAiKgalLAZVKD7TQ8vCcbRnG
 xepK63M7hc/o0uuJY1ZIqwXl/IewCAiruF0fknsQBjNfQfc0R3G/HLWYbemUbTv41x0FtMJgblQ
 HP4W+ryzfH3/GJ4l/W3MxbT3DPDd+ks88cNOsnwQQDNQDj4fTyBenc3nll7dC54M0At1iK+NlUx
 XSgjqdmqQB75ZvKrhE1Xl+4n0Kq+M823qX1NE9/kx3pYQa3KQYpl3UVUlcLQss9tEfe7ZEwQGVt
 4DefUKnmQQhKMDGMxNaTOt5Dxah7GAKIk/QVAwQutQkTroMjTAWEge4csntZkY7ENESfuXwqY9j
 7ggi7hJ4LlmqejYgeAg==
X-Authority-Analysis: v=2.4 cv=e/gLiKp/ c=1 sm=1 tr=0 ts=69c3fb0e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=DtSqZenC8O3uiLbdm2EA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: DjzJN4QxuBFakF3zCDM_7I2egmy8ck6I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250109



On 3/13/2026 9:13 PM, Krzysztof Kozlowski wrote:
> On 13/03/2026 14:19, Vikash Garodia wrote:
>> Kaanapali SOC brings in the new generation of video IP i.e iris4. When
>> compared to previous generation, iris3x, it has,
>> - separate power domains for stream and pixel processing hardware blocks
>>    (bse and vpp).
>> - additional power domain for apv codec.
>> - power domains for individual pipes (VPPx).
>> - different clocks and reset lines.
>>
>> This patch depends on
>> https://github.com/devicetree-org/dt-schema/pull/184/changes/d341298d62805bc972dfba691da6b3b62aa3ff15
>>
>> Nacked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> If you actually implement my feedback, then you don't need to keep that
> tag. The tag was given because you were pushing your solution regardless
> of received review.
> 

Noted.

Regards,
Vikash
