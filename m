Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720093822BE
	for <iommu@lists.linux.dev>; Wed,  4 Mar 2026 09:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772616827; cv=none; b=d+P5q2s/s89zT3YuKILsYkl6V5BKxZchWcJyVJJmivX6vNdyqzJoaj3WtTYI8tNhgD7dOWEecwZcWK3PMErV9QmrRZUnXasMqESuUFjjAesVcjlKJ1Ab75ldHCByrYW7Lhe+1G2wfZXxnOpHvI1rysJ1Kw7PW1SwjE8hZU0tiT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772616827; c=relaxed/simple;
	bh=UgQTgkB5UzffbHxj48UknwnHweyGmMrlnoYCea5R01M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cam5z6xY7QAp2kb7NmMsU/s0ziPCfO836QF06xIB5bWuqiZwr0Ily9nUQv+B+gfWDA14LZxiOI/Q/nROnrPSXxU26wO3zNy9v4RDfxnbCQF3MWMoRh50F+q7VQqK5rtl0yzEbo1+sUeEz6iz/9Yc4EbEdifrttuxhrjqcmwszyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jG7fGQ4v; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Awd4+t5r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jG7fGQ4v";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Awd4+t5r"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245SPg5957016
	for <iommu@lists.linux.dev>; Wed, 4 Mar 2026 09:33:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	olej/QuVyiT3XCCYbNDROqVlMJ/ZiroIS/6G24fqqXw=; b=jG7fGQ4v5uKwi+m6
	jYRS3LTZutxZaRvtn8jkQxwWB2a0rTwd5e4FuO+g0wWd5G6gGJcJF4AE1G5i+wFk
	OVKDaM+De548acZWpPzF3QrgKX7M0ybyyo9T9nH5iq1FCKDwI9itphQ7adIazLDh
	RCVUSxnyEZWmuQHAooPZDGtWaMjcWZ8Cwxhrap9wNj/tneGiKaSjMDD1SK277er9
	zx1qlz8KOShYrjRR+IbVJPOroaviNiAlxyRY0ZMUgNqTvVo0VGxfRXNQzqpcimU5
	5LEprhOHTQYA/7ocebT16KTOpnKkzt3JtoAKgir2XJgo30Zc72Ql1lf/KJbK5HwK
	TOtKHw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cp6qgaamu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 04 Mar 2026 09:33:45 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ae5031c6c5so146396545ad.3
        for <iommu@lists.linux.dev>; Wed, 04 Mar 2026 01:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772616824; x=1773221624; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=olej/QuVyiT3XCCYbNDROqVlMJ/ZiroIS/6G24fqqXw=;
        b=Awd4+t5rvGNwfh9l9MLD7a1INAxyMzUMV7wVnCb1MrA5tp3WNBu9yYd6vsQ8P8aHK6
         QImBa9UDy115ZqkGfZbSSAUWV1M3tOA0fuaXP976uK7co6r13LwvHoG1YO0oRQyEHeGb
         B6IG//m4MwCLPWsUlVXiWOFMtuZtMgdyJe++uwAYpqGUsEb/0r5c0OLXBaGk7xCU64kc
         qnBm5iz49Ky9NJGILCYN+VZnoGanQ3MMZcOJEk/eoabvdGF69RsKiYeJ01LhIkOWmoSJ
         k3aaZ2k/hnLJga/0ioZLcfmDZ0mdOCM1+wH11JXgavwmnpB2CiGTWGVeRVX1FP2dWFEA
         n7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772616824; x=1773221624;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=olej/QuVyiT3XCCYbNDROqVlMJ/ZiroIS/6G24fqqXw=;
        b=KZIIyD34gtHLAAN0P6rirsA6M0HVdIGE9JaP4knB6TLeyQcW0prpXr+crDItAsuOMi
         7wmjJ3hlWOPT/lAlimKR3o/HH1wZzLDGINs8XfvePz8sNydjAjsrKMABbfseiIiQ4APJ
         rtJl6fu4Gs2tqzmdJjiA8auyFBrEqUQNq4AahWvqNXps41RPvooTZxCzI2rgnHzEVt0m
         mvTaU7Osv5Yq9/R4sOFgCLrXSGa0bVTqyepj1MhkCjTVeN4h6NkHsL/SuoJoJ20zwh9y
         AY35lwPoeyAcP6QTK6CkHJryKtvmRM+TPRdnu68HC9dGyJ4lutpe/sWwu1ff19mlvHo8
         yn3g==
X-Forwarded-Encrypted: i=1; AJvYcCVid7+hvooJUOG182OUBRx22xepyqhVR95M4CiVI/Z5oEpq1GnyrkINHI7ldEUB68VsmGwE/A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwIUwWe96Zlgudz+GW4Kh9Yo1B0bK8nfyv+1ZttMOXpv0GqPlDp
	X4e6/bhOw4rLD4nhDcPAfTT8Yk8eZ1qFSdrgaa9OFrsiAufwsJj6P1JpiSLxei9E0mAGWAPYXSE
	gjn04L/IshntgYPYiqhppW+5fMPJvhIIoZqA25GyO1Rm/izFtIScFzQJP8A==
X-Gm-Gg: ATEYQzyKU5+e3avHZjqlQc8/+W9ojS4tCLa7IyPOqC81z9GH59JrLJsn+OaAF6lfbTR
	dFOaBXTcnKO7KvjH7KBW2BVopOVEKNM0V1Cj6PYUg7GPJ+ItxzUO+43anSiMyYpM6fpbhjyzwgm
	vHKizbn2phiGvWaSkiSxFdyhTvNCl6dug0k5ISguVi34vXnBQtDdqBchviTO9rnzdpnQs0tVEyh
	DFkIsR9anRqas5p94XXaxC0FUP25S6bkvXuwy/bWJBUAhbiRcl2IX6BOeGB/yMZhJxz3FWURH4t
	Q1z+U6NVM+iBg9vO4MF378uBm1fnM1buRXD9+08MWCOAKceUQyfVX17PdJmo++cDl7UrU2u2jF/
	AI90sVanQSnEwcuUDp5oRKg3FuojNkJkDEPKtJ8eZ7D6uFL7FxSgqbSyy
X-Received: by 2002:a17:903:3586:b0:2ae:483f:b23b with SMTP id d9443c01a7336-2ae6aaae620mr19109875ad.32.1772616824004;
        Wed, 04 Mar 2026 01:33:44 -0800 (PST)
X-Received: by 2002:a17:903:3586:b0:2ae:483f:b23b with SMTP id d9443c01a7336-2ae6aaae620mr19109655ad.32.1772616823507;
        Wed, 04 Mar 2026 01:33:43 -0800 (PST)
Received: from [10.219.57.109] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae541358d4sm76250575ad.75.2026.03.04.01.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 01:33:42 -0800 (PST)
Message-ID: <d3687764-024d-4dbc-9342-8edc9b4f1fdd@oss.qualcomm.com>
Date: Wed, 4 Mar 2026 15:02:14 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/3] of: Add convenience wrappers for of_map_id()
To: Marc Zyngier <maz@kernel.org>
Cc: Nipun Gupta <nipun.gupta@amd.com>,
        Nikhil Agarwal
 <nikhil.agarwal@amd.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Gleixner
 <tglx@kernel.org>, Rob Herring <robh@kernel.org>,
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
 <krzk+dt@kernel.org>,
        Prakash Gupta <prakash.gupta@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, imx@lists.linux.dev,
        xen-devel@lists.xenproject.org, linux-arm-msm@vger.kernel.org
References: <20260301-parse_iommu_cells-v9-0-4d1bceecc5e1@oss.qualcomm.com>
 <20260301-parse_iommu_cells-v9-1-4d1bceecc5e1@oss.qualcomm.com>
 <86342janlx.wl-maz@kernel.org>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <86342janlx.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA3MiBTYWx0ZWRfX+y8d2MjI72qk
 9rxu80CyACudC8/duXo131YsGUXZQsT1/ltc4iewy0BXnriW+BGSakC3k2yFaIGvfdPUCQkHg0A
 JfxZ64IcNC+b2w2NpNkHoFX1tuXzbhxidVVq+NGFoLlV+NPlmPYvxzBJUojtkHkOWSacXy8pCn6
 eDBwitv9CXK6hkVwsb9iTiZGO0A2JgUPG/Ehlp1sRdnoahNt6j4h87yo8+ys+ZPO4gf8PE3dCkn
 xcYSNrboHjCg3F0C4xLWyJCG9b6mIN+c4wJuyjRhCzzvs8w50zUcWP/Arj54nIzXZgNQfwwnbks
 t0Jxu9juw0JwHeytNqn8oraMc616mH2dOUUrA0y51bSF4v8TM4PTP93f2rp9cy2Hw98pidHstxg
 1Uc9SYKE+o2U6AXgKtenoM1JqkceZn7yXryYchSncT7GWMgMgr1am6aw4bUZCZUdYm+XJ8Y32Pz
 DH+sn4j16zQV9GL3Obg==
X-Authority-Analysis: v=2.4 cv=UJ3Q3Sfy c=1 sm=1 tr=0 ts=69a7fc79 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=8AirrxEcAAAA:8
 a=xEgsDuFUHT4EKXnybycA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: 8kF1WMVmwaIx2Nl6hFgNMdVH-tNU0tly
X-Proofpoint-GUID: 8kF1WMVmwaIx2Nl6hFgNMdVH-tNU0tly
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040072



On 3/1/2026 3:16 PM, Marc Zyngier wrote:
> On Sun, 01 Mar 2026 08:34:19 +0000,
> Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com> wrote:
>>
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
>>  drivers/of/irq.c                         |  3 +--
>>  drivers/pci/controller/dwc/pci-imx6.c    |  6 ++----
>>  drivers/pci/controller/pcie-apple.c      |  3 +--
>>  drivers/xen/grant-dma-ops.c              |  3 +--
>>  include/linux/of.h                       | 14 ++++++++++++++
>>  8 files changed, 22 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/cdx/cdx_msi.c b/drivers/cdx/cdx_msi.c
>> index 91b95422b263..63b3544ec997 100644
>> --- a/drivers/cdx/cdx_msi.c
>> +++ b/drivers/cdx/cdx_msi.c
>> @@ -128,8 +128,7 @@ static int cdx_msi_prepare(struct irq_domain *msi_domain,
>>  	int ret;
>>  
>>  	/* Retrieve device ID from requestor ID using parent device */
>> -	ret = of_map_id(parent->of_node, cdx_dev->msi_dev_id, "msi-map", "msi-map-mask",
>> -			NULL, &dev_id);
>> +	ret = of_map_msi_id(parent->of_node, cdx_dev->msi_dev_id, NULL, &dev_id);
>>  	if (ret) {
>>  		dev_err(dev, "of_map_id failed for MSI: %d\n", ret);
>>  		return ret;
>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>> index 6b989a62def2..a511ecf21fcd 100644
>> --- a/drivers/iommu/of_iommu.c
>> +++ b/drivers/iommu/of_iommu.c
>> @@ -48,9 +48,7 @@ static int of_iommu_configure_dev_id(struct device_node *master_np,
>>  	struct of_phandle_args iommu_spec = { .args_count = 1 };
>>  	int err;
>>  
>> -	err = of_map_id(master_np, *id, "iommu-map",
>> -			 "iommu-map-mask", &iommu_spec.np,
>> -			 iommu_spec.args);
>> +	err = of_map_iommu_id(master_np, *id, &iommu_spec.np, iommu_spec.args);
>>  	if (err)
>>  		return err;
>>  
>> diff --git a/drivers/irqchip/irq-gic-its-msi-parent.c b/drivers/irqchip/irq-gic-its-msi-parent.c
>> index d36b278ae66c..b63343a227a9 100644
>> --- a/drivers/irqchip/irq-gic-its-msi-parent.c
>> +++ b/drivers/irqchip/irq-gic-its-msi-parent.c
>> @@ -180,7 +180,7 @@ static int of_pmsi_get_msi_info(struct irq_domain *domain, struct device *dev, u
>>  
>>  	struct device_node *msi_ctrl __free(device_node) = NULL;
>>  
>> -	return of_map_id(dev->of_node, dev->id, "msi-map", "msi-map-mask", &msi_ctrl, dev_id);
>> +	return of_map_msi_id(dev->of_node, dev->id, &msi_ctrl, dev_id);
>>  }
>>  
>>  static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
>> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
>> index 6367c67732d2..e37c1b3f8736 100644
>> --- a/drivers/of/irq.c
>> +++ b/drivers/of/irq.c
>> @@ -817,8 +817,7 @@ u32 of_msi_xlate(struct device *dev, struct device_node **msi_np, u32 id_in)
>>  	 * "msi-map" or an "msi-parent" property.
>>  	 */
>>  	for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent) {
>> -		if (!of_map_id(parent_dev->of_node, id_in, "msi-map",
>> -				"msi-map-mask", msi_np, &id_out))
>> +		if (!of_map_msi_id(parent_dev->of_node, id_in, msi_np, &id_out))
>>  			break;
>>  		if (!of_check_msi_parent(parent_dev->of_node, msi_np))
>>  			break;
>> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
>> index a5b8d0b71677..bff8289f804a 100644
>> --- a/drivers/pci/controller/dwc/pci-imx6.c
>> +++ b/drivers/pci/controller/dwc/pci-imx6.c
>> @@ -1144,8 +1144,7 @@ static int imx_pcie_add_lut_by_rid(struct imx_pcie *imx_pcie, u32 rid)
>>  	u32 sid = 0;
>>  
>>  	target = NULL;
>> -	err_i = of_map_id(dev->of_node, rid, "iommu-map", "iommu-map-mask",
>> -			  &target, &sid_i);
>> +	err_i = of_map_iommu_id(dev->of_node, rid, &target, &sid_i);
>>  	if (target) {
>>  		of_node_put(target);
>>  	} else {
>> @@ -1158,8 +1157,7 @@ static int imx_pcie_add_lut_by_rid(struct imx_pcie *imx_pcie, u32 rid)
>>  	}
>>  
>>  	target = NULL;
>> -	err_m = of_map_id(dev->of_node, rid, "msi-map", "msi-map-mask",
>> -			  &target, &sid_m);
>> +	err_m = of_map_msi_id(dev->of_node, rid, &target, &sid_m);
>>  
>>  	/*
>>  	 *   err_m      target
>> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
>> index 2d92fc79f6dd..a0937b7b3c4d 100644
>> --- a/drivers/pci/controller/pcie-apple.c
>> +++ b/drivers/pci/controller/pcie-apple.c
>> @@ -764,8 +764,7 @@ static int apple_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_d
>>  	dev_dbg(&pdev->dev, "added to bus %s, index %d\n",
>>  		pci_name(pdev->bus->self), port->idx);
>>  
>> -	err = of_map_id(port->pcie->dev->of_node, rid, "iommu-map",
>> -			"iommu-map-mask", NULL, &sid);
>> +	err = of_map_iommu_id(port->pcie->dev->of_node, rid, NULL, &sid);
>>  	if (err)
>>  		return err;
>>  
>> diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
>> index c2603e700178..1b7696b2d762 100644
>> --- a/drivers/xen/grant-dma-ops.c
>> +++ b/drivers/xen/grant-dma-ops.c
>> @@ -325,8 +325,7 @@ static int xen_dt_grant_init_backend_domid(struct device *dev,
>>  		struct pci_dev *pdev = to_pci_dev(dev);
>>  		u32 rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
>>  
>> -		if (of_map_id(np, rid, "iommu-map", "iommu-map-mask", &iommu_spec.np,
>> -				iommu_spec.args)) {
>> +		if (of_map_iommu_id(np, rid, &iommu_spec.np, iommu_spec.args)) {
>>  			dev_dbg(dev, "Cannot translate ID\n");
>>  			return -ESRCH;
>>  		}
>> diff --git a/include/linux/of.h b/include/linux/of.h
>> index be6ec4916adf..824649867810 100644
>> --- a/include/linux/of.h
>> +++ b/include/linux/of.h
>> @@ -1457,6 +1457,20 @@ static inline int of_property_read_s32(const struct device_node *np,
>>  	return of_property_read_u32(np, propname, (u32*) out_value);
>>  }
>>  
>> +static inline int of_map_iommu_id(const struct device_node *np, u32 id,
>> +				  struct device_node **target, u32 *id_out)
>> +{
>> +	return of_map_id(np, id, "iommu-map", "iommu-map-mask",
>> +			 target, id_out);
>> +}
>> +
>> +static inline int of_map_msi_id(const struct device_node *np, u32 id,
>> +				struct device_node **target, u32 *id_out)
>> +{
>> +	return of_map_id(np, id, "msi-map", "msi-map-mask",
>> +			 target, id_out);
>> +}
>> +
> 
> Any particular reason why this is made inline instead of out of line
> in of/base.c? Also, some documentation would be helpful for the
> aspiring hackers dipping into this.
> 
> Other than that,
> 
> Acked-by: Marc Zyngier <maz@kernel.org>
> 
> 	M.
> 

Thanks Marc.

I made them static inline mainly because they’re just trivial wrappers
around of_map_id(), so keeping them in include/linux/of.h avoids adding
new global symbols/exports and keeps the callsites simple (similar to
the existing of_property_read_*() inline wrappers).

That said, I don’t have a strong preference—if you’d rather have
out-of-line helpers in drivers/of/base.c, I’m happy to respin accordingly.

Re Documentation, Sure I'll add comments for of_map_iommu_id() and
of_map_msi_id() in follow up patch.

Thanks,
Vijay



