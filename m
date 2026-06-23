Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5156F30C14E
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 16:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782232580; cv=none; b=iUAXueIxf4uPUSHDCl9XS4jUR/5TAaEXwTyfhsztN/lCoL6ZFUzTjit6ufY+UbO69VyjjRTdwzyIG2k52/ErzdR84mk8D2uDyKvRhIhWvn11y6GAwO1dG+ofiCcd9WvD4aNKGq6pb0QMtOhdj5CEfYNtW4ylyGTzAdxot9y2mKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782232580; c=relaxed/simple;
	bh=4SwdgIE+bd78iV3bxadhFE/SU6oy8jw4xjm+8xIaN84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I204XZmkqtpjSR1YSsqM6Xtd2viGyEE4M0K3a5l65XhLMsoi2+DyUhGNjYvsThMvWSi286mYEjMwYeBzb0MNfJJ7gQiqp2r0r49vvX6OEbFzpvEmKAuZM1Dtvh6IeqSxXSNpiKGWYklcsEBX1AXJsfMPgr5tFgK/GvasNbXubKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hBFwZWrJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bDk1pY8L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hBFwZWrJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bDk1pY8L"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBZd6T4052485
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 16:36:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xA0Pw5Ltim7xa7TG+yFu6in4RZDMahQ0O7HSJsSCKNo=; b=hBFwZWrJs9byP+c6
	hYYxGCrOpcZvXsOg28ZB6vszdjmOpDg5xjYrgaWLAB2QRTDOU08+5R/jYG5PW4FS
	oxjsRSNDoQUVy12asRr0bOypqvLuU6vrk6G47EpAVfFk8HLlyP686H+77ABbEEYA
	CcxHT/jCVFeID3l5ZwEIzPeOxzdL8PlqaFaPe+NsskCv+8g5VF+O3L0wumSlg+dE
	KtVB6yhhIIBls4mTfu2atPJbChIapUxE/rqVXgMsopdhWqe6SclBORTCeYvs1uyJ
	MLDiUDeHXl8Rn/zAi6anLruZIogLZQUt//ltG0ncMJjjmUWxg347N1RjLaDIdZdy
	xIcNVA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyr9ysj0p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 16:36:18 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9157b3e5182so7578385a.1
        for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 09:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782232578; x=1782837378; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xA0Pw5Ltim7xa7TG+yFu6in4RZDMahQ0O7HSJsSCKNo=;
        b=bDk1pY8LaFNrncAWtyV+wUVqc8F9p9DIQwdyD8HwFX4LnplaQr1mOv8jacolJIw0pH
         LchvYE7m2diYWRrueTW3CT7bup8piWYqc+bMI36zKjygThn85q31H68NAjE1M0F7r8A/
         2gZSdPa2wXyOR51hYUdBV8Vy/zT5JGiqQBvfEmkvZ3kMeS04bEHjgsAyIRlCG2Njv5/Y
         Y9Hgu1ilQsLFYbU+1n2C/229bArv0mit0s9Kw7nNw+qEcFpAXAqVnNZ/hIQM6TCy+gl1
         bKl/Ge/JwqKhua2YHeJpspXu9mCeClKYtqOA/WGrqdcuTWfiTSuJABDxTPcORULSj3Ac
         tFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782232578; x=1782837378;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xA0Pw5Ltim7xa7TG+yFu6in4RZDMahQ0O7HSJsSCKNo=;
        b=ZBAbtNJgwQnwTGsfNluvZ4fp7ywYpT5BoWDZhgUCAMfjBK835eacQzw2pd0nU5dxtp
         vodZiciqnFwKBooEpo7Zv+FRmRgHoOudcGka5eHUS580LNX3IDcws0DhH1YsVPueDcut
         7Floqmc1dHOb5DF1KjmlBC/2JpiPDiD1yISxCraO8V0i94XQFbwLKshow0PfyeChM3lo
         GUqIrCmr7a6w7xCuK5NVTZyg3ja03OMVxmWgo27LmopfBFi95ky0YQ5CszuQF+oXiIOG
         b25U9SbL+qxb2mVp4TBcFrffVSdalcOyh4NsL91vaY3rNrN0qW+4+khkmiIUe8VxibIq
         wP0A==
X-Forwarded-Encrypted: i=1; AFNElJ/T4jWNr1jjGNHkYInXi5kO6VDCd9MtXiEPW5rj+pBuGOw3Mq1ZAf/UPC56OYaczCVv0ABMaQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxSXN8b1MwvlsYI3Vawyd0GlU8wSdonNJMTYZWzyy4GQEvfSq1L
	p1VMozSuYqhD8bkwyVyFzR8FMlGdz0TSiMitYfXltBOB7mDyVFeZFH62dSpS7QAvOubVYUxL3B2
	YwllsZ3DoC94WveGkm5qmnHZCIQYsvDIWfRpLz0ZmAWmuSo7p/eUxXG/BsA==
X-Gm-Gg: AfdE7ckpYYPNiP8UqTIQe01ce9TweLJ7+/54WUohCzv8CkuBjxHzpWFojGJF31JtUTB
	MsIt+289pegYXLNyZcA//vDV/CikkG5JeKIa1WRzz6/udBQFINSh2LpRT5Hy+lk0EzKFBOke/F0
	duoCiI4GU5wgyY3DIrW/EP3UxVaoMwF06GtmRbnKTCVMY1zMKxZDLFgWR9v1aznJnsuavkQcfzw
	0NthcFSe2Dmkl4RfDq9ZeDfNomf9496ym/9T2XGBk4uKWt5AnkjKeNQ/z8xesCTeljEb3+fkUcB
	lvCZK7oB6yl2cwO9u7/jsi13XsDyBu21TpIh83FCuzMnz12tjto25zLmbwM6hzMyj1rx7rGZ3ps
	hvajTE+3YBK4Us0QHVWqJRoA/QywPuvdcSDE=
X-Received: by 2002:a05:620a:6781:b0:926:e8e6:3c28 with SMTP id af79cd13be357-926e8e65d56mr123280785a.7.1782232577694;
        Tue, 23 Jun 2026 09:36:17 -0700 (PDT)
X-Received: by 2002:a05:620a:6781:b0:926:e8e6:3c28 with SMTP id af79cd13be357-926e8e65d56mr123255785a.7.1782232572407;
        Tue, 23 Jun 2026 09:36:12 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad69555c45sm943642e87.36.2026.06.23.09.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 09:36:11 -0700 (PDT)
Message-ID: <45794082-0c86-416c-a2b1-76ab4f20d82d@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 18:36:09 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] iommu/qcom: Enable clocks before hardware access in
 qcom_iommu_ctx_probe()
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260623122034.1166295-1-mukesh.ojha@oss.qualcomm.com>
 <20260623122034.1166295-8-mukesh.ojha@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260623122034.1166295-8-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=JYSMa0KV c=1 sm=1 tr=0 ts=6a3ab602 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=Yd-jd7UEqWDYs8h9-TIA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: oYjNfR1jx5ABx8CUfBCN10Z3V0wGdr-1
X-Proofpoint-ORIG-GUID: oYjNfR1jx5ABx8CUfBCN10Z3V0wGdr-1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEzNiBTYWx0ZWRfXyZrb51hv32sc
 gfY+BxjanDpR0gDhvUkY/xlr+5I2FfW0YbAP6O+IcvIh+Lu9ngewC1Ka/Me+XNaNFLh737tNhEi
 R0BNZYjiq4RfQxj5N0A/cXLD2V/jirydBvzCY/WF6xjsyN/eSq0MCnqlvw5ROk9M/uBenNDvSt4
 Lt4xXX7dvPX58+WIz+YzZlIEqxZ+FxMseAUp4Fx6gq5ILx01viYkkV9fY1cVUlIRUBL5fGfH49A
 ANwXziY+4m6fIkKh8jxYYmWY/Sy9PxfMDuvKkqqHvASQ2DVHLEF9CCHc0Ow3YZTYXwmz1D1UKo+
 k7IkmNADIFACC9twxOlUeuSLvpsyqGtxwCSpLdd528SsYMow506xTHdmqxaCqpU17dpENBtgekq
 1p8qQAHolGXx+2UV1/TI+B0Yy9o52BRVmgv0K79MLvHoYSmiF/LmVycUi5VkWjwqvYPvxbUEehn
 h+gLQiSL+DHaygeM0iQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEzNiBTYWx0ZWRfX8eaKwzEXdkf2
 X7HKg1nH8+vGvxJIMaonr/NyTB4tEaetKKqehCVbrWbicRGbax/hzVxRN2ki9JNe4gGk4aoKA1h
 w6T0GaijyGA7XmbDzuJzISlh+DkUFks=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230136

On 6/23/26 2:20 PM, Mukesh Ojha wrote:
> qcom_iommu_ctx_probe() reads and writes the CB_FSR register to clear any
> stale IRQ left by the bootloader. This happens during
> devm_of_platform_populate() which is called from the parent device's
> probe before any pm_runtime_get(). The parent's clocks (iface, bus, tbu)
> are therefore not guaranteed to be on, making the register access
> unreliable on rebind or after a suspend cycle.
> 
> Use pm_runtime_resume_and_get() on the parent device to ensure clocks
> are enabled before the register access, and release the reference
> immediately after.
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
