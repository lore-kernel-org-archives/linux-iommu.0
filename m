Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA3748423A
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 10:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764384; cv=none; b=CuzXQ1T3PbJImTawmsuSmmoHulVXhXYuQc7ZTaME7w5ScX3K9lQlt0t2490b6mC+xkr3vpDYCA9R9fIBshElWX/KODzihMrOKUkJE8lOixPAn30jrQcFvcuDA55aTjKyuPRpNfJg7z9f8uRo0lh4q4NqTcG/SxMDA7YToEacLb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764384; c=relaxed/simple;
	bh=XJqq/HqfHJps0QJpX9Yh5Stodb+XN2Bv1jNcqRvC1+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nCyn5uhdoWN/cx9nh7QG7uIjq+zSnj7F/GOlZSYMryy4WHtyMC5z6hT+rrU2UFrUsTAKOcp8J0/aakQC/5fsspN8+s0U24QnrFo2lrX6Lbf9CYfUKOu6P6Ug7j+imkfUxkCG7+EAx48ng39nYuogpC5RsXHw2dxD1kRjf5goYu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GChnVdVm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dnhw2GKF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GChnVdVm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dnhw2GKF"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68U7dVsR2119208
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 10:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oOS8cWcom7zKihTK0i6yF41CIgFONzu6H2go37Q+AJ0=; b=GChnVdVmku6RuTmC
	1fJ2DDWjNwhRb0XkKRKojfl/OySNJn0mjLQjytrD0jyPZzWYmQjFT/+yw5pQf80o
	mT+EXEMKTxg1LCpst2Rg7MY2GArzBC1naM2AfI5dSc7ugCfHOE9JNxoSRJldTx/L
	dTBAUyyDYKneeve+pienZb22d3Tk3FX/C7vNQ9F+S3Ytdqb2vpDXhIechrUqaAhE
	9ganUWrJY+2Uud4gFJFhErbj6l5c9Q0Ge9USvjeic8BILUZigEjcVNwQCp/I2FGG
	/Hf8VP82BS5k28cDrNqRa6PblVvCu+T7/DIpgvoELCFfDRe1Fw37qce9NBktCBRL
	AU0eiw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0rhej9b0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 10:33:00 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-532bad5d751so6184501cf.2
        for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 03:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790764380; x=1791369180; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oOS8cWcom7zKihTK0i6yF41CIgFONzu6H2go37Q+AJ0=;
        b=dnhw2GKF87p6DQ6NLJca0jtuHq/XAqPTeI67Gd5SYqUBTHA5d5zAan/e/9WwPqma/G
         5usJGAh/5g/vzXhdhj6gaucGMARvnV7CwYaCwtBc3BM1LNfIvUYh8fdArczxYbZoUvyH
         YMUdRrZirF3LIZvoYMMHeuMoXvAaKPpE/VKXMQ9smPPKNGEQYekIN+KtUexlTjKG5q/k
         9x7g/vSFqk4M+hibyxq4ps8jNA4h3rU7/vdNQwNuIN/kbuFjOET0AS9+QfgD1dyL1/Lk
         8E7kkrpBXAQALPFVPuj4CTZ+YOXT+MFYj78Z+hY4xEit3rh8PMENAwsmQdTUPDtck5+X
         xFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790764380; x=1791369180;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oOS8cWcom7zKihTK0i6yF41CIgFONzu6H2go37Q+AJ0=;
        b=vs18v2z1VRpCIDn+hobb/bsMNuE2MABnSMWz1Z+cDbk+G5IjI+zKIM6hdERT/SCH5n
         9fF8gHkv9+yZB1EjXayz3GKT0WQx3PD8XRZpVemnUjpjHn5EmVRF+9WTNaGSqTWJ7BWA
         5Yek3htywkcC2o8K4YwWP+xt21DZPuYBxxoAyzU/nShtM1GhoiCDaRab2d6idO5e/esQ
         h5QHOyk3Dp8qzVVEuTQHZoVDs7/ygneAcZ6Ib7Qf4woTIc3bX9f8kv1kkcd3L5Kvks6k
         FHoV+sgpyaCd1JYmOb9mFBiGJqFoJ6/VnW4ry0Gha+AUxMMnMkDrPyRQB/BrriFSTOuu
         CV7A==
X-Forwarded-Encrypted: i=1; AKwUvBwF7YsW+1G5avVKSBcnvRGSfBtQo8p1ozitEO5ujDR6OlDqqKkE4XMsu0q5dFfhOq/j4nvOPg==@lists.linux.dev
X-Gm-Message-State: AFuF++nHqiPme4cVWfCy6NKwkqDOYo/7qwG33j9+7AdZaDtohKwDnNk1
	BjKesCOQ8mTgCjXzK5crxnk3h5iNlrLwlNZ18I1xbAMC4Uuwqc579cnYv6X3NwVqB3/6I/ka0uw
	pDwiS+14dmTK64ZmBh0m2an1dNi8fnmwoEpNDeiNDsiLoPHpqRa8bcDvDcA==
X-Gm-Gg: AYBFou2oTlT/j985q/tRMH+MOnCO68/gTtwZd25SqBPhE8RJPJezxxKPQZcYp96IPA/
	I/BeWJ+OG6xo7R1bG49YkzZ9aKoeT6qfjrVLqbTBdGyfZ8OIFyBjfZ2jCADvHgfqTJl3M4igWD/
	NwwNtVaNiGsZq8XEhLoId7jZCLPgTiwCEEYdaW9ACP2p3OJDmkM6oDqWUv25nItZAQd1uqY7cuU
	vqZVAIubUOjHnWzirQK5Lb4nIqTaBkdsOU1M1ljeN22bMNUVayHl5AakSXUS9iuJy2phXvagGpd
	BmtueIvb58nmAS5oT67tWjFlvPXdSTOSYWbBmqH0QAZSQyb3nF8HgdiTv/rnjNgYrdD9SYUw510
	cEVrycgjZ4swf4+tYC8vPrQ==
X-Received: by 2002:a05:620a:260d:b0:93c:6e1d:96c0 with SMTP id af79cd13be357-93ca96ce16emr134796285a.3.1790764379605;
        Wed, 30 Sep 2026 03:32:59 -0700 (PDT)
X-Received: by 2002:a05:620a:260d:b0:93c:6e1d:96c0 with SMTP id af79cd13be357-93ca96ce16emr134793185a.3.1790764379143;
        Wed, 30 Sep 2026 03:32:59 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e22f7f26asm44710266b.42.2026.09.30.03.32.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 03:32:58 -0700 (PDT)
Message-ID: <6c081871-6799-4ff0-ae19-187d8a6f9d9a@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 12:32:55 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/13] arm64: dts: qcom: sm8550: Add Iris context bank
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
 <20260926-vpu_iommu_iova_handling-v5-9-0322ca5dc10c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260926-vpu_iommu_iova_handling-v5-9-0322ca5dc10c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: FO_zN9K6tKqQQ_d0EAUdJcaAW8dCvsnl
X-Proofpoint-ORIG-GUID: FO_zN9K6tKqQQ_d0EAUdJcaAW8dCvsnl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA0MSBTYWx0ZWRfXxE4a+P/LA0jQ
 dmZrOhzCGNHlqMw+UclZ70incAFgcwhMdqfF5bx/mT+yC+18q1/Vkndt0CKrO+dwgpq0adsBP1A
 h4Ax9icKEX7zupcw4UFaX3m2C6qWbLI5In/pqx46MXrqcOBb4J3cKMY7ln2e+GDjFoO0SaQJYT0
 lfurbMt/Srvs8Qnya7FuxvGl62NsdeHscvcsW6J1IQorZmB7/Rks1DHISF3M+Ne7l37s9/ngS4X
 N9VY6u/eZyiohk+VZfwvbMobSDyZ7IbwtYymsh9DkWGQZ5qMrnZz4NekKaYas0UIbEHPUtlGidW
 oyryYlcjaLgI6ru9E5oaJhI9EceRFcGaUODDB8w7D4I7w+kt551GRPicp8YOxH6Wv87I2Adqrw8
 kF+V7RfKj35t6FlhvkfTZnp1nBhEnT3VhHqvoV7GDrKeMCk8HoqKmO1VAOlNnRbxjfLREiIokzO
 6+KI4EmcNjEwnymqoPQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA0MSBTYWx0ZWRfX1KRNFX7ODBpk
 bXbS9y5FUaKFrDjtY9ulOhyhFqzjF6pzgQgWLpxK6EFaxooc7LpO4ytJNCCpi1H8Oy/EQXhyRsd
 zoJ+nYQLBrTcgolxWvGdqSIJ8WkxjLo=
X-Authority-Analysis: v=2.4 cv=Tu1zFzXh c=1 sm=1 tr=0 ts=6abce55c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=G2U8quZLHxfXJRKprjwA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
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
> A single "iommus" property on the video-codec node puts every stream in
> one IOMMU domain sharing one IOVA allocator, so nothing restricts a
> non-pixel buffer to avoid 0 to 600MB. Once an allocation lands below
> that boundary the hardware faults, which shows up as unhandled SMMU page
> faults and spontaneous reboots:
> https://gitlab.freedesktop.org/drm/msm/-/work_items/100
> 
> Given that the address range restriction is for specific VPU stream, it
> should be ideally be moved to that stream. To achieve the same, a subset
> of streams is now represented as subnodes, so that each can be
> associated with its respective addressable range. The design was discussed
> and agreed by mainatiners here
> https://lore.kernel.org/all/c7b956a9-d3e8-4e18-b780-5d08f5cd2ca1@kernel.org
> 
> In the past, this limitation was addressed with an iommu-map approach,
> with the iris driver dynamically creating the devices. That approach
> was later concluded to be a hack to avoid having subnodes, and was NAKed
> by the iommu maintainers. It was discussed in detail here:
> https://lore.kernel.org/all/c7b956a9-d3e8-4e18-b780-5d08f5cd2ca1@kernel.org/
> 
> The video-codec node includes address-cells, size-cells and dma-ranges
> to declare 1:1 mapping for DMA translation to the parent.
> 
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
