Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC19032B99F
	for <iommu@lists.linux.dev>; Tue, 16 Dec 2025 22:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765923710; cv=none; b=DW5iEMa2QG8RiPvB3Tm8yYkONt53lmb0iEUIeEBzKLCMxVnbOgxPFLvCvqV2T0ycqQdJ87KistuGYQZzdFF9sJLgNRNLnbRoMqMUUF6jySNyGVNknh9W85zGRcg0k1PLtJGJ1FGC+5tlNYvP7K7EPPcWnQxHa8jqYHbo0nyyA2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765923710; c=relaxed/simple;
	bh=G9gLuhn1gYlX16Pldc7mw767XXUhwO5xnSab+bTzS+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pH80Q9YCW631wkMXPgAqfB0UZRoUXiw5Ju5wu0cDjccB5fJm3aCsiuqUODSO08fk1dk5CVH7huB0uIBUeIZc5l71f2dExsMNdc8eVr0/hcjghzYSW9HknD2hyk6guX5PbvCqwzziySGtpesQfCozQyrdbEAUsMbxfMGm3eAJFF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a8+RADNq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OZgKSF8q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a8+RADNq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OZgKSF8q"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BGLW3Ea567562
	for <iommu@lists.linux.dev>; Tue, 16 Dec 2025 22:21:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8HiBCIcpdMLJOIL1RNrE8wcn9Ndx6c9xmNAQz1tizXE=; b=a8+RADNquD3dbLe7
	+bqhf0fh2DctX9R54PGcC0xDlKgryDav/GufPQFB2V7bE30tCggJx7MvypzhUxMU
	b/9r1Y7WAGgOPKxjIiOE1XcLn44H9ljW68uJV9beA7U/kHBEyM+Ts8026k8siSHa
	QMtexlhafmgBmWyf5dnjt36xrHB2obJM8eMNP04+Ejy1Q31uky9K/9QGfFtHVvQU
	Fl8GFnybqvANGF1dMjy86q5/n+p3C+tEpr0NcZpk4y/rZOrWG1oXnjM4jXHNZ+Tf
	LKMuaJS044tJvcVW81iCMh4OFEAMAsSWRhq7trDeA2OA4R04TSWHFsdTnYJ0KhWO
	UhY3cQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3fe283my-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 16 Dec 2025 22:21:46 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so5353930a12.3
        for <iommu@lists.linux.dev>; Tue, 16 Dec 2025 14:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765923703; x=1766528503; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8HiBCIcpdMLJOIL1RNrE8wcn9Ndx6c9xmNAQz1tizXE=;
        b=OZgKSF8q2puDNzxfeT4DWmrGy34HLgUr9zIjv02O0UpyAM04uOTDhd/rqLPGcFIn9B
         iCZMcenX4fK7JrmIx6NaZaYcDaFgtTD2wthBrQajLqZIc7R/fiBosOahtANqOympvsmJ
         DTztNZcAMJWlsNtWKf1m6XwJfDgXcpmENYhecivotuqVIwPHZygoEu5HRXGFUwSlT91i
         kE/RQIyEd7hdbZ9ORW+215Jp6sVynddb28D+SwBRtpQl3Km3kokyjSd8zo3X6rS6ZOFX
         cZI4iD/OEkZXnkEnQgEXXYUYMBGHoNqw7weNbKyX40w3a4a/N0mt8XoYGpbQiq1qtV/k
         AUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765923703; x=1766528503;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8HiBCIcpdMLJOIL1RNrE8wcn9Ndx6c9xmNAQz1tizXE=;
        b=OZZupQ7sAVSP4vpjMdf2AgujJUCtYTZ2MmcAeIaSQavAUc3uekZeyWZZ6bBPSUBDC6
         BKV5icW+CjapvQ7r5SMDnyc+pFbLpFcwoBExBz9rgNYpidXAli+apWkhHSsWG4bx9+cr
         sn6+v79Qk0z6D9mLXyjoVviayEmoXD+1UHnePESy88GTNK203uVt0qQdNk/K/lOvzAAt
         4pErE1SDka0W6nEnhbUJLwolS9N1zvAYTCSVCTddFg3c847otZMnOWOVUihcPY4ILW0Q
         iw5N3+Ub4tj25cdkzqz3ver66CI3IRBmse8xtqfTh9HtIDVM7N9pK9sOxGPK/DDmd4fg
         X4JA==
X-Forwarded-Encrypted: i=1; AJvYcCXQaGqTD2qcCE2IFyMf1HSztmBPn5dKJFgDj5uOp9FXSKOdmG2cMvVnGJOPSQHc1+J5jHEM6A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6WkRKssFQc5iPnadLsHJV6Lbx77nQT6aaZyERBosMZlcThK6Z
	XTGDB6zTDqliGdveVG2YbCU0UiAY6mKrBq9yf0yiLuzI5R0WQp9uupTSxN60+xcSoxQr7J9kLi0
	agVki+1cCPEyf9HmIafrbPC1jNFgnZeVjvaJ/hLKMseFPVbQBd91EAC2zog==
X-Gm-Gg: AY/fxX5uN3UceJb0KVKS4XUg9pC3VTrmK5XuA6jEW49EtZIL/MY5WkWGwkNRHR49hXA
	awSWIghQZLkKRuyZ7irpmy4HAtTVHLat4zRVPGVwpnPYcc/cqbfaJc3QlZsPrbhtHQWx2eLunSw
	ipIQqCmlRpb/p3q+Tjw05254ZTHQGIBfij1lXRMmMct27MM8ToCK1L1q9hpfZklnHU341abihou
	G/fm6Naexv8FA/pQycH2dqKgbYYyl3Kq/iClHjdLimi6b7489/UMHOytjuAG7/ncxijTveJBD2E
	y5G9oaWxgkDtVh2tWlix2WCXHyxa23Ot7/AYVD+65ZnPvWVQfG9vi5hEBh6zzkBdhwyeKZqMSoD
	QQLz3BttFNDe1gb3nHNvNSgtjxPyvDEXV2rktOXlNcUE1G84RGgYpLgwed4GFqUF5vTBtgFA0PQ
	==
X-Received: by 2002:a05:693c:40d0:b0:2ab:ca55:89ab with SMTP id 5a478bee46e88-2ac3014dce6mr10730965eec.42.1765923702464;
        Tue, 16 Dec 2025 14:21:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFi/A5m1zIJyuP7xZZ92DFDZYKgvLKmrGiV5FjsUQjVbjI+cenqaoY5wg0bM2r+933ZgklO/Q==
X-Received: by 2002:a05:693c:40d0:b0:2ab:ca55:89ab with SMTP id 5a478bee46e88-2ac3014dce6mr10730925eec.42.1765923701875;
        Tue, 16 Dec 2025 14:21:41 -0800 (PST)
Received: from [10.71.110.87] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ae4f054476sm1665750eec.16.2025.12.16.14.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 14:21:41 -0800 (PST)
Message-ID: <61102a92-ad98-4fbd-bee8-760a758b0eb6@oss.qualcomm.com>
Date: Tue, 16 Dec 2025 14:21:40 -0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] of: reserved_mem: Allow reserved_mem framework detect
 "cma=" kernel param
To: Rob Herring <robh@kernel.org>
Cc: m.szyprowski@samsung.com, ye.li@oss.nxp.com, kernel@oss.qualcomm.com,
        saravanak@google.com, akpm@linux-foundation.org, david@redhat.com,
        lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
        rppt@kernel.org, surenb@google.com, mhocko@suse.com,
        robin.murphy@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux.dev, quic_c_gdjako@quicinc.com
References: <20251210002027.1171519-1-oreoluwa.babatunde@oss.qualcomm.com>
 <CAL_JsqL6VVQ7K_ZAbHJ8Gb7ei_jusLx6wRn=AdOVgV50dX0ejQ@mail.gmail.com>
Content-Language: en-US
From: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
In-Reply-To: <CAL_JsqL6VVQ7K_ZAbHJ8Gb7ei_jusLx6wRn=AdOVgV50dX0ejQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: IAWJL93b0cXNiTlM4uzJ0bDMyh_IfK4d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDE5MCBTYWx0ZWRfX8SQ7hb9jx/29
 fhhgKotAjIdc+G6ufqeFXUPLleKhN+X1pcvouaRjS6vahOOsF1OJWYXf61UV2AfXwdHvISABqN4
 2wctKlQnMFv4u30SiXp23NIg2HQ7snWNLwonFLD2BX+nKy4vaLqtqymLqdewG4R3gEZVcPNvk8p
 f38mfvwrI7EmpUOMR0fktzZd9hPdnQU4XdkFY12SnPvKt2S7jfAD9a/96FX2lpHX4i01esod1yC
 D73lJXu2iVIWPlcAKcJUAvGfJKKZANVTLQY29mSD9fiSlWZcV04/HXmSNf6eaYtBCOXZzEwcG1o
 pKqrPNLTp+FtEPfso1aRp9030HUoaPJbUu3GjoRaTzMJC/eBgK4bZL7pFKI9mNekgGJynJGvEFV
 E5MyPiggTra1AgfZWq1MWPPwceU6Fg==
X-Proofpoint-ORIG-GUID: IAWJL93b0cXNiTlM4uzJ0bDMyh_IfK4d
X-Authority-Analysis: v=2.4 cv=HpN72kTS c=1 sm=1 tr=0 ts=6941db7a cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KYYUgL8zeczeCQrUCMoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512160190



Hi Rob,

On 12/10/2025 6:07 AM, Rob Herring wrote:
> On Tue, Dec 9, 2025 at 6:20 PM Oreoluwa Babatunde
> <oreoluwa.babatunde@oss.qualcomm.com> wrote:
>>
>> When initializing the default cma region, the "cma=" kernel parameter
>> takes priority over a DT defined linux,cma-default region. Hence, give
>> the reserved_mem framework the ability to detect this so that the DT
>> defined cma region can skip initialization accordingly.
> 
> Please explain here why this is a new problem. Presumably the
> RESERVEDMEM_OF_DECLARE hook after commit xxxx gets called before the
> early_param hook. And why is it now earlier?

ACK. I will add more of this info in the next patch version.

> 
> I don't really like the state/ordering having to be worried about in 2 places.

The advantage to having the state visible to the reserved_mem code is that
we can skip adding the DT node to the resrved_mem array since it actually
won't be used.

If this is still not preferred, another option would be to use a helper
function  in contiguous.c to call dma_contiguous_early_fixup() for the
reserved_mem code. This way, "size_cmdline" can be checked internally within
the file and it can call dma_contiguous_early_fixup based on that.

> 
>> Signed-off-by: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
>> ---
>>  drivers/of/of_reserved_mem.c | 19 +++++++++++++++++--
>>  include/linux/cma.h          |  1 +
>>  kernel/dma/contiguous.c      | 16 ++++++++++------
>>  3 files changed, 28 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
>> index 2e9ea751ed2d..bef68a4916b5 100644
>> --- a/drivers/of/of_reserved_mem.c
>> +++ b/drivers/of/of_reserved_mem.c
>> @@ -158,7 +158,7 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
>>         phys_addr_t base, size;
>>         int len;
>>         const __be32 *prop;
>> -       bool nomap;
>> +       bool nomap, default_cma;
>>
>>         prop = of_get_flat_dt_prop(node, "reg", &len);
>>         if (!prop)
>> @@ -171,6 +171,12 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
>>         }
>>
>>         nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
>> +       default_cma = of_get_flat_dt_prop(node, "linux,cma-default", NULL);
>> +
>> +       if (default_cma && cma_skip_dt_default_reserved_mem()) {
>> +               pr_err("Skipping dt linux,cma-default for \"cma=\" kernel param.\n");
>> +               return -EINVAL;
>> +       }
>>
>>         while (len >= t_len) {
>>                 base = dt_mem_next_cell(dt_root_addr_cells, &prop);
>> @@ -256,12 +262,15 @@ void __init fdt_scan_reserved_mem_reg_nodes(void)
>>
>>         fdt_for_each_subnode(child, fdt, node) {
>>                 const char *uname;
>> +               bool default_cma = of_get_flat_dt_prop(child, "linux,cma-default", NULL);
>>
>>                 prop = of_get_flat_dt_prop(child, "reg", &len);
>>                 if (!prop)
>>                         continue;
>>                 if (!of_fdt_device_is_available(fdt, child))
>>                         continue;
>> +               if (default_cma && cma_skip_dt_default_reserved_mem())
>> +                       continue;
>>
>>                 uname = fdt_get_name(fdt, child, NULL);
>>                 if (len && len % t_len != 0) {
>> @@ -406,7 +415,7 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
>>         phys_addr_t base = 0, align = 0, size;
>>         int len;
>>         const __be32 *prop;
>> -       bool nomap;
>> +       bool nomap, default_cma;
>>         int ret;
>>
>>         prop = of_get_flat_dt_prop(node, "size", &len);
>> @@ -430,6 +439,12 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
>>         }
>>
>>         nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
>> +       default_cma = of_get_flat_dt_prop(node, "linux,cma-default", NULL);
>> +
>> +       if (default_cma && cma_skip_dt_default_reserved_mem()) {
>> +               pr_err("Skipping dt linux,cma-default for \"cma=\" kernel param.\n");
>> +               return -EINVAL;
>> +       }
>>
>>         /* Need adjust the alignment to satisfy the CMA requirement */
>>         if (IS_ENABLED(CONFIG_CMA)
>> diff --git a/include/linux/cma.h b/include/linux/cma.h
>> index 62d9c1cf6326..3d3047029950 100644
>> --- a/include/linux/cma.h
>> +++ b/include/linux/cma.h
>> @@ -47,6 +47,7 @@ extern int cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
>>                                         unsigned int order_per_bit,
>>                                         const char *name,
>>                                         struct cma **res_cma);
>> +extern bool cma_skip_dt_default_reserved_mem(void);
>>  extern struct page *cma_alloc(struct cma *cma, unsigned long count, unsigned int align,
>>                               bool no_warn);
>>  extern bool cma_pages_valid(struct cma *cma, const struct page *pages, unsigned long count);
>> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
>> index d9b9dcba6ff7..9071c08650e3 100644
>> --- a/kernel/dma/contiguous.c
>> +++ b/kernel/dma/contiguous.c
>> @@ -90,6 +90,16 @@ static int __init early_cma(char *p)
>>  }
>>  early_param("cma", early_cma);
>>
>> +/*
>> + * cma_skip_dt_default_reserved_mem - This is called from the
>> + * reserved_mem framework to detect if the default cma region is being
>> + * set by the "cma=" kernel parameter.
>> + */
>> +bool __init cma_skip_dt_default_reserved_mem(void)
>> +{
>> +       return size_cmdline != -1;
>> +}
>> +
>>  #ifdef CONFIG_DMA_NUMA_CMA
>>
>>  static struct cma *dma_contiguous_numa_area[MAX_NUMNODES];
>> @@ -463,12 +473,6 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
>>         struct cma *cma;
>>         int err;
>>
>> -       if (size_cmdline != -1 && default_cma) {
>> -               pr_info("Reserved memory: bypass %s node, using cmdline CMA params instead\n",
>> -                       rmem->name);
>> -               return -EBUSY;
>> -       }
>> -
>>         if (!of_get_flat_dt_prop(node, "reusable", NULL) ||
>>             of_get_flat_dt_prop(node, "no-map", NULL))
>>                 return -EINVAL;
>> --
>> 2.34.1
>>
>>

Regards,
Oreoluwa
