Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629C9344DA6
	for <iommu@lists.linux.dev>; Mon,  9 Mar 2026 21:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773091400; cv=none; b=Eh/gQxmCYSoCZIPooe0FKcTMtjPTtwvqflqvq1dzOWWk6A7QqeZw8LXbRlTBu7HMag/g1+hjRA6sgOnVEamGvhYb6egloU47FT63Z2rV7zVIVatesKnnxzcgJ+Pp5jGLDu9mb52oO98WkBIGnzmcwaGAr8JeFzXnQX8vFH8nGXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773091400; c=relaxed/simple;
	bh=m1v80ULIA7KIbd4p3gE+m9qvtGfx8dQ7XD8T+nphWSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPXScW7SKgmkMDWM7WHAy6quStO1ZK83qvDsPMPLF47xk5TcHyAeZ05/8rGIPJOq61otrMOXWxojYNpWca1ZZgINvE1nvafUxtUxN7nhbAayugTGIoFAtvPNRxn7yOtj+itFE9Wy0GZLx24X+9CClNxWmyNTCOTS8wz9kYVJb7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eyJPpq3I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WxNG0LWz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eyJPpq3I";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WxNG0LWz"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629HBlsp296200
	for <iommu@lists.linux.dev>; Mon, 9 Mar 2026 21:23:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=TtfIg1OCm36qvkMhTOZUWOO1
	bZpr9t+AjKAbArsxNiE=; b=eyJPpq3Ig7NxG3aU7DJtqhc3PsNXLt5yKHOlINSp
	78iEyJkx1Kv9HVu6lMkbquLLkhFVRe5VDgVx9MdIMWcWpERBlViQyHeWKFr7V/43
	lAexD7de/jtwjnixjFWElOdRtTAIZNMzoznOULVcEij4or/w85O0w5pOTYqfMFzD
	wgLOlGhGMmOrikUaOuSMbrHYIzoWhjJeHlO1Qrx5j6m2GqcbpZQ1RTGMGok0jfFB
	XGjD8yimz+eA29vgC3DWQ7BPQBxPpoNpuMsj+8cgHe4x9pLY4Yzr1buVqa0zukzA
	m+HUjpVrpT5ki3Gp8XA+FcQIiEHg+NxuCR1N3G0DZTdEOQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csyfy1hfe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 09 Mar 2026 21:23:18 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cd91c0262fso331980785a.1
        for <iommu@lists.linux.dev>; Mon, 09 Mar 2026 14:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773091398; x=1773696198; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TtfIg1OCm36qvkMhTOZUWOO1bZpr9t+AjKAbArsxNiE=;
        b=WxNG0LWzK6anw3moTPexd/F+8i17AqwtC9dw/+cQJgEdePiIl2FiAmQaW+6+6GZfdL
         +iGAP9bwp6brJLbAqcMcR7qp0grAnJvrUGAyi2iKjD4hupZp8iBAAHg9Q7K/IDVHuGIR
         tm0D6l7xfjuydHRltxREi7MDANC63PrlLBMgsArEUw4yhlnLybLkfvnkIJF6jUscv9ih
         AgL0LJHUsepXu6JWO6Yx8EmJflJLBDj8zZYDORwK1dFXmdTyBvQijNLFbkZSr0V3KzRH
         0mT2p1tfIIjYVNIgG+m3E5jP6DeTG8ieDS8zDznabm84Vka+fG9znmMotxL9dhD7Bt69
         medA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773091398; x=1773696198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TtfIg1OCm36qvkMhTOZUWOO1bZpr9t+AjKAbArsxNiE=;
        b=SfMoPixYmCqM4OUTTn+07FE9JUgStfJLdEZ+10SD03Jc/SWohbEVqNKQCibawdi/8U
         Avakm5/3sZEm2wPcClxSFxjMB3ZKdiyHeGeWg2tzCe0opyAX4y5weRTipjhJLcx4suO4
         9mlz4tiF+mW5dJRRKiUBhvUm69GWI8zlmWYDrcdSZXc5O+8L80XiipgMHADiBraxoInd
         E6z7EtyGr9RJ4t5OwzyYtx8W4xhPF8RA+O0WF8dlv9oZSuqci69Hj07m5IK7+nUVcbbB
         tXjDi2py8nNr2fPOg3MPt//urfPw621ssQenr0mOk/rMhMPJ6lcFZ7uEhxy6Ijl6wuPJ
         R+EQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw8ZiL/QaZWnG+1g/WKAq6ddPjxBR5GYCHf9aYLi6Y86+nRORq+w1OygIXd7NQhdGqOOe1GA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4OSYursYV7a9LDF2zRKlWGTdk2CWTZCfEFphInRAm5iIqRlgb
	/6M7L57y1LuS887fOr+L+XPKYPdg1CpW8zcEXHgffSbwWw2SeUFIoJXBwtGH0N0/S9wnfzurB4x
	r25UetZSEntMoenwN59+EckMgIuqRRciNsOCUgu7BQqxnQzGSMEqjQj8VdQ==
X-Gm-Gg: ATEYQzyuKSSXaa5CSdEih+u+XZvVtAM1cYZZWcoSr8eg4gGxRYevmovNMTvUkoLFhix
	4/50zS/YimehZTJhZ3wznk9DAvRib3b74ZVXRp4B+OHcAQsSekUS1CPN/2n5awzOcdQvYA7Lw83
	N7LKPs3fDynUelvZG6tMnY8bXyrD6o1D32hRbtQ4UIdddNVkR4dDrwfjKeTDdIw3a9oBhEz0UNq
	ljiqr164Q/YZ3w7khLp95nTFHvrm2hntKTlbhIYe0tYJ3UQB69NPQ3282TS2TtmI4/jC9Bi2Hi1
	dPDUbZqlkdFQ+/sTv9OGya1feJKGkGGUA95+PzKf3RgttI1TUTl0jlyq68z5bYPcXLR4YCQmsfh
	6Jwu0ytgvtgZ5OsKMh3sKqRXBUEIA9jf6CsaXMpK4TvM8KqkFjdWcvZtYnZ/5/jQm3bvpH34g9F
	0/hwtSbICv7JQ/LzqoD7vaN8kZjjWFlG2A3dI=
X-Received: by 2002:a05:620a:40c3:b0:8cd:8f18:d1d3 with SMTP id af79cd13be357-8cd8f18d5demr363278985a.58.1773091397453;
        Mon, 09 Mar 2026 14:23:17 -0700 (PDT)
X-Received: by 2002:a05:620a:40c3:b0:8cd:8f18:d1d3 with SMTP id af79cd13be357-8cd8f18d5demr363272685a.58.1773091396812;
        Mon, 09 Mar 2026 14:23:16 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a13d02b7e5sm2278544e87.32.2026.03.09.14.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 14:23:15 -0700 (PDT)
Date: Mon, 9 Mar 2026 23:23:14 +0200
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
Message-ID: <esfzpgpgenydif2sxahsetkglz6kewsgjhkmzr6ulrrkctnkbq@a4zsfdmhbxui>
References: <20260309-parse_iommu_cells-v10-0-c62fcaa5a1d8@oss.qualcomm.com>
 <20260309-parse_iommu_cells-v10-2-c62fcaa5a1d8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309-parse_iommu_cells-v10-2-c62fcaa5a1d8@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE5MCBTYWx0ZWRfX7kLMp0ZHQL9a
 34BOpAznRU/p7fUveHaZ/aBLA82ZgXIKvQYXWvgi7lNgkzpMqDJPkbCpzyYICN/sW63f86x+2ke
 H9PHF6t6YKZ0GgNYTCfe3vHHkdmckZPIh28W7gTcxsJ6PAgByDR0Kna66Oda/B0xiQFVYWejNRT
 tD8E/Y8kMKNz5OhtVB8zDJuGl85rKP2fNKCRT7q+yxUc9m+T8ZP34l5ZTR8bWZSahMV/KzSGcSH
 5rhwxdMsvSdZ9bn6g4O/njRRJ59mIg0dVg7oJxa5hB5jXbRVBTfWalS2NCZSk2zc24CrJ9v1g79
 6p6BoR/ZjkChlDZsVRwZMQngjVxDiZWCNKzJFYanDdN+cvq3A2L/N6xTvO/md4ulKLSBv7rDOsn
 iVUwidoOtH9hpWrltDphEhUKT4EIgi5z4CKk/9EB5AUf5pf5vBI/0UOYdtREfjpsvEX/Lt3pDFQ
 d3OS8Ud+UDJ0kXl4lCA==
X-Authority-Analysis: v=2.4 cv=OcmVzxTY c=1 sm=1 tr=0 ts=69af3a46 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=eKfNa9SdMFmDU-kgw3kA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: j9XoZqI-eNTZ5FmnZqbuM_Vike181EPh
X-Proofpoint-ORIG-GUID: j9XoZqI-eNTZ5FmnZqbuM_Vike181EPh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_06,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090190

On Mon, Mar 09, 2026 at 01:03:38AM +0530, Vijayanand Jitta wrote:
> From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
> 
> Change of_map_id() to take a pointer to struct of_phandle_args
> instead of passing target device node and translated IDs separately.
> Update all callers accordingly.
> 
> Subsequent patch will make use of the args_count field in
> struct of_phandle_args.
> 
> Suggested-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
> ---
>  drivers/cdx/cdx_msi.c                    |  5 ++-
>  drivers/iommu/of_iommu.c                 |  2 +-
>  drivers/irqchip/irq-gic-its-msi-parent.c | 11 ++++--
>  drivers/of/base.c                        | 63 ++++++++++++++++----------------
>  drivers/of/irq.c                         |  8 +++-
>  drivers/pci/controller/dwc/pci-imx6.c    | 16 ++++++--
>  drivers/pci/controller/pcie-apple.c      |  5 ++-
>  drivers/xen/grant-dma-ops.c              |  4 +-
>  include/linux/of.h                       | 12 +++---
>  9 files changed, 76 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/cdx/cdx_msi.c b/drivers/cdx/cdx_msi.c
> index 63b3544ec997..03232b5ffbca 100644
> --- a/drivers/cdx/cdx_msi.c
> +++ b/drivers/cdx/cdx_msi.c
> @@ -121,6 +121,7 @@ static int cdx_msi_prepare(struct irq_domain *msi_domain,
>  			   struct device *dev,
>  			   int nvec, msi_alloc_info_t *info)
>  {
> +	struct of_phandle_args msi_spec = { .np = NULL };

Why do you need to set it? Parse functions ignore passed args, don't
they?

>  	struct cdx_device *cdx_dev = to_cdx_device(dev);
>  	struct device *parent = cdx_dev->cdx->dev;
>  	struct msi_domain_info *msi_info;
> @@ -128,11 +129,13 @@ static int cdx_msi_prepare(struct irq_domain *msi_domain,
>  	int ret;
>  
>  	/* Retrieve device ID from requestor ID using parent device */
> -	ret = of_map_msi_id(parent->of_node, cdx_dev->msi_dev_id, NULL, &dev_id);
> +	ret = of_map_msi_id(parent->of_node, cdx_dev->msi_dev_id, &msi_spec);
>  	if (ret) {
>  		dev_err(dev, "of_map_id failed for MSI: %d\n", ret);
>  		return ret;
>  	}
> +	of_node_put(msi_spec.np);
> +	dev_id = msi_spec.args[0];
>  
>  #ifdef GENERIC_MSI_DOMAIN_OPS
>  	/* Set the device Id to be passed to the GIC-ITS */
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index a511ecf21fcd..d255d0f58e8c 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -48,7 +48,7 @@ static int of_iommu_configure_dev_id(struct device_node *master_np,
>  	struct of_phandle_args iommu_spec = { .args_count = 1 };

.args_count = 1 should be set by of_map_iommu_id now (and dropped here).

>  	int err;
>  
> -	err = of_map_iommu_id(master_np, *id, &iommu_spec.np, iommu_spec.args);
> +	err = of_map_iommu_id(master_np, *id, &iommu_spec);
>  	if (err)
>  		return err;
>  
> diff --git a/drivers/irqchip/irq-gic-its-msi-parent.c b/drivers/irqchip/irq-gic-its-msi-parent.c
> index b63343a227a9..729fa2f9f758 100644
> --- a/drivers/irqchip/irq-gic-its-msi-parent.c
> +++ b/drivers/irqchip/irq-gic-its-msi-parent.c
> @@ -152,6 +152,8 @@ static int its_v5_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
>  static int of_pmsi_get_msi_info(struct irq_domain *domain, struct device *dev, u32 *dev_id,
>  				phys_addr_t *pa)
>  {
> +	struct device_node *msi_ctrl __free(device_node) = NULL;
> +	struct of_phandle_args msi_spec = { .np = NULL };
>  	struct of_phandle_iterator it;
>  	int ret;
>  
> @@ -178,9 +180,12 @@ static int of_pmsi_get_msi_info(struct irq_domain *domain, struct device *dev, u
>  		}
>  	}
>  
> -	struct device_node *msi_ctrl __free(device_node) = NULL;
> -
> -	return of_map_msi_id(dev->of_node, dev->id, &msi_ctrl, dev_id);
> +	ret = of_map_msi_id(dev->of_node, dev->id, &msi_spec);
> +	if (!ret) {
> +		msi_ctrl = msi_spec.np;
> +		*dev_id = msi_spec.args[0];
> +	}
> +	return ret;
>  }
>  
>  static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 959305a84748..b6e07c5fe715 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -2102,36 +2102,37 @@ int of_find_last_cache_level(unsigned int cpu)
>   * @id: device ID to map.
>   * @map_name: property name of the map to use.
>   * @map_mask_name: optional property name of the mask to use.
> - * @target: optional pointer to a target device node.
> - * @id_out: optional pointer to receive the translated ID.
> + * @arg: pointer to a &struct of_phandle_args. On input, @arg->np may be
> + *	set to a target device node to match, or NULL to match any. On
> + *	success, @arg->np will be set to the matched target node (with a
> + *	reference held) and @arg->args[0] will contain the translated ID.

Is this part being actually used (and useful)?

>   *
>   * Given a device ID, look up the appropriate implementation-defined
>   * platform ID and/or the target device which receives transactions on that
> - * ID, as per the "iommu-map" and "msi-map" bindings. Either of @target or
> - * @id_out may be NULL if only the other is required. If @target points to
> - * a non-NULL device node pointer, only entries targeting that node will be
> - * matched; if it points to a NULL value, it will receive the device node of
> - * the first matching target phandle, with a reference held.
> + * ID, as per the "iommu-map" and "msi-map" bindings. If @arg->np points to
> + * a non-NULL device node, only entries targeting that node will be matched;
> + * if it is NULL, it will receive the device node of the first matching
> + * target phandle, with a reference held.
>   *
>   * Return: 0 on success or a standard error code on failure.
>   */
>  int of_map_id(const struct device_node *np, u32 id,
>  	       const char *map_name, const char *map_mask_name,
> -	       struct device_node **target, u32 *id_out)
> +	       struct of_phandle_args *arg)
>  {
>  	u32 map_mask, masked_id;
>  	int map_len;
>  	const __be32 *map = NULL;
>  
> -	if (!np || !map_name || (!target && !id_out))
> +	if (!np || !map_name || !arg)
>  		return -EINVAL;
>  
>  	map = of_get_property(np, map_name, &map_len);
>  	if (!map) {
> -		if (target)
> +		if (arg->np)
>  			return -ENODEV;
>  		/* Otherwise, no map implies no translation */
> -		*id_out = id;
> +		arg->args[0] = id;
>  		return 0;
>  	}
>  
> @@ -2173,18 +2174,15 @@ int of_map_id(const struct device_node *np, u32 id,
>  		if (!phandle_node)
>  			return -ENODEV;
>  
> -		if (target) {
> -			if (*target)
> -				of_node_put(phandle_node);
> -			else
> -				*target = phandle_node;
> +		if (arg->np)
> +			of_node_put(phandle_node);
> +		else
> +			arg->np = phandle_node;
>  
> -			if (*target != phandle_node)
> -				continue;
> -		}
> +		if (arg->np != phandle_node)
> +			continue;
>  
> -		if (id_out)
> -			*id_out = masked_id - id_base + out_base;
> +		arg->args[0] = masked_id - id_base + out_base;
>  
>  		pr_debug("%pOF: %s, using mask %08x, id-base: %08x, out-base: %08x, length: %08x, id: %08x -> %08x\n",
>  			np, map_name, map_mask, id_base, out_base,

-- 
With best wishes
Dmitry
