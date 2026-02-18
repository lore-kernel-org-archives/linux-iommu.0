Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A82226461F
	for <iommu@lists.linux.dev>; Wed, 18 Feb 2026 05:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771390898; cv=none; b=XGdFKFPEDEp3kvAC5On6LG1YvztNMzm5lT/4lwTqEdJjWzNRlWOAcruAC+qwdud945oL46gdfF3ivZpYqdeqYy+Aa7aREGjOWwvHDlQq2kxoeXdzR9bAppGgwtInfup+F9/5AAxVt3qGw5dZp76kmAPfW0Px/rXNIRUBFUZEms8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771390898; c=relaxed/simple;
	bh=IpXbrC61/fq9QXKuA8vNqJv6ogdbFJyCwrJ+zr6Jr7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hWiV96xJwxp32O6ITMeUYcFia+SNwwj9kA+sIPt0guokQglI31DxAg0Cp1Zeg1X4WhzF1p1MFbl5SRReEjXuCgTd+/vupoz4oZOTisCVfES73tbyGfVEYaGZGsgEJEWRy+rQLIG2aQzqkOXxBbjOoNu8JlJt1IS0v+8sAxsYTSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oWHRATlP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HDTqrhmn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oWHRATlP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HDTqrhmn"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61I0tmgD1168070
	for <iommu@lists.linux.dev>; Wed, 18 Feb 2026 05:01:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jO11N00KLBiobLQAubKnwu0ldzywWFwUTepoHLqvWF8=; b=oWHRATlPey5V9xdj
	wwM76sugMwaqzJYAkaYwcbCofIbmzJZCcsL8AQOw++JEkZbvRN+a+KTkRi/5iLdP
	puCp3KC5jwtpyATmnOdjlHyX8n0z5UbFOkBtb+JcpdCDmaMQ6catAjgTotSb8/B+
	K+2BxzTnbrYfzM5HSLPdT5Uqcbbyk1obxd7go5hql/f263ecFxX+m2Oa9XYjT78+
	e3mp8A+8xuVqYQLDDeIka2wSXhLvPbN4XxCgs+clxB08Oh0Yxt8b9oZnL1uQ0M2z
	Qh3wvmnqrhzHQFZHJBCIIFKLqg7vWGZpbfj06FDDyyQ4PVKTgry6rXY4BnxMv28r
	ay3QlQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cd3ah8e0n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 18 Feb 2026 05:01:35 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a784b2234dso275194335ad.1
        for <iommu@lists.linux.dev>; Tue, 17 Feb 2026 21:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771390894; x=1771995694; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jO11N00KLBiobLQAubKnwu0ldzywWFwUTepoHLqvWF8=;
        b=HDTqrhmnZNH0qBGBDbA/rCB7M9P4QsRzIGXafg+3CGU/L+Nfc9eobqxv4DGJRTb7S6
         /po+NFtFE1uR2BC6bY2qsaue9VD0nZhbgKf+1qrKej6YzZt695zIoBt9ZqzV2ItYriT7
         ME6QpX1ggMeJaouHv4XBDH7Yah6ggi5gC23SNfbd5s3IV1qAnQQD7PQB6MRS4dSzrmG3
         kibnutivmQ3641ZLy5WbzgOWiKUKLunzO+V/j/qW3lCGJI8hwjVxzkdd7U5nAuMKExjN
         1ZpNTW4Gyx6ZFj0ycLo0WyIgRvze1/LtATNo1B9M4/5zPGT1DxfD4MYWoUJrT/VWVMMq
         twGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771390894; x=1771995694;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jO11N00KLBiobLQAubKnwu0ldzywWFwUTepoHLqvWF8=;
        b=S9ULO/zFczGSdt0Q02cy+5aloiOOCzB1pCgMAlQfcBYMYyVg3gIqoq5RnJ5i9RDIX+
         sdsq0FgP7Wwb+FmTl70TboIywPuB8n/wd2AQdwQdHtLrU9Il+Qoj/5qb5kHMT0NbW4cX
         8LN2zY2O/DXCMmrG98ujFFeaiiheTszz//61LugRjEI9S6yaoyQ8MiuI7Og33vobvPuU
         W63tYf7Gmpp7JkfEWl231PdYTmH+EZeTjtjT7E37tbPaYhvOqLmbCNzCQgjRKMgKlL8E
         We867bfx/SYXqolL5/+tuJmCCxwGiEg6ca8v6UQRhYm2WCHVxNV+taUnQ4/IEv++kGDJ
         vheg==
X-Gm-Message-State: AOJu0YyOnNbUFNCvTd4kQfM3onoXn4AcvrpLB2vlLvjNRSlaJUsqsGZ9
	nZbRi3CVD4Bxq+BuxRMFRL6bMKaThwan/TCgNl+VkbqRIhlde0L7o7WJ9ZnGEES/4qhUaymaJWt
	KdTv7E3trUs7ylCGQGb9/D0SHkNCMK0VhbR/LrK8+JMg9k6kOs8UT1Ft0GA==
X-Gm-Gg: AZuq6aLJkrHe/L4A++BALi7RW4GTFuUwfuRQwyhCFAg568hKaBmVQs5ROTd7FwnEe9d
	r4CFywe/9+JSBrqwt0HVLbMU1S1D+BVGgmj/jMg2v4/0ktqNNmJXH5S30hI/FlHmMst5Emqi2HK
	3Gpxx+Ybe0+tH2wjOe/qTxO2iJRKFdRWY113dYz6uU/Iu7XmZyVC9gaMZJQaQiFIxH3eA4IVjZM
	0c2EjHIQmZ4+pDQDmgU9OlnlPWFOWzfpaSznxac0f8H8jrevXxFanyLY7wnX6bz5Ebet0pozVFP
	xHs/zp8dDNjNolnPgGCER9e3ZnLloN21npo3/In6N150kS8Fyxutvzgi7duVNg+45sSyHYLrRZD
	cRmSAbS2vWgZmqhiYE2LO35zMayb/j21QNPZVVbBnqX6uSlz/HTEsFTe0
X-Received: by 2002:a17:902:f549:b0:2aa:f0d6:bf59 with SMTP id d9443c01a7336-2ad50f33fc6mr8541395ad.35.1771390894356;
        Tue, 17 Feb 2026 21:01:34 -0800 (PST)
X-Received: by 2002:a17:902:f549:b0:2aa:f0d6:bf59 with SMTP id d9443c01a7336-2ad50f33fc6mr8541225ad.35.1771390893896;
        Tue, 17 Feb 2026 21:01:33 -0800 (PST)
Received: from [10.219.57.109] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a713e8bsm163530905ad.28.2026.02.17.21.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 21:01:33 -0800 (PST)
Message-ID: <f3c8513c-e249-4dcf-aacf-785f9ba2427d@oss.qualcomm.com>
Date: Wed, 18 Feb 2026 10:31:28 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/3] of: parsing of multi #{iommu,msi}-cells in maps
To: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, robh@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, bod@kernel.org, conor+dt@kernel.org,
        krzk+dt@kernel.org, prakash.gupta@oss.qualcomm.com,
        vikash.garodia@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20260211054033.2796660-1-vijayanand.jitta@oss.qualcomm.com>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <20260211054033.2796660-1-vijayanand.jitta@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Zo3g6t7G c=1 sm=1 tr=0 ts=699547af cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8
 a=LNEgvAdLbYxa4KfAdnIA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDA0MSBTYWx0ZWRfXy7Gapq4vcKJ8
 aj2WW6RGHX7m5iqQFRc+UdK0cqbz3ey4TN6KhTqwh6kdfIEevvdRBxBoofnf5K11dVZ2/n/RrUW
 /Ktm6JHrmpKhs2j6spMJ4/dmBKZKlMjLBF+jB/RrtU4YaAUby9EfJCyX8MgXXe1N4M7VbzFb9/M
 +rnHoZPe2aXIS2bfQ0jFOeqxC93ofLdikF1sYG7yt6X2farYX50gExFH2Tm/CyLafrlUUn9LfOd
 XsdcRFOXp7Us4cSyeul65vTbKq65g94tt0LhyqTtnpdmASsR1bcXEwhnMvVUm/g6HI17PYNoIJG
 zBYXMGOlVvBt3E9IyElpGFi0A6TAnwinwK+dS6togpuNn5ZloFTZ7cv8GV329sXjpaaL9b90+GN
 EOGN5HLr3bRzjOOByUktZh8WPoyQnJtHOUKHFvBoVRgKufT4OzPSg9F6fy2LF3fgYh3uhz+20TO
 5gU/ZJE3E77NEW62UsQ==
X-Proofpoint-ORIG-GUID: yfGoRTP3spRrFMqQvnRrqGvrrGAwC36k
X-Proofpoint-GUID: yfGoRTP3spRrFMqQvnRrqGvrrGAwC36k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_04,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180041



On 2/11/2026 11:10 AM, Vijayanand Jitta wrote:
> So far our parsing of {iommu,msi}-map properites has always blindly
> assumed that the output specifiers will always have exactly 1 cell.
> This typically does happen to be the case, but is not actually enforced
> (and the PCI msi-map binding even explicitly states support for 0 or 1
> cells) - as a result we've now ended up with dodgy DTs out in the field
> which depend on this behaviour to map a 1-cell specifier for a 2-cell
> provider, despite that being bogus per the bindings themselves.
> 
> Since there is some potential use[1] in being able to map at least
> single input IDs to multi-cell output specifiers (and properly support
> 0-cell outputs as well), add support for properly parsing and using the
> target nodes' #cells values, albeit with the unfortunate complication of
> still having to work around expectations of the old behaviour too.
> 							-- Robin.
> 
> Unlike single #{}-cell, it is complex to establish a linear relation
> between input 'id' and output specifier for multi-cell properties, thus
> it is always expected that len never going to be > 1. 
> 
> These changes have been tested on QEMU for the arm64 architecture.
> 
> [1] https://lore.kernel.org/all/20250627-video_cb-v3-0-51e18c0ffbce@quicinc.com/
> 
> V8:
>   Removed mentions of of_map_args from commit message to match code.
> 
>   Link to V7:
>   https://lore.kernel.org/all/20260210101157.2145113-1-vijayanand.jitta@oss.qualcomm.com/
> 
> V7:
>   Removed of_map_id_args structure and replaced it with of_phandle_args as
>   suggested by Dmitry.
> 
>   Link to V6:
>   https://lore.kernel.org/all/20260121055400.937856-1-vijayanand.jitta@oss.qualcomm.com/
> 
> V6:
>   Fixed build error reported by kernel test bot.
> 
>   Link to V5:
>   https://lore.kernel.org/all/20260118181125.1436036-1-vijayanand.jitta@oss.qualcomm.com/
> 
> V5:
>   Fixed Build Warnings.
>   Raised PR for iommu-map dtschema:
>   https://github.com/devicetree-org/dt-schema/pull/184
> 
>   Link to V4:
>   https://lore.kernel.org/all/20251231114257.2382820-1-vijayanand.jitta@oss.qualcomm.com/
> 
> V4:
>   1) Added Reviewed-by tag.
>   2) Resolved warnings reported by kernel test bot, minor code
>   reorganization.
> 
>   Link to V3:
>   https://lore.kernel.org/all/20251221213602.2413124-1-vijayanand.jitta@oss.qualcomm.com/
> 
> V3:
>   1) Added Reviewed-by tag.
>   2) Updated of_map_id_args struct as a wrapper to of_phandle_args and
>   added comment description as suggested by Rob Herring.
> 
>   Link to V2:
>   https://lore.kernel.org/all/20251204095530.8627-1-vijayanand.jitta@oss.qualcomm.com/
> 
> V2:
>   1) Incorporated the patches from Robin that does the clean implementation.
>   2) Dropped the patches the were adding multi-map support from this series
>   as suggested.
> 
> V1:
>  https://lore.kernel.org/all/cover.1762235099.git.charan.kalla@oss.qualcomm.com/
> 
> RFC:
>  https://lore.kernel.org/all/20250928171718.436440-1-charan.kalla@oss.qualcomm.com/#r
> 
> Charan Teja Kalla (1):
>   of: factor arguments passed to of_map_id() into a struct
> 
> Robin Murphy (2):
>   of: Add convenience wrappers for of_map_id()
>   of: Respect #{iommu,msi}-cells in maps
> 
>  drivers/cdx/cdx_msi.c                    |   3 +-
>  drivers/iommu/of_iommu.c                 |   6 +-
>  drivers/irqchip/irq-gic-its-msi-parent.c |   2 +-
>  drivers/of/base.c                        | 148 +++++++++++++++++------
>  drivers/of/irq.c                         |   3 +-
>  drivers/pci/controller/dwc/pci-imx6.c    |  12 +-
>  drivers/pci/controller/pcie-apple.c      |   5 +-
>  drivers/xen/grant-dma-ops.c              |   3 +-
>  include/linux/of.h                       |  33 ++++-
>  9 files changed, 152 insertions(+), 63 deletions(-)
> 


Gentle ping.

Thanks,
Vijay

