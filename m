Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686F92EA490
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 20:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763064016; cv=none; b=Ya/fFYOsQ9fufA2fwls0y8YASWjfVtktr37U60qKMSwxdW8gHmuZ4eP14LrCR79ZY6yzKewcQuyXakxEkqRs3AOU0le2jvyEDr43qa+rXjMdRGG4kjuMYtfLuJOHDRZJAc0IB0tq8b7hVYY79o211LIoaTd184jTAs481njgrts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763064016; c=relaxed/simple;
	bh=1DAdQVK6CcKp8rIYP9ca04DjW4Iqw5yNG0Th0nmNrzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sZaffEi0EUzGaK+PAAB/RFkNuOinH4tO9ZX2aSzAfuEwqFcYRz1kRlVAFi4TwbgFq6c03dvE6++3U2uVGM0H5VPwe52Dx9LFBLPTv+JDtjCT4Yg2o6xePcNbkPiJnJNIU0wQQWG6Mgi6WS/j4iY0Sz6LOeH+PFOoQQ+SGR7AWwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fuAxD8wc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d1hN4Y8s; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fuAxD8wc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d1hN4Y8s"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADH2xHB866464
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 20:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OJ7w+mpX/9CJl+Orva8v96dQySUzco1O64PcH/xD3KI=; b=fuAxD8wcsAEwL5NV
	bh1wPbEpv+tKK62AaSEWu70KnScWrWuMyJUhri/6SUyYJmD2GISZk7hmQjrkZAIW
	bKcoENtov0aleRgOVMYAQ4JDtwgqewpHJ0XSY1NSKTu4HAPlNyjVCtjjguMSFGgx
	Dl+3aF/RDg6aysVhZW1VLTpk3CzGeybZYPnOit2k/Jd9mzdf84wifHdfltosinqb
	N8O4SuZaBpnlNEAa0SXtAkWRdqN9Ks65fzTVcjUmlyJRTdEDLF1yGAMAjWN+MnJ8
	YN+RVQZwBxSKx+YAXAlZcWkeG2oPDHRXnvJ05PBji5dMGfCYFjl1qjuG6Qx18FiK
	K9/mRQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4adkcw0he1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 20:00:13 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7ae3e3e0d06so1021338b3a.0
        for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 12:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763064012; x=1763668812; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OJ7w+mpX/9CJl+Orva8v96dQySUzco1O64PcH/xD3KI=;
        b=d1hN4Y8sxJpIq/kY8tYlIjCAEihAAlKcbRuPJrO61ws7z3J74PHpoLeEp6IUVaJyVm
         789FZLB5NZbaek2f2POVw6N9FEldjTMAu4zzTzswUbwVg4LUp/SkxB//+2i/WrH9W5HF
         Jlt4cjNytlSBMhx42klgCdkLOGgdOqwiSRHZ8x1uRbYzDEoEsG6kvMti7oPTBgmFpYYO
         sGRT8JqjjbLa56ZkMDSyusfi27Od/XcrTRUMFZyeAcmFmoThS/51M70pnDuVLKgwMBTt
         2bBwCw+D6OpFhjWZx3Oksr3eRAYrpQ3KQ/DOieWH8A73Gfq2w90SmRWabhnK3IqsEzHA
         2k7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763064012; x=1763668812;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OJ7w+mpX/9CJl+Orva8v96dQySUzco1O64PcH/xD3KI=;
        b=shcDUy1V5UKEMg5wdu3CwQ9b6OcANveyCGvIZ1YBzgXppb+D/sQETZMZpZlPqVOYf3
         LB58vA8EFWKieSlpTyg6r8q3H1bx17EOn5NiTheOrPyZsa8DEtNQp310nch9S0FM81Rd
         01ERcvBsCufE31mDY+HbA4hsOHjFttwDNXemfWLMVl1cZIH/QVnCwlRX8gNbC8x/ul+6
         q9zwykzgv1x+PlcEa6BCHIdeRXcySmhcn98i6bdz3aVu8UNiG9pwjgxwJMVWkigeXh0w
         2NmHvD01hbtwxKKYkcBDoklxkFyKna+w0Ucww6yXAbnr5+9AfGHC6CRkRjFavtCIdk8g
         0Bkg==
X-Forwarded-Encrypted: i=1; AJvYcCUIhFD423PuvfMhjXUFoub7jMakA2dx0KhfmnfE7Sig2m+k6JBVGVSvXd15imq56660aKOyww==@lists.linux.dev
X-Gm-Message-State: AOJu0YxSKahr+EPILzUb7tdqdscUBlfYNTZALNhuWGUMavtt09MK1R2z
	13U7kKJIz1V7XiSaLt2POqJqRAWn02b31gdDy+Sbi1iCTuiAOXxuNBfbbhXelr6o3PYhP4bmPgJ
	pHg13jpzph4fWne/XEGn9AOKtLLbVWQ1dy4rBOPnk3wbfitenB5EVcSEMOA==
X-Gm-Gg: ASbGncsczsTiL1mXEcJtvK/0d5JGQy5M3gRmdVzbtVypYqONJQa3C0x2Lx0eR4sYvDq
	QP3wEi6FFDWW9JRPZ0BT5Dd3pPILnGHpA0saEmoUGcdo5sV+3uZPi/1MGAvCutYD6MjR80rtwEj
	erpBd7iEWYh3OT4TEY1T2vcWpgt1XnGTHJa59VLUgWs5ZTPGprGZi1x5UUOOlg+SNY4McgL17FL
	77yDl+bGMf59EEN8rmvGsYODzUFOwNA7g6L/WMGWINDh4JgGxl5hmZ//QTE7jCqDNfTNr/sLstT
	bwe+OwZC+xjxveGQrw//ruUB5GZhZTyVcP+p1gWmUbwNaQYdpriEA5XLiMBgquC9gyPY5CwNL08
	HLTiwRpPEnLpM4ajs0UTNOA==
X-Received: by 2002:a05:6a20:5483:b0:353:1edd:f7a with SMTP id adf61e73a8af0-35ba30634a3mr896567637.59.1763064011745;
        Thu, 13 Nov 2025 12:00:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZ3uM6rWYFMlAKzZmNJ84R9H/A3/jUV3dWp4GW6Y6VWrqLNpi1YOXm3417OaJPss+ncsmlsA==
X-Received: by 2002:a05:6a20:5483:b0:353:1edd:f7a with SMTP id adf61e73a8af0-35ba30634a3mr896525637.59.1763064011030;
        Thu, 13 Nov 2025 12:00:11 -0800 (PST)
Received: from [10.204.104.20] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc37507fc7bsm2929570a12.23.2025.11.13.12.00.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 12:00:10 -0800 (PST)
Message-ID: <fcd703e5-d483-4369-8149-a25cc733bc2e@oss.qualcomm.com>
Date: Fri, 14 Nov 2025 01:30:01 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/21] drm/msm/a8xx: Add support for A8x GMU
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse
 <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Connor Abbott <cwabbott0@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
References: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
 <20251110-kaana-gpu-support-v2-10-bef18acd5e94@oss.qualcomm.com>
 <f7e204ac-28b6-46a7-903d-30b7f31dff8b@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <f7e204ac-28b6-46a7-903d-30b7f31dff8b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=K8kv3iWI c=1 sm=1 tr=0 ts=691638cd cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=tMg4Ou186bfY0pTZoTsA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: N7Wc_ukVdkOIvcm1Rzn0knE0vp_c3r5M
X-Proofpoint-ORIG-GUID: N7Wc_ukVdkOIvcm1Rzn0knE0vp_c3r5M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE1NiBTYWx0ZWRfX8qKTnppoNTm7
 RQLEC/tAKvA3mzJOai+ArsV0FzY9m0GVABUE/hhzLVW0MbwqY2SKxAofsa4C4W0Iuis4K3HXXxN
 z2Cv1B3ObUPkXSf/SVgbFXC2nu3tgTlK6W+MAiobnpAkJ9cZHEHGHzpLWbx2Izoh4TdJP+VZse9
 83IQCFF2KsqeCNEFYuzhQFRKd3zQaMGG6239HKBJ7GkOlRriWWIqwWGfMS30I0fiHeDPXYh7PEG
 vmkIhn3Kh2/g2jN1U+5TBq8V2pcmyqhii6wyMx7f9Nkx7j09cv6V49hzvglD/Yfg+gsyaPw/ZKd
 mAXU83fg5m6q+cupksJIzo+4vUHbx1ZOusV8q5BET4m8InFZ0FmcXlXHdqbiK2eRIShScbDnhQC
 IWNcsMFaLNX9abXghsKBsk/t1zxGfw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_05,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130156

On 11/13/2025 6:40 PM, Konrad Dybcio wrote:
> On 11/10/25 5:37 PM, Akhil P Oommen wrote:
>> A8x GMU configuration are very similar to A7x. Unfortunately, there are
>> minor shuffling in the register offsets in the GMU CX register region.
>> Apart from that, there is a new HFI message support to pass table like
>> data. This patch adds support for  perf table using this new HFI
>> message.
>>
>> Apart from that, there is a minor rework in a6xx_gmu_rpmh_arc_votes_init()
>> to simplify handling of MxG to MxA fallback along with the additional
>> calculations for the new dependency vote.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>>  	/* Make sure there are no outstanding RPMh votes */
>> @@ -990,7 +1022,8 @@ static void a6xx_gmu_rpmh_off(struct a6xx_gmu *gmu)
>>  	gmu_poll_timeout_rscc(gmu, REG_A6XX_RSCC_TCS3_DRV0_STATUS + seqmem_off,
>>  		val, (val & 1), 100, 1000);
>>  
>> -	if (!adreno_is_a740_family(adreno_gpu))
>> +
>> +	if (!adreno_is_a740_family(adreno_gpu) && !adreno_is_a8xx(adreno_gpu))
> 
> stray double \n above

Ack

> 
> [...]
> 
>>  	/* Check to see if we are doing a cold or warm boot */
>> -	if (adreno_is_a7xx(adreno_gpu)) {
>> +	if (adreno_is_a7xx(adreno_gpu) || adreno_is_a8xx(adreno_gpu)) {
>>  		status = a6xx_llc_read(a6xx_gpu, REG_A7XX_CX_MISC_TCM_RET_CNTL) == 1 ?
> 
> You skipped writing to this register above - can we count on it
> always being in the right state?

Warmboot is done differently in A8x. We can explore that later. This
fine for now.

> 
> Do we need to map VRB, or is that a topic for the future?

Yes.

-Akhil

> 
> Konrad

