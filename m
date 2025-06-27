Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9B172635
	for <iommu@lists.linux.dev>; Fri, 27 Jun 2025 05:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751002756; cv=none; b=bd6l/N9f6ypNYGjXAXwL7AvzmCrJ4Vf1SmwhQj4wd0UCK51JXWLiOnwNrMegw/9hX/+jJXZ4W8rTCWb1GayCckrPNzYE6c6xodU2DCe9/UUozjHiJXKqz5dG+bRoZVsNr7GGSEQ7Be0sk2hwCiYoU64fP3SI/OekyNqBWXv/HSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751002756; c=relaxed/simple;
	bh=9lq7yrINizoQwYV3ol5GwiZhoGIgWxMEtODvCYRhoik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vDUwNK/qe5eUF7Itlua4PA3NiHXloAhrQl2Eds3vRnuHEqHb8vQmfPGiHq0bs4oEyNUfH35gSj6K2uqgAmQ/mb+In+S7ojSNRK4fvkWMjbnK7uEfYfacg0DWCbB79tZNSzyJ0eYGzO1TyWI67h8Xb9iscRVmIcTGaEH5x1Y0VEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N+xn0yDw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N+xn0yDw"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55R4DELD011372
	for <iommu@lists.linux.dev>; Fri, 27 Jun 2025 05:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oxTpg++xQo/Kx2N25g5VpBf60MBGualJNHTFqUV2XeE=; b=N+xn0yDwZVR2MZss
	MUe+jtNxU4bz3McjadRTik1fjTCK1ttWOEJMTPT5tU+pUwa4l7MSYT7ZaQyRhCGq
	2yUK1f8yPT1EnAErMuTeUoUlhgtpgKRuSh7hEuhsZrF1VCZOCi8AHwLlhmgnUiCk
	+lLEkNuJCqV48yFLUCCod35ZARTYg/riYubiKS2+BC5Kne4A9YsghJ6UVjCsW6Gw
	ICuRIT9NGCm4JDBek7HLQwAFKaa0ySNY1lRcOonQ8bFJp/4O2PGquf8Wpof6ZOsM
	qfxr2npfANPjvOrNTMExcqOL8eGVBmmQwXOXAOIxiasLNIqgfjJadraviFexlvBc
	8FQSrw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f3bgnj85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 27 Jun 2025 05:39:13 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7489ac848f3so2864767b3a.1
        for <iommu@lists.linux.dev>; Thu, 26 Jun 2025 22:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751002752; x=1751607552;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oxTpg++xQo/Kx2N25g5VpBf60MBGualJNHTFqUV2XeE=;
        b=jR8o4MtjoI9IE/e69XmN4HNJFG4Rw9yVWNJvzVXvNP8BQ7xY3lI8zEl0wD5cMrbIHo
         sK4c0Dkx74eRRw93LoTKOCt1XeYdFl5vCy1kFaxlTOXfvYQhKLtgJM6n3Qj5MV8SczwZ
         sfLL62HoHjJOGXHpKO5JEPb2GlF47uDORs50ZUsgvcuPJ7YEEW9BgDWKuvJbOqMsp5EB
         b9SJNVZ2O6IKG1/Vp1ibB8iN1TKn4XGl/JKdtFtpXMJAhCo9Xgkqf7VjOfuMiFqTfXo6
         UvB3eQ3hxOaqBpB/dmitz1goENPd5rii4ijb7H3jp1G5RIuNifPyWcbkiVTu8Dsj689t
         yhLw==
X-Forwarded-Encrypted: i=1; AJvYcCV1auc8kBQmhEiBmbZbNro1C5QhIzCfz6jmVHF9KbNp5q2LeR1nqVOMdoShbYezW8eXLL9Vpg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzO/NgDxcJGgi3I/L60OG6YNSyBXvctIPRal8Y5jEfOrK8wcRvS
	l7V144MQEMftCcNXr0KKl/YtfGSaSnIcRSisHlbyiFUgshb314T+Y6zPwiGn7F3CgTHEKxCqOvF
	hGIFTVBEFY1VuFYKRNRw+M7wqPUJ7EJyaFyiyzdqTp86Q3UqdQ9zdNIEE0g==
X-Gm-Gg: ASbGnct0iGFYHYOhnPn28/UM9udQ/KkizZ6BgMlpz3P3cbNSKzrHE+7dg2iE306Lo9E
	7rZ4yn4B44pVEKh1ItNHsgA6oF+QrO0eUMFDAAbwT/1K3HW5/+oIRdYXF5Z0zERH2ITgXJ21deZ
	C1QMjo9XXlKxEqqY6/wHMkt408oUpPNgi4JKUnOSxhT/SOWozx6XK5QWbhxFjNEMAmCfiwXMjks
	dQFDKCLETAjWDTGQBawH9shxqcHcppBvTnMc4G0l5DBTEfaVC7lAc9IjezZpdmvOuhTQReyomW9
	lwvhYKOQZZrC8sfC9ss2D2DViDYnJwuS0rJob5Qi3U7hWed2cdcJKlj0Jufzv4ePykNFcIQCd7M
	JWVYRcW3PfT+nUA==
X-Received: by 2002:a05:6a21:3394:b0:203:bb3b:5f1d with SMTP id adf61e73a8af0-220a113ca4dmr2982004637.6.1751002752144;
        Thu, 26 Jun 2025 22:39:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6SJ90oL14ce7W8awMAVolaiw2uwi0whL5nP8wepFa/D1DEk94f0Oa6WqT/XC4xbcrBTqKlQ==
X-Received: by 2002:a05:6a21:3394:b0:203:bb3b:5f1d with SMTP id adf61e73a8af0-220a113ca4dmr2981969637.6.1751002751716;
        Thu, 26 Jun 2025 22:39:11 -0700 (PDT)
Received: from [10.133.33.95] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e31d85b4sm697467a12.56.2025.06.26.22.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 22:39:11 -0700 (PDT)
Message-ID: <0ba2176e-3339-4a8b-850a-ca5643939c8b@oss.qualcomm.com>
Date: Fri, 27 Jun 2025 13:39:07 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath12k_pci errors and loss of connectivity in 6.12.y branch
To: Matt Mower <mowerm@gmail.com>, Jeff Johnson <jjohnson@kernel.org>,
        will@kernel.org, joro@8bytes.org, Robin Murphy <robin.murphy@arm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        1107521@bugs.debian.org, iommu@lists.linux.dev
References: <CAPDiVH8gaBH6o_OY-zUWYpDbj5mhiqmofKGb71gLgHOi4vA=Vw@mail.gmail.com>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <CAPDiVH8gaBH6o_OY-zUWYpDbj5mhiqmofKGb71gLgHOi4vA=Vw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: XhLPe21wEoRRPVhgR5Q2x2HywTz-Yq0y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDA0MyBTYWx0ZWRfX6jA9S6vESpZB
 xZYhGGfZjdcRs0EEJd8nb/OmfMUD3W45X/duGDcXKVywk+54P6dIvzUQVkkggj55xeJMi1w3S6n
 8i2YzW2oM6E5E7vUebk6uwxWlTz7YAX4FaT75ImTMz7N8QEnLpj9uoX74LaIUX7sag2ePIQyErr
 y7FbEwbrV+89PbfStAIDkaVdjtLDmi81pA0jxeHLYiIhf9mm9j5NbYX0lK2hcjqhJPxreizX14o
 N8miyhBr3DBTQf8v28juKjHUcu7R+rVEa/rA+Ec6Ez1kWhISPSIdQ76lw4kJ6v5lqmvg2O7sNRU
 dNCaal1hUW6r4do9fZj22TH3SNEV7y2jBFdJLdvs8BR+zFqcVGUBmonQH6XsHOxDpCGWXfuslgS
 EBvXuherAf3o9AnpTWzco/iPZSrS4LxCsS/QcPHjnBpNuDSEV9Em5Q2S5MZJcx3xCYmwuUN8
X-Authority-Analysis: v=2.4 cv=L4kdQ/T8 c=1 sm=1 tr=0 ts=685e2e81 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=xNf9USuDAAAA:8 a=1nlNwiK_QeuRR0xryQcA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: XhLPe21wEoRRPVhgR5Q2x2HywTz-Yq0y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_01,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 bulkscore=0 clxscore=1011 suspectscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506270043

[+ IOMMU list]

On 6/27/2025 12:21 AM, Matt Mower wrote:
> Dear maintainer,
> 
> I have been experiencing lost network connection with the ath12k_pci driver
> in the linux-6.12.y kernel branch. Often, when the issue occurs, the
> network does not recover until I reboot the computer. A full report of the
> errors I encounter, the symptoms that arise, and several dmesg attachments
> are in https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1107521 . I have
> attached a dmesg from 6.12.34 for convenience. The short summary is:
> 
> 1. I started noticing log lines like the following soon after boot when I
> updated from 6.12.22 to 6.12.27. After these events occur, the network goes
> down and often does not come back up.
>    ath12k_pci 0000:c2:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
> domain=0x0010 address=0xfea00000 flags=0x0020]
> 2. I was able to reproduce this issue very rarely in 6.12.12 and 6.12.22.
> The issue always occurs soon after boot in 6.12.27, 6.12.30, 6.12.33, and
> 6.12.34.
> 3. I have not reproduced the issue in 6.15.2 or 6.15.3.
> 4. In some cases, when shutting down the computer, a kernel bug caused my
> computer to hang. I haven't determined whether this is related to the issue
> above or an independent issue. Search the bug report
> for PXL_20250611_140820085.jpg to see a picture of the kernel bug on my
> laptop screen.
> 5. I have tested two firmware versions:
>    a. fw_version 0x1108811c fw_build_timestamp 2025-05-17 00:21 fw_build_id
> QC_IMAGE_VERSION_STRING=WLAN.HMT.1.1.c5-00284.1-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>    b. fw_version 0x100301e1 fw_build_timestamp 2023-12-06 04:05 fw_build_id
> QC_IMAGE_VERSION_STRING=WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Thanks,
> Matt
> 

I had a quick test with 6.12.27 kernel on both my Intel desktop and AMD RD but didn't hit
the issue. And I am using WLAN.HMT.1.1.c5-00284.1-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3.

As mentioned in the Debian bug report, since reverting ath12k patches does not fix this
issue, maybe it comes from the IOMMU subsystem?

