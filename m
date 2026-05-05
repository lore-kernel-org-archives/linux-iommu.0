Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3464A37C901
	for <iommu@lists.linux.dev>; Tue,  5 May 2026 10:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777978499; cv=none; b=cnXBfjgnb0gLFLEKD/3ub0nibZuFeA1CsqlkubiiYjrtoQxPn75y+yiEskfXvUslxFg541fG6BROui3glQypfWdqP3d7rwZ3RCYBYFVzSa8RJJuhXxWzcKjODSgPeXaBy27doSbUyp01ARhgkFLkVq9hfml8TT+O/6d0HZKHHrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777978499; c=relaxed/simple;
	bh=oB1kmq12me1ceMdWUlzQL5RkR4ozbRzxncGFdIDYvfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RM1f2DnlATqip6+EZ3D4tPDQ632Zm4GYNrWofVpYqGXNPgbN7kw/GZ1IhWypHm+scoSnmWs2368sI3UMQqNsWskSa2BNMyy6vhjkUUWqQ/Aumr2cV2qBzJPF4fG4Zk56ZqDWnIlWIUj2isj69Iwt5aMKr8BuM9xWa9x+HU13euo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LonEUX8P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iTOYqLsN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LonEUX8P";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iTOYqLsN"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6456li0U3187548
	for <iommu@lists.linux.dev>; Tue, 5 May 2026 10:54:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3BLJdOTNMnvDK0QZqlb+2VB8xllUiDV37a14B7e6vkY=; b=LonEUX8PdHmVy31g
	PpKbFy34z17YixmgtWmlZ6ju6GB2GIr6vH+0n1SM+kdGszFThDY3rKZ8PnXlGjjC
	0NWS9FKQiqPh8vtJ0O8LnmRATVtHaExw6f2jq5XPXZLsUzs5XUglwzA1D70cvK/T
	vpHlhtNAsSXNZ+EVK1UNbG1Ed1fpuZeTofhF6jbdUTuHIVl1AXWh4OndYezl+gq3
	5GpfAsTD2u0CsRITDdjGfy0NBFg4tElCuruagKXxtPIT8MJ2p2OJ+FZEG9Nx7gjP
	211Nh1B/gj6sgVsGi2aL7eHESx0o6gZRpKzt0KVXzyQZbHnvYy6TyVYzbVPDqL2u
	qoJLfg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dybkk8xj1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 05 May 2026 10:54:57 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36472c6a7d8so10398236a91.3
        for <iommu@lists.linux.dev>; Tue, 05 May 2026 03:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777978496; x=1778583296; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3BLJdOTNMnvDK0QZqlb+2VB8xllUiDV37a14B7e6vkY=;
        b=iTOYqLsNQD2X4Yyl4U+CUWiKwrkM8wYLmagdEZD5sZtk1zvYKqgkOy2QlEPTkRHKk6
         EcI99+wtfPEQziG+hvYV8HuYLLNqTx19Z8au4H6g58IijPGDKprTtft1aUdXfoey6tra
         D15sxpu4geLQeB0mJKlwmfAEvd8wNG0OtHvi+HEjl6tVl1BV4nl8MpHupsr8w0thJBMx
         4AFgVwOM4p8N99MLIxlJ3A8N/aGCC+M5OfTC7r3GE+IsyDWNMUABpWrYET9Db/XChgOZ
         5gUlgVTiP5BaWCid6kCoFpLmloGORxzJN42ygr89IRMiNbCQPp83+OW8C/pVvDjZKToj
         l+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777978496; x=1778583296;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3BLJdOTNMnvDK0QZqlb+2VB8xllUiDV37a14B7e6vkY=;
        b=AjsVH6kGD259ZDFa5oALBVFFNrcBLqy3uiLIDlQqJ5D/Ot/8MlHEcBGZ9VusETO71a
         94N6JGMxINQv3WvVKr38yz8ofgE0Ditn5xEziRp6s1S93m5DvW83cJdUOmloZgFo1r2b
         BjZJmllCGOewx2Vi0eVpG/xuKBQ62KrkLhpwPlL7WMz+iND/fPoj7PWdc1QT+1SF6598
         2M+TwW4O+Zpuu4FFZ7k/jhW85ZPTm8ykYjbwJh9upnR+IwNmvgaWezS54GG4Yo/2dp+7
         jPd/n3dX3fJAUY7DWm5SPn5c743YcCWmDLg2L9Qq67PW5jJsXZxHZD820tC2ZCipBSvf
         jQiw==
X-Gm-Message-State: AOJu0YwIxCiAW4CZPHDZo833lBo+UsnlvKRyKzYH1WVdwkCOg0KStK4J
	kdhBX0YVLRCpwQwKS/BzVI1gfWhhZP/QoYmJSWd2zAOh7w0QZ8GYkYqlk6v/5rwzY7h9oYPcsIP
	n29XISTdHs4oLLWahX12Ils81q/WtdO/8XhcqsohpRuiFN+P5uUx/o3S4zw==
X-Gm-Gg: AeBDievYll5/L29/JFhctQzhgtLjI0c+aVZPCi0mN/qvTmU1LdWFHci/os2wSlfSsUx
	P+iLWANIGO6PbilXxitwV/cs9OAUOODwq7UajK/6nD2khACXulkXM2+lKIxtD+NYFtHLp41BppS
	WWHgmIe4mUn6K1lJhZm0O3KnNXAQvV0t9cs73stxhGZRQ+AYmxWq9vva1GTL1JkIYe+0KT8HVj5
	dRg1Hb32CBj4xtOypUpPDhxKH4KyRqDRwL14BFJ1X1lI5EV+eCETvNmGeZd2ZrAWFASVcVA8F+y
	fHGNAlNqq/f27AhEhRMYpQDDfzz1GyTb5P8z9hUMSj8LmkiV3IUNi1DGxepoGJ3q33HhIDchV9d
	OXFbYxyhB0bWX7mos2AiNYFa42l2J9zTS5KHd+O+oyFpJB1T+yWj9c6Fjr/4NdVdGn6kVNhmVFu
	uIipPm2Gxiils5KOlUmrNI1C+0aVZE+klbfiOw4A8nNIIuUGriWSE=
X-Received: by 2002:a17:90b:2b8b:b0:364:7467:53e5 with SMTP id 98e67ed59e1d1-3650cd866dbmr13459949a91.2.1777978496226;
        Tue, 05 May 2026 03:54:56 -0700 (PDT)
X-Received: by 2002:a17:90b:2b8b:b0:364:7467:53e5 with SMTP id 98e67ed59e1d1-3650cd866dbmr13459935a91.2.1777978495755;
        Tue, 05 May 2026 03:54:55 -0700 (PDT)
Received: from [10.190.200.117] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae5cc52sm137977745ad.78.2026.05.05.03.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 03:54:55 -0700 (PDT)
Message-ID: <96daa0ee-4cbb-4472-ab3a-19ee32b4758f@oss.qualcomm.com>
Date: Tue, 5 May 2026 16:24:51 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Add glymur MDSS to ACTLR client
 table
To: Lokanadha M R <lokanadha.r@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260428-add_glymur_mdss_compatible-v1-1-8416df5a26f4@oss.qualcomm.com>
Content-Language: en-US
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
In-Reply-To: <20260428-add_glymur_mdss_compatible-v1-1-8416df5a26f4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDEwMiBTYWx0ZWRfX1pu4Y2jRrg4i
 mcSYNu0UA2GdY7cbkNY0tTf5SupgZibQRHu2r9iKHAOtCoUduPzydn7Q9Tg7Jiv4o0GkpcsCITa
 FPt4mZbKn/anuHahbxs0yfBt9asDV2Jr0MxUyhBiuFDZEeA0jnbrgrACHTem+gv21/J5Lsvuxlt
 giaTwnTmXLWcLgKjkUjYsxX0CG76aEJ+iQcn0rZ5Q+xrQtejJWgOuHeCrVFW8G/7QUjI2Mdh2c4
 JUCtb8QLYNYNCtihCFDrbPuWEJYkbV80GswA9NGB8goRRzMujTgz1pOM+swavEhB1O/hBqbh2Kg
 odGsN3KZwBOo8QgbySACWIrIWm4nesq9ZxI18zxrzBaE2nvUo0kAFeJMTXfPtTNVOyTWorBbSpT
 WidirnDPiah9a7YJDD9iovOKl5RO6m19GfZ+PxS37tIN5KVvznd/940e4FNWlN+6lHVyfX+hF+4
 qxKnIN/SVvamq7rI9Ig==
X-Authority-Analysis: v=2.4 cv=SPBykuvH c=1 sm=1 tr=0 ts=69f9cc81 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=wtB1UJvddPmpPx-NcbYA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: 0c6nYUg0GsSDgcgqNYNlcYhYy2-2WD47
X-Proofpoint-ORIG-GUID: 0c6nYUg0GsSDgcgqNYNlcYhYy2-2WD47
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1011 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050102

On 4/28/2026 3:13 PM, Lokanadha M R wrote:
> Add qcom,glymur-mdss to the qcom_smmu_actlr_client_of_match[]
> table to configure the SMMU-500 context bank for the display
> subsystem (MDSS) on the Glymur platform.
> 
> The settings disable the next-page prefetcher while keeping
> macro TLB caching enabled. Without this entry,
> qcom_smmu_set_actlr_dev() finds no match for the glymur MDSS
> device and leaves the context bank ACTLR at its reset value.
> 
> Signed-off-by: Lokanadha M R <lokanadha.r@oss.qualcomm.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index edd41b5a3b6a..6df48499a4b2 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -41,6 +41,8 @@ static const struct of_device_id qcom_smmu_actlr_client_of_match[] = {
>  			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
>  	{ .compatible = "qcom,fastrpc",
>  			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
> +	{ .compatible = "qcom,glymur-mdss",
> +			.data = (const void *) (PREFETCH_DEFAULT | CMTLB) },
>  	{ .compatible = "qcom,qcm2290-mdss",
>  			.data = (const void *) (PREFETCH_SHALLOW | CPRE | CMTLB) },
>  	{ .compatible = "qcom,sa8775p-mdss",
> 
> ---
> base-commit: 7080e32d3f09d8688c4a87d81bdcc71f7f606b16
> change-id: 20260428-add_glymur_mdss_compatible-44f5b2837498
> 
> Best regards,
> --  
> Lokanadha M R <lokanadha.r@oss.qualcomm.com>
> 
> 
Reviewed-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
