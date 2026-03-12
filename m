Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0926399362
	for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 11:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773315723; cv=none; b=W70oVirZsj7SkOyEdXpT4pGBUvvabem07MReWSBMP9uCdwhTEhzBm1rEPD1GGk66RSyC+Ag0r3CHg0ky8enAqq5pg7FmlwhMZlF9FL2DubNw/iVDpNeRNexkmZm3o5v7JQs6BG/OEOtk1HEUBugNUU/5tGn61OcyKnWPr8HW1dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773315723; c=relaxed/simple;
	bh=nwaZTsNWKtiAy3M+myiu//8Q2UY2tqa7VUs/W+GtYLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DhoHT9w6eLIOm3H6nOO3hFoLWjeRM9xQKm+5vISyAs6Nxy201dVJV+D0wszM2ZHWaS6hF6iqa0Ll8O22KDxOceh0LiBsFV3hjHb5EZNyq7dM9xGT/3TClZzHie6WRlyFEPPOUg8PyLLHlTqL7X8W4asYMFoWQ50vYL8JCxpKPL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cTWDR23r; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JfkYONdF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cTWDR23r";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JfkYONdF"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C2cW781594122
	for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 11:42:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O6HJTG517rx7BZNC+Lqbxk38jHNOTKDXfitY+fGl2Qg=; b=cTWDR23rSNC6RXYv
	NYm5xAfJP6JIuBegbdJxesqHYjbPVMpbyoaplrYspybiURpA1Trs2IBBicGX/68c
	/5p+bLJWsmwM5nkoINvohPNjkwnCV2Td1WLJKuiQev/oeNlwdMwm/GB45fgFyHxJ
	HBiAKD73NnOBoytDQFweyjSwkRPfJWCUyj7pEosaMeJDL4V+7DNFEgrEfn/EASZJ
	6+Gx97SZIgZENJcFW2XKZ7T0QIf+zW3nzwfP8DgMViWz3ZckUTqhX36WvwMOPypt
	LWOJsODEoFAaVja57lITwPwa+tEi6nJkKgY1F91wyXAO/nJARSgaUFBOp4o2h3W9
	cdmcuA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cumvq9amj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 11:42:00 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2aea7747aeeso10846275ad.2
        for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 04:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773315720; x=1773920520; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O6HJTG517rx7BZNC+Lqbxk38jHNOTKDXfitY+fGl2Qg=;
        b=JfkYONdFYRBuUduUdj9K0NZAuL30AcV6mjvsJkQecImbazfyiP3VSViqL7uF2Njf7u
         Ddopm5s8yZI6uTV6eIdAdzn+FjkYSSi9s4vYqtk1gw3gPZzzOj0FalHWtZ6len5jolu8
         IVE38HHtpS+cJttbMiAU/aB+Vd0e0UFr7fwmD3F0qT4R9vUmOoMAsa5NptiBm7ANbdEd
         IxN8NKDR3qv2xUg5bIiPtxyOjLPPc27pJypSF+JqP/WXt05rXDU56aqZFfzLVGsAXhWM
         ndSp8AJ1GFnmm14O0YKlfvYahM4Mqv2xolfJnWeqqPwrcnmobpOS720erKJBM6rU5o4z
         45MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773315720; x=1773920520;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O6HJTG517rx7BZNC+Lqbxk38jHNOTKDXfitY+fGl2Qg=;
        b=hbxGxSut2uIGzQoBxIvJ2oyikdTLaiNjsT3b2+dPAAY+ZXN1NW5XH2HgcT6yjR1cFM
         aQZmJ4aGu1b8pHqbi1nzAfKvdyB7G43xEWNlhwb6zs/dG4Us7Tweb5tjMFQwpJvDW1j3
         PtEyCbG/yXHt2m5JDKUXpDUN4fSJwiRCDpOVGJMW5micNGkHVF7yHly2EzRihSEp4Y5N
         DG0vwE2DNoRdKnqdHshyQZrr4deshYLbJvyLGuf9vVq1QxHpuvmk7GAnxfKcJK2laf3p
         9bw/KIn2wN8d3VSFF+/1F+uUFVYeo4qIoZsrjHuKdZsaBLr3V+HJ/lF7nfKn1Ri4JBlo
         DdIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWr3x6UOqUsMVr3uVAyX2rwqeoX1l6JyxSE7hHCwqWy6DTBTCSKK1kbEVEV46PUbYDf3zk9SQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwdwJ3WAKixcEDCSAzktBKl/oeUNHyiIsw0abxdIx8Av09XAXd2
	iUZnAj5cLyN6ZMge6mXrtVIHjcsmy9jS7cytNdtN3ksH30TH8SryK+RxJq5/Klr5EwOXHrCgxJf
	rtkSJHLA3bklL2ClSCQgrFTG9E9z5lJpKW7H3eEjF5I5DVcuvoglqTrKx5A==
X-Gm-Gg: ATEYQzwo5vG6js/o5ETHP6Lhy/Z37ryhOZVTHuyUi1jspo3xjA9oJqL/Py3SHSBrTL3
	cFYs8q/kKEJWsj8S0pijLTh8MsQOeR7ZV6ny6UhJynUjkfzUPEq3lIAj/Gi8WO8RQqdRts19Fn2
	43IysMZzW7iXSPciw5vF22+HrqNmif+5+LtDdWytzUgbFmYXov3aZYIK96IcfY1ZNm+yV1W7yX0
	5Aw3i7H1piuLD8D73vfTTAA+zCRMQUiUBnNKNWXuzmxN0cr2YLtMUVHgzF6Hib5cGj2k81Jal84
	mlCVvzYXpz/h2zTEUIp6XCXYtE0DXCvyKVzvvpFv6s7AyMTws5GFTXhpFH5wlW5LvEOIb4Z2BTh
	xgTR08cgriKCDy9a3tAI3DS0bKx5+j2HcEnVUTwMu48swi2XeSy8fgi8MPw==
X-Received: by 2002:a17:902:e807:b0:2ae:478f:2ec with SMTP id d9443c01a7336-2aeae89119emr62683455ad.29.1773315719572;
        Thu, 12 Mar 2026 04:41:59 -0700 (PDT)
X-Received: by 2002:a17:902:e807:b0:2ae:478f:2ec with SMTP id d9443c01a7336-2aeae89119emr62683115ad.29.1773315719067;
        Thu, 12 Mar 2026 04:41:59 -0700 (PDT)
Received: from [192.168.1.10] ([38.254.186.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae22217dsm53886225ad.4.2026.03.12.04.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 04:41:58 -0700 (PDT)
Message-ID: <57537059-4989-4704-ae6a-72576d031216@oss.qualcomm.com>
Date: Thu, 12 Mar 2026 17:10:25 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/3] of: Add convenience wrappers for of_map_id()
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Nipun Gupta <nipun.gupta@amd.com>,
        Nikhil Agarwal
 <nikhil.agarwal@amd.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas
 <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Prakash Gupta <prakash.gupta@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, imx@lists.linux.dev,
        xen-devel@lists.xenproject.org, linux-arm-msm@vger.kernel.org
References: <20260309-parse_iommu_cells-v10-0-c62fcaa5a1d8@oss.qualcomm.com>
 <20260309-parse_iommu_cells-v10-1-c62fcaa5a1d8@oss.qualcomm.com>
 <3plcdobbd6teiluzijzk33yepbpsur24tnmjr32sco7a4loptm@xmzmsaurvmvj>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <3plcdobbd6teiluzijzk33yepbpsur24tnmjr32sco7a4loptm@xmzmsaurvmvj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: QvzwZW-c8KwvrB3bYthfMnN6ZK37qIOW
X-Proofpoint-GUID: QvzwZW-c8KwvrB3bYthfMnN6ZK37qIOW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA5MiBTYWx0ZWRfX6ssuO34jZ4mo
 E9vvOQDhaaZdB2NMXTH3Hq8cRTwSC56TAgFHwJsfXb7he8kvujGSaFUFZ9u7mALE+g+6mksWcfA
 oAmBUPf/EmpWPEDwizIBqh1B3fS71LeWyNc5yI2gpKupPqCrmKKXKxJEcIZFkZILLg/+hO8Sr84
 65dcqZcoYiwMuUP4nKN4wXvsW4cyFUPRwg+bUkASuKhKISLyEAuNQ22WZFgYJOS4tptIACrUkBc
 5Ne+ulOiS9Kiczmpq1r9ByUhtmKr9D0+m6FMUvEbrXFtn9xvx5zlQxqsb3EFxFjpjQG+en05tO/
 YRquft+Z0DzAv2zS1KDccTe4K+l1t/OphEVqrKpYBUJf+6/uzUnvoAulfsOMjhMmdy8ehKiiBHZ
 Hpp5oYWLbPaW1Kp0v3WvrIyURAQy5EaBFrjpIZUET+2+d+a7PjjePZgSbLvCoX6jXFC+ohzk2Jj
 mi00VAMzMTIKJy3aD/g==
X-Authority-Analysis: v=2.4 cv=ccHfb3DM c=1 sm=1 tr=0 ts=69b2a688 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=FuYIH7Xx0xzBSkYrynBYgw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=8AirrxEcAAAA:8 a=EUspDBNiAAAA:8
 a=6wy38kV5EeFARYyu09AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120092



On 3/10/2026 2:46 AM, Dmitry Baryshkov wrote:
> On Mon, Mar 09, 2026 at 01:03:37AM +0530, Vijayanand Jitta wrote:
>> From: Robin Murphy <robin.murphy@arm.com>
>>
>> Since we now have quite a few users parsing "iommu-map" and "msi-map"
>> properties, give them some wrappers to conveniently encapsulate the
>> appropriate sets of property names. This will also make it easier to
>> then change of_map_id() to correctly account for specifier cells.
>>
>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>> Reviewed-by: Frank Li <Frank.Li@nxp.com>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
>> ---
>>  drivers/cdx/cdx_msi.c                    |  3 +--
>>  drivers/iommu/of_iommu.c                 |  4 +---
>>  drivers/irqchip/irq-gic-its-msi-parent.c |  2 +-
>>  drivers/of/base.c                        | 36 ++++++++++++++++++++++++++++++++
>>  drivers/of/irq.c                         |  3 +--
>>  drivers/pci/controller/dwc/pci-imx6.c    |  6 ++----
>>  drivers/pci/controller/pcie-apple.c      |  3 +--
>>  drivers/xen/grant-dma-ops.c              |  3 +--
>>  include/linux/of.h                       | 18 ++++++++++++++++
>>  9 files changed, 62 insertions(+), 16 deletions(-)
>>
>> +
>> +/**
>> + * of_map_msi_id - Translate an ID using "msi-map" bindings.
> 
> Which ID are we talking about wrt. MSI interrupts?
> 

id refers to the device’s requester ID (RID/BDF or platform stream ID),
not an MSI interrupt number; it is the key used in msi-map to obtain
the translated MSI device ID (id_out).

I'll update the kernel doc as below to clarify.


* @id: Requester ID of the device (e.g. PCI RID/BDF or a platform
*      stream/device ID) used as the lookup key in the msi-map table.

Thanks,
Vijay

>> + * @np: root complex device node.
>> + * @id: device ID to map.
>> + * @target: optional pointer to a target device node.
>> + * @id_out: optional pointer to receive the translated ID.
>> + *
>> + * Convenience wrapper around of_map_id() using "msi-map" and "msi-map-mask".
>> + *
>> + * Return: 0 on success or a standard error code on failure.
>> + */
>> +int of_map_msi_id(const struct device_node *np, u32 id,
>> +		  struct device_node **target, u32 *id_out)
>> +{
>> +	return of_map_id(np, id, "msi-map", "msi-map-mask", target, id_out);
>> +}
>> +EXPORT_SYMBOL_GPL(of_map_msi_id);
> 

