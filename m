Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758BF3C3420
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 09:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776159218; cv=none; b=L2ndy0h1z5pfPl509Zi6fm7WwOfbMAcw1uQrHIXE4YuHncMrCpqbN6xplfCDDVOpVVfhERZu2w4T8msFGFds6VdK9N4oi1ybZVCAtl62i5Jni6e/eujjRgOmGFRL5KuNzk5IOSwirp0OM/jZik/vbyTq/+ZeN5p+O/ZXG4Sv2ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776159218; c=relaxed/simple;
	bh=0BPZxwyeCDxt/qQ3n1UlOe0NaqQe38QUBg+xfperdj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUY30Q9k9RYO4XMANEtJjEsQ/sVj+PmVVmnVU+IUIk4yRw0OBeyq8sLWQDHuW+KoSOZscb0RdE+C0N6WhHb+raWGPk/6r5SCZ0yKz9VfD4D5qfykDI9huvmozMY5lk/2yBs4cpcSOh/O+TGkhlt709YQUUel/FSBiW0S3cZAISc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YJKMVZ4A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eb1gBmQU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YJKMVZ4A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eb1gBmQU"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63E6vY573158091
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 09:33:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=mSbqfMc6xRfrir7P9sbbGiVO
	qRkXoiDCed3ZiNBf5fk=; b=YJKMVZ4Adyx6ojrbYHIw6Si593Z37yloSz8aGqg5
	DBEIwsJA+NOP0telQpGWfp1aVu4rf4qRteIHNVjnLk8laJVWRbv6DAQ+VAhJid0d
	dxWWxQg+o3VDoXlpUalH+ii5DSmddfXh2EDnCnex4X3ew5mS/MolJf2LnzOxvnx2
	KyF0LDdv51HTDtvrzjgfYapa3kijKH2fiDjsx0Hd7KMnwbQawoh+TKd67pgfypLT
	IqoYNFyav45qxmUeSEdKcWbNpWUbigULEGQHJ/Tlk3bl4oVKslueF1IE/667PURk
	JxkGxR3dpCIgZiVEfgukf3DlPZCR4zlZvltkD9VFuJcrhQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh86ba2vn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 09:33:36 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b24e9b4d82so44057165ad.1
        for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 02:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776159215; x=1776764015; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mSbqfMc6xRfrir7P9sbbGiVOqRkXoiDCed3ZiNBf5fk=;
        b=eb1gBmQU1CmHIf6ykjqXFXhi0dHlvD8Y1thsEs9sGURuUbB8Z4jMwHENBuuWI0A2h2
         P5oOkfG/Jno37OvmYhBiFvNpXG7XNRRLT2L1Tl1EF0RJbYFNBlzQfI+ZAdtGIU6w8jRG
         xUkhD9HjI7IlXpovxn/Zfbqxn+KsNNNqgi2OUoHPUvMP4MEikj3+s2J6I2kswMCCoJ6u
         nR3TlO+GW6YehPteYu6L52s1jrpR8ivWncgljRjG+xI4VC7Grz/jtgMuNgAuE9uZ0SAI
         UNFsBz69cm74vIz4sZFm/L4VBGgjeXP/vrte9EMzohUnfCJ6CgMPbsuadNu5Pguaqcbv
         /lvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776159215; x=1776764015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mSbqfMc6xRfrir7P9sbbGiVOqRkXoiDCed3ZiNBf5fk=;
        b=isQ8QaPt6FsFdYcUc/6QEbTD0sok8Q31pTc0NK/AsRO3QI4neRSsF14M0sZpImtv3q
         ROVMYHqzJ1zRellILsj6QNirBsrbzZWzpcwj0V2vlSLUraCAmlZT8Ak3SqTHgZcexG4A
         QzqS2+YB0eRI7wgjsLNhj92vsjkHXtLMTE43Hy+7J31n/5X0aueQpaVrngcF+dy1DJf6
         esDnqvZMrm1lREig6/C+3ugxleNxN0x7tNUAAOuagJtOknmvd9MBNQx/1VrPWVWXBUW4
         yUGcg7OE/MyeC6F4snew4MC3UEmJElO9MSJ6F25dkCVe6xCyyj+/rfyd1xdWNi538RxZ
         bqgQ==
X-Forwarded-Encrypted: i=1; AFNElJ8D3j/chVyK133BFrFT1oqT40KI6+wH1XRiJxl2u/qsiwzrnd57wOgkeniMDulMscQ5+kIuXQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXsyDU3OWgKCrHqeeSlrqzKslIt1nHnaAQAYT1mYqbkPG2poR8
	b8NVcys6qgHU8jmBQqzDU9r7u2/LEHOJMxxPzZeOBSgk9AvBETVvuQI0OG8Gq5aDFsAg5ItJjif
	IM/SF1WpD+56/ZGv1LvDeubY2ymUlHLtFS8/mhtjJu1PCEVQzVnuP+SU8jw==
X-Gm-Gg: AeBDievuhErB+DvdPdM2tePoZgk6+Fi89ujk34cZm0bugdANX+oM7g5pLkYjMiiWaJc
	0OEkNQvKJKvgp0gMP3baoIXs8A5z6NO7x0Y7VXJyoByser9zaVCU+RMb6bk7JrF55QSfv9G7Zoh
	a1t+1Mfi3KmYFaud/DAzOZvvCbjCuexKbCrwN9UhgBxyeSkl+mzBZf4aMeSjoJwhY1kEZpeTEht
	HMruxCbatXA/ueR+c7kX6gkDabiV4e4B3Sg9aHYEj5DWZQDu7KyHxSYEazD+uzvOPcKAjFygq9z
	CUMqWP5SCQeuLtdt1mpzb2uxR1lR0b02/nX+QZJl2u5M2tmVAvabgxyD1IM8vFIFZlXMSHw9Cx/
	AITLZ2r0e9gleG3klHkO7NjQ6u8F2ZiXffU154736oUMXaARk
X-Received: by 2002:a17:903:3c6e:b0:2b0:6068:4c5f with SMTP id d9443c01a7336-2b2c7260fb9mr194441165ad.8.1776159215263;
        Tue, 14 Apr 2026 02:33:35 -0700 (PDT)
X-Received: by 2002:a17:903:3c6e:b0:2b0:6068:4c5f with SMTP id d9443c01a7336-2b2c7260fb9mr194440675ad.8.1776159214669;
        Tue, 14 Apr 2026 02:33:34 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b45e949464sm76959135ad.24.2026.04.14.02.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 02:33:34 -0700 (PDT)
Date: Tue, 14 Apr 2026 15:03:25 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH 05/11] media: iris: Enable Secure PAS support with IOMMU
 managed by Linux
Message-ID: <20260414093325.clafqgd367jrqpvq@hu-mojha-hyd.qualcomm.com>
References: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
 <20260414-glymur-v1-5-7d3d1cf57b16@oss.qualcomm.com>
 <20260414063128.6ass64wfi7nmtzti@hu-mojha-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414063128.6ass64wfi7nmtzti@hu-mojha-hyd.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA4OCBTYWx0ZWRfX7Ie01DFAg7KI
 EolhO7UOG5wOmpEnqHbLybKKQyA+JE9f+WU5rQatQhCtqYsysezaJwro38xyAXU2+VbUAfZhIdL
 ECoMw3R4Ed2gzjISePirsDy2RR7dw9UQ8vKi3aIIYhxyjvqHNSgJXGmXuCwktA5vm6CCvmb1ppo
 wp3o1Wr52l1xplodguDehRffMM90mUyfPPqWDMBcRuQkpnvtsbJ5TBeCbuwO5r/Uhj/2dITxOs7
 xiEbtiV93FuPd8I1A0cmg26iQQuMdnrGKTCRmehBJQH6JdsrHiGt+Z/mmWvwJUyqu67+Ic/UoVP
 1KZOkyDLrF1UgZ7Yqqsr3B3KBYVo8yRK5E8/29lvrOgqhsJHYvMAqwymVz3vQCf1vz08kqDuPXa
 +gbVxL0vVaiPMuSPHr6RZN63yWDMEBKlXOIsOV5DWVHoXg3e+allMa4n6PH7ZWsTZJpj51CynAO
 ND1bCys8eMiG3wTRbUg==
X-Authority-Analysis: v=2.4 cv=MahcfZ/f c=1 sm=1 tr=0 ts=69de09f0 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=TLljPvHKC21aDJODJdYA:9 a=CjuIK1q_8ugA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: h_poub95xDmBO3MHySe8LNqrkXnFQSZw
X-Proofpoint-GUID: h_poub95xDmBO3MHySe8LNqrkXnFQSZw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604140088

On Tue, Apr 14, 2026 at 12:01:28PM +0530, Mukesh Ojha wrote:
> On Tue, Apr 14, 2026 at 10:30:01AM +0530, Vishnu Reddy wrote:
> > From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > 
> > Most Qualcomm platforms feature a proprietary hypervisor (such as Gunyah
> > or QHEE), which typically handles IOMMU configuration. This includes
> > mapping memory regions and device memory resources for remote processors
> > by intercepting qcom_scm_pas_auth_and_reset() calls. These mappings are
> > later removed during teardown. Additionally, SHM bridge setup is required
> > to enable memory protection for both remoteproc metadata and its memory
> > regions.
> > 
> > When the hypervisor is absent, the operating system must perform these
> > configurations instead.
> > 
> > Support for handling IOMMU and SHM setup in the absence of a hypervisor
> > is now in place. Extend the Iris driver to enable this functionality on
> > platforms where IOMMU is managed by Linux (i.e., non-Gunyah, non-QHEE).
> > 
> > Additionally, the Iris driver must map the firmware and its required
> > resources to the firmware SID, which is now specified via iommu-map in
> > the device tree.
> > 
> > Co-developed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> > Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> > Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
This works as long as IRIS does not have optional resources. Once it
starts needing mandatory resources like some peripheral access mapped
before IRIS is brought out of reset, it will need a resource table SCM
call, which we currently added for remote processors like ADSP and CDSP.

Let me know if you have plans to add that. I have a few sets of changes
in the remoteproc resource table and an API which we added in the
initial series that I could bring in.

-Mukesh
