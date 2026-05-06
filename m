Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6CE1EF09B
	for <iommu@lists.linux.dev>; Wed,  6 May 2026 05:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778044903; cv=none; b=CHXeMcj9Vkby/FI7zEnunO92NQ+V2FLillNqQPWtnutosnJD0ceQkp2V49UDzAu1+708ndFyck8INdZ1jmwULvCdHWLJO6UyNL6WOy6a6RAmGC/UT3OSCoHgJ9rCGSePY4XXhCGoeFrKDh4o0aILiZ+wdJy/vMt3cYA7v45l2bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778044903; c=relaxed/simple;
	bh=Sj/Uu5RP+53mJvN5YPI+Bqc0Ki1TaGCxMvlnM8akErY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSeDuaeTk4SVTGVm03gK0/PgGEdUKtvWXJkyztZnc5QiM2aoRomljNtKvF74kA7dVK/79MwFJ8qoi6ddKl2jL7rtrOj30zgGr/Yq7s0CMQ+o9Il7HjwLPSdn9nIhJO1BuhnYXZM+XvAGCMePAGzm15i8dJ3b1EcGFASSXVjrvxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nBvF1NmG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YwfsydO0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nBvF1NmG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YwfsydO0"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6463qsMp2187057
	for <iommu@lists.linux.dev>; Wed, 6 May 2026 05:21:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=pBdh4/JvYKUMPV4XE6EJA/hH
	7ueJ2klFaJ8ONNXBNbU=; b=nBvF1NmGfNwIwP1ohqzFJH1WKXEZTQGwMsaVNLzB
	6oYB6qlIUj8c4FzXyjS74ibGUuJO0ru7hqPeCnGlqVKkYfjgzUv/84XdmS8ZTxao
	ktdasOQQQBTYYy2W0sBX7VMAgOKYujtYJrftD7itHVZTqCWZW2AonjdnJoNUoxv7
	z6vFYK97VDitmhEwUBZ8vW0EUsEfe1nqRkhpRYcT+63rWgffpPoP8wR96fMPrkfL
	PdIz9cn/XxicoIlkzoe5wrCgySytujOGxCgQAyGyhpiYGwiK9oCVoNagbFifDm0I
	N7u27EPH4uJjRIfXlg9sjt/7NHS92QxhfgeQUnG3tW5dsQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dygce3j98-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 06 May 2026 05:21:39 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ba718173d1so17245555ad.0
        for <iommu@lists.linux.dev>; Tue, 05 May 2026 22:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778044899; x=1778649699; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pBdh4/JvYKUMPV4XE6EJA/hH7ueJ2klFaJ8ONNXBNbU=;
        b=YwfsydO0uQnzrBe7XOJEA28JTYx9tM9iUBNZti+EdBDL9W0tGOC98M5ALwqDCsrKFr
         wLK8X/EvRA3qek0LVCsoyltatvQC30jQ+JGcTlMs0nrLf4Z1JSomUmhlLblMcwDjGX3i
         YZ9x71SV40UeRyQspbrSDO/FfwFs8shZLajBhuPfHVldYlPwgRhZnNvClst52hhenjg6
         l5R7yH9p00mTUXKCSdujhR8ZbE31SdlUKh9f/OB2EU7KE5CZjRUyVSNoybQyCAb18Fh8
         MpmcInrRLlu2/CaWnGVi15+W4lXEDZGWfMKkeAGJjNyismZvkcIOxhKWJYhEIdu/qJQv
         FYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778044899; x=1778649699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pBdh4/JvYKUMPV4XE6EJA/hH7ueJ2klFaJ8ONNXBNbU=;
        b=kNpWwidNW/O6fsPvKOz4hQr3N+zK8ptl8qmm91rpT2LuJdPcrt1VhEVglHFu/vFcsh
         8pB0UPDNFHnfPdbgp4o21tjaayNuyIxs2/pQ4MeKFbCDj2EA5jD/vpnZTNtXAeewpACe
         G1qvTKw02p67UVmNgYQYy5pQN26Ye41cvCYEYdC0W2C2IcHyip6MwNFg1hXaahyDusXh
         o7z8IF+DTK0JZWmpP0obJcWQtDUASh/NIZvRNSO+gc5n2+2yShmbH0lSMQrNR3Bbmq7f
         ddqVrI/a7XNMNPMUuzH/aSBXiDgVgMDwi6UEII/7GG2/hBk9Axg2TlnIu+DepNzq42Mx
         9nag==
X-Forwarded-Encrypted: i=1; AFNElJ/hdTGRlprCFUU7JHtrXW/JNxHv7yZmLBDEegUsJ3SUiyRHk+I3TDXC+3YKvxdHxDEQ8d4ihA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0EiUtxJe4w///IhkypOiOQpepi+4ecqIUwcZwI4ws1U9uymeg
	IO4teaSPobii9qlYAiCI7W//7bYQiFIGAklTcmE9FVimkaejV/tRoWpQ6IU71TUCgIefns1PCwt
	l7UwDW4pPgbaryBGAs9wHALAXNY2MXoV5ifuKsGRr8h2BzjpQH60vs/mSqA==
X-Gm-Gg: AeBDiesV9b7zdvkJasNhIadZSHkQV3KvRCCXP1RMdAliE88TROPzs9nA0NWhhIzGGT5
	JoaLUdsSqfJ+yj8fblVY+KXdGPtrL/x6EXeNNXN8NrlF0PMhiVPU5mEMaVjIa8phmv/WPy7XJdo
	ZLHyfcSFqXdACm/bKDEvpm9Jh6p7T/y8ihzTsz5c1XITHSiFO3AskvHIGcLNyslTXvWA0XA5D/F
	czI0oNsIFM0ys3EvNlCav+6yyU3WL2JbQmphmN4j51gWoJoKD2Br4L0Cd+eJov13be17YwtQZYI
	MgDrdxTvEyEuMQYA9Sb9cGxbATHme0VJqQ1lj6x5bUqiGdQo7W/E3ZuW2mAiKHO8MaG1u1PK4Ng
	Uq6VMNiPL1jU7o9g6wWmS0REzg6vViHOuyUkT8O8OND3AaQpTtzxF2JRiig0=
X-Received: by 2002:a17:903:1b10:b0:2b0:bebb:1081 with SMTP id d9443c01a7336-2ba7a20ce22mr17270355ad.28.1778044899064;
        Tue, 05 May 2026 22:21:39 -0700 (PDT)
X-Received: by 2002:a17:903:1b10:b0:2b0:bebb:1081 with SMTP id d9443c01a7336-2ba7a20ce22mr17269975ad.28.1778044898470;
        Tue, 05 May 2026 22:21:38 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba7ca3bff3sm10280225ad.84.2026.05.05.22.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 22:21:38 -0700 (PDT)
Date: Wed, 6 May 2026 10:51:29 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH v4 07/13] media: iris: Enable Secure PAS support with
 IOMMU managed by Linux
Message-ID: <20260506052129.4kahdrcxxrvl53hy@hu-mojha-hyd.qualcomm.com>
References: <20260505-glymur-v4-0-17571dbd1caa@oss.qualcomm.com>
 <20260505-glymur-v4-7-17571dbd1caa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505-glymur-v4-7-17571dbd1caa@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDA1MCBTYWx0ZWRfX9g3YbhHbZ6fy
 TdMg7jbYHdFtOkxnfbZG3HBReGk1gagpumW5JWDh25/JH/DPfMbhqH3nrL2N2GhM5am47tGQVA4
 vRxX1CODctug7potXZ1B88jFR0/HeCkiuP4f1rBhzNVFUL9r85YAuHCtjw3OQHPGfAiNzlYzomF
 iB1/E3++qEMlOZhUbAFrEQ8Dbyxm+ytDAxX89tyqb45X7tWxOzmPyZ66JcmN8AH4lpGCqyiU5hW
 XBYpfOr3A6sXtirtG3ce6edtYj6LvESR2TXFftmZe15XJPIP4pu/kbAfcy3lizDhkiC20ivuz1f
 oh/IDSveUifLkHS7fRj6SWC97SQ+r4QBJC1bgPAMW/qTbB6ZTaJ7z4sNkflB30V58/Cf5w0jyTy
 8VDlTE93ep4LZS+Kl4dNcr7+DntxI/Esx6ji+HM0v461UK+kk+PYMnPKKhU5ZJ3VyXxZZOa4TxZ
 n1gj0kEcs1YqqjnFV6w==
X-Proofpoint-GUID: d5wi7fy0U3b91DTiSBdgyvZsKnSPSn27
X-Proofpoint-ORIG-GUID: d5wi7fy0U3b91DTiSBdgyvZsKnSPSn27
X-Authority-Analysis: v=2.4 cv=b6KCJNGx c=1 sm=1 tr=0 ts=69facfe3 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=kdmdhyyA-vVXd4KnKA0A:9 a=CjuIK1q_8ugA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060050

On Tue, May 05, 2026 at 12:29:28PM +0530, Vishnu Reddy wrote:
> From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> 
> Most Qualcomm platforms feature a proprietary hypervisor (such as Gunyah
> or QHEE), which typically handles IOMMU configuration. This includes
> mapping memory regions and device memory resources for remote processors
> by intercepting qcom_scm_pas_auth_and_reset() calls. These mappings are
> later removed during teardown. Additionally, SHM bridge setup is required
> to enable memory protection for both remoteproc metadata and its memory
> regions.
> 
> When the hypervisor is absent, the operating system must perform these
> configurations instead.
> 
> Support for handling IOMMU and SHM setup in the absence of a hypervisor
> is now in place. Extend the Iris driver to enable this functionality on
> platforms where IOMMU is managed by Linux (i.e., non-Gunyah, non-QHEE).
> 
> Additionally, the Iris driver must map the firmware and its required
> resources to the firmware SID, which is now specified via iommu-map in
> the device tree.
> 
> Co-developed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>

I have posted https://lore.kernel.org/lkml/20260506050107.1985033-1-mukesh.ojha@oss.qualcomm.com/#r
for resource table extraction and the API to map and unmap and now you
can use the api similar to below
https://lore.kernel.org/lkml/20250819165447.4149674-12-mukesh.ojha@oss.qualcomm.com/

> ---
>  drivers/media/platform/qcom/iris/iris_core.h     |  4 ++
>  drivers/media/platform/qcom/iris/iris_firmware.c | 72 ++++++++++++++++++++----
>  2 files changed, 66 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_core.h b/drivers/media/platform/qcom/iris/iris_core.h
> index fb194c967ad4..b396c8cf595e 100644
> --- a/drivers/media/platform/qcom/iris/iris_core.h
> +++ b/drivers/media/platform/qcom/iris/iris_core.h
> @@ -34,6 +34,8 @@ enum domain_type {
>   * struct iris_core - holds core parameters valid for all instances
>   *
>   * @dev: reference to device structure
> + * @fw_dev: reference to the context bank device used for firmware load
> + * @pas_ctx: SCM PAS context for authenticated firmware load and shutdown
>   * @reg_base: IO memory base address
>   * @irq: iris irq
>   * @v4l2_dev: a holder for v4l2 device structure
> @@ -77,6 +79,8 @@ enum domain_type {
>  
>  struct iris_core {
>  	struct device				*dev;
> +	struct device				*fw_dev;
> +	struct qcom_scm_pas_context		*pas_ctx;
>  	void __iomem				*reg_base;
>  	int					irq;
>  	struct v4l2_device			v4l2_dev;
> diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/media/platform/qcom/iris/iris_firmware.c
> index 5f408024e967..0085dd7ec052 100644
> --- a/drivers/media/platform/qcom/iris/iris_firmware.c
> +++ b/drivers/media/platform/qcom/iris/iris_firmware.c
> @@ -5,6 +5,7 @@
>  
>  #include <linux/firmware.h>
>  #include <linux/firmware/qcom/qcom_scm.h>
> +#include <linux/iommu.h>
>  #include <linux/of_address.h>
>  #include <linux/of_reserved_mem.h>
>  #include <linux/soc/qcom/mdt_loader.h>
> @@ -13,12 +14,15 @@
>  #include "iris_firmware.h"
>  
>  #define MAX_FIRMWARE_NAME_SIZE	128
> +#define IRIS_FW_START_ADDR	0
>  
>  static int iris_load_fw_to_memory(struct iris_core *core, const char *fw_name)
>  {
> +	struct device *fw_dev = core->fw_dev ? core->fw_dev : core->dev;
>  	u32 pas_id = core->iris_platform_data->pas_id;
>  	const struct firmware *firmware = NULL;
> -	struct device *dev = core->dev;
> +	struct qcom_scm_pas_context *pas_ctx;
> +	struct iommu_domain *domain;
>  	struct resource res;
>  	phys_addr_t mem_phys;
>  	size_t res_size;
> @@ -29,14 +33,18 @@ static int iris_load_fw_to_memory(struct iris_core *core, const char *fw_name)
>  	if (strlen(fw_name) >= MAX_FIRMWARE_NAME_SIZE - 4)
>  		return -EINVAL;
>  
> -	ret = of_reserved_mem_region_to_resource(dev->of_node, 0, &res);
> +	ret = of_reserved_mem_region_to_resource(core->dev->of_node, 0, &res);
>  	if (ret)
>  		return ret;
>  
>  	mem_phys = res.start;
>  	res_size = resource_size(&res);
>  
> -	ret = request_firmware(&firmware, fw_name, dev);
> +	pas_ctx = devm_qcom_scm_pas_context_alloc(fw_dev, pas_id, mem_phys, res_size);
> +	if (IS_ERR(pas_ctx))
> +		return PTR_ERR(pas_ctx);
> +
> +	ret = request_firmware(&firmware, fw_name, fw_dev);
>  	if (ret)
>  		return ret;
>  
> @@ -52,9 +60,27 @@ static int iris_load_fw_to_memory(struct iris_core *core, const char *fw_name)
>  		goto err_release_fw;
>  	}
>  
> -	ret = qcom_mdt_load(dev, firmware, fw_name,
> -			    pas_id, mem_virt, mem_phys, res_size, NULL);
> +	pas_ctx->use_tzmem = !!core->fw_dev;
> +	ret = qcom_mdt_pas_load(pas_ctx, firmware, fw_name, mem_virt, NULL);
> +	if (ret)
> +		goto err_mem_unmap;
> +
> +	if (pas_ctx->use_tzmem) {
> +		domain = iommu_get_domain_for_dev(fw_dev);
> +		if (!domain) {
> +			ret = -ENODEV;
> +			goto err_mem_unmap;
> +		}
> +
> +		ret = iommu_map(domain, IRIS_FW_START_ADDR, mem_phys, res_size,
> +				IOMMU_READ | IOMMU_WRITE | IOMMU_PRIV, GFP_KERNEL);
> +		if (ret)
> +			goto err_mem_unmap;
> +	}
>  
> +	core->pas_ctx = pas_ctx;
> +
> +err_mem_unmap:
>  	memunmap(mem_virt);
>  err_release_fw:
>  	release_firmware(firmware);
> @@ -62,6 +88,18 @@ static int iris_load_fw_to_memory(struct iris_core *core, const char *fw_name)
>  	return ret;
>  }
>  
> +static void iris_fw_iommu_unmap(struct iris_core *core)
> +{
> +	struct iommu_domain *domain;
> +
> +	if (!core->pas_ctx->use_tzmem)
> +		return;
> +
> +	domain = iommu_get_domain_for_dev(core->fw_dev);
> +	if (domain)
> +		iommu_unmap(domain, IRIS_FW_START_ADDR, core->pas_ctx->mem_size);
> +}
> +
>  int iris_fw_load(struct iris_core *core)
>  {
>  	const struct tz_cp_config *cp_config;
> @@ -79,10 +117,10 @@ int iris_fw_load(struct iris_core *core)
>  		return -ENOMEM;
>  	}
>  
> -	ret = qcom_scm_pas_auth_and_reset(core->iris_platform_data->pas_id);
> +	ret = qcom_scm_pas_prepare_and_auth_reset(core->pas_ctx);
>  	if (ret)  {
>  		dev_err(core->dev, "auth and reset failed: %d\n", ret);
> -		return ret;
> +		goto err_unmap;
>  	}
>  
>  	for (i = 0; i < core->iris_platform_data->tz_cp_config_data_size; i++) {
> @@ -93,17 +131,31 @@ int iris_fw_load(struct iris_core *core)
>  						     cp_config->cp_nonpixel_size);
>  		if (ret) {
>  			dev_err(core->dev, "qcom_scm_mem_protect_video_var failed: %d\n", ret);
> -			qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
> -			return ret;
> +			goto err_pas_shutdown;
>  		}
>  	}
>  
> +	return 0;
> +
> +err_pas_shutdown:
> +	qcom_scm_pas_shutdown(core->pas_ctx->pas_id);
> +err_unmap:
> +	iris_fw_iommu_unmap(core);
> +
>  	return ret;
>  }
>  
>  int iris_fw_unload(struct iris_core *core)
>  {
> -	return qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
> +	int ret;
> +
> +	ret = qcom_scm_pas_shutdown(core->pas_ctx->pas_id);
> +	if (ret)
> +		return ret;
> +
> +	iris_fw_iommu_unmap(core);
> +
> +	return ret;
>  }
>  
>  int iris_set_hw_state(struct iris_core *core, bool resume)
> 
> -- 
> 2.34.1
> 

-- 
-Mukesh Ojha
