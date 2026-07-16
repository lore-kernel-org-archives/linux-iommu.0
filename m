Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9963B3C13
	for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 07:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784186861; cv=none; b=QCYMwnN0hP6zZZM0Ao+JzfMyrAS31r/VhUoIlUBAiUVb+075gc6K/TrwVUY8z7YzKBm2lIsJrgHT0qYJInPwFXArQczjjHJES0AZHZFbq6AtzvIijOw5YKgnciFCymXegPTpNyKWNqv3NdYNkyMfcE2mtcbCpmqpgnq/c/e41YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784186861; c=relaxed/simple;
	bh=AKpy4pnIDwSZQN/myaZIK15rW6VRJX80vHJ1H8+v1ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvZiwCEad9zuviU8s7QyLnRJ2yP7yRFKwNTjcNLTFjRtK58Vi6mTPboBMUJThhghz7uK13anKtjhY4bkzUtBDMCSLWN/Aqllh0MwcipeDeNh4QjfH9eV3wR+MjOdgupbOCGWh91hPQYaH9sahkgBo7nIcSiqptJe5bVUjJ9XN3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XX/m6RZe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EfxBP6/Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XX/m6RZe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EfxBP6/Z"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G7DsjP2048849
	for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 07:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Bx9Xs0p7V4nn88GnuV9d3SGR
	DdrnnmJ7s4DaIuEh7P0=; b=XX/m6RZeFQsgLhOnR0lybETLbDxpJzgBK3zY05Gq
	uDQyKM4T5GDvl0gJvAmu4h9lc3cvXOWxYwRMkfClWsR7GzUcvc7FQzwMtp2BeCzM
	5laO9EXvfmemFPz//MQtzvXY0rc76ErRpE5KsUFu/g8FM4fj68EUiek/0IkwyRya
	kqzO1lw/1kcESVSDw6oxHxbBpyrOQsrg2L7UAbKNPbDs+TJae+DQgxKmy87g7yAB
	FlhvjPDufVyN8mhqhVVvKsEYSix5lqxBrV+saIC8P9jqHh75qw51lBikGIABwh6j
	Za1Add4icEEb/KR3s4kMzczxS+NyEBGh2227Dk3koPxbQQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feayfkrtc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 07:27:35 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-380b630c505so7791002a91.1
        for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 00:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784186855; x=1784791655; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bx9Xs0p7V4nn88GnuV9d3SGRDdrnnmJ7s4DaIuEh7P0=;
        b=EfxBP6/Zy9DluXHLzAAZvVvhHkNCuXg/STz75Mfye+QuV2cZHimj2z5ug6BjYsr4tO
         MVASYgsrybXgwsE59KMDRqiJiQKV+ravnHRMVdjIIL4f2Yzspwd2sXk5EMbT4cviVYcr
         AmPMt0oMSImgMbUia2nLTHyPmCku1dczl00dXRqert8FF6Psv8amrjby+f3iMgo6N0Py
         DIAVBIFj8CP5WzDvE4HQOHylzEowU+GE0VaIphbbNusaE8Vi0MGQe8VPwtdc+kbpmWJN
         gSyx9h71FHrCvI36+NXquBtooIQWDNFpu+M17GXB6A8QVDwpjOixE3i93wg6aG0zGMBz
         weVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784186855; x=1784791655;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bx9Xs0p7V4nn88GnuV9d3SGRDdrnnmJ7s4DaIuEh7P0=;
        b=TUtPHAUG7r6+Cw0K50sWxlnQ4+8YpIQT0mAy8g3d0H2eyTvx+dgsF6IO7qEVj9TcjM
         3RW97Lmyv0dR6Oo217BkN8TP8JVHbrMZXZNjdGygzNd90EMJUWEths48RDiBIeRgpAzU
         5dID+oQuklhAeGF5cr+nUdmNg7CTZWgxlUJYafSfdnCQzoyeNuu1wwubEIJuXE8juubc
         qE7jpQ4tQy3ZsQlxBq5yK4z+0U9kBqOt8FP+B6HvQEq39ARdtn3j+kdzgjg9RIok6472
         DZstnrmlU6M6tMYzuh06pgqTnqbLpfPIKIHy3Fe+dkutFQHZDhWwjfzttXDje2oFmnS0
         SFcQ==
X-Forwarded-Encrypted: i=1; AHgh+RrKep00rH8CgyUf6SgJua3k1vtMvSx3Se/h9LFtBC55tXf3sw7aOmlmRSy3AMU1j9lbg+vmBw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/N3y2KstklMpgqgNRdZonUp5fsi+vUK53qhA+CHiSSbs/ll/y
	1/sOmF8LtgRh7BdF8ix+6dPLOOoKrv5bV3TpMSa8ZdSksKpGwdG8nQ6rnBXhhjs6rd2GaxUqrrW
	Kmqq98i0YBIbz42zQXN1BTfkgYRVYdk1SENXzO9zeXDLluGaVC+wfep93lQ==
X-Gm-Gg: AfdE7cmW1vsiqXQiAx+8OaLYbcohEPNbex9XhlqTxPk3tCMX6pDjteQh+ir5ZnpirVT
	NmscFyYCauvTJ3M3MbgTiEOc1wqtJUDvM3TecaZ2kPg95JKxVFOEZrM7JZP/TD2/q8IZ+7tRlKb
	UbJKQoPawCeI6MGPWDcohwLlLMFDm3W530qZsIjL4uCivTBvorJvQW7RJ4Iu1rKGpWQveaf/p3a
	/b3FZkR65R0g0wlmnCZPuu6Rq+4Lrbf3nHz7VQ0m+CRYFT4ZrF382Zfi4KnxiQP+PadtVvQT4LH
	qJ02+9bgIEthZDLIBS2Xwwt5uwkx4jrxKZh2KXlhPQhpD2TpiEziSnHSNgZuSQAxV6/an7VqqtE
	PtkT9vmLlQ5ICyDXm7ZmQBeBrgVo=
X-Received: by 2002:a17:90b:4a4a:b0:37c:18e0:90dc with SMTP id 98e67ed59e1d1-38e1ae31638mr7365595a91.16.1784186854610;
        Thu, 16 Jul 2026 00:27:34 -0700 (PDT)
X-Received: by 2002:a17:90b:4a4a:b0:37c:18e0:90dc with SMTP id 98e67ed59e1d1-38e1ae31638mr7365580a91.16.1784186853996;
        Thu, 16 Jul 2026 00:27:33 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e6f0fcdsm8559669eec.30.2026.07.16.00.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 00:27:33 -0700 (PDT)
Date: Thu, 16 Jul 2026 12:57:26 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Weimin Xiong <xiongwm2026@163.com>
Cc: robin.clark@oss.qualcomm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] iommu/msm: unwind probe state on registration failure
Message-ID: <20260716072726.njo62a2xbaum43u5@hu-mojha-hyd.qualcomm.com>
References: <20260716013229.91014-1-xiongwm2026@163.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716013229.91014-1-xiongwm2026@163.com>
X-Proofpoint-GUID: RSxzqwe8F-aXPzTNDLZpMxP0cPHSFj8s
X-Authority-Analysis: v=2.4 cv=WoMb99fv c=1 sm=1 tr=0 ts=6a5887e7 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8 a=a8LOBI3GJTFK-6nigkEA:9 a=CjuIK1q_8ugA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA3NCBTYWx0ZWRfX/BU2ApO22Pwb
 8THsAH9i73zjoqhjBLYPpRiEMsp9M7Cp0t/I7s/ciH+zV+dk98adiLF0nSoMq2ljkk1dUnuw70B
 713xZiEr3N2bmRcwhD/LWkcjMn95rH30pK/zxuaah5UcCbpyb6NTnJfgpiS4yikEcn+udfwtM5T
 Yhuc9JZL0WJ5djTXX2OvrV7/l+F318M3gYpvXeV7S9FnaN9VOcQDK/bEQRc2Obm4SQlXuHzgBW2
 szkZS/FkqzzcMYSLFpYQF1l8rS+iK+fppEb7/PooZp6ozIGoolF/KZOKtozLvLFkh0JDqTy38UT
 8uR6nh+WOIjr72eaDHqMWetFC0q5vl43ZcEBRM/BOiThfioK+K4r+9T78WImUBHjV5mdb1V0FeN
 uQvMYj7FNGscrPukmvNdpItczp6iI1pYeOyRhsJFT49RUtTRyE++AlUeGWJgKJNWKjCdn6ZrZz1
 e7iQVmgFisbgWRHRP/A==
X-Proofpoint-ORIG-GUID: RSxzqwe8F-aXPzTNDLZpMxP0cPHSFj8s
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA3NCBTYWx0ZWRfX0BSF6IT/a7nf
 wyShwgmU4u8BOJlPN7iTw/KqBvTEpzmWPmtUX4W9IC0I3QmQhKsHKgdwXni+SC+Ai8znKvatoGa
 rC/Mp1L3OMvMaQ2r5ETWBpOuT9w19+g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160074

On Thu, Jul 16, 2026 at 09:32:29AM +0800, Weimin Xiong wrote:
> msm_iommu_probe() adds its devm-managed IOMMU object to
> qcom_iommu_devices before adding the IOMMU sysfs device and registering
> it with the IOMMU core.
> 
> If iommu_device_sysfs_add() fails, probe returns with the object still on
> qcom_iommu_devices. The driver core then releases the devm allocation,
> leaving a dangling list entry that later list walks may dereference.
> 
> If iommu_device_register() fails, the same dangling list entry remains
> and the sysfs device is left registered as well.
> 
> Unwind the sysfs device and global list entry in reverse setup order on
> the corresponding failure paths.
> 
> Fixes: 42df43b36163 ("iommu/msm: Make use of iommu_device_register interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Weimin Xiong <xiongwm2026@163.com>
> ---
> Changes in v2:
> - Resend the former patch 4/4 independently; patches 1-3 from v1 are
>   dropped.
> - Explain the dangling list entry and stale sysfs device consequences.
> - Add Fixes and stable tags.
> - No code changes.
> 
> v1: https://lore.kernel.org/r/20260714060930.220277-5-xiongwm2026@163.com
> 
>  drivers/iommu/msm_iommu.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
> index 0ad5ff431..d0d926be7 100644
> --- a/drivers/iommu/msm_iommu.c
> +++ b/drivers/iommu/msm_iommu.c
> @@ -784,19 +784,25 @@ static int msm_iommu_probe(struct platform_device *pdev)
>  				     "msm-smmu.%pa", &ioaddr);
>  	if (ret) {
>  		pr_err("Could not add msm-smmu at %pa to sysfs\n", &ioaddr);
> -		return ret;
> +		goto err_remove_list;
>  	}
>  
>  	ret = iommu_device_register(&iommu->iommu, &msm_iommu_ops, &pdev->dev);
>  	if (ret) {
>  		pr_err("Could not register msm-smmu at %pa\n", &ioaddr);
> -		return ret;
> +		goto err_remove_sysfs;
>  	}
>  
>  	pr_info("device mapped at %p, irq %d with %d ctx banks\n",
>  		iommu->base, iommu->irq, iommu->ncb);
>  
>  	return ret;
> +
> +err_remove_sysfs:
> +	iommu_device_sysfs_remove(&iommu->iommu);
> +err_remove_list:
> +	list_del(&iommu->dev_node);

IMO, this can be avoided if we move the list addition to the end.

-- 
-Mukesh Ojha
