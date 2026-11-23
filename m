Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795425815;
	b=WmFBnEdwNH/Dexy/i3O2yQf1TpgphXieQo9iJ7NRuj4nnvvXsuwkPfRbqx6k68MiK6sh
	 nLSDyAWXwPf226VZhxvUCVEM91CgzmsT+c6wCKGqtaSWdk8qKbhxT2enUA5Fti07sCzTr
	 wdxmaD8BPL6Gtbc9T1UIeDqbpud8U5Xi6fFHHAAmaChdJ/LY/GH/fkdVm2dwWxV+OpODg
	 Akx1yPxOvX/2MPuuJx6TF0dwQAjkKDLtBHclEKfJYDM6olsMG1qpatoVckrHakhTAGLnA
	 E6dQpJAerRmJKuD1Fh0Qw3BbNVi8e/b8xLSrYDLQaiIwEykKqx5YQcC4das3AR3Q/CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795425815;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=abWMY7ZZrLC+CqjBFoijCLowA5IbNlX6SAVuIWMzYrY=;
	b=t8WkcV5SjKnXgPgLIwo03FLA57b8YxnOZE9VAd/xBd0SW3cqRQMOEJN05epF2ULKTdQa
	 WKn7lS7t6GtJ6HZMRyM8udsDkt3kBEmQfE6FcllElo3+8Wytjvr5EkA+5x2YyOpdzYFSj
	 deJ5meLeUnqVgTozp6B/P1D+uMhfRY3Cg0+bSHWIWhlZohK19vxYRhKMiLzTtqKpTBVOc
	 3UOl3vSU6bIVa6j10ZtcHfxID7NJdrzlVsh02B3IEfk9lbUT3LD4Vz3f20MTgOSBNfZOH
	 XmkP4Rjs4ketN66qYZkmB0ZaJlRjciJ7HJZEBuOnaGewCIZc72n4kF+79qDmO1StsYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=8bytes.org;
	spf=pass smtp.mailfrom=8bytes.org;
	arc=none smtp.remote-ip=85.214.250.239
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0367606A334
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 09:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0367606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549216fa.dip0.t-ipconnect.de [84.146.22.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id EE42F244CA1;
	Mon, 23 Nov 2026 10:23:33 +0100 (CET)
Date: Mon, 23 Nov 2026 10:23:32 +0100
From: "Joerg Roedel (AMD)" <joro@8bytes.org>
To: Qing Zhang <diasyzhangqing@gmail.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kevin Tian <kevin.tian@intel.com>, Krystian Kaniewski <krystianmkaniewski@gmail.com>, 
	Tal Zussman <tz2294@columbia.edu>, linux-kernel@vger.kernel.org, 
	syzbot+fe84fc6a684e0beb86e2@syzkaller.appspotmail.com, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] iommu: Fix dev_iommu leak on mock fwspec initialization
 failure
Message-ID: <awQGCKf4UGKO1bjw@8bytes.org>
References: <6ae402bb.0c1d3ab6.e3d48.006d.GAE@google.com>
 <20261107140000.1-1-diasyzhangqing@gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261107140000.1-1-diasyzhangqing@gmail.com>

On Sat, Nov 07, 2026 at 10:00:00PM +0800, Qing Zhang wrote:
>  drivers/iommu/iommu.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks.
