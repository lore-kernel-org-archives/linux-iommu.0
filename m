Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793612842;
	b=jo0vg6zHX1gv8tkDnry5X6fLS5oeQEYRLRgW6bpjkhtnGZM0/Q3pXVN3rDKH386H4jpC
	 Mw6oygsPu2y+O/mvT7SzF5XAwlyhfVm9DJleA1gsNou6ikc9n+J5kAPqIfFGgvnAze4CV
	 takCFWhwJNAv3X7ai8i626M8/Yeq94yimqB2d5YMBMIpG8wUva4Pz6e7aPJKzNDdT2zAg
	 WL7VR39JWVtHFlg4M2MkmEXzksJ44ryXOyud2M9Rh/j1+7u3VrQkEX+5XNyrka3f0Y67W
	 zrPH6QwAUWHiLJi6Bm2DOn07sxxGFvBFK4IpieLV5XSqRy5yGTwE5RHev9SAW+9rEDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793612842;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=IVHnQxrU7iotifddxQWwphpnn403VF4eD0r25uibKE8=;
	b=vX6CI1Nc12OyDzeM/9Q2mdU38q+uu4JuZ0PXprGws+sHQZOmQCD36VtQ4ENeHwqAh2Ix
	 x6SREXiMncja0vUcW1eygjlyYAc8GVvka/O5AjwsJ6XBY9mgdLy2QzEJ/TKj1GfFyBqy3
	 Q48H2w2vbbdj1X1DhaIUakhmlUz6De9uXkfRVuE/HtAaOn+ZnbR9JQhDOyZRqbmfe93lK
	 JYYKV4wGDjgYJ/DEYowkwCgQrhyqPOk4DaYoQP1CO2CG75yNOnOeDYvCeSlXZWExutJ8S
	 c++Z+FcwzW933aLBQgyDJJ5KBezPLMRrRNfMjOq6mdvHgalmZGzdMG0v7Nxd6ivHtgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jSnohwWi;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=igvBtRfZ;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BED360A2600
	for <iommu@lists.linux.dev>; Mon,  2 Nov 2026 09:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BED360A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jSnohwWi;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=igvBtRfZ
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29AO5C3086551
	for <iommu@lists.linux.dev>; Mon, 2 Nov 2026 09:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IVHnQxrU7iotifddxQWwphpnn403VF4eD0r25uibKE8=; b=jSnohwWiUBZ9NtOR
	oHh5Cwu3ngWVSgEcNRLn2xJVxoWzJKvbteDYpb14R2Eg0tJZ5IWHEp5j3q2VOx5b
	kKWIN8wgEFGsoHxjzPvqxMGHmmWqSvP4o7CwVGi798X8CEf4jtxPLl9wC05/a0b3
	wLQacHVo5zMf/nvVzW2Ckp2jBa59W7Wv0dmCyDxDwMqN/jHefWCmZ1ySduX9qc80
	G7gPpSFsGI9iCNHPxGmiifj8qfz1tMFduKIQuuVEmUGRBmtWa8/prA7QWai0nR5A
	rvscJ6qnEwgmaV4uOfsRguvcy5eDdTQnuGWJXXmZZ2jPcfk522OyklBvMPZlyJtD
	ji8rTQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpka616b9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 02 Nov 2026 09:47:19 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5350173dc7aso7576171cf.0
        for <iommu@lists.linux.dev>; Mon, 02 Nov 2026 01:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793612839; x=1794217639; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IVHnQxrU7iotifddxQWwphpnn403VF4eD0r25uibKE8=;
        b=igvBtRfZg8mIQE7g0Lh78VZX8qlckNdTOoEzNwOxIG6cVqv4nqugOoLHbPN52rIOJW
         gWnwuPqQ71ZJVB/U76/KS9FTtwDYBQMK5kVzWM8yFz0G0Or3i+REd8MCT57I3MAzGTRg
         7eILl3cgDmAJwjoP5WLlyY5xDTVIGNvjWjk7YJL8gbBOhLrUpEELpyU9mMt1E+AR4s8K
         qXF4CaLUokFYzG6Sqj1FYRzNqRw3gRaRBC+HVwmeDSiZJuMY9kEC9yPTBgGecYM+jw2p
         Ft94ugBIM6PX+Datx6TeE8Nj+TagLNLKWJv67vqv8W8wjPKxShKkX0S5OKO7DmCAu0Np
         aGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793612839; x=1794217639;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IVHnQxrU7iotifddxQWwphpnn403VF4eD0r25uibKE8=;
        b=epcA5jKRey55U9y7QdMIf4+15J8iLc6Za0vk0CPBEOEEB3RGtTQJSa1gpremNaBjZv
         2qOwsSVUaotuufBvRKFkmjac94Egrci0cm31zKJL8ot0/e6I41kMt+UXxXSU6WCv/VGk
         4r5fw6Av8NVezO2dNwIBzi49cTYETsH3o+XgSxbPHLjU0MXlK9qkVwDmzcf390IyA0kq
         OK3P0N22etjGb/qEhWmIXndSs5lgl7DOl4lHaRM8y5zY+EV6hW2NHfySf20alNZkxjgZ
         9VwbnYIZNhAKZXoRf/NQ8CEXfrJmtIx+HdkuuPWnwmpclmruP/ecDuf9/nYWrB9ujgF1
         HBow==
X-Gm-Message-State: AFq9FYK9OEY+LoLM37rF3oUGGIHxOl0ssJsV0DplYdLbmTrPpMLimu/t
	Vvaitr4tU5OiqVcIdliF+3KBtD3ONZsFDnvzlNycNH1Ig5MhENuTec8BLKRA2SWD893xVP0DIXz
	3SCQeyRaXgI3zG8iY8xQ1ESVyJS/qaw7MIHVfwdoGziozxohkB3c6P11FCQ==
X-Gm-Gg: AYBFou0pXOcownALCvaWqI3YFAcEd6PT18jG9ZyWvhKCJIusfummteFavZH6lioD21L
	pY6hr7hhPbIz+mWEY/LM+QQbTwXgf22IYKw5a1UVed1bHy1A0I/X218j9sp3x/wrgCoSctsVm45
	ZHvoXRlx74l6/znbLQFD0xy63CtU0l8kQmI26wmMsMCFZecONl8eaFWwcKcTdSI1PUyqQpENI+g
	Od7UiK8zYEGQJydbY3gIPUVr4bw/nhjYDKCCzgaiyKR4nMMREGxVvWsjsNoV6m60KLmOysGbL5w
	vlK97d4IeVSx1ZGQU6vxLfc9fXAobBucmnc5PvBs5KbONwdjR9dExv1CL4K3Vi0YQadQVxZh34v
	wzXIOqrc1wEbVkEbAa7tvN3ONN+DX1Is4TemLn2nRx7KHXs6Fjz1p11sYXGrZd3rtwOhz3hA=
X-Received: by 2002:a05:620a:85a:b0:936:2f59:dfe4 with SMTP id af79cd13be357-9442135f71cmr1707760285a.0.1793612839330;
        Mon, 02 Nov 2026 01:47:19 -0800 (PST)
X-Received: by 2002:a05:620a:85a:b0:936:2f59:dfe4 with SMTP id af79cd13be357-9442135f71cmr1707757985a.0.1793612838806;
        Mon, 02 Nov 2026 01:47:18 -0800 (PST)
Received: from [192.168.226.248] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4ec9ee537sm2987089a12.10.2026.11.02.01.47.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 01:47:17 -0800 (PST)
Message-ID: <d7a919b1-3a41-415c-9deb-9a0dca8bfa46@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 10:47:14 +0100
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
Subject: Re: [PATCH 3/3] iommu/arm-smmu-qcom: Use identity default domains for
 MDP5
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261031-msm-smmu-identity-v1-0-a2a70580eebd@oss.qualcomm.com>
 <20261031-msm-smmu-identity-v1-3-a2a70580eebd@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261031-msm-smmu-identity-v1-3-a2a70580eebd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: eM2OMIisJpd1YP2dwlLCpmFfAQziSlVu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzOCBTYWx0ZWRfXzhUyB9aAY8Ow
 O0Uit3SRW52q7Od/6hyW0COIusWMz1goBJcsMuw3lTWRFlPmkeDPNvKCDrSfKIAzUEtSYaFp9MA
 +Yly/5qPl8hWhv25veB5/v0xHDZBGzw=
X-Authority-Analysis: v=2.4 cv=ZbyIpcVA c=1 sm=1 tr=0 ts=6ae85c27 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=UxUOhlBcqau6VQlabQkA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzOCBTYWx0ZWRfXwnyEIWo9RbW8
 sxdY7pBL4fw1DJiFMUaPfGgeu1e//2VhP3nrsF8n75F9ICKfXyWs26peB6X5yR/h+mBShqbqoBm
 8DfMDfIUYSwduzuMYz2yw0/NMbWBXO1GprppWUscsMHuPBU1t2+37w/OK5O6I+q6tLU/086uxnR
 RQ1KhCOv9lcaXrDcsMJPLnVAsCkM6VAQfE055lknRoAfZ+3tpCiu3mBE/8QPeULP/sbH0NAXAy8
 z/HlO2T5j05PjiIk42BRVBjIZ1dLvRPxIZ8X3g/nshyZjpqEuHfVDvWUHgVQvHHTM2c1Km3OcNj
 TtU9x0vQj93CMNFtqtxtwYJerK8lVbhtuDXPSFJazHGMWGeSbkUvZg3TljXyYYJXt79Ad2dn5xQ
 Y1Op9Dp3Nsxk7PBhfTwRJ7CljcHSqzzwS/nrhYDA0hLRcUBtl2SllFONmjwxJS8lmPISutX0jWG
 /bbnsNkN9Ke6n4y4lbQ==
X-Proofpoint-GUID: eM2OMIisJpd1YP2dwlLCpmFfAQziSlVu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020038

On 10/30/26 11:04 PM, Dmitry Baryshkov wrote:
> drm/msm writes the addresses dma_map_sgtable() returns for the DRM
> device into its own page tables, so they have to be physical addresses,
> i.e. the device must not use iommu-dma. On MDP5 platforms the DRM
> device is the "qcom,mdp5" node, which is missing from the client list,
> and the msm8996 MMSS SMMUs have no qcom impl at all, so the device gets
> iommu-dma. On db820c the SoC then resets as soon as the GPU starts.
> 
> Add "qcom,mdp5" to the list, which also covers sdm630/660, and give
> msm8996 an impl with just def_domain_type, keeping the bypass emulation
> out of it.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
