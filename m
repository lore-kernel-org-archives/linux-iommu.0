Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3FD39B954
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 11:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784892638; cv=none; b=YuXBaWihCul9WiMrT86vo9FYBzNM4geobdC8my9OckaR159HxfqOHIka13MX6MqWQ2DWpSINv8wKcUFiYKCfaUmnBwWCm6HQcEwpV+NLODOG+NmsOCbwzCX8ArvpAV9FwT0PTibe0tJMRkWw8Q7qE6AjkiGYDvx7TTzSKgqIRts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784892638; c=relaxed/simple;
	bh=v9CE0NZgeV5DlI/DjX5s89yBEYtQGbY9EDY4vDxz7xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4OQYfcCTWL7122OA0iVh9czBwNP5fvaaGOnhp67lTHTWKGbj3DcclMHZ8+xI4Tfhz1TqPDlUaLkTP/7BlbwBN/YLC9oj2fJJclRnqQJKDTPU45ol06tqor68zfCnIvLGY5xnVz2qVRUHTYjaFqbxAWH1LM+mK0qdY08kayrWfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AzYsxphn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IavHyyQD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AzYsxphn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IavHyyQD"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OADaQv2720682
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 11:30:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ifhK8jF0fZ9P81kr75lgN2ov
	xxuOE8Gi3gW8iorSRjM=; b=AzYsxphnwEvoFrjj2ct2dVpTyT4wuylQpTaRYmk9
	YwYg6Y2GF7tVOo39jVowCMUiobRWJ/NOoqfl0r5uCU9w7hRysnfmN30Vi+hGIjNE
	Qp14rhVgwsUu2v6jVlo6bJ4Htd9c/L1VdD4Nkao5Ep75EfH9nrso9KUtrNqSkn7T
	fRenBAkO8Ql3W397zwOCke9LdDKe/WfcKi/ZvvsEu+AMzLoZlZbhe8OfTyruRc6U
	eOI8qlgT8zUfjmLnQajcrftnlz98Np+ysoCxK59j7r5EDmcLbQWIvAwsc45xGifn
	DMq6efJCE4u2nWodMALhfjOLi2mft+PW2cvNL0PjgLKQKQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm5yagamg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 11:30:34 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52769fc3f2eso5330141cf.0
        for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 04:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784892634; x=1785497434; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ifhK8jF0fZ9P81kr75lgN2ovxxuOE8Gi3gW8iorSRjM=;
        b=IavHyyQDhk/kOAyFhQ+HrcVBSE92NbMQheGP+U0tgBWtKa25x71W1sA4xAI+d9v1i+
         b0aauwBZKo7QnEXuPsCicHXw4uXbJTAAozPa/S3wr8mtXTQmIzfueC8Tyk2LOQ8WEpjj
         xy+EP6MZEU6jcAlNKAhulevMS5DZfcJHb/7AWJ+YahE4aGOUJevkEmH91ZYET4nbGDrl
         rDW6C+M54IrkWjRgcnJIyjz3tjrN6RMXgPx3lrb9VFKemdovfoupMjNBIr/c4AyW4Fhm
         kIsNI+3WcTJ3p+/htmXB8x96dKMGpQmiSpAXTYpvDNvax02SUXAZZrEQnnbwWjRercxV
         VSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784892634; x=1785497434;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ifhK8jF0fZ9P81kr75lgN2ovxxuOE8Gi3gW8iorSRjM=;
        b=siBdOJKIFXRpKAt4YuLy3tNBNNZ/KgGfuKzg7a3APvJ8fFemgwm3SQbkeq0Q2vtDHT
         Uj2spBq/YKHzvSf93A0KbSC4cTbWEh7tIw51YCQjolBrOSELGq/s76MKFLn4L9JzlsKN
         F0UFz/A/SWpi0Uf5EGokzNvopAI2BqG9U+kUsyPxhDTitl178M3G+3OxmE+LcxnpQvr7
         hysiuy6cTysS7/Uuv3DcWsMbfEi3zwi89K7Kv3AWRCj52VQ+gRqpzN3Z88fnOs3/vAWk
         zU0dRp3wq8iRjColl+raaCNH/4yZhkp9QkNrfc4UY1FaU4Wckwb8Kb8CnORlcxXDJ2Av
         lGpg==
X-Forwarded-Encrypted: i=1; AHgh+Ro6AkBP0XkWvgjonqxdl42EOWTW3Id4e2ruez1Ky/nAZpjk2hqT2gmBHp0uRXX8XOF6qggB9w==@lists.linux.dev
X-Gm-Message-State: AOJu0YydWehsvj8AIwKeu50tUt+2ky4nRo3lDOJ24odGkuI/BfzZU6Os
	SuVx6qKYRxyAf+rG+FdvGNJi8F39CpeWnNiC7Pmz8E0lf0Q669+SFJZ3o8k+bu1c94lF+7sT5sB
	MYljwf+Cn8zwC7J1FGktyT15txsy/lA7c5XEwrYubfyt6Kba9YLrWYsJvWQ==
X-Gm-Gg: AR+sD116Iu0fDapljkiaautcVya8d9ZYz2W5GT5YVdY7R0az7PU/fd79Tbhi5a2h3/8
	QCWklVv08OYVEpg0PbKrgMyDOpITkMYBuiDdL7e7AtSRaxbxqyezqCau/dnIR6AaMktOY+uI41C
	EtNesSujYgwrj9ujfoIDWkQFVMtNAf2esLSBOyK4u+Qj7WKJFE0YFacKtcopFhf7xk7G3ZPjMNr
	pXLAgXV9KzYNLu/Evjf1VVlZ/fzAjSNBoNLHo6Okf3Rf4XjQa+yIuDPlMMr9tD8gPm15E5RoPOf
	rDEUTHxXB2tVIFmpcqEV82+4n+9NiBwEf8LSEX44GYoKvmoGGGbT5jwN8mzZOAMUKe7ZTK3OeJw
	U8G+YiN835csgfqwy/GAONW4aVVXFn3A4sn6SGz9TWwTxpZg3WfQTxftyfwmu3AlSsnjekm0JM+
	d3fjulbnhWtIRUzA==
X-Received: by 2002:a05:622a:1350:b0:51c:83ee:e42e with SMTP id d75a77b69052e-5283dffc205mr65522841cf.77.1784892633947;
        Fri, 24 Jul 2026 04:30:33 -0700 (PDT)
X-Received: by 2002:a05:622a:1350:b0:51c:83ee:e42e with SMTP id d75a77b69052e-5283dffc205mr65522211cf.77.1784892633423;
        Fri, 24 Jul 2026 04:30:33 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2a9b8c9f8sm1459645e87.14.2026.07.24.04.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 04:30:31 -0700 (PDT)
Date: Fri, 24 Jul 2026 14:30:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v9 01/14] dt-bindings: media: qcom,glymur-iris: Add
 glymur video codec
Message-ID: <frmpjyrk3epa26oebskil52sony6k672a5mkcamviiz3vdjlj5@eenvztuikja5>
References: <20260715-glymur-v9-0-8cf2cbe12a07@oss.qualcomm.com>
 <20260715-glymur-v9-1-8cf2cbe12a07@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715-glymur-v9-1-8cf2cbe12a07@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEwNCBTYWx0ZWRfX3cUtWeEJVoYN
 +piXFMvI2EfX7eTSYM8HPJ1OJFleoDIrzWN9wIKlH9SrkEIKqPZrmFe0AYvzWZmJJcH/ep9Ya5K
 P7Oh+Nf5v6YH1S6EKwEzYdFJQkRA6tw=
X-Authority-Analysis: v=2.4 cv=Rtz16imK c=1 sm=1 tr=0 ts=6a634cda cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=l6FLTy858EcHa7FfVjsA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: OAHZLDljoW6irwknLil5nQlWCA1XUgPf
X-Proofpoint-ORIG-GUID: OAHZLDljoW6irwknLil5nQlWCA1XUgPf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEwNCBTYWx0ZWRfXyawbFus32Lc8
 jK7gqX9l2eUnbdeMWquohCiItGNOJRNxEFB6UEILcOX4Gkm29YWWlie3aNfVXSi22rXdihabP3e
 nxJI0F0mHexZp9O4RCTIf+ytQeVRb7RFzDpgIHSQsoYwpHJPAOtiISv3pKTOiGtUyd4lp1D7KiK
 qIMLs4SoLJTzr7+5EScKXPVMMR3XpHk0SO/7c/YqJCxBAeO6qrpY6FKOmBYcm1tLII24lc8KvsT
 LUSpnZpYHBXCiDYnfZN2vfUT11XAmUwr55e41HI+fEbFIzEFXyw45zsXulepdIzpJI8UuNnUk57
 +hNPEDQH9Gdgq/gN8EMZq13v3NiNW2w40hzpHt8+OXiN2eZNZrRMtbrCgmfR5bnNM0HQ8WgI0DU
 LfWHmf4Z9zB0Vvohx7zKzC7nzq69hhA4P/lpQDDHliUqVtPkA9Ckd+HX2QVgZqkdDF7P+l1KcJB
 eWi+gr1xFpFkNjz3M3g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240104

On Wed, Jul 15, 2026 at 07:39:55PM +0530, Vishnu Reddy wrote:
> Add device tree binding for the Qualcomm Glymur Iris video codec. Glymur
> is a new generation of video IP that introduces a dual-core architecture.
> The second core brings its own power domain, clocks, and reset lines,
> requiring additional power domains and clocks in the power sequence.
> The current maxItems constraints for clocks and power-domains in the
> common venus schema were sized for platforms available at the time of
> authoring. The glymur platform introduces a dual core architecture
> that requires more clocks and power domains, exceeding these limits.
> Raise maxItems for clocks, clock-names, power-domains and
> power-domain-names to accommodate the glymur platform.
> The glymur platform-specific schema have fixed constraints for these
> properties, so the common schema only acts as an upper bound.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  .../bindings/media/qcom,glymur-iris.yaml           | 255 +++++++++++++++++++++
>  .../bindings/media/qcom,venus-common.yaml          |   8 +-
>  2 files changed, 259 insertions(+), 4 deletions(-)
> 
> +
> +  firmware:

video-firmware. Please follow the prior art that existed for venus.

> +    type: object
> +    description:
> +      Context bank for the VPU firmware processing domain.
> +    properties:
> +      iommus:
> +        maxItems: 1
> +    required:
> +      - iommus
> +    additionalProperties: false
> +

-- 
With best wishes
Dmitry
