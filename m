Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A6323C4FE
	for <iommu@lists.linux.dev>; Tue,  8 Jul 2025 22:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752014379; cv=none; b=RgsVOfUZWxpLDpIaI8SU9leDyT9P+QGgt65AX3WjaPOLZCmkk6n8uGgpS8O+g0EDirZTVOkzNIs20B4wqKMLUonyLthlk6NSapsg9XLIi4vgZflrHnpeKR6wEUrYBE1LNxKKq3I5Vwt4x92lvAQXttZ64TxFojwFrPaxadU0yMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752014379; c=relaxed/simple;
	bh=F/fF3Rhxr5b1fiF0//GSOd76xUZw3GpIk4+dqXfKpiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aKnB+69dPdKXZRTJcMPbF0A/DqB3g5FM/JrKIBExTLfIvo6pbnI+Fb4P2F2VK23D4dPEu05W5LRIkH53rlVOiMXvEz1gV4aRF6Rb7Ej1TzaFGIBltpi7y2AgyTO7gEwQSvNWu9o6xvGY5HBCxtFAHnRgPB2Crd6y2oBKqH4puQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dnqsVAvx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dnqsVAvx"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568IRhxp003539
	for <iommu@lists.linux.dev>; Tue, 8 Jul 2025 22:39:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7UtZUgVsdHbUgf+84soaO60Bc1Eoqdwl1tY6FaWRI/4=; b=dnqsVAvxsxfPNtV1
	90mlJtfHkz2WSDEH99XyoBC9SqqhH5DJP//4PFwKm9JAIXpl6CCP3ojFwZBsOYQz
	MWA3QkVFOkHNA9OcSN5s1GqSsdQEEYVskhD1Y1EJocx+7GLwo4GXuQwumtd70Rt9
	x+Rckx3Vcr77JgsFThIyG78ZT7vWg7wkB4D7nh2hL9Z52AZRabwUH0z9gd2dIPS6
	R3EDG7fD845L5tXMkEVKAN2fvcpyltd2FDmckYR9szdqG6urw9VfQtLSrVlJppFl
	aedLiPbPZLphg4C5xZUTNs5o6iCWJgMPiDXg0uv+76taWBcpi7V3q5XacXCMjhZK
	YQIl9Q==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pvefjb1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 08 Jul 2025 22:39:36 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-74927be2ec0so7048093b3a.0
        for <iommu@lists.linux.dev>; Tue, 08 Jul 2025 15:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752014375; x=1752619175;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7UtZUgVsdHbUgf+84soaO60Bc1Eoqdwl1tY6FaWRI/4=;
        b=GoTS1fb088Hvsn24VXH143+bODXNmY88601zQSjPJfM462HANfqgpN2iQ1ls1jdcy9
         WH+ADp8JsKPDs5aql8D28nalmU/uR36BfvQgNfJHD6qlqI6E6gTyeFKcuNbX2+nwKBQ2
         bd+VllW2QSd8RC8jKCmPN4Scf5wBuftcSg3+9MH9desUw5RnelDbwb4i3qzJdUg746uY
         KusYU7bZRRb59a8nXTdAX8ZVgX6cqDJ/12VI3NLBpeWWUseAcgy612rpxi57qdMze1vj
         nxO2ZP5mYKlTczEdkkWTK0s2ucJsggmyW/dYOfyFfe7T9JZ335492Ebwjh/aK04aAsWo
         sftA==
X-Forwarded-Encrypted: i=1; AJvYcCX9/5+InF6wHwhdyq6Q/gHNvUuRc1xW4ClV4OFcQHYaPyi+5/NDTnr9GvHxRmD+K8ixN4or9g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZs4107magc2hnDoTM0uvAFxoXE9sbvutSdZILICUOYhKlQsMx
	NkefIkZ3tsWAK4f7vTKZ1NuO9CaDQB2RfCwZQqqLWH2H37KM9gsiyf/c80R+YplGAai1lzPebGm
	rrS0CaulYN8vYT5wL8nzQAmI7zNyD7g7CmEVeVZWv8bxQDQP1Y/PlEWtRsQ==
X-Gm-Gg: ASbGncue6sGQeRdBhxa/6qS8kLaOebZ8xUepVRXMzNmH+GoRH76GofGXqQZqGEcuMYz
	ylQn9ykswoX4iM1ewRojIzh/BDjR6+ba6vChERZ7yvTg+TSR7wU0IyNf1Lku3MRwShd0S5TBU40
	oc5wJvVZa3XL5B4XWfbalX/MKRNyxWuXL7ORklAU1DdtomRelNlHv2ySDohwvsfMfs4N1E/yuu+
	bR7R/IVqkYrjCF70/CJgX1QOF6X3jM4dhJzY3h11V9i4d3Te8K/1fwQPu9+jQWkbX3vNllz1P1T
	7fr81o0Tf1PADxthDp0/tN5+Z1c+BWFqBLx8L4Y7WB4KZrXx5XhLzpaIzGLL0EEeHnrGm6jwYCH
	UJaCOvwPP
X-Received: by 2002:a05:6a00:2d9f:b0:740:9d7c:8f5c with SMTP id d2e1a72fcca58-74ea668cc20mr441774b3a.18.1752014375428;
        Tue, 08 Jul 2025 15:39:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBiN3xyeq7O/uV1TnSFOOrnKUZ/OhLBMhI3YNs4YPGljXRssP01Y/5JMu4DrrIP6a34HkNsQ==
X-Received: by 2002:a05:6a00:2d9f:b0:740:9d7c:8f5c with SMTP id d2e1a72fcca58-74ea668cc20mr441702b3a.18.1752014374744;
        Tue, 08 Jul 2025 15:39:34 -0700 (PDT)
Received: from [10.71.111.173] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce429f6c2sm12565653b3a.134.2025.07.08.15.39.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 15:39:34 -0700 (PDT)
Message-ID: <a6af609d-b9e1-4b63-85ab-41ab08968579@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 15:39:32 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] of: reserved_mem: Restructure call site for
 dma_contiguous_early_fixup()
To: Robin Murphy <robin.murphy@arm.com>, robh@kernel.org,
        m.szyprowski@samsung.com
Cc: saravanak@google.com, quic_obabatun@quicinc.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, william.zhang@broadcom.com,
        kernel@oss.qualcomm.com, will@kernel.org, djakov@kernel.org
References: <20250708165627.845295-1-oreoluwa.babatunde@oss.qualcomm.com>
 <ceedcc51-7a4e-4da0-bdcd-429e7c212d19@arm.com>
Content-Language: en-US
From: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
In-Reply-To: <ceedcc51-7a4e-4da0-bdcd-429e7c212d19@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE5MSBTYWx0ZWRfX2zeugIHNzoE+
 bU1dwcS8C+AE7eakcZnevkphNl5+AATrX7eH3wXe/VPbRPp0jBr7KLF0IAKX89K/FNJglaPCN4c
 32P8wpQBmGUv5ViTgMajjxg53HAgExDvR/v+yR2Wm57WBkQajjyRdNBwksdH5Nd+yaecQIyrI8F
 7YxAlqveX+8aAVc/dRgix2OGautVJITgSaTCrtfhS9M1AwVZp/pd1xD1+/4elwA5kI0M1YfGUYv
 nmF1KUP7WXHM1VnGmJ2ut4bOyGpoHmWDGIjDcN+gwqDILrP+ieIQ6bcQepY7ryqj4EdEBCRIvcF
 OOh3u0U8/DnYHMuGhnNEgJC1NAJzxXRVJvKnV5uZXPc4w/J91EQy/C1DImivfsxwOo3c9QKW6AV
 2AssivUOzED9ldS/X0lI+9zOEsOy/+qUhKRsWkzGPMJ8r9/kuxjeGwWSsiY9SqT5XoO+lhnU
X-Authority-Analysis: v=2.4 cv=dciA3WXe c=1 sm=1 tr=0 ts=686d9e28 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=fQRGRuMEmedUXPIvGoAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: qEpltr_dpBaevSDB97T3BceFaf6n4wRL
X-Proofpoint-ORIG-GUID: qEpltr_dpBaevSDB97T3BceFaf6n4wRL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_06,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 mlxscore=0 mlxlogscore=977 bulkscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080191



On 7/8/2025 10:17 AM, Robin Murphy wrote:
> On 08/07/2025 5:56 pm, Oreoluwa Babatunde wrote:
>> Restructure the call site for dma_contiguous_early_fixup() to
>> where the reserved_mem nodes are being parsed from the DT so that
>> dma_mmu_remap[] is populated before dma_contiguous_remap() is called.
>>
>> Fixes: 8a6e02d0c00e ("of: reserved_mem: Restructure how the reserved memory regions are processed")
>> Signed-off-by: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
>> ---
>>   drivers/of/of_reserved_mem.c | 14 +++++++++++---
>>   kernel/dma/contiguous.c      |  2 --
>>   2 files changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
>> index 77016c0cc296..132d2c66cafc 100644
>> --- a/drivers/of/of_reserved_mem.c
>> +++ b/drivers/of/of_reserved_mem.c
>> @@ -25,6 +25,7 @@
>>   #include <linux/memblock.h>
>>   #include <linux/kmemleak.h>
>>   #include <linux/cma.h>
>> +#include <linux/dma-map-ops.h>
>>     #include "of_private.h"
>>   @@ -175,13 +176,17 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
>>           base = dt_mem_next_cell(dt_root_addr_cells, &prop);
>>           size = dt_mem_next_cell(dt_root_size_cells, &prop);
>>   -        if (size &&
>> -            early_init_dt_reserve_memory(base, size, nomap) == 0)
>> +        if (size && early_init_dt_reserve_memory(base, size, nomap) == 0) {
>> +            /* Architecture specific contiguous memory fixup. */
>> +            if (of_flat_dt_is_compatible(node, "shared-dma-pool"))
> 
> Surely this is now going to call the fixup for *all* "shared-dma-pool" reservations, rather than just the ones which are specifically CMA regions? That seems potentially bad in a number of ways.
> 
> Thanks,
> Robin.

Hi Robin,

Thanks for pointing that out. I believe if we add a check for
of_get_flat_dt_prop(node, "reusable", NULL) that should help
limit this to only the regions that are meant to be cma.

Please let me know if there's something else that I'm missing.

Thanks,
Oreoluwa

> 
>> +                dma_contiguous_early_fixup(base, size);
>> +
>>               pr_debug("Reserved memory: reserved region for node '%s': base %pa, size %lu MiB\n",
>>                   uname, &base, (unsigned long)(size / SZ_1M));
>> -        else
>> +        } else {
>>               pr_err("Reserved memory: failed to reserve memory for node '%s': base %pa, size %lu MiB\n",
>>                      uname, &base, (unsigned long)(size / SZ_1M));
>> +        }
>>             len -= t_len;
>>       }
>> @@ -472,6 +477,9 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
>>                  uname, (unsigned long)(size / SZ_1M));
>>           return -ENOMEM;
>>       }
>> +    /* Architecture specific contiguous memory fixup. */
>> +    if (of_flat_dt_is_compatible(node, "shared-dma-pool"))
>> +        dma_contiguous_early_fixup(base, size);
>>         /* Save region in the reserved_mem array */
>>       fdt_reserved_mem_save_node(node, uname, base, size);
>> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
>> index 8df0dfaaca18..9e5d63efe7c5 100644
>> --- a/kernel/dma/contiguous.c
>> +++ b/kernel/dma/contiguous.c
>> @@ -480,8 +480,6 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
>>           pr_err("Reserved memory: unable to setup CMA region\n");
>>           return err;
>>       }
>> -    /* Architecture specific contiguous memory fixup. */
>> -    dma_contiguous_early_fixup(rmem->base, rmem->size);
>>         if (default_cma)
>>           dma_contiguous_default_area = cma;

