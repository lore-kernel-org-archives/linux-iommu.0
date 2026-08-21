Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740CC376A06
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 11:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787310924; cv=none; b=Am1bi1bTwsy4bVNCB5SGV8oWdhhHlJiK/1p+idgsEQBkdcBygQ7iJ9SswBSKSbVbMcENBPiS3J7l0G/rao5EmNSUgfQKkG+8SBmdU83Mv8fJtOdG/X6+ZeDj83ntsIzXr3EAMT6wi3Bs0HM7gNXLO4X7s4U2hvtlsIdTV5BF3jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787310924; c=relaxed/simple;
	bh=yTV4qmuXEJsGqWTSd63hGk40D4GeRMBixFTOuNGoEFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ammQcerUT9qqRHGDfFTfZUfzDeH4J7WVh2clnMj/F3K7rZBMwk/BjNcr01kxjGCbK2uN2vqeF1UcJe4G7YOqM48ULQZcOIdYOWIQmbS5GPi5XPu1N4/Zx/rmGuDNjENJHX/EokAtBS0sE+1QEuOpQpPRvuqUqdCScuRIVL/eIbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e7LhV1Dd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SXKGUrAW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e7LhV1Dd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SXKGUrAW"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L9Lhl71983011
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 11:15:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hzHnaq9Npns7wIBlsqeJGHfp
	uRuzgcX8JekRmNl9OHk=; b=e7LhV1Dd6mrkmqk7OyLIFud+rasyy0LiYuAyQmWE
	G3jJ7CwxbsLSGgTe8M0SOlrZy5HwdulTL7UOvJrBjJbobo7qxfsDryAG5Ag44uiA
	ZprIzcqrGewXYMcX9FaR73T/RP4ZX2tx09IYr8QDKwYEOtl+1DtfpCclLyTUeaQZ
	pF52tLVjoMRajOpjeN6A+MeZq3c5Xszthn3y0whyjFW7C4MlUjGp45HVoUxo+eMV
	1+mDCfOwC2f0dhhz0zvoKX0j/J32mbw+xhxYRBgaWXcxA7js9kZrJ3x/qD4S+hsF
	4RlWMxeMhRVYlTKj3SA6lSjMSNkRI8jWKt2AXc5rozzgfg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6cdsj0q8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 11:15:22 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-930b571432fso83322785a.0
        for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 04:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787310921; x=1787915721; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hzHnaq9Npns7wIBlsqeJGHfpuRuzgcX8JekRmNl9OHk=;
        b=SXKGUrAWGgHlgoxC1B6nohBzSGQHuVBRNbBj/KoNZIuk7QWCiWNbVyjLpT70TNXgU3
         EM+pq6gkbwS+HyIYf8aQ7CIF8W6JT26Y6OKCgCBRtloMRFGNAZDf5xD3dmYw0SX/Y/yH
         i4gh+c1qpZRwXV605hmKVxk9nZQYcE4aEFKWWc668vJbBuPy2j9QtGUXPG2uLli61yH1
         FW/D/GOvlSfgaiMux//tUqnA2cNxXw5tcSN/BHBsnjx+dLVEzxn8TqDh6I97bcS8u+/Z
         EWd+x1emzm0Z+ncangk18bBC96NDiznSV+Qz4wl7YQ9r+2Xbfv5Ztn66bU527hOIHV8L
         qUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787310921; x=1787915721;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hzHnaq9Npns7wIBlsqeJGHfpuRuzgcX8JekRmNl9OHk=;
        b=rCwvnveoItVuGUe3e0ZAx75wxD1aKx9czHX6joQ3Yk/liS0UcJz4DsS63UQPgg3ya1
         1fy7jd/otuREELj4LzIby/sgTHBsGbhMdevuvK5HXhVniUuqHFi99WzB9q0HR6M5o1Ag
         w5vxNOk6pyz++3KHAtE0YbE6ONeugKhaUIYAk3XRjmtogAAi9wNW7G74UnoFjwP9UY48
         LMIF3tQHPHs7Qs9hsvIdqFmCJ/66scNXbP0e5//fn4S0FvFyPswZICI8vj6R62r8GBid
         2sdTP3kIXEoiOdr0WE19VK7+cKsVZ/PS7nRtyatCVzrVki3hxvcP6IZ5ZTOB4Miz+NYp
         spHw==
X-Forwarded-Encrypted: i=1; AHgh+Ro0JsyLHZoH+6uKXrPc9ZyJy81MJlJXY4pojcwqZ89qSXu3MbCfQzZk2DA+3ghYmfOEIBTwXA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4ShsVy46NG1HEWj14K/Vy26G6j//34TdtIsuUIS1enwKOZwmz
	awgmLbpqku4q9aiK/Rh1wlPAx7g2zbzAjRJs/5T75U9Yrdx63xchD+baFvKleO9JFsgfM4yDDND
	lgpsGrf6+TPx/Ci4qgeklb9Qff4rep1MhtQRRod6kzhzeE9TtbzSs9uTcHKMMLUpMyQ==
X-Gm-Gg: AR+sD107el5sVbIsYqW6UCgguGhv6IMBUz/WS3t6AYNIrMx2ukoTw4ls08On6KqXr0g
	HajS8DmWnniFXXHDg9Xvc2wqB3k+nAknStA1F+fFeQUMDUyjb8RTD3lp8xEjQGZdQ9CqmpblO7T
	yMSm2CRr5PCgKmrEkukTYtuerRNWWjXSzuuySyejl0j5X1gx7Irtxb/2WVhLyg/RQB9YX7SPRe7
	RD9GYemOc9CsbOooek4AW6xLxozv0aL0l8NqoNzHegh9OnAVlOpL73eDhN+0tj8na0iaTuRLQTx
	N22EPV6aJ4LSYJ5IbKPnztIOdshOkyDDqO7aRQxdowuD4POLXrEgjuqk2aLJYOLMhzsgMGXBfFs
	sFC++htTLixP6qC5LJjFJQHr+o9g/pPuP068=
X-Received: by 2002:a05:620a:7003:b0:936:ce17:7792 with SMTP id af79cd13be357-937283bd34cmr1289003885a.8.1787310921493;
        Fri, 21 Aug 2026 04:15:21 -0700 (PDT)
X-Received: by 2002:a05:620a:7003:b0:936:ce17:7792 with SMTP id af79cd13be357-937283bd34cmr1288994785a.8.1787310920874;
        Fri, 21 Aug 2026 04:15:20 -0700 (PDT)
Received: from localhost (ip-86-49-251-7.bb.vodafone.cz. [86.49.251.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b915cda6sm28004285e9.14.2026.08.21.04.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 04:15:20 -0700 (PDT)
Date: Fri, 21 Aug 2026 13:15:19 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
        anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com,
        fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v4 17/21] iommu/riscv: Report cache coherency capability
Message-ID: <dvh336e6ra47vkg2rahzgsqsq53ryl2cc6lkb3lapsee744bal@5z37ncf2t2kh>
References: <20260820214150.545737-1-andrew.jones@oss.qualcomm.com>
 <20260820214150.545737-18-andrew.jones@oss.qualcomm.com>
 <20260820214730.GC244917@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820214730.GC244917@nvidia.com>
X-Proofpoint-ORIG-GUID: zeUXrUKgvQ-FlGbZ8XTgQJfPpcv5_ydD
X-Proofpoint-GUID: zeUXrUKgvQ-FlGbZ8XTgQJfPpcv5_ydD
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA4NCBTYWx0ZWRfX3mZifAM3lhrl
 d6SjkVUgMR+WE1YQwrrqlnlT7wfqZxDye8A1hrJedE1mKCovlUMPF96dCb6UCR084igdW2NkFWV
 8uDHrd0AbqB48PuvH7m/M+qwfummASM=
X-Authority-Analysis: v=2.4 cv=RN2D2Yi+ c=1 sm=1 tr=0 ts=6a88334a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=on9AXyaqQ0RhfYpiXjjEXA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=Ikd4Dj_1AAAA:8 a=od_w8G5EaJPSkqSz1mEA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA4NCBTYWx0ZWRfX8rbE9XxiqXD4
 XU66lTW8Lufz1Lcsiayi2XpWP1GhTcQQTynruwNhdha8kD3MNqjsk0w4ZjZIQP8zeYWJIDNdXXg
 7nKSg3fL7us8se+tPT4oxvfo+crFN8i55ogfa5pWFsuA2pefMTj2QnaKn6cYCrtl9guKpiiS2Mi
 fvEg8eoYrGaK3buhdYmQH4pZWyobzwu/unvABwabEEnWpel3PGguRdmk7ADzdYjjEZAzIWoMFdW
 TsfbD+f3328DWMqlapNvDZtE8O4Pkg4F2L+ysu0BB21Q5iGyPADpAywoFy2LpXQCP31WMM9qMRu
 gLrtada6eccpF2iQHT11AlLVd/uMayRKhOrYWWBa54ohT1eGMRE8vZBkqfwtAK0neKoCjRXrpdH
 fzCJYKFg+2WpXRIAZgYeTdEhd9ZWcpgu+5vxjQ7Gi/wB2N3L/5OkOxnwIb1iyD0Y5jFhp8O8s9T
 cB8bO53TLEM0lj2R8iQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210084

On Thu, Aug 20, 2026 at 06:47:30PM -0300, Jason Gunthorpe wrote:
> On Thu, Aug 20, 2026 at 11:41:46PM +0200, Andrew Jones wrote:
> > VFIO and iommufd require IOMMU_CAP_CACHE_COHERENCY because they use
> > IOMMU_CACHE mappings and have no userspace cache-maintenance path.
> > 
> > RISC-V page tables preserve physical memory attributes for IOMMU_CACHE
> > mappings. Svpbmt marks mappings without IOMMU_CACHE as non-cacheable,
> > but preserving physical attributes cannot make a noncoherent device
> > path coherent.
> > 
> > Report the capability only for devices marked DMA coherent. This limits
> > userspace assignment to paths that can honor cacheable mappings.
> > 
> > Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> > ---
> >  drivers/iommu/riscv/iommu.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> You can send this outside this series?

Sure

Thanks,
drew
