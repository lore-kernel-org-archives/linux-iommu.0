Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E272642E8C8
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 13:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787751939; cv=none; b=QfEl7OjzG7ViFyMBDcv3pE59szOTy2yH4UHmOOBhVIlj8Qi/OGYKwRgLpKfQMWiabaZpOnWn2UHTx1VV9xXzAkV8LAXxI04mEZPf4KcPYkKeR/TELJ9MmCmppcqegb0tIszB1E3cMF+H6S0u1Rtpi/w77LmCuooGTpH2DcBKQLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787751939; c=relaxed/simple;
	bh=b3TbOLaOaVdbEoxxuz1CQtZAQmDctOUjkFHF9gAxpXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CXv0+1jcSZnbo8j7GNfLXD6xsh09DK93OnpIHLDOpTMZVemE16eoMka9yqw7hbM6pHYt+0RHwvwbR0FfwWvt5U7YZWfVlJAh9yQiJnZN+6l7VtZcaNsEj/1/f9PSyR3MSmfgiLU8x96i6UIkAQOaro3Ycoh5d8N7vVZgCLkwgbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hlNd3RgX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eQaEpoRO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hlNd3RgX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eQaEpoRO"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QCUGPV949392
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 13:45:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4jnYIpJgtFEZlWrcRFiUwalcwxZjoeOSevlSYM3+k2M=; b=hlNd3RgXSWmiQxeY
	bbtdV+I8fqLURJiyTIgClpz0Tr8jUPb/86Dv5BytCuvpCkSiYE7mnx38abo6bJMq
	GjE9WG8+JKCJkKlYb0RJS8sWBugJ4FbAMqRouy5blxcv1fQmCGIbm1oml9W6uyTH
	ef8Pna7IoNIgndJZ1ObAEwbaU9/pb0zYQD3t3Y2UWWqkWOu4IwJFSUPGu1aLnhYm
	214P6eaLNfyjtRKPHkvmniCr8A9BwTWFvK0eJ42ay9hv8UG22ttXfiGKG53RNmSF
	MQhJEe/Hv4GgzNS9dwjZUsGE8AREGlMrUpU85qt8eCx75ccDuh9q7j208avufXzG
	pstV8A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga07589hw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 13:45:19 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38f5ac7416eso1619386a91.3
        for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 06:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787751919; x=1788356719; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4jnYIpJgtFEZlWrcRFiUwalcwxZjoeOSevlSYM3+k2M=;
        b=eQaEpoRO3I6tD8Q3zz5j8digcyNUe5uMciWthDkjekJhe9B/GtmU5a2aUfrDu2sbsT
         lje1aRt+P8PKm8MmDH207+TjAq6rzWFIRBkjwdI0kWWD+PyZKJnWh9DfHD4MYyVkm4m8
         WKcj9de7UFjaQPVi6kTWSzdz8eKHmfzY/S8R9Fh/gctOFdSOhiUYrj3M+aE28gHNo6WM
         CKnhs21YE5XLu3rFOf6Ckk9eQJI5M6V5JJ3vA/CWizWQkJtkYwvpC1frrWDx9cWS8Dlr
         1RBoDt8dcafrhsdpnsdNGfehAo26aJCYQbdZv1uWRqo7LAqfbZ4U5A7+jMaV0reLwAYn
         oBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787751919; x=1788356719;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4jnYIpJgtFEZlWrcRFiUwalcwxZjoeOSevlSYM3+k2M=;
        b=gQTd7afXPscni6Nf6CiUXX56j6KU19Z5sDPjaRCZNkZJv6ROrT+maa9wANnGc5ZT2S
         shUb2sVTeZeqx+3E77eO8sekskOe7F6JdX8s+yzrXM0ZsoOLneA74UnqjMaiygPmEomq
         pts6OEaY3qUN/mE7QM7QGN4TILG5QslGHzkLcILcq6NdwN54oWLdISKaHS+LDAkvBXGG
         RVnkO7H9VJLtPjJFhR1lUxk1zUui4aJtC9JkVSLi8sPQ9cWBCHHUC/FrrR//KVQfGNCs
         gEVlUJxDlHVN4T2G8Nhe9ahVM4WBROIe7IGGfSMW5mOFHRFuzHw9xEl6EIt81kcKWHrW
         h0pg==
X-Forwarded-Encrypted: i=1; AHgh+Rrgwl47UlqjJDJH/H/1VC47SaDjoNp+sszJYW2FX9R6N3C3/UwfB6Op5QNapBf/z0dhvcDoCA==@lists.linux.dev
X-Gm-Message-State: AFuF++mqiYex8KaTvqsnxzQAknkMukpIusR4vPXvBHYk1vzJwv/ijSEq
	kTzge9W2TWAS+p7tQ3euR03Rfoylr322lIZwGdVn6A93Vzm11cbEMgf5JgnPt7Z66dDV7StYzDv
	xJDzLZqSKo0RoDxFm3esJcYJO1gkb00SxLys8vHccbmUWdAaQOd14cMV+Zg==
X-Gm-Gg: AR+sD13zJZicSVLGQyG6ONHWFQ/n2Zp7+VtF9mEdawG5PiQCkq8KjAUisyp0ZkjaUu5
	IMPk5ihFrALGAlpc3yOrLsi1IBt+ruRSb/YZ5M1ybGXzG2boOK0AxxFFcnnYkx9hGYpAosti3WH
	WiwqQ7mgD1WWeapkv/3nUMcDOn3P8uiw51mJQV2wUrLoE/eJ1M4XgCii3THr3gYK6fFD6uHNG+Y
	Ufq3SM9E3YutCBRfLnri2pPzEXzLfGCY2N3hwAO/e0/oV4P/rLTBAy+NV22Agl2clBq41NKSw9K
	O/wKwiNovudB60WrgLAmmUy5eLMEacycSMSRujMHA+LwO1xoddq7FDQhqfUnBDPIg8Br2lzpQdu
	2TiOcgOpLGX9XF/mWAKD0zqIx4L1LBg==
X-Received: by 2002:a17:90a:d2c6:b0:38e:5c6:4db9 with SMTP id 98e67ed59e1d1-3966d3dafb9mr15825943a91.11.1787751918698;
        Wed, 26 Aug 2026 06:45:18 -0700 (PDT)
X-Received: by 2002:a17:90a:d2c6:b0:38e:5c6:4db9 with SMTP id 98e67ed59e1d1-3966d3dafb9mr15825822a91.11.1787751918186;
        Wed, 26 Aug 2026 06:45:18 -0700 (PDT)
Received: from [10.219.57.226] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8f20036sm13571333c88.5.2026.08.26.06.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 06:45:17 -0700 (PDT)
Message-ID: <2febead3-0f0c-4e0d-b11a-8c61ec027f44@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 19:15:07 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/15] accel/qda: Add DMA-backed GEM objects and memory
 manager integration
To: rob.clark@oss.qualcomm.com,
        =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap
 <rdunlap@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling
 <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>,
        srinivas.kandagatla@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-9-69a02e9090d4@oss.qualcomm.com>
 <7030a8f8-f320-4b09-b2de-2c8e897409f8@amd.com>
 <CACSVV00MubttbkVJgMommPMorf67yqn7D1kfwpxVUZ0t-6au8Q@mail.gmail.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <CACSVV00MubttbkVJgMommPMorf67yqn7D1kfwpxVUZ0t-6au8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 92Ma8DAgbqpP3icRor1RYoeSR6iIbPhI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDExMyBTYWx0ZWRfX2AtPm2Zf7ybG
 jjCntwDgck5UgeWaiebX9FZNCOSVFHMUj8KcCHyIkoCZlbAb3t7AZ5/q/YOUNlBoX5Mwqz+Sf8D
 Xc3wGCXHrq4ezpmKoSmqOnrvtxoM9JUwjSjuV4vC3Q25AL3xtyl1irv6N3Rlmk7USOu0ei81mE+
 pyORavtn+sngXSxBN+Ko9yl1rJIrgbeEjVI54jBzNHXxiSXCFiQvZY4CqGReks1E9WVcDnJomNe
 f3/c1T3CjmfYim6dyRpCasv+utPmQn2PoBQnCYTCEfkO0red8j1t3KQ7/wkdtkELJfvtJ67hujL
 qfqPjOe9Az+Rt8gXwe3DDgdGdgmIzOWO66YAlOQbbDM7B8jwuRzUqC1le2cbX8jyNnqApW46UjY
 dNBf90a4UwE7PMAIMg60kBTrY5I2blTH6PvoCypWiGq3z72CKBziLkRSans22lscrxMWivpo0DK
 YbMO9Y9eSUIovJufaqw==
X-Proofpoint-GUID: 92Ma8DAgbqpP3icRor1RYoeSR6iIbPhI
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDExMyBTYWx0ZWRfX0b4191TIOYCT
 lhW0ypR+qxqDnUA+/sFUSzSNxcRnybNlx6goq1qhBWYHTwknw/Gl/f01NO0zhGYwbKnYLngXmiy
 j0UvVhRcr7K2cINTGgtfV4zbLVpkwQg=
X-Authority-Analysis: v=2.4 cv=RPiD2Yi+ c=1 sm=1 tr=0 ts=6a8eedef cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=sLzL-2GVjjNmCx-rav0A:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260113

On 24-08-2026 20:37, Rob Clark wrote:
>>> qda_memory_dma.c / qda_memory_dma.h
>>>   DMA coherent allocation backend. qda_dma_alloc() calls
>>>   dma_alloc_coherent() on the CB device and encodes the stream ID
>>>   (SID) in the upper 32 bits of the returned DMA address, following
>>>   the Qualcomm FastRPC convention for IOMMU address space tagging.
>>>   qda_dma_free() strips the SID prefix before calling
>>>   dma_free_coherent().
>>>
>>> qda_memory_manager.c
>>>   Adds process-to-device assignment: each DRM file (process) is
>>>   assigned one IOMMU context bank device for the lifetime of the
>>>   session. qda_memory_manager_assign_device() first checks whether
>>>   the process already has a device (reusing it with a refcount
>>>   increment), then falls back to claiming an unassigned device.
>>>   qda_memory_manager_alloc() and qda_memory_manager_free() delegate
>>>   to the DMA backend after resolving the correct CB device for the
>>>   calling process.
>> Oh, stuff like that is usually a pretty big NO-GO now.
>>
>> AMD has made the same mistake with KFD and it resulted in a massive chaos.
>>
>> The DRM file is the driver context your process uses and even if there are multiple DRM files for the same PID you should absolute *NOT* share anything between them.
>>
>> The general rule of thumb is to not attach anything to the process using the DRM file descriptor.
> A couple other things to keep in mind:
> 
> 1. drm device fd can be passed across processes
> 2. virtgpu/virglrenderer drm native ctx is a single process that opens
> the drm device file N times on behalf of N guest userspace processes.
> 
> All that to say, Christian is right here.. drm_file is your context,
> pgtables should be attached to the drm_file (potentially via
> drm_gpuvm.. which you perhaps want to use).
> 
> BR,
> -R
> 
>> Regards,
>> Christian.
>>

Hi Christian, Rob,

Thank you for highlighting this.

I'll rework the CB assignment to be per-drm_file. Each open() will get a
CB assigned from the available pool (find-first-available, not
find-by-PID). The assigned_pid field and PID-matching logic will be
removed entirely.

The hardware has a limited number of context banks that serve many
sessions (on fastrpc, via the DT "qcom,nsessions" property), so multiple
drm_files may end up sharing the same underlying CB due to hardware
constraints, but while implementing that also, I'll ensure that the
association goes through drm_file->driver_priv, never through a PID scan.

I'll also look into drm_gpuvm for the longer-term address space
management as Rob suggested.

Thanks,
Ekansh

