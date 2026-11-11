Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794381022;
	b=pp+6WsqHdaz5pydXLabrKbBCFvFdnCnHSv8gK9JheycNSXqDInc2CunNpkaiNNPZogu3
	 VAwO6llIMy8tKGkBqo6kFnBDCUTfXH8abWzlrrFhMyOYmVwQwbZTEESHIAHtgwRhBNkFW
	 KySCXZQPo7e1od8k5ULBywWSyA4ErjhmeFIX0u/WN0jsGVlSmZwYR2NHiBL8D6lChM5lv
	 ymdHII7fIML3g7TQn3eC0nzLF+7Mp9SrXfTaj+4FY+W3FzTtU9DYKpdS2YS0DOS6EAUyj
	 cb7niizg2ZX0ya7yUffIfN6rC0WtAub7493YYsH8ZlH4IwmUSDbKsLEZ1lZP+VuO9MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794381022;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:X-Google-Original-From:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=W3qNx39FMf1BOTjwvebsKoIWWMVE5mBaCfEA196G0ts=;
	b=Kvs3zvcmX8GdF/HIkbVIsgrxbYG721HWpGFiewdNmXYmwmgvrIJGaszQMloU9UEVYWno
	 lXhSVy4IGgSV8wtdZKItO/fhRWeUtjAoEIjBZGyt/q+AamCjW+xdIrngexcBT3LUkgB0A
	 2/Se5fXMi/FFnMO1L5gjm4UK7sxr3oeQn1bV1PzCta5sOqgAkscNn/Vait5EhY/24KMJO
	 sina+/AAZ7wHKT9200pnlubOdSxU61M+83ZRrx+/auz14pr0yHDrvGsIkmsAB/mIKFMeA
	 YY9lmTZ5c1+mtH5wzWPm8iP0SxQ56fUmkl5TnKOs5u52CS17TZHIkbVT71k2hFVplPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oFND5jF5;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=W+kIPcM3;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4159B606A326
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 07:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4159B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oFND5jF5;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=W+kIPcM3
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5KfC9300688
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 07:10:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W3qNx39FMf1BOTjwvebsKoIWWMVE5mBaCfEA196G0ts=; b=oFND5jF5muk5SSG6
	x9JOIMx9x232dA6O2ATNkn6sWV0UodJv1+B2e7BRi/puHKK8AUR3TCKzZSGtSHU8
	9svUKvzTsi+LNIBpG9WUmauSZVAz3i+BsmJrYHCyEeM/hFW/FH6qgJ3hgeWL35Yv
	uEftjHP0oJPJe+MDww6tHw6iOIcKMTigexvq2AeX4u1fK6vZzGdfnQcYXYTePa2I
	4Q0VtRd+Bvs+LivjFQxX5QASU/L4lovBjKv13Z4D++PI7GQCuH3Ajy6p4jxbeOD8
	i8JlOF6Y5oHK1md08FgF+fpfAeasxFiVwtIyzC3O9rDt6zLdXM/3HCe5kkA7ymTg
	ak0HgQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv7c5k013-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 07:10:20 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36f479b9819so5042329eec.1
        for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 23:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794381019; x=1794985819; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W3qNx39FMf1BOTjwvebsKoIWWMVE5mBaCfEA196G0ts=;
        b=W+kIPcM3ZJv2sLEJBvCtJxoIo+TvCdU4mHXE7lzc2VGhuF25iiYUFblUQJu/gdIVXl
         VYdaHk/jTBiEQnlcrIuhjqwwXzGXJ0EOVGuRQXT71oPVmcQk0qjjNc1IPqfsyK/wcwVW
         yUDbsNNHtNAcyrlGBMuL6zTCI0QG4CW2mAvbBEM1El7TlTkePEjwe92nmqC6tThjdIC2
         EuwozumrIVWXNLsGflqnuQXLSI87Hrs06YvrAmhWdvRpuXGnoI+186jG+wOPc5tyc9JH
         iIX2HMf752LUDlWeg04I3/6ba3KUiPXjq2ca5VQiOq7i2NwnrZlfm/8t19MmzBLubDWl
         554g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794381019; x=1794985819;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=W3qNx39FMf1BOTjwvebsKoIWWMVE5mBaCfEA196G0ts=;
        b=b/Glt7A/SaTuP8aNtkND55f9Y4UjqnO3ktvE3eASYzQ60IUHeOHG5MumqVX1GmfDO4
         rh5vp85D/k6Xfo3gAlvDZ+rl68mdTM2RikV0+oINt1WmAXWBWHVpOp+/RtnxDNpxWska
         dx35y1SuWP2S2eaFp+JZtBEq9GUzrK3Tjy1bQYl04Ax8mPuiE6N55Wdkm508qN2CAE/T
         TKJnuD63oE1yfY33NaTPCG1N+inUk9A9iqUecyPy6bIivflMh4+J2gMPV2clgKYGQSfQ
         +hVmX4c+om2WvQrDSQ9y9xiyxeXr9wfTt6aQY3MRHDBFY6qgToJR0vxSRlFhu/IujPQC
         4a1A==
X-Gm-Message-State: APuU4Z8JT4+yf4Je9FuApIE9W6qRWpXbDbN5TcVA9RPVv7RNuTlqsLzW
	u1GeVwU2onZ2f/kBLq1pUNtvRnlSyLbWCDggSJNbWET7Ee/yUIBeUL1Rm9ga/YDuOQ7rktAaIO7
	LnVg8JiMypMXjTeCS8ddXsFIwW61uiP7KPauCPUHYyXXUssHOt80CLBQTfA==
X-Gm-Gg: AYBFou3LKfhyphJuMGfHnA2wzudlU2EgKTak6YLGafW1WnrZPUEkdgt6yKFdomRWxxU
	7k/48mqKmKFfQuPNaVK7CfieP7ScRTALTqqQZhg595bhymsyNWnF8CWPkofhxgyxkpqhZ4R5x9h
	DXnpGgXYMKuV66adznnArTpVaZ+SbePNRxwzqFG8z65dPmK+qhk+rX9V1JsZ8Q/Ob+kWPTo3YKk
	rzfoEbSUskwWe4T4CBvi5+TnTu9WCW48KlNAXoQEqV4j3BuveotScANYRqehUvRhuEIcgTPATtH
	4gTRy6d/SwcoCKUOLGLY8BThJ1SMT+yEPD23guDwX1iz8gS4TZh0dxej1R6OMk+bq2J91JGiwi3
	YCqvNbaLY5O7m9cQL9A0k9fyzUlllGufuQRuB/FRGtRYSYCXsyfdFnfAkRFf8Ibnpnlqmt9So1U
	6AgmqXvLE=
X-Received: by 2002:a05:693c:62c3:b0:36a:1e9e:ae61 with SMTP id 5a478bee46e88-37687119518mr1917664eec.38.1794381018897;
        Tue, 10 Nov 2026 23:10:18 -0800 (PST)
X-Received: by 2002:a05:693c:62c3:b0:36a:1e9e:ae61 with SMTP id 5a478bee46e88-37687119518mr1917632eec.38.1794381018145;
        Tue, 10 Nov 2026 23:10:18 -0800 (PST)
Received: from [10.204.79.28] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060899asm12686718eec.11.2026.11.10.23.10.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 23:10:17 -0800 (PST)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Google-Original-From: Jayant Shekhar <jshekhar.shekhar@oss.qualcomm.com>
Message-ID: <2fb9fd90-fac5-4a9e-ac7e-5dde689d8b80@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 12:40:05 +0530
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
To: "Rob Herring (Arm)" <robh@kernel.org>,
        Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: iommu@lists.linux.dev, Abhinav Kumar <abhinav.kumar@linux.dev>,
        Simona Vetter <simona@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>,
        devicetree@vger.kernel.org, Rob Clark <robin.clark@oss.qualcomm.com>,
        linaro-mm-sig@lists.linaro.org, virtualization@lists.linux.dev,
        Jason Wang <jasowangio@gmail.com>, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, linux-media@vger.kernel.org,
        Mahadevan P <mahap@oss.qualcomm.com>, freedreno@lists.freedesktop.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Flemin Jose <flemin.jose@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        dri-devel@lists.freedesktop.org, Abel Vesa <abelvesa@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Will Deacon <will@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Philipp Stanner <phasta@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Konrad Dybcio <konradybcio@kernel.org>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-1-7cf014efdee1@oss.qualcomm.com>
 <179304379330.2965544.11793708430519844335.robh@kernel.org>
Content-Language: en-US
In-Reply-To: <179304379330.2965544.11793708430519844335.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAyOCBTYWx0ZWRfX47fi1HRXKlXr
 wxtg5AYXzZIYCsfDbyvbYK8gmARzqc/W5BVUHfsMqjXHetgYw4wOgNKIeHM/PRFEv2wGgKvgKoi
 s0/0og1O1wrpll8HhC9sao0CxXBWXBBWTJQ0Am8HAltapAk8kFu0CRUPR8rS2UEj1GDL/1VkFIc
 ZBhkJsL6Xl3EG6xd2AynxxRqSRamTyJEwblwBElJuxJtSoPZCTI6qfGGO6V02vIBH5uyTBzt8nF
 tbvM9GOSAl3seV+wvxUTlvGGzdDW+Ja6SPzuzExRbA8irU2JOnI4C0tnAi6l4WSVS++93D2+S43
 wdzIy1g9d1XWQ+D3/LqCQ28Vyof6DN7ygTgbeUTbzTldAEs8ogyFGoKKx/Nhh2V2Uz4DOhqwQTr
 gV/kqejTI/7cmyiyyAsAvxpLOHYQYNssywyX30qGIyZ8xg/VZC9oL5orR1uOknXGuBGMUHTHamQ
 RXmRgV1O4zemCeDPH8A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAyOCBTYWx0ZWRfX9+VLSPwPPFw+
 zbnTw/HbYv2bomTlfIMkibGDOyxFzb3272vq0aCof/O4RTKzkoFEkfXEw918Mk8X2DEhNGgSTG2
 tYpXWlbPWRfVx42qcIKVkXOL19Iph6U=
X-Proofpoint-ORIG-GUID: WCuyT7giNZhb8AUjG2QIeaNls-JdzQlX
X-Authority-Analysis: v=2.4 cv=eq9KXYpX c=1 sm=1 tr=0 ts=6af414dc cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9TjDuG0S92mpM2z4UZQA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: WCuyT7giNZhb8AUjG2QIeaNls-JdzQlX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110028


On 27-10-2026 01:14, Rob Herring (Arm) wrote:
> On Mon, 26 Oct 2026 11:51:11 +0530, Jayant Shekhar wrote:
>> DCP platforms place the display pipeline under firmware control, so Linux
>> cannot discover display resources through direct register access. The DRM
>> driver therefore needs device-tree descriptions of the Qualcomm transport
>> wrapper, display topology, IOMMU contexts, and panel connections.
>>
>> Add bindings for the Qualcomm DCP transport wrapper and VirtIO display
>> subsystem. Document the IPCC power-notify resources, transport and
>> framebuffer IOMMU contexts, firmware-visible IOVA range, INTF graph, and
>> DSI panel connections. The wrapper creates a standard VirtIO-MMIO child
>> after the IPCC power-notify sequence has completed.
>>
>> Assisted-by: LLM
>> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
>> ---
>>   .../bindings/display/msm/qcom,dcp-dsi.yaml         |  79 ++++++++++++
>>   .../devicetree/bindings/display/msm/qcom,dcp.yaml  | 123 +++++++++++++++++++
>>   .../bindings/virtio/qcom,dcp-virtio.yaml           | 132 +++++++++++++++++++++
>>   3 files changed, 334 insertions(+)
>>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/virtio/qcom,dcp-virtio.yaml: iommu-ranges: multiple incompatible types: uint32-array
> /usr/local/lib/python3.13/dist-packages/dtschema/schemas/iommu/iommu.yaml: iommu-ranges: multiple incompatible types: uint32-matrix
> Could not decode node virtio@9be8000 property iommu-ranges with value b'\x00\x00\x00\x00\x84\x00\x00\x00\x00\x00\x00\x00\x04\x00\x00\x00'
>
> Traceback (most recent call last):
>    File "/usr/local/bin/dt-validate", line 8, in <module>
>      sys.exit(main())
>               ~~~~^^
>    File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb_validate.py", line 443, in main
>      dtb_diagnostics = sg.check_dtb(filename)
>    File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb_validate.py", line 331, in check_dtb
>      dt = self.validator.decode_dtb(f.read(), decode_errors)
>    File "/usr/local/lib/python3.13/dist-packages/dtschema/validator.py", line 631, in decode_dtb
>      return [dtschema.dtb.fdt_unflatten(self, dtb)]
>              ~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^
>    File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb.py", line 591, in fdt_unflatten
>      dt = fdt_scan_node(validator, fdt, '/', offset)
>    File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb.py", line 320, in fdt_scan_node
>      node = fdt_scan_node(validator, fdt, nodename, offset)
>    File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb.py", line 320, in fdt_scan_node
>      node = fdt_scan_node(validator, fdt, nodename, offset)
>    File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb.py", line 312, in fdt_scan_node
>      node_dict = node_props(validator, fdt, nodename, offset)
>    File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb.py", line 258, in node_props
>      props_dict[p.name] = prop_value(validator, nodename, p)
>                           ~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^
>    File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb.py", line 185, in prop_value
>      if len(p) / type_format[fmt].size >= min_dim:
>                  ~~~~~~~~~~~^^^^^
> KeyError: 'uint32-array'
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.kernel.org/project/devicetree/patch/20261026-jshekhar-dcp-hlos-v2-1-7cf014efdee1@oss.qualcomm.com
>
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.


There is a dependent patch which adds iommu-ranges, I had tried with 
that locally and it passes.


