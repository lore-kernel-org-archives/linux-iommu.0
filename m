Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E472F4219EF
	for <iommu@lists.linux.dev>; Thu,  5 Feb 2026 15:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770303870; cv=none; b=W+8++oK6DcqpCaw2tfLbv+5Iapc3TbqgY6NyCF1RJBSBnS5Gw/IiPLnOP5usnnJeI3nO/G2t54BGxb+PH8++/Pnut3mDJF3iderVm5QrpYcvmCWEdaRlCQU7JqbCgDzOU+nfii55bOWvGJzonUiI3SRWNktJhYZEKuiRF53Oz+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770303870; c=relaxed/simple;
	bh=SUsEwkuyVvNP3vyBu9cxsyIKK9MZJsYqzp9t9GalqBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZDaeEGtHUvf41S9+sQ9Er6sKhzRLKPOGqPOhaS+80U87rp4f9YJk6efOmsJUt315z8fabaGd9CQj4yISQE/Ogu1PJV+O2I9Mgaj275k9uyzKx2mIT5i9sQ/iKvN0R36Tlllg7i9B39VMbiI8FRbn32gxeyI6qanSbbie7RjLI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OvdZEEh9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DvtI78Bk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OvdZEEh9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DvtI78Bk"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615AxM3X3032152
	for <iommu@lists.linux.dev>; Thu, 5 Feb 2026 15:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=KfBltjWFs/4bjLl10PANJ+We
	wubPhQqXLGvIdvHvBRo=; b=OvdZEEh9XkPxnIwQcO8fsStOxA7WybJudPm1SCz+
	XQ+z1brLbXcUFfSgLIZCWzoy2jRfANeM6wwnOxYVNoSDwyBs/y/7x84JC2lwgiU5
	05x9skkTvIdMC6LHpFImXlJMqa0DMau4loxb9fKpXzryA2EovY+LCtU0LJn1iaBp
	Sk2d0uqf2x5NVk5pAB7MCjMzBap09SrJA2KKXacL5/dkW/IaKgDVnAYUQ54h4zuD
	AHX4PVEDKrBviVzdf00Du6PHrYlQvmgwiZcYLcgtVu9GL+0ahE0QPqbCdLPc13Z2
	FFBty+5mqMDEkZzACzI495/LgKdmO/2yd/8QduqH3p9FrQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c4a7tkn9s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 05 Feb 2026 15:04:29 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b71bdcd037so716072eec.1
        for <iommu@lists.linux.dev>; Thu, 05 Feb 2026 07:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770303868; x=1770908668; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KfBltjWFs/4bjLl10PANJ+WewubPhQqXLGvIdvHvBRo=;
        b=DvtI78Bk+2KP+6TUZZ3BUgXAgkbiKMmahQgPmuaJLnDk3lRL73N78/M3MOhqg+h2/P
         Ngoh0KwG67oIxjBY6gQDz07aYfIzC4J1J/11atFyqv8ViM4DNXNQs68TKBkcmhlYEbpC
         nwlG1E4XW/RqkQ7pmuuPC37xtbXYcDZy3YO10tObNHNmtcy8w//r1dUllnDdFGoi7TLS
         XDOoCAh52G7BwWnlhBEA3LrsviQLw1X2grtUyG8kdNlHnf3BaovNpnWsYC0op02Tk1Df
         ms3bjRNFbHta+GHytZZNPCUXJCMxkk+1FBcVRUA3+zA2VaR0SmjrZsUCGMEvm4nRmzJz
         bCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770303868; x=1770908668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KfBltjWFs/4bjLl10PANJ+WewubPhQqXLGvIdvHvBRo=;
        b=QfJE5Zr1JCTiPhe7HZZSC4z67sZTq8Kra3VnmFYRxtoBnjfkz+A9RTVhlNIfoEM74l
         tWsgupC9QWy8fpaoFqA5zpMgVS7AK1bLXlzaUr6leTwusR+lFnuvnMsmoHqx38F3yQNQ
         KHGFANJWH07d/xHb/h42W2oPA0vFMl9yK/tMjzGJQMGji0IPxtqLqKCrw+rttmdubA5n
         pe6Aiy6kaJxEuDKRFO54dzepK0g8Es/+XcKyylfSbiCtnQLspTQaYKyxl+GcDWRB1gKc
         tsj3fg05fNljGvIo7hBYzSB0aw7/h3ZlnL9tZeWuqc8D2aHECrWhCoqV5mJefZyGZc02
         Iv5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXH+a4+ETLRnXl+8DZkb1LFAe8jEPyRkXn4sUOc+h/CCVmNemAzICMoc1nQTPSSu+klh81J0A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxthO69ZWwcqZ09hg8wI/Z47/QFsJJ8Dhhp7gq7vx11nu54+QS9
	x69gzTaFP6eO3G5j3VS7dqrPlKtD0h3IL2JEYkUmRq6WbKlUhPvwO82Awqdes3/2WfG/aYthvIs
	GzJsBW2LQ0q089MAxXqxQuzuX7POjQsUT8trU+qrxyJQhuvPS8pJMOTkMtA==
X-Gm-Gg: AZuq6aJy6VhWLZaUEEt8PMizkAni9H2/qJgUyqMCIGssD0b1QkaillggDsRCiR3kJ/x
	QTWGgV1PM74aBWFxtrT/RzHCskjwqikGkAIUF0EK5airgAgx2cTubyeCD+k2OaQcbJIdAJlmAq7
	O0AqO98b+jb5aqpX9mEoM+2gtmNagGlXqNKzuzI8apCF1nTt8A9re8eHYyU0hJiqKQ+7Yz6VhM2
	6qhfc4iLz9Y2xOoZxhjY4JEgcEDTiuMN8C8sX6m/QqazzfYrVG4FafPrfnyb9qUd4wPU69UBYs9
	4WdZfPS+UlHQTNDUBbQF3ureJxh7Uyrz0yEsmoHyDkLjZERJ26RMPtYhzAPI5dFwBEyyz+m0K0M
	Dy91ARAI/3ReHXNBrOII=
X-Received: by 2002:a05:693c:2c0a:b0:2b8:3224:90fc with SMTP id 5a478bee46e88-2b845e48ae3mr1234318eec.5.1770303866780;
        Thu, 05 Feb 2026 07:04:26 -0800 (PST)
X-Received: by 2002:a05:693c:2c0a:b0:2b8:3224:90fc with SMTP id 5a478bee46e88-2b845e48ae3mr1234303eec.5.1770303866168;
        Thu, 05 Feb 2026 07:04:26 -0800 (PST)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b832e12845sm3491862eec.5.2026.02.05.07.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 07:04:25 -0800 (PST)
Date: Thu, 5 Feb 2026 09:04:24 -0600
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Lv Zheng <lv.zheng@linux.spacemit.com>
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>, Jingyu Li <joey.li@spacemit.com>,
        iommu@lists.linux.dev, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/8] iommu/riscv: Fix WSI mode IRQ number handling
Message-ID: <qlnntgtoaatvdpyvusjhe2y3hickopigwf3sobtnsfwpfhwjiu@zi4auf65eepa>
References: <cover.1769562575.git.lv.zheng@spacemit.com>
 <cover.1770195980.git.lv.zheng@linux.spacemit.com>
 <F77F878EF7C59BD3+a9078997d97dacd05d1271a5390dfd08a402b325.1770195980.git.lv.zheng@linux.spacemit.com>
 <2ueryrki7uzpjn6rbqz7scy46sjhw76jjilddz2naslz3eyfdp@ycwf42eaw5yy>
 <927D288E956D61AD+d1488c72-afff-49d2-bb6b-5ef5ea08b627@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <927D288E956D61AD+d1488c72-afff-49d2-bb6b-5ef5ea08b627@linux.spacemit.com>
X-Proofpoint-ORIG-GUID: HPYHrkWG-xGF2KhqSUndhlasDFH-uCXZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDExMyBTYWx0ZWRfX+F0jHhxYOu91
 zMkntXBkrn7URAsp4EKyY5p5+L6MkmVesb2xO9f2+SRYC9rEbv8Q1D3J3H6nObNKEj9fGQNmC05
 gbjRHrY+mNcRJ27HgEoWljp48hasqzz4TTJzjb9SBiBng/IM3z6NTDpfTdWMmUf//YOg+beYdO0
 bX8FlPtPyqXU9g7mLgjmVoKlqIHkcwEI/E0QQGTuTWSVK5CRuMUFydtGY+xPebYn/pXX8yv+OiY
 3ToF1X2PivkpJDACvlqgsyExsNF0T5HKSreYWuSITU2i1s3wY0LnWDjAhcJCeMbScnlMOr/YCy8
 Gnfu8inKiE/MNG/5EO4LB3Omfq+jxE7q+jI6YdE9YdGR9VPGYnzy+aTSqmL3NgCtd3zJAR5KYj1
 lg7crp47TcLY5LfcG5Di1o0tSyVNwkmtg4Rn9pOxM7s1w15lCg75yz0f7Fywv0kazsCyNwFX9E1
 rTkLl4+N1l2RgLXo9oA==
X-Proofpoint-GUID: HPYHrkWG-xGF2KhqSUndhlasDFH-uCXZ
X-Authority-Analysis: v=2.4 cv=QaVrf8bv c=1 sm=1 tr=0 ts=6984b17d cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=2SqC6Y7SbBa8MZsB_aYA:9 a=CjuIK1q_8ugA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_03,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602050113

On Thu, Feb 05, 2026 at 11:52:57AM +0800, Lv Zheng wrote:
> On 2/5/2026 1:20 AM, Andrew Jones wrote:
> > On Wed, Feb 04, 2026 at 05:08:52PM +0800, Lv Zheng wrote:
...
> > > diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> > > index d9429097a2b5..26630979473b 100644
> > > --- a/drivers/iommu/riscv/iommu.c
> > > +++ b/drivers/iommu/riscv/iommu.c
> > > @@ -1593,11 +1593,26 @@ static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
> > >   		       FIELD_PREP(RISCV_IOMMU_ICVEC_PMIV, 3 % iommu->irqs_count);
> > >   	riscv_iommu_writeq(iommu, RISCV_IOMMU_REG_ICVEC, iommu->icvec);
> > >   	iommu->icvec = riscv_iommu_readq(iommu, RISCV_IOMMU_REG_ICVEC);
> > > -	if (max(max(FIELD_GET(RISCV_IOMMU_ICVEC_CIV, iommu->icvec),
> > > -		    FIELD_GET(RISCV_IOMMU_ICVEC_FIV, iommu->icvec)),
> > > -		max(FIELD_GET(RISCV_IOMMU_ICVEC_PIV, iommu->icvec),
> > > -		    FIELD_GET(RISCV_IOMMU_ICVEC_PMIV, iommu->icvec))) >= iommu->irqs_count)
> > > -		return -EINVAL;
> > > +	/*
> > > +	 * In WSI mode, ICVEC may read as zero. Only validate if using MSI.
> > > +	 * Check if FCTL.WSI is set to determine interrupt mode.
> > > +	 */
> > > +	if (!(iommu->fctl & RISCV_IOMMU_FCTL_WSI)) {
> > 
> > The behavior of ICVEC does not depend on FCTL.WSI
> > 
> > > +		if (max(max(FIELD_GET(RISCV_IOMMU_ICVEC_CIV, iommu->icvec),
> > > +			    FIELD_GET(RISCV_IOMMU_ICVEC_FIV, iommu->icvec)),
> > > +			max(FIELD_GET(RISCV_IOMMU_ICVEC_PIV, iommu->icvec),
> > > +			    FIELD_GET(RISCV_IOMMU_ICVEC_PMIV, iommu->icvec))) >= iommu->irqs_count)
> > > +			return -EINVAL;
> > > +	} else {
> > > +		/*
> > > +		 * WSI mode: ICVEC is not used. Set to identity mapping for
> > > +		 * riscv_iommu_queue_vec() to work correctly.
> > > +		 */
> > > +		iommu->icvec = FIELD_PREP(RISCV_IOMMU_ICVEC_CIV, 0) |
> > > +			       FIELD_PREP(RISCV_IOMMU_ICVEC_FIV, 1) |
> > > +			       FIELD_PREP(RISCV_IOMMU_ICVEC_PIV, 2) |
> > > +			       FIELD_PREP(RISCV_IOMMU_ICVEC_PMIV, 3);
> > 
> > It's certainly not correct to set iommu->icvec to anything that can't be
> > written to the IOMMU's WARL ICVEC fields and read back again.
> 
> Indeed.
> It looks I can keep icvec returned for WSI and keeps the write-and-read
> check logic only for MSI.
>

You shouldn't need to touch this code at all. I don't see anything to fix
wrt the spec. As I said, if iommu->irqs_count is known to be greater than
one but you're getting zero back from ICVEC even after writing 0xffff to
it first, then ICVEC on your IOMMU is broken. Once you've confirmed that,
then the best you can do is add some workaround for your specific IOMMU
here.

Thanks,
drew
