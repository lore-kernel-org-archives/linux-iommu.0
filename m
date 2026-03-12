Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F2535837A
	for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 14:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325107; cv=none; b=tTS3LF+SyniPSNMvbsYOriqGao24EHqjrBUPrk/dg0m/WnsnLm6XV2cax6s/gzeu1RbXM6zmzpLlo7EWUK6jUVxmzY2N9PcolDeXwTT14ktQ4k7uI1NylntiI+hjX8ex7oeLKk4hfEnM6ulFDUFiiKlz254ZlWJs8G1W9uWrKCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325107; c=relaxed/simple;
	bh=WBp6aG8OIPb/dsUpez1Ic8Jytais2oVJHc39FfdijWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UK8muLSi7xYuDyECKA/J7IQ9cxbVk1fPddxUFyPOs0Eqh8lYcROMr7SBPzjoO+sUY/D8KjG2avu5+nDeZweHRSjtho37PR6AiWz4eyDqN4+u13yUtmTdBtWCvcJfDG/qKehAmTWDxq9D7/YON04x+GbTYic9uu8N921YPv1WzJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pC9s3oCR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dSpduiLU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pC9s3oCR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dSpduiLU"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C9xuF4263554
	for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 14:18:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y7xFTGXb5DPsTd4oxsCvF8mg+z4yb1CrqE2iNac3ooo=; b=pC9s3oCR3E3pJGcF
	6UBJOzneozRH8yHPflsxqstBz8NmkNtzIcCOMzWl7Mf8bniEEG3tg1o8Gf6eOER8
	iEH5SI48La5x3ShD7d2U00BqfTQnGC86RMZBVy2//Y+3lQg8W+seoMLrQOG0EE+z
	dNM8ykzfkh7kNSve4jqCX2isXmsW6au2z2aD2Vl0RhkvgqBsHAjer2W60uOZM/ou
	G8q60QJZpk6R8OE+8EDLj6gFvBCIXS+427OcZgRvCgssFzBbiFfuWMcbTcw+C5VY
	9kymaHldyvZ6go56cowbutM/NN/MqcTN7b0pv0p53rwa2PzV2geT4iFmeTzVyLMA
	ChezqA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cuh4yjaue-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 14:18:25 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-94ad0d8eff8so17116068241.1
        for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 07:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773325105; x=1773929905; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y7xFTGXb5DPsTd4oxsCvF8mg+z4yb1CrqE2iNac3ooo=;
        b=dSpduiLUmJTHdJEcpQoGMYmWAjwwLJ/bI+eEt3rQ41ZIBz/DPGVbxWOmNOKbAnudfC
         VoJ8MRiGnhaaCmU3Tq6WNWl2+lU87Hd5z4Q2GFNxtc1wIs/1UOk8Hj48xednhpMGWZYT
         T762nnWRZXs/cGoJo/eJPzhLDT2ys7pxPP4sf/nVFGRpFTomLcPftyDpnWOYamFkWOAQ
         KhXP7Fbzm+LRr44CH3wAbzwCs9+2xmtDl7Ts13IfEll7Z1OY7PaLGtnBj2VTtWrU14ZT
         FBIy5XEAV2EvIIEPA7HQpBJIXExeVCWoYSrCi6xXw9VFdCw8wP7FcJl7ZIUIOwRORTCD
         gcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773325105; x=1773929905;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y7xFTGXb5DPsTd4oxsCvF8mg+z4yb1CrqE2iNac3ooo=;
        b=j2RlQhuccpoXxJIQw6W7n+q5rcVNISraA/yjvdOo8GTG9qgyXZv7TmmaKz0JCJALey
         5jpCGaWkDHmc5ejfYphR+pqs8ihnMWreI9fBmJNwCkbGf2q+brRMDGufueMdUrpMokKq
         FJq9nihmODYHZCln4vbvZYP57EW0Pafk1kE0z6KyDTPJxBXS8rY1J2r3WYVBRCviC/tu
         yLkbdS2HN7nclRW4xwmVj2ieRyApF2tnkBlyZEnRdOjN17VYxvav40VSkPzmoGL2d0Xb
         ReIttAf/hsBjQjtUw1ujiPQX7/Jw2RMLEe3kCRgw1GFGd5dPtaINGQ+Lr+pgdNT/cRdj
         nQeg==
X-Forwarded-Encrypted: i=1; AJvYcCXnx84EYTzOyFc3T6ia6w6Ax+u+n2nn/zQvfRcl4XrIgQ7EnSJR2elsQIGPTDz/WzV9XiD9BQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz2EJe+lZ2ny1p0rdKu0yb+z2jjgLpviC6SWBs02hLxUulUGig6
	AkyXSIlEL3uuxqsiUu3WiCaxteV3drhMwlTMIXqn3lLJMrmtbRJ+H19FYOBO83oM7D3ETOVeGh9
	mZ0RDy58/zy+kpue8fetpYETKY+26e8RslbznN1SOi4exv/rhql79ud9Beg==
X-Gm-Gg: ATEYQzwwipmHfsltw6z+VNUWb75c8H+vQG0IpjbH73dVEjwtw5/FXcGuyMiAerLi2yq
	JZiH1+zU2OUJ7OXke0qfCpM1Jhil6PXb9P1ZKp2vh1m6m5JtZjWNMEqte9y8A22y3VH3jzPF6Ld
	xrmLuYIRF5iubT5y2Zb3Qe3hJ/qDBHPkSI+OFuBoY7U1unCFDjWc0ttOLzO38CZoVPjG1zzomNy
	cgqXGU4emtT2eUXLk5YL0VAJ+53Pk7ANPfoOgBmRMgTXY67aP/j/b1mGwiowVqSkXv8U9NLrRwj
	+mWrjeRUpQQ+Ox6VtPbv2xbpS22lFreKh57s8nMulcVlAR9+blQbpZ0oaJwCySUndI1OAwEF9Sx
	3cMy/U/H/rT9qjPdDA9HMJeD+01WZKSzte1E5vRHlr+fUC07yewferNdkypgYzh1KjDkNVshGZC
	DN+UayiDfdXSY0YOsxNiJ1l4G8IwE6Bhzs4/M=
X-Received: by 2002:a05:6102:f11:b0:5ff:eaf0:6e77 with SMTP id ada2fe7eead31-601f4a44a79mr1406608137.17.1773325104559;
        Thu, 12 Mar 2026 07:18:24 -0700 (PDT)
X-Received: by 2002:a05:6102:f11:b0:5ff:eaf0:6e77 with SMTP id ada2fe7eead31-601f4a44a79mr1406556137.17.1773325104042;
        Thu, 12 Mar 2026 07:18:24 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a15602e268sm977710e87.21.2026.03.12.07.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 07:18:22 -0700 (PDT)
Date: Thu, 12 Mar 2026 16:18:20 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Cc: Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
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
        xen-devel@lists.xenproject.org, linux-arm-msm@vger.kernel.org,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Subject: Re: [PATCH v10 2/3] of: factor arguments passed to of_map_id() into
 a struct
Message-ID: <dyjdwxaq4oc7ahri3iuhnmobh3gwmn6drhox7t2elep4rlqhuq@fe4gp5t7q5r5>
References: <20260309-parse_iommu_cells-v10-0-c62fcaa5a1d8@oss.qualcomm.com>
 <20260309-parse_iommu_cells-v10-2-c62fcaa5a1d8@oss.qualcomm.com>
 <esfzpgpgenydif2sxahsetkglz6kewsgjhkmzr6ulrrkctnkbq@a4zsfdmhbxui>
 <27edd195-b0d3-4214-9df3-74a84da1e3e1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27edd195-b0d3-4214-9df3-74a84da1e3e1@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDExNCBTYWx0ZWRfXw1/lJbp2zMFl
 QbEFgF+EhjrEJIwkdd1XL178ZTkwNUCrlOB09PJzPzQ7VVEfgRngRL4LUv4ZSP4vrabJzYX9pNu
 bOtG9zAtHykYk/dOvpJTlkAf+Ld2iRAXQ/3SDI3LQPI+jSMOeGE/H2R2ZNs4bHgzBT7JwzRPcqu
 3G67RsWoHPjFpFmgWm7IsmvymgxrmXO7NwNiCZOP4HwXE7U9HzOc0mH9OO/866GzNuHfQzvqW09
 OYclgS3Nb9Nr2xUqPMElrAAOCfBtsvrnNIK052IZ+iKjCC3kJ2QM2m/jlYmzKSNodlUrERz8iVl
 Zx7u+3l/VstsPL8TXjGacSTdK8zvp8w9QbqJI4LqiKi2xpR71OISaTKBMEaOn0z/TZ69KVRZW87
 BebHxE+RB9zfB0XcUrqeYlez/AFOlw2XKyBvngiN+dqQawKY56+s3OJtPCy8yxRCiJCMkig1bQI
 A5W2+D3DT1/mFJBThlQ==
X-Proofpoint-ORIG-GUID: GZo4YSQEIDju9ndQAPSVl-SDjU9ZsO7x
X-Authority-Analysis: v=2.4 cv=C+7kCAP+ c=1 sm=1 tr=0 ts=69b2cb31 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=KPxCMH61eqygQ3DODZ0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: GZo4YSQEIDju9ndQAPSVl-SDjU9ZsO7x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120114

On Thu, Mar 12, 2026 at 05:12:51PM +0530, Vijayanand Jitta wrote:
> 
> 
> On 3/10/2026 2:53 AM, Dmitry Baryshkov wrote:
> > On Mon, Mar 09, 2026 at 01:03:38AM +0530, Vijayanand Jitta wrote:
> >> From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
> >>
> >> Change of_map_id() to take a pointer to struct of_phandle_args
> >> instead of passing target device node and translated IDs separately.
> >> Update all callers accordingly.
> >>
> >> Subsequent patch will make use of the args_count field in
> >> struct of_phandle_args.
> >>
> >> Suggested-by: Rob Herring (Arm) <robh@kernel.org>
> >> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
> >> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
> >> ---
> >>  drivers/cdx/cdx_msi.c                    |  5 ++-
> >>  drivers/iommu/of_iommu.c                 |  2 +-
> >>  drivers/irqchip/irq-gic-its-msi-parent.c | 11 ++++--
> >>  drivers/of/base.c                        | 63 ++++++++++++++++----------------
> >>  drivers/of/irq.c                         |  8 +++-
> >>  drivers/pci/controller/dwc/pci-imx6.c    | 16 ++++++--
> >>  drivers/pci/controller/pcie-apple.c      |  5 ++-
> >>  drivers/xen/grant-dma-ops.c              |  4 +-
> >>  include/linux/of.h                       | 12 +++---
> >>  9 files changed, 76 insertions(+), 50 deletions(-)
> >>
> >> diff --git a/drivers/cdx/cdx_msi.c b/drivers/cdx/cdx_msi.c
> >> index 63b3544ec997..03232b5ffbca 100644
> >> --- a/drivers/cdx/cdx_msi.c
> >> +++ b/drivers/cdx/cdx_msi.c
> >> @@ -121,6 +121,7 @@ static int cdx_msi_prepare(struct irq_domain *msi_domain,
> >>  			   struct device *dev,
> >>  			   int nvec, msi_alloc_info_t *info)
> >>  {
> >> +	struct of_phandle_args msi_spec = { .np = NULL };
> > 
> > Why do you need to set it? Parse functions ignore passed args, don't
> > they?
> > 
> 
> The parse function does check arg->np on input — if it is non-NULL,
> it is used to match only entries targeting that specific node.
> 
> Also, there is this existing path in drivers/pci/msi/irqdomain.c which
> pre-sets the node and passes it as input to of_msi_xlate(), so the node
> pointer is not ignored by the parse code:

Is it only being used for MSIs? If so, can we make that explicit in the
API by having the 'filter' device_node pointer?

> 
> u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
> {
>         struct device_node *of_node;
>         u32 rid = pci_dev_id(pdev);
> 
>         pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
> 
>         of_node = irq_domain_get_of_node(domain);
>         rid = of_node ? of_msi_xlate(&pdev->dev, &of_node, rid) :
>                         iort_msi_map_id(&pdev->dev, rid);
> 
>         return rid;
> }
> 

-- 
With best wishes
Dmitry
