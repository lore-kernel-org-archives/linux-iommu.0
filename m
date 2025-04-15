Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07022063D2
	for <iommu@lists.linux.dev>; Tue, 15 Apr 2025 09:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744710587; cv=none; b=BKZjXSBEoREsFEgsy/qY7+HXLFsqS4vmCsU7OmjdfBxhE2X2IlL5ufAl8tFs3q2PfYJFt4X8V1bKqIr2EIBNhs+dC2hBe5RnCgOaOh1OvBJVKCoCEDiAq5KWezSKZrooTfH3NeCXUgqpzxbeOGadAvgU7fZJMQJ6jEYtMduzSJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744710587; c=relaxed/simple;
	bh=52LpJpjDjE4yBWBRZ4EBwCQtvWp1jBAGSwaH4q8wP3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O/cmwnqlnDrSMessiE1OWIC6b7Pj0Ue7y0fdMON8KRpeTPWX6ASbYCz7pgLDfhPjN3hWARP/SWzSnxNApaFLaGWLNDwzBAwgpwCdBWBfUrergBVR8Ld9VMatCows0awKxVNFLIlJvd4Qty5CTx/jQjwtI4IkNSH8pbeb/TC5JmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HR2rNzqq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HR2rNzqq"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F8tHaq005247
	for <iommu@lists.linux.dev>; Tue, 15 Apr 2025 09:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KOIM5yPpo9MViTBKkLNoXdzuS8SDS+QNfkUos1BVNLM=; b=HR2rNzqqCQRNtosu
	jEyA4Dwg+NNBmGGuCP+gFkw6Sr3hJ7PnCrYM15v3TrbbxWlWj2G+WYbGAcbRFd42
	kapFPavs0vYmmIcTTg69pEtU9PzAapxIIsqm6A2GTa5Qt8IQCqN69eMogWNqoRby
	Rqa8IGGo0sz52m3mMvnBsonowiawCWbZynuGm68L/Ku0+HaiLdcwvMXdVlyXNJxq
	P/Jnh2niB/eBa1v4GseskiAOZsVQDwVDnssPhA3Se7nCxGTOHVYJS+1EYoMTNKWl
	M1h7HIMsbL+w54teqwkwUXKGRIWwUkNxzCCcGhNojgUsAPKqumjKdjNrvLo+E1du
	44q52g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yhbpqccc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 15 Apr 2025 09:49:45 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c5e2872e57so982937885a.0
        for <iommu@lists.linux.dev>; Tue, 15 Apr 2025 02:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744710583; x=1745315383;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KOIM5yPpo9MViTBKkLNoXdzuS8SDS+QNfkUos1BVNLM=;
        b=gLI5gBc3PnVmijUquVGkcoIH30XCUYAArOYp9cT/JDoRank2bTumncWKNNZMaP5PeW
         g+bIhNI4vS+IzhfoWiEMbZsEjhhuFpv+OFw3+F3MPFA9K7zsy3aWusfolLhUX5kjB9L5
         t3hd116J9dZlRufhSs6JpzDtdfxm0u6wUiFwv/ins8Amlwk4WIqExYuApVkMNr5SgT0j
         KJOn+sxlCubWOkZTmLyqL4D0b161H/L8j+LyWZ4YmqjMBW4XZ34lsPg/AKBCwaDTljJB
         ZHiktkLnr4rDAZpGu51yJiN3TWOPWcp8mwUU8YOX9irqAih9i/E1XXybC0cBVei6inix
         HvhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVduCc+2RDc6s656z2IuL8NOjg/92AlZ/0uWDhLLDAG014mQ/nFsz2SokfxM/+6IZWrdDO1aQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzXp/UBq09vuQLL52Fim28EsJX7LyKJmGubvS2DENdASC/IE19+
	jbiMCaZ1TgzTPfhqF+KrMCV9c3fofcP7qptARnn/PqSxw+KENQKPjGvmKW3g10bqERDjJS/V0an
	0vyqxNPRdkbRpFx2Hr9OkMAMqjPYAD/NhYD8k4KcHLinXRzXMI4k1OQ==
X-Gm-Gg: ASbGncu79s2tAusCRKiNnuw2T5i5e69B2uuy4NiInFO0gpQSMXAcRmL70OVfetQq+bH
	2ABL/9Zqffm5JeBhBjon76bstVyfzN+l0yTJpb77A7UeLeIqjq1T0Sc6ABsns/SycK7uV8xIMRI
	VRzpTKY86ehWVtxbAKvkk/EFIlKbswIPZMJxsQlZ4ECia/IDqrtWjhN+jTbpCVg94mJhAukrbA5
	LaKeZqf41l/5LUQ8qnMe45l35IEGYJPUfV3pk2pJrZUa40X44U8RMaRL6um8fAFPj4bHwg3gxg8
	cADDvwzYqiggaZ1ukcsDx8CQC17ApsO48zgx+iOvx8y9i1kPQWQfgyBZ7vt9MMoSRIIbjb989ju
	h6jXheJw6HKxb2q1ATPnqmkhuFyiRLeXoOuKL56sDO+xj43uVLFU5+1c8sSYk
X-Received: by 2002:a05:620a:424c:b0:7c5:5909:18d8 with SMTP id af79cd13be357-7c7af0d3d1emr1773053385a.14.1744710583701;
        Tue, 15 Apr 2025 02:49:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoHRiOt8l67E2P0R7QBa24QR77cwJMkGHiQzo6vMvNgAnJNTeO3hOBWB7ssd17odFt1mGM6Q==
X-Received: by 2002:a05:620a:424c:b0:7c5:5909:18d8 with SMTP id af79cd13be357-7c7af0d3d1emr1773051985a.14.1744710583367;
        Tue, 15 Apr 2025 02:49:43 -0700 (PDT)
Received: from ?IPV6:2001:14bb:aa:77bc:64e0:30e4:f6ff:5bd? (2001-14bb-aa-77bc-64e0-30e4-f6ff-5bd.rev.dnainternet.fi. [2001:14bb:aa:77bc:64e0:30e4:f6ff:5bd])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f46623c2bsm20611601fa.111.2025.04.15.02.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 02:49:42 -0700 (PDT)
Message-ID: <10e8c3dc-fbeb-42e1-b810-d80e768ecf6b@oss.qualcomm.com>
Date: Tue, 15 Apr 2025 12:49:40 +0300
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/10] arm64: dts: qcom: sar2130p: add display nodes
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Bjorn Andersson <andersson@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org
References: <20250415-sar2130p-display-v3-0-62314b1c9023@oss.qualcomm.com>
 <20250415-sar2130p-display-v3-10-62314b1c9023@oss.qualcomm.com>
 <96e38ebb-5847-485a-8bf6-50e7b10ce572@oss.qualcomm.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <96e38ebb-5847-485a-8bf6-50e7b10ce572@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Jki3LVj9zp8p7rh7CzEt1VNXDdg8qvz8
X-Proofpoint-GUID: Jki3LVj9zp8p7rh7CzEt1VNXDdg8qvz8
X-Authority-Analysis: v=2.4 cv=I+plRMgg c=1 sm=1 tr=0 ts=67fe2bb9 cx=c_pps a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=01dcSNK4EstfxtfeDswA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504150068

On 15/04/2025 12:44, Konrad Dybcio wrote:
> On 4/15/25 11:39 AM, Dmitry Baryshkov wrote:
>> From: Dmitry Baryshkov <lumag@kernel.org>
>>
>> Add display controller, two DSI hosts, two DSI PHYs and a single DP
>> controller. Link DP to the QMP Combo PHY.
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> +			interconnects = <&mmss_noc MASTER_MDP QCOM_ICC_TAG_ACTIVE_ONLY
>> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
>> +					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
>> +					 &config_noc SLAVE_DISPLAY_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
>> +			interconnect-names = "mdp0-mem", "cpu-cfg";
> 
> The first path should be always on, so that if CPUSS collapses,
> the display may stay on

Ack, I'll fix that and send the next iteration tonight.

> 
> other than that
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Konrad


-- 
With best wishes
Dmitry
