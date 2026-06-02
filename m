Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C109A356768
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 04:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780372913; cv=none; b=jLCu8ApU07UPfWzHZbmzzgiFJjgd/ycm+XGOw5+Az32ST3FHOwVx8gItu74aKKdwmiPSEm/lHNDfh3GY6d4JoXS/GN4euuAA/mpydOKvefRWMaqgW8c/rO8cWPt25psrT3nP13TltgNYeV1nuCoHl3fofGaGDeO5JDgDjUjDTU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780372913; c=relaxed/simple;
	bh=y1Z50JCC0kbirV2odlz6oDYRSM/Z8bPShu5Du2Sxb/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gs6k1otN4yRNxLm04iQCMyXLAXzHYlDZu183mnm7XYoZ/n6wF3tcHv46OQawOb8yE1AAwATQva/TbJq5M3wR5Bfy90meUSijzsOM6m8YnareRnqY0vzavmLa5SJDXTgge2ZiZaizBbywNOKDvAl78cCjPJsaclfXwBKXGE965/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qGse+ZGS; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qGse+ZGS"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c0b1a48855so805ad.0
        for <iommu@lists.linux.dev>; Mon, 01 Jun 2026 21:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780372911; x=1780977711; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8zzoO5ZfBSeXc58zl83ql5q86WDqT67vRVNbMImi2Ms=;
        b=qGse+ZGS15wXgvRDQ26PNX/bd3mtkoL8iuknXUBPJ/AvygXIa+2JtAUnoMfnz1EADb
         ayXtHPmvzC4x/I8fdNiUeGbBTXYn/Ft8pmvlLGwMvuw2ABAmgPWlaC5gB9RDqxW7w+lM
         oEIZ7AUFR4MoH9OLAtPKWJXFZhEFfoe8NER7JEQH9+Gam1aH/Gzubu7fwJ0cJ/VjILXp
         /AFL/hCQOcnc5RPp4rmPt2KR9fN09hth7ZuC0CHfYHZF4bJlGoCIOgpXoUsPGTsfVnFp
         cIoGCvfp/3SHhoXQvEf7plyws6sS5ZwpvUQm2JLI1UxQCgwsG8eMfg2Jj+D1/GnHzFv7
         R7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780372911; x=1780977711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8zzoO5ZfBSeXc58zl83ql5q86WDqT67vRVNbMImi2Ms=;
        b=OMm07RJzO/O6erSgIvJ+Bm4Lhm4OXhsBkR8ljhkwWbOCtgQkXRH7hyMZLnbHu2I8P+
         aYYbL3gx0JhchFqFeQZ8Hfxn5u0DCTtpvQj/gZxWe1k8HgZnmGm8pgVuGlU+bkrEVAaU
         Di/6ZKbOPSFpqcn0NeNRODgChoWCApWuG9gNh0CbPdG4XLLEraDWh3ANWoVqQy9mhVn+
         IaQeLsNGyxVuO2O6nlTYL2GTkQy2kESGlbzzLJb/MwBnMfQDI3YN7CbhvqBjjcS56LrB
         lv1DnYpqHVbwS3kfYir0X5rv+lIn1t0NrGyKW8vP+lNbCxYFfzMrC2s4UesiFcqFBzWi
         aCZQ==
X-Gm-Message-State: AOJu0Ywp4iFjTmiuhrHEb7pdK/XfUgT1jiUSXT54JOLid5zhGvv6uyay
	3cctWIfQjIwHnAblMAm+eNdBQBstK6A9gZ8Tei+LE4lCpQYZo5/vWaoQ9DnDmSGRhw==
X-Gm-Gg: Acq92OFLW30EjZeS64Ja6TA34BpZHMwGI+7zb/FDRBnSVDEZvtTpKsTps3wsx3H5tnF
	C/m9JHNYctwc50vZFBUFulO8qMjvkf5VUTVi2btdmLkGtmEYjI5xKJW4uRQaXkuKqH4TH6fCYN4
	9sEpLaH+1ADhSivaciWnxqrLChOgOu3UMim8UYNhIfaqtsis+OX1yS3AaVfe990kSWt4981bQIN
	u6tCXLX3wsX+yuxRRj2DH3howqYNQ1zlzZwFWbmSZeODPrtcwkD+colqTIByCAK2YuxKeBTMt5U
	d9ylzt6crvj2drKf5t86nF7g9x1SFRxN32bYER56rTgQfxpbw3R4/gsBkBMl1VbLWVbYD1t3rd2
	3m7tXd+eYZS1t5dwABZFmv0ZXsdHiqBEIIC2amvrvOW8nhNGZj2eslaJcOA+wx0CiGetZuH5X4x
	JkTgiTXcBhvHXJnbYCPY5RsVY7e8pGPiO2ncTdjth8bFT04LLGY23dFsjI8yPqCZeNh488iqU=
X-Received: by 2002:a17:903:2288:b0:2bd:3c1b:3073 with SMTP id d9443c01a7336-2c10eb2b907mr1518505ad.16.1780372910379;
        Mon, 01 Jun 2026 21:01:50 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23915adcsm115280955ad.0.2026.06.01.21.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 21:01:49 -0700 (PDT)
Date: Tue, 2 Jun 2026 04:01:43 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Ankit Soni <ankit.soni@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>, sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] iommu/amd: Clear DTE with update_dte256 in
 iommu_ignore_device()
Message-ID: <ah5Vp4fojpXVUkZn@google.com>
References: <20260601134204.2150602-1-praan@google.com>
 <20260601134204.2150602-3-praan@google.com>
 <20260601141956.GQ3195266@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601141956.GQ3195266@nvidia.com>

On Mon, Jun 01, 2026 at 11:19:56AM -0300, Jason Gunthorpe wrote:
> On Mon, Jun 01, 2026 at 01:42:00PM +0000, Pranjal Shrivastava wrote:
> > The iommu_ignore_device() function currently uses memset() to clear
> > the Device Table Entry (DTE), which risks torn writes because the
> > hardware reads DTEs as atomic 256-bit qwords. Fix this by using
> > update_dte256() to perform a hardware-safe atomic clear when a live
> > dev_data entry is available.
> > 
> > Fixes: 99fc4ac3d297 ("iommu/amd: Introduce per PCI segment alias_table")
> > Reported-by: sashiko-bot@kernel.org
> > Closes: https://lore.kernel.org/all/20260529153216.2AD1E1F00899@smtp.kernel.org/
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > ---
> >  drivers/iommu/amd/iommu.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> > index a94de66a885e..9b5861e241d7 100644
> > --- a/drivers/iommu/amd/iommu.c
> > +++ b/drivers/iommu/amd/iommu.c
> > @@ -750,7 +750,16 @@ static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
> >  	setup_aliases(iommu, dev);
> >  
> >  	pci_seg->rlookup_table[devid] = NULL;
> > -	memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
> > +
> > +	/* Clear DTE if we have a live entry */
> > +	if (dev_data) {
> > +		struct dev_table_entry new = {};
> > +
> > +		amd_iommu_make_clear_dte(dev_data, &new);
> > +		update_dte256(iommu, dev_data, &new);
> > +	} else {
> > +		memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
> > +	}
> 
> This seems a little weird, an ignored device shouldn't have a dev_data
> really, or it will soon be freed.
> 
> I think you are better to replace the memset with a dedicated function
> 
> /* Cannot not be used on a probe'd device with a live dev_data */
> disable_dte(..)
> {
> 	struct dev_table_entry new = {};
> 
> 	write_dte_lower128(ptr, new);
> 	write_dte_upper128(ptr, new);
> }
> 
> And then this new ordering breaks the clone_aliases flow, it was
> supposed to copy the 0 from the current DTE to the aliases..

Ack.. I'll fix it.

Thanks,
Praan
