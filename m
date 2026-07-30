Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED1841F35C
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 12:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785416264; cv=none; b=ZjomSB680h+U5mXO8BJfvcu8o/5/oz10B+7sqPAVg7iwBYMcy5pluv2fjMWpOU8+q+3BbGhxpBsIspZQtrjOzSK4zcIWv8zYik5xbKxwQc0oPrye20EFefrE2ZMwCt1skBz9LttANzAfIy7rDLYb/4ZRPhw6TMpET2GtquzdWSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785416264; c=relaxed/simple;
	bh=3E43cZpzy5OTsNhoM+G+lWYTt2bq3VUHWtwgGUwUZnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFDZwaEmEwUX0yXMKbAMk7mHEXnNen3FgvnK2K/a/TuQdevOarGuAjK3t1TicKAsOMYmIE0lqo0cga6ghbnLDmp2UJLCMGefi3FfndNYtWIi+FTkqH9gpwL55qDquGot9xHtOs3WJ2Wb4SgvlYgh7OLKc+1Uau3YeQ8+B8Ar6Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GN6Bpsij; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gxv+gPMn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GN6Bpsij";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gxv+gPMn"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UCkHbg779420
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 12:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fAdpaPLh7Qw8oMA7YY6FkhGe
	9IbNaPjelC1V+MNagRI=; b=GN6Bpsijo0dl/WBNZN81JBWTzZg7IjHkEkpx7NsH
	11V362UrlaAIEsYewwLjpxHjNyT52F65y8IzPDvjpoEgHK0XMj0V62pikERfccyi
	SutjQGmxJHNlZUjBvTCEJiunOPhV4VXTfjZe59dau4K2RQy3NDT6lRfcQ8+pLat9
	HZycTnBoxzvx8Bbd6+yq0+WAVDEvxvMM+oFwW5XnhRvD8xC6mDQQFQ+LTxNwRipV
	V2A7Dd3kLOF/JwzEZO/CEBKPsX/KU4vRCRiZFkjtVbsOU9j+xcgO6Yz/3VOkNqA7
	yBcXlhBFh8ETeUkJB6EFS/Q5UXnB2QYQ8u3KLw6RGC9Trg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr6wmg1nw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 12:57:42 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c1eb52e1fso39460421cf.0
        for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 05:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785416261; x=1786021061; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fAdpaPLh7Qw8oMA7YY6FkhGe9IbNaPjelC1V+MNagRI=;
        b=gxv+gPMnpAD2WA3QH535blMT486Um/Q17q7b4fqGDRfURyqNN9xTj8t3Ls2QNOjkhj
         L6a0HHAObwVfVgGtynXLeZ+s/0t0yzP59iKlQ/82TrfNDJvy6yTnwMHbMP8H05GzZ0P7
         G4VvYM3+cVE2+fpuy/R2trMCCL5TlsJNKzmjRFr5kBK9u+3Mo+mABkXhGzMZj1Uc9j5H
         Bb7amyjt4U7mhPoDpdhoJHcHUhWCeC+1+sfQyW8495XeQ0dmbF2x2JBGyaSUvQp0g+EH
         IWCTQmP3sATkzz+lOg+Tpapj1PmKGEAWiYNLkguqgh8lcU/TSoNSD1wwRtfWARYfx2vk
         UGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785416261; x=1786021061;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fAdpaPLh7Qw8oMA7YY6FkhGe9IbNaPjelC1V+MNagRI=;
        b=Pr1Bb6vtGCBejfRSf52e1IQGXTnFQkm5FzDOzt3J8jqLcXSFosPg4WxK4PZyUNTavr
         RagurlA/FPOURpJbq+eN66zD+ZmRzAoKTlbwapAyssBd2OKycq80lSeWrgdKUhR2zXem
         0cRssEkuhccH8+gLGzBgJ9Cv+A71Lf2rYOdI3Ua47uPF3Z6t6a8q9UM9fWBl7CLmabzR
         dotYsLIZaRrCqUDsfFA53fJJmgnjeWBY4dwsy44ZTDqmI1Y+I+Fe61/UERWMT+rOTYFr
         F+W2SXX9zbC8/qMbWLuqieX3W/1wUH7IW/VNvICjQFdkMjDbmVPhJVR6sxqPZwkFexF+
         dZgA==
X-Gm-Message-State: AOJu0YyqfNbi86D9Adl4n8csU1roaVjd1Dnb5AQk/UX0qu+uzonoUDLP
	nnn4u50yTeCarxYE4OntE+OqeJ0Aygg4glJYD8zpbw9Zm9b+Pb6Wrh7LOq89KMVQbFdEHThd6js
	bgBs77RVgUWLM6FtGJK0yhhlY2KB/kEixT+OXyWpedTjLyN20e1gzdrXV5A==
X-Gm-Gg: AR+sD135y1UC8K+YTty0QVjUWmcINEGJAQy/CPvn867kRjyQhl7tslXu/cEjQCcY+TV
	3jiHGdvKLmjsezIX7KSpDe7J3mAvOMMYNip/pSu/RCZFfJZhPtDdLpc4kF4CNT2rwTsLh2RjNL5
	Q3gK2GvUSWdU/Xea+3DUPDTLa6knE2zstVeF5woKjdjD22PJFhqJOwcvvbFFginiNLHGlQAkiLz
	p3buIguIhRmg2hoHYwISc+My3CG7nB5vMOXpk4brdWA+TUiPhAb318id8IURaDjeqMUzji5w5wY
	6CN234eFRmQx1OqJkbeP8AcBeP17MaKJHv7rKNOwVvHKxWPtN+kiLqGjA0WffuBht/E/eKTKXqo
	g03cDW2x7rgaChwznOj/cZoC56OkRcm0oKf/bjJI=
X-Received: by 2002:a05:622a:259a:b0:51c:185b:29e0 with SMTP id d75a77b69052e-52b38387758mr28017031cf.10.1785416260679;
        Thu, 30 Jul 2026 05:57:40 -0700 (PDT)
X-Received: by 2002:a05:622a:259a:b0:51c:185b:29e0 with SMTP id d75a77b69052e-52b38387758mr28015851cf.10.1785416259036;
        Thu, 30 Jul 2026 05:57:39 -0700 (PDT)
Received: from localhost (cst-prg-94-50.cust.vodafone.cz. [46.135.94.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a07c7682dcsm593594a12.4.2026.07.30.05.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 05:57:38 -0700 (PDT)
Date: Thu, 30 Jul 2026 14:57:36 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, joro@8bytes.org,
        will@kernel.org, nicolinc@nvidia.com, jgg@ziepe.ca
Subject: Re: [PATCH] iommu/dma: Restore locking around msi_page_list
Message-ID: <7kuyuyc3niyr7nvtppu7git4wno5htoypsvmcm6uhnqx6pzj74@ozixdbv6y6mn>
References: <20260728123313.1284782-1-andrew.jones@oss.qualcomm.com>
 <7c8097fb-2f4c-442b-9aaa-4c04d10a1988@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c8097fb-2f4c-442b-9aaa-4c04d10a1988@arm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA5OCBTYWx0ZWRfX6qb7B8gF4t8O
 VjIsV4F7fAzXSSs7uOTtH1khNRYuWyJdSvPFidJroj8j2/h0DykD/WdAsJV6bhiD7zQq7CBhOam
 15Qmd0oMSU+GAMmP5K0eW8e7AShIIxQ=
X-Proofpoint-GUID: ZRtAdKfpLvL93FDD92SC1XFggge7jmd2
X-Authority-Analysis: v=2.4 cv=OauoyBTY c=1 sm=1 tr=0 ts=6a6b4a46 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=K44ovq/QSKyRiRxWKRAbdQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=YSkgSfBlQmtJ0r3t_9IA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: ZRtAdKfpLvL93FDD92SC1XFggge7jmd2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA5OCBTYWx0ZWRfX+LVi/kQR2ZWm
 drA5cAmR8pdu4+aRb5hA6UYmhVFDkc1WsjLfGycq8btxdRrRgwoBJxlGnuIimgsX2UuGvknzfRf
 w1kLssSUAFnAlcalKLnB26bLJlwXojglM6FgpTnvMvxdW0Nu3PkeEXWhc2FEacWJOEqY68q3HAO
 hf+StJMwBc7cGowuTjLeUnRzjmXM9CXTebsbh5GcgPHIW9jRFvNQVweT748R4QeQSWIovINIfTu
 bsjIxfP0Y9vK8scV8IFRyQWVampBNr0GUmpDE5dNs8HuDV4SvYkm/gqz6on38WRK8L1l1Kp7F8a
 mPPHgOKQKC2i0SIeok2HXJ+S/fnusu99JawDFQh6Gy1Y0NEK/kJObrvmhpylfR48fng0K3JZw7N
 0Wb/USI8RZFozCq+WZE3CST9zW5eBkCrG15KLcLkuf+FiwVT6mgnWO/rxtYHthNF5y7k+15ZtWL
 rb7uU6BYiUABKF+XmRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300098

On Tue, Jul 28, 2026 at 01:50:48PM +0100, Robin Murphy wrote:
> On 28/07/2026 1:33 pm, Andrew Jones wrote:
> > Unlike a group's default domain, which is always freshly allocated
> > and privately owned (iommu_group_alloc_default_domain()), VFIO type1's
> > legacy container merges any newly attached group into an existing
> > domain whenever their iommu_ops and cache-coherency enforcement match.
> > 
> > iommu_dma_get_msi_page() only asserts the caller's own group mutex is
> > held (iommu_group_mutex_assert()). On an IOMMU that publishes
> > IOMMU_RESV_SW_MSI, e.g. ARM SMMU, a VM with two such devices assigned
> > through the legacy container can have their guest drivers probe and
> > allocate MSIs in parallel; each host-side VFIO_DEVICE_SET_IRQS lands
> > on a different device fd and group mutex, but both devices' domains
> > are the same merged domain, so both can enter
> > iommu_dma_get_msi_page() concurrently and corrupt msi_page_list.
> > 
> > commit 288683c92b1a ("iommu: Make iommu_dma_prepare_msi() into a
> > generic operation") dropped the prior msi_prepare_lock on the
> > reasoning that "each iommu_domain is unique to a group," which holds
> > for default domains but not this VFIO type1 case. iommufd already
> > handles its analogous list correctly: iommufd_sw_msi_get_map()'s
> > sw_msi_list is explicitly ctx-wide and protected by ctx->sw_msi_lock,
> > not a per-group lock. Give dma-iommu's cookie the same treatment: a
> > mutex scoped to the domain, held around the lookup-or-insert in
> > iommu_dma_get_msi_page().
> > 
> > Fixes: 288683c92b1a ("iommu: Make iommu_dma_prepare_msi() into a generic operation")
> > Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> > ---
> > 
> > Sashiko reported this issue while reviewing a riscv iommu series[1].
> > I've only compile-tested this fix.
> > 
> > [1] https://sashiko.dev/#/patchset/20260724151218.965929-1-andrew.jones@oss.qualcomm.com
> > 
> > 
> >   drivers/iommu/dma-iommu.c | 26 ++++++++++++++++++++++++++
> >   1 file changed, 26 insertions(+)
> > 
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 9abaec0703ef..0b5da4579aaf 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -58,6 +58,7 @@ struct iommu_dma_options {
> >   struct iommu_dma_cookie {
> >   	struct iova_domain iovad;
> >   	struct list_head msi_page_list;
> > +	struct mutex msi_lock;
> >   	/* Flush queue */
> >   	union {
> >   		struct iova_fq *single_fq;
> > @@ -80,6 +81,7 @@ struct iommu_dma_cookie {
> >   struct iommu_dma_msi_cookie {
> >   	dma_addr_t msi_iova;
> >   	struct list_head msi_page_list;
> > +	struct mutex msi_lock;
> >   };
> >   static DEFINE_STATIC_KEY_FALSE(iommu_deferred_attach_enabled);
> > @@ -378,6 +380,7 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
> >   		return -ENOMEM;
> >   	INIT_LIST_HEAD(&cookie->msi_page_list);
> > +	mutex_init(&cookie->msi_lock);
> >   	domain->cookie_type = IOMMU_COOKIE_DMA_IOVA;
> >   	domain->iova_cookie = cookie;
> >   	return 0;
> > @@ -411,6 +414,7 @@ int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
> >   	cookie->msi_iova = base;
> >   	INIT_LIST_HEAD(&cookie->msi_page_list);
> > +	mutex_init(&cookie->msi_lock);
> >   	domain->cookie_type = IOMMU_COOKIE_DMA_MSI;
> >   	domain->msi_cookie = cookie;
> >   	return 0;
> > @@ -2196,6 +2200,18 @@ static struct list_head *cookie_msi_pages(const struct iommu_domain *domain)
> >   	}
> >   }
> > +static struct mutex *cookie_msi_lock(const struct iommu_domain *domain)
> > +{
> > +	switch (domain->cookie_type) {
> > +	case IOMMU_COOKIE_DMA_IOVA:
> > +		return &domain->iova_cookie->msi_lock;
> > +	case IOMMU_COOKIE_DMA_MSI:
> > +		return &domain->msi_cookie->msi_lock;
> > +	default:
> > +		BUG();
> > +	}
> > +}
> > +
> >   static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
> >   		phys_addr_t msi_addr, struct iommu_domain *domain)
> >   {
> > @@ -2205,6 +2221,16 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
> >   	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> >   	size_t size = cookie_msi_granule(domain);
> > +	/*
> > +	 * A VFIO type1 container can attach the same domain to devices in
> > +	 * different iommu groups, each serialised by its own group mutex, so
> > +	 * the group mutex held by iommu_dma_sw_msi()'s caller isn't enough to
> > +	 * serialise msi_page_list lookups and insertions against each other
> > +	 * here; take the cookie's own lock instead, scoped to just this
> > +	 * domain.
> > +	 */
> > +	guard(mutex)(cookie_msi_lock(domain));
> 
> If this is still the sole place it's needed, why not just bring back the
> static lock as before? I can't see that requesting MSIs would be a
> particularly performance-sensitive or highly-contended operation to justify
> cluttering up domains with something that in one case is known to be
> unnecessary and in the other is still only for a rare corner case.

Agreed. I'll send a v2 with the static lock restored.

> 
> Alternatively, if IOMMUFD is able to do the right thing at the higher level,
> is there any scope for VFIO type1 to similarly serialise its own calls?

I don't think so. VFIO type1 goes through iommu_dma_sw_msi(), rather than
a vfio owned function, so there's no clean way to use a vfio lock there.
iommufd goes through its own iommufd_sw_msi().

Thanks,
drew
