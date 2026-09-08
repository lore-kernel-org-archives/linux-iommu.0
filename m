Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD85D30F80C
	for <iommu@lists.linux.dev>; Tue,  8 Sep 2026 07:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788853547; cv=none; b=MoahrXjxBm2dn4FcyYvgUvxAMn8jZm4otICivue65Ksf06PBKL8hZeDKoOMY2H8frENH3xGH3iOUQ39LKRXN8NgUaynKqQBxIyA3Qg3fpOdAETk5Uoh7+vkz5rrfqLt9l038RStuVlr9AtFKGES3PD3aduX14gomLuMi6V42Y3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788853547; c=relaxed/simple;
	bh=MYJ8QuS9dJHlh3zGd4Jjmjuv7oAWC7r/tOj6ovNMei0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JowBQlOoBJbYqlgx+loAEiUnrmQp9Ihx+FiYN2j1p13vYmKmRKjiQHzt49QgHlB9ZHbmg+gNfOjjo1N4RKq+brF51QHye1fdmLVVt+DMs2gj2GBPBPEesT9h156kRaEucyzThXPYngnLzMSDxSOSk25gdG9VANuuDL6BahSpteI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=meyDObDd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WJM5rSeB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="meyDObDd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WJM5rSeB"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6886Lm5n2502326
	for <iommu@lists.linux.dev>; Tue, 8 Sep 2026 07:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vjCdleB62PQ5+3oSfJm6THWjJHXQHO2Cei/sEBlVgJo=; b=meyDObDdxg1onozh
	BTIfrgJw9Bf20bmpFLWeHyZoqdWL8TX8jZKczZ2pE6krABotoKHevESc6wzTBOzl
	OAwYrON/e3Pl7RsZxRn/C14fZyu4VRBSt3xnJLQHdwXsh88S9DC5l9GiZmPVa8hA
	eT3Vm7Xv/6RxHAs66hv7XBakFwk2uRVloSq8Bl9hzR6PEnOgqphhTOHN2EUHNvJq
	MqXXrISTRFOLQnXj5HCjf2dsYwA1yuMoVHaaoTwJGFlGxGn9AsLUQL4zxmYGCj/X
	DkfS9JacTTbaF9b8B28tcXEN5zSj37ztLWzdNQWA+CbGZVik/3TZUBGHipETto+C
	bV2gbQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjcv7gcyg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 08 Sep 2026 07:45:44 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38f283baf1fso5129194a91.3
        for <iommu@lists.linux.dev>; Tue, 08 Sep 2026 00:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788853544; x=1789458344; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vjCdleB62PQ5+3oSfJm6THWjJHXQHO2Cei/sEBlVgJo=;
        b=WJM5rSeB5u+XZD9BdHHLGL/4/qyDS2SBsebrdpzm9H2LNGons+NzK91vwht8Cl1zMn
         ZuATkreCBldYZmqgYMYPrL8kN+C2hbSu2EBXnsq+xMXoQhFfhHQlqHP6ffNQzCjbwu1B
         twlG3PG16iCpvIBngv0RcgMsAk6MKc0KYw5ECCw5ULQZj8pQCpf7Rsrmwps8sDRmjp/f
         4nIxteOotDEH6GUNNd7RGjwOX99hfrSta49LJYwAWLh2+Jm0jA0PR7ec/8Ok7Gr96xbk
         rjzyPDv5D8F00DyJxiHZqr3R92IYZhz2ZypHkkvU9aPRAOkZSxa5p3lBVpOii82qT9JX
         J5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788853544; x=1789458344;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vjCdleB62PQ5+3oSfJm6THWjJHXQHO2Cei/sEBlVgJo=;
        b=jLN6W9/Mk3k50Af1a5bbInEFutQPiBeffjzDtGfZ4yQwQ6aeC5GvvvExr5KkfLCBsr
         RK9pFiu751bWnRO+UhrNhbVR21joUiBCsUe9X8N1jGBn4MarE0gBBMOxLQO1EfkKE9fk
         X7vBQqxNfrHfX/BSFP//yzS0KnMsSL3ImBfr7s3TGNI+q1y2oxQty/nUm4ibr9ZfQg2Z
         /NCoL/GemzmaWTaQ98war3BZ3AfDzEndXqvn7yP7xlLflvM/7o2X9zvIdTTeN+XJAjSv
         yZREBgFry11RuAEjuhadluulCjDTbP1CrpWKjLzD5PD4YqBMGXPyaDiQxRiGP6umQIYa
         w95g==
X-Forwarded-Encrypted: i=1; AKwUvBzQiWRt3Xf0SSIprgCiqlqgoqAaRIxf9vmF951SpjUftGPNAHtW1n6JLjpsZl0TkK462yS0oA==@lists.linux.dev
X-Gm-Message-State: AFuF++lwI6Q2WG/Yt0GjkL+1sNO1yaNfvyWyd91N4GO+AQNSk/eeuvlF
	XlA+AkhLcLA1pS1Jj8OvpUJ7ksJOq7SWaDEek5NpLjBPM4rGWlPiY2O3lU5yqWswksG59rv/QR0
	i2eeN+dHyuhwyRNDHwiakYf1Qh50qwxy3nSjLgH6kxfOj9bv6Okmk1m3u7Q==
X-Gm-Gg: AYBFou0tu+hfaPGt1ddmGaCvFQPwAcd4v98ov8AEGJxVFLlRCznVxESDh87LpRxMzrm
	w0BlJqGAkh49r7KO6LLs5R76mpUp5bIEh7d0POcpFkHYOCIFM1gAHqFMDwdznass1wOb+ptCdTr
	l5tb07bxIDAGXVKoRJ7IwpZcu9YTjq13QqB+Wng2ncg8+p1dssGFmQTzKnlMiT6Dj0jZO8jrCW0
	xOrq4x+wZXtwJZGryTYZGuc6UPVRpFUkXQniSywRcA21tVFGZNGT2lCuG/mNT5EdfXK8U6jmygc
	wUfnqi4vD17fw91q+Ypc5aKSp+3RTNEVRPge3Nl8rzh9aU/yjsQBlKD2xGkrXhMx7LomC48VTS6
	SvTNWS4is60dfhXRhZLhtrqvKuZrE9w==
X-Received: by 2002:a17:90b:1e03:b0:398:b17b:3bd2 with SMTP id 98e67ed59e1d1-39b260dda6emr38832030a91.4.1788853543416;
        Tue, 08 Sep 2026 00:45:43 -0700 (PDT)
X-Received: by 2002:a17:90b:1e03:b0:398:b17b:3bd2 with SMTP id 98e67ed59e1d1-39b260dda6emr38831975a91.4.1788853542891;
        Tue, 08 Sep 2026 00:45:42 -0700 (PDT)
Received: from [10.219.57.226] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-336c2571039sm14719241eec.25.2026.09.08.00.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 00:45:42 -0700 (PDT)
Message-ID: <a3b73723-9522-40da-806a-643093b1b227@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 13:15:32 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/15] accel/qda: Add initial QDA DRM accelerator
 driver
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>,
        srinivas.kandagatla@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-3-69a02e9090d4@oss.qualcomm.com>
 <81708487-89ce-4cd5-b39a-2989bdce6088@kernel.org>
 <3476b5c3-7983-4994-a901-3d7d8bd75255@oss.qualcomm.com>
 <4ef74e14-8433-4619-ac97-62868c8799d1@kernel.org>
 <g5orcvzjbwww27vwcsxl3ehrek6lvznxptd7jutifoiuicjnm6@iqq2pus6omsl>
 <a642833b-f22a-4bea-8a20-0debc47e1895@kernel.org>
 <4xcyqqrqbvgxojfcmnpwbi2uqk5tvhts52l6sxetltcgb7mo75@lfsgfoq4npz3>
 <59aa182d-1b4c-4bdc-a1d5-e76cc9c88ed9@kernel.org>
 <c806d7c5-98f8-4b0b-9d00-969e1917a8e4@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <c806d7c5-98f8-4b0b-9d00-969e1917a8e4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CMEamxrD c=1 sm=1 tr=0 ts=6a9fbd28 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=wP88gyHQT0P6k6tIFBAA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA3OCBTYWx0ZWRfXyOKOQm6PZB44
 LJ3yzYG17nQGoeXo/wJ5hRCg1HjSaBnIt3Ql08MTs0OAE1qG/XSNbI6UKJRQHwXWTqrqme+FNOZ
 BcqQLxy7dprpJCc8GNRxZxVnp0kIfM8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA3OCBTYWx0ZWRfX2TAQuXw3DoSS
 tNlz2ZK2CHr2ackwRNMqdRdmAJiN/F62tdytIrM5rRiarZS1/TaTW8Q4qDpMBZ+pIgUZ703lf7d
 HKjr+7wiEqA+gj/FAROMhPrhi335XoKiaD4BXrR32ET9rKPwKF40EJbNdVPochBquDrqKnJpLFS
 2BF83HYXLaCqgUSLHMpOUx61kTA5OHERUyrnJy17oYjXOn4d8KE+8m0fCmsQXWfsmhT9uSObQbo
 QUuRzAc7AEWYJSdo1n5RvT4DC5QTlk497p35zpDkEdvuABUw0dG0lUfAz6f3Vz329oOubgLOns1
 iNJxyJk2WQ6+8S3Z3Yjcl4M3DAzKyudlA0kM4LGyc5JI7V1aEjSgy3o8txxlLGErPjQ/IHiUVnY
 OIgI/Kxi3Q0woKzCIZ4c6Gbj47gaR4RG/aTH+4FOWPim3XmixqW7BAb20LR7iAx3lmuBDPzp6Sb
 s1KnT7t+MxCHaIcX4+g==
X-Proofpoint-ORIG-GUID: 7Gh3TFhvQf-Odl2ahNvz_qW1qWuTtVS0
X-Proofpoint-GUID: 7Gh3TFhvQf-Odl2ahNvz_qW1qWuTtVS0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080078

On 31-08-2026 20:28, Ekansh Gupta wrote:
> On 20-08-2026 19:01, Krzysztof Kozlowski wrote:
>> On 20/08/2026 12:07, Dmitry Baryshkov wrote:
>>> On Thu, Aug 20, 2026 at 11:07:45AM +0200, Krzysztof Kozlowski wrote:
>>>>>>>>
>>>>>>>> Device node with this compatible is already populated, so this looks
>>>>>>>> simply wrong or you are adding a duplicated driver.
>>>>>>>>
>>>>>>>> That's a no-go, you are supposed to work with existing drivers and grow
>>>>>>>> them.
>>>>>>> I'll bring the discussion again here, there was a discussion to move the
>>>>>>> driver to accel subsystem if we want to support new features/uAPI
>>>>>>> changes. Please read [1],[2] threads. The intention is to replace
>>>>>>> fastrpc driver with QDA eventually.
>>>>>>
>>>>>> None of them address the problem. You want to grow fastrpc into user of
>>>>>> dmabuf? So you move it from misc to here.
>>>>>
>>>>> It's not as easy and nice, so I think in this case it's better to repeat
>>>>
>>>> I disagree. The existing fastrpc driver is not that complicated. It's
>>>> actually moderate amount of code, much less than Venus was (~7 times less).
>>>>
>>>> It easily can grow to support two interfaces and the only difficulty is
>>>> how to manage these two interfaces simultaneously or exclusively, e.g.
>>>> opening first one disables the second.
>>>
>>> I see the point here.
>>>
>>> Would it be acceptable if we add QDA support only on the new platforms
>>> (e.g. via the SoC-specific compat), provide QDA for those platforms,
>>> and, once it reaches complete API and feature parity, we remove the old
>>> fastrpc driver, migrati old platforms.
>>
>> The problem with this approach is that we have no guarantees that it
>> will reach feature parity in respect of old interface, thus old driver
>> might stay forever. If we agree for duplicated driver, contributors have
>> no incentives to support old approach.
> That's a fair concern. Let me lay out the sequence we have in mind and
> then the concrete reasons parity is not optional for us.
> 
> The plan is staged. QDA is enabled first on new platforms, where there
> is no existing userspace to migrate and the new UAPI can be exercised
> properly. In parallel we close the remaining feature gaps against
> fastrpc. Once parity is reached we migrate the older platforms onto QDA
> and remove drivers/misc/fastrpc.c. The end state is one driver, not two.
> 
> On why parity will actually happen: the DSP firmware is not changing.
> Both drivers implement the same base protocol against the same firmware
> image, so the feature set is defined by that firmware interface, not by
> what we feel like implementing. For QDA to support a feature at all it
> has to implement the same protocol operations fastrpc already does.
> Parity is a property of the interface rather than of contributor enthusiasm.
> 
> Other than the base protocol, there are some features(daemons,
> capability, session sharing) that exist in fastrpc for performance etc.
> but are not yet part of QDA. We want to implement them properly rather
> than port them across as they stand.
> 
> The remaining question is how fastrpc can actually be removed once
> parity exists, without breaking existing userspace. That needs a
> compatibility path, and it is a deliverable we are committed to rather
> than an afterthought. For that, we need to settle is whether that path
> is a userspace shim in the library, an in-kernel translation layer
> exposing the legacy device nodes, or a hybrid. We evaluated an in-kernel
> shim during v1 and hit constraints around constructing per-client
> drm_file contexts from outside the DRM core, so the approach is still
> open. I'll come back with a concrete proposal, and it will land before
> fastrpc is removed rather than after.
> 
>>
>> Much better is to refine the old driver, gradually adding new features
>> while maintaining old stuff. This is the only way we can force
>> contributors to actively work on minimizing duplicate parts.
>>
> I believe you are suggesting we bring the new features we are developing
> with DRM core utilities into the fastrpc driver. I don't think the two
> interfaces can share one driver, though, and it isn't a question of code
> size.
> 
> fastrpc is a miscdevice: it accepts raw DMA-BUF fds as arguments and
> tracks buffers in its own per-file lists, with the fd itself being the
> buffer identity visible to the DSP. QDA is a drm_driver whose buffers
> are GEM objects in a per-drm_file handle namespace, with PRIME used for
> import and the GEM handle being the identity. These are two different
> buffer ownership models, and neither can be expressed on the other's
> file type.
> 
> Supporting both from one driver therefore means carrying both models
> simultaneously: two IOCTL surfaces, two buffer lifetimes, two teardown
> paths, and a memory manager that has to serve both. That is two drivers
> sharing a directory rather than one driver with two interfaces, and I
> think it would be harder to review, and harder to eventually untangle,
> than a separate driver with a stated removal plan.
> 
> There is also a positive reason for being in the accel subsystem rather
> than misc. We can build on existing DRM infrastructure instead of
> reimplementing it: GEM for buffer management, the device and file
> lifecycle, and the debug infrastructure. It also positions us for work
> we have planned around scheduling, drm_gpuvm, etc. Over time this should
> mean less driver-specific code, not more.
> 
> I'll restructure the cover letter so the staged rollout, the
> compatibility path and the eventual removal of drivers/misc/fastrpc.c
> are stated properly.
> 
> If after this you still want to add or change anything, please let me know.
> 
> Thanks,
> Ekansh> Best regards,

Gentle ping on this thread. Wanted to check if there's any update on the
compatible string and coexistence question above, since it's currently
blocking respin.

Thanks,
Ekansh

>> Krzysztof
> 

