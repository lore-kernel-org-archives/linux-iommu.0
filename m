Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED71937EFF8
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 18:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787767937; cv=none; b=N1mI69UxAwJAzvQIp9Cn6kEjzsuoDyJ5bT4rbEtiCC0aIRu+uP1tRSDlXxsEGRAUVUHkJ50JO6Vh4SxYtBKT8dWp3JZ1c5AfUEw2F8nxmM4IObc8OgD7+3l570uHJ4NvqLny0tLv/eyz7fKE2ZnhG90TVIo2hAT7T0uMq74L0Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787767937; c=relaxed/simple;
	bh=U6eDUay/b/Eqbeo4HNFmdbbykpl4I5CvzBRP52g7Cg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHz6rp96QGgG+mGwoVHsN4phe8zYTDPdtdtebuSGK8b9kLj357scArQltHd5oiMF3NBhxTLeKaYnm1W+LiR8YM4fH/YmR8JkMWzBCdM0jQ+zqv81J3ACegjj60yqSIIeNMYLeSFJt8yyLyBfOBoi9TrqyBVaWcLqZwDpppkool8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mut5g1fb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fQGFlCuK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mut5g1fb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fQGFlCuK"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QHIwH51572313
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 18:12:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dSVenvfxBw53qjjuZWr9MSvP
	Nm3bVPnT5i/8UJYBkTc=; b=Mut5g1fbLlR37Uq+cSyRhoeRHz9YiuCYrHbS7Ver
	mY82Pd4jblSlKnVzgw8WAYn4YcsNFC92IWSF06xmRaNjlgphDGRNS/5muiYg+Hn6
	ZxqLkzlTf4Az3pFztC2svtbwN3u6PXyiixH6zztdbTUuN6ZLy+kf04SLUCasCiLd
	BldZeHABcIzlAeBhT5wW7Bw/BXrHRLc6Q7mJFSjMAoho1xADoWBYMep2kBV8Eqcp
	LY5haTUWvPWZ4+Sko9AAkeQ0UWeoqRN87mdqmi0h7bHes0dLGFhYyPeZQlkxUcOb
	4c/m1Iylf+MVHBobVVsKtrDdDk+dHSEgLJPR6g345OnUVA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga4ec86ut-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 18:12:01 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52dcf1bb6e9so1490241cf.1
        for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 11:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787767921; x=1788372721; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dSVenvfxBw53qjjuZWr9MSvPNm3bVPnT5i/8UJYBkTc=;
        b=fQGFlCuKfp2AeuvEaWyO6uElDOoQQ1a4OTD9Tt+VXEqWCJPOcVDUJR1/ZQV7J+B2Db
         easLVpZgi6Ww3m9YySRO42mUAy2R8fqgQ8krOA8axmjq0uVbIVAOxPGMWq2Fvw+9Dt3g
         CIwu/6CSQYiqrg1pVuQR9/O5DQd2XIl81iL5MmWCTF/tv5zmUC8NW/UFiLoQYEC1qScV
         alnWEq9qoqOsuoCH3lCAbV2MzXMjttvvlBSAN5csi85zFsmUCYFddHiQbQ93C94s1Wn+
         BecwqrrXolTZ1IBpWjkhYXyk+FdjY3EePcMbfsSnCOCvYYNNGCCqaTyjJrPwwH0DnDC5
         /J0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787767921; x=1788372721;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dSVenvfxBw53qjjuZWr9MSvPNm3bVPnT5i/8UJYBkTc=;
        b=O39+o5Qe+YnMQJSBfXB1mCUp9WQ/JC6209hAI/aNXROCjZTE1takGrDZKRYtds2YVj
         qWso5ilYWB49xeV3FUhYxmu8z2+qtcLZCrnqXmcIF0Uq3eCvSOkC1XE+knxZpFAWJOGD
         xMNcmLr2oMfJGA5/5Z2t8aJYhotXdhDTav2u/vXbCZGY3lLoCKE2Ue8/+A7tgiSDGrEn
         mOOuxS7451Ad0H58+flWrINjl9TQm8VfG1i3CPfi6q27rOJMhGq4S4j4nIGFXjUKhD1A
         y4qwQapfTNjPduCHyjuS8cO6y06ysTX7kROUX0RcII9Yfqo5xDnTjO/2UQnvyzWAwJYQ
         b36Q==
X-Forwarded-Encrypted: i=1; AHgh+RpCRd6Pzpq6KfDKLVefVR/r1lP7ei2xfWq65rn4ZY3/pEeAFe3Zsygj+pCmsRyL8bKheucPUg==@lists.linux.dev
X-Gm-Message-State: AFuF++nNTgIxx1udrLvPqYOuEBI/pAb1/hwG+gLiKzUk6nndHSH7A20N
	JjuLQrqafMuHUdcLAJ6TrgfgBA0w9+v7Z/MgcVcqUj3vMpPyqZSIy9CLLpTq0tXp49DV26T9ZWG
	tCABDXXqRfjWjyKOBm/wdwLrxHBlyYdryvywYIsPJIy0YR1LZoS4t7iLcPA==
X-Gm-Gg: AR+sD12wDbSlxy3VtIw57EhbKeu1Af3aBpdKsR6zs1s/eU9NEcBR2mAVU7036BQ4Q8U
	6DTO+hemnkrKc5NjdfHeiSiBNRB4QPplN9IXCMaQV7Rt9kuK7wMRpgbBli30/7E7vDvTsUI/H5m
	B9v/6f5xFgcdP8aFJ7r4sC2AqekciEV2j8WnuGTLR+KR9rYBeJ7Z8gZba39hkgllwd3kBm7A4MQ
	c1MD4WsE+GwssP0WN9Zbx5yNkYvLQz/UwyrwDO0oDV3JoUNXD9Jlw/ztL+M9o7qG55YB3NXGFZT
	4bDXVIBP0R5eQKYeKBeYP7H2jc48pmQ8PP3zz5kYEl9w/6dRj96RbrRl8Sb1X23QAK33+2u63y6
	n1VANmrHw
X-Received: by 2002:a05:622a:2d3:b0:517:6fc2:4760 with SMTP id d75a77b69052e-52fa1a9aa93mr11665651cf.9.1787767920763;
        Wed, 26 Aug 2026 11:12:00 -0700 (PDT)
X-Received: by 2002:a05:622a:2d3:b0:517:6fc2:4760 with SMTP id d75a77b69052e-52fa1a9aa93mr11664871cf.9.1787767920295;
        Wed, 26 Aug 2026 11:12:00 -0700 (PDT)
Received: from localhost ([193.165.40.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499fa55f458sm12784615e9.0.2026.08.26.11.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 11:11:59 -0700 (PDT)
Date: Wed, 26 Aug 2026 20:11:58 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
        anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com,
        fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v4 02/21] iommufd: Add iommufd_sw_map_msi()
Message-ID: <l3xyzbhqfremod6swwiks54znvoqy57hmqpsdlpcji5czjja4w@4qgiuwhwlie3>
References: <fp5myre5qaersxxshitgoupbzkx2zwo3rsz3q5jfdiarmtwknh@gmfhz3cxuc33>
 <20260824170417.GR244917@nvidia.com>
 <3gdj54zcs5dncgom3zlntyredyuh2xe5ueg7nd4pdrcksmnwfl@k3fyky4h6556>
 <20260825140334.GA3325090@nvidia.com>
 <cxbneh42ui3gbkoqrsnoatxoec5exzbprfbgxcy4iekqmbceho@gouiwn5q5uzs>
 <20260825165209.GB3325090@nvidia.com>
 <iltwtfmgnmofsroo7eqrvjx6yhqbptwutywq65mgm7adudz7pq@2mdg3dhvtoud>
 <20260825175901.GE3325090@nvidia.com>
 <pzutriwhwe4whonj3veoo4hzxmq5tlmmyui5u6gt4bgl5wxxrg@qjsq2pvd7by3>
 <20260826163234.GN3325090@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826163234.GN3325090@nvidia.com>
X-Authority-Analysis: v=2.4 cv=KIBqylFo c=1 sm=1 tr=0 ts=6a8f2c71 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=CzrpMg+lqiTzknPDBj2tlw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=b5O_Hy56fsZqd-xyW_cA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: cqm6WxsfdjM9ngy1QceQP_OTPjl3LIDu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE1MiBTYWx0ZWRfX3tJvz2zRu8Q6
 qAoh9H7nxupeadBFB+fpCLFOvmjuK5NIcmWCxRS+gtVgMNPvpvVY60mLipjKxCXz8SZzWRceHst
 u+BFCqE7/pW5R+RQzr4a4hv7AwZ5P8H/+a7EtKDBjVlm/ZQMHx2oahPokmaQKTVYAXCY4tRP8RM
 D1leerBGrfAWZZ6v12hrErTj5YLjAH+nSGq1qo0beIjQp9xKxQdcgtAp22qQ6rRT8IjRmVbeS9N
 rWImqYG6XXSvPo8wVeRdYt+COpU+lg3NvTqD/ZsJXW5XKAr05RvHNCQdUuPqOVxUMlARq3ZJqIK
 NOMFRhj5OhgD9bmVk6/DorfyPVahzruSqzYwhgSvPpWSUNY78i0QIBzX+NP8cj9f+PEr5KTKxrI
 3lG4VvBQlNWsjw/9l6MSmGpGyOQUW4YLkgkCixRJIzCIUu+5klvztSOAKtvKZEtlJ/qZxksOrkJ
 eb44cgWcsX6oFmakWJw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE1MiBTYWx0ZWRfX1CHgYPBYiwgp
 e/dFDMc5TXVh6fMS6hZD3Lg4VFC6wL12+LW1HOUxZNdBvPuk9FDyAuFroNQCutMKFrLsHn8OmpH
 3Fx1IJWxvIF+tG8/Sodi7B1UW8g5t+0=
X-Proofpoint-GUID: cqm6WxsfdjM9ngy1QceQP_OTPjl3LIDu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260152

On Wed, Aug 26, 2026 at 01:32:34PM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 26, 2026 at 10:23:20AM +0200, Andrew Jones wrote:
> > RISC-V uses the same basic model as x86 (an IOMMU-owned interrupt
> > remapping IRQ domain). x86 makes that domain per-IOMMU because its IRTE
> > resources belong to the IOMMU instance. RISC-V makes it per-device because
> > its callbacks operate on the device's attached IOMMU domain and preserve
> > that device's existing MSI parent. The IRQ callbacks provide the lifecycle
> > hooks, even though the mappings, MSI table, and device context all remain
> > IOMMU state.
> 
> The irq domain isn't per device, it is per msi table, many devices can
> share the same table, and the VM should have a single shared table
> across all devices. That's the core uniquely RISCV wrinkle I think.
> 
> IDK how Thomas would like to model this, but you will get a better
> result if it is very clearly explained and asked.
> 
> I would like to keep the iommu out of it, so I prefer if IRQ code
> patches in its MSI table pointer broadly the same way AMD does.
> Though AMD doesn't have the restriction that remapping only works with
> a S2 domain :(
>

The per-device irqdomain model allows multiple devices to share the same
S2 IOMMU domain and MSI table. Unlike AMD, however, the RISC-V remapping
state belongs to a replaceable S2 domain rather than the physical IOMMU.
The IRQ hierarchy must remain stable across domain changes, so a stable
per-device irqdomain which operates on the currently attached S2 domain
may be the closest practical equivalent. I'll explore this further while
reworking the irqbypass series.

Thanks,
drew
