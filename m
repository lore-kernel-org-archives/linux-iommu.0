Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C94032B113
	for <iommu@lists.linux.dev>; Tue,  7 Jul 2026 08:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783413673; cv=none; b=R0I1vkTeSo2BF/0gMnFlv6K3XD+j3vU4kkP5qQ8QY0hUZERUauNExx3AKh61+ZjrJfi57JQReJHxFbVvUtcFC/ovtFSahafPPqIl9RSHcRbNoogEuQhu3oVh34e9aTcAMLFk7+p3sN1M5EdNSwbVXVe7m+nTqweeKX+ZdH4v49g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783413673; c=relaxed/simple;
	bh=hsE1R7ng6TipGkRqwppICugWHMfDvmkiKuhrFirCYII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nLcAflb2B09wdifikRraA5wJwOmoWnz2C9tOzoMrNzOqjHHaY6CeACUXY5fGRdgNQUwOHuy8x4ZHOiJFMdGSzJwyqQOk+1g7QOz0yHO1I1jwORLK7EzsPDu+SOv/44/qIFTp/CUadaH+A8DN7S6v/QBhLXDgsSsN6I/morsQ1Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I2h4gFwU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MaNEg7OJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I2h4gFwU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MaNEg7OJ"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6678DqZW3206049
	for <iommu@lists.linux.dev>; Tue, 7 Jul 2026 08:41:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T/aFwVhqAGc0ZbZI9x0aiPx8X3rURaDkbGwWbnLHtE8=; b=I2h4gFwU+DniJ4AS
	I91DXHqeGqDegN3b98/ME1S4lHUcHux6a+mV81sSLsHSjLylYglx2/w/5qDHd+ol
	HF0zsqAyi7+hb/q69X8Jpg00yWpQJmFWn2xYqWrnnb4jQ/caRQdTo2sBdnEvBOJx
	shzzooXfsKpgIZ3W7kYt7Qtg2YQ3tVOtVCSLNO7WTi0ogZqh1ZL0njIPq2Ekx28r
	tdo9WfgNDu94+IU3vy6pzlKrPRI+1NJd2NI7xOACyRDnXoZrO/Yn8LPq5xXfOkKq
	ISh1NjzAp8nhQsFyyHOMM+uajbYVla7wxSJNH+zLr8BfwxKHghtfp2CcT3wQ3Lrt
	CYw5eA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8fdw3dy5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 07 Jul 2026 08:41:05 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36d97a4e08fso6916853a91.0
        for <iommu@lists.linux.dev>; Tue, 07 Jul 2026 01:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783413665; x=1784018465; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T/aFwVhqAGc0ZbZI9x0aiPx8X3rURaDkbGwWbnLHtE8=;
        b=MaNEg7OJNqo6fxPJlwIB9RL0JMq0vmVZ80VVqqLkH1kTgBMZUTNKWgTtgQBkgGRai5
         ecU+EfAMbg+PVXZBZEsNrQVeM445zq/TM9teWu6FMZ8fRfMnC5BgRsKc/IkOzeUPL3/T
         PwdMJJrTBocqkm/ZLBOcsobjYumPM9goab28oxgsVA+2wPh8No/bsnobaxc3fBGQd68p
         WaVsFX0Sp/WwPXR9tabOz6TOlg986mdJK4mJrgwNWuhVR8hqtMsGBrR8U46VbctpC4ep
         MAmDJDqOfVfwigcuemqgF6i8YiUCzTvJToWMn6MfW7imG4oQcjmQQ2UkdYEyD4uZpLtN
         gAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783413665; x=1784018465;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T/aFwVhqAGc0ZbZI9x0aiPx8X3rURaDkbGwWbnLHtE8=;
        b=rXkiVxftPpsGdT8BZtDkEzseBGQZEGksivSA9TFutJdAwZ4DQiHhN6a2fuqUHNT2qE
         6mBM2Q38nILQPvNAktoBQzVk7gzEJMyAOWcRBI2w8yi3h+cdoi9rEhdulIPch2uXlhRK
         Gtb1vufRL4uk9LOu/NiYLPggu1vApmGWzs630lzadr9xHjG2nh4zeDr4zJpajP2Sbfrq
         GMVEu/zHbhfM2iUpBlwt2X5RgKb11vTzP0EoHXgRp2rh8ph6Wm2Q5ekpoEpTirSfTIZY
         YdAbPJFZC8ONVjAUe1pk+jLiqcDY5lzgnUJJsLBizLv+135vgMsLO2Hw823IoMU94upD
         HX/Q==
X-Forwarded-Encrypted: i=1; AHgh+RqJbcsvy1gdKj/qdHtQQDrEFURnQN5dbAz8dC2JXfaNRoZs6rzoOrR6fwS+qK/lqyto0nrl9Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwT0yHgmGbbjEDn6DgeCH0UzA2z3mgZ1pImXj50nJVjBPAn9w1H
	VS3p+g0UO2Jbzr9jmQA7ohA99vKABxlgEI5VCncefw2NbVA+YQ/HUGEwUXIw8spbo8VvWalnkyH
	GLwHw4PVj29PrwuD0cVXLCzRm4Q0zKtbV65AS0240chFwc9yZxjQa3p0E0Q==
X-Gm-Gg: AfdE7cmPaipPN5EkDPsxiaj06O1c7vlKxb0D30bZfCEYU6aFFPQfclOp0CaT0+Sb7B2
	nZ5J9lh1lIp/htkcwzo1ZdI8uhtehH8Y3QWeVpotT/f7iWHZFt0mq9ZN4D/Iw/ruqEx9RYj5tI7
	in4mxOf9oZHedzFlutsxYZSWoOR/HSjAW/E8i/wrD2rEWRsn2bxNvYxQ2VxKJSH//yVhRjH1U0k
	lrF211iZPVBrTb4SjKBE6dgNfBITGinEZ31zg1Ux2s700wMB2c3GdclMmoM86bTeNFSiCsn60F7
	kmVviDjRT2bCU7L2mpZ8dhKR3SQKE4fx3EgE/N+7JyQ+HfN7xfCi3aUOTVmrzB/8einrO62ug7W
	cvGFoqtXJnRHliZAaIQlIa+hIDu8hLqQqOYUwtHPRzA==
X-Received: by 2002:a17:90b:2e48:b0:384:8a11:33eb with SMTP id 98e67ed59e1d1-387575abe72mr4559424a91.24.1783413665181;
        Tue, 07 Jul 2026 01:41:05 -0700 (PDT)
X-Received: by 2002:a17:90b:2e48:b0:384:8a11:33eb with SMTP id 98e67ed59e1d1-387575abe72mr4559398a91.24.1783413664710;
        Tue, 07 Jul 2026 01:41:04 -0700 (PDT)
Received: from [10.218.50.222] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d1ad7974sm708702a91.12.2026.07.07.01.40.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 01:41:04 -0700 (PDT)
Message-ID: <447245d3-4e79-4645-a814-9dfc52fc5bf1@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 14:10:52 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] arm64: dts: qcom: shikra: Add GPU cooling
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev
References: <20260707-shikra-gpu-v5-0-d2f373912d3f@oss.qualcomm.com>
 <20260707-shikra-gpu-v5-6-d2f373912d3f@oss.qualcomm.com>
 <cikq6wyljzdlyuopvxno7fipifzc7f2zc6hs2ligiu5esnljui@5mxhammibgpc>
Content-Language: en-US
From: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
In-Reply-To: <cikq6wyljzdlyuopvxno7fipifzc7f2zc6hs2ligiu5esnljui@5mxhammibgpc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA4MyBTYWx0ZWRfXzO+fsd94VlZM
 BQl3V3pmhkFK83dGIwIU+4on8inchLWd3R123uLrN9aSA4TIwhsS6fVrnMUkj2DsUhaJcbtOGPz
 aKPJgzTTDvxKvpQ2iiXLPDjrFk5m/10=
X-Proofpoint-ORIG-GUID: uyMEgZ25tcT3lPA-Wpic5vPd0gEDEnXu
X-Authority-Analysis: v=2.4 cv=EtziaycA c=1 sm=1 tr=0 ts=6a4cbba1 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=agT521uulj5WE4s-WisA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA4MyBTYWx0ZWRfX+sFp4V+9FzHl
 G6RzXXZSko5MoGsRx0VVmyFLN1dBju5etsUX6eLoden6xmaEf0Q0Vq9+0DrBiUIwYGLvFgSl2Vq
 ZWV4c8gbKoiGJSpA7wvgIfpAtsUd6iSAAsUYvZnOqMxboTUOtgAB3E2qfsfIt+wzMllAw2vxS7k
 H0NBm0Pjpj2mfwCYMxLqLqQu93pqA5HvJAF/0PI4CuFpVCudfcpMFDKg+qXST2PwvNVKmeLbWIj
 hOKL2wfPiLGSdY4K98fADodz120ovRfnuK+liPV9EQN5fUsff920N5We90U2v8ufT5pJKgIKKjG
 aRlRN5IFxYklFG6NcdiCvsGrlpKXy9IFKYFwHCLjCRKtGsPHIoO267MJ/kVR/yTLZGQCbIv69Dn
 K35E+WKYuJOQq6D8nR8F3kQBDP561mpUI0JNIl/44/Y6maq9XadEq1AztiIMXahKC5OgdFha/MM
 5Lrx/6n9zHzVbbe9fNA==
X-Proofpoint-GUID: uyMEgZ25tcT3lPA-Wpic5vPd0gEDEnXu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070083



On 7/7/2026 2:58 AM, Dmitry Baryshkov wrote:
> On Tue, Jul 07, 2026 at 02:34:38AM +0530, Akhil P Oommen wrote:
>> From: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
>>
>> Unlike the CPU, the GPU does not throttle its speed automatically when it
>> reaches high temperatures.
>>
>> Set up GPU cooling by throttling the GPU speed when reaching 115°C. And
>> use a passive polling delay to ensure more than one "passive" thermal
>> point is considered when throttling the GPU thermal zones.
> 
> I'm not sure I can parse this sentence. How does polling delay affect
> number of thermal points to be considered?

Thanks for the review. The commit message was unclear, apologies.
Without passive_delay, the governor fires only on trip crossing interrupts.

Can we use something like below in commit message:
"Without passive_delay, the governor fires only on trip crossing
interrupts. Temperature stabilizing between two trips generates
no interrupt, so not all cooling levels are applied. Set
passive_delay to enable periodic polling to ensure all cooling
is applied."

> 
>>
>> Signed-off-by: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/shikra.dtsi | 16 +++++++++++++++-
>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>
> 

-- 
Thanks & Regards,
Aastha Pandey

