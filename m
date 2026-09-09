Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC9F43B3EA
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 09:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946483; cv=none; b=aBlS7mrV5iDNvXzowOKzRPL6+THlwauCNGdpRtEb3dUkT4qiWI5wR7YMYdL6XfSfoM3y0/ESM5GKWFPZcRCb+zdxvlpfje+50lrFcCSRPHkAa2ci2YOlcyO+kW2x3pmIBgg+gpXx/C5ojKRJGwSWjT/V6Ws/oIZVo/3bh2EP2uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946483; c=relaxed/simple;
	bh=kNqW4sSYGE5RLkZoBx/ZOl+rx5XiXMMo2xzg3a4N4Js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XcsxEGmi74OYUR1v+96xkfOM0KU0BixxJW9RW9RhwuEBd0dFSfKNGEKuK9c8Ja7j8VmgZocC/D9wBbPZVQ9rjq9ICVMINDqeEZKitNxCzI84nnGnmZ5GqfKoQHP7o9RzXwG8k6CAoH/n9TgMW0BkxTOFzYTLutleeW/459T0DOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jSd6TU9i; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kaLFgAez; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jSd6TU9i";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kaLFgAez"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6896iItF3653864
	for <iommu@lists.linux.dev>; Wed, 9 Sep 2026 09:34:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G3ioQZMKHwe0XM4c4x4bDZIuIz125l7nRfQhXfiQNYQ=; b=jSd6TU9ikeRQPs3y
	FeEwVvdiWJ1SfErQCQQiALnOJ0hXnDx0R6jmtUmWrtbvMlDXaMiLwB4GFCgl1Guh
	lCm+eOMTpPIjeu+JFw6a16zZRtaO4Z9eYJu3BMOfYjVFoetNySyIYSPunU94X5a+
	UsruwzKZT8hVNpeC61WX/V1UQjWb6cwgYewmIQPMnZpdFSV4Hg+7hkZbc0y0HHog
	/nAWya5FprPJiKaO+fu0Q/wnD+LnWYe8xaefRVyy6b5+5clRNqKdMofwq6e7RQim
	JgNdjESDhTlmWd5C0lLvmxSxjPAJ9R47vOIaS7D/gDpjkdzbI6O/LQyt2dMF1pLO
	h/ZiVw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjppp3jb2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 09 Sep 2026 09:33:44 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-398ba5404d2so1597864a91.1
        for <iommu@lists.linux.dev>; Wed, 09 Sep 2026 02:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788946421; x=1789551221; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G3ioQZMKHwe0XM4c4x4bDZIuIz125l7nRfQhXfiQNYQ=;
        b=kaLFgAezhBwacp1pjYGxdlXUm3mhIewhyjg9hRbDGw2C+GCLFkSZmxOw6lXUojyTLG
         ZXyJOwHEE+IS4zgFJgvjblcC9vHoSa89Bg+yNE3LrD/hnGXNClqDR+JzWe9kFUSfud2X
         i4w14oRhQq9Xxu1adTd33D2BBYHqoqayXiiFqGpO2h49p1teY7Dr62oQzyReMQ6JdFWu
         8sShI6PbuD0SC2rG6PYuOsC1zZan+WbRd7ArbJ6CGsa/n9OFC6RAId/sysuEpDG+bZAf
         uv/dRA5AGKgq4jHl38WxAOWrn0/hksQHV2JD2eAu6iaF6C8sU2jvhsjVz+z1xbPQMSGS
         uxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788946421; x=1789551221;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G3ioQZMKHwe0XM4c4x4bDZIuIz125l7nRfQhXfiQNYQ=;
        b=tTF3OwJUeQN1csC776VsjBMIyiemOOr+P0ZzXlieBq0LH0k1HEVbZ42iN15PTH4Nq6
         7fESViTdRU4dChbDD53vBCZ86IXj5ylW0IFgII4ORUoy0rDv6dERGAbGnwSj24GURSgk
         B146P2Mg4qPnCbQums/ulIE/RLYezzv58bu0dZkdcAr8DaNZ++dK1OPd8DTGYM5rclEx
         bT0+Z99VCZnQs26IF1qcTu8NlRm/hU1Wq3PKlOn1/7XU2KKJHHbAtdWCXAJmxj0GbWbR
         k6dy2mB6alAiHTf5L3jbQyO2bpaR4OWyiKEYmwn8cZ43PFGf8nLpc0KmQWNppWKtqVSx
         hF2w==
X-Forwarded-Encrypted: i=1; AKwUvBxa0kpA3xMtZXbcpohXZYBNLq7WKmaqyoi20GqGHw2/hrKjIN76eaCoNGmC5XTeFwk/qagFHg==@lists.linux.dev
X-Gm-Message-State: AFuF++mXBtGLp+4e7bqZ5sFZU4LaXoOZ0mLCSwsTfSZJNqxtKGW+orFj
	iAU2nrrF5kVUJvsBUltvwDmUqpugfVK4sIRxR2LsEkdcNowjsCMYg24xub6rBEHCE6pXuansCXD
	zuP3SX7VYT25/v/GpHg6YeoZTrgCSGfYOZpFhSz6fgOZJe5bsed8Xv5aRsQ==
X-Gm-Gg: AYBFou2qPSH7d+9c9/ZUmFVgcZxtGfrUOmfYR9LICefkYERsVmhabZCyt4empkhLGLt
	BkglpSq8rovnMhY9psuVh7/ntVRiK7PWCoPGj0YzFmXJDlvUVfGB4zBE9llnIVUGYvSagE5NTBD
	U1tW/TZcLn8ArgG0e5gDxzJhWJKRQrdQUjyuzW3CNkZIhQo7AcG+diF+dlNIGHO0cj1l+qjlJsA
	yjkdSqNmfdJPO9mG5Fq5zC40UcfNV641RUmLaWTrAF7CY1lxQjqAtldUZR0bg3GdDBJeqW8TCGJ
	+9X7RuHuj5YESj3ucS5r84RwEE8e0xUbhrSKANJDN3Wcjtn195Zk11yuhWkITXm9G9/BGbTdGuB
	j2akkKBQArPJ2SQu8v4RUmqQnj6I/eA==
X-Received: by 2002:a17:90b:2c88:b0:398:ba56:b926 with SMTP id 98e67ed59e1d1-39b262e28c2mr56016269a91.25.1788946420998;
        Wed, 09 Sep 2026 02:33:40 -0700 (PDT)
X-Received: by 2002:a17:90b:2c88:b0:398:ba56:b926 with SMTP id 98e67ed59e1d1-39b262e28c2mr56016151a91.25.1788946420231;
        Wed, 09 Sep 2026 02:33:40 -0700 (PDT)
Received: from [10.219.57.226] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a534df1sm49524306eec.7.2026.09.09.02.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 02:33:39 -0700 (PDT)
Message-ID: <33042b5b-28c9-4df6-9c97-8b389a3f1112@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 15:03:28 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/15] accel/qda: Qualcomm DSP Accelerator driver
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: rob.clark@oss.qualcomm.com, Krzysztof Kozlowski <krzk@kernel.org>,
        Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
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
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>,
        dmitry.baryshkov@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Anandu Krishnan E <anandu.e@oss.qualcomm.com>
References: <CACSVV01eYr6FyA6XBG0xw0yv2dydvTEhcY-WUy07mxM8WwkZcg@mail.gmail.com>
 <318f14c2-0e87-4e07-8173-1511dca67d78@kernel.org>
 <CACSVV01T=ytVJKM7NRoBTAJm7vH+JPJNT9Tftu5X9YskGXerwg@mail.gmail.com>
 <e7b4eceb-cb3a-49ea-bed9-728c958594b0@kernel.org>
 <CACSVV03ypjBYkhRpt=TyDwOKhejKKke3x=Fi_TvxXN-5U_rCsw@mail.gmail.com>
 <fb834ae5-7113-4a86-bb84-ca5115c8d7ff@kernel.org>
 <CACSVV018jB4WRRJ_CUHQmkHXZcqauWJXWGgrzY_HA6cFQ+Q3Xw@mail.gmail.com>
 <dd3da35b-1db6-43a4-ae1f-35620692f51f@kernel.org>
 <CACSVV01o_XYuSzaYGbo9pY=459qiA_fgL_KRHVJH+LH4RYcMzQ@mail.gmail.com>
 <23e31249-cce2-421e-88f7-1a2af66e34b6@oss.qualcomm.com>
 <aqCKgM1yCbWjFdgO@baldur>
 <09f62d84-18ad-4d7a-ad18-9abccfd5e508@oss.qualcomm.com>
 <c447c7ef-828c-4fda-8e82-6983a3d0eddc@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <c447c7ef-828c-4fda-8e82-6983a3d0eddc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: vOREOZlD4Rag2J2f7JnfIwPUscGsXTvO
X-Proofpoint-ORIG-GUID: vOREOZlD4Rag2J2f7JnfIwPUscGsXTvO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDEwNiBTYWx0ZWRfX26sjt7Q8eIHU
 nZb/62c3XKidVgo9BHcQv8B1+lxuJGhTHxQXDRKfi9vt1JsLLwbdPQIfn4e9iyysCpG50VlbQSu
 9FCx1f7SoxlXVYc2eokWKgEWxQFRlfVhBXOmLIp9oRxlaxdwlXHB8swZ9rt94TQFmP7X0F0U0fJ
 YcNKIV17lRBM1LZDTtvbRHaovm4CwSxaiGoTrFopWV9DqE3zsyadpaUdYnbmziLUGRvxRoI2OJk
 XHkjk2ntWu2eJMk89bkhjXtrgu/MI0GICYGf9Gheu/CslnpGBniypQFynnEd8z6JlyTxRscPp5R
 CyIlki+n6WXLkt3v0sFxFQXXAEJQYQtLIrCasvQmXLYEbl49fqzCd+mWwI6hZ0mLp1VFjxy98sj
 WZ6MRhORLqH6+vyovWjqRse96zWGA6JJLRBKufsn24OaxKzdDU5J1N8ymWF9tp82tI3AZW9jVbV
 KIvJzsf9zVEpL9VtrnA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDEwNiBTYWx0ZWRfX7gYJbMjRAySS
 ju7/rUexDt0oD+gS54ftmnxbk6UHrB2ytkpclqnNQCPSs0XKsnLmXbXj2oeEbvmqkSXNODe2gRL
 65eyEufTP2m+VARI6X5a5eOVBJ/ZU5s=
X-Authority-Analysis: v=2.4 cv=DcInbPtW c=1 sm=1 tr=0 ts=6aa127f9 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=aHQZQ_1TodyndcZw4m4A:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090106

On 09-09-2026 13:32, Srinivas Kandagatla wrote:
> On 9/9/26 8:53 AM, Ekansh Gupta wrote:
>>> This is the actual problem!
>>>
>>> We have existing user space that depends on the ioctl interface exposed
>>> by the current misc driver. You must not break these.
>>>
>>> Hardware cutoff is not a viable solution, because that's just a
>>> declaration that we'll let the old platforms rotten - or alternatively
>>> you commit to maintain two drivers to the very same feature and quality
>>> level.
>>>
>>> So the only reasonable solution is #2; from there it's a valid question
>>> if you reach that point my stepwise migrating the current misc driver
>>> that solution, or if you present a new driver with the fully backwards
>>> compatible interface, alongside the new ABI.
>>>
>>>
>>> But this does bring to a question which the cover letter should explain
>>> - but doesn't: what problem does this patch series actually solve?
>>>
>>> Regards,
>>> Bjorn
>> Agreed. I'll target #2: QDA implementing the existing fastrpc UABI
>> alongside the new one, rather than a driver split by platform.
>>
>> On how to get there: the blocker we hit in v1 was that legacy fastrpc
>> buffer semantics appeared to need a drm_file, and there's no exported
>> way to construct one outside the DRM core. I want to re-examine that
>> constraint rather than treat it as final, since the legacy interface's
>> own buffer model (a dma_buf fd as the buffer identity, no GEM
>> involved) is not inherently tied to drm_file, that's how the existing
>> misc driver implements it today. I don't have a concrete design yet
>> and would rather work through it here than commit to one prematurely.
>> If anyone has thoughts on how the legacy UABI could be served without
>> requiring a drm_file per session or if I can somehow bind drm_file with
>> chardev by exposing some APIs from DRM core, I'd welcome them.
>>
>> On the cover letter: fair point, and I'll fix it. The problem this
>> series solves is that a miscdevice interface requires us to hand-roll
>> what the accel/DRM subsystem already provides as common
>> infrastructure: GEM for buffer lifecycle and reference counting,
>> PRIME for cross-driver import/export, per-file (per-open) context and
>> handle-namespace isolation, and the existing debug and lifecycle
>> tooling the DRM core already ships. Every accelerator driver added to
>> drivers/accel (habanalabs, ivpu, qaic, rocket) has taken this path for
>> the same reason, rather than each maintaining its own equivalent
>> inside drivers/misc. Building QDA directly on this shared
>> infrastructure, instead of extending fastrpc's own ad hoc buffer and
>> session tracking to cover the same ground, avoids that duplication
> Am sure you must have already tried this, but Can you not migrate
> existing fastrpc driver to this shared infrastructure under the hood?
> 
> Can you elaborate on what are the blockers you hit in doing so?
> 
> This will ensure that UAPI is retained and still get benefit of QDA.
> 

QDA's session model is built around drm_file, and fastrpc's chardev has
no drm_file associated with it. I'm still checking whether that
dependency is unavoidable for fastrpc's case, or whether there's a way
to use the underlying buffer-management infrastructure without it.

Please correct me if you are asking/suggesting a different approach?

> --srini
>> going forward.
> 

