Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA563859DE
	for <iommu@lists.linux.dev>; Tue,  7 Jul 2026 07:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783411031; cv=none; b=epM+goPryM4v+Xs8bZXUpTB7gOGYraIzvZjPedONVmuLz18N6bcw1K4qAabmncnK17ZxNj8oI4KYg7Vw4FKA/yulKBV8vpobBNbyw5h1qFx+fuMVYrLrbvmtfGnczvyCYvaN9l3g+lXyJ3eejAuxX6pHV4oOt+kQT5gaOVle7ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783411031; c=relaxed/simple;
	bh=7c8SCLDxz1//Ut0q3RLGJjkmqLqxbMz3thHlFN0cw98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YhqKpU3i9pP9y16bOf5Efij9so97CHw0FAbwQo/0XhqVZpi60SgPE4tnfXtNSknWrEdhY149eLV5wVTOmMlt88ZKDewV2iv9F1RH2enqJjL6cEL6R3PvCmIYjb9M72yu5gDuOAreq0pWxYpZQ51LHhq7Nk7VLKp/VAyQVJQrerQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fcckQYcR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FS+5pb5L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fcckQYcR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FS+5pb5L"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667491r12451012
	for <iommu@lists.linux.dev>; Tue, 7 Jul 2026 07:57:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7YpaEdMecakz3winsJqyzZ3JM2BmdyWxm8Cl9jEyPXA=; b=fcckQYcR8YaWsCne
	8OMkkL6BP/ynJXTTEAsp4qAeFWCCSjtyss+7TFUrogT8Wim7hJYNpi6snApgBjUS
	TKjFsDx7XkHgKeZK9JiMftH9grco5VxkAWTNiTqHxZWEj/V/oxN0dfTwapDvVIWT
	6bePbgvZVPdMCveLWJJfaMIlrvyLikhUIiTSt/fsGYitYyYoUna2vUuaPvez1i0n
	/3jqUl9vCs2hdmUit562G2/k6yzexF1+ZLjJnm5PTbhUMXmejpIIW1bSTc/kxYf1
	EkBuvtu5Sku3r6Y8ZoITOOI0bomB3zl1EUtfCs/cVdSxe+O2z4PmKrN46N5ra0a+
	idONjw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8su70u5j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 07 Jul 2026 07:57:08 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c267931ebso23641351cf.2
        for <iommu@lists.linux.dev>; Tue, 07 Jul 2026 00:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783411028; x=1784015828; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7YpaEdMecakz3winsJqyzZ3JM2BmdyWxm8Cl9jEyPXA=;
        b=FS+5pb5LKxmxm8QG8GZVYMx1kg8KVfCB7s7u5oGMhXSrIEC9ubo4BW9jigkzpWJr3D
         2HA5YqxJXj2xbDa09T0qiesk3YAEp9Jg8ZAPSAyxEEyHVBqfo5MaLbzg5brLHwN1HtGm
         cD8/bZ/8/isDqyRbKwCQ001u/va0uemKvLk462LDpl/5L87rB/AeCVGa7CHOU9KnDFTK
         1HhINj7q5b3kxctLttZT7bQxXijmhtIPfA3RLTnz6IbQE3y5h5HNKGzFlkRzBUaCDDRc
         1JvZFz+dkpDBPuPlFScq4DpEBDjTIGVzLF8YOoPacHihH50vromKhLWluo9eB35Be8QC
         zWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783411028; x=1784015828;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7YpaEdMecakz3winsJqyzZ3JM2BmdyWxm8Cl9jEyPXA=;
        b=g0IdPdA8UdcFieSFhJUmD3RPW81aZciszRcgXkc1EmsyRHcei+eI4bz5wiGpFt5SBY
         +15zNcH0i70e/jGOEDYRXhRTRASaKqRHG7BLr+OI4D3Abwspm/xL1bXvaAxFL+yEnoY1
         5syOmmCmYODXA2hvDILKPKp29vAi7bKdqT3deotl1tpRGd9sFZ3mTtvXDZ2vewEbrhPy
         yNSyRRBoKpQFy0X27K1xLtjsNDuTlb/2zS1Vbr0aW7MTf5eUYMmKJVc9VWHUsy/L8v0G
         sFPQgo0UjzMjPTrG5sxdsPmm1nFE0dcX+tr6Mk6RHXGEuT/ZcEZPJbHSA9prNtSVijtX
         dYYA==
X-Forwarded-Encrypted: i=1; AHgh+RqNmCx8xS4T8nxkmiSmt4V2X2X8Q4EoR9+LyBco/7xFy/lCbUSXKUyPd8XpG+F1spwuUtBC2A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6owVdXHe2xhVQKuy7Xv51LtXO9ulKHGIQy+CceKbW8j0uz+8L
	nyVCyW/9+ssty0xYIA6vJf7j3SPNkdbQsmvF8LJI7G4sw+i2LlNDAuRwNqp9xvoMs0FVmtra25d
	SeTPuytlP5lc3//qhhMbaVx1XMwC9rnsSZO4PfgHUvf7W6YH9xsjXXZTzbQ==
X-Gm-Gg: AfdE7cmKo50v76eIEi+EQSHWcc1Wz6uHT3Fg0/Ch4l2GoD2ZJknc6g10Y1Wm4A7Mcla
	HVQGpMWuJimB0+1mN8jEma4nj/2Slgzrf05yH/lmZYbDr5rOpo2DfshqIOX8aoVvPPq+EY6U7mn
	IqZrFW6EXbKcJRIV/28kQ0a94nPTyKKjuVAXqGdN588GlbVE18wnQbN7KePAYWVptOIa0HW1fWe
	vm5aGcT1wYzY0YeIJ3w45OReb3JkASiQ3h6chGTQRoD+47ER774DWZrYTZTxwShEX05YqyH9w1X
	cCvMyOvCQdpSiCSEvOyLVOB5SFfqsiLBLdvp3TFYrleKzv8QF3l/OvkER2ayGM/A0FfQPp6BRxp
	p+CLl0q1RzfKyvjHauptgrs4jr+kfZ0LIf38=
X-Received: by 2002:a05:622a:9c3:10b0:51b:f40b:2fa2 with SMTP id d75a77b69052e-51c4bd5a87bmr80136201cf.1.1783411027792;
        Tue, 07 Jul 2026 00:57:07 -0700 (PDT)
X-Received: by 2002:a05:622a:9c3:10b0:51b:f40b:2fa2 with SMTP id d75a77b69052e-51c4bd5a87bmr80135851cf.1.1783411027315;
        Tue, 07 Jul 2026 00:57:07 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15ad82311fsm75880366b.8.2026.07.07.00.57.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 00:57:06 -0700 (PDT)
Message-ID: <c9fc2770-d436-407e-998b-b7ca49ee344b@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 09:57:03 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] arm64: dts: qcom: Add GPU support for Kaanapali
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
 <20260705-kaana-gpu-dt-v2-5-6ac53de56314@oss.qualcomm.com>
 <e2b7e03f-911b-41cd-8ac4-044492e2bdbc@oss.qualcomm.com>
 <b11cdc41-e88b-4815-9349-453f1bd5f14c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <b11cdc41-e88b-4815-9349-453f1bd5f14c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA3NSBTYWx0ZWRfX3lITBUvB5Lc0
 6B0j/YgIoDO6RYperC6dhnnvmGIj8AY2ARyYNwM26bJSc+yOxmj2tEh3cVkfhVN9lkH0RRUeQVB
 LZONmBnb9GWWwGvnYLQrnnGBstp8RWv0NtcaCZA0tgY6+flSWVhorLBzlow4ujM9ednHtgMTN1/
 ehyJiEedpxONRLysG8l8Kj/9ZhEzpvZ23b4lnJLxS6IHvcHaK5ES4vqQquJrQgSmBsT8pRH9JlO
 z/BoR4tDqzo3w8zz8wbin0msV0/s0PqkN+nSKUdQ2SSH1YeZuKAiuYjaDRm4jxspgNIe0r50IQU
 /YSGSduR2L2BRxG3iVWcDStR0mJGoQHGxrjxGxy4Qtu3zUlAfq3SZSuWOxYMUvDHHVTlslR6Wf/
 Wu2Axm+uP4qapjg0nos3Bc/wMdIZ1IsLa93qtVw5YUxbKoQC4sHjTLPQnc9kff+o/HWPUP8cvT/
 tqyLhj2ZoNHhFK0u4RQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA3NSBTYWx0ZWRfX5PdqGqqwfz78
 QllEYL5JDG2E0SlixetTTnYt5/auxgbn9VlBLNCeRW4d6jbPnwpgsKPAeHJBzPByuEIqqAiV90O
 wKZV6UFiwhPB5QyLVnU+U2qLISyPjLI=
X-Proofpoint-GUID: YiPyubS-zDvRu01ub5BXAe1lPrjErK9X
X-Proofpoint-ORIG-GUID: YiPyubS-zDvRu01ub5BXAe1lPrjErK9X
X-Authority-Analysis: v=2.4 cv=HN7z0Itv c=1 sm=1 tr=0 ts=6a4cb154 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=w5vk1yBYWc5d-UbTd4AA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070075

On 7/6/26 10:06 PM, Akhil P Oommen wrote:
> On 7/6/2026 3:07 PM, Konrad Dybcio wrote:
>> On 7/5/26 10:00 AM, Akhil P Oommen wrote:
>>> Adreno 840 present in Kaanapali SoC is the second generation GPU in
>>> A8x family. It is based on the new slice architecture with 3 slices,
>>> higher GMEM/caches etc.
>>>
>>> There is some re-arrangement in the reglist to properly cover maximum
>>> register region. Other than this, the DT description is mostly similar
>>> to the existing chipsets except the OPP tables.
>>>
>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>> ---
>>
>> [...]
>>
>>> +			qcom,gmu = <&gmu>;
>>> +			#cooling-cells = <2>;
>>> +
>>> +			nvmem-cells = <&gpu_speed_bin>;
>>> +			nvmem-cell-names = "speed_bin";
>>
>> This looks good to me, but I thought that on a8x, we're supposed to use
>> the freq limiting register in CX_MISC - is either of them preferred?
>> Or are they just hardwired to the same thing by chance
> 
> I believe the other register would work, but I don't have a fused hw to
> test. OTOH, this is what is commercialized.

This is the answer then

Konrad
