Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D7E3EF0A1
	for <iommu@lists.linux.dev>; Fri,  6 Feb 2026 14:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770388216; cv=none; b=fvW2HXlfcvlddJKoKXpxZQeGs/SSr7kgyUJO5KmpLeO91N8hkXnDShJkkC9u6IXPfKUUXHOWG6KeO3/POByYl/C6obyF/JVR66X+EH2dgm3TbTTZgz+km8DZFm63jRDatWRDPq5EFu7pxvgVHXF5pfGjKdpARxonbGkCjSPmiZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770388216; c=relaxed/simple;
	bh=VJUJxiaiSyjn06mFjR9T+fjRixI6F335byZ5Sx4J6MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pW5qoPBjl99YMNQGQACdXa5MTd1SwVakAI25fWNX+B1DfSc1JaCoyDy6Cpx2hiEuusQ+PbqV36o7aiZeIDa2PHxR5Ueg4IJB+C3+1pgqs5f+S0uzWziLz+hz5glBIh3QYC5+8uaNorYWaKjr4WNwGh2Q/4nV3uB6hDsjcK2bCew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fc6MPKxP; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fc6MPKxP"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8c70ab3b5fcso100649285a.2
        for <iommu@lists.linux.dev>; Fri, 06 Feb 2026 06:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770388215; x=1770993015; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=THMhyPMr7sNTge9zhp9X3LUNdQ3UJ8Jh3cljXKT38Os=;
        b=fc6MPKxP/wWEE4d6y3e6prxntIbGSORt6NanIcABiQcY9/HIGW9PkBXeicU9qD6tSy
         z3Bdzuukd6hHQ0kJ5ovil6KvGcUBZauTYPnb4RmAwYWKo+uj4zJSVYVwNNQUEGS6eSYm
         YNhc/p5Mg+FYL8hffenazdtxFi+AMbryDbMregEqOZ5JeVKr/StU29lGrra7Mqj+4aQy
         nQvdXDEKrigaIQejwhjmDZgoxgCcuENtMAU9r57lQJWIoRqJViAR//VPiRPPhR16/DVA
         dlv0LnjCnQHQVd1yhZyFPZQGyU5WqNQnIyxDKqCYJEUMXWDDDUxwDDBGqWP9pZPxujEK
         R4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770388215; x=1770993015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THMhyPMr7sNTge9zhp9X3LUNdQ3UJ8Jh3cljXKT38Os=;
        b=D+nv28aSqB52mc6wINdURMwG46j07soi/GyXRYiP6bGdWwSqUMZ13NZjFDBrNFkINh
         zESTTaUvTVodHqTkRSbcM5Jj1kb1yKszVUsmsqddesGG5SHGU7SJnVLsFzUhx9+2PrZa
         YM798yJP9YTPZyRdfFpN+Ktf1FtL1stEtx+wdjmeC0guCDGbgtlUcAN7fTq2FQjfvZ8C
         OZ3seetBi67JR7UBrOUQmeTeyjkfycwAtZsknCzKOvfwiww1fBHoLoPveMN7woiomWVS
         thsYNLwIHCyCQnouoJcvCcdJwdkL20UnTkrsDiZsWpoIMUMtAkpP4if/UTAb3imGG+BE
         Zssg==
X-Forwarded-Encrypted: i=1; AJvYcCVHi9WDXyS+1eDli62Yk2Va9aO9CymfFHBVg+07A79RrN6uFob1RaXoOeEGpxpoWFIHgr04oQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx1UfV7oWDHKTklS5MS9Sp/wsfHKHrezcwi1TT7RRjsp7onhrIK
	C/AL2epG5C9sP+FBf51nCSHqJGVF+m3mnWoWJSuIAAR9KotouXxZl7+ceFfrmF1unV8=
X-Gm-Gg: AZuq6aILKIKFs8AAaNQbK37Eh1CT4eM07QXPbqEOUh3j6X7cf7MlHChoIuiPugKAomX
	uZGyDXFVaVTpuX/a/S+usgNxm+brqPsgGmie93LTFRDueoS6/F/Lp2EtD3GS9erBB/2esQMVkIF
	AnEtPoGm0vHjQVSkpEJP4PNQqkPVWxEMQ9KZvrTfTYd7vc0dv5fncHCECkH0L3/XkPbORcK8R2c
	ajl4kqoJjtmqop6v7jrWqGN1ybvhowY/CndGq5eB6+gX2e5egUnkKPi94CtgRXyv8+Zu2PeF4jk
	/IErTuPODZBskxNBX1cVIiNNkK8PlF/d5YKkV2f+wnq2zAP98NxsycZGbYRBGEkXUIyd7c/mTtx
	5MRPzXOxssxpCwXWzFUR+C1iyZpNgme0WEG8dytx4EJaBUoJiIsgFJS3J8t556UThUx1NFGUO8N
	6OgHfUgpdBywYHeij5rlrclPDEqmJQ8KFEfZzyUiGsputde6KRrEiNIh4tquy8PhDKPM8=
X-Received: by 2002:a05:620a:448c:b0:8c9:737e:3840 with SMTP id af79cd13be357-8caf130a55emr392847185a.67.1770388215425;
        Fri, 06 Feb 2026 06:30:15 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf77f6badsm160617385a.11.2026.02.06.06.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 06:30:14 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1voMqc-00000008O8R-0VMF;
	Fri, 06 Feb 2026 10:30:14 -0400
Date: Fri, 6 Feb 2026 10:30:14 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
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
Message-ID: <20260206143014.GH943673@ziepe.ca>
References: <20260102-pci_acs-v3-3-72280b94d288@oss.qualcomm.com>
 <20260205233920.GA17083@bhelgaas>
 <ga5ro3nvrbmbjubtk6xnozzc6exqq5vnkmp2pfuhtnzmpsuogz@lcycdoxtu2k4>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ga5ro3nvrbmbjubtk6xnozzc6exqq5vnkmp2pfuhtnzmpsuogz@lcycdoxtu2k4>

On Fri, Feb 06, 2026 at 02:41:36PM +0530, Manivannan Sadhasivam wrote:
> > It'd be worth expanding on this and what the effect of avoiding ACS SV
> > is.  Does this change which devices can be safely passed through to
> > virtual guests?  Does it give up isolation that users expect?
> > 
> 
> IMO, ACS SV is somewhat broken on this switch. But we can still passthrough the
> downstream devices to the guests. There won't be ACS SV apparently, but that's
> what users will get with broken hw.

I agree with this, the HW is very broken, let's have it at least work
properly in Linux on bare metal out of the box.

If someone really insists they need virtualization with narrow groups
on this HW then they need to come with a more complete fix. Using VFIO
is going to open up the reset flows that are problematic with the
current solution, so it isn't like that is already working fully.

Somehow I suspect nobody would use this switch for virtualization :)

Jason
