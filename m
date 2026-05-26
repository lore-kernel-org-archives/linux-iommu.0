Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FF23D79FF
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 09:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788772; cv=none; b=RMXE7Jx+3YBsVAdq7AFeEjcSZAsDyWla9uPdNuPydjSccadXxkl0aLq4ws5gyxkIrsSXAhXWKINr9MLjghrmveH8h7BOF3j8bJorf+TKlf4JUirvcdmyh8rE3olDgnJeQKzNueQ9LjJa+oAKcEvWrvY2b6/YC8mx7Mpv5XHxKPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788772; c=relaxed/simple;
	bh=ZCAvrcBAJIXTnHEvSKz8Yq0JKkscj5TsSoJRyS3heaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PTlGQgBGtm5tCZe1Trck6lIlz6jURNIcNpLwRTFtQfLdxbiOThuiRs/lbfxVOOtWsQhmVx7njQGjB3N9dNl7PMgQG0Sq8Lsat24oo6FFMrJ0cdGMGHc37yldtP5dgCAoAPXzpgJrGcaME6qmBxnG4Cs5liZKVmpnyU6DMQG/8bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fr1+vbDE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T0dAxKgD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fr1+vbDE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T0dAxKgD"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64Q8exBi4117909
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 09:46:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+tNWCjXxY3vDlbxeyc6dAiioLTzJiUtHmEfK77uv8QU=; b=fr1+vbDENVQY5Zkc
	AWKEyhljX0yFvxH6I1SvWUMTfp19xN/S0yh+TGoyD9Cl2mMP1B+cxYr4CMbB+3HK
	i6mgb6GJt0ChQnVW/edYstQ2ZQ/3qEyz7787O7HhTjAw4XPZE3hs5gii8npI7Amv
	SV4YTLdzF9yQsyRYbZhe8MXQpEJ8I1OBPDETlM0oT+VsBZIO/86gjRfEn9vRxRhD
	fa7RK+Fn5PB0Yls+1QT2cAgdVoCp2+ET9/qfV+TNX1+bxgF2y68cg7pgqK+nzx0o
	z9PP/dkyTpf4v2k4Ml/cIFZEvKeM5ltrMipw4x5NALhFjWWhKMw9d8b7GJjlf880
	lK0fmQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecqudb8pu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 09:46:09 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2bc6899bfb1so109017425ad.2
        for <iommu@lists.linux.dev>; Tue, 26 May 2026 02:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779788768; x=1780393568; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+tNWCjXxY3vDlbxeyc6dAiioLTzJiUtHmEfK77uv8QU=;
        b=T0dAxKgDfEDoBnXif3zQrP131tWG4YzmgHiRIyE0zlklmtLcJ9yGyxZMWg5pDyC+1J
         /zwnvcYZvz2UlGz9NiESWjAb27F8/Jw9DGItGMOz/khmMjXvRiCjktW59KCdp2EPJVmJ
         nRtkbhF9CbeMO/lx0tkH+aCWaERSxBKUECyVpwxCKnAjlUhkQpbc5EeTVaC/O3wDAPL+
         8B6CnxnziBr1cKQ6KwWTDP9jnZs2BzpGkxu9XPH+LkovrofSPSLJuwGPYW8GzVTUzZiC
         yyTBNDqZksRdSWlvcVFX56PVTaVnp2q7T3a0O8N30Fpwhr/xD6+M686cvhXD+L845R2P
         Y6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779788768; x=1780393568;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+tNWCjXxY3vDlbxeyc6dAiioLTzJiUtHmEfK77uv8QU=;
        b=WowY479GDmUEJ3ICLLyQWEkX28hgjSwin2kUeN9KtlLC+4XRA7ipC6+EynKJd4Nh3G
         /XU4sqeZ7ubWsJpxitht2li5JVufHMx6CwUyka+Zq1osTFjyGXpnYZ2+zwj+AJcAT9XH
         PJDEgShlW4xU3jMQUT2vx0sj1bF10hqJ1GbZJHZco326haDrJRbA6cWqbmBvEIaSmsmb
         ef0ILiZcmguSZHp16elf7lSRhd2RTWjmUMaSgcry6yBHudBnGGUF2VNc1NcZnwxE6625
         Bj+rPZnCAKg/Iqbf3lk60e4/bjc+yaYNJd14jeIZu39GDvYM64e+R8ouBCbOjrrsRBL1
         ViRw==
X-Forwarded-Encrypted: i=1; AFNElJ+t1Lpm+xgouYOs244lKA6r/50tvR1djDRGzaTeyEsjb2CGZ7lGeTu4kJsHGMIyoR/Jviy+Bw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzB9/rSLdC90KwihRq9k6Gyl8SfOriSlKRzU3KtRpCcwWNFTeCA
	m9Y0lf374WnKQcm8Zaf+fzNsUPhXi6RZfRAEohE+wtKA+gR5EbFcMD3hkF3bDNkS+ufuhFEn9OI
	t7k6y1bhV5zpr3Lb43Z0DwbSSJiNm6JjqK0aTGZXXisNUBOr+Mco0j6LVlw==
X-Gm-Gg: Acq92OE7hiqVIiRcDqyYEc6XzPKcFRzAr+Ev0Sl6Pivof7ERxQsxbqhqnXazSS9Ye0d
	O9YEwjFAPkeUp2kzKRUMIegWk4wH0bLEV88FvfprFeaVs3/gdAjZoGyo+x3KimcGEwwFS//nR0M
	llZqmsS2qG6G/V0G0+chBwS1hJqWbjPYTBrjW6k+mdyQjQwXv0mTEeU1jGNrNoy3SRNXTSkv0bs
	9nNNbQ+M9H9pb+1dL8nM5w3o8/f9j4DsxEMv/fQnpA+MWVodguWWl+InFArBZSBQRJEaQ3ufNse
	d367nJ1zenrLr/GFrkFDWst1oLk50Lxm+rOSzt9y95aGQyUd4PY09kFqY7cXp+Jcyj8lYMTUBML
	Z0onc/FaWTTJzDiDyId5ra5981JfSwrYKfVdqp80eoqJsz/RDYr6jpdi8
X-Received: by 2002:a17:903:41c2:b0:2ba:e42a:231e with SMTP id d9443c01a7336-2beb064837dmr200645605ad.37.1779788768357;
        Tue, 26 May 2026 02:46:08 -0700 (PDT)
X-Received: by 2002:a17:903:41c2:b0:2ba:e42a:231e with SMTP id d9443c01a7336-2beb064837dmr200645035ad.37.1779788767805;
        Tue, 26 May 2026 02:46:07 -0700 (PDT)
Received: from [10.219.57.109] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58b2ebcsm121223885ad.49.2026.05.26.02.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 02:46:07 -0700 (PDT)
Message-ID: <f2eb5c9d-a78b-401c-8796-f7ef7a8d7386@oss.qualcomm.com>
Date: Tue, 26 May 2026 15:15:55 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 0/3] of: parsing of multi #{iommu,msi}-cells in maps
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Nipun Gupta <nipun.gupta@amd.com>,
        Nikhil Agarwal
 <nikhil.agarwal@amd.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas
 <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Prakash Gupta <prakash.gupta@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, imx@lists.linux.dev,
        xen-devel@lists.xenproject.org, linux-arm-msm@vger.kernel.org,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
References: <20260520-parse_iommu_cells-v15-0-b5f99ad4e7e8@oss.qualcomm.com>
 <20260526-finicky-crafty-hare-eae27c@quoll>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <20260526-finicky-crafty-hare-eae27c@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: DSbysjJheoQyuRrHjy8fFZY565c1AXcz
X-Proofpoint-GUID: DSbysjJheoQyuRrHjy8fFZY565c1AXcz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA4NCBTYWx0ZWRfX9WQ84rbT8ehg
 iAEzyDU/fyCYCtF/8wXlDvQB0YsTbDZKSSBGUSBdgf7soF7cu/QtmIALInOr80G+WoVGxRlEnvc
 +8nnstt4w2WZsLh5iN2zSaWh9t5UAJKe5Hu69vJt41daok4lZUt0M/KZRRpIb12IeXIcKUD0ZTe
 MV6Z6Q+mW6eGnRMcDsqPKILRVUjRPOn+isNFP+oZohlONmjyu/stVWcpqEo6o6SySXKeyHVJom2
 tzKIrCK/+Sj7+j3tpL6GMWRQ1lmyalQp6nRgiAf/ktMZaytvINvfWhUQNPYGiD+0dLmLIVZDfbs
 n7vzQo46EL3PVngJ7WKUKh5D43/q5HsJq0/akYza/+7v5vYDdotk/qK1aGk1RnTn3bOfAtKLRND
 NB7qD4MalbXcGp+4as1+3FhSKWw8h6SbTPBsBDkkEdc+0b35PwHrg1qKt8rTLBNC56TuP35DOWu
 cDd74epah/+uO/AFl8Q==
X-Authority-Analysis: v=2.4 cv=C9jZDwP+ c=1 sm=1 tr=0 ts=6a156be1 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Jo8nEopC4ZUABtMbiE8A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260084



On 5/26/2026 11:42 AM, Krzysztof Kozlowski wrote:
> On Wed, May 20, 2026 at 01:32:39PM +0530, Vijayanand Jitta wrote:
>> So far our parsing of {iommu,msi}-map properties has always blindly
>> assumed that the output specifiers will always have exactly 1 cell.
>> This typically does happen to be the case, but is not actually enforced
>> (and the PCI msi-map binding even explicitly states support for 0 or 1
>> cells) - as a result we've now ended up with dodgy DTs out in the field
>> which depend on this behaviour to map a 1-cell specifier for a 2-cell
>> provider, despite that being bogus per the bindings themselves.
>>
>> Since there is some potential use[1] in being able to map at least
>> single input IDs to multi-cell output specifiers (and properly support
>> 0-cell outputs as well), add support for properly parsing and using the
>> target nodes' #cells values, albeit with the unfortunate complication of
>> still having to work around expectations of the old behaviour too.
>> 							-- Robin.
>>
>> Unlike single #{}-cell, it is complex to establish a linear relation
>> between input 'id' and output specifier for multi-cell properties, thus
>> it is always expected that len never going to be > 1.
>>
>> These changes have been tested on QEMU for the arm64 architecture.
> 
> So there is no real user for that. That's unconvincing. I would assume
> that at least you have real user where you test it.
> 
> If you want to speed up acceptance of your patches, then also I would
> prefer to see at least one more user, beside Qualcomm. IOW, show how you
> solve other people problems, not only yours.
> 
> Best regards,
> Krzysztof
> 

Hi Krzysztof,

Thank you for the feedback.

The upstream user for the multi-cell iommu-map support is the Lemans
platform's VPU device, which requires iommu-map entries targeting a
2-cell IOMMU node. We are currently working on the glymur series [1]
and once that is finalized we will post the Lemans patches as well.

That said, I think this series can go through independently for the
following reasons:

1. Correctness fix: The iommu-map/msi-map bindings have always
   specified that the output cell count is determined by
   #iommu-cells/#msi-cells on the target node. The kernel has been
   silently ignoring this and assuming 1 cell. This patch makes the
   kernel respect the binding specification.

2. Backward compatibility preserved: The of_check_bad_map() workaround
   handles existing deployed DTs that target 2-cell IOMMU nodes with
   1-cell entries. This series has been tested on the glymur platform
   [1], which uses iommu-map with 1-cell specifiers, and the existing
   parsing continues to work correctly.

Thanks,
Vijay

[1] https://lore.kernel.org/all/20260515-glymur-v6-5-f6a99cb43a24@oss.qualcomm.com/
