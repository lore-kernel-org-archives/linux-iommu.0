Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CC83218BA
	for <iommu@lists.linux.dev>; Mon,  2 Mar 2026 09:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772442778; cv=none; b=DQX17gz+I64D02t8JntxiWsTrU2iAWaTs7Ufwt04FtkrvWTuTxU5Qjg5YFKipgHpNtYLP7KTqptOGIia2Q6F084IzcLf6WsGW3lEjPw2jG48f9yyAdJOp49zZel0hEx9AdnzjffpMUDx5Y9bKj4Q2iWE8ajZdxyQ2s6KRC2dCc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772442778; c=relaxed/simple;
	bh=upR9qprZzNZKObkJyZBXoQ2flW1n8CMNghZ1KRkdicA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fJ4EuBBxJn9LH/v8EDctLvQ2PRhK6njwabyUc8SyBJkJI6zHR4O0i8QrpO442vD0WIyvK3sfPHYlMZygNkLh+/aPG2yED1EJxsR7W9EVrNLJz3d0cJ/HXkgiBkNPx8pBjr0ZIAV/c3lXpQ4ZL9tmyC7oBXvwXinHpxl/uQIJ4MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fzf41Olr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I1EHlRc8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fzf41Olr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I1EHlRc8"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62294ZfN3753075
	for <iommu@lists.linux.dev>; Mon, 2 Mar 2026 09:12:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RUKup/XfO3qrGbQJzWHbBXV03Pa7ritqjhXq2ej50ho=; b=fzf41OlrSKkpQ6wi
	cPQXO5M+H1/gKBOaYXUE9BMMfcSeGx6uEDuGZwsV6Lq/my7EBWG7XVuLcNdZVZOB
	tSNDpjP9FtPPM6iRJHZNHDS+OOflGy+z5cH3tFGhNqlwtxYdGJW5wbNWdZTgWQOk
	V1kdZnXxUtPv83ZpKQnB8FeCY9+wu6Mxz4I2dyAN6IX6diuuKNaFkAlazxJdsoaw
	gYzC3Kk1n4VHbhHDUmxRT4knmV/BOZd0Lbb80uMjPOqswfxyFGS+h51ftHuBN74E
	QHtVo1SnCm+zRdOYV2YUkcg2ExftgfTOXynvwoGd2evfkuzDo09ACqGAovNTqVLA
	fk8GnA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn7kq81cm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 02 Mar 2026 09:12:56 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2adb1bdf778so43662465ad.3
        for <iommu@lists.linux.dev>; Mon, 02 Mar 2026 01:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772442776; x=1773047576; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RUKup/XfO3qrGbQJzWHbBXV03Pa7ritqjhXq2ej50ho=;
        b=I1EHlRc8Y6EYAEkw7hF1Ag0pgTfDjDgBwA5N/lssr26ZDYrDZx5YmQ86iD19Pt/6l3
         eVVNP8BWoQxg6w3frxdQ4OmnfEV1arCynaM3vB+HfbkaJsMv8r/yRbzppAbzJRmiKjil
         t84aAvPNoxPBiqMFiw+gVdAacPq4oJaKcmBMvb4+4UQ1z34LV2sLyrtsbs4ZUHGSNTv7
         QU2O2Al7c01auCTAZc+Bq8ZcewLB5sCflvsfmWZP5OtgYvzcoYLfvNWZHbvwJrWZvlYm
         pOvLrd2EUbo3HyzE7LcvwYAbDsE+yFDGHbAos1OsFFZOlcpsNAs7DQkfzIoqyVWIeLHW
         WC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772442776; x=1773047576;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RUKup/XfO3qrGbQJzWHbBXV03Pa7ritqjhXq2ej50ho=;
        b=XvKAkv1tPH9fq/tlcZYrYRh/MFyUAoHfENPOdMvBkN6I/rFBTHUvVb2EAWqbyOGZUu
         bP6R7MN0x27Lm9XskCdzTr93h3Jk+IrumCkSOVMbf84+K4gJKsCKSzb0eNwN1/gozpRS
         GoDXQ0bohrCTvl0Xiz2MA5Pk4wPd4Nxx0f1Fc6L+MOvx3A8Pz2oGU1mMqZTKF6F3NCnA
         qRP/MLKVCmGYUR1EmJMqY9ck5gqGAbKpmBtjdMTxY68lAnsbsh8W2HzoNZMMMfSZ/wwx
         rAL96aOREz3SJ6g1MWo8TrREq4md3n7oMMdnufbatLZwighZlgHVSAHnrsOwVA7D6mnw
         fvRA==
X-Forwarded-Encrypted: i=1; AJvYcCVanrt4PZ5XDPbgTrJPVSZ6hh6TjUrLAPMMyr6+fVZ1uQ8mhwjTFgjoCxftZsKcs3NL2JZrMA==@lists.linux.dev
X-Gm-Message-State: AOJu0YypvLHp43UROfy5rKY1K2VvE/fm2UA3lQwozSW+7/j/CkCVo4aL
	ZRC9GjSSjDyIUdoervOOV8uaLmtTB8cRiDyL7BZH4P3rn4TbVfIBkdHIe+OYyvSxzFKi57/p0aC
	1+QbdsFkRcmqH9XfEx3jQRHoww6GSiStppo4ni5rlGEt77skipgTk6s892Q==
X-Gm-Gg: ATEYQzxyCY2kD6y1QYDR+PkfOQ6FgvWy7HfiWVlkDYI7GxzTrx8By1WrG/XphQGeDOG
	6ucxoNPkYBSndPu505Z6HAhH7S5zDrpzn4hQzfuf7fFbC+k8+1TW9WuMdfDFOoBydwzoCd9L+95
	vq8bOdUV9zhdmfAwvG3K8WfUXyYGW8RYNoEp/pXbD7L0tUdLHfl6F5+aMoGS+Zlu7nbAgipC/pE
	NyWMjRdJtGSFd/LfgyJ7iklKW0Khp7mclqGAxAABYLFeVgQsckMa13a4uqHXZpTIax95XHP1+s+
	4eBM3t5uAFl5TMD0aCTCMhthXrZbEbW73Cz0VWooOm9kKR+t5FKLzD1E2f7UnMW9827CJgQxwL9
	RJ/QmKFwO1ZjJ7ZU/KAFyl7Z7dI6tpkhoqW6QToRG2AtVXIcoSQ==
X-Received: by 2002:a17:902:d58b:b0:2ae:5655:b16 with SMTP id d9443c01a7336-2ae56551006mr12820445ad.21.1772442776082;
        Mon, 02 Mar 2026 01:12:56 -0800 (PST)
X-Received: by 2002:a17:902:d58b:b0:2ae:5655:b16 with SMTP id d9443c01a7336-2ae56551006mr12820065ad.21.1772442775550;
        Mon, 02 Mar 2026 01:12:55 -0800 (PST)
Received: from [10.206.99.28] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5b0691sm178825005ad.11.2026.03.02.01.12.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 01:12:54 -0800 (PST)
Message-ID: <4abcb402-8d57-4bd3-ab8f-3a96c11b3410@oss.qualcomm.com>
Date: Mon, 2 Mar 2026 14:42:47 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 16/18] accel/qda: Add FastRPC-based DSP memory mapping
 support
To: Krzysztof Kozlowski <krzk@kernel.org>, Oded Gabbay <ogabbay@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
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
 <20260224-qda-firstpost-v1-16-fe46a9c1a046@oss.qualcomm.com>
 <fd7a2ac7-796a-4cdb-a55f-91e42f08109c@kernel.org>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <fd7a2ac7-796a-4cdb-a55f-91e42f08109c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: WDj-IgZZ44hGoXR_BunI7xeMfHvw7628
X-Proofpoint-GUID: WDj-IgZZ44hGoXR_BunI7xeMfHvw7628
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA3OCBTYWx0ZWRfX1AnBBXw7B4Z7
 IzwjOzNVYAygyFMFpBNn+S2+H+041nhlcwG8jtMvYLCaQeBPDObpnmiK1pY1Y14EmRtysCWea2g
 UOl39FJC/U2akMThzIm6hfhaWafB4h6JaGTlTgYx7wQBuzuNkRoapuFAhC5V+sbgRevxjFXIx4/
 zQWzVETzBIDiBf/wHJ7NFafiG8ZQHsZwLAP/5dgP2oaXlx+Z8wAtNU1hAkckpx8TPVvMe7Oi+eN
 OFyNqubqXmWN1j0ugNxZ0O/VgOKfaAIegm3v2svSu2j7l41U8I9U15Mt5ApRCElE1m2xhLJ94k4
 gDWXxcLFcYsqZg4/zwYyWMuPAXQzYgB+3LJz3Cx6ojlty6Zgfq5D/kc3OgiwTxSyzaRzi/OAF3g
 PjAmNOGcuO36k/IO0vVUn9ETbT51MYxRVE5D1Ld9cBASVyHAQTw1VebXwN4iL+qooCKlvkgrM0f
 VbpLnKzjNcrT6FAIbFw==
X-Authority-Analysis: v=2.4 cv=GLkF0+NK c=1 sm=1 tr=0 ts=69a55498 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=A3mkvOHymaTnmgbQ1zAA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020078



On 2/26/2026 4:18 PM, Krzysztof Kozlowski wrote:
> On 23/02/2026 20:09, Ekansh Gupta wrote:
>> Add a DRM_QDA_MAP ioctl and supporting FastRPC plumbing to map GEM
>> backed buffers into the DSP virtual address space. The new
>> qda_mem_map UAPI structure allows userspace to request legacy MMAP
>> style mappings or handle-based MEM_MAP mappings with attributes, and
>> encodes flags, offsets and optional virtual address hints that are
>> forwarded to the DSP.
>>
>> On the FastRPC side new method identifiers FASTRPC_RMID_INIT_MMAP
>> and FASTRPC_RMID_INIT_MEM_MAP are introduced together with message
>> structures for map requests and responses. The fastrpc_prepare_args
>> path is extended to build the appropriate request headers, serialize
>> the physical page information derived from a GEM object into a
>> fastrpc_phy_page array and pack the arguments into the shared message
>> buffer used by the existing invoke infrastructure.
>>
>> The qda_ioctl_mmap() handler dispatches mapping requests based on the
>> qda_mem_map request type, reusing the generic fastrpc_invoke()
>> machinery and the RPMsg transport to communicate with the DSP. This
>> provides the foundation for explicit buffer mapping into the DSP
>> address space for subsequent FastRPC calls, aligned with the
>> traditional FastRPC user space model.
>>
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ---
>>  arch/arm64/configs/defconfig    |   2 +
> Not relevan there. Don't stuff other subsystem code into your patches.
> Especially without any reasons (your commit msg must explain WHY you are
> doing things).
Please ignore this, it's a mistake pulled from my local test branch. I'm not going to add any
defconfig changes as part of this patch series.

Thanks for pointing this out.
>
>>  drivers/accel/qda/qda_drv.c     |   1 +
>>  drivers/accel/qda/qda_fastrpc.c | 217 ++++++++++++++++++++++++++++++++++++++++
>>  drivers/accel/qda/qda_fastrpc.h |  64 ++++++++++++
>>  drivers/accel/qda/qda_ioctl.c   |  24 +++++
>>  drivers/accel/qda/qda_ioctl.h   |  13 +++
>>  include/uapi/drm/qda_accel.h    |  44 +++++++-
>>  7 files changed, 364 insertions(+), 1 deletion(-)
>>
>
>
> Best regards,
> Krzysztof

