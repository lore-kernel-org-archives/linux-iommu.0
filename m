Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD53476CE5
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787320603; cv=none; b=QvE7+ztAdBYQdM+4zMUUhWDdB9AMQShQuZ2B0SLYZjtGVoiSJ5Zd+K6zxow+V2lLngn4aBnGlwCogkZF3UF55g2I5Fd1cCr+oh9hwqFxSx/Dk4zplteShs/Ttf04Mv8m3sYX/699uMF4NbT72TSlxGAjPByPTT4G6Sy6tyLQrak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787320603; c=relaxed/simple;
	bh=ZZMRpSya+sgh98GBkJ1Ih3BPyxYpSAMd7QPNmKYVyKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onTgTRQVkovW3y2UO6+58zuMV+BfG3BrIa6UHwlF0ATErA3FXVyr0zB4Q4JDYDUDQwK6z55Wg0O9ky0cM3o2EisnORzXkYwLQhZ5CmRUl8gD2gqiJiMa4WRCMfiiSz4Uu4WPo6MtEORX6G9RRy4dNWysPtSL5XntKYN0gy671qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UlQysatI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aQYe0CDA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UlQysatI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aQYe0CDA"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LCooW52029791
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 13:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=208mLy3Ki7ZmUkj5X/SI6UnX
	5AP2enQuN0QqXNysB90=; b=UlQysatIPD9oDfNfH5bXZiRF20aUSbgJm1sesl/U
	ehCjC5bmYfreXwIuQMPVsfjcRSzfDOPM8jfj93DK4MwH322b9pbf/Voh905Kzu0i
	KR8CxvkfdkyNYyXPaxIoxWrR/R+jEhGbgWXeSvmfYXOHmHtcB8Xjgf1n2MJ5vsKb
	ZwrIlQIROWVjb10pUIM5WoMtHxbaDGH6RizJcNbLTzzQzXCmLBd/8bAoXHxtGGJh
	4ehVnPcsDpayitk0mFnoR2c2w78HjZ5Vzodn3R64K96rjQfvoP0I1EzSZNn9hDkf
	RuV4mI1hHdV5rFQvlwW9kT4dvvTPeoj7KVXv9JAduHNPHQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6fue1yws-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 13:56:40 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-90410c668adso11215246d6.1
        for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 06:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787320599; x=1787925399; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=208mLy3Ki7ZmUkj5X/SI6UnX5AP2enQuN0QqXNysB90=;
        b=aQYe0CDAzIVfYvZ9aLyy4STSa5tCKaM4NUVcaJJYlaSYJABu9vXQGsFDJZzrZ10bcf
         SlHNlc+J0QaH/8HtWhdv1DgG1+rGHbW8RG6LD/rNnQda//wvGJq5fqtbo6mQD61iWgjc
         M6PQTGZvDC+xug8PUKslNxQ6Acg2RsNYqQPkMVHjYI/Vo3UJnpjEQskO69MsyMP0fg57
         MNEo/xCGSrltGz2Oq8B8XjPeuorRwvz0ad9TNXaBuc/TORhxG7nCot3ua6iOR7atJN9Z
         GlO5PcXZWNKlUMbAL/9RKmqjW0zF2FJX5qnS7qFOlbLfqgGPR8EtXcrPbpD4ZTmEauxO
         OmqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787320599; x=1787925399;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=208mLy3Ki7ZmUkj5X/SI6UnX5AP2enQuN0QqXNysB90=;
        b=QN1vs7IscMpi1c9XvLSH1DrtVwBx4WcMgAYFyBO04clLIuhv30BhdGKdicTbh5sQav
         Vb+ZocSpVoLQuIhdam7I2w7uX6jeyXKdNe6xblSJBLjzYHcrb/Pe2dFdXYb5O2jaU6Ef
         sPnJwRIYuYU4dOUpfRNdMOyu+A+9kKTIYcMrNEYfpb6itsdhMTjt3C/U65K7IhOyITj5
         +RqGu2Z363hWy9mI8MPTvljVYGspqD90PVaaWm7XafnyGfEQZOAiHrSioKgeO4h1R198
         dKi/mWL1M0iOjkclcxywxiunf9+SYQW5Hhlh+O4dc+aiZC64Uv2aNCdVXxPi1U2sPD9d
         ivqA==
X-Forwarded-Encrypted: i=1; AHgh+Ro6CQuB4fS0AOZWWMU2JhGJZd9Vd8akI33H9zXeThaLGOV+IQIsoUplhArKwPh0fVEJs/zHIQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz03jyba68gA0145iDAPjVVuF+mkCKt3QuAifY/GkP4QKFBdk/d
	x090PXOM45qWY5K9nF8seHFBgiqbDaKfJbEvuhR7phBvnJRbhuOxRjI5HpSIFIe7/7h2PKE3GxD
	m1s8LkRH8Odu60efevawE9e7WNJCcs+gPfKkeitIkLsj0AuVxjxaWjmdoVQ==
X-Gm-Gg: AR+sD13g5MEaNvGMwSCgSKHujmxGHZacZp++OjgTGI9z2jIfdpyVlojxEjucFZQ0Ib4
	QXi8U8w6Qr4o8wTIgAJiOOesminU6qKKdc3QAGRW9j3Mn5Dn+2YI+N4VCBxOn4/k1x7PobvK22X
	D3yGZi/quVikX15TW43UqDw5pFr5+JFeyaFLp/RCV8dqpiFf27J5gkzIPlux1xmhKy7gCOkTea0
	tm/ZCj/gdkXEZ52dl6zRo6QX+rsHYBTEddwa/d5vuL6JK3aCSabdrhULSPn7vdy59aQHTTjuAUE
	C574WsMSe/xht1Gk8Z4XM7fVBMaq65GsDX1Z2R0xfP3ATgALmU9Aa+Zu6jqqxrCfAFH0vJ557Zj
	US6g9MX2OoqwS0Bb/rqHF7WWBKuerblDdpg8=
X-Received: by 2002:a05:622a:4818:b0:527:8770:8fd6 with SMTP id d75a77b69052e-52df5a421b1mr55979411cf.35.1787320598695;
        Fri, 21 Aug 2026 06:56:38 -0700 (PDT)
X-Received: by 2002:a05:622a:4818:b0:527:8770:8fd6 with SMTP id d75a77b69052e-52df5a421b1mr55978681cf.35.1787320598266;
        Fri, 21 Aug 2026 06:56:38 -0700 (PDT)
Received: from localhost (ip-86-49-251-7.bb.vodafone.cz. [86.49.251.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b916a250sm28764715e9.15.2026.08.21.06.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 06:56:37 -0700 (PDT)
Date: Fri, 21 Aug 2026 15:56:36 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
        anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com,
        fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v4 13/21] iommu/riscv: Preserve MSI IOVA state across
 domain replacement
Message-ID: <6d32btsqdpuqta2bda2hr4kco7m46tmpigfcthtpgiogho2xz4@7j6eaudgicct>
References: <20260820214150.545737-1-andrew.jones@oss.qualcomm.com>
 <20260820214150.545737-14-andrew.jones@oss.qualcomm.com>
 <20260820215204.GD244917@nvidia.com>
 <wshoqx3xyz7f2jmhgbyzpkm4ppl64olswhw5u6dye7nmomkari@j2zg5ecuvsmg>
 <20260821132252.GG244917@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821132252.GG244917@nvidia.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEwOCBTYWx0ZWRfX+jTSlnKutSn5
 POk80K6OT1RmFdIp3rlV+DEBAOGIJE+SCGspnvC+U6BrsDMaQ78iKnRnZrcDb3dVFsIvAMpkz7Q
 2YUgEujBClDKmZra3FbaNUTSJ52Nwgw=
X-Authority-Analysis: v=2.4 cv=U9+iy+ru c=1 sm=1 tr=0 ts=6a885918 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=on9AXyaqQ0RhfYpiXjjEXA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=eCfTknyUrC7K7Id0JDUA:9 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: MfK1D9b4DBSfZ3e1NGw4Tt9Mp07mPxH_
X-Proofpoint-ORIG-GUID: MfK1D9b4DBSfZ3e1NGw4Tt9Mp07mPxH_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEwOCBTYWx0ZWRfXzk7sGRJ4Z5TR
 IZf7xMkEkJByRK0pSFkZmEhnyAISyPNRyfTrxrOKF3XIRpdNB0B/yI2VTu7I0nKfmD/DuKEhekH
 tGlWQhox+YtXUTXYSXpUcFX5/OUnquADuRna9TsqcoKENOB8Y4DqbPTTGxDsKhFZhdPM9/pLU5T
 4aQCrObjUUcKyZzr4i1/Ms32yPzdLqZEkNK7+P0f7J1ow+65fXr5q5XnP5sxpAMUc8tqDDeBMpz
 BuDpFZYiDqVx/VEfrCJxAFYppEDPrKf9RJXCdtMwtT48BE5q4aDdWw7sE8vXqzfQR9I7em6e0Ne
 NDRzTLUOfRCES1OrKHGlx3hGPL4Un9ZZjNs/Z/l2dTMUKx1fR5If2PqAnBm02whD7VBwZbkOQCk
 cm5qEz5E9lGk1G0Jy0qEyzy5m5xaoYVaZay08edwPxBxyjt05uBhSVtS90zlzSu9ZqBd1XcgUnM
 eA2/EhfDS5X2pVFHg5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210108

On Fri, Aug 21, 2026 at 10:22:52AM -0300, Jason Gunthorpe wrote:
> On Fri, Aug 21, 2026 at 01:14:39PM +0200, Andrew Jones wrote:
> > On Thu, Aug 20, 2026 at 06:52:04PM -0300, Jason Gunthorpe wrote:
> > > On Thu, Aug 20, 2026 at 11:41:42PM +0200, Andrew Jones wrote:
> > > > MSI IOVAs belong to a paging domain, but iommufd may replace a device's
> > > > domain while its interrupts remain allocated. Waiting for another IRQ
> > > > allocation to populate the new table would leave existing interrupts
> > > > without valid MSI IOVAs.
> > > 
> > > ???
> > > 
> > > iommufd is supposed to handle all of this itself, that is what commit
> > > 40f5175d0eb7 ("iommufd: Implement sw_msi support natively")
> > > 
> > > is doing?
> > > 
> > > The whole point of that commit was so drivers don't have to deal with
> > > this at all.
> > >
> > 
> > This driver relies on that support. iommufd installs all required MSI
> > mappings in the incoming HWPT before attach. The additional driver work
> > is to populate the PA-to-IOVA lookup table riscv needs in MSI composition
> > on IRQ affinity changes.
> 
> So it is all because some of the MSI state got leaked into the iommu
> driver? I do not like it :)
>

It's a cache of the MSI target IOVAs, rather than MSI state itself. But
the batched API lets the descriptor cache one IOVA base, so msi_iova[]
and its maintenance can go. I'll rework that for the next version.

Thanks,
drew
