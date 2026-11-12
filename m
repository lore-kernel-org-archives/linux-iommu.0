Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794476890;
	b=WodYGTYUwGn5Y4qmWjENDggpcRWf4U5NEwylQcQFE11rsxq8YAvoPXl3BLgVLdxfjEzH
	 vlWLiK10FbJxMw+H2AIX5/YgCqNmTI9zrfD1PE4HccCOVcbk1tXbRiXOQraPWGy67Pj6L
	 evszpK2ww/5rY5gKVbtBxPIqaIunxi5zTwLjzF/2pPaOvstRwr6Vp1+ZhPw4FXB5zw0cX
	 vrNbJ06EI+y0V6Nqobj6t0I7uFCWz6SPb5C6C0gk724+adqTdfG/My4lycZPUPKul3TAD
	 X0RXQvbYcH1Co+abGrRd6iD80LQ2bX7HyVvZlpss5VYnCYkxfuPssMKV6ykUeQrFCVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794476890;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 X-Google-Original-From:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=rQ0S0zFJsG83541wAchvZ00WuoVJfA2hSRmQg4ozNH0=;
	b=yOz6xHDtJOEQlN7Cl/In2+7BFlV5OjxHdkPLGJHfMJota+x+QjAfVWiL88je8XcjLiLP
	 JTRCFfrDToV9gyv5UzUGBNFjOBJ8hUD0yi3CLEWQy3G0ihEE+vkx93zALtNtO3d1Jdu5l
	 k8IfGDSiCYZ6OQtGkir0AGkPk8lIK6/maCU8wu7ySkCxe+o+UdFrQeTevQk2yICpTBj+G
	 RXuCSUl9k5odpbh1fDgOjYHOBkRW/vhthiPxaro90B9hJdqE8LLculERRceyMYKrb/GIw
	 ZuC5mfQjVuee5pXSggT8oWl51Jizxos/XPFku+P8yruozejg/cIM1i6uyf9GHyDwKYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lEYzziPz;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=g1GVq4hp;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D55606A330
	for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 09:48:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83D55606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lEYzziPz;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=g1GVq4hp
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC5nhJQ441763
	for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 09:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rQ0S0zFJsG83541wAchvZ00WuoVJfA2hSRmQg4ozNH0=; b=lEYzziPz3E3wXE1N
	/r8Q21KLI0GSOoZbw37IOQi+XRe64yyHxO4KJMKXyD6wHBr3+uN2A2DqG1aZFVCb
	td0orAtjRp1dC4j/KyPqG5d96q5y7vKMm2BKTOKsdt1dlyUwp24z+1cEnebHmiba
	lsmQibx194c8rA9m2TXh3aOD9i7AI6KxyLK00WTHqjhvlhD4uAN/bB+W+ouD9DVf
	YFu1UNcSm+Up02WumBc+r6ikblrY5kMlzpu37riEDvTPfzmaBSpLyb+pCef3TTpE
	LJnjDCjjnF+Cz0U9C2aBPvT6jwMkRiiKlKn3l4dQXbHdnu8pkdbQTpnhKR5UBEBO
	sdPQmg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw7nc0vm2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 09:48:09 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ad30487d55so7179749a91.2
        for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 01:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794476889; x=1795081689; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rQ0S0zFJsG83541wAchvZ00WuoVJfA2hSRmQg4ozNH0=;
        b=g1GVq4hpNj+LUfMCV9Lz5qYRX3uiYuuTl4+rd9E3cC69OFVyt6p7jtdQ8WnFHaNq8V
         gFLwwViLDLoVG2F4brQUDsj7SzZoUlD5oXzn1AFBNRGURnwfyX6OHqHVQIy16nJNdsEZ
         yRI15YFfcIaMLCH5fzljmQ3Qvfl09jIk1F3g1bS0o/ENZDHgNw66ewQ4gZO4elWnVfws
         oWFD8OzXIN2ilbnxaXRrdrn5HHPoIwBTpNTKEhYTyCBkpnPzhw3se9DNDe06SOMt/jmp
         LTGhpHl0/u2b7KEOMGrY6dmEHByjC7CAYjmLkGQxMKfywa72E2bJdDRjj5nAW5f1OnoJ
         a+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794476889; x=1795081689;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rQ0S0zFJsG83541wAchvZ00WuoVJfA2hSRmQg4ozNH0=;
        b=WgxwCjvPYAIEMnpdAx54HtLeTeWR55Y56xdWWapiaL/qrsoOPtMsnMEJQSkKyXx5sn
         PeiNV2XKR1qjWdVpkSjEdU3Yr23TH3lTrr204f0X89rikyLnw4bXwG09HMldHcU+rwm/
         hV13d7gfZSUqRr3k/LJReMG9qubPVidiR4W51qt83l6fiMCuBtChVk6gRylPT7yhZOw/
         fMMz8oX7tPbAfb84Q/si/ucdpS8NPGNjNOBBq2zMQlp6CxS8xfE22/1Q7CHWtPaK+OQj
         yRJu3IslynAoQnPmtp8Hc38tRvwzQPRR1uUuYpFRUHHzmfmUR726Lhy4x38kYKc2eaJF
         PJmA==
X-Forwarded-Encrypted: i=1; AL+hErGxVo3taP0jwa4nNHaMK/XGWj8/CrGeG9e4AZJsqxUcHMrQtQQwZoL9XpWk+c93eBKx0knPtg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+504zOd2+gIDVlfBjX354IqRu4GmDQjWaVEYe+djTOj/oA1z9Q
	oPQYab2PxQ9gIXHpP9ez1fK5uBsPD9C32WQIswx5ne5ubynCKcoYUuteLGFnwRKFaDV/OAZWyc6
	sGtu13rKO8fSBMpZ8sYbShbp8AWFHw1zJsAsMSH48LP9r7KBhQODeo0lcDQ==
X-Gm-Gg: AYBFou3tpXWZ55U2vphC/pl2fWf/rtXqTtXkCtlNq6R7VThrgA/tUvONT225wK7TE2j
	57niRcDkh4Fqjvpq31yZ3NavfqBRUn2DFM6XTz/d5sGzzt5JxaExrrXLrlHKL3SiBFQ1ndcx5E+
	Rfi0zw8VkTD57U+bZgZEyZEliaD+mdj70mnku7aE4R/Xg7DdblNl9V3EJC0YTb1OnB3AZVt/Om6
	kn4JAc3DE2V4f18933L6urKspHQzQ3/oAt9LNRdieqT2LdHaVgYQcnYI2krl3/pb+JWXhyuQ7aw
	F7gh6A+Y4/+WtCK2WtImgG6aw6lPVIWc9fq9J71LzV5ph+xWvRWSUW8ZxhhV+i0/zSCFDyvgHzg
	DdOsK1gcJWnRAR42WKh4EX2p4cyzfLTePCkBBTIGUfqAV/CCStZxoB0SkVJMKTjvH2S7ownpFLn
	5MaI7JSro=
X-Received: by 2002:a17:90b:5247:b0:3b0:a9de:9886 with SMTP id 98e67ed59e1d1-3b182e9457fmr5003630a91.12.1794476888799;
        Thu, 12 Nov 2026 01:48:08 -0800 (PST)
X-Received: by 2002:a17:90b:5247:b0:3b0:a9de:9886 with SMTP id 98e67ed59e1d1-3b182e9457fmr5003594a91.12.1794476888303;
        Thu, 12 Nov 2026 01:48:08 -0800 (PST)
Received: from [10.204.79.28] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d0fdbdsm3913394a91.10.2026.11.12.01.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 01:48:07 -0800 (PST)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Google-Original-From: Jayant Shekhar <jshekhar.shekhar@oss.qualcomm.com>
Message-ID: <2932200c-d930-4d5f-a308-0bde202af349@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 15:17:55 +0530
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
Subject: Re: [PATCH v2 01/23] dt-bindings: display: msm: Add Qualcomm DCP
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowangio@gmail.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Philipp Stanner <phasta@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Flemin Jose <flemin.jose@oss.qualcomm.com>,
        Mahadevan P <mahap@oss.qualcomm.com>, virtualization@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-1-7cf014efdee1@oss.qualcomm.com>
 <fzchmbho74ii6d2zhzni4qy4g74hiwv4fwf5xudrqdrstt6klm@7wdoo4acr6fm>
 <0bf2075b-e507-4b81-a563-f7b4e7e2cbc1@oss.qualcomm.com>
 <34hgm3yw4z4kbulvgpg7c2iunyui5ljn2l6fqq47prc7s6hycn@c2rnwvhcn5x6>
Content-Language: en-US
In-Reply-To: <34hgm3yw4z4kbulvgpg7c2iunyui5ljn2l6fqq47prc7s6hycn@c2rnwvhcn5x6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: k3IzqtOQveL8IuhM3r1QrHhtDZ1uS8QT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAzOCBTYWx0ZWRfX91WHj9RVY8JI
 Hp9PvrhMrsi9UP5XFrVCqXDxIR2HOoV1BNn4rqZD7yScBs2qrHCcRBdhirYbp/zHRnEQtW3WaiO
 xrSwLpUeoZjOiEFSATXrLtx4ONBnItw=
X-Proofpoint-GUID: k3IzqtOQveL8IuhM3r1QrHhtDZ1uS8QT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAzOCBTYWx0ZWRfXxwJRgOcY3ROA
 PVW0ZI9saFgroAWhW18n1S5h5C6QNmK/S7JvuPRmlupFKiqm8R2eN2EksKXGBH8MNPtXKXlh1Nt
 piEQ5yPcdP1HvT98xb+7wSyFVn9kng2tNIdSLYh4SVtLid/Lvkze9XKbZN7O1m5tfZ1ZJnWhSek
 FlrsSyQxdVsh+D30KVSI9XySzUzDRuCiraLondDIEYYnRdcAKCzuE+Ye8tyzEu0335545aQbWQV
 Hfwu7NARgDwEwxFC0UM/6T6FLMR7LPh2EP1KLv6ecuNhBczMV53/VRgr+B4uvr/SG0bNe02Ta+8
 OGHrrV7N1KUhDJZycpQleqShtAby8/xBRUj2Lgc0lp9JG58sL/uGC+6Y3GB+dU8ZGPsapA1AWzJ
 unFA1oB9LXbYHHj+goY9t6wPYj9C2soOz9scClrueHZwMgM1WTH5cB9zQbwxpUERpsB0WtcElV8
 BpYsPp31Vdv55MjYd8A==
X-Authority-Analysis: v=2.4 cv=A8b5rKWG c=1 sm=1 tr=0 ts=6af58b59 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=8VBehk7qD7xQtsfHT0kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120038


On 11-11-2026 19:43, Dmitry Baryshkov wrote:
> On Wed, Nov 11, 2026 at 12:38:54PM +0530, Jayant Shekhar wrote:
>> On 26-10-2026 15:27, Dmitry Baryshkov wrote:
>>> On Mon, Oct 26, 2026 at 11:51:11AM +0530, Jayant Shekhar wrote:
>>>> DCP platforms place the display pipeline under firmware control, so Linux
>>>> cannot discover display resources through direct register access. The DRM
>>>> driver therefore needs device-tree descriptions of the Qualcomm transport
>>>> wrapper, display topology, IOMMU contexts, and panel connections.
>>>>
>>>> Add bindings for the Qualcomm DCP transport wrapper and VirtIO display
>>>> subsystem. Document the IPCC power-notify resources, transport and
>>>> framebuffer IOMMU contexts, firmware-visible IOVA range, INTF graph, and
>>>> DSI panel connections. The wrapper creates a standard VirtIO-MMIO child
>>>> after the IPCC power-notify sequence has completed.
>>>>
>>>> Assisted-by: LLM
>>>> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
>>>> ---
>>>>    .../bindings/display/msm/qcom,dcp-dsi.yaml         |  79 ++++++++++++
>>>>    .../devicetree/bindings/display/msm/qcom,dcp.yaml  | 123 +++++++++++++++++++
>>>>    .../bindings/virtio/qcom,dcp-virtio.yaml           | 132 +++++++++++++++++++++
>>>>    3 files changed, 334 insertions(+)
>>>>
>
>
>>>> +
>>>> +patternProperties:
>>>> +  "^dsi@[0-9a-f]+$":
>>>> +    $ref: qcom,dcp-dsi.yaml#
>>> When adding DP support, would you add more devices at the same level? If
>>> so, we risk getting a warning about multiple devices using the same
>>> address.
>>>
>> Is it good to model each firmware INTF as a single interface@N node carrying
>> the INTF reg, with the protocol-specific DSI or DP description nested
>> beneath it?
>> The driver can then obtain the INTF index from the common parent, avoiding
>> duplicate addresses across protocol types.
> Yes, it might be good, but it's not what is happening here. You are
> adding dsi@0, although, I guess, INTF is 1.
>

I raised that approach before v3, but the patch still uses dsi@0 
directly. I’ll update it to use a common interface@N node keyed by the 
INTF index, with the protocol-specific DSI/DP description nested beneath it.


