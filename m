Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950DE36683B
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 08:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779264363; cv=none; b=RtSbvBrZonv/sMuRGt6kixZ1Rd5ArTrMuvyoJwQv1aONAqDExp84QveY5fC9mKjkS/Vl2ExKUrgaZQ6gtaq3YUSrCQ1Ne100G7qln2WpFRZjZI89LAuwoNDQzbxnf81BTqr8MM3xjs7M3NTGLsM/Ek34dQdGBa7r20xlO/hmwM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779264363; c=relaxed/simple;
	bh=KUaCdDomY2qU9nG60VsZNCEO7wba/w9qv4eRI81YKo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tApbvE9kJpphusAQn9Z8ICqEyFiHhqiKAt0VYSkZO3zdwIYPZJr1Ot9QTMAlCP8VzYclKDje/tt+cU05F+losg8eezD1ShC6keCKZQlXEURUYQnKnZlslVhmKeH3qvEzy0ObyIF9mfKUrLsH43fpGFQdCIDoiNXIojvZoYm6aSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZaRSheFu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XWekdPmp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZaRSheFu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XWekdPmp"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K719Wd2984348
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 08:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h4o4tguLJ2M8UFVCSQAOmrgjGYGYAaNNp+BkOJSYljs=; b=ZaRSheFuPELGrHrU
	5bq5fVMfyqResKiQ70JQ9GcmVcwVO++BNdtAGa8VE2RcuXKOS1fdXMzwTJtDbph5
	Kdz4noyWWRWd6d23UxPQMSbSlVPYhaCaEpU8/dR7MIrPBCAKu4u2eeLWD7A9h8Ru
	U3reVb2kI1+5mBFvP29oQxg4eDYm25BSrQS33OCcAsX2dxLWXMzwkxEAzAllr/T5
	SbMuaMtk4zoKuAm4QahqJUCu0TasoEKPmouhj+BzAYKQPlph23Nquuv+5EWqtMuO
	plY7E2DXbNgLQ53IfLC/cnaAcIDD30ZwYB/zcqQY/p+D8n8MDMmrXgdUON6gqfI7
	uk+kjg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3t3scw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 08:05:54 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36781927b4dso4879610a91.0
        for <iommu@lists.linux.dev>; Wed, 20 May 2026 01:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779264354; x=1779869154; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h4o4tguLJ2M8UFVCSQAOmrgjGYGYAaNNp+BkOJSYljs=;
        b=XWekdPmp/ZfoYuUH35B5QNo78OZzszgz40m+Nc9R/TBXvHWM9ufArFM5RMXBSluqXJ
         wqNjI3cahC3lLwEJJQiiYc9v/7SCTDqLFmQFg2qeqLri06K4r7N1YTnEp5/jYe7WtzYz
         i0CDGjSaDL1G0g9w5WE+oCUTS5zEO0hOq5wOjUkkT/IYcPyLdb2to1M5S+wglaRvsQCf
         5PJGQA9noe2yGqKUJ/bFkMcD+EfyzTSlbaVTb+8zP0SUHWqoNTc5x9brJ5y8UWQpT6mW
         8dsfjXrzOcLq0euJQqJ11PbToRHkrAWba2j5teEymDWd29n76mSWpt6CI+j3FbHNLSbP
         XtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779264354; x=1779869154;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h4o4tguLJ2M8UFVCSQAOmrgjGYGYAaNNp+BkOJSYljs=;
        b=tNDFR/W26GCkFAbp54qHimP9wj0jSTj3IgKuBaDIGwyPskuFeujnspV9zszCSytSTo
         8FIwBJ7cyXV56mmJ2yIlnDOOKRDga/M164lFpSgkon6Z67H9tm1AldQR88WXrFU15qzV
         +2E6VYpmQOqxm8pB8SKdhCzsOZSlqSH4fqRYpx/MC21rm/utwLJp2VoO5jhpLduQ4s+B
         NCKK/ynwvmsXEtN6WeDidAu+6HsdqVZbTWSWXea174WiMykV0aNAyudUsQNC832+uSsF
         6zmRXdUBod8Q4jtWjQ6cyDZPZgJwp31jVe3Ml7w8Y8of8ZybEdOHaprAhc5TUZKD+OBa
         RRhQ==
X-Forwarded-Encrypted: i=1; AFNElJ84Kd79RBms0S4JYZuL9grhhSW3ioC/iBanuMbKcryEl7ByprbpkBSJRCVMoTyt8iDiSNYL/A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxi0CixX1eVjB59/SReQol7x7c84jH5D+Ba6ye/oLW82IN6SW34
	xMJWO9chysOxRRyadM67KLvX3xu64TzgRqFXmP2PsU4UXNHenkV+oOL+fAzUyHCeYevc3pqFOEt
	Nj9DKGXmn53W75kL1o5S3qKE9pXUPZvffQ/wu/hlkTe4iJ72vrmZDWHfewA==
X-Gm-Gg: Acq92OH7B7V4RXAnKcpl43fxY7rx/a6jK1mySTYovtqRT0Q382hboQGDtVnLDrbX1/A
	gCRPG3klsm7YWzaMo8uEGie5APKMNm2l+A+kLQOy9+dsgngs0qO8czCanmO0x+7yz0+de4Sbzaf
	zXvTLXVbqmxmWDBj4pwWQFr0PGU3yb/0qzkuE64++rt8QQNLHypQM5uhEPdSMPjz1X4iZuyttWk
	HtnACI7Yxx9UfjjCAt2YkcxDNWOufCJrM4YlVUnGrkcXh758jlkypteysBNrA+KU5d7ElHNaLqX
	4VOXaZz8jhIioi1pIsrvZFshCKdt01N/6VQfZR0p1F+7UEk+wGkS3ZAkKDV6vukhgAO1Xx4vZdr
	2cUYSCIwGOJrjG6lU3yrb7rAnXi8LvKbCKaJwZZxZlVwPKqEYzCxSIJvlGOwkybiEcIA=
X-Received: by 2002:a05:6a20:7d9f:b0:398:ac0d:9a0b with SMTP id adf61e73a8af0-3b22ecb031amr25955131637.50.1779264353658;
        Wed, 20 May 2026 01:05:53 -0700 (PDT)
X-Received: by 2002:a05:6a20:7d9f:b0:398:ac0d:9a0b with SMTP id adf61e73a8af0-3b22ecb031amr25955066637.50.1779264353199;
        Wed, 20 May 2026 01:05:53 -0700 (PDT)
Received: from [10.219.57.109] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb11683fsm18637582a12.26.2026.05.20.01.05.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 01:05:52 -0700 (PDT)
Message-ID: <11b91838-9b24-4a62-8760-fdeb3703afc4@oss.qualcomm.com>
Date: Wed, 20 May 2026 13:35:30 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 0/3] of: parsing of multi #{iommu,msi}-cells in maps
To: Rob Herring <robh@kernel.org>
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
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
 <krzk+dt@kernel.org>,
        Prakash Gupta <prakash.gupta@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, imx@lists.linux.dev,
        xen-devel@lists.xenproject.org, linux-arm-msm@vger.kernel.org,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
References: <20260424-parse_iommu_cells-v14-0-fd02f11b6c38@oss.qualcomm.com>
 <20260506221915.GA3290640-robh@kernel.org>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <20260506221915.GA3290640-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BOCDalQG c=1 sm=1 tr=0 ts=6a0d6b62 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=zmrd7r8un3QtD10oEDQA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: USyo1MG-AMqTJDgBHHGoo77gZ_cgUUpJ
X-Proofpoint-GUID: USyo1MG-AMqTJDgBHHGoo77gZ_cgUUpJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA3NiBTYWx0ZWRfX/Iy8S1ZG3mn5
 Vp7SQZhEXbok5X7CPGT5Oga0XXpuZJFzjeBa1sxLdvzJrwbhEzPnpDYZaRhT+ueZZ68LLS4YH6R
 FbvZ3wyGKxzX6TpAVBZLTs2aH6lvDcCCyMye66eWK0WWwZMUt1pxYc3WvzoNvujQOUY5O3eELFU
 TTNmXGImHKphyrJ3Sdr6lxrA3aZIkRLaSTsDA6O1vLCwQ8LxcImG/HylWzk3nFPZH+Q1y49h6Un
 RoFjZ+oxPnpl+dQ5OHcfx41lOv044oJKZiiMnDjpNH9oydkJ8OW6PvVO7PcTyFQiInVnw2OLeqi
 n1AOCKUCsELIkBX0bDZsugyUQbTXbph0gsdjMqxdBFeW2d0tolMPUvqBgVaUI9O5+gaO0+IOYxe
 9Sq/kU/z4kX2cZ49LCLV4OKooSf6obQMuUcsYWlZYSExLB/dwtdL4/yACUJhqDa5d676/0IMgrO
 ThpQMCP8LSx/V+nQnXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200076



On 5/7/2026 3:49 AM, Rob Herring wrote:
> On Fri, Apr 24, 2026 at 11:26:07AM +0530, Vijayanand Jitta wrote:
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
>>
>> Since, this would also need update in dt-schema, raised PR[2] for the
>> same.
> 
> Sashiko has some thoughts on the series:
> 
> https://sashiko.dev/#/patchset/20260424-parse_iommu_cells-v14-0-fd02f11b6c38%40oss.qualcomm.com
> 
> Rob

Thanks for the feedback, I have Posted v15 addressing comments from Sashiko.

v15: https://lore.kernel.org/all/20260520-parse_iommu_cells-v15-0-b5f99ad4e7e8@oss.qualcomm.com/

Thanks,
Vijay
