Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5958A241C8C
	for <iommu@lists.linux.dev>; Fri,  6 Feb 2026 15:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390430; cv=none; b=ZWpCarZkLcD7rlb/9bpnDZKyv4C6jwd5Stg6UuiZxcoemTkTBI7xudy+NtDwIYjbXKGhy2sA6sSd5FawcvusU65xaes28lttxqUYC7AYPRTvsfp4d/2z40kt4HTp4Zb2N9fdxYhzDUlpXLitd6uLkslAd7nplx6EykYHaZjxZi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390430; c=relaxed/simple;
	bh=bRK6FzbFILa5Ip3b30D2dURLw48SKMLMEvj/U6Yrpho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1trpXrswMScS/Xj3YjyDiQAOa+JgeY8H0qhlJkTFuqzkKuRJtHR7X4wH1V8xUICSEi5rzf8c8oDETPGJUgbFX6TVOkDR1cQzNj5DUb/YZp6swPmsGF7WkMPQ57/DBh+9i0Aw/JMvGT5Jncpn7TXNwTs5T3ZeS3nchK7DZfHG+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fE+9OEG0; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fE+9OEG0"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8c6a50c17fdso83044085a.2
        for <iommu@lists.linux.dev>; Fri, 06 Feb 2026 07:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770390429; x=1770995229; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tVq6rfsNPgHkVD9Uk0vE2z8beerbYIiR5ZWjlpv17tE=;
        b=fE+9OEG0lMA802a/yPfdKfxL6lKHl7CCl7OUAoMXW9cqpuEbLguYTJlGD2rnjDjpBf
         TZ64zkwlnije41q49YxcTVktSx+2Faqe0+yQchKfVES2GTem9PQs1Wh4FT3051j1vL3m
         T8qdmpDK1KNTEAFV4Lt5eNvofOb1vsEitQFSyDWPH7+4VWeBg75TXiekScOz0xf/mND+
         Z/j4K4ZBzBw5ECSC5hwqrpz/z5nzwmR1lIZL0Ak8VlTMjq1vsBwE1M2TV36pGYDcas+k
         T9Vky6Vvo5qsWRnM+VHqHEOXPegsiHKOOnZFZ8JgXrc2EjA/mj83agU6GearttENwTvg
         CRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770390429; x=1770995229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tVq6rfsNPgHkVD9Uk0vE2z8beerbYIiR5ZWjlpv17tE=;
        b=L6uFQ4UtayiwnEmF25yt9sJB9i1mwt9/9bROKkhWwaXDrOjT3DtzDz7kHR8UpqPa/C
         +Plh0ePouzOYFKYOTIxjdJzA52pdCM8+aS7GqZBevHian1xN0HUJLb+WqwbdDBi6a2dH
         HoAfwX8PYzSBrs64PfHdBPBIuTfoNQ7qTmzXx8xiAbM2KQ8l/HHCHXGo+3I3OnLilKQB
         FvEE3Z2PZhPZ7bO+vge3OL+vTH+9saO8VGGyIe8HDUdjPVJeTE3jdyn10RuNalR8LHOS
         vFPk5whfJinwRwOMY1bM9fOYRBNP34QOVKBGupQC1+HAsI84dyeQ6p1AzkWb/quy+I/L
         J0tg==
X-Forwarded-Encrypted: i=1; AJvYcCVwezyEw//kOYBgHpQshOuFtuI+VlI0h8SgMexhudQqeDonpr/ufMRvt7XxNV917WkN+soZoA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwcdnpEMeILz2XGep3UegupYuzZm19z4QPFQ3WLT9YXGIrG4sPn
	1EWjphTVFJzIYTQ4WHpaDvFZjC/Iwzs+D5CBKw6/hpylP/yYBvhj5+rvkwnqJS2Fbi8=
X-Gm-Gg: AZuq6aK2HQnbn3WzK7PinjlAmO3tA5bO9cGh2PUrEDMk6ujWKMEs7bprWqyt08p+DFu
	GidRKNuKL5myfrLQ52eTaedHC9XmBmpSfP5cTMacLWz+9rr528DeD+wlBW0KQYzvJqNSYZc3EiG
	iDEE7DbX5PmuszleVKJoNwphLcUFFqnxPUm0q5E6kONG35LeGChhBSe2t05g/I/q1JEaL64OS+w
	JqNJC2/asWrHq7dtXkrCPqUFwkr46M/OG3uHshUrm4bYzn1IPkk/Fhsl0i7htMuoup50y7J/qwA
	77Uv+zgJH3DKIbB0j5Nz0/RA2k3iv8+VPSrC/l4Re12nZJ6B/KdMT+8ck7ExpHE+WWW6PkaY9T0
	h+FDvKp0+nfHBVZRgP0gC2MgSFYBNs74blgB+z+mYxld8bn9cxEGYY6kIeNu7sDqVmg9QDWfl9t
	3MQolDYYuROGX+tsH85qeKqbfwgwLsqkLMl6aSxx8puGNE4sVssCGhe7zfOl7drOPHV78=
X-Received: by 2002:a05:620a:2906:b0:8c7:1b3c:8e8 with SMTP id af79cd13be357-8caef9d452fmr344688285a.40.1770390429177;
        Fri, 06 Feb 2026 07:07:09 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf7aeed7dsm163905385a.18.2026.02.06.07.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 07:07:08 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1voNQJ-00000008ZWC-2gJs;
	Fri, 06 Feb 2026 11:07:07 -0400
Date: Fri, 6 Feb 2026 11:07:07 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
	Xingang Wang <wangxingang5@huawei.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Alex Williamson <alex@shazbot.org>,
	James Puthukattukaran <james.puthukattukaran@oracle.com>
Subject: Re: [PATCH v3 3/4] PCI: Disable ACS SV capability for the broken IDT
 switches
Message-ID: <20260206150707.GM943673@ziepe.ca>
References: <20260206145254.GK943673@ziepe.ca>
 <20260206150505.GA58808@bhelgaas>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206150505.GA58808@bhelgaas>

On Fri, Feb 06, 2026 at 09:05:05AM -0600, Bjorn Helgaas wrote:
> On Fri, Feb 06, 2026 at 10:52:54AM -0400, Jason Gunthorpe wrote:
> > On Fri, Feb 06, 2026 at 08:46:51AM -0600, Bjorn Helgaas wrote:
> > 
> > > IIUC the current situation is that for these IDT switches, ACS SV is
> > > enabled when downstream devices are passed through to guests, but
> > > after these patches, it will no longer be enabled.
> > 
> > ACS SV is enabled at boot time if an IOMMU driver is present
> > regardless if guests or virtualization is in use.
> > 
> > Linux doesn't change ACS flags dynamically.
> 
> Right, it's just that this series effectively un-advertises ACS SV for
> the IDE switches so it will never be enabled for them

Yes

> > iommu_groups will correctly describe the system limitations with the
> > ACS quirk path and so all of the above concerns are taken care
> > of. Robin is saying the Juno SMMU forces a large iommu_group covering
> > the switch anyhow today, so at least that platform is not affected.
> 
> I guess REQ_ACS_FLAGS is what iommu_groups looks for?  I looked for
> such a thing earlier but must have missed it.  Thanks!

Yes

Jason
