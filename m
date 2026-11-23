Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795447599;
	b=wGfV+j3r1SOMdEhsY+DvH5UVxoFQVkqQ03bdi5VqkfEtpJ6SQrDQBdzvbYqtfLjrpW18
	 mutFpFh0q+AfXqWXp0tHBRG6O6hKO3R1palCKM+VyqZTfCLuA0YxMirWpyA5eC3QnQzGB
	 M0cajmvrb8Rs67jaCs/Y9/suQd9rWazyHHZkLSU5EudRYtpJ3fTWUATP/X8Y2bP85wMcd
	 5i/zbhsnzXkgUtT87Ay2b7K84P4BSsTyKCtP2yCmx7YgH7oeDKQsypfp1GB3oiJSDktU2
	 CEfWFZZKeKexjSJ9QC7YWLrLZszET0ER1wOI+d90O5O8+uuTsH5mSJPV8aFWYzJ7J7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795447599;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=WuUxIXOTitidaH3hOzfbjH0n5miOrk3cJGjFf9YeLq4=;
	b=YtuwN8H1EHCDoxzpzOmdAAckk6uel1Y9qFhzJfeJW009FCAjyz19XIQfFiWBcLbL0qD7
	 hGC6dFLES+EHHgYHjMkGX5+2kbKzPYrWB4ATaXtIORj6GTZvcUZu26vzJAjKy3UsN8+kJ
	 bAjjczMqh6z9NgJT3ZUYcA8/z9WQaVtid4Uj6Cd62Aroqi++pUN7ZOvCMHim3t6/FG+0E
	 HgWL68XJwtAtc1YtDgMjM1QkzwkXCRbjnfkJ5hCEmZ2He0zaP9nzgsKIFTqd4vJGhPXmN
	 oJYA8f6TWoIpwMoZ9JAJEJ4MFDj5c5/grfyja8FgQhbwioZ6XmLYp5C7YhIq79kl7DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dW4qkRhD;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CNdOdny7;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB64606A327
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 15:26:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CB64606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dW4qkRhD;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CNdOdny7
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDKxSZ1974245
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 15:26:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WuUxIXOTitidaH3hOzfbjH0n5miOrk3cJGjFf9YeLq4=; b=dW4qkRhD6imxWpO8
	u5HFt+cbJ2A5mj1c1Ds7HXJFBiwHhG8/isQUmEVOmN7Q5yCgvPESuKphzSseuY4X
	F9YEIBVBT1rILBMztZWXjiPF+1SnhEwm5opt4/mrlJNr0M6zeY/dB36oxtnRyUoM
	tDMuRHv5ZaVAwy8If3ybdWC85Fbh0ZVD+q6ZeC2t2NuTIqYUGrLY3sdwXP2lBrbd
	Z9w4j5qU5t1595g8SPztX96GWeNFLLPFKdg3McdjKgraKLdhZahNnueNV0togGOP
	KfoZa9K1/Q+EdN7BO+S9pKid3qQllXMCtbsoH4td8IOMjY46VyK6qcXYVJWcNfBV
	OubzFg==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4m7us0c5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 15:26:36 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5ee4ca14454so95145e0c.2
        for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 07:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795447595; x=1796052395; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WuUxIXOTitidaH3hOzfbjH0n5miOrk3cJGjFf9YeLq4=;
        b=CNdOdny7CWQWPhqTn2K99U2qHDpkjRxZMMBNHWN6EzOeVt2KDfQNZeWmPmZNPS0ccE
         Rjj8CCQsUN6oTw2snF3Ouio5T1Spib/XrQ4ZlxMQ3LXmpy3ZCCgGDPm25z30/hJ9UQNh
         /IdwQC6aIVAOK/XxdP8Q9eYtMtn+n86U/CXUHIxT8BRiLbxWnEYysHT5BkIb07cjAd0C
         34Fp4Z2kP1MaNM289PHP6E/dshrxBXQIXhozkQaiXjKwWPcn0gOLHh0vJgwja+oC+FiO
         SknEYWMv6VN3H1pO5IV3uvCjNClr3x5Ha/lrYklORqVjWqxlQQEu4WpQ1FvKAtAmJ0xl
         QRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795447595; x=1796052395;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WuUxIXOTitidaH3hOzfbjH0n5miOrk3cJGjFf9YeLq4=;
        b=OAEWkd2Suqzp7/kfNliX9kSfmcXxzgreXdTksKN+lCg5PNkZdBBXdXc0+VRvDOjRCf
         ZiDZLdt8869qTmrVTmgIuDryQOoUcnW10kqa23LXU4FjehMd8jkUutZI39+jGDvQPe5Q
         bBU81D1m2aZv0gIUz/rhP0Eu04evXaylwctKLLcF9JalAjEPa09IEwdm2yi3za5kf7jd
         YTOhvUCYBSlx69jUM1zq44Ug+/Z16goe/x0D6Z4KEeK4ByFOHwGRyZ6uGOeKoLbTeMGa
         kBAPJoeCi00MKwZjVLLN7jlNvVY9afp+F1DeEAlxCp91SZbVVE5p+UaZADR8amR3NzoI
         evhg==
X-Gm-Message-State: APuU4Z8iC8NuLkJ7zkak/rsquppEcsw9t0sVLf5wU76tg8y6urpYlGK5
	hGFwZ+oexdInVQlOjSG+RrQAxAvv0uJb/wWTF24HDHQBOyFgf30lcVuNMZ/TrWJGNWQLwGh5nW4
	DIVVHkKyGRvN+vzP1VY3l8SVPFnTVvrVQu+V1oTsBjM5yCgckN0GyubFakA==
X-Gm-Gg: AZFdTZd89ePYlRsVckCRaxn7NKSXperSr7dg+OMf1dD4BmaFJCl+LZfeM+br22/yXBE
	ru3w3jz83ZW23qQwFQuxTwuedCeNZudAFzoDTzNVVUQjqiqimeityLA0KRaz1gndbwzCv7xaWLr
	KI8HGJvpF9lVTPa1iSLlMlMsAVnsiaY7QT42ZHETPF9jFSdrO50Y3Pzw7Ir8V4//0dZQIDbz0On
	I8TzICsc534YiVwMMeGlFEc737/U9syXGyKsW3K7ZQ/Mvp85xPE3x6hP9yJGAkBVCEpDfwSE6p/
	5KhE5qv2OV0XapIVLmJkS5Kxn1JL7QsUTgCwFI5j0hYOjKJ5syCsuZj5i29o3k1/DcNiSjkVOcs
	dGK5+xTqlqiLLsuTdHJ6ogOyDPuO+VLTAXuVAJf0AKzxFIBiSm3BTWjDKPMq/xeHdaL5CwWw=
X-Received: by 2002:a05:6122:c20f:b0:5ec:b681:f4ca with SMTP id 71dfb90a1353d-5ee8afd6c93mr7291725e0c.4.1795447595275;
        Mon, 23 Nov 2026 07:26:35 -0800 (PST)
X-Received: by 2002:a05:6122:c20f:b0:5ec:b681:f4ca with SMTP id 71dfb90a1353d-5ee8afd6c93mr7291684e0c.4.1795447594833;
        Mon, 23 Nov 2026 07:26:34 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513acfe25asm420926666b.11.2026.11.23.07.26.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 07:26:34 -0800 (PST)
Message-ID: <8560f4a8-41e4-4f78-bd0f-3aabe731b79a@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 16:26:32 +0100
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
Subject: Re: [PATCH] iommu/qcom: Disable clocks if restoring the secure config
 fails
To: shyckless@gmail.com, joro@8bytes.org, will@kernel.org,
        robin.clark@oss.qualcomm.com
Cc: iommu@lists.linux.dev, robin.murphy@arm.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20261122-qcom-iommu-v1-1-ecb20a28871f@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261122-qcom-iommu-v1-1-ecb20a28871f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: JIMsU2vZeiI4UL8Wd-sViEOv7O6ADddM
X-Authority-Analysis: v=2.4 cv=KurYSmWN c=1 sm=1 tr=0 ts=6b045b2d cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=_2H1bLmklXDtjbdw0hQA:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-GUID: JIMsU2vZeiI4UL8Wd-sViEOv7O6ADddM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA2MSBTYWx0ZWRfX3kptFj256MQy
 03n0rkDB4R1O7iiKInoPY7q5tRGBC0yfuyeFotmiRICHXkWlbrgqlbUUsORMA6Paf2xLeobSegX
 JagVK+c5MWHZdQlsYp/RmOK/TNSmw2c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA2MSBTYWx0ZWRfX2FYTvIBicE4+
 ykPNU0vtec8qfKB1Zsm81KyUvG63HmrNVQkDnjp45ygS+mnekWYnfN3YACI3ImSdKDEsoBHamp3
 JDqPKMRS1iDYlCBfmuR14zZLuSNjOE+tnjACd/r1IKKdpXwTFHDwMlGH5UyXdSCFuyKOgrdTnk5
 X12fbq0h7pz2LB/raEFFPXJfIo6hq6hybPVJTUYa8YN6HagXxC9f/aWTSDHU6yZNjudKEcoC3s+
 up5+FV2NDpxBPcIdYxrqOgxZoXj40oiHQUqj306myudVQly3KEY/WLa6X+AwaXIbYy+93IkvXSW
 YhASwxiTfrHyB3T1veJvgORih0GdkQ6161af21S73ObIy41Ev05hewj6fDdbhVwrNeNMaw0rkNO
 VqmLsO0EdlQeICzQFHYjRH9Wjm9vbKdb2VV3d7FnsHIbd8E7Tx9gQn8yNz/Ll14owJ1koT0CdUf
 qtVgGIAjdVsaqOBJJqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230061

On 11/22/26 11:11 AM, Suyuan Wang via B4 Relay wrote:
> From: Suyuan Wang <stevewong@hust.edu.cn>
> 
> qcom_iommu_resume() enables the clocks and then, for an IOMMU with a
> power domain, calls qcom_scm_restore_sec_cfg(). If that call fails, the
> error is returned but the clocks stay enabled. The PM core then treats
> the device as still suspended, so qcom_iommu_suspend() will not run to
> turn them off.
> 
> Disable the clocks again when qcom_scm_restore_sec_cfg() fails.
> 
> Found with a static analysis tool and checked by hand.
> 
> Fixes: 268dd4edb748 ("iommu/qcom: restore IOMMU state if needed")
> Cc: stable@vger.kernel.org
> Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>
> ---
> Compile tested on arm64 (W=1). I don't have the hardware.
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
