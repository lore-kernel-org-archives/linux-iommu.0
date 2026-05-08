Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734A2397E75;
	Fri,  8 May 2026 13:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778246258; cv=none; b=lOW4q3l+1AnFBUAB3/Xm23CcEv6iLEIHDoMgop303VnzeY1KjeeXPEW+GBQEhn27DDfBHXRTIkHLvrFx97INhKCCv87XmAMOKHc6b4dM/3+jjGb7yDifSRKDXJJfzsBkSTvk6uQx1Ex6IN5OqAzjn5DESj6yx+S406yfAZG8/Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778246258; c=relaxed/simple;
	bh=NBRn0QSouTTKCK6mdhZM30u6gsTSFX5dIaekbwACZcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRPI4OkE3DGe7aXJjwny/0Hvf3QsufLJ097XSJCAccLuAd2vWGVSw4Mo8aQPBzREjJhQqHDZyD1BWXUcmCYbH/xdVtZbhKxZNVLxEnI3k6D7F4fR/9yDYYmK9xQzzBm20vMQ2aE5ffthexHGD4kLsJv7GskZ45pEoWT1hd2zE2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lFrMfNaJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lFrMfNaJ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648CKRml2578306;
	Fri, 8 May 2026 13:17:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=kQ1VvPGimWPLCqjnA9N2xJzCCYSk4u
	BHMR8guZBnBmg=; b=lFrMfNaJpkYOuZ6QhMJjMHecduAbeOep8fQcB0xBy3z96b
	OV0bb2JO8N1ToCV/6pElX3yFRol/kYjTlwQ0xo+4Rmdj9ccC330u/WkuGTynNC9F
	Ida64JN7tHfKq9VZ/Zj2VHnvoX934WdtGnY38xBfvUCy/VpLoxFo/5anmBdLDZJN
	rycNV5eegzRmRbd0akNEAwqjtWsWQiQuMMdG2CzGpcC6NT0FTey8es+YHNTogonL
	QXX9PhZWU0rZH1kfH3FMdlq2yl88NjDorjeUNc+BmO4W+guL8nvnfi1WWqh0IlnV
	Zsw6plwqyAASD9nnRFaqWh97auSe4vO34znTGAZg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y52hyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 13:17:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 648D9U6r025665;
	Fri, 8 May 2026 13:17:20 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwvkk8941-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 13:17:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 648DHItV42140036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 May 2026 13:17:18 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B90B02004B;
	Fri,  8 May 2026 13:17:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 315ED20040;
	Fri,  8 May 2026 13:17:18 +0000 (GMT)
Received: from osiris (unknown [9.87.147.123])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  8 May 2026 13:17:18 +0000 (GMT)
Date: Fri, 8 May 2026 15:17:16 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@kernel.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/2] [RFC] debugobjects: avoid gcc-16.0.1 section mismatch
Message-ID: <20260508131716.73223A2a-hca@linux.ibm.com>
References: <20260203162406.2215716-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203162406.2215716-1-arnd@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEzNiBTYWx0ZWRfX1CcvH+JiyWhj
 ukpvZfA0Ngpw9mVXBhHPt92Wal98Zg0zCLk4lCB29/KyiCQBtGIL46kybD6nxDN7gCZt8pPnnTX
 QfVSLP6/o+3/WAcAm/NPoAVlzykTUICMAi+QdDkHZoHnCq3sZ9CEounDOSD+2AuT5loESjI2xnm
 QF8qLI08JlWfou9oqEuFwuvPdcCYYZNAMjjfT3HXusQL+bhKPiNkkZDuvQ21AEmTO30NMwWhdwZ
 dRvGBb9N8oMEolfjDGyj0k3AojLOJmH/9Bs3KXWfTqp8Shn5SrVi8OT97qC7fVaIVqhzQQvj4/S
 KlhNGxk/vEmANeMWYjTzhhtH9kSPH0M8XiDR1ctqQxuomRG9qDBe9A1hHr5KI6IqmjmigaCxBUb
 SmeVXMdSsFI6Q05jZ+9PBnUliJ1DPvWX1P2xRE6pzaKKHedUHP5VG37tc/9qZ/FvMoHF86FaQB3
 0R+ddzsNRLiiFPr9EOw==
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=69fde261 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=Dd2KEV1C9IK5qE6hSXAA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: zgu7XtzBP35Is-f0VZQqdtj2nSaU3qCU
X-Proofpoint-ORIG-GUID: zgu7XtzBP35Is-f0VZQqdtj2nSaU3qCU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080136

On Tue, Feb 03, 2026 at 05:23:59PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc-16 has gained some more advanced inlining techniques that enable
> it to inline the is_static_object() function pointer into a specialized
> version of lookup_object_or_alloc:
> 
> WARNING: modpost: vmlinux: section mismatch in reference: lookup_object_or_alloc.part.0+0x1ac (section: .text) -> is_static_object (section: .init.text)
> 
> >From what I can tell, the transformation is correct, as this
> is only called when lookup_object_or_alloc() is called from
> debug_objects_selftest(), which is also __init.
> 
> I have not come up with a good workaround, so this simply marks
> is_static_object() as not __init. Since there are currently only two
> files where this happens, that may be an easy way out.
> 
> If anyone has a better idea for how to deal with that, let me know!
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  lib/debugobjects.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

FWIW, I'm seeing this now on s390 with gcc-16 too (debug_defconfig).

> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> index 89a1d6745dc2..056957c4e52f 100644
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -1195,7 +1195,7 @@ struct self_test {
>  
>  static __initconst const struct debug_obj_descr descr_type_test;
>  
> -static bool __init is_static_object(void *addr)
> +static bool is_static_object(void *addr)
>  {
>  	struct self_test *obj = addr;
>  
> -- 
> 2.39.5
> 
