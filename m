Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC82234BA3F;
	Wed,  8 Oct 2025 19:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759953428; cv=none; b=L7sqxbKW0cqpqVzPT5oPkIcDQpv+pBDw42MC8Jy1hRuZghjdLS6HaQ4H0L3xZ7PsnwCXK+Wn4luhZ0qoHSwmWheuKYfX2+menZHnX4Ay3/UpRiTfgrV8tC3tC6gszWmh6h1mszjLZt4XAzw5Pbz7pKpk406rkmxAfDdOl6OwvHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759953428; c=relaxed/simple;
	bh=c9vvlEG6NFFguYAWZ5zFAypbZeqJh79z9sc2CdR1ChQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSoGA0v+25HW33Mpr06abibXftsoWXS8OiTJlQ+lVIwz6lPVl+sZ0BVG/Fn/8lva1pqjEZ1vx/FXGr5jY5yTC+pQ1VeSI1OTd0JHouPWdZbFJoVQEwTwEcYCI18fABQWAF3vbBIYiIT3RtFrBkB+ww7kieOs2+OlcfV3dUa02YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p7Qh7IUt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p7Qh7IUt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GGaoS/61gkMrgKWFTNNh8sJ3cDZ7GISkiMTek91mBGo=; b=p7Qh7IUtTzlFf784v86b9RAkZ9
	w3NpwpZfygMr8JVNcnR/sJBi3jipjlhqK8abdzeRo7tlRUqTKm4FoR0OQLAGZYthiGIJ0WmKuBcFC
	KbgCT4u4YQD+3CYM4U0ZML/k40/ZBAZ2xM3rf1q1uRoq4QFFHtPeCKnpwsIZUr5kCjSSpa8cMe3AL
	zJJFHn3omQWuVeVrDdTcBgGeYY1+XCphcWGhNCm6v3w2zbNu1kbPZEVvTrzMpYjZ2VNUJyvy6ujQa
	mgejra8dSceGA8U6lAGrnXuJESBDEbkNtEgevAgVwTca3AB9HkPsMeJBPhrVMfTuDg7WwdmxFjliT
	QIwPf4xg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6aHL-0000000BzdY-2SAf;
	Wed, 08 Oct 2025 19:56:51 +0000
Date: Wed, 8 Oct 2025 20:56:51 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
	iommu@lists.linux.dev, security@kernel.org, x86@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v5 1/8] mm: Add a ptdesc flag to mark kernel page tables
Message-ID: <aObCAwbf1-Sxepni@casper.infradead.org>
References: <20250919054007.472493-1-baolu.lu@linux.intel.com>
 <20250919054007.472493-2-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919054007.472493-2-baolu.lu@linux.intel.com>

On Fri, Sep 19, 2025 at 01:39:59PM +0800, Lu Baolu wrote:
> +static inline void ptdesc_set_kernel(struct ptdesc *ptdesc)
> +{
> +	struct folio *folio = ptdesc_folio(ptdesc);
> +
> +	folio_set_referenced(folio);
> +}

So this was the right way to do this at the time.  However, if you look
at commit 522abd92279a this should now be ...

 enum pt_flags {
 	PT_reserved = PG_reserved,
+	PT_kernel = PG_referenced,
 	/* High bits are used for zone/node/section */
 };
[...]

+static inline void ptdesc_set_kernel(struct ptdesc *ptdesc)
+{
+	set_bit(PT_kernel, &pt->pt_flags.f);
+}

(etc)
