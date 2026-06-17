Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D18D3A3835
	for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 09:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781689711; cv=none; b=HecuxxQtkFrwq8RFkt8N4nWghVuD1C5wgI/BVosYj2Cn9wHDBjvY6O1uuTN+tkBnUcUriiBQW8sLl1a4328tF1WnogLJLeCg83UytXa/w93e3bue8/lYnuT28Gqm8ks0Jobn283Y+cDaYwHOk+LfD3X+Bd7QzlDotHoGrYnKpu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781689711; c=relaxed/simple;
	bh=RDlq0QlpZF1Yk6nwIj57XH+2UjgnGQXUyT5CSkrput4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FVbcJet8D4UyQakUDtbsCz3RE4Rv5/j9zfCULbNyEWhLijeemW/S83YYgr9JN3+Ug6MRSAaKDfLN7A07Fon4YBquV4f2bmEDrL3ixlqLHHYM9ztCX1okGcb5RZrjKNfgN/hOB1A6ap8N37TfLxQzKHQrI7KsPgsCbosSKjLvEpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h7tx5YRC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BOKq57Ht; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h7tx5YRC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BOKq57Ht"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65H8UprA1608122
	for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 09:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1Rr/ngv/2ytVGX2mGHKNa46HYx0Ceuzd0Ez9qBttTUI=; b=h7tx5YRCnRmYZDXs
	MWt0D9ZXNWWW4NteemrIOjLcSQHaMvRNlyLyotm586le5nxORBKOAgrC99HuSNRC
	qF8fhOiG06h3/JbG8SX09dKPiVdixFaPiJdbV0xVL9WuHQQL3hLx03YCgtWApFzj
	T+VGc5So45R2gRO2Ftkr2Jn0kvpUMLBLrfT0khhX/9McXRRoBrJCV7HCIF4iugQZ
	ufWhtYjuF5QV6iBWF29ZPf1yqzwfa34DWibAKAmFegMiAvA8ZGZzZOJ+zwABFvhV
	CDXUT9qCni1W8fhsC1RDE20OZyU4PakkT+X30u/s7ZXFBwpjeBt3X1yFMeJ7FRNv
	a+032A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euef22fgw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 09:48:29 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5176891d0a9so13260361cf.0
        for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 02:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781689709; x=1782294509; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Rr/ngv/2ytVGX2mGHKNa46HYx0Ceuzd0Ez9qBttTUI=;
        b=BOKq57HtW48cTSdOcy7CDovMe4XQdcxHobRVvGheMO8BJO7IpMa8gKMoob6HPtg+Xj
         HRJ8RdXW4OD6HBRl4zhZzVPUUadJsD8R+2iDQ2QHKMVZn+240/y+Iynu+b5GNbxLyMnn
         10tTkgSHObb83q3nNBcvLGewZfdzcLDSht40TnUw21I7cHcR5HF6N3ZuH8B1r88mJ3RW
         XVyl1RRVZN7hMeG13tHKJgvRJS9G90LEzcoDCPjctRXLk8V3yAM+TXH4O5y878gdpNzl
         PaCpnK4DYPEgaB4ad6YeSj2X7UHdZvPScZv6web1Izmxx3In+i8ThLHn5HgmRiP6HK66
         QX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781689709; x=1782294509;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Rr/ngv/2ytVGX2mGHKNa46HYx0Ceuzd0Ez9qBttTUI=;
        b=TwUGiA/1RzGZWih1Zot1TlTgCp9/fLeoB/xNZfN4GP1UShB3i3Y+duAS7Ad6ZB2lIq
         2O9SASBT3ZIVbIJusAi1ftDI4B3FYziKFyjhq4SS+qRjIYYyzhCQxwnVZU7Bbl0Dhc13
         +dBwdhU+Ruu8j6YAKerne7y/EIM1IVQdJa41M7KzciH9twFSdB7+nHnhCWBy4kTw17PW
         8XKQBENwQrFRkfgL7yxDD3/W/Frq/r8g7X7Wz/qqdlJFkH0JmwRP3Njqg2xOTqaics60
         C3H5Aik4qZ5mGVl7+PZWtvlhYvoPx9GWDRzX+Dp63kMjc5e2Vrf1WVmJVcaoLbEQr7uC
         XoDA==
X-Forwarded-Encrypted: i=1; AFNElJ+Tu3aoxDM9U7mngMq8Sf9W7bi4A71bKByc6zVgCpnKtHNKmVZw7t6N5p8mE038EEZb16f0tw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwsawgkUAUQhbOO6QzeSN7ctFcHobEodRFmGyNUmOT8TcvOCuKO
	42qjjcBQa+a5Ts+2sgDmPss98K0SS4mRGbtdyK0HuXKRcB5SNaiO6g3CUSu5WBYqHPl5hc/DQn5
	qdo7etaWqS3qZWsBJUXXMH3QzvM+aDQIBQEpTflm2kh16VdHBV420/pGNXA==
X-Gm-Gg: Acq92OHPoX+f2VtUlaUuSu+XD+Z0rdb+V1feWkvNERxJIcTEM3rIH/N7qdTKf0WhxCs
	GG5JvhQMunRYpodAaBpZ4MNnOfps0Q0j3kZLRDYT6AtFUXp3vGzEDp03xBd3qGBOWlARIC5vWj6
	VnR5QKjEng9odn8wm1MhWHHAccut05SqJgh3VnzWNrGJpa5ZA3YlUCAY6CW+qX34LAW38OiX8q7
	xt1p87+Cj7zkD9P1JAykR3JjjkF8CLJ25qqhZYeqqF7/AQhO2uoB7llFgTb2aMt4POVmcvHMQ7B
	CXSrMrpqccA4dLz+aI8WCthuC5JWOx78DtMLwqxZOpng2B8Fed3bYrJ90nevP0BT4N17hnbCJXz
	6COM2gfnSP5ScE9Hnm/s8lwu1++DPNVB4uZo=
X-Received: by 2002:a05:620a:4410:b0:918:588c:d095 with SMTP id af79cd13be357-91d8e0ab2c3mr313537585a.8.1781689708723;
        Wed, 17 Jun 2026 02:48:28 -0700 (PDT)
X-Received: by 2002:a05:620a:4410:b0:918:588c:d095 with SMTP id af79cd13be357-91d8e0ab2c3mr313536385a.8.1781689708347;
        Wed, 17 Jun 2026 02:48:28 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb7b6d9b7sm771513166b.41.2026.06.17.02.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 02:48:27 -0700 (PDT)
Message-ID: <f5bf56ef-a57f-4b1a-b18b-63aff94a3bcd@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 11:48:24 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 11/12] arm64: dts: qcom: glymur: Add iris video node
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org
References: <20260610-glymur-v8-0-1c79b9d51fc0@oss.qualcomm.com>
 <20260610-glymur-v8-11-1c79b9d51fc0@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260610-glymur-v8-11-1c79b9d51fc0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA5MCBTYWx0ZWRfX+Exp/wy/bKRK
 cIgCBWQ1oHsuqvS8xeolPXGKAG6DyF0PrN17Nffz/KtGtbXqJ/OIArfOfFA58yaWZkDqbPN/N9c
 2xIUzoAXOlrI1DOEYcflw5l2pHaofT0=
X-Proofpoint-ORIG-GUID: zSIgAfLBoKIlhWGsUv2BwuJsCS2OiX1L
X-Proofpoint-GUID: zSIgAfLBoKIlhWGsUv2BwuJsCS2OiX1L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA5MCBTYWx0ZWRfXzGQH4hUdbOnS
 aqbBP1vAHLurT6Lk8wLuCE3eZQgJGe996yLfcsc1mFm9DWgcUobDKD1zBbnuvQ0T+MHifkz9Vet
 BGsKrzqvFnem7gj+RykjU1MUmFVyLCfB6pxdhGxKqrStX2kx0/OstYAhHQa28XZDifqAvS4PeR2
 StAb6R8TKt1FkGezQEo44v9fl0ln3Jxc627atfWxO4j+nNfUFXo5qch/On9L6BOqUVEZWq8EaH7
 FGz68FKxTBt0xXCNE2R/E0W2FLbZq/EgynA/w8H6AIYc9dfcBwjskgoUZsPcsYmi5cskvGpN5eV
 ZxQTT7B80TaqllK0aBzJQjpxZ4k6cgUo3PhVMIVEIpASHrVXQpFHdSjL3bRbPzNOPfLqjqoNgmp
 SLWNaHlOsLv2a+jRg1jm9FXSRPnu3jjZp7zpe63JLNccu9R2fW4yE45K5Qv1OtGY7YLO3CZqOox
 cHORKyTmc7wj9/MVPwA==
X-Authority-Analysis: v=2.4 cv=acpRWxot c=1 sm=1 tr=0 ts=6a326d6d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=LDWERgqoa3hHt-U3m1oA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170090

On 6/10/26 8:29 AM, Vishnu Reddy wrote:
> Add iris video codec to glymur SoC, which comes with significantly
> different powering up sequence than previous platforms, thus different
> clocks and resets.
> 
> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/glymur.dtsi | 118 +++++++++++++++++++++++++++++++++++
>  1 file changed, 118 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
> index 20b49af7298e..42bcd03c4d3e 100644
> --- a/arch/arm64/boot/dts/qcom/glymur.dtsi
> +++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
> @@ -16,6 +16,7 @@
>  #include <dt-bindings/interconnect/qcom,glymur-rpmh.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/mailbox/qcom-ipcc.h>
> +#include <dt-bindings/media/qcom,glymur-iris.h>
>  #include <dt-bindings/phy/phy-qcom-qmp.h>
>  #include <dt-bindings/power/qcom,rpmhpd.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
> @@ -4788,6 +4789,123 @@ mdss_dp3_out: endpoint {
>  			};
>  		};
>  
> +		iris: video-codec@aa00000 {
> +			compatible = "qcom,glymur-iris";
> +			reg = <0x0 0xaa00000 0x0 0xf0000>;

Please keep the address part padded to 8 hex digits with a leading zero

[...]

> +			/*
> +			 * IRIS firmware is signed by vendors, only
> +			 * enable on boards where the proper signed firmware
> +			 * is available.
> +			 */
> +			status = "disabled";

I find this comment superfluous

Konrad
