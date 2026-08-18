Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC74378D7B
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 05:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787029839; cv=none; b=nv7mn6fqURsEu1BPbaveOnAqx3ASjC1iJj7EHeuUOozYVaTojcT3GaZCQzPE56+k+/h/yqTERFSOuBwVaDBYnQ6jOfTKMGz3RTMS3tgX3MxCyd5vyrKxvPgB0i/XnrbP6w7+ddBQQt/HKm2PMBbE6TqA1QZwtTEpu8aBGZEWwE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787029839; c=relaxed/simple;
	bh=FeAbcPh2BNksaU1ol+KzsK0r4wOWdTJppcdaT2TRPqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sSOGiS573mgBiqCzpkuAbDUQKsyEReqi80JRcB9umZtHvV0Ux9XfG2VP65NwrIa5PiRlHNLTyGNvDSr6ZM0CMbuAa10w0OGgjspeM5cNIkHc+3MGqUriTsmbXGcUuDaglZzu3t1zzsZgUnDsikeo2IrMrRXqOFP4A8zDgUu33y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KeBhHxQZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L1UJLIFV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KeBhHxQZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L1UJLIFV"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I342Fm3298976
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 05:10:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Rp3lIMjCbjVBjSLiXhtJRxpN1gXNwjBR1B2cE1UgyMk=; b=KeBhHxQZWxpTR36D
	Psjvj/wq85jpkNoelRCr7GA7IQCCNbmQzbbatB7HF/+kMmEmIX47iSfKo78TrcSi
	zRz5ZSG449nqvSpSoNWzt68dQQgrrECiYvvocNwe0bQUC3g/OuRn/tEfNoxb24oC
	O9wbXTcyPL56yRHFNej8KVXdeaEMBbZEEIPNDfRrpfJcoG68OgijLhbpI6ejiKy9
	0/VB2vb/qCwEl8lPPqalgpvM78u5K5Sp+CNMHTxsKImtrqVSh44YqH9H+pABffO5
	hr6Tf/yxspMv8oPqYzuJdIWNp2SdtEDSQsiwbvkCPxvoGVfB+nOTF1tlZ9n7YP78
	D4B/iQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4f5prevm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 05:10:36 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84e048a801dso5684744b3a.3
        for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 22:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787029836; x=1787634636; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rp3lIMjCbjVBjSLiXhtJRxpN1gXNwjBR1B2cE1UgyMk=;
        b=L1UJLIFVi38VYseot5c96Nh7KQVr3yr/lADqzD6WsFh+YZ5m9sF7m33BCCG2xf8CF9
         XsZoIqKBDIHBJ2U9L6cB2HuK4YJQd/yp6mDTF9poBMmSEngoogW1lf4yBAEv9qZk++Q8
         eSxoEx4tyMdOLQn2/xI9oYbCk/XhUVs3So4MYoOsdCu/Af2NpRcUlM2BlIsfLZZ6Bzyx
         SyjKrzm626z4nHAEy0MPxev+po8iewnDudgBYKUdliP5HKJcI0eny7DPVr2Kw38Bqx02
         yfXYtDpA2qEs4FWNYiHWg2DS8f63gyWQ2ZY8atGXnD13dA+rIFPgr+SJvC5OIFwXONU5
         L84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787029836; x=1787634636;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rp3lIMjCbjVBjSLiXhtJRxpN1gXNwjBR1B2cE1UgyMk=;
        b=M1nD5aq71ztlFYFpD4QX7odPIUqP3izRgFeq8jKU9Jrt+pd/zWoLxOCzQlJdeE0UgJ
         udP7GJQeUm9vPzCkA4hEwuC08yRhogBZltcIzQoR9T8QENh7f/Oaw+pTOmdiLqowpwyH
         tokJqFZdh5ADmUasGzV0TjquHlL89yqTTJQfsNfgBGoQOYydqDZvmI0PukUXfvBSZDsY
         P20NlBpc/B5xp3Noe0zpszKNNKL+S1XQ4+a4y5r/j8fbr1aVVrYQTBMDGdBo03EgiNyJ
         XtrUhu3kTgD1zIvM7ditegLMAQUwEIX5tQy0xoO2iqlesS/o3SBWq5FXLpAoNTzK4cD9
         z6Bg==
X-Forwarded-Encrypted: i=1; AHgh+RptoW2T9EQsZvnRXS+1XAFktkh4gZ/v3Vn6PjHnyJFYwHnJSmGh1pxoOXXhRybaugz45453cA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyyP6XHlynYQ1SJYCuiqqkEuOmJ5qUcBan0Mg0a3IgXOYy5MaDm
	aOP1pkR7TDjczhjCLb53U7cMYoFLLGQ2j99R+0p2kGd3ImRbVJaJUYLqE9SaNaqZmQ0aQkszBYa
	lg3A8CV+alSc2XHHV+aB4DzBShABJhFenjmfMdchj+BFDf8G3RkUBi+ezcw==
X-Gm-Gg: AR+sD10X/l+c0nJq0Dd53i3NNLcRoV7UAXpRikwEEGyOeJ9F12SuHuXdC6fYB0T1VBr
	BH/r0jXPZyy6ZLu+t2szvNkLyUWNaMcdkofWPALWNXD2PvzEdEh7HYlSpYKLDLo2Uo4QV7xncU/
	d/J8Lch95zSBwZsg9xhldXdOF3yUGHQ5xLNQPv9LuOEyebsqI9afuI7kl2AatV/lU1YkMvCRw/V
	sUEpNbXPpZevDg9BHc5hgnf2sNSt/UzjoHwJel9/gDeGEr9lmW376+hiEFm1kyQZJ6lqj/J56Tf
	MWjNaFW3+OoOFajpVtPd+nJwf2H/Na+ONp92fHhS0ZwHLfDKJsUYhEuOCwVUUNueasyKzCrTcNB
	oVZzimhSwEf83LmxqdLfaltNgAskoMw==
X-Received: by 2002:a05:6a00:188b:b0:845:e8b9:347 with SMTP id d2e1a72fcca58-84fddfe099cmr29499673b3a.13.1787029836095;
        Mon, 17 Aug 2026 22:10:36 -0700 (PDT)
X-Received: by 2002:a05:6a00:188b:b0:845:e8b9:347 with SMTP id d2e1a72fcca58-84fddfe099cmr29499576b3a.13.1787029835654;
        Mon, 17 Aug 2026 22:10:35 -0700 (PDT)
Received: from [10.219.56.166] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851b6ff2232sm1015652b3a.52.2026.08.17.22.10.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 22:10:35 -0700 (PDT)
Message-ID: <89ec74da-15ed-4278-b651-5c753fa4f146@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 10:40:25 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/15] iommu: Add QDA compute context bank bus to
 iommu_buses
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap
 <rdunlap@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling
 <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>,
        srinivas.kandagatla@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-5-69a02e9090d4@oss.qualcomm.com>
 <20260817134416.GA1415075@ziepe.ca>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20260817134416.GA1415075@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=S+/pBosP c=1 sm=1 tr=0 ts=6a83e94c cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=UlZBYPnkdO8YS_jrOJUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: UOy7c9iqLcS8c5KwlBsALbTR1aomyOWY
X-Proofpoint-ORIG-GUID: UOy7c9iqLcS8c5KwlBsALbTR1aomyOWY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAzNiBTYWx0ZWRfX5FnkXI95dVOQ
 q2ilrxrb3CXkOwhokOPqHiC/sKeheSEUyNO+Vc2yFwGcjPA4G8Wzx0TMQJA9ebmpQDYecIbcmPe
 ahRykkbiXgtsgBH0qUK8bkogg/ASvJY2WXn2u+r641BQnH9K5CGAf9Q5UENvv3DomLNfSj8E6qE
 /xXJwDLC4gdmcaHhjSjRPGuqatUJxWzZA+BkRIUxvDefPKoif7HNTjMqdjq/SQiERfwjnLSEd7e
 pmKPXLV8yaE/Z+9SG8quP7u+aW+TePsT/cnYP92k/r6NraTy0yW1GKO+II4FsTtBLrZPCQlp5ct
 fGkk3tFZLTdAmdJKF5kqFcFNkIldO4wlovxE/IYO8VSnQL8OHt1J+tB0m+nYZ4qwbWEk119++Z+
 UNwuOuNSPcBJo/QRRwzVjMGyH6t1kupoiYCsFMYfJMLE5GglrOD/WM/2P/5JC6hqmdXsHdglN5G
 vYYeKZOlduE1+u1CnSQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAzNiBTYWx0ZWRfXxSEDDNOCgSfi
 10cv6wMup40qjdWufJCni1YHogEU6ROld0W6/g5IPpE1DeRQWlyyrVu33vWcaW1S14Ui6iQ2OB3
 g12hBT6aEJsf+PNacb27twszJ3gkuj4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180036

On 17-08-2026 19:14, Jason Gunthorpe wrote:
> On Mon, Aug 17, 2026 at 10:17:40AM +0530, Ekansh Gupta wrote:
>> Register the QDA compute context bank bus (qda-compute-cb) with the
>> IOMMU subsystem by adding it to the iommu_buses[] array.
>>
>> The QDA driver creates synthetic devices on this bus to represent
>> IOMMU context banks (CBs). Each CB device needs its own IOMMU domain
>> so that the DSP memory manager can enforce per-session address space
>> isolation. Without this registration, the IOMMU subsystem does not
>> probe CB devices for IOMMU groups and of_dma_configure() in the bus
>> dma_configure callback has no IOMMU domain to attach to.
> 
> I didn't notice a clear explanation of the proposed DT schema for this
The context banks are described in DT as child nodes of the fastrpc
RPMsg endpoint with compatible "qcom,fastrpc-compute-cb" and a `reg`
property for the stream ID, this is the existing binding in
Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml. QDA reuses
this schema unchanged.
> 
> But it looks awfully similar to the other driver that was creating a
> kernel synthetic bus for actual real HW, that wasn't well liked.
> 
> What is this for? Why can't you have a normal DT binding for the
> iommu with normal devices?
The CB child nodes are not separate addressable hardware — they are SMMU
stream-ID assignments described as sub-resources of the parent DSP
interface. Using platform devices for them was explicitly rejected by
Greg KH [1] and subsequently using a generic shared bus in drivers/base/
was also rejected [2]. Greg's conclusion was that each driver needing
this pattern should have its own custom bus type.

That is exactly what QDA does: the qda-compute-cb bus is a per-driver
bus type with a dma_configure callback, following the same pattern as
the existing host1x_context_device_bus_type that has been in the
iommu_buses[] array since 2021. The bus creates devices synchronously in
probe, calls of_dma_configure() via its bus callback so the IOMMU
subsystem probes them normally, and tears them down on remove.

[1] https://lore.kernel.org/all/2025062434-reviving-grumble-1e53@gregkh/
[2] https://lore.kernel.org/all/2026042442-luxurious-antonym-f20c@gregkh/

//Ekansh>
> Jason

