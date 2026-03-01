Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ADD271A9A
	for <iommu@lists.linux.dev>; Sun,  1 Mar 2026 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772362025; cv=none; b=MCm55nk/o03bSEO5PppE/jDWmmjftnf2S67m2a4LFM4w7Q0Uh2Q1/UKp74IRHQdurobaGeKdFme1ABKE3N46xc5uNeYTLmlkH5Ui0IZqBwVm7EgKoKpfu89U9uuuUOjFUyhg8o4Qzzqm8B6cH8UjbRbQ64skTHl0Xjkg1qavxYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772362025; c=relaxed/simple;
	bh=uW8W0EQhL5MHVWOOJvr908HHoVSklsT9IyQhIzg9DOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMLbLdA35Xln6ft7Js5Vxdil/P/oabGS6lLQwlCb8jK/xQNiXusnor6zSnbm7LJ2ti1moExrFY4voNAA/i2aX8YxnFf6B/0+MwnU6H47+LLgFCjwK6BpEDgM83AvEBIin1ox69kPaUlraRhh2vtxfvJ+b9FaECgWAsZCERhG/mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YHzedMVv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LgFU2wzs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YHzedMVv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LgFU2wzs"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 621Ac81s1330592
	for <iommu@lists.linux.dev>; Sun, 1 Mar 2026 10:47:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zMjjSX07o27ArEy58bafhXTf
	zgI0LtEb8dLPu9QRg6g=; b=YHzedMVvaaQRmITBFe8xlRAGp8P99EssBQY/pKU4
	5F2QJ5TRhTc6aItMbvykuefuUQIazptsv9UE9PHpvwpC1M+e1jXsUT62ohJytu/e
	RldhLQBp18YepRjUSmK6wuw5wmhrPTkxHh0nYq0lBb+4nK4Ztl0J/nvTVcQEhFmQ
	jAhvb//acoWSA3UXKpi1kdahy8aWY8gtcFTmo0MoXVHVDbZtADY+PBM2PDG5mLct
	9m7MkPMdZ843hZ+h40XdTx1WGnDLataaldhWe/qsX5StDb8rU25k1g+v6s9gPp5d
	3cg1+H4J+zKzj/uIE/BAyVD607KfK0kE+a/7LiwBCbbnSw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cmgbar80n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 01 Mar 2026 10:47:02 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb52a9c0eeso2634956185a.2
        for <iommu@lists.linux.dev>; Sun, 01 Mar 2026 02:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772362022; x=1772966822; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zMjjSX07o27ArEy58bafhXTfzgI0LtEb8dLPu9QRg6g=;
        b=LgFU2wzsm/VjgCowQKmbwhSHYZeQBxIbIFSRTrc3G3+4ZsbTL59o/+BdYwhO8KE6uH
         BDwcuTehPv+IBgTIC55jkVG3Sshfdk73Mco025XF5KAL4QYm+Ti2pqN01pjhRpa76/0r
         cyzyQsCeSZDsK5nbEZrCCRXNp8nXoPQwSYpw5t5oCubKeJBoKIwkuCWj6DS4tklZOvcS
         UCDklF9wgsQc6YSWrmlaGUqgEyBCgrRJEPmVHmSG/lh6V0/haBbY4UbLq5j04WeJx9Xo
         /jA5SulqjxlHrCfjR4IKs2qKDGI/2PyTyECdt0w+Lm0GvbI5nirBftkLRfobzNjDYGmo
         W4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772362022; x=1772966822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMjjSX07o27ArEy58bafhXTfzgI0LtEb8dLPu9QRg6g=;
        b=aI5sEccQ3Gbj/plkpr0pvHCBMyueXQhvdcwXUmiAQr6QqwjChDdj1Gsz0fmQE5Ufa2
         DMfjgCa6VMe7XKCxBwrclQDwA1RoOX4PqoESorX1ZCETKG2+9GpeXH3TyTNnOBZ7z8gO
         lkrbFucZoPe9UdLM4puT4nEX/T58lYo1V/QfVC3XJLsq85dsrzuk0jX1EEHsE533fx3e
         om1tRvNbLFLtkbw0ITWS8wU85KWGih6BXM8xyRKVeqaRfy6EpIfSPVz70iDJaF0lrwWx
         EA7WB7leTyvu16Tp1g1tB5nf1feJJtOhygQlmkgoFhi93O+8B0NKc/EOFUhGpde+F6nn
         BVfA==
X-Forwarded-Encrypted: i=1; AJvYcCVgh2uvxvpfytkePBTt1xRvWrrqwLDHSMehVc/eSGfktqwcHBALc3K/T1ev+ZmhnK+39I2f3A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyPXNBPICtYBykrYH5f78TwI581d4v8YVJWvvDs4vpbj5Mos+p8
	oWzmuty8z4QVz8YGGrv4PcqDqcGAvauMQEnlwHEzEIp7MDXaXXv/PUNGHX5gX/8luRshsM95SSG
	R2gXILldKowgLR7FfLtlkXHRmQuWWniF3WD+WMgt02bi5qS9hmdEKtZnbPg==
X-Gm-Gg: ATEYQzwpF0SfU5xeHO9ryYspK6SvXFwOHgNvtVpRBmAhCUIGpPG6N5QThLzfmreRShC
	DA8KQxNC/TpW0Ev9FfWVzoVtswIBVNq/KKCSRvCm+xQ+IYkgWd63iRJZTExnSXp/0if+fyVsWwg
	kRVz2URt1/Wk4sdui8b/t+1voRmGOvoHJaItIjwlVjShK4JzXyiw8xWGMudNIsfSSOYl/cJ1eqy
	SVAlalEvgSk32aCc+/mwiXflSLwho/po2OutsLlU1vvsBtIaoaadMOdN8J6+QVEfM6X72uPQq8Y
	XrHgZ9A7IFdxxTcFNbxpKkOpl3JWrgi/Ixp5M0s9pw78SHobkVuo21OVIjes6+MymkHD9ZnVEfK
	eaCeHos9PfeernVCfDLIZ7KCI3RC5wkzFWaGSEHN+e9FG5x1l0OP+ph6QipuOSPMGhi6Pt92zoT
	GgEZLsBiou4jNP81UD0P9of6mCX+z9qeyh2rc=
X-Received: by 2002:a05:620a:199c:b0:8cb:50d6:18c3 with SMTP id af79cd13be357-8cbc8d6ef5bmr1217220285a.1.1772362021859;
        Sun, 01 Mar 2026 02:47:01 -0800 (PST)
X-Received: by 2002:a05:620a:199c:b0:8cb:50d6:18c3 with SMTP id af79cd13be357-8cbc8d6ef5bmr1217215585a.1.1772362021320;
        Sun, 01 Mar 2026 02:47:01 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a115bce377sm971860e87.15.2026.03.01.02.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 02:47:00 -0800 (PST)
Date: Sun, 1 Mar 2026 12:46:57 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>,
        Nipun Gupta <nipun.gupta@amd.com>,
        Nikhil Agarwal <nikhil.agarwal@amd.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>, Rob Herring <robh@kernel.org>,
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
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Prakash Gupta <prakash.gupta@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, imx@lists.linux.dev,
        xen-devel@lists.xenproject.org, linux-arm-msm@vger.kernel.org,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Subject: Re: [PATCH v9 2/3] of: factor arguments passed to of_map_id() into a
 struct
Message-ID: <ehhnta6zvfua723llpb52hh3lwqdh4ttomzt7xqrmcjnsslbop@p4w3gjzxp4rn>
References: <20260301-parse_iommu_cells-v9-0-4d1bceecc5e1@oss.qualcomm.com>
 <20260301-parse_iommu_cells-v9-2-4d1bceecc5e1@oss.qualcomm.com>
 <861pi3amuu.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <861pi3amuu.wl-maz@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAxMDA5NiBTYWx0ZWRfX6dYWzWv2Tj4W
 JGTUDrHvW4Ca0jtthRgYKC7EfsxKF44kW/rEfFmz++w+/pmMYLsORD8V2gJRJ7F52ZNFTyUHMIA
 hV/5oFTeRpK6Wobyhp4I/ockmK323Cc7IWWE/CzpmJ5gFC1ZqCnCeicVwslG9rVzJQeKC/Uq09X
 uaDsxuZM9IdqMxuMbNlxpTH3XSlpFpLIyBv1oAyIlUyWLQkzeSdCjej4/XLI5mbW+F4CeWEp2W/
 fuzRTUNbCPwTPhOo3KxJRVU1+E3YzGzMXtH2/boEC+DUet9kemnEJilgBDdRk35OGYELf75+7DB
 94APGCw2cjU/OIOJ6i6g/miCjGZEHW9Jo3Qcf1NxNbbvYqKxjl58ddFUVy5MOUUVq2ZRP6cF3uz
 w6KpTaRMKlmI5dzODH+oqKzWH74oIX1p4TuQ6jyj+dwsZ9ZidI1HH7Ac25BC0nXNOj+rJ/xApyW
 1/Ix70AQthBRbBUb5Ag==
X-Authority-Analysis: v=2.4 cv=QfVrf8bv c=1 sm=1 tr=0 ts=69a41926 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=YG64nluAAAAA:20
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=Pq9JgrngHnaR5_AiyuMA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: ORWkQb3dDNytsd41zjZcCloMzhN68qNp
X-Proofpoint-GUID: ORWkQb3dDNytsd41zjZcCloMzhN68qNp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-01_01,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603010096

On Sun, Mar 01, 2026 at 10:02:49AM +0000, Marc Zyngier wrote:
> On Sun, 01 Mar 2026 08:34:20 +0000,
> Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com> wrote:
> > 
> > From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
> > 
> > Change of_map_id() to take a pointer to struct of_phandle_args
> > instead of passing target device node and translated IDs separately.
> > Update all callers accordingly.
> > 
> > Subsequent patch will make use of the args_count field in
> > struct of_phandle_args.
> > 
> > Suggested-by: Rob Herring (Arm) <robh@kernel.org>
> > Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
> > Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
> > ---
> >  drivers/iommu/of_iommu.c              |  2 +-
> >  drivers/of/base.c                     | 37 +++++++++++++++++------------------
> >  drivers/pci/controller/dwc/pci-imx6.c |  8 +++++++-
> >  drivers/pci/controller/pcie-apple.c   |  4 +++-
> >  drivers/xen/grant-dma-ops.c           |  2 +-
> >  include/linux/of.h                    | 21 +++++++++++++-------
> >  6 files changed, 44 insertions(+), 30 deletions(-)
> > 
> > diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> > index a511ecf21fcd..d255d0f58e8c 100644
> > --- a/drivers/iommu/of_iommu.c
> > +++ b/drivers/iommu/of_iommu.c
> > @@ -48,7 +48,7 @@ static int of_iommu_configure_dev_id(struct device_node *master_np,
> >  	struct of_phandle_args iommu_spec = { .args_count = 1 };
> >  	int err;
> >  
> > -	err = of_map_iommu_id(master_np, *id, &iommu_spec.np, iommu_spec.args);
> > +	err = of_map_iommu_id(master_np, *id, &iommu_spec);
> >  	if (err)
> >  		return err;
> >  
> > diff --git a/drivers/of/base.c b/drivers/of/base.c
> > index 57420806c1a2..6c3628255908 100644
> > --- a/drivers/of/base.c
> > +++ b/drivers/of/base.c
> > @@ -2102,8 +2102,11 @@ int of_find_last_cache_level(unsigned int cpu)
> >   * @id: device ID to map.
> >   * @map_name: property name of the map to use.
> >   * @map_mask_name: optional property name of the mask to use.
> > - * @target: optional pointer to a target device node.
> > - * @id_out: optional pointer to receive the translated ID.
> > + * @arg: of_phandle_args structure,
> > + *	which includes:
> > + *	np: pointer to the target device node
> > + *	args_count: number of arguments
> 
> Number of arguments *to what*? Isn't that the size of args[] instead?

It is a number of values corresponding to the phandle in the DT
property. It might be not obvious here for iommu-maps, but the struct is
idiomatic in OF world. Let me quote a (trimmed) example from
qcom/sm8650.dtsi (for a different property, but it explains the meaning
of the values here):

gem_noc: interconnect@24100000 {
	#interconnect-cells = <2>;
};

epss_l3: interconnect@17d90000 {
	#interconnect-cells = <1>;
};

interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
		 &gem_noc SLAVE_LLCC QCOM_ICC_TAG_ACTIVE_ONLY>,
		<&epss_l3 MASTER_EPSS_L3_APPS
		 &epss_l3 SLAVE_EPSS_L3_SHARED>;
/* I skipped the second pair, it adds nothing here */

Here the parsing function for this property (of_icc_get_by_index()) will
call of_parse_phandle_with_args() 4 times and it expects to return the
following values in the of_phandle_args:

1. { .np = gem_noc, .args_count = 2, .args = [MASTER_APPSS_PROC,
                                              QCOM_ICC_TAG_ACTIVE_ONLY] }
2. { .np = gem_noc, .args_count = 2, .args = [SLAVE_LLCC,
                                              QCOM_ICC_TAG_ACTIVE_ONLY] }
3. { .np = epss_l3, .args_count = 1, .args = [MASTER_EPSS_L3_APPS] }
4. { .np = epss_l3, .args_count = 1, .args = [SLAVE_EPSS_L3_SHARED] }

The whole of_phandle_args is then typically passed to the corresponding
xlate function, specific to the paricular .np ('provider'), which will
use #args_count values from the #args array to return the object from
the provider.

Now let's see iommu-maps (again, qcom/sm8650.dtsi):

apps_smmu: iommu@15000000 {
	#iommu-cells = <2>;
};

iommu-map = <0     &apps_smmu 0x1400 0x1>,
	    <0x100 &apps_smmu 0x1401 0x1>;

The property matches current definition at [1], however this spec
doesn't match the DT practice. It forces that the property should use 1
cell for identifying the "object" in the IOMMU provider, even if the
provider expects to use 2 cells (two args).

The correct property should look like:

iommu-map = <0     &apps_smmu 0x1400 0x0 0x1>,
	    <0x100 &apps_smmu 0x1401 0x0 0x1>;

[1] https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pci/pci-iommu.yaml

> 
> > + *	args[]: array to receive the translated ID(s).
> >   *
> >   * Given a device ID, look up the appropriate implementation-defined
> >   * platform ID and/or the target device which receives transactions on that
> > @@ -2117,21 +2120,21 @@ int of_find_last_cache_level(unsigned int cpu)
> >   */
> >  int of_map_id(const struct device_node *np, u32 id,
> >  	       const char *map_name, const char *map_mask_name,
> > -	       struct device_node **target, u32 *id_out)
> > +	       struct of_phandle_args *arg)
> >  {
> >  	u32 map_mask, masked_id;
> >  	int map_len;
> >  	const __be32 *map = NULL;
> >  
> > -	if (!np || !map_name || (!target && !id_out))
> > +	if (!np || !map_name || !arg)
> >  		return -EINVAL;
> >  
> >  	map = of_get_property(np, map_name, &map_len);
> >  	if (!map) {
> > -		if (target)
> > +		if (arg->np)
> >  			return -ENODEV;
> >  		/* Otherwise, no map implies no translation */
> > -		*id_out = id;
> > +		arg->args[0] = id;
> 
> What if args_count is 0? Given that you place no restriction on the
> way this can be called, that'd be entirely legitimate, and you'd
> corrupt something you're not supposed to touch.

args is an array (not a pointer) in of_phandle_args. As such we know
that args[0] is legit.

> 
> >  		return 0;
> >  	}
> >  
> > @@ -2173,18 +2176,15 @@ int of_map_id(const struct device_node *np, u32 id,
> >  		if (!phandle_node)
> >  			return -ENODEV;
> >  
> > -		if (target) {
> > -			if (*target)
> > -				of_node_put(phandle_node);
> > -			else
> > -				*target = phandle_node;
> > +		if (arg->np)
> > +			of_node_put(phandle_node);
> > +		else
> > +			arg->np = phandle_node;
> >  
> > -			if (*target != phandle_node)
> > -				continue;
> > -		}
> > +		if (arg->np != phandle_node)
> > +			continue;
> >  
> > -		if (id_out)
> > -			*id_out = masked_id - id_base + out_base;
> > +		arg->args[0] = masked_id - id_base + out_base;
> >  
> >  		pr_debug("%pOF: %s, using mask %08x, id-base: %08x, out-base: %08x, length: %08x, id: %08x -> %08x\n",
> >  			np, map_name, map_mask, id_base, out_base,
> > @@ -2193,11 +2193,10 @@ int of_map_id(const struct device_node *np, u32 id,
> >  	}
> >  
> >  	pr_info("%pOF: no %s translation for id 0x%x on %pOF\n", np, map_name,
> > -		id, target && *target ? *target : NULL);
> > +		id, arg->np ? arg->np : NULL);
> >  
> >  	/* Bypasses translation */
> > -	if (id_out)
> > -		*id_out = id;
> > +	arg->args[0] = id;
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(of_map_id);
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index bff8289f804a..74fc603b3f84 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -1139,12 +1139,18 @@ static int imx_pcie_add_lut_by_rid(struct imx_pcie *imx_pcie, u32 rid)
> >  {
> >  	struct device *dev = imx_pcie->pci->dev;
> >  	struct device_node *target;
> > +	struct of_phandle_args iommu_spec = { .args_count = 1 };
> >  	u32 sid_i, sid_m;
> >  	int err_i, err_m;
> >  	u32 sid = 0;
> >  
> >  	target = NULL;
> > -	err_i = of_map_iommu_id(dev->of_node, rid, &target, &sid_i);
> > +	err_i = of_map_iommu_id(dev->of_node, rid, &iommu_spec);
> > +	if (!err_i) {
> > +		target = iommu_spec.np;
> > +		sid_i = iommu_spec.args[0];
> > +	}
> > +
> >  	if (target) {
> >  		of_node_put(target);
> >  	} else {
> > diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> > index a0937b7b3c4d..e1d4b37d200d 100644
> > --- a/drivers/pci/controller/pcie-apple.c
> > +++ b/drivers/pci/controller/pcie-apple.c
> > @@ -755,6 +755,7 @@ static int apple_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_d
> >  {
> >  	u32 sid, rid = pci_dev_id(pdev);
> >  	struct apple_pcie_port *port;
> > +	struct of_phandle_args iommu_spec = { .args_count = 1 };
> >  	int idx, err;
> >  
> >  	port = apple_pcie_get_port(pdev);
> > @@ -764,10 +765,11 @@ static int apple_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_d
> >  	dev_dbg(&pdev->dev, "added to bus %s, index %d\n",
> >  		pci_name(pdev->bus->self), port->idx);
> >  
> > -	err = of_map_iommu_id(port->pcie->dev->of_node, rid, NULL, &sid);
> > +	err = of_map_iommu_id(port->pcie->dev->of_node, rid, &iommu_spec);
> >  	if (err)
> >  		return err;
> >  
> > +	sid = iommu_spec.args[0];
> 
> I find this stuff absolutely unreadable. You're fishing the SID in a
> random position of a random structure, without any documentation of
> how this is supposed to work. This really needs a wrapper that hides
> this implementation detail.
> 
> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.

-- 
With best wishes
Dmitry
