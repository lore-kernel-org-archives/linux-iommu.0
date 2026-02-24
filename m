Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E48616A395
	for <iommu@lists.linux.dev>; Tue, 24 Feb 2026 03:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771903997; cv=none; b=j2iurLAb1VvZxmtpSk6kWzxEWTR9f7B+s3nJmRYeJypP1UT1kqblysb5DBODgbIxMtJiohaBeLpxFokbhz4gfc0Z7GsBYPi69egzl6QfVcRMYxMlGNaltKYGx89bgRhQ3NTt9+E/Bi5fPt9lYGSbnlo4HBVOhybCvgmqAxUP1bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771903997; c=relaxed/simple;
	bh=alwlXydTZQTHU+SrbhxPkAVBaJ0ViLt6EMzcXAEspXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HMNcVDkJYxMezwccaHDiuHK/qEwZMDD4E/g1qa3iR2dHiIseyLypNYNJ8vkpEg+m7ToA/CK6Aw8TQOkAnKsJIJm2SYBEuJ20qJmwFNBtgkCUl2HbmdQ/ee8guLQWzWvh5f5bHB5Y5xT8C10CP7kEKkc1tL7Y3+v+CmbuSgtM9Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MpsmBFFf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IGTM2LFo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MpsmBFFf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IGTM2LFo"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61O3KoQC2997010
	for <iommu@lists.linux.dev>; Tue, 24 Feb 2026 03:33:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cw5oOYysEVaaTcVwIagtgtb1acPAUP70RqJhekAP7Zs=; b=MpsmBFFfOVHfn/pk
	Gg4QcxaaZhK4U4eeUQBi7urMNKOvTDwSza1oS2UzSLIHLFy6kA7W7NleuM4sn6pl
	M4x4z6TjyHPZgg4ou/d8h8DibM3bcqEdiwQu0FeW7LgGxLih+lLSrErJxFh5rbzX
	joWxCc85TVP2OaJiKwZxzYkKcrm6kl8YijJF6ZMr0v7LH8HP2qqM6Z0p5yvz6YbR
	XjQe9GyKv84EeXPKNaDjKC9RSLpcMfINW3laTZ+VfF97K/O+0n8fHtp5xtJi4egN
	BJECOTqR8p85DNs0EfpaZlyZzaGKFuO8gdAkbKig/BVcURryr6jTJC7DzqVx83T0
	W1ob0w==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgte8sn9f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 24 Feb 2026 03:33:15 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-12711967e0eso7024353c88.0
        for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 19:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771903994; x=1772508794; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cw5oOYysEVaaTcVwIagtgtb1acPAUP70RqJhekAP7Zs=;
        b=IGTM2LFoh/peiSt1KsKvvRWUtg6fep6Fhyo2wAVJbd+Ug9D0RNHuEo0YrTC+/Fq4a6
         97nDY2FbbA4ELdmX0ZP4hVtj4+k/fgeN9JwxcLMuwevHvA9vk8t3ufHb8FqHIcPx6/Yu
         r5cTbGrqdAxYNfahzsa9ZqkwVb7KlnvAGQ1AAWe5dKpBU3NHI5OobTiDC/LxkZeHzERU
         91tIZhY7fI79p+yARy1/JlK7CArHO6Fc/QwDiwxj2mvBI++Buf6ql9Ek7W3P04EqP+Tz
         1OfY2z+sm+mw5oawjcsgkqkYW0vICVSF0QLyBejLmf7RHF8FS75g3oqf95mvj257npmv
         R6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771903994; x=1772508794;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cw5oOYysEVaaTcVwIagtgtb1acPAUP70RqJhekAP7Zs=;
        b=IOnIl41BbZfg370xiG0EujP6XO+PI7SqFg7LHv7DW1qUOOpAEBLBUJmAb/FLsf7T5x
         NCSiTj5c30kATMzJukx1sPQZKXZzPyrMeP1+9C7NqEz+Xk+6ptiMnDMpbGig76e1x1WK
         FuxBCzKpNB3ATjR/1ykMcvZITBUNsa3++WtKjjMD4nKC1NEmQplfxFIW6jHY5WtzQNJX
         MNERu1p8Z17kudZsU2+1KNlQHUtRWmrsHEjIvEPdVqekpny0+Xt8WLu/nsg2WWVIzUWC
         L4IWZaWdwKkjm2UcrHjDORw8lYjotmmsRsmJb4tYMtCU6sVhRWtJTtPnsE20pJGvInTk
         A5vQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv4tG6RLwVYgMQ//ZaM5gWDR2iujuq8swio1m/z1PpgjzKJ/MKkdsjzkU/pcRju1cOHkjcGg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyl68pWnqUXUoU9JBWxWoGj1w3GFHwrSy9LwrA4QPZG/M7hzLvg
	gFOcLOaYF59lcXqTOqY1mXgEB39VlLbBhj50UANBBludLgLTTFj5ZWWOWI3guyr9uuctSK16GmI
	QAo+MzytfHVhl/phXMFQhsgGTpXKezkd/3zj3iZUP09R5bkGHI/hN+gCzgQ==
X-Gm-Gg: AZuq6aLYiOFY3AAvC1ieNJbQkbr2H9juK2GnJhhdi8zyHUk2XFrDiSTbqMvArzEHHDv
	kVpDYCt6EQQMtQYqUdUPYzRCsw331kcJ+UqcUF1Md0taN1SwXXTK1vWpex4mkXCnMnS8xeaGQZP
	dEP5Fopf2lH87lZXTFozLAJm1RrEme97hXi6i117ygx3GE/Lv2JcY0qU9fSsWsxpaeUyxo6IqqX
	hOgNiKRb3K7jzSLBi1vy48vt6A0jnxAHDulQhHsXygTz6jQ1adoY5dc7fw4WooTge/wZ9oxKEyc
	ylbclyiGxSlooQHiAXQdFEXo5GzdKex/on0kShcFSsc4tZTkpkM9NKh6jJ7NvXxdOl+kEyiG9EP
	3pGRZkFXAEKmUcXotxqMd69/yq7UMWmIU0uKg6qhAt2DqSALPg4joKx0=
X-Received: by 2002:a05:7022:4387:b0:121:9f05:c4c2 with SMTP id a92af1059eb24-1276ad18ec5mr3365890c88.23.1771903994052;
        Mon, 23 Feb 2026 19:33:14 -0800 (PST)
X-Received: by 2002:a05:7022:4387:b0:121:9f05:c4c2 with SMTP id a92af1059eb24-1276ad18ec5mr3365882c88.23.1771903993530;
        Mon, 23 Feb 2026 19:33:13 -0800 (PST)
Received: from [192.168.86.165] ([76.176.48.107])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af20fc8sm10325680c88.6.2026.02.23.19.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 19:33:12 -0800 (PST)
Message-ID: <e94ce683-d47c-4c8e-8b26-cd327c891cc8@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 19:33:10 -0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 01/18] accel/qda: Add Qualcomm QDA DSP accelerator
 driver docs
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>
References: <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
 <20260224-qda-firstpost-v1-1-fe46a9c1a046@oss.qualcomm.com>
Content-Language: en-US
From: Trilok Soni <trilokkumar.soni@oss.qualcomm.com>
In-Reply-To: <20260224-qda-firstpost-v1-1-fe46a9c1a046@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: MQVE3WkHfkD2ijTrSLOkJZ9kdyI6ovIP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDAyOCBTYWx0ZWRfX3GMRjTfqKAWh
 rAlWFtArsxiiwlNAr9abfFc38nYJpLR/qbBaGuBXEZoV7T1WOWUvh1p7DbrJNYNP40AS3JuHSNE
 JvTPOF4bRxJNUCUkDyFyMPZDFi+VMf0yRmxZp3tgy5dRfxdWmfi12ZvMLtESC1s2LpUlVrtrYrx
 1/iAOm8IirDpzeX32cEqazwC8Dy/WSh72E7xECTvlizbzES7u83A6lBS+1fZ55R0okpHJTQBJf3
 JX/nn3R1b6mcNKWsEVghoRzqL7vaB0DSdhOjOslab1wAJY0c08Gnetd6d4DR9tVLj2Rdnpw9tO5
 qhPBmJxs1N7w5UwfISsMyub6/yPaJB+5Lvc9xeAY6ckXCUwAlbd5PtmnlIAvVnPNbv/L3x/qVwC
 ko77S5UFBGRSEVXTeoYpEcZDQcqNFN62eHwMMoxpUGJtPUNsGNvW1sh19dyIdOZ2qDfC7n8XyuE
 nY1vUU3hOLHfpx2ZmdQ==
X-Proofpoint-GUID: MQVE3WkHfkD2ijTrSLOkJZ9kdyI6ovIP
X-Authority-Analysis: v=2.4 cv=WqQm8Nfv c=1 sm=1 tr=0 ts=699d1bfb cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=lsoD3MMNObdLvy1227ExmA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=88Pab4rnIKjo3RbOS5oA:9 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_06,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1011 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240028

On 2/23/2026 11:08 AM, Ekansh Gupta wrote:
> Add initial documentation for the Qualcomm DSP Accelerator (QDA) driver
> integrated in the DRM accel subsystem.
> 
> The new docs introduce QDA as a DRM/accel-based implementation of
> Hexagon DSP offload that is intended as a modern alternative to the
> legacy FastRPC driver in drivers/misc. The text describes the driver
> motivation, high-level architecture and interaction with IOMMU context
> banks, GEM-based buffer management and the RPMsg transport.
> 
> The user-space facing section documents the main QDA IOCTLs used to
> establish DSP sessions, manage GEM buffer objects and invoke remote
> procedures using the FastRPC protocol, along with a typical lifecycle
> example for applications.
> 
> Finally, the driver is wired into the Compute Accelerators
> documentation index under Documentation/accel, and a brief debugging
> section shows how to enable dynamic debug for the QDA implementation.

So existing applications written over character device UAPI needs to be
rewritten over new UAPI and it will be broken once this driver gets
merged? Are we going to keep both the drivers in the Linux kernel
and not deprecate the /char device one? 

Is Qualcomm going to provide the wrapper library in the userspace
so that existing applications by our customers and developers
keep working w/ the newer kernel if the char interface based
driver gets deprecated? It is not clear from your text above. 

---Trilok Soni
