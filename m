Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6629F4A92D5
	for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 17:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789149214; cv=none; b=s1j8Nstd2rN9GgUfrW4KTDDk7PAi95tL9LRWAgRR3qcns1tYXbMsRWOy4yqYLjLnk42VixWid/hRUu5igwujxuSQ88JJ5w/HCDeEqFGNGsW0BRvmi9MDbuXqWBUEIuNxcin97tVw3mioqMYEGB8oIoghSQX9QqLbhrP5gRKRPOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789149214; c=relaxed/simple;
	bh=8eo278yP0UbiWY/1X6osihtpgSnzn78n6QOTLg1L1GY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rWWTxye78dUTCJ56X9bYE7MRTk8nnznSEuYUbmq9Bj5T6nXsulreZSQuE0svW/oVvFHe+QGQ19bmUT4Jc20Ufd483qgPb7fYzU6Su5YtCKbKorSUH0BmEWABWDSD/Z6SFufRxEahOYJNUyYT7/8/j5mDltbMHMsVnmcQHeroyyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cCa5p4Jk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b4e8lht9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cCa5p4Jk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b4e8lht9"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BHWaGS488171
	for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 17:53:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4OoQhFEnhOfNhViKEsSDPMJo9+bfekumVfJ9cT1RTvU=; b=cCa5p4JkND7TYbm4
	5hjEtneqcApAFC6sxeONvum747FQrypYk57CFtTWfgAU+wcYuA4/FoU9ynMfeGmy
	51uUoQJSRxw63U50bCVSSuj60+IT7oqA+fxQxxeCZZuKaAs6FtwzQkHZoH3nzvCc
	a/LqDhy4gtAvJEw5riiYarlYrXwI0w7r21AD97o7dfz6NQ5Os+N2FrqGEuubKTCP
	yfPaBSFjpNLkBBZ569wJJzv9q9mLKj0q3pfLdCFetQGaI6U6wryHIrR3nlN+6RG2
	XTwrf2CwUD8m/yo7CDxPdo9EjW88sQ4+RiL/60xlUoXw+JxnD3W/0okDiDur1/47
	uD92nA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmm1e8nb5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 17:53:30 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-398d7e0f3b4so1645303a91.3
        for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 10:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789149210; x=1789754010; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4OoQhFEnhOfNhViKEsSDPMJo9+bfekumVfJ9cT1RTvU=;
        b=b4e8lht9DrXyYkRp+Sa5RzTsTH3ZuETft87ewXH02FmWpeDOS1hlTFoCcaESolubuk
         J57eT3F97+HwKDfWJqvtun0khgtZunhD3BCe5g8+h924BjW3ZXPsi7v/rVAlrGCYgzfN
         LCc6g+/d9ymt+D7cDYLgpSu61jg3BN873cJaZC3d3QFMuBYIBpGK/q5Cs10PG7Z2USvA
         nkYuHHuDzjIzWZ/QSwXVd58hpGuIPH3iB6zT2PiX7wlR9/OAhysC86BDY2A/c2T1VkB8
         5pfJMrgZE+h4o2LqHRnJZKII0GtzAuW+Qr83Hj9DgewokLabsM6wLb0SkxhmqjimZ7V+
         5QUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789149210; x=1789754010;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4OoQhFEnhOfNhViKEsSDPMJo9+bfekumVfJ9cT1RTvU=;
        b=jC2ohLg0KArdHyNMAp5hLguKJLzTd8YbFFrekhkydvYy9VZvhZyrH4gIC6K0b4W8aR
         cCsYahdlXM9WH2HqbGExM091+a+wNGUK3tq46woz0iPInKK+I4Tugt33Ink7RssBqYGB
         e4w77DRIrhGgom/9Ybm5QyAeqrUmYsaKb8Cfcx6GXpg6ulrgoSTmIO0uN3Hn6CJTQ6wf
         Kq/Tb/Zvg4ozO0M2OAYrjAnYNX15WDLQeAgM4Fe9w9hslFsThthplOFJQaaX86zS+YLu
         tioWa1snjFmmItZtzggFpdUrC/fiBtK362n8ZozD+ZaNTnPanEH7al6t3kUeM4Ion615
         twuA==
X-Forwarded-Encrypted: i=1; AKwUvByRLPBE/H31tn/SQv7noE0qRbIQTg9+ro0OvFbz1nrOaTqLW4XPmnZDeVeBG/On1b9SAb4AvA==@lists.linux.dev
X-Gm-Message-State: AFuF++lpRlozuYB511Fk4isr4JmoY8dpuA757iu755kLtIEL+pXnqlPj
	E1RCpoJQIOJbKT5wSXsfkLaajdu/XosmtOKF1vltGtpHweMGLUo3diUClcS3+/GxIezR8pN1XyB
	+WC2rwiwZsWv4TQmt9LGTHfMs/sHmwLXcGRpiDYzXtOGuzZnJooX8TKSEQQ==
X-Gm-Gg: AYBFou0Q7k98/RVDKZRRck2YEjTi2vO+daD1rqcYc0eLRvU3FHkrPYKlAS7qoyvCu93
	j49MoyiHiKtAMjAvQZ+70QdzfJI6VsQBcsklpwRt/QwaOa8VsmDRKjsDcZb+/lqaYqM90Q6gH3Z
	AlGJQ7GPAnUmGHL6JdQCRBrEgOjBEqpn3lPZDARowY071EKQJKkbi61tP+VNOGL6uhBuTIRzOWC
	FTcuOxAgE7CYQNgA5b/pPM10AZ0BTepE5J5MFK4pfmLIUFdeVigwaEa4HbpspDLYc4Q/E2S9zcM
	x/tbqUvcoDeywktaBnCG5+nSjMHotfklcVf+dRkO0rCHX1zYVSSYvuRnBz55rP57AkBTMRMBOa3
	DOFA+9GcHGuTZvmquNadt0iBsC8ntsgljZ2Y=
X-Received: by 2002:a17:90b:1d45:b0:39d:6f12:fd47 with SMTP id 98e67ed59e1d1-39d9c215be0mr9518601a91.20.1789149209928;
        Fri, 11 Sep 2026 10:53:29 -0700 (PDT)
X-Received: by 2002:a17:90b:1d45:b0:39d:6f12:fd47 with SMTP id 98e67ed59e1d1-39d9c215be0mr9518526a91.20.1789149209152;
        Fri, 11 Sep 2026 10:53:29 -0700 (PDT)
Received: from [192.168.0.172] ([183.83.137.104])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4ed64fcsm9168666eec.16.2026.09.11.10.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 10:53:28 -0700 (PDT)
Message-ID: <d1cd7692-6cb7-47f4-a086-c9ae4a826171@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 23:23:18 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/13] arm64: dts: qcom: monaco: Add Iris context bank
 subnodes
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio
 <konrad.dybcio@oss.qualcomm.com>, iommu@lists.linux.dev,
        Daniel J Blueman <daniel@quora.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
References: <20260909-vpu_iommu_iova_handling-v3-0-2fe43ae45495@oss.qualcomm.com>
 <20260909-vpu_iommu_iova_handling-v3-11-2fe43ae45495@oss.qualcomm.com>
 <20260910-mottled-tody-of-discussion-2ed66c@quoll>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20260910-mottled-tody-of-discussion-2ed66c@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDI1MCBTYWx0ZWRfXzHYhFBnRPOUf
 YGn3FnEKvFCM+yUaHsyccOkwKEcGvuQdtxBrSgDQPkNL50qz2sPHXJh+j3l9+HdmSB3YW4lzt6t
 ulAM0nGpr19ajlQ7URxrrFQ1TpmfTEOW1UqBv4/tKjhIj1BzBGhDiflKxsOxH/2N6evAzoPfFw/
 8GbWJdVhqKNeQWVQZENMQagvOkPPtzbv4meBUe17lSkS/IQLSG5o/Wv4qRtXZptaQtEKG/qkan1
 4rXZTqz6SPIFlGc2PHyIXDZXHzC0FkKmnsnFQaedSNU5OM+2iAG5XPnV/ch1A5MaKAUf7IJBEc0
 tpuZ6E9TPyRt0DixGGMrLRpUGuX8a6kF5vxEpECg6Pfz4+kHqg9Gj9n5gOJALHUjgH6990umoCx
 XY2/Hrxdl2TO1ZK/NUj6vIUqlv3hwKaIF/F0aSsZHWI9wyoEa5R+7619+GDWxV3efVZE3jkh2SN
 09EMb4jzI7qb0x2TzUA==
X-Proofpoint-ORIG-GUID: F7kCIbyOOpivBSo3d20A8okA1U_QQ4X_
X-Proofpoint-GUID: F7kCIbyOOpivBSo3d20A8okA1U_QQ4X_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDI1MCBTYWx0ZWRfX3HQ8PMNDN+dD
 EF17XDj79xXALKKZMfQ1yF200JKp7kl5XsWJ6WHEOYQ/zJwZTXC5UP1bOI5d9/gDmPMWkCHu2Tb
 +lJsqf5J5JjnirvW8MBzC4EmEJ4U+lQ=
X-Authority-Analysis: v=2.4 cv=LrwHWXdc c=1 sm=1 tr=0 ts=6aa4401a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=TwCXObd+TJU0JWB7kQOUgw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=t9ty7G3lAAAA:8 a=K3eY9hOJoobCHU9vVZQA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=Vxmtnl_E_bksehYqCbjh:22
 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_06,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609110250



On 9/10/2026 12:33 PM, Krzysztof Kozlowski wrote:
> On Wed, Sep 09, 2026 at 08:27:18PM +0530, Vikash Garodia wrote:
>> The VPU issues DMA through several SMMU streams, and the hardware does
>> not give every stream the same addressable range. The non-pixel stream
>> cannot address the low 600MB of IOVA space, while the pixel stream can
>> address the full range:
>>      +-----------------------------------------------------------+
>>      | non-pixel stream addressable range (600 MB - 3.5 GB)      |
>>      | 0x25800000 - 0xe0000000                                   |
>>      +-----------------------------------------------------------+
>>      | pixel stream addressable range (0 - 3.5 GB)               |
>>      | 0x00000000 - 0xe0000000                                   |
>>      +-----------------------------------------------------------+
>> A single "iommus" property on the video-codec node puts every stream in
>> one IOMMU domain sharing one IOVA allocator, so nothing restricts a
>> non-pixel buffer to avoid 0 to 600MB. Once an allocation lands below
>> that boundary the hardware faults, which shows up as unhandled SMMU page
>> faults and spontaneous reboots:
>> https://gitlab.freedesktop.org/drm/msm/-/work_items/100
>>
>> Given that the address range restriction is for specific VPU stream, it
>> should be ideally be moved to that stream. To achieve the same, a subset
>> of streams is now represented as subnodes, so that each can be
>> associated with its respective addressable range. The design was discussed
>> and agreed by mainatiners here
>> https://lore.kernel.org/all/c7b956a9-d3e8-4e18-b780-5d08f5cd2ca1@kernel.org
>>
>> In the past, this limitation was addressed with an iommu-map approach,
>> with the iris driver dynamically creating the devices. That approach
>> was later concluded to be a hack to avoid having subnodes, and was NAKed
>> by the iommu maintainers. It was discussed in detail here:
>> https://lore.kernel.org/all/c7b956a9-d3e8-4e18-b780-5d08f5cd2ca1@kernel.org/
>>
>> The video-codec node includes address-cells, size-cells and dma-ranges
>> to declare 1:1 mapping for DMA translation to the parent.
>>
>> Tested-by: Daniel J Blueman <daniel@quora.org>
> 
> I do not believe the testing actually occured, except some case, so
> please apply it ONLY to the commits where applicable.
> 
> I already asked this at v2.
> 
> If Daniel did not confirm where this was tested, then the tag DOES NOT
> apply to any of the DTS patches.

you are right, it was not clearly confirmed where it was tested. I would 
drop the tag.

> 
> Best regards,
> Krzysztof

