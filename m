Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794571839;
	b=O23kzX9qgKZ88snTesDfdp9Q4q8INRL8aD8QPMmKDXG6QEV6Mbz7ZXewd3wR48oyH942
	 L1l/i8HQZ7l9Ec9WoSbAyR50XHxzGWCouzorpsVA3KigRPwQUjtLklTOkFMVy64zA7zLa
	 +a8Yav2aM11hGI5dwJX25FRWT1XtOinO8gLKAi8qfvm+61fiHuHTg8tv+IaRH5kszMG/Y
	 zYubnjvi/b0tIirMTy9BtQTgX2fnPjdJApSGN27C+USrS2iIG47uWLVwCws1tLa3q5RE6
	 +DTFivLMifGLcFJ8XZyUz4HB/NLOhHHtpBt3kDNxYaWNeTc9uKNaSNswG8Ua/xps51w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794571839;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=4hEbvuDKTvq5Xc54WAfLx4GkA5m8TdMCxYJefmo5WTU=;
	b=0ewSd5WQah5ldO84/aAGPwqaTQn6Zh6+2nw6KGzg3L5M7wYZVCGyegQV9BIDuFIXtCuy
	 qUKXpzc6rDJ4Fq6lq79pOGltxVBSjs89iyE3hf9B0P+SSnZ2JJwDVGThgUiw2kXOAMveS
	 WANgtNJPgm50Lgfzkg3BJ+vxw1PtzGr5+WUfeypMYJGY1/ibpoancCuWoCBXFdFnUL61H
	 elkwjDgK5byg1TCLr8q0mCbITPYHEZQPWqeTuwLYA3lYQBjd4J9fwZcsyMYxg/p9xCstC
	 8FYqwornz7WE2Au+MD6t691StjOZ5lVFWiPIckjdFaQRcITrel4V5uvxss/WXBZQMRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ObBtv92B;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="hb4/IXMH";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC705606A334
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 12:10:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC705606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ObBtv92B;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hb4/IXMH
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADC0jxd632031
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 12:10:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4hEbvuDKTvq5Xc54WAfLx4GkA5m8TdMCxYJefmo5WTU=; b=ObBtv92BXUpOERJ+
	2WgyEdl4lbkD7pOLZH5GrGlE+98lvcAtyZbrkhFvxZIDGjJzZVfGGQmQjOzKKPqb
	9K3j6lvWgfinVvqZG47jlC4w4AXyt/jPlZVU3WapMHA5Sy+vPNw8jOIillPbbq6L
	wKuOh5azgiMcnunj/Z40CesmKcHwMvZhU5R0KC1cbbj3u36fdS1l5b/z7PXJ2iY+
	zLZIH7q5h76zuRurP7DnTiUTYFek03tFCNYM1cnBI3UTlIm+56yJ1kG7RpaJMMys
	1+TvvsDds1L1WqJ+1M8yRZjaLK3jgQVzjL33ANFBF7C2BLbiqj6+tEyCd7ssXpN/
	08SwdA==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwqufj7mf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 12:10:38 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5ece1a3bf7fso59647e0c.3
        for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 04:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794571837; x=1795176637; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4hEbvuDKTvq5Xc54WAfLx4GkA5m8TdMCxYJefmo5WTU=;
        b=hb4/IXMHevVt/6uw7rCSnjbTeBdtFm86HYafDw5bGoISqVHaK1gag44VA6TvanGex9
         i5Lh+6zTvfuRIAcwAr+GH+oosHBc0qpv/DhHTh2UH1Q4+p7ghfZvB1tdxu+nyivCdLQA
         soNUO0E/PizZMnWUzjnipd8xrBpUHYo9FDIpqiXe1qOIJTFs8jsnpN31N6WQHnD4JDN+
         WpsqZPN/57R1ptCPfFDgnlJTJczCoBF9dLrG0Xabsfx9j/j7+mj3Tw5XEI3MQqctW8Yp
         2VACHfNJrFa/8IESCMNonSP2PNN9FXBEgGfMzWTRFFjd/NGUH7XBQMxw3/vNLH/la3J8
         8IQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794571837; x=1795176637;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4hEbvuDKTvq5Xc54WAfLx4GkA5m8TdMCxYJefmo5WTU=;
        b=ACQrGac+ebG8c4TnIq3JzfEiFJo6dd6MxU9V6gx+LnbI4dcF7bWN19hbYUZ2f1GVhU
         Gpimx/4aalp/5qtPp93Frj97+xq5F59lCcZHBrwmk/77VzVufvfgffU+8WuTBtnvzVnA
         nM++yOQPzlBZ0epgetAGaRhjFH1/bH6FO6kXnfaHW9iU0HxAjP+sRcMirMIlZUWOpAS9
         XRjrrjq+RlJRkloCbj08Dpa4br6HukpMdo2MjLALfAgol6/DsiMsaAKaD9nSpCZ3RKJN
         MJxpyEnIet6itzM2Yzff03yNmF7EyJS5c3SKZYArq/3K/2WyCa5R5XqMX88TpJLpL5Z1
         dKHQ==
X-Forwarded-Encrypted: i=1; AL+hErHHAhlYTjFDGC/q6pbrJo04BoREPERtBBB5nJ264rOHRDocfbQvl82aI4kVsFsmWS9J0RP0cw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+6h2/59UJL+rMBwfJ1NiTK55E11f9KrNvF1BTk6NnaP8ZYietq
	EXeal/ksv1hdrQDqjShtpjwKzaYAtJQjLecDEjU6K9HKf3osihYtAG2oA+iyS41NKccdUy96cSK
	e+i+ahxhnfSQ3qOs4Wf8KNCPRhEgNPUPCgQi4/0q5uxPV/FfFxGBGZ+O49g==
X-Gm-Gg: AYBFou0MOPcqzJA34qPrBPqQ08VUIilA2MTwMoE/XLxowvEYgYEi1xwDRfxdgqsqjPB
	rXsmAu4hlTEZWbQ/2RSOUw5o3OxIjxDjm3g4ro8uqHQuzPVzTfawW2++kxdX2H5MhDtthPlDTx0
	9/NM1hvUbquOKkTwQoQLlX0WnMP0U3eq54yGr/h4rNjKPstg0FkURHonZ7rX1wJqvH9W3eW/ZwO
	13fouU2YnQQ/1ArZBw6GbG5PY3i5cT2L7++aLZxwClcJS4aRjmFLVJVPDGKunWnzPl3jbVFWTCM
	LYaciv3dwAaA83NShyW+JovIe/V3My1GRBsdi+Tyug4baEx4HBIm5foYYUllkASA0Ogx8DHijqp
	caHybFr5+Rmsin2IcCEmqrWbOAAJmtHlI/X4rBlP4NSU3O+t3nm57gc6f+vuB4AmHpVncCTc=
X-Received: by 2002:a05:6102:61d6:20b0:7cc:32ce:4c41 with SMTP id ada2fe7eead31-7d64d6c510emr550114137.2.1794571836935;
        Fri, 13 Nov 2026 04:10:36 -0800 (PST)
X-Received: by 2002:a05:6102:61d6:20b0:7cc:32ce:4c41 with SMTP id ada2fe7eead31-7d64d6c510emr550065137.2.1794571836420;
        Fri, 13 Nov 2026 04:10:36 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c23ddf82sm870968a12.26.2026.11.13.04.10.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 04:10:34 -0800 (PST)
Message-ID: <0cac5090-a135-4a6c-8221-846b34ed5513@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 13:10:29 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/17] arm64: dts: qcom: Add initial Halliday dtsi
To: Stanislav Aleksandrov <lightofmysoul@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
        Lee Jones <lee@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>, Bean Huo <beanhuo@micron.com>,
        Stanley Jhu <stanleyjhu@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mfd@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-usb@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20261109-halliday-dts-v1-0-289114ab8197@gmail.com>
 <20261109-halliday-dts-v1-16-289114ab8197@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261109-halliday-dts-v1-16-289114ab8197@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: dk7kT3o54AeRRnsPf75my9ksEhzQMQOa
X-Proofpoint-ORIG-GUID: dk7kT3o54AeRRnsPf75my9ksEhzQMQOa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA0OCBTYWx0ZWRfXwhrrOoga4F5R
 s/8nkBm6yGwExgDiMwWe3zMatdEkStfjCHtaWx2ftEr1tjhL+dqHyfUuSW8AvrxudYvXIW7PzV1
 CXlNZCO0jHaZLzRX4WJsOZA4+2ed8mhIKGg68MsREXzFXDh3Rlz0iZwZQTwgPsisb9VsY3EesIR
 mRTUMsCZFVEqpV/4552OO7RXushyrydvRNzLuKyVxF/iAoSeGCtu+9b0kQWAmBabwHabRtp4Cvz
 PctB1B1YZVMg98s93FEZY6fvdNeshjNoq8njLGg3ey3hdD2LoXBb/k1dylNlD7awJnOu1xyFUdO
 VRKEm0tISOss2fMRnBkcOqa7vvP8NMnW5PqZSS+hBrJOjmHQsdowx9Crhz3F8Cr43TV5NgYTodP
 8oYemcheeVnZj7ohAsWNOqvUeOlxyFvzSBRd0LRuXHeNjmxi9oQWQsNa+Xt7V3rc8DLU6sA00hg
 YyRxYb1v4zR8hFk1+Og==
X-Authority-Analysis: v=2.4 cv=XZocX455 c=1 sm=1 tr=0 ts=6af6fe3e cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=U5E2jiqv92kUeAjINO8A:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA0OCBTYWx0ZWRfXwErvmie3y+/+
 zoN78buv5Rv0AsdU/hJ8RKhApPVTYMnMAQZQbFCUQ849+ULjepN5v3+diMBujMksdmZsbl0sdhy
 OICPys5cil4HnhPfgqdrY6LfjknvOyc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130048

On 11/9/26 1:33 AM, Stanislav Aleksandrov wrote:
> Add the device tree for the Qualcomm Halliday SoC
> (SXR2250P / Snapdragon XR2+ Gen 2).
> 
> It describes the CPUs with their idle states, cpufreq and OPP tables,
> the GIC and the PDC, the timers, SCM, SMEM, RPMh with its clocks, power
> domains and interconnects, TLMM, GCC, SPMI, the apps SMMU, USB, UFS
> with ICE, TSENS with the thermal zones and the PMU.
> 
> Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
> ---

[...]

> +		idle-states {
> +			entry-method = "psci";
> +
> +			gold_cpu_sleep_0: cpu-sleep-0-0 {
> +				compatible = "arm,idle-state";
> +				idle-state-name = "gold-power-collapse";
> +				entry-latency-us = <400>;
> +				exit-latency-us = <1400>;
> +				min-residency-us = <2207>;
> +				local-timer-stop;
> +				arm,psci-suspend-param = <0x40000003>;

Please add the other idle states (D4 and E3) from the downstream
devicetree and match the order of properties (psci-suspend param)
to glymur.dtsi

[...]


> +		usb_1: usb@a600000 {
> +			compatible = "qcom,halliday-dwc3", "qcom,snps-dwc3";
> +			reg = <0 0x0a600000 0 0xfc100>;

Please use '0x0' for zeroes in reg values

[...]


> +		spmi_bus: spmi@c400000 {
> +			compatible = "qcom,spmi-pmic-arb";
> +			reg = <0 0x0c400000 0 0x3000>,
> +			      <0 0x0c500000 0 0x400000>,
> +			      <0 0x0c440000 0 0x80000>,
> +			      <0 0x0c4c0000 0 0x20000>,
> +			      <0 0x0c42d000 0 0x4000>;
> +			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";

Let's break up such long lists into one-a-line

Otherwise lgtm, very nice!

Konrad
