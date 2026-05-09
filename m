Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A05B1E1DE5
	for <iommu@lists.linux.dev>; Sat,  9 May 2026 06:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778307060; cv=none; b=kzi+X09UaDGzTJ6v/A+z6mkIp5jSIEpr+E84t6o4ewEYfe2SSUFHNkfeLp/L07pxBRtbpq9tbayjl6bxOQ7O3/MBW2xsi9DUIL2JbpF8XycAEwYjJv0DJEZy7T8QSXAGD4PJ9Q6VArWN19b6KRR2jA/vwG0YosS0inf/dycgoCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778307060; c=relaxed/simple;
	bh=gUtJBgdHbKk8C8Dkub6YTx8JZpA6mK4tj8PEmSeG9kQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEG9k/048zWiVLVVUSXkJ26Vv9cFtTOjde5fhwDzXcNjOHN9yKcuiSmJH8oIaT8RZJnrbountMA+YVdJGFmMhWN0s3pGSVF/n3NA0V5hdUMZYL3ITzpzXtYtXMc+Onx4qhjvC2/ICfb5UrWvd6IK3ba4sLUCIMZ6yK03VaKin/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=yZOHDRFn; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="yZOHDRFn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1778307047;
	bh=lh+Rf+S9Y1oV0j5jnSZk/rlpg3XQLtQo9q16FEDk7A4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=yZOHDRFnwU+rUgUNkW/H74Jd8D0ZAcpIR4OFxk+7Okpi2q8uce6i4OTcIxnEde3Xk
	 zfOE++1Ieoeauxf5L1mZ9so+8jKisKqR/eO1PGSsyRqFRqt2ZHLrheMcmTdogDY9bA
	 c3b3pHoiJb4RmhG0w0s7xW2uUCOd1jfH0PnI42DI=
Received: from localhost ([61.169.175.90])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 2AD878A5; Sat, 09 May 2026 14:10:45 +0800
X-QQ-mid: xmsmtpt1778307045t6d36uikg
Message-ID: <tencent_07DC93F42D53F6A4C20886013823A83F6C06@qq.com>
X-QQ-XMAILINFO: M2SvzgchpLqfYZz+3Zuh5EItW+RffQKBvaDfLY9K8+69X/3AG7l27NptDT7PL4
	 cxownEE9lNB3RRvL0opEYrgVVTAwXFvq3CcAbsKMvko7OnnLJSUr8KjgvHC38Dw6t3X7+4xzLb6N
	 Ny1cAB66V7/G91OQaidOXldWlSpBjdCdX20kKDBrHiUEnXppdGVsk5c0nErGitw/tgRHw4sIAZQk
	 BcbBV/cfN/wLLrvRCk44LQMHaYFDN6SCI04a0Sn7kogW5Mxd3wb4ySwM/PhP/3FV9eQFEMZj6Sdd
	 Si6a8Dcvac0lMcf3xwSW02fKLNgfCgZKmquoGGS5j5YS2l+P5j+LvsDKl8PkYrVHpGqW4mMtDLlH
	 acPEdjt/kL58PGHbo34j1PYos4rzmd2qcZzUA9CBbHS1mZssaDiUG1PeEwoUaHQn8sfz6vVlI4eb
	 nO8Psw3xkhGENk5fR4ce5ilnZ8Dus5Bfkg47arRvQpUZT/JoNQR5WZBAacoi624kIijRPEEkZDPu
	 +tb0G3H2DPVtS8RnGyFb2YoDzaCm6xBlVLWx0ApTdXEnSfJhnKJDvwYox64ndLcYozy4UFHbihBn
	 m6jfh3O2CtI7hcg8SyVjTvB/ewClW7vYGyrdKQn3LhAy/MIT93TfLrNbor1cm1zOxIBqSsyCD3u3
	 NsJqeZDyKAmrLP6aUrEUa4PqygBpqX5gVe272G/x7VkH92R9sxy/WsSK0PVVqzq9QOBpEBH0H0Ba
	 6hayH1FS1pLer10vrlXZyizEQPZnGIuFMRLCKe9nYsrU1tEZo16FMz/nbkax8XQz85JVwUUCjOdX
	 JaE+06VY0OeEXK35QTRW8nPlP6Q+/2Iguhxid36jmwjdm/1xmwCqJV9UAJd1Jsi4Zsfp+KW37pUN
	 Q8vArVxOudIWOSG4QCJ6vyh6Ef96iPgsrSs48G9P/ksqK85qBCuxQ2uHasH3KqYnF73lYpW932/v
	 8+7IL399MPqoxShtLo0ToobQxLUDiiOkSjdik3gfg+WZ7lD3NKgrvzh1sVIf34Klzz1MrZCdY5RF
	 HpW7A15vKZMIgodMOuXWf+PT5hBk5tpHyIKJQqAo7Pk36/7TYZ
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
Date: Sat, 9 May 2026 14:10:46 +0800
From: Leo Jiang <leo.jiang1224@foxmail.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	joro@8bytes.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Stop queue allocation retry at
 PAGE_SIZE
X-OQ-MSGID: <20260509061046.tdau6n6p4564k7sf@LAPTOP-LEO.localdomain>
References: <tencent_F6E384A40D990A279B460A0CDE1927FDF509@qq.com>
 <0fdf4b1f-90f2-4f69-9d2b-dc5f608e9c1c@arm.com>
 <aeeoEHHNKPo32H9R@willie-the-truck>
 <tencent_DA99B62735469A0CD219E9FC73E234A47309@qq.com>
 <af340uhd40FLTaEO@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af340uhd40FLTaEO@google.com>

On Fri, May 08, 2026 at 02:53:06PM +0000, Pranjal Shrivastava wrote:

> On Wed, Apr 22, 2026 at 05:13:08PM +0800, Leo Jiang wrote:
> > Hi Will, Robin,
> > 
> > Thank you both for the detailed feedback.
> > 
> > Robin, you are absolutely correct. After a deeper look into the source code,
> > I see that allocations smaller than a page are indeed possible in certain
> > cases. My previous assumption about the DMA API's granularity was wrong,
> > and I appreciate the correction.
> > 
> > However, as Will noted that the current logic deviates from the original
> > intent, I have prepared a v2 to limit the queue allocation retry boundary
> > to PAGE_SIZE.
> > 
> > In v2, I have:
> >  - Updated my identity to Leo Jiang.
> >  - Removed the code comments as suggested.
> > 
> > I will send the v2 as a follow-up shortly.
> 
> Hi Leo,
> 
> The general guidance is to send the v2 as a fresh email so that it
> doesn't drop off the commmunity's radar.
> 
> Thanks,
> Praan

Thanks for the guidance, Praan. I'll send v2 as a fresh thread shortly.

Best regards,
Leo Jiang

