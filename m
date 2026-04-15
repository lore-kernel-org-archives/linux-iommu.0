Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E878A390238
	for <iommu@lists.linux.dev>; Wed, 15 Apr 2026 07:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776238913; cv=none; b=RjG+qnaMW4/xxS0RyWjHOgIetNoEkgsMB1cp9Us9SqKQ1Np4rFAI89/RgqudNH+ob/XPQ+Nmq2MqGHugfp5FD7knuLMkYqGOa2icAtnZ1KoEjhpzSIeC3C4RW1HAHxxRNIaPgvRu8oiUUewb2T1Ls1CdH9iqdgMGSiDgfQv57Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776238913; c=relaxed/simple;
	bh=W62tWESM4gyLAD60Nr8FLrKgGfGIsNrx/lX0lAT80rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j28uH+GdwADGQiyn6ax/aMVF1zdVuzu1HYlg+p8WoC18Nzb93Fzq25WsV4LkgdcaoAsEsJdXgOFvnie2nZEGsDf75/tkRtEX/1mlRn87rH85fL8egth7n/5CHoMPUpAykq1gT3kbp3Ksml5CSXV+03AitH3JZSzJX2WUgv54kpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fmv5bHmd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D7z/EXa6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fmv5bHmd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D7z/EXa6"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F2TPYf731080
	for <iommu@lists.linux.dev>; Wed, 15 Apr 2026 07:41:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fEE+gAEsFWtIb8J9lBZIYnIc
	JedOP7rud4t86JGVm1g=; b=fmv5bHmdyeeR0J5fV6LTm1j0KuQGJ82LUOLwOjAz
	vo4PmJagFxMmZ9AEE3iR5zYoXul7wvZf3Q5+GrLx3H3D4QpXCpcWhgk1L87G3rPK
	JPWULzEc2eL2oBpTh+ndk552gmtSdKBsynPemxzJ3N75mpHC7s8W2P4Bq/7AHfdZ
	4S2Ebb97lpbTqdxruC9969b+2EOGvE7dO7oWOo9ovmEO3h1A/tClDKqn96A1eWmM
	vNtReg1uUXxUAcBc3YZFXnLl2fnvaN6Khj5kqsXZuzwbITqbU5yRu4MF/oeQmgbA
	zC2CzHbjnPTeTpUuPDStzTHhFd99cAq94KU0FWQXR2RuKQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dhruuan0p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 15 Apr 2026 07:41:51 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35842aa350fso12175149a91.0
        for <iommu@lists.linux.dev>; Wed, 15 Apr 2026 00:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776238911; x=1776843711; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fEE+gAEsFWtIb8J9lBZIYnIcJedOP7rud4t86JGVm1g=;
        b=D7z/EXa62wRk0Hl6IFhNOmdCc3KOOLfVURbw61rod8Bdx6Az7HSGtjT3x2okmJ6E0d
         UzeKAwtHfFotVmwidA+ZoVIKJhEmMstN9dZcLMTEvU9ec6bmAHPhDhmjx9a41kqDLPam
         J6go+2Pwomi1T86PkYPXNW1XEHINvO5GLNKTFx0QMtw+f4oyQb8OZTpRZtdpXD203d0d
         fWPjoq8cXKpI+2Qc33aZVwq1pXPnpjZ59iRfjq9Sxws0Vo0GkFmfTtcd1XjohQIguCBa
         XJ53XlNPZz4AummyvauBb4QLEiZCDD6vjLuZCGhg6VoQ2oh4fFZT6cNz2Df/kPzGfaUE
         1M4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776238911; x=1776843711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fEE+gAEsFWtIb8J9lBZIYnIcJedOP7rud4t86JGVm1g=;
        b=NZZZAsBYrbc9o46mr3REVo8BE/zf5d9uYIP8H0DcL9+OgfD8m0UUm/auGA9Gkin7s0
         GP9IfDhyP6B7y4gtuv2xQP//J3WOfmJtgy1+zkbjtz13Qu4hM+eeD493fOJ0mTKrCU4A
         8khcyrBUQrXV51I+flE7fYpp6fdXez+WIrFCYnnLo1OEI3kQn819LM7n+R14Z5ex5j5n
         9BaAiPWyv9Zhz/sgaqLr12bwjLkHnLggEnDBHGs65DZOkhjF8XXx/7gLgWvJNekzsPzr
         0Nbc4UXtFrL+M76DGtUC8f01Aj/nL3WrxFhWV6f/qoavrO+9pHxY/HMZhrA7MryypGOh
         iNlg==
X-Forwarded-Encrypted: i=1; AFNElJ927F8w4o5fDY8GumzGl96+GWU26YJhTQD6SDMgVa41SKWuSPo+A8Hck5QUsJPzgWP/mtdW3g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxBHRI5ve4Yq2+mV3PqFyhg8bIoqHfxMxagCrtAYSn63Q/cL1KG
	X1YpIUf0SuIs67icTk/Y4SVLEgxusitXz+Irv/vhk3q0OU82oamqvzCrmsnkQyj9sTh3QyZL1eJ
	sFhHU3ymJABlSTaWy19hZFezxqiiE1h/RkQplXk6YzgAbxAqPa5uqRY+QZA==
X-Gm-Gg: AeBDievtOFUQfyR1M/rfQ2KDRDpoa84niEAtHOpd4Cxghfn8qno+xJOQAU9KZgsO4SG
	bjSlNG6BJADNOR6GNm4/ndTIQ2ZyE2qlD5aD92w/ZqoWCp+8kvzGNcEN2eePd62/h2Jii4l4bKk
	VLZ/goE0RhHh4OZKuS44hirHQZ45OPaOTpQfSWRAB/bSteDzBXuJZrnhVVJZP0XyMTxzk3n2kpm
	0Us4eEMlOf87egeve4tKfUftzVMgzanHsMg2SMR4uJWxK7Xv3N3Sm4eCgOEb+tspL18IRx+K5n7
	9QhYeYDJnwOWn7a0Vmc91GVeZbbnJLSIbwnaOwOWhdJzjiQtibTfeXT+IU/JGKzOq3B4lCcC/c0
	7Vl7vSu1zbEECUxRx6iTf9krQCKcR+f0A5Pyx82Qj7lqMppqm
X-Received: by 2002:a17:90b:2890:b0:35f:bd29:75b9 with SMTP id 98e67ed59e1d1-35fbd2976d8mr9238436a91.22.1776238910423;
        Wed, 15 Apr 2026 00:41:50 -0700 (PDT)
X-Received: by 2002:a17:90b:2890:b0:35f:bd29:75b9 with SMTP id 98e67ed59e1d1-35fbd2976d8mr9238391a91.22.1776238909809;
        Wed, 15 Apr 2026 00:41:49 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fd2010246sm1863160a91.6.2026.04.15.00.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 00:41:49 -0700 (PDT)
Date: Wed, 15 Apr 2026 13:11:40 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH 05/11] media: iris: Enable Secure PAS support with IOMMU
 managed by Linux
Message-ID: <20260415074140.46bg27tzbuyzjq3d@hu-mojha-hyd.qualcomm.com>
References: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
 <20260414-glymur-v1-5-7d3d1cf57b16@oss.qualcomm.com>
 <20260414063128.6ass64wfi7nmtzti@hu-mojha-hyd.qualcomm.com>
 <20260415073605.qqvpf36uhqmghg5h@hu-mojha-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415073605.qqvpf36uhqmghg5h@hu-mojha-hyd.qualcomm.com>
X-Proofpoint-ORIG-GUID: fTadWjwvCM-f9je4ktDRNrAYdAHp6045
X-Authority-Analysis: v=2.4 cv=dpfrzVg4 c=1 sm=1 tr=0 ts=69df413f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=No4tYzxTJ-fOGiIKadYA:9 a=CjuIK1q_8ugA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDA2OSBTYWx0ZWRfX/td9D1j2JGfR
 6PiRTQusg0xWlhd5gh5RE0GQycp9T4JAaDNy/4P9xy42/3Z4LKSCEX2F7J6SpZresEnh2y4lIuD
 GrMGwUu1WdqZ2iqPIRVfceob4dqlyX74pS5d4daGFYPzzG3NBUEyflGY2qZ7nVCkItGhuWzGMEA
 ZsMaXg2GEXhAwA5i99q/wip8JYHdtsH7myh/Rv2GeRYDku7zuYH7beYRDWxwsLJ8ynz/HZUvDIK
 sPSNo+pElvL0eliU9RVPTj/j3p+1FWYcAwXPB15dOg+SlZBLKGxR+crc5A26th0hOkSwGzY1xnr
 N+n2E3spXSvQ3Sk4A02wcv4YwpBFDzApGlqay3yF5P9ArS7s8lpQpW4KQPBEbgaajO9ZBcSP/I8
 M+KMxTSAxID6wXmZV8hq6CRI0lGQ2Z4uBRQYEyAlVEG34hBYm5ltmh8t+Uv71ZacJskVC8hK8LF
 I7FT7tHIhK5D71AhXjA==
X-Proofpoint-GUID: fTadWjwvCM-f9je4ktDRNrAYdAHp6045
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150069

On Wed, Apr 15, 2026 at 01:06:05PM +0530, Mukesh Ojha wrote:
> On Tue, Apr 14, 2026 at 12:01:28PM +0530, Mukesh Ojha wrote:
> > On Tue, Apr 14, 2026 at 10:30:01AM +0530, Vishnu Reddy wrote:
> > > From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > > 
> > > Most Qualcomm platforms feature a proprietary hypervisor (such as Gunyah
> > > or QHEE), which typically handles IOMMU configuration. This includes
> > > mapping memory regions and device memory resources for remote processors
> > > by intercepting qcom_scm_pas_auth_and_reset() calls. These mappings are
> > > later removed during teardown. Additionally, SHM bridge setup is required
> > > to enable memory protection for both remoteproc metadata and its memory
> > > regions.
> > > 
> > > When the hypervisor is absent, the operating system must perform these
> > > configurations instead.
> > > 
> > > Support for handling IOMMU and SHM setup in the absence of a hypervisor
> > > is now in place. Extend the Iris driver to enable this functionality on
> > > platforms where IOMMU is managed by Linux (i.e., non-Gunyah, non-QHEE).
> > > 
> > > Additionally, the Iris driver must map the firmware and its required
> > > resources to the firmware SID, which is now specified via iommu-map in
> > > the device tree.
> > > 
> > > Co-developed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> > > Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> > > Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > > Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> > > ---
> > >  drivers/media/platform/qcom/iris/iris_core.h     |  4 ++
> > >  drivers/media/platform/qcom/iris/iris_firmware.c | 71 +++++++++++++++++++++---
> > >  2 files changed, 66 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/media/platform/qcom/iris/iris_core.h b/drivers/media/platform/qcom/iris/iris_core.h
> > > index fb194c967ad4..aa7abef6f0e0 100644
> > > --- a/drivers/media/platform/qcom/iris/iris_core.h
> > > +++ b/drivers/media/platform/qcom/iris/iris_core.h
> > > @@ -34,6 +34,8 @@ enum domain_type {
> > >   * struct iris_core - holds core parameters valid for all instances
> > >   *
> > >   * @dev: reference to device structure
> > > + * @dev_fw: reference to the context bank device used for firmware load
> > > + * @ctx_fw: SCM PAS context for authenticated firmware load and shutdown
> > >   * @reg_base: IO memory base address
> > >   * @irq: iris irq
> > >   * @v4l2_dev: a holder for v4l2 device structure
> > > @@ -77,6 +79,8 @@ enum domain_type {
> > >  
> > >  struct iris_core {
> > >  	struct device				*dev;
> > > +	struct device				*dev_fw;
> > > +	struct qcom_scm_pas_context		*ctx_fw;
> > 
> > fw_dev suits better and ctx_fw is always for firmware, maybe pas_ctx is
> > better.
> > 
> > >  	void __iomem				*reg_base;
> > >  	int					irq;
> > >  	struct v4l2_device			v4l2_dev;
> > > diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/media/platform/qcom/iris/iris_firmware.c
> > > index 5f408024e967..93d77996c83f 100644
> > > --- a/drivers/media/platform/qcom/iris/iris_firmware.c
> > > +++ b/drivers/media/platform/qcom/iris/iris_firmware.c
> > > @@ -5,6 +5,7 @@
> > >  
> > >  #include <linux/firmware.h>
> > >  #include <linux/firmware/qcom/qcom_scm.h>
> > > +#include <linux/iommu.h>
> > >  #include <linux/of_address.h>
> > >  #include <linux/of_reserved_mem.h>
> > >  #include <linux/soc/qcom/mdt_loader.h>
> > > @@ -13,12 +14,15 @@
> > >  #include "iris_firmware.h"
> > >  
> > >  #define MAX_FIRMWARE_NAME_SIZE	128
> > > +#define IRIS_FW_START_ADDR	0
> > >  
> > >  static int iris_load_fw_to_memory(struct iris_core *core, const char *fw_name)
> > >  {
> > > +	struct device *dev = core->dev_fw ? core->dev_fw : core->dev;
> > >  	u32 pas_id = core->iris_platform_data->pas_id;
> > >  	const struct firmware *firmware = NULL;
> > > -	struct device *dev = core->dev;
> > > +	struct qcom_scm_pas_context *ctx_fw;
> > > +	struct iommu_domain *domain;
> > >  	struct resource res;
> > >  	phys_addr_t mem_phys;
> > >  	size_t res_size;
> > > @@ -29,13 +33,17 @@ static int iris_load_fw_to_memory(struct iris_core *core, const char *fw_name)
> > >  	if (strlen(fw_name) >= MAX_FIRMWARE_NAME_SIZE - 4)
> > >  		return -EINVAL;
> > >  
> > > -	ret = of_reserved_mem_region_to_resource(dev->of_node, 0, &res);
> > > +	ret = of_reserved_mem_region_to_resource(core->dev->of_node, 0, &res);
> > >  	if (ret)
> > >  		return ret;
> > >  
> > >  	mem_phys = res.start;
> > >  	res_size = resource_size(&res);
> > >  
> > > +	ctx_fw = devm_qcom_scm_pas_context_alloc(dev, pas_id, mem_phys, res_size);
> > > +	if (IS_ERR(ctx_fw))
> > > +		return PTR_ERR(ctx_fw);
> > > +
> > >  	ret = request_firmware(&firmware, fw_name, dev);
> > >  	if (ret)
> > >  		return ret;
> > > @@ -52,9 +60,27 @@ static int iris_load_fw_to_memory(struct iris_core *core, const char *fw_name)
> > >  		goto err_release_fw;
> > >  	}
> > >  
> > > -	ret = qcom_mdt_load(dev, firmware, fw_name,
> > > -			    pas_id, mem_virt, mem_phys, res_size, NULL);
> > > +	ctx_fw->use_tzmem = !!core->dev_fw;
> > > +	ret = qcom_mdt_pas_load(ctx_fw, firmware, fw_name, mem_virt, NULL);
> 
> We need to release the metadata because this is the change compared to
> the previous qcom_mdt_load() API, which silently released DMA memory for
> metadata in the pas_init SCM call for clients that passed metadata ctx
> as NULL. Since with this new API every new client must pass the new pas
> ctx, it cannot be NULL anymore. I intended to document this clearly when
> introducing qcom_mdt_pas_load() API, but I did not do so. but thinking
> it over again, we should not be asking client to release the memory
> which they not allocated, so let me write a patch for this where I
> client like remoteproc explicitly ask or set it if they do not want to
> release this memory as their XPU locked and can only released after auth
> and reset successful.

Just to further clarify, nothing extra related to metadata release need
to done for unaffected client like video who were passing NULL as part
of qcom_mdt_load() earlier., so no changes needed in this patch., I will
basically introduce boolean and set this only for remoteproc clients.


> 
> 
> > > +	if (ret)
> > > +
> > > +	if (ctx_fw->use_tzmem) {
> > > +		domain = iommu_get_domain_for_dev(core->dev_fw);
> > > +		if (!domain) {
> > > +			ret = -ENODEV;
> > > +			goto err_mem_unmap;
> > > +		}
> > > +
> > > +		ret = iommu_map(domain, IRIS_FW_START_ADDR, mem_phys, res_size,
> > > +				IOMMU_READ | IOMMU_WRITE | IOMMU_PRIV, GFP_KERNEL);
> > > +		if (ret)
> > > +			goto err_mem_unmap;
> > > +	}
> > >  
> > > +	core->ctx_fw = ctx_fw;
> > > +
> > > +err_mem_unmap:
> > >  	memunmap(mem_virt);
> > >  err_release_fw:
> > >  	release_firmware(firmware);
> > > @@ -62,6 +88,19 @@ static int iris_load_fw_to_memory(struct iris_core *core, const char *fw_name)
> > >  	return ret;
> > >  }
> > >  
> > > +static void iris_fw_iommu_unmap(struct iris_core *core)
> > > +{
> > > +	bool use_tzmem = core->ctx_fw->use_tzmem;
> > > +	struct iommu_domain *domain;
> > > +
> > > +	if (!use_tzmem)
> > > +		return;
> > > +
> > > +	domain = iommu_get_domain_for_dev(core->dev_fw);
> > > +	if (domain)
> > > +		iommu_unmap(domain, IRIS_FW_START_ADDR, core->ctx_fw->mem_size);
> > > +}
> > > +
> > >  int iris_fw_load(struct iris_core *core)
> > >  {
> > >  	const struct tz_cp_config *cp_config;
> > > @@ -79,10 +118,10 @@ int iris_fw_load(struct iris_core *core)
> > >  		return -ENOMEM;
> > >  	}
> > >  
> > > -	ret = qcom_scm_pas_auth_and_reset(core->iris_platform_data->pas_id);
> > > +	ret = qcom_scm_pas_prepare_and_auth_reset(core->ctx_fw);
> > >  	if (ret)  {
> > >  		dev_err(core->dev, "auth and reset failed: %d\n", ret);
> > > -		return ret;
> > > +		goto err_unmap;
> > >  	}
> > >  
> > >  	for (i = 0; i < core->iris_platform_data->tz_cp_config_data_size; i++) {
> > > @@ -93,17 +132,31 @@ int iris_fw_load(struct iris_core *core)
> > >  						     cp_config->cp_nonpixel_size);
> > >  		if (ret) {
> > >  			dev_err(core->dev, "qcom_scm_mem_protect_video_var failed: %d\n", ret);
> > > -			qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
> > > -			return ret;
> > > +			goto err_pas_shutdown;
> > >  		}
> > >  	}
> > >  
> > > +	return 0;
> > > +
> > > +err_pas_shutdown:
> > > +	qcom_scm_pas_shutdown(core->ctx_fw->pas_id);
> > > +err_unmap:
> > > +	iris_fw_iommu_unmap(core);
> > > +
> > >  	return ret;
> > >  }
> > >  
> > >  int iris_fw_unload(struct iris_core *core)
> > >  {
> > > -	return qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
> > > +	int ret;
> > > +
> > > +	ret = qcom_scm_pas_shutdown(core->ctx_fw->pas_id);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	iris_fw_iommu_unmap(core);
> > > +
> > > +	return ret;
> > >  }
> > >  
> > >  int iris_set_hw_state(struct iris_core *core, bool resume)
> > > 
> > > -- 
> > > 2.34.1
> > > 
> > 
> > -- 
> > -Mukesh Ojha
> 
> -- 
> -Mukesh Ojha

-- 
-Mukesh Ojha
