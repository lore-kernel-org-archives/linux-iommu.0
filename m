Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2EF18027
	for <iommu@lists.linux.dev>; Fri, 21 Nov 2025 05:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763704457; cv=none; b=CSSTqyMo3l1n2eSeelNNQiDpSG2CMFfM5K6NzywoBYNAmaZDmp/FUAougdYDBZgD2qpCLVjirz4vdXutPP+F7Fneb7Yz7hMh+dJUdyggJLCKG9aYEUFheSyT/jskagB90Gzzn/b088Upma/KB2y5IyLKCPC4M2H9HpgGaYWLJTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763704457; c=relaxed/simple;
	bh=9X7SGMHwfdDaWhwvXtLbh75M2VDciXVe/v3T1Ye8Feg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BWgkT1b9UjR0BePw/hcpKIGxBDjLus84947QB/SoEHiI8q6wEeFsbnk3klvA7R2fIzqxF4fWZj/roMA9/UM4TEvIZON5mDYdiho7+6eWvqrS9bJdWYKQ325qTZWwBSy+CuYyrmRXiI4YjV4Vni8cOEr8ISBGOY5SwaYDRDIAjcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ceE3PBkm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e6jXM9SI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ceE3PBkm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e6jXM9SI"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AKKAW9f1337397
	for <iommu@lists.linux.dev>; Fri, 21 Nov 2025 05:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N6dOCQqfdW5KBZlnKBU27Ab7elxXmhCesDUpJ2r5DSo=; b=ceE3PBkmZb9rZf/G
	Eh5V/Iw9nXbMmwu5exIi5iOMpWeDfSfWp0j8SfLUAPgkrgAx514lYGZC2HCq+eeA
	cuV5fOyuuXc8QZ4M5zzAHZQTDPc7vcMaEc38BscDg2l/HvLpR0Sq0UER+XRKfitt
	HHS3PiLE+uPZ7QC+ZahFPHKiha/zcMa2RVSOD99sVqFfHYJJA5kyKW1D48W/SOta
	+JbjCPbQuQ5yQPCr4bYwRkBLJIs+9AEJphvYiCnpN5FaH1n0tO8mYJthWfTyNNK3
	vOvTAffhJHL5QKYosetblMd0CTKUxecgRyjMxd7O0OZriGmi4YXu9DNZ5wXLb6lc
	QqehvA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aj5y7t7j4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 21 Nov 2025 05:54:14 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-343fb64cea6so4539025a91.3
        for <iommu@lists.linux.dev>; Thu, 20 Nov 2025 21:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763704454; x=1764309254; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N6dOCQqfdW5KBZlnKBU27Ab7elxXmhCesDUpJ2r5DSo=;
        b=e6jXM9SIjoI68Yxlht5v0UenPGY6SkFq3hU3VsKUWWGzLcApV986VSIJuDOblgO8Ei
         8qPyA8xc0TaY8kRHyAbRoIZQ6cgE99k4roximSmI2eimfokujUkVc3IwjLvlv4YxWZ8A
         rTUd9PCSnPBT1yfZEiQHxQ1dm6scyhUWAk4AImPHhLcgxc9ugoF4EL+7ZZKNKT9f+Cr0
         MGpritUJ7nA6eGeWri83iJMcptvhDORWx+Yj+GNm7jsztPSPsyY0r6++tqnZ1zFilARW
         WCoOgYopOWZwVsgchvl5wndM9fSjxMcK8jBLkG9HdvbS1T8h8V30k2hkjX/GIWE7rGVP
         Z8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763704454; x=1764309254;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N6dOCQqfdW5KBZlnKBU27Ab7elxXmhCesDUpJ2r5DSo=;
        b=HrO+G9Noo+JSbi7Mo4Pi91vOzRMAuAwgHCbJl3TShI098wmQ2qj4ofafcQ5egrR3Me
         E0M2CAqasfkZWdJBkrFj5KkL0I92G2IJFmtWOpJp3iVLENfg46mX5iGjAegm8Dc4KQSa
         KVi57FuHBBHLSbXCdgNCnp5SntIS0XQAwiaR77oJSQyYSYzUKZ5iJTHd6P61zC4HFfn/
         1hAkE12ADs7Spgv4FlGJkk5VIUlJtNMAx5SsPKhPBseglYDGoJ1tFAKJgnDOdmGwJ00W
         ohpmoBuXNfjgNB2i6xPCARJv4SJ/2SEHTzIcwlnZQzTqLaGSnYminS/mkgyQF/NTWaRZ
         87zg==
X-Gm-Message-State: AOJu0YxE0euAfRkhK20A7VFfg80UvkWiss2FimeTagqKDfKmb66dsmLm
	mk5A3wk1ODVB5QW5PflScUEfAc/iWBc+rTmQOFDLxzxt17UIwXgyJgte2O+QxTwZ1U8nCdg9ndB
	OWY9nR23tzlcexsDQrZLIUfdL3lUsX/c5E8W30PBK7lc+414G+e3YwjKUHQ==
X-Gm-Gg: ASbGnctLf/h2XpmGO+gE25/t/2Qw2SGTZfbGyw9jIAdqo77GOAJGMm12sArKCWqUhkU
	snUrdrCTOcDNIH5Zd93B1yGFCbCd6YxB8lZGy19iP2HoLTLrZNa8VqEr1RFEK9n1mV4DZcg8+QN
	nQMLRlhX9oX3WVQIxiF8fTNWKO23vNbL3Ihv7mR8y3km2nkcdRghuthJ0GDmP0BAYir61etEx+i
	AQVFZKHL70fDZhll7ACR5dvIWXZpJRGIaIAgUrZYJcno2nxO3K5ezjY9cGaubAtNr4ZUfq02DGP
	EEQzcEwgkWxTqnFPGAOSoXgACgU88f1+HjybjxhYKE9CdXK+HkdGURH77bDOeInQ4FGfZ+FNUpM
	84I1iw5l9uIFUd5L3xlVcVUMQrTUXSZgjVlQS1w==
X-Received: by 2002:a17:90b:5628:b0:343:c3d1:8b9b with SMTP id 98e67ed59e1d1-34733ef6e38mr1383760a91.19.1763704453573;
        Thu, 20 Nov 2025 21:54:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwFVp4n8DLtVSs2NpiwUJjr9aSWGASQp3L4CiV2L5WMRYOJJ/h7lxIzbBv54uqkg1bG2wHXw==
X-Received: by 2002:a17:90b:5628:b0:343:c3d1:8b9b with SMTP id 98e67ed59e1d1-34733ef6e38mr1383735a91.19.1763704453016;
        Thu, 20 Nov 2025 21:54:13 -0800 (PST)
Received: from [10.219.56.14] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345b0202b16sm5993512a91.2.2025.11.20.21.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 21:54:12 -0800 (PST)
Message-ID: <74c2bdbe-1346-4229-b9dd-694b3063b1bb@oss.qualcomm.com>
Date: Fri, 21 Nov 2025 11:24:07 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] of: iommu-map parsing for multi-cell IOMMU
From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
To: Robin Murphy <robin.murphy@arm.com>, will@kernel.org, joro@8bytes.org,
        robh@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        konrad.dybcio@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com,
        bod@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
        saravanak@google.com, prakash.gupta@oss.qualcomm.com,
        vikash.garodia@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <cover.1762235099.git.charan.kalla@oss.qualcomm.com>
 <0319bdf5-0a46-40fc-93f8-30d74cf6475a@arm.com>
 <351373ed-c699-4945-a978-cb35412918bc@oss.qualcomm.com>
 <e6fb7000-7aac-45b6-b4f9-c9efa2a98d57@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <e6fb7000-7aac-45b6-b4f9-c9efa2a98d57@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=QMxlhwLL c=1 sm=1 tr=0 ts=691ffe86 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=Nc0QaR6EQMpeMu4v8QIA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: tSy7Ivo-9_Q2NdEtWSqKkrxD-ETBAE3O
X-Proofpoint-ORIG-GUID: tSy7Ivo-9_Q2NdEtWSqKkrxD-ETBAE3O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA0NCBTYWx0ZWRfX/BlCAnd6s6Fw
 NSQ1ayppgS+y+ZLX+mu/EluNUv1M5aKGNfMXWxw9JYSb1xKxS8XnxiOMd3PkRmyp39ZMGP5LFC4
 e/+m8KNTMzUsOLBkW48k3+X5tdBMdvuigG3xyXMRBCUf7C/AMVXC/juque6pkF0fH4wsplyWUAh
 gU59N3MRaWLGu02W32uH+rKEalJ0ya4l3sZTDIp/ElbgFHM7ogx3LesMHEBHUs2u0v7XtXqPHm7
 efLh0TZ8GdOnlABYsqC1sWrfJDXCGUuIGFvJVXi/U1jY7k4gRmlu47pqGUPH3XZpFxsIuaut+Wz
 +q+V4gqce4aOK+ytUMHBYhoplt/QwHNBE3jT6SSN8evmwBagwGFwSVTtKjbZ9I0DM3EGpqN8q+e
 FZJUwJ+vdYZhb2lI6FvbpLMI8t+5Gw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_02,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511210044


On 11/12/2025 8:12 PM, Charan Teja Kalla wrote:
> Hi Robin,
> 
> Don't want to bother you with my ideas, but I can't think of other ways 
> to handle such cases of multi-map than the below. I just tried this code on 
> Qemu on top of your patches(with some nit compilation fixes) and just checked
> if devices are added to the iommu groups.
> 

Hello Robin,
Not sure If this is early to ask for feedback, but waiting for your
valuable inputs here.  Thanks in advance.

> ----------------------8888---------------------------------------------
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index a511ecf21fcd..ac005e70de7d 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -16,6 +16,7 @@
>  #include <linux/pci.h>
>  #include <linux/slab.h>
>  #include <linux/fsl/mc.h>
> +#include <linux/platform_device.h>
>  
>  #include "iommu-priv.h"
>  
> @@ -41,6 +42,18 @@ static int of_iommu_xlate(struct device *dev,
>  	return ret;
>  }
>  
> +static int of_iommu_configure_cb(void *arg, u32 *id_out)
> +{
> +	struct of_phandle_args *iommu_spec =
> +		(struct of_phandle_args *)((void *)id_out - offsetof(struct of_phandle_args, args));
> +	struct device *dev = arg;
> +	int err;
> +
> +	err = of_iommu_xlate(dev, iommu_spec);
> +	of_node_put(iommu_spec->np);
> +	return err;
> +}
> +
>  static int of_iommu_configure_dev_id(struct device_node *master_np,
>  				     struct device *dev,
>  				     const u32 *id)
> @@ -48,12 +61,10 @@ static int of_iommu_configure_dev_id(struct device_node *master_np,
>  	struct of_phandle_args iommu_spec = { .args_count = 1 };
>  	int err;
>  
> -	err = of_map_iommu_id(master_np, *id, &iommu_spec.np, iommu_spec.args);
> +	err = of_map_iommu_id(master_np, *id, &iommu_spec.np, iommu_spec.args,
> +			dev_is_platform(dev) ? true : false, dev, of_iommu_configure_cb);
> - 	if (err)
> - 		return err;
> -
> -	err = of_iommu_xlate(dev, &iommu_spec);
> -	of_node_put(iommu_spec.np);
>  	return err;
>  }
>  
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index a4fd4a4f720b..8abe36c17309 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -2085,16 +2085,21 @@ static bool of_check_bad_map(const __be32 *map, int len)
>   */
>  int of_map_id(const struct device_node *np, u32 id, const char *map_name,
>  	      const char *cells_name, const char *map_mask_name,
> -	      struct device_node **target, u32 *id_out)
> +	      struct device_node **target, u32 *id_out, bool multi_map,
> +	      void *arg, of_map_id_cb cb)
>  {
>  	u32 map_mask, masked_id;
>  	int map_bytes, map_len, offset = 0;
>  	bool bad_map = false;
>  	const __be32 *map = NULL;
> +	bool mapped_multi_id = false;
>  
>  	if (!np || !map_name || !cells_name || (!target && !id_out))
>  		return -EINVAL;
>  
> +	if (multi_map && !cb)
> +		return -EINVAL;
> +
>  	map = of_get_property(np, map_name, &map_bytes);
>  	if (!map) {
>  		if (target)
> @@ -2189,16 +2194,29 @@ int of_map_id(const struct device_node *np, u32 id, const char *map_name,
>  		pr_debug("%pOF: %s, using mask %08x, id-base: %08x, out-base: %08x, length: %08x, id: %08x -> %08x\n",
>  			np, map_name, map_mask, id_base, be32_to_cpup(out_base),
>  			id_len, id, id_off + be32_to_cpup(out_base));
> -		return 0;
> +
> +		if (multi_map) {
> +			if (cb(arg, id_out))
> +				return -EINVAL;
> +
> +			mapped_multi_id = true;
> +			continue;
> +		}
> +
> +		goto translated;
>  	}
>  
> +	if (mapped_multi_id)
> +		return 0;
> +
>  	pr_info("%pOF: no %s translation for id 0x%x on %pOF\n", np, map_name,
>  		id, target && *target ? *target : NULL);
>  
>  	/* Bypasses translation */
>  	if (id_out)
>  		*id_out = id;
> -	return 0;
> +translated:
> +	return cb ? cb(arg, id_out) : 0;
>  
>  err_map_len:
>  	pr_err("%pOF: Error: Bad %s length: %d\n", np, map_name, map_bytes);
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 183be897b088..84a24c2a1041 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -24,6 +24,7 @@
>  
>  typedef u32 phandle;
>  typedef u32 ihandle;
> +typedef int (*of_map_id_cb)(void *arg, u32 *id_out);
>  
>  struct property {
>  	char	*name;
> @@ -458,7 +459,8 @@ bool of_console_check(const struct device_node *dn, char *name, int index);
>  
>  int of_map_id(const struct device_node *np, u32 id, const char *map_name,
>  	      const char *cells_name, const char *map_mask_name,
> -	      struct device_node **target, u32 *id_out);
> +	      struct device_node **target, u32 *id_out,
> +	      bool multi_map, void *arg, of_map_id_cb cb);
>  
>  phys_addr_t of_dma_get_max_cpu_address(struct device_node *np);
>  
> @@ -1436,17 +1438,18 @@ static inline int of_property_read_s32(const struct device_node *np,
>  }
>  
>  static inline int of_map_iommu_id(const struct device_node *np, u32 id,
> -				  struct device_node **target, u32 *id_out)
> +				  struct device_node **target, u32 *id_out,
> +				  bool multi_map, void *arg, of_map_id_cb cb)
>  {
>  	return of_map_id(np, id, "iommu-map", "#iommu-cells", "iommu-map-mask",
> -			 target, id_out);
> +			 target, id_out, multi_map, arg, cb);
>  }
>  
>  static inline int of_map_msi_id(const struct device_node *np, u32 id,
>  				struct device_node **target, u32 *id_out)
>  {
>  	return of_map_id(np, id, "msi-map", "#msi-cells", "msi-map-mask",
> -			 target, id_out);
> +			 target, id_out, false, NULL, NULL);
>  }
>  
>  #define of_for_each_phandle(it, err, np, ln, cn, cc)			
> -----------------------------------------------------------------------
> 
> full patch is at: https://github.com/charan-kalla-oss/linux-next/commits/refs/for/iommu_map

