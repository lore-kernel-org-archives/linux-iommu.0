Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B03E35950
	for <iommu@lists.linux.dev>; Wed,  4 Feb 2026 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770221402; cv=none; b=m0QeTELSIYeAE/zFtEaLjKa62VhSTV3LHgUWFUsgs+sD+FDhUn2YjmJudy0ctMTa3Ppkj06cEAbP7e8RmCMsSOhrvLllhr9CIWZwEmpAu/XssPw0EWMvqurdJomUUbcluNajPrDPXQSHTjgi5gHD384jGhDhmHGT1iygcpvA9D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770221402; c=relaxed/simple;
	bh=r5jkgBASvfahYDIpNq482tH9/i78Bx5EpWMZOjx0RnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rEZqxQIi6du8OrUAk1m8X9xEEeC1PLXpiH5hKINoE+Qxs4MTzqbqyGD56xgEOk2fbpKr6QK52ulkH9vl7CI5PTavrdUZ0qDZooRlci1jxZ1OUOriE3bjieAiLuufFd2bd+eLSo6qhDTS0bdBhOefUjWPdEZ+MPByxng9cINNTzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iotCLpR+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gYg9DtX8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iotCLpR+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gYg9DtX8"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614CINVi1880644
	for <iommu@lists.linux.dev>; Wed, 4 Feb 2026 16:10:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Cfk2AxvSUaOW6gTcg737om3J
	rAPlsakGmZKpL4ObUwU=; b=iotCLpR+MUNKsJaGaSaLwpHUjtrsFLqlafbgHX47
	QEq1AOjsjDh87wO13lUIj8MSyXlPbLm9icxg1UVJA4g3EX1SG2/qv5RaoCChX5Ve
	EpxiQRQjsWclmrEINKGbfJ581H+s6+2dneGGHsGtQTKOByV4wHx1mX0fMOFWCKBt
	hC1DHFFDbKwJSOdufwbidZZ/RwLMStXJuEd4utvc8FboH8DP4frVq6E4dMDRfsj9
	f9cYM03E6QvB5bRZ8ivO58Zs2V1lLm9hHmQjEJGQooXx2fNpauUOqVD3WPFStd4M
	xF07fj+1+5DhTvpmq1FrKzJLvlzfl2MyO23pOuv4zAWU4Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c43n9s4as-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 04 Feb 2026 16:10:00 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2b8295e5703so10997780eec.0
        for <iommu@lists.linux.dev>; Wed, 04 Feb 2026 08:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770221400; x=1770826200; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cfk2AxvSUaOW6gTcg737om3JrAPlsakGmZKpL4ObUwU=;
        b=gYg9DtX82FsjfG2o3S2p3jbj+LWxglQ3o6Doqn5JTgpH5c5cch6QyNBYb9j/Ed2etW
         vkC24wkWavtr+gwLZHGb9//bvCNv1MfTkiAwXldfWQmaoRE/87TIW/H2px+GubSEkGxB
         5PPLTxYFoDujQAaDLDtJZOegy1h4ESdm/SMHzrhFkMODxuKQS5Elyv3J4nst0F6e8+Hd
         zM5nRUSpLBPabPfMtfHNIJX+LhVINiawK7X+dpNN2PsbeRibWASdgxoUBw7iUs3Fxdli
         21j04k+J8kXr1Kmp2cQBJ3ngMCbKnJzxuPLyUGD0Z95eueJQpseY+KAeMIJA64CjXzNd
         BqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770221400; x=1770826200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cfk2AxvSUaOW6gTcg737om3JrAPlsakGmZKpL4ObUwU=;
        b=eFLkf+FJ2k04gsdi1vN0mU3rEuK/9l8ShPfBTrFZCmYYKWvtRiQoTNsmwAq/SHAhxF
         0bPXLuriLi+BKKFgoq0a4FjiKEonunGj5oWtkxlEwY/3CNJkKSGZG0RvpL5uIshn+MYk
         Qqv3FMX6vAWxZLJcp1wYxCNUFxYZwY98yFC65XUrgrO7AGr8X1rnahBJoFtqgk/GQP7G
         sOpAvrhwrPDX+oN8YyKgcMFzMvx6LyrkwXfWf88qG9GRjEsCO0HVDOfDC2aJXn5Umlx6
         AJL2guFMcYJLwW02zjDkYddFRdzly2VS4qJxdNJ0o81vN8RpRl1nYCTiyAARIfzJT2It
         WxHg==
X-Forwarded-Encrypted: i=1; AJvYcCVBXQ9yj3tg22jQSa8nwGVhSqzw2qn+7NlL2VvfQCCWYwNVf9mcFqYZSGPG5zPpW/Rwo0r6QA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTxXjH8dcLP56eQIVTxrEP4+YVo8QuvoZsZkuF8rUn7uJFHzrj
	GaQ7GIihgKEX1+l+edhvOZusLUe+ucrvAwYAyLwxjr4PRizm9W5GIzL3UZlpIT4s1GlHG4D8hfw
	cRl8zrPbMgEWqZLyEZ2cL7O9VDnzjTSABdi+Mvo/mzbgo2V//8ewOgxhw0ptHGPER7A==
X-Gm-Gg: AZuq6aL+zNVeu2uW1V5WE7zNlCYG9voAnXPcHDjMZ8OeiUtcwgeESgy7tbfg1hodc/S
	ZLuF61LYj8/l5nsdC1KgoIK3qw5lPUkgbR88Etor4ZcDcd0J/8Ry5+hVe0uYkLveE0JwuKMyjm0
	9ZUksLGTGFDwKjn/WNwvVZK2G5i+7vY6cbnZpitNlqgTt9AJkkSG2mH3v6ckoIIfsjFUlNex9AN
	t+hWgN940LlPLNlpHp8Xn4tP5nPrKzY6yE1X1fmkyKQXC4Xgjx6Sh1sBZH/Zl7VgZuFcepulD0R
	iI+4Fhio0Lztv5o+cjnChRBNiegQDChvURB6s8871COoYaIbtfDsePnU9JKGZr6KtXQs7OALjY8
	SsLe1kYzENrkbVCLzJ9g=
X-Received: by 2002:a05:7301:1296:b0:2a4:3593:646b with SMTP id 5a478bee46e88-2b832a556a6mr1776493eec.27.1770221398519;
        Wed, 04 Feb 2026 08:09:58 -0800 (PST)
X-Received: by 2002:a05:7301:1296:b0:2a4:3593:646b with SMTP id 5a478bee46e88-2b832a556a6mr1776447eec.27.1770221396480;
        Wed, 04 Feb 2026 08:09:56 -0800 (PST)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b832f8e78esm1613358eec.16.2026.02.04.08.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 08:09:55 -0800 (PST)
Date: Wed, 4 Feb 2026 10:09:54 -0600
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Albert Ou <aou@eecs.berkeley.edu>,
        iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <pjw@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Tomasz Jeznach <tjeznach@rivosinc.com>, Will Deacon <will@kernel.org>,
        lihangjing@bytedance.com, Xu Lu <luxu.kernel@bytedance.com>,
        patches@lists.linux.dev, xieyongji@bytedance.com
Subject: Re: [PATCH v2 5/5] iommu/riscv: Allow RISC_VIOMMU to COMPILE_TEST
Message-ID: <5vwi2ayg7mr7ug7ydlyonlrcser5o44pycjsjhg7nyvppuwhhx@gd3s5x6gzhhe>
References: <0-v2-b11ebca8abb6+c096-iommu_pt_riscv_jgg@nvidia.com>
 <5-v2-b11ebca8abb6+c096-iommu_pt_riscv_jgg@nvidia.com>
 <dn7bsft2qvjod3sm6omneq37pwr2jtdzgobapy6obpgccg7soc@ctvs3c2w4vob>
 <20260130234434.GK2223369@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130234434.GK2223369@nvidia.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDEyMiBTYWx0ZWRfX4ZEvbi5N+KeG
 DTh9oNRR5iqk63mZXF3aBbSNVLJJd8p62meOxh6TP0L46NEsypX2CG2smUz+HZwjplOc+fZIXeD
 v54pob+HlzNmjCxM154tYGjOuyAHU2YborQY24rEjQCOllPnoTyqXgKRY815YbhjrxU2IjJR8U0
 znBgqf4uECz78l0+sGh5NrZmONdcaSMsIVkq9EDKA2pEK4HSTG5dacy/tvAIhWeSK67hINpa05K
 Is+R98iY85dgNJNx5cQm8h8GM9gKMLjhdbGAnHD9+y8r+1BfOpvOG8IbymSy1ykXgMYO/tBCzwd
 WzvN9P7tFeQHJsvpikvhZ50cc4O5EpceHcdiAqzjpSFMOjMEnLAhBpgEqSgJkqfiuUdiNPuXHhe
 HD0U7PbEsKteYjRnlCzW572e1d9eMWgn2rxjuczaM12QHhbcdD+ehmPpHqM2ViXtu5LyQXUE+28
 VkQEHA+mdeyW2RqF0tA==
X-Proofpoint-GUID: 7j6xRdawHo4ChXVKsFoc2KEBdZOAagGy
X-Proofpoint-ORIG-GUID: 7j6xRdawHo4ChXVKsFoc2KEBdZOAagGy
X-Authority-Analysis: v=2.4 cv=b42/I9Gx c=1 sm=1 tr=0 ts=69836f58 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=mqPRyWp8_4GUfDidQbUA:9 a=CjuIK1q_8ugA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_05,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602040122

On Fri, Jan 30, 2026 at 07:44:34PM -0400, Jason Gunthorpe wrote:
> On Fri, Jan 30, 2026 at 01:58:51PM -0600, Andrew Jones wrote:
> > >  config RISCV_IOMMU
> > >  	bool "RISC-V IOMMU Support"
> > > -	depends on RISCV && 64BIT
> > > -	default y
> > > +	default RISCV
> > > +	depends on (RISCV || COMPILE_TEST) && 64BIT
> > > +	depends on GENERIC_MSI_IRQ
> > 
> > This new depends isn't called out in the commit message. Maybe it should
> > even be its own patch with a fixes d5f88acdd6ff ("iommu/riscv: Add support
> > for platform msi") tag, but, either way, thanks for the fix.
> 
> I think if riscv has a 32 bit configuration with iommu HW available
> then you'd want a different fix to make it work.. Probably include one
> of the high/low headers to get emulated writeq
> 
> This is just intended to make it work with COMPILE_TEST on eg ARM32.

I was pointing out the new 'depends on GENERIC_MSI_IRQ'. We had the
64BIT already.

Thanks,
drew
