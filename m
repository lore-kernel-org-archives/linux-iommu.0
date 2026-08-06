Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA6E43D50E
	for <iommu@lists.linux.dev>; Thu,  6 Aug 2026 10:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786013255; cv=none; b=BLM3TTjZ/3XpS+JZxfTkxqLJV1Bh+JGwC5J24N92fETYl1g7b6Tt2aiK8uKrDhFyQeeB5H3r9ecF3s62ZDwQVWA565CMsnElpNpAsj/UBTeXw16dqii+Qge3xrMiAxDgiubmAtidMqkvl0MUvsJ11aUVSHwAIdGL6V5fPQ6rDGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786013255; c=relaxed/simple;
	bh=zYS+zZmBCbwicU1zbLJKCTZb/LX51dmiX4lIFeR0EOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SLl6edWqNfkZDYPDznbBu+up6idhVx7OIxvwMQ2ud1/lERCmqDkB8rEpGqZAXqznDnQtLJaFNPY6uGHngnSraMiJ5trUKtSz5oEYfpsHw01X48tH67AyjCJZn6Km6BQXbq511UVtrr7k1bPJreO7DLOJqRUU7rVzKDHfK8GEis4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QSKWznhV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rpnx1F98; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QSKWznhV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rpnx1F98"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769niRp1534178
	for <iommu@lists.linux.dev>; Thu, 6 Aug 2026 10:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3XcAoiANmEcMbel61kHL29IMp6ZNyBHShgiap9zoaO8=; b=QSKWznhVTZ6i57kV
	kjaG1ShV01GKobYOyZb3oRWY7ctX4zYP5YXNsoB0EoBQef2S/z9/2rUPiXm/HOHa
	7npdLv3qiJj9F3gFV/IMo3bv72iFiKyKES3GhvnkqoED1LeN+Hzf7+GPDIM+mxeI
	sedbtXhmZF0Zr3tEiC0Gl/U+6iFiNOOq1vhMX5m2yYaVTaEuHXCsPnrLlCU6HROX
	mMlUpV3Mgo9c9DY+5Jcugh4eVIkpmRUSgCU8mE9FjGFjFLkYnBRlfNZoNBUx762C
	rIroqx/Gu7ROp4rDwgULhKH8ISfVYJJqEbibvFi2b9ju+D4dEt8YvrvlSEZX9+gQ
	RvuP1g==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvn8ps11w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 06 Aug 2026 10:47:29 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84a67b16217so3450045b3a.3
        for <iommu@lists.linux.dev>; Thu, 06 Aug 2026 03:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786013246; x=1786618046; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3XcAoiANmEcMbel61kHL29IMp6ZNyBHShgiap9zoaO8=;
        b=Rpnx1F98yVP5BxDRTGLJC1sfmim3XnPxE42IPMbbi6i5kQHI0ILaNN00aIggBBXLYG
         0gb9Kol4oQeGmHicK0xxydVZbPutHnriD0YK1OQlttvSSc8QIxOSPLTNJ3bgH1ku3izx
         E1Ed1nhvysq+VWZqV1klY1pFANrJHIjmU7a/jlDlmLDNgBfci5b9NVwa/cy5OCpOIsTN
         cCzVsdrdorFB9uplBp5TdMQiIetFZVF6v7Ul1BkRQEQZ4oGWdYM0SgKbh/Xm15bXb97D
         MxVZ/D1ky2V566/rJVPcy6HyalHMc+/CW6UPCqw3JF3Zs5pwGIWJYc+lkC2sT4NZV/f8
         UC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786013246; x=1786618046;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3XcAoiANmEcMbel61kHL29IMp6ZNyBHShgiap9zoaO8=;
        b=ICd2LxlxyavkuVXq+CcY3HY0NKd7X6Li4NcGjtOpoQTwjZrAu7FNruOzgtDI/zp5SY
         abNdd3eXn07OINxmeqmGfBip7VnwbYg4GX1m9nmsPicrkMiFybZwni094Aq+vO9el0IG
         lfdjz+Gib3QsUUIFaGvov42TocfS1K3blDQlfoZpirfH5leyTfXeSSJPynIKDWLYpOup
         nfp8MeAym6/V+FMboGUWxmlNWyA98pf6CJ6ANIysvpMq60wC1roRiHZrfYWDbpIKcMUt
         5JWGx5bkl8FsY8oL2QZYMLjtmDvwKfwk+GEzPwsZAu1zxWZFGx0jS8434Ic+jpAonB4w
         wtZw==
X-Forwarded-Encrypted: i=1; AHgh+RqBxfJGKgKV8zvlAPUZ/k5jCFgHsGyH7QazqocLCsXjbvs18j4TUY3aFXNxbM9er5+EiWRHcQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwzDSJOH/63TM50BM5X/zgGClJdleGnFP+qM9fC0IQd4b11lKko
	EPrPu7xxTq12byWu7b24bGLT8W3pFWEE3tn77ARt0ObFKaWdlUIwkno1RGAH7Wmaqm39Grwt3/2
	znLtXpx5AgntC9kIQcj1JhiAZ3bsXPycbSjXl7R6n73RQ7NZM4oV+ozNogA==
X-Gm-Gg: AR+sD10+xODepHHEixZXnR0CFx+1fRTW4ULPqk+WHM1wD07mKnYC0pfVGaXN6TJ6PtG
	QPhL0b6xNSfRpFtz/p+1Ji1d5xyO+6pWi7+5AbiZm0+WxGliN5DUr7B3a4u09d0xCgVASarmkZP
	zO2EDvx00+xH+aULU3bGKnX+s8TX+cdBRj2lO4dxufaky8wmA2YqbcDBqsNdyy3t/LrbF4t081o
	Kxgu9AlENcx0tMoEVVriBqc9wJZTU/H82qI2pkrsY4ICK7xmbLBnQqdfO24PsfFDTsscrMEc9K7
	iqMXMyqKhNyEK6HHroG8Od3HEbmaXk9Oamdn41JRJ56pEWEUHBc+B78uwYV0ftiIS4QTcY+fcMk
	xvcZMrCgoCIgRXYI41LL0uxinPXDIjIM=
X-Received: by 2002:a05:6a00:3c84:b0:845:e9f8:67de with SMTP id d2e1a72fcca58-84f2e0555a6mr14758717b3a.27.1786013245873;
        Thu, 06 Aug 2026 03:47:25 -0700 (PDT)
X-Received: by 2002:a05:6a00:3c84:b0:845:e9f8:67de with SMTP id d2e1a72fcca58-84f2e0555a6mr14758664b3a.27.1786013245412;
        Thu, 06 Aug 2026 03:47:25 -0700 (PDT)
Received: from [10.218.10.148] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f453bb24csm1138822b3a.24.2026.08.06.03.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 03:47:24 -0700 (PDT)
Message-ID: <89c7178e-dab2-4b2a-8d8c-c91363b7280d@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 16:17:19 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iommu/arm-smmu: Use pm_runtime in fault handlers
To: Pranjal Shrivastava <praan@google.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Connor Abbott <cwabbott0@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
References: <20260630-smmu-rpm-v3-1-f69874a580fa@oss.qualcomm.com>
 <anB8ydWLQw0KZxqT@google.com>
Content-Language: en-US
From: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
In-Reply-To: <anB8ydWLQw0KZxqT@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA4NSBTYWx0ZWRfX/OSTo21t0sWp
 oueLCzHpyinAT6JqzKmZ8/dq8xV/IYr16+D8GtRv8DMolmvOAahsjoU4eY3HfuF5giJEWcM/jra
 9hHO7wpVI0wUYdBU/036JEzbwZJFaBs=
X-Authority-Analysis: v=2.4 cv=RPeD2Yi+ c=1 sm=1 tr=0 ts=6a746641 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=1XWaLZrsAAAA:8 a=k4Bztf7HfYMb5pBHrIQA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: iaI8KtAqekiW8-RF9B6Ai5HGKUi6Lp5G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA4NSBTYWx0ZWRfX2JQIcxc99smf
 lxhm1Pf7cgoty2o3cDMcUon/TEKsFElESkbmcksBkOBzA0HSQ0JwBZ32uvM9x7DkI4nMq1A0zPp
 sfOhjiFiLxnTNNUzDK184aQn3fpLTHvwCNdYHx+07gFBmpeMLmEkHZQUnufCO/3FfwXaeBVSAsa
 CwN797hZiuDopxUV+6rLwpZZ56g3JQ80747yysDOVnq87pHVXDZcZgA5wKN3R+5SGuMszQXcmG9
 yPr6E79+lBqpBx5+C4y7IjmRiI6AH30RwNhYuOfKj7O1ydm6blnW/a8BDh4Y6R9FpbAaRyaFlqK
 1CV0dSX+iSlIJnJCrGfXxURL+IMhwtUya8l5yhyw3FX/v1C9DILDhoeMPZ5VjTs0rYVK0Taclnn
 Q/9xk4WKMfiwm8pWyAYhEIcGFAEjYdx0+E/PK83whK1DuxmELHDrzp8RHHYgb67RPdT8m0Kmnhe
 /DdkFIZmwmDguwz3QBg==
X-Proofpoint-ORIG-GUID: iaI8KtAqekiW8-RF9B6Ai5HGKUi6Lp5G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060085



On 8/3/2026 5:04 PM, Pranjal Shrivastava wrote:
> On Tue, Jun 30, 2026 at 02:32:46PM +0530, Prakash Gupta wrote:
> 
> Hi Prakash, 
> 
> On a second thought, I'd like to discuss one more thing
> 
>> Commit d4a44f0750bb ("iommu/arm-smmu: Invoke pm_runtime across the driver")
>> enabled pm_runtime for the arm-smmu device. On systems where the SMMU
>> sits in a power domain, all register accesses must be done while the
>> device is runtime active to avoid unclocked register reads and
>> potential NoC errors.
>>
>> So far, this has not been an issue for most SMMU clients because
>> stall-on-fault is enabled by default. While a translation fault is
>> being handled, the SMMU stalls further translations for that context
>> bank, so the fault handler would not race with a powered-down SMMU.
>>
>> Adreno SMMU now disables stall-on-fault in the presence of fault
>> storms to avoid saturating SMMU resources and hanging the GMU. With
>> stall-on-fault disabled, the SMMU can generate faults while its power
>> domain may no longer be enabled, which makes unclocked accesses to
>> fault-status registers in the SMMU fault handlers possible.
>>
>> Guard the context and global fault handlers with
>> arm_smmu_rpm_get_if_active() and arm_smmu_rpm_put() so that all SMMU
>> fault register accesses are done with the SMMU powered. If the SMMU is
>> not runtime active, the fault can be safely ignored as
>> arm_smmu_device_reset() clears fault registers on resume.
>>
>> Additionally, disable fault reporting in arm_smmu_runtime_suspend()
>> before powering down. pm_runtime_get_if_active() returns 0 during
>> RPM_SUSPENDING, so without this, level-triggered fault interrupts would
>> cause an interrupt storm while the device is being suspended.
>> arm_smmu_device_reset() re-enables fault reporting on resume.
>>
>> Fixes: b13044092c1e ("drm/msm: Temporarily disable stall-on-fault after a page fault")
>> Co-developed-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
>> Signed-off-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
>> Signed-off-by: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
>> @@ -2306,6 +2329,25 @@ static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
> 
> [...]
> 
> I believe, there is a small race condition in the suspend path that can
> lead to unclocked register access crashes. (Something similar to what
> I've attempted to handle in arm-smmu-v3 [1])
> 
> In arm_smmu_runtime_suspend(), we disable interrupt reporting in sCR0 and
> SCTLR, and then immediately call clk_bulk_disable(). This disables the
> interrupt generation but what about the interrupt handlers running
> *during* suspend? I believe we could have this race:
> 
> CPU 0 (Suspend Context)                    CPU 1 (Interrupt/ISR Context)
> -----------------------                    -----------------------------
>                                         1. arm_smmu_context_fault() starts.
>                                         2. rpm_get_if_active() returns 1.
>                                            (Clocks are ON)
> 3. arm_smmu_runtime_suspend()
>    - Clears CFIE/GFIE in registers
>      (stops new IRQs from firing)
> 4. clk_bulk_disable()
>    (Clocks are CUT)
>                                         5. Attempts MMIO access (e.g, to
>                                            clear CB_FSR or CB_RESUME).
>                                            --> [CRASH] Unclocked MMIO access
> 
> I believe similar to arm-smmu-v3 [1], we must call synchronize_irq()
> on context interrupts after disabling them in the SCTLR but before
> we cut the clocks. This forces CPU 0's suspend thread to sleep and wait
> for any active ISRs to safely drain while the SMMU still has clocks.
> 
> We can simply add this loop to arm_smmu_runtime_suspend():
> 
>>  static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
>>  {
>>  	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>> +	int i;
>> +	u32 reg;
>> +
>> +	/*
>> +	 * Disable fault reporting before powering down to prevent unclocked
>> +	 * register accesses in the fault handlers if an interrupt races with
>> +	 * the suspend callback (e.g. device in RPM_SUSPENDING state).
>> +	 * arm_smmu_device_reset() re-enables fault reporting on resume.
>> +	 */
>> +	reg = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sCR0);
>> +	reg &= ~(ARM_SMMU_sCR0_GFRE | ARM_SMMU_sCR0_GFIE |
>> +		 ARM_SMMU_sCR0_GCFGFRE | ARM_SMMU_sCR0_GCFGFIE);
>> +	arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_sCR0, reg);
>> +
>> +	for (i = 0; i < smmu->num_context_banks; i++) {
>> +		reg = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_SCTLR);
>> +		reg &= ~(ARM_SMMU_SCTLR_CFIE | ARM_SMMU_SCTLR_CFRE);
>> +		arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_SCTLR, reg);
>> +	}
> 
>     for (i = 0; i < smmu->num_context_irqs; i++)
>         synchronize_irq(smmu->irqs[i]);
> 
>>  
>>  	clk_bulk_disable(smmu->num_clks, smmu->clks);
>>  
> 
> Since we're disabling those interrupts and fixing concurrency, 
> this seems like the perfect opportunity to add the sync_irq too..
> 
> What do you think?
> 
> With that loop added:
> 
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> 

Thanks Pranjal for review feedback. I have addressed the comments in v4.

Thanks,
Prakash
/com
