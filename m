Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31AE43F08F
	for <iommu@lists.linux.dev>; Wed, 16 Sep 2026 12:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561126; cv=pass; b=k5JB9y8HXNe30Zudcw97yWeUyRNo6hwikDwzMGzWBmthvG0/XxgPimX30XJw2/C4cUa5lKVw1asMjgkWoZTKUHUEzUa6A6gBpKcWBvswM/K0JpSXabR5lYTX1PkC0RBEVZmN+yjS3EWyMw7LyHMrHBzwWN5EjfeIKdSz3yl1sBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561126; c=relaxed/simple;
	bh=cFuJnI/gnjp4xLrzIqNiRkV0rShV5E0vA0XrCKp3Nm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QFexxBHrigweBD0sO+3kYtSnXK/5j7qwDkDxLHVfpa+PBvvlFKBUPJAwLsjuxHcKPrzebNG+mdV+npwj5QApPMr9uZ1tnRLqiTAzQY093/dtV+ojmaibUx8UCfjLQqI6453/PTd7xf19KQKuulxslW40WXDJDfauH3SbaagQskM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k9V8GFXW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NucL5DnE; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k9V8GFXW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NucL5DnE"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68G934W82226493
	for <iommu@lists.linux.dev>; Wed, 16 Sep 2026 12:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=SZBupEoFPUauIn4/x4mdIDMsjjahDV5vgXK9nZDkKoc=; b=k9
	V8GFXWHIdnHp6Y4RnNpVLDr67AHxIWYMsbp2wmPOzH94cRlXMQtwXV7xIZ+9BXR0
	0nR/078w0RDY5npb796BNWhMuXLAAqG6YK8dtpYEurKNfXq7Fa/7aD8tX3wFdkE0
	6OHdaRuZIiumN1U6y20TE8eyAsSsgbwWzLMle0j74mNUcOwU9w13bLZnbHclBNtu
	moDljfiHU5n5r9RW2PtAkTPiqmbehLJGMTTfkBwrO4AQzmgh35DJCUDpox7iqzDr
	mGAcBB8eoI1ibcz/V3z+ZnEVL93hmW3Yer9TFDNbRPMORE3IkU6KVJOQnmPVv+Jg
	lOWWtHO7wLNgrboDzF0g==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqah9v86p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 16 Sep 2026 12:18:44 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-893845c4924so1479637b3.3
        for <iommu@lists.linux.dev>; Wed, 16 Sep 2026 05:18:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789561124; cv=none;
        d=google.com; s=arc-20260327;
        b=N6+DRlUKFBO6qozlPotXypY/gACrUxCjC9DiNGlJLT9kmnwyusSY6+8R2yvsvlhzFn
         KOSlMQMy3RgP4Jl733Vu3Az+8BFgyOSDndbNjRVYLF/CsF1+YJzMIsdFKqExqyfeGC6u
         dxN+pa0fQ9dQHXI5dOvfOh+c7xlMNApL+uWYjfR5r1H6vOOG0F2dwkC7A/yRa5VTNX2S
         FQObeDVxrZtmAfdzlv3HHLCLShitw8iwnUM0Qp399QvwlRU++d0szbySV3gAVE+iQweY
         5FTk0lEHqYkkvBawomdGlhsfThq6TxjKCM9hpJ7cVTOrUqcuK/tS9LM3VysR06rSu2Ja
         MOdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=SZBupEoFPUauIn4/x4mdIDMsjjahDV5vgXK9nZDkKoc=;
        fh=GQBlop5UTxANYpNxZ7ALr2yLGkE4NDc4CeHgJ0q7804=;
        b=pYV2K8hzXZCchkFlwS3xz/gBIDULJxG24JnvG01UsYTa6d+Rr5iA7y3xvDWoksdxfT
         RocOqOcPWYzbYwkPLyFYMdmaGEdqfSdct///ohwZ7FUdcNIzEi4mClBYEf6j5opuBRJD
         TwEDhYVgNw2vdjz0T5JpPCTh6xMXNBu+ip48E56sLewVgm8aq/ZiqFu1SzeyrAx7nYEa
         BFINYrSJpl3SyHZB5Rhlqc+PSkMtouV5zxTQHZNJsg3SS+eBZ5M9HMPoPgA1eU6mpFSK
         d6vBEf/P6VMDVk4gDCjxWOU5qkVzcXtw9cBmCRd8Olzrhcv4M/xMzQ2dJFjTJinozexU
         U6/Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789561124; x=1790165924; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SZBupEoFPUauIn4/x4mdIDMsjjahDV5vgXK9nZDkKoc=;
        b=NucL5DnEA3YxUyGxXesUx/9uD3/BQDEOx0G3dgDkojeva1/+aXfHAx3sxPxxxmpGuM
         Mebl26QRHT67h7aLPpmt/sv34rW1e52n799vuoNzeR34U5ydt0MuwNMd0GacyjL9cFts
         xdNPPgPVRYccJP6i3OTz2Ox1vl62GUE7CyCsyy9W3fZL1xiRhSJKM/KgWqamZ4YV213s
         rKfQsUHSv+3BEhk7JIHKNJ/NerqrNr7OYhg0+Rrad3kqx1zMX49nn+Xz2l27icXi260n
         N3L1V2apfaSPCp/N741RYO4JGyiQLdt/HBcHUGYyp/zT7TDT/MXFY3bdpXIvk3Y+QlXq
         YsjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789561124; x=1790165924;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SZBupEoFPUauIn4/x4mdIDMsjjahDV5vgXK9nZDkKoc=;
        b=ZUv4ygTw8iyZybcxkkHAEtWrzYkNO1tbNs8y95bsYfnNlVzn8dNopoSiboTQIONggS
         qw0lVpENdsnpvhnuWW9F8LRLMWpEJ0/CmYL9Cle5Bj6Nwsxt+lmMznMTKaS3gvNcbnzJ
         ByPNM818q483BKuY+jO7uMOLe9A3gTTb0rYGNHuOdiK/dHG46dEeYfYD5cKcPO6T2UJQ
         73oWBjac4ibYAjaAv2fSdQb13f6Vz4z+UH3v9XoslMCPzZLMFpArjGGMk9bymNLEDpVp
         25ZtI5S3EG8kd9KTl/IbPJGCo0G7MmsrV8xUFJ+P528qcIAarJlWDC6CMINu6px7R2uV
         pqRw==
X-Forwarded-Encrypted: i=1; AKwUvBxWNhcY89d0BMTPcHiY/d5fwmYKZTKnV6hnH0AeRVUi2dTWIibKXjCZj6MPuTjcwE9pVauprg==@lists.linux.dev
X-Gm-Message-State: AFuF++lainwm0pwqqxaNLuDc533yBFIYRFjn+EoaLJNfIW3Ka1vg6P0u
	Ti31BZp1YzkGGyjwCnbtoTYRFiwhFkJ+06ZEoPKvKpSxt7quj+AXAwdSrD5xNgC7NK7rbJRCpqX
	ckbGhzjev/gIu4c3m4aG6LaGASagpJ89DZVIX5HVd25CyDkplS4o29wgQnY5Mb8M96dPEIb0ut6
	K5c3UD06KKEf19zms+coQ4WcxF/eLKdj/w
X-Gm-Gg: AYBFou2/BjoJAPX3awsKeXly/50iPG9rTjL23E8z1Y8ZNdB5WeLCcTf/PZ1rkZvkJHB
	3vIK0O/jKIRaXed485x3j+xSSnczzQCdjKBshlmXxOzQueHDtTEUl4hAdWU7LhJLDCuBHbA2tBJ
	JJpkYkUw5Ofad6px6yj5++tA7HekoPz3eN1EDBEJv10G1PsiJYYZtcPjpIVfY=
X-Received: by 2002:a05:690c:34c9:b0:873:5bb2:6c12 with SMTP id 00721157ae682-892265e7601mr6043627b3.60.1789561123683;
        Wed, 16 Sep 2026 05:18:43 -0700 (PDT)
X-Received: by 2002:a05:690c:34c9:b0:873:5bb2:6c12 with SMTP id
 00721157ae682-892265e7601mr6043477b3.60.1789561123293; Wed, 16 Sep 2026
 05:18:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260916112545.887461-1-xiangwencheng@lanxincomputing.com>
In-Reply-To: <20260916112545.887461-1-xiangwencheng@lanxincomputing.com>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 17:48:31 +0530
X-Gm-Features: AcwNN1W_xPwCRH9HhXLAxBaZmSSff5vjkIMgObB2TpK3jfnwJHHIzxaUu74RxEQ
Message-ID: <CAB19ukHfFXmuPEaWdNPvFRkvMGpDQfVEpCHfqsHL20tpBytQRA@mail.gmail.com>
Subject: Re: [PATCH] riscv: iommu: ask for ACS to be enabled
To: BillXiang <xiangwencheng@lanxincomputing.com>
Cc: sunilvl@ventanamicro.com, rafael@kernel.org, lenb@kernel.org,
        pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
        alex@ghiti.fr, linux-acpi@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, tjeznach@rivosinc.com,
        luxu.kernel@bytedance.com, guoren@linux.alibaba.com, jgg@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=BtkIUoX5 c=1 sm=1 tr=0 ts=6aaa8924 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=D19gQVrFAAAA:8 a=4BKX8IsyAAAA:8
 a=RP7urAqO3HFMDD4ElOsA:9 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
 a=W4TVW4IDbPiebHqcZpNg:22 a=bflBWynC2lygM3eL1Mvi:22
X-Proofpoint-ORIG-GUID: 1DoNYTGWvs0Ma8-yym1HFADiFj-b1ieW
X-Proofpoint-GUID: 1DoNYTGWvs0Ma8-yym1HFADiFj-b1ieW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE2MiBTYWx0ZWRfX7pxqoohzQic6
 p2Eh5uCB4HKhO2hjgQ5Hu+De3CzmmEU9+ALpfw0wXWVjNynfunVixRmiBvptKTG3yLt0nj5wK+d
 jkTaxEWWb8lh15xV7HkxliTHvy4QAX904JFPs1oMmo872Q0lXcJ3Hs30WRByTL/al5NTf04YeXc
 uWn8ZD/zVIT4K1pfhXPb4kcrKTGDmJI88HpqZy0tjRh/GGH4xR40R2vWKLbmLPdsi3rOOliA3fC
 buKjnlxJlFqErJVz8aQnMitk0KoUNEsJzs9sHGTD0LIK5V+wjc4sLLKG4jprSAT1CQrxCWI1cuY
 dLMQUoqv3Tdv9R/qoQef+5/0GIHTktVabRW4yUQi4W4NK5k4Ee3HP8og1Av6NPumn4uyBAsGcHd
 KjyKYc6ZOWGUw1BQWIz4/AUsUiDkdqaGJPr1qGoAonUvkHNhYVEFABUV/LUAsULMUlW2tWfiL4K
 cHKuiJLb5YctNxocvkA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE2MiBTYWx0ZWRfX5/rohs8hBIb8
 mpMHx+CgiIuwWpvWg+NMvYdOoVYiAosiok2FWIFe1jkRzQbpmL1WXQOKylGtr2pkskxnxSP2+iE
 2LCGLKl+4slhnLd93VPEL7KZ2X8kAz0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160162

On Wed, Sep 16, 2026 at 5:15=E2=80=AFPM BillXiang
<xiangwencheng@lanxincomputing.com> wrote:
>
> Make sure ACS will be enabled during PCI probe
>
> Signed-off-by: BillXiang <xiangwencheng@lanxincomputing.com>
> ---
>  drivers/acpi/riscv/rimt.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/riscv/rimt.c b/drivers/acpi/riscv/rimt.c
> index e4538fa6c2c8..30d2d0211d5e 100644
> --- a/drivers/acpi/riscv/rimt.c
> +++ b/drivers/acpi/riscv/rimt.c
> @@ -525,4 +525,5 @@ void __init riscv_acpi_rimt_init(void)
>
>                 return;
>         }
> +       pci_request_acs();
>  }
>
There is already a patch in the mailing list for this.

https://lkml.org/lkml/2026/9/3/1930

Thanks,
Sunil
