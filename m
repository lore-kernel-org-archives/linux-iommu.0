Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A84237106D
	for <iommu@lists.linux.dev>; Mon, 10 Aug 2026 08:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786348919; cv=none; b=urOigml7u8FxX9IacILkMLSW7YmG8welG3go83LSy6SwfESw5FWqdVoGQMHnMRMPenPrdktlqtbFVqv4uCXS3eaQsidJlD4rH4fzpUzL9Q1b3y4Rg1XXZMqr2jpmFYjjgzg19H9kYZdTIy+mYD1TumOO6i37qcyjywDb1N6d0cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786348919; c=relaxed/simple;
	bh=zLQxOzxKS7CHZiz+Zvsrdb0Z2a9krVV73RgE7AW97sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMZi5Qm5C6/XLjGBdNx/xp7oKeUWBPhDxhEsc5fKyhxh733RuRWTgOL8q+8O4udcv+Jg74AeqtCgwBgYNr2lvv0ZLfBAkJyyxgKs0/0O4wEzUvdqT0RhGpySCW0yLf2jcnQgOSp8zDx9yjQBS12kw2b0NLz3I2/nytCgIbfdKtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NKTg3x9p; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XV/Y9UPv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NKTg3x9p";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XV/Y9UPv"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67A5piPT633082
	for <iommu@lists.linux.dev>; Mon, 10 Aug 2026 08:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=nOFIe8m9HxDwbnLgc+9Tz62O
	8nS/XQ7EyB4Mr2xiWqo=; b=NKTg3x9pAEHBESHpi0KrwjRNYQK+7hNFFvqr+WL3
	BDA+/M2Es5frNy3AsciW4GyDXBHj+K274QEZfxhTC27bBFIYqFgK/AZqQjJkl7oq
	FzqAPiNbL+55zygFEBAs90ui+dcCLr4TbHhF3hmaw3c3NKzMTKOc76a7gyb2fXRF
	y9cA4xOn0e+1gu2OfTkZfJ99em4i6F+aj49WYD3Esk7xEV7SpXxDXj9uyS2wtdvi
	ahQ8M6z20+At9l+eVWgYrBCxAVZdx2fVn2roJzbjPvP9KvHuDfJnOeXAPlsa7c7g
	2qMICpLGkmWZlsvXk0qRvKcY3vTPiY7wXFgXcdXHxlkq1A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fy8v6rcyr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 10 Aug 2026 08:01:57 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5283df62d68so18551071cf.0
        for <iommu@lists.linux.dev>; Mon, 10 Aug 2026 01:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786348916; x=1786953716; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nOFIe8m9HxDwbnLgc+9Tz62O8nS/XQ7EyB4Mr2xiWqo=;
        b=XV/Y9UPveI2aQDQluK4+8wlHBvmY5b63cDkb/rbPXUK42EBb/w+2aKftSNVNDNBXKv
         JeYgkV1wUnn3F5idjg3apjFR7ee0xiwh92vTBWrwprz79FTzoz3GZU/eIvUOvZN8sRvs
         YfGOhIsjfybFs5kQBI2dx0BGkYQf+k0t7iR7fauR58QQe6Cx/HIT5AgU8Xa5/cGxA6hD
         V4Rm8f1LHBItixCngJ4wSSFSRfUzrS7bNd9cEMlOSuHt0RK5mkBbdM9Lbgh/KdMqdmr8
         9JBuLB1Ur4ICIaWMzL/3lgQJAxBYv0iN3OuwctHMn1VIKraDCWSuk/Lb3rKFli6j7RUq
         Mz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786348916; x=1786953716;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nOFIe8m9HxDwbnLgc+9Tz62O8nS/XQ7EyB4Mr2xiWqo=;
        b=cyWyuup+yoMOkZ5YXi84lOUqD0KFIWQf4GnUgHcL2/4rQkf33hxcjSFro0nXMBUHOK
         A4aZXMbyBKZnFWmaqdPmB4Vbgtg/JDJav6AXs+L5DRWp3t4jkIneyQj6dx07pfNACPV2
         ntPdhj90lgT2P1HqKI3aqA9RdbQ0ZJlXYBSpAfaVWv2lrcBC4C2SDNDBhdeji23du704
         n8wv7olNun1eIkx3wbnNB6qw/snFJLxKZ9vDSa9ySAM9MtjbQhXaGxiYNEWgAoRAWOwn
         Kpv3m6gywBJim7Bbr/lkJBv7sdUneZ8FX+Cj9evVshVsZ8Lc+8M2KEs+0VnPWA9usnjI
         3qrQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp+HhtDJXSX4WWlxLMn/z24ax3t/bhfytbM+lJYC+8UVGOlR6b65C6WrOYabqv1z4oBwh/SCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxs+ikVxVogs1jrVL39taTPild5LQBpMwLcX9JLGpZfqDXaJnlU
	ULgU5rFM/loFR14gCl2H2UvLYt4m5FbcKgAOz/s0KWv5Q+kvqirJR93Dw9MlnALs5XmWWFjdTVl
	ZF9oMtz+xHo/OKKOcvrbhkKZ1Os47SO5pdbWn+HJwRyfwiruk8m2Q7+bfnw==
X-Gm-Gg: AR+sD11iYaHqtaKNr2JMLbDq6azs9JwogCQGxaGRtgxDFnrgMvZNajC8FrU6p00Vqjj
	fgrSkriJ4OMgPgvumvTFwmgJBEi668GZyHN8eWnXn/PTHbEjDpMuUWTQYEaGFg49LYM8DOglxd2
	msCCFlub2YU/HyjZMsqI8k1uHqn1iw2nP6lKRHABryf/DiZ5gLZCHFWNz4odF+G8Hc9UmJwefeL
	IEd3VgUuNhiwkG3g2mtmqNumT6it5z+Knd9GXEoMpINZzZ5ZDUpuq0S3aAN0ADrfsuShnwaAJq9
	2NJPBVOg79ppHd6XqnddaDzPEtbcX/O9eQ0mVBxAwC1oDj+NInPMylhQbVIJUxtolYt5x1Szfs+
	AetonRbXitau37+LpUw0VGfwco8jo/59DF1C/rKM=
X-Received: by 2002:ac8:5808:0:b0:51c:b98a:2448 with SMTP id d75a77b69052e-52ce5f447b9mr410804711cf.9.1786348916214;
        Mon, 10 Aug 2026 01:01:56 -0700 (PDT)
X-Received: by 2002:ac8:5808:0:b0:51c:b98a:2448 with SMTP id d75a77b69052e-52ce5f447b9mr410804121cf.9.1786348915849;
        Mon, 10 Aug 2026 01:01:55 -0700 (PDT)
Received: from localhost (ip-86-49-241-13.bb.vodafone.cz. [86.49.241.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002150952sm28681112f8f.15.2026.08.10.01.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 01:01:55 -0700 (PDT)
Date: Mon, 10 Aug 2026 10:01:54 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, kevin.tian@intel.com,
        fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v3 06/19] irqchip/riscv-imsic: Compose MSI updates
 through the hierarchy
Message-ID: <zpkso64qseb3g7pgorfzselza2f3rngtoqpqu2kuktf4jf6bhz@v3tzfyt7yp3o>
References: <20260807181713.228535-1-andrew.jones@oss.qualcomm.com>
 <20260807181713.228535-7-andrew.jones@oss.qualcomm.com>
 <878q6hekyy.ffs@fw13>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878q6hekyy.ffs@fw13>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDA2OCBTYWx0ZWRfX7LoJgmSOjcab
 b1AerzuHC9dXlF6bE855ms6p2UJ5RuTL3oi5nYw/1KP7G/xL/2LU0VT8BNuqYAWZwRmAJVCg2QU
 JaT5sb7FGYmm9hIDBseX+bBOFGaFsqE=
X-Authority-Analysis: v=2.4 cv=PvijqQM3 c=1 sm=1 tr=0 ts=6a798575 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=VPysOpcHbS0DNrM1Xqmyow==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=xUzaz2BWaaIfm95efY8A:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDA2OCBTYWx0ZWRfX1ZyBDDbFRqQm
 RfADx0N7bAVYdLbbfn2zOML+Jbu186THWNK0e7bPWuWJl9I64Ka8N+WM+MOPLUn2/a43UEEf3yR
 ou9X5LBaaX8SkPIQYE5o9bkwy2VjnJBRffCoYhvS0Os+GU9N01QdGIPpOxgHX5NeIUyrwKs4vIX
 yJ84bk9r4/L5sY7qlm+MNwRAx3XLl5dGwDjkFi3trT3m7lvWU2c2F9vMqh0kAL953vKZ/5LhHQX
 tcYgMpz6oGBtjDMC5LpxpXOGbYaXQ8hqbs3Gzz/KSrMvkngMmBtqhAxrr2HnW5HVLpnd08nemc9
 wljRJsF34jM0Rv9kofpTUiao0SjaSJh8Ya3v2bvEkWnyJqR11cirX4J1Q5Poa35Pqv/o2SyxlH9
 sSnHVjCePHA+XkapGP/AchN0pIbiAu9Vs4hcEVHpHHQR96wjDmxn75SWCparA9Xvtk6fo3pRwyA
 kft0SnI8cN3pXpMWpRg==
X-Proofpoint-GUID: Mtr0mBifxRuUT4_ORWJYkUfN_N7UFGxF
X-Proofpoint-ORIG-GUID: Mtr0mBifxRuUT4_ORWJYkUfN_N7UFGxF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_01,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 phishscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100068

On Fri, Aug 07, 2026 at 10:25:57PM +0200, Thomas Gleixner wrote:
> On Fri, Aug 07 2026 at 20:17, Andrew Jones wrote:
> > imsic_irq_set_affinity() wrote the new IMSIC target straight to the
> 
> Wrote? When was that?
> 
> You are describing the current state/context, so this wants to be
> 'write' no?

Yup. I'll fix it.

Thanks,
drew

> 
> > device via imsic_msi_update_msg(), bypassing the irqdomain hierarchy.
> > That skips any intermediate IOMMU irqdomain sitting between IMSIC and
> 
> Otherwise 'skips' makes no sense either.
> 
> > the device, so a remapped device would keep the pre-remap physical
> > address after every affinity change.
