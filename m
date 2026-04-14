Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54FB3E717F
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 14:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776175856; cv=none; b=MTbnudPs6hnNb/7wdatah8v7NvPAb2B3WrfRy+NmQqjYJk40sdpYJkA9+Fvl1bdsqZGJnProRHtrGGTE0XxOr9d9ErBW7gy6omp3cdGAfwgLFrkM/jlcTLHvCu6/WX3mA5Gp3fTLqc1c9zrdF3jOcBNj/i4LkKJYmDjDc1uLJcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776175856; c=relaxed/simple;
	bh=wRoc8vqU+Do3/rxWz0CWoGTRrOvwHOWj/Ks+NtJU8Ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EIqNUE3m6c2epk1bpDOiG/Ygna0FW/PIWo2RmEfdkaJu4BX1F1uv0BaFGKeSe6cnv+XGvmBj1ajcAlKhuLMhv739g5eak+Hg07klu5zYstjIfuRhZIbbuy/1p6LNG0PW1ndXj3QLzh4llmo5WxGeKPa0/7hKS3UIUyAHpOl2ogk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MnP120yy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PFdJPgHV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MnP120yy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PFdJPgHV"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EBlksl3157473
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 14:10:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YKQ7jg3Wkyd4r57T9ATozmR1799CYsFYrJoZVTakFlw=; b=MnP120yyUxKXxWyH
	Uh/UFCnxVbwpuQevgHOeQ1ng4S5LscTrPexdQoyTfxEc8c6TwZAhfvJPI8jdhvXi
	sH/l1Gx6Y36NwVnx1ZcZWTEq0MOYAeyAWW78zAFvKQSbFiAvwYFYqS2/pEmFRrGo
	8MwYLWDDbRpC6z22vEgWUTkWElTjf5141BN2lJ3XtFx9qUQ5dupkMaGkrikOrgwN
	wc38C/F1pTrSTlFCwG2hSqgZIysNph9xp/P8fqEYmTF1VSFnzUOQB2ZZmYHnFXj4
	5O8QRHL8Hh3DWLsWoPp9Ak+K5HsHf9BgJjIxLjB8oiPFEPdLQ0PWNPm8XDhkXHYf
	X6gcSw==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh86bayu8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 14:10:48 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-56d85c53a3eso452518e0c.0
        for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 07:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776175847; x=1776780647; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YKQ7jg3Wkyd4r57T9ATozmR1799CYsFYrJoZVTakFlw=;
        b=PFdJPgHV2F7EN9qTDjZfa1g64dLHlcp4ZHadXHEhhb2Uz/HUyvyTLqf8m0Kv6n3dxq
         8zJI46DYjt8cXw5n9qd2eAulgs2wFyJjbCB14xJrd98/XwF2b10qBv7NBa6WU5N6rKey
         q0YXoANw3vegA0YyVqvC2tUnkq0BW7MdNu3gg90KeN5b6pLI1ozKSwJ7VZ5/FGdOVKzp
         UpDm2Hx/JF4hJxLosv28iPBIpTSSk8TZjZGVB3Hs1TJzI8vYrp9Q6JevD4Mu2xSFgNYi
         z1fq6mAYBU6b90JOKfXtjHrwCMU529gVpn6sew69CHVGVw8LDQnVbT2LEi8rCCHxYAnw
         VDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776175847; x=1776780647;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YKQ7jg3Wkyd4r57T9ATozmR1799CYsFYrJoZVTakFlw=;
        b=geCtU+7OVT/gmOxOBFMJOrq+IqsEJVAD+9D+Lci15ng7pwrKHqdB5tUqUtaT77EZn+
         jsls7OSvgTeks4dRfBevejl0hOtlVyPAuDnWAnTzUGCB1B0iDoQTAscTIATH+D6gwXxs
         GsXpQyCLbCqdcM0tuc+0/jk6lBbBOEgtMkJ7yuNBm7yoloHg7FpHb8Ru+W1XVuKMXiRA
         lcG9aXisohIR7LUpRnOw60XcoOivoYyMNt0h09as0Z/G79k14v5DDQaIlhMuy9QbcLBr
         MGGQ0i1Nij1ZTTcWxGtzTyX04dhBgDaPg3TMlYoFJxQWtEidN9mjvFEhWBAOp7Fl685Q
         hcFA==
X-Forwarded-Encrypted: i=1; AFNElJ9Hz+8nHk88jZM7mt3rlQLlWEFRgpk6ZKWN3XHmkHsC9TDqofTdrR/guGxGz0fEuX//PQPGow==@lists.linux.dev
X-Gm-Message-State: AOJu0YxB0ldWBVxGc8Hs0Jd0tKpjFOee/iy70IIQXXsdUPXu+mOr+lbD
	gxDTwV2xqyx1Bjk7z/FcbJG4hW3lWo6eyFf2aQTb2QAqHNFomqGU9XxL7kBoJpOxCZn+6NYFYdo
	MYO5+kqTiVyHCFMRfKZW/OC5ijn7A/4lQqgpVpXKOT4/GuQheHjklbc93nA==
X-Gm-Gg: AeBDievXkOLXQ/Ypw1OKylvDV8mZ+O0YuzrRqrwhRx9D4qdCGbq5MnMwNrFqQrpTRIg
	keV2uuuqjRkDMf2lJhJbxRx12NPxP8FSjevuOHpkfMTfncdtlXy7BwF0XcXN83+42aRnGBvU4zh
	DVkY9aoDAZlDiDWvSYQ40tsOuqMHlmOocyhLZa9P7q5KmpOllKESva2yeTDijpaO3Y0wt8s5qZI
	/uci9+8WiQSfiAD7diDg61Q/+OWwFyfv4F7hJ9BsuU/2LqB2dyUvV+9SJSfF0q2nZr4dgklbpJ6
	aPSCCywTpwA3j6O5FEQy5n60S+inwKmlwUavO/QeNxKEB6NHVm2iczneALjzbGg2pq262ynE3jt
	Dw0LcSNFollrMHd27t5AFTTt3C1bF7+ebY31Hm9zYgorH8D9JyZrppH4SYgL/WQZfXUrdg5/iKQ
	0UPCrAEQ6W8VK8rg==
X-Received: by 2002:a05:6122:84b:b0:56f:5b59:5226 with SMTP id 71dfb90a1353d-56f5b59611emr1679952e0c.3.1776175847442;
        Tue, 14 Apr 2026 07:10:47 -0700 (PDT)
X-Received: by 2002:a05:6122:84b:b0:56f:5b59:5226 with SMTP id 71dfb90a1353d-56f5b59611emr1679918e0c.3.1776175846929;
        Tue, 14 Apr 2026 07:10:46 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6dfd88c9sm417722266b.23.2026.04.14.07.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 07:10:45 -0700 (PDT)
Message-ID: <ad4f1000-cdfa-4c21-be9e-87cd65f2739d@oss.qualcomm.com>
Date: Tue, 14 Apr 2026 16:10:42 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] arm64: dts: qcom: glymur: Add iris video node
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
References: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
 <20260414-glymur-v1-11-7d3d1cf57b16@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260414-glymur-v1-11-7d3d1cf57b16@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDEzMyBTYWx0ZWRfX8z/Xm/Y1/aqJ
 RxYs8+lqcD515d8xh3mF60CTGCpWdHt80CkxU4V/3U0Zr2dsteKnWoFdQ/neP398rQ+531UqYxo
 EaL9MOiSlw+cHTv4OLKUatyYv1Y+CNQn/A7IL6A7q51Wy9he2IAbS3IHbRoYY1lnnw+prgFK4Nk
 sxErbH/+i2gDGP32c4AEtZbpUovsvhZ7gd6xPFR2AT48v24dtFknb7Xt6cS59inNznfm67ag8mo
 Zuq7LaeFjbvB7jAH+fj0o0122XB87wZ9rwXwZ5cl8yb4an3aBqMUcPeS95bUdsS6+dX0ZXpp8oL
 aLy61cBjRyYkUMYUL7yPhFkeE0xmn6EAdxNYR7c+loGYUFan7blSs0WlZOYLaZsIdm3m3BR6fPQ
 9Z8l8cxtdz4DxTIfVM0IURlDdmbtyKKoR+a95Rw0yrdhM79vWaFeP6Y3eEaFi8tgmFmD+wVjcU9
 VDzl5xJmua59D33Av+g==
X-Authority-Analysis: v=2.4 cv=MahcfZ/f c=1 sm=1 tr=0 ts=69de4ae8 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=xYufHl49NKEuV1FEiosA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-ORIG-GUID: FwRJ-KbPJnFU6fueamDZU-D41ZcHi2-J
X-Proofpoint-GUID: FwRJ-KbPJnFU6fueamDZU-D41ZcHi2-J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604140133

On 4/14/26 7:00 AM, Vishnu Reddy wrote:
> Add iris video codec to glymur SoC, which comes with significantly
> different powering up sequence than previous plaforms, thus different
> clocks and resets.
> 
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---

[...]

> +			iommus = <&apps_smmu 0x1940 0x0>,
> +				 <&apps_smmu 0x1943 0x0>,
> +				 <&apps_smmu 0x1944 0x0>,
> +				 <&apps_smmu 0x19e0 0x0>;
> +
> +			iommu-map = <IRIS_FIRMWARE &apps_smmu 0x19e2 0x1>;

Shouldn't (almost?) all iommus entries be instead bound to a function in
iommu-map?

Konrad
