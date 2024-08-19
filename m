Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34081DF68B
	for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 22:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724106897; cv=none; b=Z9g+wQm6gaeHpwrGswvgJx+/u9HEP7hamqGZFomZiXQ9xiVZXZjpWNeuBbxAWkDDBufn+oBNXDTvh82VXeO6UYGioDeHWop/MVWUqXCUDdfnXzn5Kr0ULK21s3FkGXDiGYKmkcXEVRaYPFwjJgem/uqP/HaNYIgehWTSkMTQDmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724106897; c=relaxed/simple;
	bh=yAeeXH3hEK8ajF7huENH61OB3ZzOO1jVBaZD5aohuEs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCFyhUUmdEmsCECbAwswkMACIQRpPaagMdqPUf1wZIV4Au8CxQiOuMRkhuDqkDlzZsLhZ/VSlBzZ4srv9p69AnmqLzmpp4b31is1a7/ugVe1ieUREtdaXwq7j+0O75Fcz+ztXL8Myuy7+5tx4JK4iI58yahULjkA2CUURqOJAHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id 174dc974-5e7b-11ef-8eb5-005056bdf889;
	Tue, 20 Aug 2024 01:33:44 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 20 Aug 2024 01:33:43 +0300
To: Rob Herring <robh@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	Oreoluwa Babatunde <quic_obabatun@quicinc.com>,
	saravanak@google.com, klarasmodin@gmail.com, aisheng.dong@nxp.com,
	hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, will@kernel.org, catalin.marinas@arm.com,
	kernel@quicinc.com
Subject: Re: [PATCH v7 0/2] Dynamic Allocation of the reserved_mem array
Message-ID: <ZsPIATwAPpw7vnMU@surfacebook.localdomain>
References: <20240809184814.2703050-1-quic_obabatun@quicinc.com>
 <ZsN_p9l8Pw2_X3j3@black.fi.intel.com>
 <CAL_JsqJHRoP40E2Wqk_Dsc8hmAdN-63ikR2BWqHeihM7F49ohQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJHRoP40E2Wqk_Dsc8hmAdN-63ikR2BWqHeihM7F49ohQ@mail.gmail.com>

Mon, Aug 19, 2024 at 04:55:49PM -0500, Rob Herring kirjoitti:
> On Mon, Aug 19, 2024 at 12:23 PM Andy Shevchenko
> <andy@black.fi.intel.com> wrote:

...

> > This series (in particular the first patch) broke boot on Intel Meteor
> > Lake-P. Taking Linux next of 20240819 with these being reverted makes
> > things work again.
> 
> Looks like this provides some detail:
> https://lore.kernel.org/all/202408192157.8d8fe8a9-oliver.sang@intel.com/
> 
> I've dropped the patches for now.

Thank you, that's what I have asked for!

> > Taking into account bisectability issue (that's how I noticed the issue
> > in the first place) I think it would be nice to have no such patches at
> > all in the respective subsystem tree. On my side I may help with testing
> > whatever solution or next version provides.
> 
> I don't follow what you are asking for? That the patches should be
> bisectable? Well, yes, of course, but I don't verify that typically.
> Patch 1 builds fine for m, so I'm not sure what issue you see.

There are two types of bisectability:
1) compile-time;
2) run-time.

People often forgot about #2 and that's exactly what I'm complaining about.
Due to bisecting another thing, I have stumbled over this issue.

-- 
With Best Regards,
Andy Shevchenko


