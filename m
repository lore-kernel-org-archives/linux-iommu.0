Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA4837A83B
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 09:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783070605; cv=none; b=aEg+AucETyEIIIt3Q7z13l5MtmnsC4xdSZ3kRUVcN76JtVGwwWnSHslOoHN9pKYnwsWohioKWv+/50y1xi3OFtmLD7gTzuZ2xlHALn2bBvoYdQIVNaXmJwd0Qn4FHnAS7SjM4vFN98HqHVYRyswnVMpnAs6chdt7TIQ1YnKG5c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783070605; c=relaxed/simple;
	bh=D6FyfstTISzH9+nCkYuJjjuigMmR9dmkecqosBg370g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EnJ9MY0hfk0OnWbNHs5qWpDtgugA4aDfSZwtuJnGDbXaQv6X+x0+xcdKHCP9aTduFyH8/AVlKD2cCL82Ewvi0lUgkNrImIrzTjhwQpKcztZ1N5UwNa74Aef7UmYmHxsy7W9ggJdLh852SoNnukkqcXN6nwl67U+HYW8tauW6DL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JXm0VbVG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DNp89iOD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JXm0VbVG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DNp89iOD"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6636hN9e3144575
	for <iommu@lists.linux.dev>; Fri, 3 Jul 2026 09:23:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NOw/y5u6kP1EYPo+p71lja3UI5ENfrKWunho0Mw4UtQ=; b=JXm0VbVGUgl1DN4v
	Aocpo2T7qOQBSC+5Dm7ZAjfcEVQEHjJysI4lzG5vHRl8gWBXW0SMBRLjabn+gzp1
	LmM2ZecDViXL9GOw51Up0vWPGMQZ+xesNb9YVItRlH0RlOxbEdJMI56p7jW3xbxL
	j9qmhgWsdArGlvMC2tq/pviwt23W5T9IH2u7ukReIIEoe/o/9YDhWnvocMpcxkm3
	H4LAv3SyQBDE+u8Y+4ayG1/Vw1kDaNj34nmnSCTBxe3TMDrL/QEtFZbRjPF9K1A8
	HNTL4grsDMXDOyXpSvjXSOSoIF5DRpI4mYJ2B3jlnDh1PwxqHEHewegGljBFN1Rm
	NrBtIA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f682brk9y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 03 Jul 2026 09:23:21 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c7f385887bso6873415ad.0
        for <iommu@lists.linux.dev>; Fri, 03 Jul 2026 02:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783070601; x=1783675401; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NOw/y5u6kP1EYPo+p71lja3UI5ENfrKWunho0Mw4UtQ=;
        b=DNp89iODZ+gkgV2XijQHvud/kxL/3WXpR+yon8HmAcUFrgOtVRhIq69HY6V/3i7Qed
         uihTOU5XcR98OFEuGEzGTIJeteR2DFH43IWZPfQYJ+6xSM8KktUsAdt2RGV1eyKMQV5/
         MyldUdb8cBNJvtq+SiCqPT/ELoqTqq0PLO63qjVr8gcIc30tgOmGuHItB2p1R5Bs+Vh4
         PmCXtbPGGFNMYzZmJyorZt9UrbusdsY7uOVQ1ChNDERGZpqq66li7phNfsHcITwxHt08
         rDoVP5jXuhPkWROz8hgOM12baH2njBAY8M/J266rL20H6ao3G0S/xsIXrWx/F1fDHDFN
         j73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783070601; x=1783675401;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NOw/y5u6kP1EYPo+p71lja3UI5ENfrKWunho0Mw4UtQ=;
        b=YRu2DsZiojqc/azaZ3HJ92AFGwd5QmPE5VexpgjbCzZYydhp5+PYAGVZHRACcW7TWw
         Zp3gzE4wU/M1JRmDF8P+wLp5ACC9nDYulFgwVA5VkDRvEqllEB3JUn/8dFzpTMzMDyNc
         KUOl+GGXvZu7GNZyOSA7IEkb//qbjOvozodWg3PouEFxyt50uIc2Kp5C2dRtmAfXP1Cw
         oGODOxv2Nu1F0Xgjp2nC/W1Re6Cbn2IfmLc5ETc3GdY3qE+pOfEUnwmdhIgDeqMkMCqS
         UJMBthIPycSO14h+gPRt2WhaBjqRbxCdhPxIzFHJRn9X7jzZp/UEHgl0pkMIbLF4K3ul
         20zw==
X-Forwarded-Encrypted: i=1; AHgh+Rqzo7M5BWIiiFZ9yVM6WuoyePaoBVYjIx9pWuHzuGMR5PiOp1L0rC1OhvpPPbqTToGRD8dyCA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFZjnZXpgh+3oN2s/Kr9CuiZhKWTnC9dqz8X1aoV8CqZgOu4LZ
	RchPjjnvPzk8E5T0YXgMl2D4OIzxTa4CYidJ8bFJHKb3JTv9Ir//N/wyuPXqSlYSobkGQxQBIw+
	3NP1ptccmwtWMll9UmZUCPPFok1VUz17izl72B2B952uUaEMk/pHbVFS66A==
X-Gm-Gg: AfdE7ckGELhFcQs6+UsFTu6utkZzLQTwGWDR3nPtExZyUbFI+o81wNJOBknGuRtOoPz
	Tcz1gWvHSE933Ft8bw9RXs42nif8b1Fz/UdWmlT+hTb1KZikpxNUI9VPcM5j/QCBXO8ZBj2Qde+
	NxbCRqIycgtkOu1vlOs7fsRTUeQ8jXVuvKZBblBmLrxOPt760C7x81qwMh1+kJpFBf4Rp3ykbx7
	4LlA0wMva0vOdfleoZy/RfsuuS7VrcolaDLIM6kJWlEftr9dDF8/oISXWyzp898Sj4zIAmVPWCa
	gR2n/4lKjqQgZadCJYRbwQ9cDwm+vAvHnvHwIvPKYt0ZBCchFCWm9CUQ2c96uKThh8cYT74MrV7
	01vnPF2fhE70Pp/xaZB/8vWOG5qgccTLsBqR9X7s=
X-Received: by 2002:a17:903:240a:b0:2c6:c9de:cd0e with SMTP id d9443c01a7336-2ca7e75afccmr103763995ad.23.1783070600758;
        Fri, 03 Jul 2026 02:23:20 -0700 (PDT)
X-Received: by 2002:a17:903:240a:b0:2c6:c9de:cd0e with SMTP id d9443c01a7336-2ca7e75afccmr103763625ad.23.1783070600307;
        Fri, 03 Jul 2026 02:23:20 -0700 (PDT)
Received: from [10.204.78.119] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad789237bsm6382845ad.71.2026.07.03.02.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 02:23:19 -0700 (PDT)
Message-ID: <c72d2ac6-b1c8-4c96-a0c6-eafe18147ac0@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 14:53:10 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] arm64: defconfig: Enable ILI7807S DSI panel driver
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org
References: <20260604-shikra-display-v2-0-b3c1b2b67edc@oss.qualcomm.com>
 <20260604-shikra-display-v2-2-b3c1b2b67edc@oss.qualcomm.com>
 <0bbfd60c-236e-43e5-a150-93738961f3de@kernel.org>
Content-Language: en-GB
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
In-Reply-To: <0bbfd60c-236e-43e5-a150-93738961f3de@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA4OCBTYWx0ZWRfX7jqA3+YefMP7
 KrsWKeDw84WFgA+meo24HN7+5F1FI73+erHajEQnwgykOihvblLfEZKDF65C/atR3027x/4E9/m
 x4/TM8NLWlieHouSHwR8k6LizUvmZNVs8UnRbtAlu+nwNfkz5YpAHBbW+93hVEi7gmOFdXnKWQY
 bvjlQ/DsPuRedv6+at2aNj3eMqkdPLPnOtF9TR4DhQ16exvY4U4fBZdTRyjXLGXd23Ks9nfTwDU
 /1MASoCpkWoj7eYJjsOA+19cGu94scSWsuoEpEkNixa7gPTx1jPA7LfMEYsIYxTIsxMl52Ppbff
 TjemLc6B250LVdTbDNKN0bc7YeRouulGpgQhCWm2TYwEbZvVTppQhJS0yCVhHJEhbQ7Rvg0zmgb
 x7FWOQ3JiWRDhtpM2zML2l9WgiCtTOgjMxIhgCqQoFoDmWwc+Yd9FsDfAyZuOTroMVRtzRYYA9J
 5431tHt+ihQD/jKKe7w==
X-Proofpoint-ORIG-GUID: 4_WW-ULN-DKzM2JIkIrtjVT_fjv_3vJp
X-Authority-Analysis: v=2.4 cv=cc3iaHDM c=1 sm=1 tr=0 ts=6a477f89 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=TT0SokwCUCox7tJrE_AA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA4OCBTYWx0ZWRfX/suUjzY1cYMV
 8wJc6NeeBLP8vKCreBe+ez8GkmbsBayUJsvKYbuNITKK0ob+fZTKNcnaYe2eWx4+95V8mch2m1K
 Rag5W2NokPdJAHOy9eW439jEe7p0Zi8=
X-Proofpoint-GUID: 4_WW-ULN-DKzM2JIkIrtjVT_fjv_3vJp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030088


On 6/4/2026 6:23 PM, Krzysztof Kozlowski wrote:
> On 04/06/2026 14:30, Nabige Aala wrote:
>> Enable the ILI7807S 1080x1920 video-mode DSI panel driver as a module,
>> used on the Shikra CQM EVK board.
>
> Does Samsung Shikra CQM EVK have it? I guess no.
>
> Best regards,
> Krzysztof
Hi Krzysztof,

I checked internally and found that there is no Samsung specific Shikra 
board. Shikra (CQS and CQM) boards have this panel and i am upstreaming 
for the same boards.

I hope this clarifies the concern. Please let me know if you have any 
further questions.


Thanks,
Nabige
