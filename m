Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C6D3ED137
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 19:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772046740; cv=none; b=dZWg6h0OUuTM5HGjPXel76nHZJ5wOMWl0kNCMGF1QpVlpfWKezbapuKgE+vMN4qc3yNXJvuZMJKvwmaeSOFTnFtBY80Fl2R1ar0so5mPqnbKIjcW9J/+dhlxoaFjk80FvW0hxCDPlc9pGeKsZmvaX61xmMBwSP3l1OGFnnR02xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772046740; c=relaxed/simple;
	bh=3UffeSYJ90UKEt6at8F7y8k8ed5aDBg4BiH/dDRiY2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTFUokCWOBKueXtUDpzeTlyjKGeApKFrXwQO6n8nkpqquhX/BlkfecG40Ty7Zde+M6qjgyMAjAiMDu6cxI2UETHZINjvR9SoSVaVnBw4eriCdv86C3MH8w2HKaQTZOjtDNO2Y9hU82gWrqQ9vYsiEEBZvxv+763DId49ea6IQ6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WCm1INdN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Si5zyRyz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WCm1INdN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Si5zyRyz"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PH2ODM3101009
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 19:12:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Lg9srVmRK+oZJLWJq17xoEHm
	pPxqRtxhu3c9PChBOMk=; b=WCm1INdNRRhbh84DyjMSXzpeUoIeQXVsQgHBlF1h
	Ndkvbhvx3lXr7E9lEF/C2lv7P1XNL91hKJWoBQPh0Ju3cQ8qDmL8N4hvHi5mx4Xb
	xpvtgujVzIept+Zev/RH/7hr17o5f9CCDpLLq/c7ZicXw3Ga2LdzZX3eXzwD8av9
	9hGSbTuWBNDjgYpAJRgqznmnbhInDU8kIHwTTvMK007WXU74W2nrIUXjgZRCiyr8
	ZDgLf3CSVdKV8UTUfhoIJCPhtWkXt+diNrnOdGZ/33Tl3HfsLLImO8fyTA3KdLeB
	qw/AJbDZk+cn0Otpvkc1kuFzAmdGKQy61y9ZbdjiYvRPZQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cj54p8fe5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 19:12:17 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c70e610242so5855849985a.2
        for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 11:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772046737; x=1772651537; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lg9srVmRK+oZJLWJq17xoEHmpPxqRtxhu3c9PChBOMk=;
        b=Si5zyRyzsM3lkkGUNa4bgJBQj2HQUKI5qU1VHfFi0cYiqInja/p1GRUIwl/jOCsAFG
         0SDOD/ujUVsetIV6mHrev/ZdO2cdqAAYRbfAmN3bDQpxNueIFErQ3XxXHZJndSzvcUul
         dCQb+WZuRFSlrfKu9dWvbH/oZv4zwGhWrdzWy/XJy1lVAHogmSXXIK3n50BNNGEmQfEi
         rqTQaq+GLZlVZsfUwKVwCk77xHv97Nx7fVNNuCJqPcerZUuWDfHf7zb69dyx5XYvYVVr
         QFVul6ljlgjMT2CIR8SyLLp7c11fGqOX+d7nEuTuHLdF44+l7jldL2ab8mw8YpNYiU0i
         aKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772046737; x=1772651537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lg9srVmRK+oZJLWJq17xoEHmpPxqRtxhu3c9PChBOMk=;
        b=EPY7oPeMyO/ABA5zoxhzu8kLgCWQfYzRUtnIDxm94SlcqIiJ8ypKNXa7axbj4h25kB
         P6NnUKxTo7m83u2W6Rzb2K5cEcy0+lnQXy+DF6CWd3TadsF3jluBWdUu2Gw9C0OozRiK
         PZp7US9sbhdxlYWt28U7KADJwBUwbmdzOPbGPTeLDS8gw1Ah3NFSwh1S/k/zFiwc/dqo
         6wGIYMWP1uRd45w0gcxcMMQpskrq22t7CzDCFWzQyFRHrhuHuCbGD+t5Kt8A1lr6cBhg
         NAswht1whi6M4hyxIwbdtfXgGEkIy8A6D4YVgigXZIKeU/SwAzB9i3wl8bDowM0REr2o
         qU7A==
X-Forwarded-Encrypted: i=1; AJvYcCUovKTQ8lY5txSWNlSGOkdDl12Bnow3tMzxJ8x+BsBxuh7LwTDkB94VeB5peo0EZPjjSMxIGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzp9mgiVNz08e5fuGsNvoyIGzyql3NDytou5gXh4M3odCe3dDcM
	1Firlv4cXXE+NNiiR39gGyeX/SsTGRuFr9d3QHMSePAtN+nuztU770C0DdCCtQkN4Y19gYHRJM/
	dltqV/HraR/GbvwUmS+oyBgiLoceBclxsNgaebnmM5rwYEG2d08GXHBrMMg==
X-Gm-Gg: ATEYQzyreo7CWRnFMcNPlppwebDYJA4Ku9nqBphC3ab1K9BhLCLDw8Qna+Jc74SkLbh
	uUJWG3RPRxqmPUJ9fayqZ1Ckm7fkNdMhZcNmluNnOsN6Em9JtexAFZsF82ieNPA5IYNQQN9dL6P
	//HU1bhpVrax7mndhf6sXXKDdGJPx3v4olecWR8c6dEfVVZB63BUq2bT9A7Mv8ZS5If8XQr9zOG
	JVvEwENZyKTIx45Qm4XvzH1EcuxJQ4T3ajExHn+1uCj4XV6P6qlfdn260IkqRhoBYG+8Mfy3p57
	2/uO6vRDBiMGg/YFBW/AdbbTcg85JczVCHc56fAtUw6YPtwRcBoIUt8lC/ZctyWLoYqcpYPGuGS
	nGhfGNfaUQDLyCCG3ZLKt96Vlb7imNgAFDWY+zrC7pirBBBpUcXO71Nr7WEcApuw5mfkKgd0AAB
	mmNsej0N0T8PxOsH+fWrdlPYkHs7l7jOQ2vJQ=
X-Received: by 2002:a05:620a:440a:b0:8a2:ee8:e7cc with SMTP id af79cd13be357-8cb8c9cbf76mr2070540785a.5.1772046736849;
        Wed, 25 Feb 2026 11:12:16 -0800 (PST)
X-Received: by 2002:a05:620a:440a:b0:8a2:ee8:e7cc with SMTP id af79cd13be357-8cb8c9cbf76mr2070536685a.5.1772046736335;
        Wed, 25 Feb 2026 11:12:16 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-389a7a1feb7sm30070291fa.29.2026.02.25.11.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 11:12:15 -0800 (PST)
Date: Wed, 25 Feb 2026 21:12:13 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>
Subject: Re: [PATCH RFC 00/18] accel/qda: Introduce Qualcomm DSP Accelerator
 driver
Message-ID: <vgcb4n6ciybslspdoa5fkvb5zwz7xon6tnxjmxxzkqutabgoq2@sgbxxtgdyeig>
References: <vU2QyEVqOu-D3eGp7BZFICUeauxL32bwWzeidOAijoeVaJTk8KcRVsaQQD4MdFQEcaQTZ5RkzRsz9-Lhl1qsqg==@protonmail.internalid>
 <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
 <172a9083-8cd6-428f-bd3d-d831e610b37b@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172a9083-8cd6-428f-bd3d-d831e610b37b@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE4MCBTYWx0ZWRfX9yJEYC46GIym
 gydmIYulx1jDqzdHd6u2p2JoTydI1lHV9kUzp7T2+ixhXRf9rJD384wdGX/ZIQngD+hvoMNB497
 aPGQYUsBMB7CnCd6niX+rzi4MgcDVnxAz58b71UgbiusHiP49gFRlhPXWh1hVK+kcfBAIJWIUnR
 bqlD4q7tuaBZ3HW6FoonZ2Ge/+6Ok30SdNhJBx1xfzKLoybgDxDRPaSNosCeSoSZeAKJjzf9+s/
 SjVymb/iHuGefaONnUVm25yFuQhPwr9nY9PFuhVyenQz7GYNrlziyxbOPEBqSQ39HSH/nvF0uoQ
 YQOeZcPU8fZiJPYsxrzm8CUjUBCcopPH9t1RgEs3/Zt+FSXVfRH0eQIdt5hP54PUfE+9YXY4CvI
 u45QydMekTVEL2vCLmsB7P8iVQn8Dh+FrayChZ2x1ALKqRQJHVMCAeUX7kPI63pWgbsLT6eB2HZ
 7wg0I5JzJQYJS9Va3qQ==
X-Proofpoint-GUID: WdLpLeyIlqUR_-2VVm0hCViPgDrFvN5p
X-Authority-Analysis: v=2.4 cv=I5Bohdgg c=1 sm=1 tr=0 ts=699f4991 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=NEAV23lmAAAA:8
 a=DISFzqtZAAAA:8 a=jajewSGiAXp_dDDQNc8A:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=aug85vrO5LANNmmtkfAW:22
X-Proofpoint-ORIG-GUID: WdLpLeyIlqUR_-2VVm0hCViPgDrFvN5p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_02,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602250180

On Wed, Feb 25, 2026 at 01:42:19PM +0000, Bryan O'Donoghue wrote:
> On 23/02/2026 19:08, Ekansh Gupta wrote:
> > User-space staging branch
> > ============
> > https://github.com/qualcomm/fastrpc/tree/accel/staging
> 
> What would be really nice to see would be mesa integration allowing
> convergence of the xDSP/xPU accelerator space around something like a
> standard.

I'd say, writing Mesa compiler to build Hexagon code for Teflon frontend
would be a nice item. It would probably also allow us to use DSPs for
OpenCL acceleration. But, I'd say, it's a separate topic.

> 
> See: https://blog.tomeuvizoso.net/2025/07/rockchip-npu-update-6-we-are-in-mainline.html
> 
> ---
> bod

-- 
With best wishes
Dmitry
