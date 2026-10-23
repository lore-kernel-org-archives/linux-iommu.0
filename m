Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792743242;
	b=FU/AD8wRaIpVOUXx5y+snleJZ8WmXuqtx3RDRmVg5m7GSBYt2xO957+tItCgAm93mxg3
	 RLnTSUHCufynaBxhSnH17v1ODn1wGnyHX0Hx9wF67ixjbq8BJ5iRnAcz5MYHP0BMu3yPP
	 SZp8znE4IuiE9pA9d5DoFqkFzomjS88SyLLhxL5xwJI4iyYSX2DhVhAeznl2cWYTxyL4y
	 GAi1ZM56JbEKkmPs1w9h1iXAnFrwv4uL1gz7lg+BfRhnyPgVRlbepBJglXO3DaUvGxEd2
	 1/Czah7RVkRUjZ7h+8o2CHnvzDfWZk902QeQJXbY41oc4oiJIjlOoIbU5mw3ZnldGkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743242;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 X-Google-Original-From:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=tqv4KAoTYY3S/U2JwEiFFAex7twOglJ8WJnUqUg1DcM=;
	b=ddHPjveY/jMyZ8tCE8SHTH+h1mbI2jJ21LAjgWZkz4kwWKxJKcXuBK83dKLSvPzGz30d
	 owjNrAXs9+4PDZdvA9/ipuZH4HBPkgP5hh0Q5lqHHZX3Z7ZfHYKHQTPA4J46mAD9pVZw5
	 5HJDhDGqD9f6LWI3qhzgdSEnNM4u6jAsuuZ8gPRiqsHdVI3ystxkaysaX9TTdRt4TRW1e
	 FCuUR2yGNz3TeAem7BKKy6tZFVdTMxhf7/S+pCgxn6hWyq6gJhzWeZhvWStadJa58qxOp
	 6v7d+5vDtPjX9NPNEv2ExnSRg9g6t2wOaJQJema+y0qexi+USODhK0p/T55aIBHQorA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kJQsA8Fs;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JCum0koN;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358F8606A321
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 08:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 358F8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kJQsA8Fs;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JCum0koN
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7FO4b1552889
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 08:14:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tqv4KAoTYY3S/U2JwEiFFAex7twOglJ8WJnUqUg1DcM=; b=kJQsA8FsdDYDXY6i
	a7Kj2LAxWDzNHdXqTYI8OUen0oHwtkYY49xBoELPc7nsS3cmskLKwlLSQuMI1Sfz
	PQ8/BdIr+lSMLozM6PymdpD5dU3HjuHwh4a5XIRnCtneyZgq9dsjQ5LKU9PZL3gG
	lefv5o5fY+/kjDHBCB2iMrXOQpZpJRVbfwokoURV/idtOFD0KAO6VLk0sZsUCrsU
	5tneIsou6i0pqjtKPcEW8Ajev5nljBoxbIg9OCcyzjB1wSvh7gkwUVCBr5gQ8H54
	yDjCWahkVkHcW4MKPCMPHpVtBndx3L+ZDbwKERK5HP+7uOTs/CY8sT858z7Pr4Ip
	NTGnzg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmttnfs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 08:14:01 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cd60a365440so431950a12.2
        for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 01:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792743240; x=1793348040; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tqv4KAoTYY3S/U2JwEiFFAex7twOglJ8WJnUqUg1DcM=;
        b=JCum0koNgRHtRBggYjGJm9I7lX61vMtZNZldCIZm78szmxZxgXbndosL5GpfPSQOxf
         EXCaN33w5zk7CUhQFeAV4ciS+KYOO13iZkQwWS5ZfYKboOmK4jjBJXBaN7F46Tb4oooz
         lkhkkpHDXGy3qflj8YnO5G9AH/r44Gn8nVhHvUGyzrokUgoaosZ8nNlnzRgWej+opzvD
         9ndWwKgqIJ4j/TFR4P9WLh9FZD78m3sR6u/7jPgnTkWwJtqZaWuFa9UnQiuovlzGc+Jh
         unRQvefl6rJum4PZLF0wyCXXSbENNUIUV7Lbbri5rmwD5cDS75cR6ZxUoMbmJxLihnbm
         ZPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792743240; x=1793348040;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tqv4KAoTYY3S/U2JwEiFFAex7twOglJ8WJnUqUg1DcM=;
        b=KPfVJJLqI3Bmm6a0doycvfhV8v+tTHENX9BaksP3gFB0PHzdZWbEp3rYwodX58MLZW
         djljx0OKdR/D21LDBj2S3ZWDoV/9dArQecNZGWjZplcalZheuWV5kZ+6DXVZaFBmjaiL
         FfoI3RBhlrcQG/fVJumF9q036vx/R0anru7f47IR0ikKBB2L9wbkK96/BRg03KbLXNpj
         u4MKipJmKyTGAW77pxLId1WVd9GtFpcR3iIzhkSs5gfl05MwnrqquNMniB7wnlK/ZdFz
         z9bUw0r/DspsI98WI8GryqP9bxzcZjWE95xp+UBoX7KF6YpPNjom6XkuDRqAZ0PvZHxh
         0grw==
X-Forwarded-Encrypted: i=1; AKwUvByI+cpC9ofQMrH6lLc4lh+L9Zsw97as03PBsO+UdglOlbCKHGIBL3Fn4ih3gGNYnVMaDyeUcw==@lists.linux.dev
X-Gm-Message-State: AFq9FYIbFuBPFKri5ChDX5F6oIhV/XjCwIhx/kFqqFDmAE7Dyrubj6vk
	9oSjd9sCNwEGDqk0snLjHy9ZXRFTpVIe4cG19odDUStwtZBeBY5N/wJN1mr0vxmNnP9nattPAzh
	Xj3foyVXWZGfaGWSSSyVH3ruuOP3zg3mcvoZgsQlBfloyB1D0AunQtYnvCQ==
X-Gm-Gg: AYBFou0t+nFoCGT/H7XTkJskl4gASwQ84voLfzbgzJcIS3aUKg2PsYQbJmLwU4A1BVd
	hEs5RbErXs9vKNl6svaheKz3iD24oXIexZRgS2/wPHFTt38SkbYFEnCXdXIgt5vJewEbkwvcV5C
	iJNkb7lbzWSFjiN07aD5PT5QyXr2/I+GZJHVUkhsWAyjRxQGLMECss41w8CmEiOUjY8J2gcRsxK
	Ov/H9Qm7X+2zKuSh0FRGGSB+GV0O5RRLM16Nz3zx5ANTEfvP2nDflcDq++dBgBuZXSaT53kw9L+
	0Gq8zgwP0iIZFHNLRma6oGjGZtQAkjyJi8jxnv+/olRcbd8gPzaMS8WThTTIarCNyX9vz6oO5MH
	wSSW7ig03NkMRWMC4w4lu3oKzGGq9sNrSSg==
X-Received: by 2002:a17:90a:d40b:b0:3ac:8ee5:e007 with SMTP id 98e67ed59e1d1-3adce616026mr940549a91.20.1792743240421;
        Fri, 23 Oct 2026 01:14:00 -0700 (PDT)
X-Received: by 2002:a17:90a:d40b:b0:3ac:8ee5:e007 with SMTP id 98e67ed59e1d1-3adce616026mr940524a91.20.1792743239783;
        Fri, 23 Oct 2026 01:13:59 -0700 (PDT)
Received: from [10.204.79.28] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada4954979sm7758959a91.17.2026.10.23.01.13.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 01:13:59 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Google-Original-From: Jayant Shekhar <jshekhar.shekhar@oss.qualcomm.com>
Message-ID: <4c4e48a7-5ece-4fca-9387-a50c29bbcc83@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 13:43:49 +0530
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
Subject: Re: [PATCH 09/13] drm/msm/dcp: Register DCP display pipeline
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Philipp Stanner <phasta@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev
References: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
 <20261015-jshekhar-drm-msm-dcp-v1-v1-9-48aad0fe4f72@oss.qualcomm.com>
 <b2cf0c52-4c31-4b17-b341-029b82ddbd7f@kernel.org>
Content-Language: en-US
In-Reply-To: <b2cf0c52-4c31-4b17-b341-029b82ddbd7f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Gt3XaU1C c=1 sm=1 tr=0 ts=6adb1749 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=_vtLzGX-cFUddgSYHekA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: iaDOM-GmhxYMtUNadPVjN-S2VRoQRw52
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX5CBLVeslPVTK
 R004c978tL7N1EfrgJJ3mGIYzIxDpge0qB1/lcJH0DBx/pb3qFCOtJAv7uUsrCbhBzem43dCDFu
 36yGEM/h4UFjNm3Vm8vxTmHkQ8ehgXCZrcSiKG31N7JzFYn5g0vBS5E+kq7fCsKIwGTvnS7vgVT
 vuLTJ6iaI+bcEX8LL8pUEcRgq2Ba4WPr968/y42UpOuC6jJ8I3RZiMQImMvGQEOlqI/zJV03/1L
 loSfzPY9f9LbQaabf6TUnAR5sRb9HOw5Pl/7j0NAb12nTo1rlrmabv0L7xxiRTGFHf+5Ybjx1+m
 zmIzTKWvm1Zub7fIibpxK+fE0/8PV9tNqX3Ts8mqyVK73bOQP4+9KlvuIzBiRIdmQjaE3nIBOwn
 MZSh+B54fjOAoT//r65SFiXFYj3tAAUnUR1zkCW38ywW/oL2TaXdfEb4uJGHU6/fiEW2el3FNYB
 P+6nCaLwjC5rw2Hwh5A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfXy1wxcgFHV34v
 TLiyfV6sS8NwP4ku6CUSv+K0bkJX7VQyFvw9q6Fl/AkyjgF0QW8aaQMYGaI3d4hhcNJX4XsBsrD
 h/b+C0UZED3Kui4UhnrhogtQ6sCacuU=
X-Proofpoint-ORIG-GUID: iaDOM-GmhxYMtUNadPVjN-S2VRoQRw52
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230032


On 21-10-2026 17:35, Krzysztof Kozlowski wrote:
> On 15/10/2026 09:38, Jayant Shekhar wrote:
>> The DCP firmware exposes display resources through capabilities rather than
>> through host-visible display registers. The MSM DRM backend therefore needs
>> to build its KMS objects from the firmware capabilities and device-tree
>> display graph.
>
> ...
>
>> +
>> +		remote_np = of_graph_get_remote_port_parent(ep_np);
>> +		of_node_put(ep_np);
>> +		if (!remote_np)
>> +			continue;
>> +
>> +		if (!of_device_is_available(remote_np)) {
>> +			of_node_put(remote_np);
>> +			continue;
>> +		}
>> +
>> +		if (of_node_name_prefix(remote_np, "dsi")) {
> Where did you document the ABI?
>

Will update in the bindings in v2.


Thanks

Jayant


>> +			if (dsi_idx >= ARRAY_SIZE(dpu_kms->dsi_bridge)) {
>> +				dev_err(dev->dev, "too many DSI outputs\n");
>> +				ret = -E2BIG;
>> +				goto out;
>> +			}
> Best regards,
> Krzysztof
