Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810D2484889
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 10:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764391; cv=none; b=k4wKIJUmtzx/M7Ea7SuiEKvJHLFODEnxyH+x+tVb7ohZT4DSpNKJb39Rbmt9ltNYffXVWtBt1EPHMrpiqt4QFKLhyLhsbzVnaYKUydWeFUEvjHxJFJKHeg9Jww89WMAaMC6D7ooNL4js6ui7h68ZNu5C6VYUTwMFPN7oTfZR4SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764391; c=relaxed/simple;
	bh=p0rtOpqJgYOdzRogUQx4C72rBJ6MZuOxyLFNm8hD7RI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YdnEYZ1wdnOx64hH16e6xo9CDP4V0J3iZQPZp/mFaZuYSSCsB/uortIi5bKDsTFh5N14XVZkAEgTdCjyvN5lfev0/W1E7rYazFaYq6mIRBrh8Wy93u1V0KeZQE1H/pksGeYkYr+jZq3dGTBQhTz9wU6mbxE2BCpfhqL5kWiwKO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TMQRCHii; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cwvMiawk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TMQRCHii";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cwvMiawk"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68U7daGE3330390
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 10:33:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ekqw08WhSNuzNavRYsHvqJW6DtR1r0AaDDdoOSLKqQU=; b=TMQRCHiiRvFiOdpJ
	7BSVgWtkH48nMNyYnmNAfpeGzU0zQqZurkIl6xRlU6uxU8NAQoTX4YiO237LP+3x
	jZ0THO5zSq/bQ9WtqpSWtCzLPCo0cbKiiW2jwG539bmITFukFb+jcs/78VRASBcx
	FtZEUqKaQIws7RIZD2hkL2X8NZK91pCZFq2QveLVm/j+VrTwHvtorAVXNWfuv5OY
	+aRtK2JADuv3CaHnLZalsJq5ieeIhKsSgpOUkD7QMM8/XQwBtQdkmtqSrVdCBxHr
	0etWsOK6685L4ZGtzYqfoct0iy4vVw6lU9f8AH33IUgqkHLfOApzS0b11fPpl2IN
	NsUIdw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0nm3jvta-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 10:33:08 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9375d92d0caso101997385a.0
        for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 03:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790764388; x=1791369188; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ekqw08WhSNuzNavRYsHvqJW6DtR1r0AaDDdoOSLKqQU=;
        b=cwvMiawksTwN0z0M4JFyfw/0AJlJHr0+2TByU6qgeCFF/SZOv+26gkN2ZTzD/6bSA6
         A9DKaWX1v/WmXw+ddsg06hfnBXUIirQ+Jzk4sYz69ABK8p/B2T9ism+CeRacOAYwqRvt
         XxBqD6QqFmO8IGVent1dVmA7logks8/hig+BrfHeL4TNnHgvpk2zuvp38dEGX4/0m3l2
         KPrpU6blR4hQvaAAstVKD/wqB8cfOK5+5ZA02nX2Y1TqDhEwZj3AzGGn/S9/Pj3EBmMy
         HKR/Z6Tq74DWSXEHiWQGTEvIuBljJMos+QnzTdRgrmPEbXD/sNZynCkUfBVDOBFfh1p7
         MUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790764388; x=1791369188;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ekqw08WhSNuzNavRYsHvqJW6DtR1r0AaDDdoOSLKqQU=;
        b=mzd5XcxtIdYE0o/mvctptHxDf8cGw8yybgdoA+QwXnKKOwgkqOk93oumO2usKoqnEK
         +ZvayEv26Ik121MMu+uroneloftBk7jeBUumYgyty0mFPn+PGR0iAY5omaCbqXV6EMp6
         oZGA5KP9kt6eRF2PCybzduvkFlKPUV5ZbyGBS+XCS7T63UB0aM+l3gzY1oAbjhaTp7a6
         D2kms9JgrynmVX6PwjCd54dXGtRUmVRiHOkZ6wgixe4tsrxHDKL2vJdjha+oa5EO52yb
         X1enqNfkpdaq9VEEbLpaVyIhjDW0FSiDH3rik+50FxGlLmqkDXgTfPdKrs+P0sua+Sqz
         X+eg==
X-Forwarded-Encrypted: i=1; AKwUvByx4crf0YtjtNU1ikNTy81WmdXCj9JqyxQMESeqcxJSSAVzVUV89ALk5PEYBPC6jFq0q2xtVw==@lists.linux.dev
X-Gm-Message-State: AFuF++lG8vah/iRzrGsvBzHYUkNxDsG0zBKpp/GMet6QGl+Iquf8HCjO
	Wq9fXF0qM7QEVfJ+wowdXGu07igrgd5dNPgs/r2GJC12VfuSx5IiZ5p+984XGfjUDQ9HzOp+3/S
	WHKY30BzW9YRkoAiYgrUB7Me/+AERmx4+P3zpEt6KKMvZXwiI9xLtSeg4xw==
X-Gm-Gg: AYBFou1ZtKkwCGE8d5MKL2ynVI7c4VBrnod1TNqNJNWF7uwqBAz40tCBMI3Fak0BmzY
	OwR2inHa14nYsVppM1uduzDexB4fgjuTeeryPaMPTN3jITsDbXXUggY9kDbQClZj5dGv+PQZe1l
	68FLPoYgBA4xOBUUA6JU2cTT4qQUuB41I+S/fZfsq9Zf+IItNev759063dhTXiwL78iqe0Ps+YC
	KiePMWgf3KPMCQRsNMsmfK9YkE5mi0U3iwSCoTwz3vhINrKfMKcL7ubLEJmIJwtD7PpCDawaJqY
	6MjG9vJH5KBa/DW+wmhT25aTXiAdDnizykXz+EBRzwdqJ8zm3LXH1+f9y8y3v2d4PlH7deIjpB7
	0Sn9ZlboBOREOtBhb+VILBQ==
X-Received: by 2002:a05:620a:4116:b0:939:5924:e319 with SMTP id af79cd13be357-93ca934902fmr130585785a.0.1790764387751;
        Wed, 30 Sep 2026 03:33:07 -0700 (PDT)
X-Received: by 2002:a05:620a:4116:b0:939:5924:e319 with SMTP id af79cd13be357-93ca934902fmr130579285a.0.1790764387153;
        Wed, 30 Sep 2026 03:33:07 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e22f7f26asm44710266b.42.2026.09.30.03.33.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 03:33:06 -0700 (PDT)
Message-ID: <cb246048-cb92-4fd5-937c-3f285c67ea80@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 12:33:04 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/13] arm64: dts: qcom: lemans: Add Iris context bank
 subnodes
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
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
        Robin Murphy <robin.murphy@arm.com>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux.dev,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
References: <20260926-vpu_iommu_iova_handling-v5-0-0322ca5dc10c@oss.qualcomm.com>
 <20260926-vpu_iommu_iova_handling-v5-10-0322ca5dc10c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260926-vpu_iommu_iova_handling-v5-10-0322ca5dc10c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: L0aTSi8imRy6H7BwpbCutaWsgX60keBM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA0MSBTYWx0ZWRfXzCjM/whJJBOf
 UzN50FctHVleevdpzBiH3Kq3AYp/Nx1zYLFVNc9KjR+9gL/Zv2W/LNNJ3ePfsaGgljdDKaSVST1
 hXkun1J4PC0A59vkgEXdEnF1SGfG/RYYMesRMouCC5sd3BSpcEz3YzV0DVXRdTmU2/v1BmS8b96
 /8HZBn/WY7jsw78HCqb5j+RL3hgiMacjKEssd0NSL0YpljDB2hQvgkxYQcgymGIrZ00v2G3He4t
 6EVF96AD0t7kR7O6w91cbYdtlfhq4+nEDM5bs+ZxnPmG49QkCSjSwh1jRye6VjT6YXce/tgLuW5
 G2656ktKMqfEQt3TBirrfNXYXOcMK1C8zK4M3jGgiYHJUlB3eIg6bp6osOYLjOrzDWR5/hrOCq9
 n7hngGCMpQUy1+h3I3CgDhb+cSv6BI+YiRv9NTBDembOPdAvavQEdprmxuKHacRQdjTnLgRdfmc
 +wWWPxvi/WOh67xc6pw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA0MSBTYWx0ZWRfX78ft1XCSv+jx
 x2/Vn8tx5GR7Se692f5RH/6yO4bcN81cL5yxbASSL4QvcCasw2XGIkgt4dLw67qkvWGaBTjVCiz
 +zBZqG1em807VfWcjMPW/sC873A6rXg=
X-Proofpoint-GUID: L0aTSi8imRy6H7BwpbCutaWsgX60keBM
X-Authority-Analysis: v=2.4 cv=fqxJ914f c=1 sm=1 tr=0 ts=6abce564 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=4BULcDCo1EIeXDFKsSoA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300041

On 9/26/26 8:34 AM, Vikash Garodia wrote:
> The VPU issues DMA through several SMMU streams, and the hardware does
> not give every stream the same addressable range. The non-pixel stream
> cannot address the low 600MB of IOVA space, while the pixel stream can
> address the full range:
>     +-----------------------------------------------------------+
>     | non-pixel stream addressable range (600 MB - 3.5 GB)      |
>     | 0x25800000 - 0xe0000000                                   |
>     +-----------------------------------------------------------+
>     | pixel stream addressable range (0 - 3.5 GB)               |
>     | 0x00000000 - 0xe0000000                                   |
>     +-----------------------------------------------------------+

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
