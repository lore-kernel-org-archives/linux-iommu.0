Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8003A63E6
	for <iommu@lists.linux.dev>; Fri, 27 Mar 2026 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774604122; cv=none; b=YxR7T+2Xw89ntHEyfCijq1lbsaV5EKuhZ28US2p8I1IMXYQ457c0GQm/oNjY+j5tzT7ny4uePA3hwTZNg3wLoHpMhFReUKSvCkkJ5ArxeqUAO+STIXZMlStjlalB/NZdCeAP6TY7cNXy0EXwcDkU8eU84fYQZ6ZrlWeXITp+P6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774604122; c=relaxed/simple;
	bh=iJOHN8dmGPbQD80ivaf5mntVO+SR076qCtKMvmHaQFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cQMENEtbbaGw4e3fdH8Z+zItec5aS5/5Cr9iPPjTL9tqmXXIbePN9SO9+CRC13FGg9R1DkOmds1GYu2uo8nYh/VAXFNhZIz/J5NtmVtNfossxH13etO3BCtGd7/XHeUHtVH7es+u1ZRgD7KcufMGxQwwZvA6AHKTsQVd6BRBmF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dfqtedcK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GKfY/CQa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dfqtedcK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GKfY/CQa"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62R6vp36298526
	for <iommu@lists.linux.dev>; Fri, 27 Mar 2026 09:35:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iimVuL7Si0EC2QW/qRbXnzLK0ktDtNjpoesWqPPB7kk=; b=dfqtedcKdd+VWg1M
	7rr8jESz/4pyob5K2fouLMEhfpda0yOt9fk6Il6m7RWjeliiACai4e+ZB2hlrx1I
	9MgYxRv0KQ/ku0BWB2gtqXXvKiBRNyf12jRfiUQuuolYntBskTlFgAufv+olHd4U
	9+pYzSrzGS/nBGGzKPqngAx3//YA4A3M7kaA4l965KaJ1iChtAww5Rf4BioiNEed
	zzoIYSIj9ktfWv7IMm3l/NGkcKvqOL4pYOu59I2WfsLqBIG6r82rTb5Ka8Nq3b8H
	ykkyk8hGHoSagfqLpuEBqOyCW+kifxN5Cw9NttYhmJ8EX02pYG8IZakCzrf4EwZ0
	7Q/RGw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5bd8tg78-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 27 Mar 2026 09:35:19 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b0c954ff58so32486135ad.1
        for <iommu@lists.linux.dev>; Fri, 27 Mar 2026 02:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774604119; x=1775208919; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iimVuL7Si0EC2QW/qRbXnzLK0ktDtNjpoesWqPPB7kk=;
        b=GKfY/CQaa7qYzW6VgVSpi8vqEIxFWJzQ3K34CkWYwKYRy7NheK3AQxCqw6UrXX/A3e
         jNhRM5qfbmliCXpBwmjkAM+zx0mRXtmJmKKrlCCXIkMQ+lX1cRziD4lQsUZsxSFngvUS
         INWo55E74ewvWn9ol64Yjk2qdPtJ1HSFV1RPaiEU43KOv/GpR8zIMEOvvifo73QWkQe/
         Wt5P8rQMemX6Izt6pm/sqilfjLNoT0K3aFen5IAf9HxQxxkEs4cXjFnhNM3hL0RmOtN/
         sOnCCGjSBsqz9uJ8j3jtSiUYEijw6ldRY5hXG0clrT+joxYE8gAZER3HezXCu9i/AqWF
         ClBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774604119; x=1775208919;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iimVuL7Si0EC2QW/qRbXnzLK0ktDtNjpoesWqPPB7kk=;
        b=oZpW9ugSaQhc3OKZTVV1TE+mNVhbZFitjv5qb1Wx9FNYvgxuPTM5pskrNWErFmtjQo
         sHwFP5Qtlp+ASQ3CVmBVeHrjqC8GWD221e/loM6Tnqt/lwcWxNOLeC814vbiPjMqlRxs
         f0hDWKspsddDVmkOBWOHowLuK8kMrdGrrsG5yc9hTSg3MLILDyWqDxzQbKqkwgX2GKLC
         sz2+kvvA1QNRkZ/dMbvr8wYb4rdDhpIIt6ojipt4u4qQ12JSsngun/RZ+YHT8pPhXvUT
         7KlVFPjO6ovM+f+XJ2uZkYC48wwnHMQ+Z0bYWD7ZiH/W1bK5Yrc8nTTrX25inn6uin31
         kdBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaaZqzkSvM2T0RGeU1wm10oC6U9Vc3hKlkBN2CIIJSml+Mo7Ovlf38crin8TvkwzhiaFAMcQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzu5ceAPpFowbLc+8kXC4ae77jh78h1e/+6CnKWJ54tIStYhtJ5
	uK1ZsmDK0d3NlLv4wsLEErQ3noytWmUt1SbQHoYwPP4JIUTcmi1sLduYiVaP05LTS8pq6Qmvwh8
	dPgQff3ZlcgsxqXiG+RQApz1aoYZe/nxYERGWfItAdR58nMMLUzPqlXelBw==
X-Gm-Gg: ATEYQzy9woZkA7y9sicdGGz+mKxSlSQBgCwy5O508b7TjTS6ZBxvW9+LatyJhskW/TT
	EsQ+KzLwmeQLmXXukHaW1/w+kZISyrZyucp63+TqXZr2hgWR2u6CyXfFUeInMIpE+Xz7O/C0UHm
	fZfF47aynyBCozSUG21qShSmCcoRL7fJRjzegFlJMM1pIDkJZweQSuvLXO+awoqPhfwmGtFgjDY
	WgdViVf+yxOAQsX3cyFIh6Ds3oF6iEpnLZYFVq/CndEab/dXkhitzYDAHBv0QUbCmxtxXRwvmgl
	PPijnq7+kgbiAxmGGUplToDcE40DliIpUxAOO/QMy2XAF2/L/S2neHa6INQy/Cqdes5IIUv++cI
	uCG/Vw6Ep0g64dCwTTNM3L5M0g94MjhBwrUNhXLLJ3wqH7IoAggTfoUu9
X-Received: by 2002:a17:902:d502:b0:2b0:6d8b:6a07 with SMTP id d9443c01a7336-2b0cdcaa738mr20284075ad.25.1774604118576;
        Fri, 27 Mar 2026 02:35:18 -0700 (PDT)
X-Received: by 2002:a17:902:d502:b0:2b0:6d8b:6a07 with SMTP id d9443c01a7336-2b0cdcaa738mr20283585ad.25.1774604117910;
        Fri, 27 Mar 2026 02:35:17 -0700 (PDT)
Received: from [10.219.57.109] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc7a7e3bsm72543195ad.27.2026.03.27.02.35.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 02:35:17 -0700 (PDT)
Message-ID: <2c21c307-99bd-4051-8c09-06d370ad9b24@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 15:05:02 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/3] of: Factor arguments passed to of_map_id() into a
 struct
To: Bjorn Helgaas <helgaas@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>
Cc: Nipun Gupta <nipun.gupta@amd.com>,
        Nikhil Agarwal
 <nikhil.agarwal@amd.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
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
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Prakash Gupta <prakash.gupta@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, imx@lists.linux.dev,
        xen-devel@lists.xenproject.org, linux-arm-msm@vger.kernel.org,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
References: <20260326161957.GA1324845@bhelgaas>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <20260326161957.GA1324845@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDA3MCBTYWx0ZWRfX/tFHiCDeJYSd
 QjevqQitMGo3lgqnlL5i1PbRUzrHojU2Qmb6IWSQ+Jokc3pUyrkbifwMJVkn0qZNqGUAbZp9SFa
 evHMtO7nZqs5puiv1Rt4+AbzbS8/Iwae+H02fO8X8x6a6HMX6iNebSmnZ34gEIedA3oJTbh7Ulu
 GvzwJ6RqraKgdOrgVZYfSoHHAU324P0X27SmxnFvWliF2k8X9wgXJT/39ghxat3i6VfTDWCXIv6
 CmFax7XXpaghy68KDCYLnvquK2QNCoOzn+8LYyX6gXbfjSmGM7a7Lkf9QX4TB/47dnQCGfOkqdj
 uGp75nV0xYcXGVhM/GV2cZncT+P7xANHPVN1cFWGj59Odlsxkxnfw+4kFkj4W1pO6A/jMZ0ek7q
 HCvQp8KXh2YYC51EGukIrsTRsTlifxvcWxiCEON6a/4GNDiO4lZsQwJuuUPOI6HPnB0rxyGMaI+
 y9PLdD1D6vL86ObUPzg==
X-Proofpoint-ORIG-GUID: F2JLCncRjAHUN8-oWdU04uvQV6T0n-y0
X-Authority-Analysis: v=2.4 cv=BZrVE7t2 c=1 sm=1 tr=0 ts=69c64f57 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=vU6kfqNVzfA0ps7fDeEA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: F2JLCncRjAHUN8-oWdU04uvQV6T0n-y0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270070



On 3/26/2026 9:49 PM, Bjorn Helgaas wrote:
> [cc->to: Richard, Lucas for pci-imx6.c question]
> 
> On Wed, Mar 25, 2026 at 04:38:23PM +0530, Vijayanand Jitta wrote:
>> From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
>>
>> Change of_map_id() to take a pointer to struct of_phandle_args
>> instead of passing target device node and translated IDs separately.
>> Update all callers accordingly.
>>
>> Add an explicit filter_np parameter to of_map_id() and of_map_msi_id()
>> to separate the filter input from the output. Previously, the target
>> parameter served dual purpose: as an input filter (if non-NULL, only
>> match entries targeting that node) and as an output (receiving the
>> matched node with a reference held). Now filter_np is the explicit
>> input filter and arg->np is the pure output.
>>
>> Previously, of_map_id() would call of_node_put() on the matched node
>> when a filter was provided, making reference ownership inconsistent.
>> Remove this internal of_node_put() call so that of_map_id() now always
>> transfers ownership of the matched node reference to the caller via
>> arg->np. Callers are now consistently responsible for releasing this
>> reference with of_node_put(arg->np) when done.
>> ...
> 
> Not actually part of *this* patch, and AFAICS this patch is correct
> as-is, but is it necessary to have different logic around
> of_node_put() for imx_pcie_add_lut_by_rid() and
> apple_pcie_enable_device()?
> 

Thanks for the review comments. Right, there is no need to have different
logic, I will update imx_pcie_add_lut_by_rid() in v12 so that of_node_put()
would be called unconditionally.

>> +++ b/drivers/pci/controller/dwc/pci-imx6.c
>> @@ -1137,6 +1137,8 @@ static void imx_pcie_remove_lut(struct imx_pcie *imx_pcie, u16 rid)
>>  
>>  static int imx_pcie_add_lut_by_rid(struct imx_pcie *imx_pcie, u32 rid)
>>  {
>> +	struct of_phandle_args iommu_spec = {};
>> +	struct of_phandle_args msi_spec = {};
>>  	struct device *dev = imx_pcie->pci->dev;
>>  	struct device_node *target;
>>  	u32 sid_i, sid_m;
>> @@ -1144,7 +1146,12 @@ static int imx_pcie_add_lut_by_rid(struct imx_pcie *imx_pcie, u32 rid)
>>  	u32 sid = 0;
>>  
>>  	target = NULL;
>> -	err_i = of_map_iommu_id(dev->of_node, rid, &target, &sid_i);
>> +	err_i = of_map_iommu_id(dev->of_node, rid, &iommu_spec);
>> +	if (!err_i) {
>> +		target = iommu_spec.np;
>> +		sid_i = iommu_spec.args[0];
>> +	}
>> +
>>  	if (target) {
>>  		of_node_put(target);
> 
> Here it's conditional on "target" even though of_node_put() checks
> internally for non-NULL, so it would be safe without the conditional
> here.
> 

Agreed, here of_node_put can be called unconditionally , will fix it in v12. 

>>  	} else {
>> @@ -1156,8 +1163,11 @@ static int imx_pcie_add_lut_by_rid(struct imx_pcie *imx_pcie, u32 rid)
>>  		err_i = -EINVAL;
>>  	}
>>  
>> -	target = NULL;
>> -	err_m = of_map_msi_id(dev->of_node, rid, &target, &sid_m);
>> +	err_m = of_map_msi_id(dev->of_node, rid, NULL, &msi_spec);
>> +	if (!err_m) {
>> +		target = msi_spec.np;
>> +		sid_m = msi_spec.args[0];
>> +	}
>>  
>>  	/*
>>  	 *   err_m      target
> 
> And here (outside the diff context) we also call of_node_put()
> conditionally:
> 
>   ...
>   else if (target)
>     of_node_put(target);
> 

Agreed, same as above.

>> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
>> index a0937b7b3c4d..c2cffc0659f4 100644
>> --- a/drivers/pci/controller/pcie-apple.c
>> +++ b/drivers/pci/controller/pcie-apple.c
>> @@ -755,6 +755,7 @@ static int apple_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_d
>>  {
>>  	u32 sid, rid = pci_dev_id(pdev);
>>  	struct apple_pcie_port *port;
>> +	struct of_phandle_args iommu_spec = {};
>>  	int idx, err;
>>  
>>  	port = apple_pcie_get_port(pdev);
>> @@ -764,10 +765,12 @@ static int apple_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_d
>>  	dev_dbg(&pdev->dev, "added to bus %s, index %d\n",
>>  		pci_name(pdev->bus->self), port->idx);
>>  
>> -	err = of_map_iommu_id(port->pcie->dev->of_node, rid, NULL, &sid);
>> +	err = of_map_iommu_id(port->pcie->dev->of_node, rid, &iommu_spec);
>>  	if (err)
>>  		return err;
>>  
>> +	of_node_put(iommu_spec.np);
> 
> Here we call of_node_put() unconditionally.
> 
> I think it would be much nicer if imx_pcie_add_lut_by_rid() used the
> same style as apple_pcie_enable_device() and did the of_node_put()
> unconditionally.  That would untangle the function a bit and make it
> easier to analyze.
> 

Sure, as mentioned above will align imx_pcie_add_lut_by_rid() and
apple_pcie_enable_device().

Thanks,
Vijay
>> +	sid = iommu_spec.args[0];
>>  	mutex_lock(&port->pcie->lock);
>>  
>>  	idx = bitmap_find_free_region(port->sid_map, port->sid_map_sz, 0);

