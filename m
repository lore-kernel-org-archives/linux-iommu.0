Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795001327;
	b=ZShzQvxq/brcQbrDbfMdzlbop1KG9ar44BObfSCaO8X5sSCx2t9DsFfs1YI89YgyZsn1
	 SBs/vodsKbvvUNH6/a7xkwe2IO4mKoRjCrfGV0EohAO+VV0/+bWpbDWzwSH6W3cA77zyG
	 I2pwpNmwDi0F0q6gFYHt1KiOWXAdFk0cgAL/UmUoKeejPizi87kBwTFH90q/Hojt3Fbet
	 2kxGKFhqVdNAHEr8FVy2KOf92OwYzqZyNe5VE+6YXNNzrXqC8hMwd+kfmGwMQovijwsDq
	 /nksPCJFl2NH/hJFj0OQyE25Oa6CVW2l6c8xpsZ0jKso6nb3BUm1GXVN52PqmTu99dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795001327;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=nG1apVdiiVH5xMYZQ+1A0shEqwCnl5EZjE+Zf2il+6o=;
	b=sWieNzLt080pFnjSQBGhx/dNYHXAk4LlTXk4kUQkNE6ESgRQ9XunsFba+4cMPC0Nu/6u
	 axkzp/XePrIvJvXErktPhyrV4C+f0TyQrMAek7V8Ug6XazaYZ/E82gqokidORXsjklVfD
	 fFw9BePFmaQXwHCpwtSAnyxzu1YbIj514WjKUIPcRgZnrVUXP80rc20JKxlIOyGKWZm8P
	 F8b4MNIn8D+bZR8LgX2IT4U56wVEu2AWCxiTFPAoAwsKlJy1UGC1iTvWdl2aeRdxNoecG
	 +URWsV0pgwltFaiCMqZ0w43I1q4vsVYMy88/nyk6gLO4mFipmGSBMwm4k6X5DW0U/ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ntylGciU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Mug1xXvd;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159E860A2604
	for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 11:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 159E860A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ntylGciU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Mug1xXvd
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIBPq5u3175701
	for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 11:28:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nG1apVdiiVH5xMYZQ+1A0shEqwCnl5EZjE+Zf2il+6o=; b=ntylGciUuJZfpWf0
	c9UM6MyqepvVZTCUP0ikndK0p570RLatJXjQ8tNCA42mvik8m09Q7kgxjCpYLS5w
	3be24pUUqP+OfFXhNIl/dv7A8fLLeH6RfrBGHOO/30xV0aBqh2ZfzKxI677TTEDd
	KcbZ5VbENV+w640ft3HbjuEvm/246WpbBNMsmpm1min/ZK1eV/GhMmmg5YZH3KU0
	zAgVZSwH03j1TilDVNNqaeyEAJ8AqtYa9gTsWf9+netIh/R8bQgtN/NKSM5Ri6RX
	MunrHSIsDg22tgIDcwR6X4XJZb2Z0OVbk665hfMAIpeETNnFmWOLuL8vK6pqqlau
	GQpvbQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv8jsq9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 11:28:45 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso1256470eec.1
        for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 03:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795001325; x=1795606125; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nG1apVdiiVH5xMYZQ+1A0shEqwCnl5EZjE+Zf2il+6o=;
        b=Mug1xXvdEZjzPEM85EZcd9eQCcITEnXlN1OP2fEDTU7Q9KXHnPDkAJUubwt5zXj1tB
         syiG4lK7PV2Mm6S2A3b9Kl+hA5sTZEGGD1ei4kIuXS7QjEo+IVi6pg2GK3fjYI1WjVwv
         dhUMF/cIYNrNkvYpKCK1v/gd/z+wwGjakcuP99eegX+tsXL45a2lqhDdld/bNtHNE/jr
         udythPw6Vli4Hq1G1phprcfQdJoFGQtTtndg96P3tEccPsbVNcznHFBK5Bepc6OwgSZw
         r8osPT0zpsmN6RiWdvmvodQqpSDrdfKaMTkFuWSm3Gno412WfUrNx+Q4ZIJzqs1OVzYM
         s+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795001325; x=1795606125;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nG1apVdiiVH5xMYZQ+1A0shEqwCnl5EZjE+Zf2il+6o=;
        b=NoRoLRc32+kpYYlWZ2ODX1BaQfZRqg38jL3WRVg4ouJsTBUDFBvMPAW7NdDfZHz8t9
         glacfiimICtxJfth3vR48Uff4kHCg1CFDr2lqaYW8BCOBwCageVew1ZaI+na0l62sYDt
         0tD6Ug448c4d38T7BiFwcdHxegqEaLZjI08wLieWDJLvmQcDsuI4xhAmL+EVhX2PemL4
         JQMz3oKoEa7qvK85Wk2bVMxW7rBWw87OFaVxnWSGYTmuTqvTRpX8t50xFEg1eHfBb17p
         2UA8IUs8/TBBkoIoak97BON5xFCprjp/LcmBQ5KxCL7SkLEvnUqB5k4b4uR0SyFGW2V8
         H0vw==
X-Forwarded-Encrypted: i=1; AL+hErHpkq70XkzwSyPmlTlhKzXkEnFZnWezhECP+1/OQiDHDtK6h7VJial3LnmDd8hbEcw17H/fdQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9td7JFKf3xEba2IINuOTK3hdXKQz2Eq+tDkFYfbZz0qqcHmfjw
	/KrPPZ9JoSACq562AIdU6GZZzfhVGuCvd44CJ+VmlgrA9Htw/n9L+kAqpCAE9DSr2yUD07SKxZd
	Qb86eSagKUGOBDjn9LKQXEhVZVo7Xu3MLHNWJg7Ri9DcwxyFRcLK90IWF3Q==
X-Gm-Gg: AZFdTZcVE7J2tmNMthaByBOoqrXJSUud6uTZxCGAjBuokqn0DRw7BPi+D/meqFnyTmB
	/CnfxvlLwgV4i2+daKdOGLsZFqbXT3xpFOkvaedu5uRCeVZV+siv0Q2ynadb3VyC566xEHnIi07
	RWb7xTGilUcpoExAtb7dTh+wqakcaY+XyW5DY1akQ+PCOJ/MrfzE9rPOu87drYu9gAlPfzJio8Z
	Imw6Y9KO7zqVGa5G4i1ncK5U4RlBpxy+hq2d1sTSE2WV+ZWlJ+5eYzOia9fFSigBN2AE6Xgbrwn
	50/Q4KqKpMBpK1aGjxT6q5O+lBJGNa0ZFJvCM6kmwCX9Oym1zUte/2gn47dJtFQn+ChILlR0ObO
	Q6nO4vp7SKPtPcWOEmRDHqA66pz9W9qKj9z3WTIUkF2CUv/GkaQhEHvx5ji5WFzIga8y1HfYQAU
	7qfhBi9Q==
X-Received: by 2002:a05:7301:18aa:b0:381:e45d:be08 with SMTP id 5a478bee46e88-38280a3c1e2mr2400858eec.21.1795001323968;
        Wed, 18 Nov 2026 03:28:43 -0800 (PST)
X-Received: by 2002:a05:7301:18aa:b0:381:e45d:be08 with SMTP id 5a478bee46e88-38280a3c1e2mr2400813eec.21.1795001323169;
        Wed, 18 Nov 2026 03:28:43 -0800 (PST)
Received: from [10.204.100.88] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a72eb2f3sm8539071eec.18.2026.11.18.03.28.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 03:28:42 -0800 (PST)
Message-ID: <1fcd89e4-feaa-4072-a5c4-56318b1d8475@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 16:58:32 +0530
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/5] iommu/of: Make OF_IOMMU depend on OF_ADDRESS
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jpb@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
        Eric Auger <eric.auger@redhat.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Joerg Roedel
 <jroedel@suse.de>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Oza Pawandeep <quic_poza@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex@shazbot.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        devicetree@vger.kernel.org, kvm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
 <20261106-add_iommu_ranges-v7-3-5c0f72083e52@oss.qualcomm.com>
 <yvkcq3zirv5tz2amfbk52a7smbsqs7jrzdisq3qxzw6xkoxklu@rplx3gvxhcoz>
 <dd62aee3-4f23-4904-827c-7f776c4be60a@oss.qualcomm.com>
 <vwg74npvbwdhepp4uownnzlj2ybpiknfktfvrpy6462rdw7snd@tj4vgnn3dtml>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <vwg74npvbwdhepp4uownnzlj2ybpiknfktfvrpy6462rdw7snd@tj4vgnn3dtml>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 8uUQkGF8uIz5ybM05T5-Cd3YkN-BWuUA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA0NSBTYWx0ZWRfX8N5IRXso+uzB
 MQwuW2+A3/5/Q4WPmn3RxoE7GeD6iHwJqKmfY8d7qHXX4vSuKJtK8W8Y00tMHBOovrJAvuv/v/G
 q22u2uGWkGsKJ4TAetK/cXsl22fEGHo=
X-Authority-Analysis: v=2.4 cv=c60+0h9l c=1 sm=1 tr=0 ts=6afd8bed cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=HfRq2NBFtK1Lh0_1ebIA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA0NSBTYWx0ZWRfX57FPwSO2u1cj
 r0vYdKESHmR5C6P9vdcXVjvqJXRqIn2pvZd7fACAWxEXPI1TgFXSq5W7MQfzct82NxWaouENcJY
 dZ8gIKzvHAEtiJW+n/nIBcFathuDnniPIIjLRbz+FZMsmcte0cKL7F90u/wLRAFcDG5wsLeKIEZ
 9SMVLV9NAIoXcfZBg8hsmH+83iNT0xuhG+Hc/xEEv7SqCJ6hRmkFIn3j2nvukcO5JFqIGXHnGHd
 7Oju6RZ2CBt+KuAXenxDYK91NtX3ShVtDk5d3b3VQyji4frXFXfBbfug98pIaXmUiQIOqkttmip
 cXiuFnDdMKgvQRJfCWl/vJmxNrTma3PCk+pU+E027M/hDKUqMD8gyENOyfAAyfu3XAcfpv0RUQi
 x98e19JHS2Ltq3BE5jVQQp252axVfwiheTmyPlFdb0aKr6Ot3SOtmtn+X7/mn3wnD4sIAmKifbS
 3Y8/bWKSAAVT0InOHtg==
X-Proofpoint-ORIG-GUID: 8uUQkGF8uIz5ybM05T5-Cd3YkN-BWuUA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0 phishscore=0
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180045



On 11/18/2026 2:32 PM, Dmitry Baryshkov wrote:
> On Thu, Nov 12, 2026 at 07:10:38PM +0530, Vikash Garodia wrote:
>>
>> On 11/11/2026 6:33 PM, Dmitry Baryshkov wrote:
>>> On Fri, Nov 06, 2026 at 10:44:26PM +0530, Vikash Garodia wrote:
>>>> The OF_IOMMU code relies on OF address parsing helpers, but the
>>>> dependency on OF_ADDRESS is not expressed in Kconfig. As a result,
>>>> of_iommu.c contains CONFIG_OF_ADDRESS guards and a __maybe_unused
>>>> annotation to handle configurations where OF_ADDRESS is disabled.
>>>>
>>>> Make OF_IOMMU depend on OF_ADDRESS and remove the now unnecessary
>>>> preprocessor guards and __maybe_unused annotation.
>>>
>>> Why? What's the problem that you are solving? Why is the current code
>>> bad?
>>>
>>
>> The commit describes the problem as "The OF_IOMMU code relies on OF address
>> parsing helpers, but the dependency on OF_ADDRESS is not expressed in
>> Kconfig"...and instead the code had checks for config or __maybe_unused for
>> cases like sparc.
> 
> What is wrong with this approach? What is the problem? There is one, but
> please state it in the commit message. Something is wrong, otherwise you
> wouldn't be fixing it.
> 
>>
>> It was discussed in prior rev
>> https://lore.kernel.org/all/20261104160346.GD3951195-robh@kernel.org/
> 
> That's fine, but the reason must be capturedd
> 

Ack.

>>
>> Regards,
>> Vikash
>>>>
>>>> The only architecture supporting OF without OF_ADDRESS is SPARC, which
>>>> does not use OF_IOMMU, so no functional change is intended.
>>>>
>>>> Suggested-by: Rob Herring <robh@kernel.org>
>>>> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>>>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>>>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>>>> ---
>>>>    drivers/iommu/Kconfig    | 2 +-
>>>>    drivers/iommu/of_iommu.c | 4 +---
>>>>    2 files changed, 2 insertions(+), 4 deletions(-)
>>>>
>>>
>>
> 

