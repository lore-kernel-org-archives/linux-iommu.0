Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380950;
	b=rSP5itsK2Kv8T3dNCwKlDSTa7lFpGD4HVVxUStOeu/1Vz6gVmgEBSkigsY6Ty7qYJmtc
	 9Ifq4eWD2DvM6JhAOkxTd23Dg/5nOHK7qjcntRiSjlT3bRygVCbOtmjKyPX271Jt54CuV
	 RXHhMVlLfIh0Cjv4sIoDInXr3xrhAZ1aUAPkfrdi/fmzDviPNPTyET8Qdlh5ATbeh1ymM
	 IKEr7scMT2Mj8pI1C6LUUGmPuC1dr2F9wwzzR7/bEACw463bVR52GJaju3aoNY9tSliAr
	 e5UHWC4Wno6mk1ikelVOh2Xahcmh+YlNfEgSOl9YAxTKCoPggN9qd0RMzvk8lnds7/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380950;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 X-Google-Original-From:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=s/82GkzE7PHKNj6s9ShBADW7lI6WOmMaHbdsdqp4TVY=;
	b=uArISb4HKSXiazEi27Y4z5Woa81orre/Kc1VLf2w+JqNDtaDdmi1XAt67U0B/7YR5/SJ
	 EBfVWlicQtYIBDxkNiYhSfvMZm0twv6kpZp96vUk5zxop/rOQWSqJe5JKUFEDMdveSnj/
	 lsv5TnyK6RfCm2H0+uK7tvF1VHBkU/trxhHQINQf9hOJOVi2nfNiAJhthDKY4LafsQIXI
	 G3Ih9YBLo49MyvEj+LV/+tr+bNHIVok3dfvz8552iCkEHQwvGHnclGVE9lf9AVe97O7OP
	 nLkYguRVEbPmBmXL/5kOnnIfaKEsSCAn3shS4BKsnH9+aJs0YwTz5/R2cPugj/Eu7Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pmOSOsj7;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Nehr3bZI;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDC1606A33F
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 07:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FDC1606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pmOSOsj7;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Nehr3bZI
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5KKEE1343642
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 07:09:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s/82GkzE7PHKNj6s9ShBADW7lI6WOmMaHbdsdqp4TVY=; b=pmOSOsj7K6IfGedP
	+V6IGVv+HoLqM/OgRGFYuznEmEb/8HNzn6XegptDT0wJTTrZAQPRiA0B6f7drvLp
	7De1hWUi8gSJrt7S6FiuK6yy5c7G5E7hv6PKiC/GVde20CKmV1xQryGV+CXN35ff
	5wUm64cVX/hxSifWV2qs5zpPbVoUEPamf+fnjCjRf5AzellPL9XIGQuXJNHpTGSs
	mnnbEReH327BT0dddowTjWHGmKmdI+GY17qkGE2m1ySvmzgoGiyb+fwNoMol6rA4
	h2X22GFldDYbo7PcnezuXxSalvhs0hinQcJ8PWuD8MbKndK0leI36gGnQrVsyTnI
	ZPVatA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huyufvtks-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 07:09:08 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso5773851eec.1
        for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 23:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794380948; x=1794985748; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=s/82GkzE7PHKNj6s9ShBADW7lI6WOmMaHbdsdqp4TVY=;
        b=Nehr3bZIhPDlMaKuglRegeF5RRY6tu+KL0Gcuxl4kPl5apmA9TXtsxfBgtPSlQfWOV
         VVpJg6ye3fBP4qIpRFmd874w/YG/EEGB3XjUZ1ESinhiZx8GQozM9hPhj70/AnLEGjlq
         1kMZ0Yw9s0ECn1ATK5DoByqqGu8eo+JpccDfgxDKacWmqDILmSeHJpO1PTJqUcudQyR6
         dXsBJ6ytgMbfPciY2gjy02PDE8O+T9RCsArD9jvHWRZiQtbgCAqTEUrwVoVyftRsC6fD
         pO91IZ4seKoPiK+1EXpsASAldemV0Rds4mHCyj4C0WeqGX5WwhHHkjM6n0qXp306tG5/
         27ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380948; x=1794985748;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=s/82GkzE7PHKNj6s9ShBADW7lI6WOmMaHbdsdqp4TVY=;
        b=AqlmFy6Uxr9KCusJdDO8Qj2ZI0JjNzYdfvVZfCe3wULYwPtoh7jLxp9l7kwuqleN79
         zPZfTBDHZfC4w9WVMHAX/feK6fhnHQpmQls6TyRMpSnk1GEHpGTIRv3NaHJYhi1kavH1
         7qeaLC0dUApW4qjIB099+E/JVmcxevp7bJHSUMf/xs32t4EvkICcrgpLf+3FKGtwjCn5
         UUrwbnGIJpFmQugqyXssDpB6641HcWAKWjkesdxxBj5mV2uqXLJnk0t67dUVu4oPd8X1
         mX6VUwMVg1HZYZ8XyXDmprIoBgb7cTK4a41miykN3jZfDjAG1giEOgxynYvOsD1ARILZ
         21Tw==
X-Forwarded-Encrypted: i=1; AL+hErHkYdP2dXJmFRScTjFXx3zdLFE7oQSgGFxNmbwtfzoPI/uiElxyJJmHWUmYx22lkohS5NsfIQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+9UelcuS43f1v536nzP3hf4u/YNcPGcDXIjxszWy4LBtzQGxMf
	u0t8ayLFPmlo0u5MXoaOgmwrfyQphJOEG7grvcOqOBVY/l23vNvOFRG3SIlue/QdUMCC+ucJNCk
	IJ9Kf09rwYl/VFHlV7NaZ9deNxKkgmZ5tU2EOnrcAd8U87rt5KylDT1vh4g==
X-Gm-Gg: AYBFou2anZDjpVDGku1khCiMiNEkw8xBZO9f757r3BJGnWAN1T3W1kstnrfdVB9e6H/
	2u+R16pGvlq03aOpYvSck1D+PGT0qm0h3n/vVomREcrV1IwK8rZ0addBf2RPvz+vGeqkevrgXdF
	BD9YzHRQ0VTV+e4mLoHB4vYu4p7Qfy1t0ctYryow9gWvl+/9p1ZZy119JFJ/KEZ6jAFdDQRvhN8
	XMFs+F7318p4A3StQyzSdV0nV4bgKQucfLHQPT1G5zHVmzuKHlXesDC9sLBEv+uJuXC8BkeKagm
	yRpmi/5f5SIcFi6StcjtYTnkHQ8poAgtK18v52zQo+mVQ4p75ff8vkCioefpaXW2wd6WAAwXhXg
	gN75T+wMKsFz80JIxWUO/4mCESpBDew/ssQe9/GZV4g77c2H31u05hQXjTOChcpvY7XxSKKm3Vl
	dw6PlCgaU=
X-Received: by 2002:a05:7301:715:b0:36d:2b02:86a6 with SMTP id 5a478bee46e88-37682f9422amr2074395eec.4.1794380947849;
        Tue, 10 Nov 2026 23:09:07 -0800 (PST)
X-Received: by 2002:a05:7301:715:b0:36d:2b02:86a6 with SMTP id 5a478bee46e88-37682f9422amr2074340eec.4.1794380946993;
        Tue, 10 Nov 2026 23:09:06 -0800 (PST)
Received: from [10.204.79.28] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060dc0csm15082997eec.14.2026.11.10.23.08.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 23:09:06 -0800 (PST)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Google-Original-From: Jayant Shekhar <jshekhar.shekhar@oss.qualcomm.com>
Message-ID: <0bf2075b-e507-4b81-a563-f7b4e7e2cbc1@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 12:38:54 +0530
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
Content-Language: en-US
In-Reply-To: <fzchmbho74ii6d2zhzni4qy4g74hiwv4fwf5xudrqdrstt6klm@7wdoo4acr6fm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 1Pptm2lm_Gt7t5spzkJZMOuglh3vpzQA
X-Authority-Analysis: v=2.4 cv=S6lMU4sP c=1 sm=1 tr=0 ts=6af41494 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=qf_9Rdqh597-Gd7SKGkA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: 1Pptm2lm_Gt7t5spzkJZMOuglh3vpzQA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAyOCBTYWx0ZWRfX6gi0WwHZz94P
 DPr+OcI6oaqG0pI7vh4ebFkwz6va+UH6Ha25WTBn2MV5iNqrrhg2soVDF3iP6kEX3B7oLIFk1sU
 LAq4OQDry0sOqF3Ab1Qwx+cmAOxyttA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAyOCBTYWx0ZWRfX2eqW5KnMcaph
 CYe/6Fp8YkdRfT51wZIYkGp2hXTw7q24+tdoK1XH3929V2ifDmfDoVURTthbm0nafRsA+fkXBwz
 enNGS0b/czkc24ZBcnTKuD+MROzMzQlo4GwpyTbFHQ8qQawQqt3lvRUhih9UjPOycUo38ukrYNS
 S6YBOdhVTXF+StYJ9uwuTrD/+RO50IBdcDD68VxwEbySJsVZYk5Xg4ikk9T3n/O9i+l62HBbO5n
 ntdyKu3aZvCLtEaM9SogkQGkGnm0B1DZbUOUlUgR65+F303mlmKsU5yt9+pHg4ogWj3ZrlJWR6p
 j/ZjCIhd1c5NrBj+tA+Bb/wyT12AqEUel8G91heTWYEGed8qzE5dNUbGotyyl7oZj4MQcO8ExF2
 gYk9Up/mdHE46RN7IFeILHEnUk0F2PGMMXDgY+A6pumAnMX0NW2yOLBcR3dVaehTEzWsdHTGD7H
 urZu59ygkMi/h4E2nJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110028


On 26-10-2026 15:27, Dmitry Baryshkov wrote:
> On Mon, Oct 26, 2026 at 11:51:11AM +0530, Jayant Shekhar wrote:
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
>> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,dcp-dsi.yaml b/Documentation/devicetree/bindings/display/msm/qcom,dcp-dsi.yaml
>> new file mode 100644
>> index 000000000000..9a0acaf00bb3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/msm/qcom,dcp-dsi.yaml
>> @@ -0,0 +1,79 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/display/msm/qcom,dcp-dsi.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm DCP DSI host
>> +
>> +maintainers:
>> +  - Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
>> +
>> +description: |
>> +  A MIPI DSI host exposed by the Qualcomm DCP VirtIO device (see
>> +  qcom,dcp.yaml). It follows the generic DSI controller binding, with panel
>> +  devices described as child nodes. The DCP INTF graph endpoint connects
>> +  directly to the panel; the DSI host node is not a graph endpoint. The host
>> +  node uses the dsi@N naming convention, and its reg property identifies the
>> +  DSI host index.
>> +
>> +allOf:
>> +  - $ref: /schemas/display/dsi-controller.yaml#
> If there are no separate compatibles, can this be folded into the main
> DCP schema?
>

This will be addressed in v3.

>> +
>> +properties:
>> +  reg:
>> +    maxItems: 1
>> +    description: DSI host index matching the DCP output port.
>> +
>> +required:
>> +  - reg
>> +  - "#address-cells"
>> +  - "#size-cells"
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +
>> +    dcp-subsystem {
>> +        compatible = "virtio,device34";
>> +        iommus = <&apps_smmu 0x400 0x2>;
>> +
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        ports {
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +
>> +            port@0 {
>> +                reg = <0>;
>> +                dcp_intf0_out: endpoint {
>> +                    remote-endpoint = <&panel_dcp_in>;
>> +                };
>> +            };
>> +        };
>> +
>> +        dsi@0 {
>> +            reg = <0>;
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
> Yes, fold it there. It's not a separate device on its own.
>
>> +
>> +            panel@0 {
>> +                compatible = "novatek,nt37801";
>> +                reg = <0>;
>> +
>> +                vddio-supply = <&vreg_l12b_1p8>;
>> +                vci-supply = <&vreg_l13b_3p0>;
>> +                vdd-supply = <&display_panel_vdd>;
>> +                reset-gpios = <&tlmm 210 GPIO_ACTIVE_LOW>;
>> +
>> +                port {
>> +                    panel_dcp_in: endpoint {
>> +                        remote-endpoint = <&dcp_intf0_out>;
>> +                    };
>> +                };
>> +            };
>> +        };
>> +    };
>> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,dcp.yaml b/Documentation/devicetree/bindings/display/msm/qcom,dcp.yaml
>> new file mode 100644
>> index 000000000000..96f6c2a17e9e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/msm/qcom,dcp.yaml
>> @@ -0,0 +1,123 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/display/msm/qcom,dcp.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Display Co-Processor (DCP)
>> +
>> +maintainers:
>> +  - Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
>> +
>> +description: |
>> +  The Display Co-Processor (DCP) is a firmware-owned display subsystem.
>> +  Linux communicates with DCP over HFI through VirtIO and does not access
>> +  display hardware registers directly.
>> +
>> +  This node describes the externally connected display graph between DCP
>> +  INTF outputs and attached DSI panels. It is assigned to the VirtIO device
>> +  by the Qualcomm transport driver and is not independently enumerated.
>> +  Firmware capabilities and internal resources, including pipes, mixers,
>> +  CRTCs, and clocks, are discovered at runtime.
>> +
>> +allOf:
>> +  - $ref: /schemas/virtio/virtio-device.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: virtio,device34
>> +
>> +  iommus:
>> +    maxItems: 1
>> +    description:
>> +      SMMU context used by DCP firmware to access GEM framebuffers. This
>> +      is separate from the HFI transport context specified by the
>> +      iommus property on the parent DCP transport node.
>> +      The child context is used for framebuffer DMA performed by DCP
>> +      firmware, while the parent context is used for VirtIO transport and HFI
>> +      queue buffers. These contexts represent distinct firmware-visible DMA
>> +      address spaces and must not be used interchangeably.
>> +
>> +  "#address-cells":
>> +    const: 1
>> +
>> +  "#size-cells":
>> +    const: 0
>> +
>> +  ports:
>> +    $ref: /schemas/graph.yaml#/properties/ports
>> +    description: |
>> +      DPU INTF output-only ports. The port number matches the firmware INTF
>> +      index. The corresponding DSI host is the child node whose reg value
>> +      matches the port number; the graph endpoint itself connects directly to
>> +      the attached panel. Unused INTF ports are omitted.
>> +    unevaluatedProperties: false
>> +    patternProperties:
>> +      "^port@[0-9a-f]+$":
>> +        $ref: /schemas/graph.yaml#/$defs/port-base
>> +        unevaluatedProperties: false
>> +        properties:
>> +          endpoint:
>> +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
>> +            unevaluatedProperties: false
>> +            required:
>> +              - remote-endpoint
>> +
>> +patternProperties:
>> +  "^dsi@[0-9a-f]+$":
>> +    $ref: qcom,dcp-dsi.yaml#
> When adding DP support, would you add more devices at the same level? If
> so, we risk getting a warning about multiple devices using the same
> address.
>

Is it good to model each firmware INTF as a single interface@N node 
carrying the INTF reg, with the protocol-specific DSI or DP description 
nested beneath it?
The driver can then obtain the INTF index from the common parent, 
avoiding duplicate addresses across protocol types.


>> +required:
>> +  - compatible
>> +  - iommus
>> +  - "#address-cells"
>> +  - "#size-cells"
>> +  - ports
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +
>> +    dcp-subsystem {
>> +        compatible = "virtio,device34";
>> +        iommus = <&apps_smmu 0x400 0x2>;
>> +
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        ports {
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +
>> +            port@0 {
>> +                reg = <0>;
>> +                dcp_intf0_out: endpoint {
>> +                    remote-endpoint = <&panel_dcp_in>;
>> +                };
>> +            };
>> +        };
>> +
>> +        dsi@0 {
>> +            reg = <0>;
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +
>> +            panel@0 {
>> +                compatible = "novatek,nt37801";
>> +                reg = <0>;
>> +
>> +                vddio-supply = <&vreg_l12b_1p8>;
>> +                vci-supply = <&vreg_l13b_3p0>;
>> +                vdd-supply = <&display_panel_vdd>;
>> +                reset-gpios = <&tlmm 210 GPIO_ACTIVE_LOW>;
>> +
>> +                port {
>> +                    panel_dcp_in: endpoint {
>> +                        remote-endpoint = <&dcp_intf0_out>;
>> +                    };
>> +                };
>> +            };
>> +        };
>> +    };
>> diff --git a/Documentation/devicetree/bindings/virtio/qcom,dcp-virtio.yaml b/Documentation/devicetree/bindings/virtio/qcom,dcp-virtio.yaml
>> new file mode 100644
>> index 000000000000..6020e848ce25
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/virtio/qcom,dcp-virtio.yaml
>> @@ -0,0 +1,132 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/virtio/qcom,dcp-virtio.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm DCP VirtIO transport
>> +
>> +maintainers:
>> +  - Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
>> +
>> +description: |
>> +  Qualcomm DCP VirtIO transport. The IPCC power-notify channel and
>> +  associated interrupts are required before the transport can access its
>> +  MMIO registers. This is a Qualcomm-specific transport and must not use the
>> +  generic virtio-mmio driver. The DCP VirtIO function is described as a child
>> +  node and is assigned to the registered VirtIO device by this transport.
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,dcp-virtio
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts-extended:
>> +    minItems: 2
>> +    maxItems: 2
>> +    description: The VirtIO-MMIO and DCP power-notify interrupts, in that order.
>> +
>> +  iommus:
>> +    maxItems: 1
>> +
>> +  iommu-ranges:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    description: |
>> +      The firmware-visible IOVA range, specified as a four-cell tuple
>> +      containing a 64-bit IOVA base followed by a 64-bit range size.
>> +    items:
>> +      - description: IOVA base, high cell
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +      - description: IOVA base, low cell
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +      - description: IOVA range size, high cell
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +      - description: IOVA range size, low cell
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +  dma-coherent: true
>> +
>> +  mboxes:
>> +    maxItems: 1
>> +
>> +  mbox-names:
>> +    const: dcp-power-tx
>> +
>> +  dcp-subsystem:
> 'dcp' is not a generic name. If you want to list it here, it should be
> something like 'display-subsystem' or 'display-controller'.
>

To be addressed in v3.


Thanks

Jayant


>> +    $ref: ../display/msm/qcom,dcp.yaml#
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts-extended
>> +  - iommus
>> +  - iommu-ranges
>> +  - dma-coherent
>> +  - mboxes
>> +  - mbox-names
>> +  - dcp-subsystem
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    #include <dt-bindings/mailbox/qcom-ipcc.h>
>> +
>> +    virtio@9be8000 {
>> +        compatible = "qcom,dcp-virtio";
>> +        reg = <0x09be8000 0x1000>;
>> +        interrupts-extended = <&intc GIC_ESPI 956 IRQ_TYPE_LEVEL_HIGH>,
>> +                              <&ipcc 13 5 IRQ_TYPE_EDGE_RISING>;
>> +        iommus = <&apps_smmu 0x15a3 0x0>;
>> +        iommu-ranges = <0x0 0x84000000 0x0 0x04000000>;
> This doesn't match the address / size cells.
>
>> +        dma-coherent;
>> +        mboxes = <&ipcc 13 5>;
>> +        mbox-names = "dcp-power-tx";
>> +
>> +        dcp-subsystem {
>> +            compatible = "virtio,device34";
>> +            iommus = <&apps_smmu 0x400 0x2>;
>> +
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +
>> +            ports {
>> +                #address-cells = <1>;
>> +                #size-cells = <0>;
>> +
>> +                port@0 {
>> +                    reg = <0>;
>> +                    dcp_intf0_out: endpoint {
>> +                        remote-endpoint = <&panel_dcp_in>;
>> +                    };
>> +                };
>> +            };
>> +
>> +            dsi@0 {
>> +                reg = <0>;
>> +                #address-cells = <1>;
>> +                #size-cells = <0>;
>> +
>> +                panel@0 {
>> +                    compatible = "novatek,nt37801";
>> +                    reg = <0>;
>> +
>> +                    vddio-supply = <&vreg_l12b_1p8>;
>> +                    vci-supply = <&vreg_l13b_3p0>;
>> +                    vdd-supply = <&display_panel_vdd>;
>> +                    reset-gpios = <&tlmm 210 GPIO_ACTIVE_LOW>;
>> +
>> +                    port {
>> +                        panel_dcp_in: endpoint {
>> +                            remote-endpoint = <&dcp_intf0_out>;
>> +                        };
>> +                    };
>> +                };
>> +            };
>> +        };
>> +    };
>>
>> -- 
>> 2.43.0
>>
