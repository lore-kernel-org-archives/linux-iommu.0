Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E134825AF
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 10:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764423; cv=none; b=Q/WObYI1C5tP1oramS5QgROggaBJ7WihYVml5w74e+8u8OVi9z7j+9oSsxrv5sXdvOf0tFb0SZwkFNP4zaonq1Stc+jYcPt2LJvWEuoIqilIrUpcTJnENTPP2M3D5FsQo8jHs3Bff3XrHG8HZAV8a4nDnHR7Xb7+VQe2IlexiKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764423; c=relaxed/simple;
	bh=7R77TQqIMmdGoS2eO0kXm9TNz0zOrN2y4HHSkA/2YWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pu5QhsGCk+o38wAWFBz43nQGXdFKivzVQ5DGLIkTWeQuFkDSesXlWVR+bjo7P8kI4V55zmmu73bpPM4DK/SdekQZoQD+9p6038VLi/tIabNdBQ6hAvEdIK4rS5Im6gs8IJqga2rP3txcjv0YDxEsJEE44CKIpbalwen81ogGZDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XI1nt06I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TUcXXhO8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XI1nt06I";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TUcXXhO8"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68U7dRiS1556144
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 10:33:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oGZvKGq2A3pM90buZ2VNpRfUMGSk6SlqzeIIAOV+V2w=; b=XI1nt06IC4Gfyq9B
	JaF7mWhGVLDxYdGSxYjijvlM8YeKzgINZOmi8J67i8aHtGJWksB1hEPIV4ig8K9Y
	7sp7uM28bWnzm8YEbZG+EabfsxVJ5gmmuwl8NQPz9WDmbJ0zje11WAEEJyAkBHVJ
	GBnhrWjuTBdj+8llu4FsgTfPySBU0+56wp9sTVcxWv5epg02/kQzbDiyKTKtWENb
	4neqAvUEjWOvc5nxH2sZnbcqnfMiqX8dYXTNJz/PYEf9XewTJlmpt1ZbxDTlJv5c
	ewy6wCextAHBTubv1xxsUA9LSABrAESqb2b1F0Fff3uh8ug/Au7ScgXVwICz539D
	8V2UlA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0x1c0sxx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 10:33:40 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-939fc317691so100833185a.3
        for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 03:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790764420; x=1791369220; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oGZvKGq2A3pM90buZ2VNpRfUMGSk6SlqzeIIAOV+V2w=;
        b=TUcXXhO8eGDlueB5Vl9R5oz8MtkAKYQOgWhhSRSG6nuhpGtKbvXY7Mm8BHSpiThnp8
         cq4VplV2kFNyZ6M1ZtnMSEcFx9fbFJshhM1dkBrTzdanHkkyILgna0eY2dj4coJS95aL
         jGuKIhS5DtXDMEGrY3gRp19hmtC9oPLKjxljnuutzSzMVP8let9UyIDsE0ogtzqtbyTK
         Jm6LW/wrnWv6fyDx9bEps7WCVMHWNIZxqA4ImVgDwz6Tm5nEjCaVixNfVxD84WcevAMC
         NP0OoA5/OJMR8825ZBuFtKQGq+MR4tWEWQRyRnWbfvJhfs+4PJ0iY0Jc/jXY6foI7Hz1
         myHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790764420; x=1791369220;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oGZvKGq2A3pM90buZ2VNpRfUMGSk6SlqzeIIAOV+V2w=;
        b=mNPZHD6fnBvvUaZEGNoQkNZvZodSvKkevtbi6tLC00uThP5JCV0/Ct/MsXxtdc5MbO
         /GeMdp9OgsNfvjpXu1WlPd567tdt8W1se7KO6d6NhuwuJ+VC+lHY4dekBK8mLUAyecVy
         uUipMKxv5S1cr4UolM4i3VIt/0X0tdrHJyeQNq3O6vfOQ07jnBUbAkkNfTDXmPqo4Bi5
         F3YTAYwBr12gKDuu9ASrZeO9DLc1CfWB2VgfoJC20cE6/HD65g28UjWNbuEJpSwe0aaw
         8cCIKI2gExGGyEZCnph15100OjLn+G0ZISRl37qTW1mi0y69bapoZYIpJuITUUeFtyJe
         pqHw==
X-Forwarded-Encrypted: i=1; AKwUvBxsrZz+2ykF7eS34P76C0HkY1IksRQZEbHi4hPhXATFPPdiIqrpBg6zYB6jj+GTeipiOlfxYw==@lists.linux.dev
X-Gm-Message-State: AFuF++n+swQ+ntvwj900VJ3PUxunUdBEXA9bjezZM0x8YJKJWxpgWDU2
	UEzHMN0wANU8jVNDhWAw5LF7E1nfzqVfddhtH5hWD4mZuNeBqKMn2E44j2zbhiv4pL1A0VIjjph
	dXIuf+K69c/s0vDXmRWqs9eit+OVmm1XAb2JZw+e2QwjDnMcsAV+dcVM+dA==
X-Gm-Gg: AYBFou2+65jfVJ13AqUBZFrjMTinuCj/scmClAt7jSTgjirYOPuMm94cDRtbJkRiPaI
	ZkLh4EkDdhqlmIX3TqplzfS3tPwUHpcRM8PBr0ZfazvLgQIWrbasrDdB/nAijUGCsdwXMHEliqF
	0iQpcM/BFgGsw9qmZKpuKp8pyQy88j+F56YX1Cy7id2E6ZFtliI1p6rcsIgjXpG7MNJ/xe4/OLC
	RVnVqpAEYvxpZUPxsH5T/xYJeqK6dDYl4L/SUDcdTxDOU0Egyvh5o9/HGyRKrmBD1eP5RhDzPsn
	w3vU4hasjdiIBCcA64rr4y1RWCTH2t5JDwg3KzyW1FszoIAOElG6Wv5DHtrIFossX1nX4mYlCxh
	ovej1uzX+YoAr+Geqm9IGdw==
X-Received: by 2002:a05:620a:3195:b0:93c:5bda:9711 with SMTP id af79cd13be357-93ca980894fmr145340785a.6.1790764419736;
        Wed, 30 Sep 2026 03:33:39 -0700 (PDT)
X-Received: by 2002:a05:620a:3195:b0:93c:5bda:9711 with SMTP id af79cd13be357-93ca980894fmr145334485a.6.1790764419199;
        Wed, 30 Sep 2026 03:33:39 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ae047e9a39sm671766a12.1.2026.09.30.03.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 03:33:38 -0700 (PDT)
Message-ID: <255658f9-cd6b-418e-989e-60daa36ca498@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 12:33:35 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/13] arm64: dts: qcom: sm8750: Add Iris context bank
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
 <20260926-vpu_iommu_iova_handling-v5-13-0322ca5dc10c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260926-vpu_iommu_iova_handling-v5-13-0322ca5dc10c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA0MSBTYWx0ZWRfX+7XZmmrWDKqR
 6NN3viXm9+wo90zynDob4rRfR7hBE8uNtnlaBQa2Glqd5lqcrj240dKeJZAGVUonanhMrSL1wfn
 dx9rhHdLzmPZ9YQQM5dkKyTjfB9UYkE=
X-Proofpoint-ORIG-GUID: DzbF3NVKhpP2gwi-_sTAHFkO3n5K8F-z
X-Authority-Analysis: v=2.4 cv=VrC2kO2n c=1 sm=1 tr=0 ts=6abce584 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=4BULcDCo1EIeXDFKsSoA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: DzbF3NVKhpP2gwi-_sTAHFkO3n5K8F-z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA0MSBTYWx0ZWRfX2jDrldJB4CkL
 eTtobMRKrkiDmDesrDm6Nh4Xkc/wNzjEq8i/NkA1fZNCdOuNYvgKKDwSxRItt67KvSsUke9y00i
 w22oPyxDgamFdulQWHKFcT7g/8TJE2Zw8sH1aHVNSOYNnYYJuiZVRC/QoztBzf+63Qbl1L51mdk
 BqGlnXXDETZZbeCebh6WYJKj7fQ1PhdEEmHx+oZJ7zp495TJEMgqZc5EYsD1Q/Ja8O9ntSGyohe
 hW3+4bAjp+DmcPTPQKjvmKJ9dZKj6Dc9i/Biku/H3KTaxJS0ZqwowjS3cyoV5/cM4IFxg31NvxD
 ye3ecNisa8fP0aqDOK89bUi0nBVJUMRSp8od2+f5migTs1khWmmUgT8gZw/NcIrKz7ysXnnhFVN
 tyu2Ru8qEsQY9WUAZlFCieT175IcixgQ9IC775UB7f221v+Nnwp7O7fyzYTBldDtW7yba180/aq
 JuVkWjFC3D7czzJBHvQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 phishscore=0
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

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
