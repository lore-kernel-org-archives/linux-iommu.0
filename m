Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323EB7F498
	for <iommu@lists.linux.dev>; Mon, 29 Apr 2024 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401987; cv=none; b=hb/o5ZOQfGRXbzvGSIYBCnrqoEQNyvdkX9gmGWVqswe+9ni4VCpbmz6YSKnGCW3Ki5zc3I0rRr4OBUeM4eqJU9j5c5NqVGEfEP6jR812FK3uXPLIjE2ar69GVNpI/2XoHbeTegLnC1A1aoOQdr+2AClpjxquefMSaEFY3PXEp6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401987; c=relaxed/simple;
	bh=7ffg10nGRai65DzA6Sm+DBPvuVwQZ6AScKW/4TvgHFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4FyxNy8jrHRGTJc22UIin7VD0HHPsYzgS9KNzZrYjVg7uA7UaaQae0+8clADP9QPNRpS+lUdnv8HCK/ud6R+/wLJB5oPYoEPkIof3boVLske0OeNWfRNPFDgb9tf8+dPgHXLeMi3wryi0lKfuyZoV2dGqn8zTYC1jrhLTsiIYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QJGVGEUp; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QJGVGEUp"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c70b652154so2810702b6e.2
        for <iommu@lists.linux.dev>; Mon, 29 Apr 2024 07:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1714401985; x=1715006785; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PL6tZzyAQb/T1bd4KCzi312ESM92EvfA0363dcOQhRE=;
        b=QJGVGEUpZq+V14HSP81V3zsGsZbpHjYtgrWcg8jEZnmalmd/WzKePiCR5gSAulqqLZ
         meT4paJQXa3+OYOOYN8TYXuQpacALQPGsS5Oe/0VVuwfiCoq4zoLCQ+XmH8ChldGmD70
         NK3IWQ0t0yvS8Q0THKHa0aY6Y9K1Fl6Inp8FT9Y7OyS31qKJkDBWEoYLEfj9TpkO2PMr
         rclCzt3p+OjjZooJlsC6zJjTkfgBPrN4OcUBE2u8DVtv1L4UfGi8SXdZWemlxJEvnJcp
         S7IUjLtBapSiU9cWXKxMZueFxagSLFhhVYUDpcfDonP8B7rrtse/quMk9StL7A9jzsar
         tO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714401985; x=1715006785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PL6tZzyAQb/T1bd4KCzi312ESM92EvfA0363dcOQhRE=;
        b=VWgxYRDp7s1aeGina97+lnEp7qfAYEcYFaHLmVrmQPXwYCtU5VdgtGXhN4dR3XJgWe
         W/H5aqXA7rED+ryT3VlTaPzo020bKD0rHlJA6ZXuJCLFTEZwmAOszs0JK7Min31YTR5E
         qfc0M52UNC8mfodsa/eTAI7SCLc28Mbsw901/JDmo7jb0lxH1R9eGbhZWIYrK5x9hlUc
         VxokmO/SkXEmfqG9Q8yZWgkhMOoyt3R9yEWzxIqpADnu+Z0V4ZimzPWwDFL/xWGkAHPQ
         VNfuMtqYDg3JEaRqg7hU/NmTcu3gk4EdgyGOPLnF8mhWcavSBDrjEUNfqjGa8bOtulA+
         421g==
X-Forwarded-Encrypted: i=1; AJvYcCUpzdY82uGgNAUxLX9lOc4FGE00ng1TU1zE2jiRi1h81YvsIaCGkf7V1tk9UAuLy1hkGo3OiU761HYDEIHjG5vzP8MdsQ8=
X-Gm-Message-State: AOJu0YzRwSWKFnsf6G4uspFwefxvfLCEz7NXD0uKV7efTBaQVn+g9oIN
	QrNZJ+LvwENHVSCiS7GoK2ajuUdHbIpT8LTkGZZe51z0LI+opmzHoxmpRDGsj/w=
X-Google-Smtp-Source: AGHT+IFOe6gG5Zd5JVe9dZoFq+NoColD5kYFlBUlxnFkxrkFHFXSMMmhpY3dNxMYFJzSXNRqXqK1iQ==
X-Received: by 2002:a54:408f:0:b0:3c7:45db:3ad2 with SMTP id i15-20020a54408f000000b003c745db3ad2mr31396oii.16.1714401985232;
        Mon, 29 Apr 2024 07:46:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id mi23-20020a056214559700b0069b4cc9780fsm3071361qvb.2.2024.04.29.07.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 07:46:24 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s1SGt-001ToN-OO;
	Mon, 29 Apr 2024 11:46:23 -0300
Date: Mon, 29 Apr 2024 11:46:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Matthew Wilcox <willy@infradead.org>
Cc: David Hildenbrand <david@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rientjes@google.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev
Subject: Re: [RFC v2 0/3] iommu/intel: Free empty page tables on unmaps
Message-ID: <20240429144623.GN231144@ziepe.ca>
References: <20240426034323.417219-1-pasha.tatashin@soleen.com>
 <2daf168e-e2b2-4b19-9b39-d58b358c8cd9@redhat.com>
 <CA+CK2bC4SWTCG2bnA16Xe+gX7=N=UYWB1wSns-K-jNqC1yrdvQ@mail.gmail.com>
 <9bf62e97-dfdd-4537-8fb0-b5f293856f59@redhat.com>
 <ZiwC4snk03ptUQij@casper.infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiwC4snk03ptUQij@casper.infradead.org>

On Fri, Apr 26, 2024 at 08:39:14PM +0100, Matthew Wilcox wrote:

> I think there's a lot of space in the struct page that can be used.
> These are iommu page tables, not cpu page tables, so things are a bit
> different for them.  But should they be converted to use ptdesc?  Maybe!

Definately! Someday we will need more stuff in here..

Jason
