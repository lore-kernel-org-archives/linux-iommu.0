Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6949714A082
	for <iommu@lists.linux.dev>; Thu, 16 May 2024 14:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715869571; cv=none; b=TunttaxJo/RdmFbNL8M/LWjNiqBRhLpFjL+kUOPw/gIxwQ15CFVketpJg49dk+q1961cyyQu3D2aJ3TyK0ScvNUcdkPqgYnygjyx5rm5vkU0jCD6MtbFKbxTlFMdke1Iy1BKL8vvArYpmRlKLSBCPVYW6aYVHN0QsBhyPGs55+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715869571; c=relaxed/simple;
	bh=ZzE4IugBYkyPpxD2g5Mg3atg5gahwJi7Wb+GI0B19U0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGdHXAJr7Ir0GKIlX/NoqNvTpZGZzuXM4Pm6VpA9bkGowe/pEK2okntp2hsBeLjHAx9kp1xIZlKd48rsbhgp7gKV/1/jpbKaiDmhJIJ1jbE4R9dEWPVoswfIBWybvZRvblbfGe59nU5a21COcWExZ7CGHesQY321w+n0g8aOsWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cn10ka; spf=pass smtp.mailfrom=marvell.com; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cn10ka
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44G40GAs017382;
	Thu, 16 May 2024 07:25:41 -0700
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3y5aqxspy1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 07:25:41 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 16 May 2024 07:25:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 16 May 2024 07:25:40 -0700
Received: from cn10ka (unknown [10.106.49.40])
	by maili.marvell.com (Postfix) with SMTP id A9B0B3F7069;
	Thu, 16 May 2024 07:25:39 -0700 (PDT)
Date: Thu, 16 May 2024 07:25:39 -0700
From: Tanmay Jagdale <tj@cn10ka>
To: Will Deacon <will@kernel.org>
CC: Tanmay Jagdale <tanmay@marvell.com>, <robin.murphy@arm.com>,
        <joro@8bytes.org>, <nicolinc@nvidia.com>, <mshavit@google.com>,
        <baolu.lu@linux.intel.com>, <thunder.leizhen@huawei.com>,
        <set_pte_at@outlook.com>, <smostafa@google.com>,
        <sgoutham@marvell.com>, <gcherian@marvell.com>, <gakula@marvell.com>,
        <jcm@jonmasters.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 0/2] iommu/arm-smmu-v3: Add support for ECMDQ register
 mode
Message-ID: <ZkYWbhTOEBu5vUVk@cn10ka>
References: <20240425144152.52352-1-tanmay@marvell.com>
 <20240430150950.GD14187@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240430150950.GD14187@willie-the-truck>
X-Proofpoint-GUID: bRpFxqrbi4G_SI4aKqjFXb7lumX-n6Vy
X-Proofpoint-ORIG-GUID: bRpFxqrbi4G_SI4aKqjFXb7lumX-n6Vy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02

Hi Will,

On Tue, Apr 30, 2024 at 04:09:50PM +0100, Will Deacon wrote:
> On Thu, Apr 25, 2024 at 07:41:50AM -0700, Tanmay Jagdale wrote:
> > Resending the patches by Zhen Lei <thunder.leizhen@huawei.com> that add
> > support for SMMU ECMDQ feature.
> > 
> > Tested this feature on a Marvell SoC by implementing a smmu-test driver.
> > This test driver spawns a thread per CPU and each thread keeps sending
> > map, table-walk and unmap requests for a fixed duration.
> > 
> > Using this test driver, we compared ECMDQ vs SMMU with software batching
> > support and saw ~5% improvement with ECMDQ. Performance numbers are
> > mentioned below:
> > 
> >                    Total Requests  Average Requests  Difference
> >                                       Per CPU         wrt ECMDQ
> > -----------------------------------------------------------------
> > ECMDQ                 239286381       2991079
> > CMDQ Batch Size 1     228232187       2852902         -4.62%
> > CMDQ Batch Size 32    233465784       2918322         -2.43%
> > CMDQ Batch Size 64    231679588       2895994         -3.18%
> > CMDQ Batch Size 128   233189030       2914862         -2.55%
> > CMDQ Batch Size 256   230965773       2887072         -3.48%
> 
> These are pretty small improvements in a targetted micro-benchmark. Do
> you have any real-world numbers showing that this is worthwhile? For
> example, running something like netperf.
We are running benchmarks on the latest kernel with and without ECMDQ.
We will share the performance numbers and observations here.

With Regards,
Tanmay
> 
> Will
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
