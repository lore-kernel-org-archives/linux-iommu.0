Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E171EF38B;
	Wed,  2 Apr 2025 07:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743580335; cv=none; b=AFgEV+MLeRptgy+c/NZ+AtBae18n2C6ec1C8M5+FpcR+38h3d6mvTdggHql+QqllLUboQJ9bLEAQiAv9FTHjMpfCTHMASCTrSMP90VeUOhLhjmiIh5OhC0oHD+Ye3UNEJdeK0g3KexCAcJ5zfaKEj6BeSGHIgGtrWSmREIqWjJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743580335; c=relaxed/simple;
	bh=UAr1Z+AxXev6VsfCf/rRanRitQOy9kGFIc+s7ksn0s8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GC1zhePyPKU4xpofT3ksHslS1DP27yaI6uPrB/eFR4ga7rou14OwfEADnJbDhX1udepefH7ss5C+4FxAKR94eaEoExO8w72ki99uCM7jO1bNtaY6zzJXvXj6qe8aLB83imi/0NwPbYs2ZEepssrpw8npcORAtyKKmaCyRP3cAFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=l1GG/c//; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l1GG/c//"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QcJX0K8Yl0giGfzJVWrled6+/qbBHVkKw4ZT7UuEPXI=; b=l1GG/c//fbkOLLhclF5wAgkWMR
	g0IbNLiU5l7vGPt+ReYRfa/NxMcsGJbBG2pzzasy1YsVolQ8IuV+EJjalGSCV0SO5L+vZBuNnaGUY
	0mW1Otgz7OAcynUOlQngIJQC7gYlZPhD5IoOvyqYcWeqUCRDymHEreWq/yUQkO8JViuEv8OslMngw
	YEDz1Dv1EplrY0qElzaYBuq2Z90c318axGUpg4fm5OmiZx+Su/qXyFMyC8WA2TLgSoLBM6PsS/iDO
	XsL+uVTijCSQ/KorFnoMFFEsbIjqKlLYEiqyc8Bi4LC5rG7eOlof/UNSKuyQpaC8lGDMkgP3XKQXX
	XeNY7/lw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzstN-000000091wg-3A3Z;
	Wed, 02 Apr 2025 07:52:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3BEF030049D; Wed,  2 Apr 2025 09:52:09 +0200 (CEST)
Date: Wed, 2 Apr 2025 09:52:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] iommu: Convert unreachable() to BUG()
Message-ID: <20250402075209.GR5880@noisy.programming.kicks-ass.net>
References: <0c801ae017ec078cacd39f8f0898fc7780535f85.1743053325.git.jpoimboe@kernel.org>
 <20250327123718.GB31358@noisy.programming.kicks-ass.net>
 <6zzyjtvkqc4ipj7ngtkx3jithfwpwuxlix677urlehgdnljwbl@wfoa5futari6>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6zzyjtvkqc4ipj7ngtkx3jithfwpwuxlix677urlehgdnljwbl@wfoa5futari6>

On Tue, Apr 01, 2025 at 05:50:32PM -0700, Josh Poimboeuf wrote:
> On Thu, Mar 27, 2025 at 01:37:18PM +0100, Peter Zijlstra wrote:
> > On Wed, Mar 26, 2025 at 10:28:46PM -0700, Josh Poimboeuf wrote:
> > > Bare unreachable() should be avoided as it generates undefined behavior,
> > > e.g. falling through to the next function.  Use BUG() instead so the
> > > error is defined.
> > 
> > Right; I did a pass like this a while ago and thought I'd removed all
> > unreachable() abuse.
> 
> Any reason not to just "#define unreachable() BUG()" and convert UD2 and
> similar to use __builtin_unreachable()?

Just remove unreachable() entirely at that point. But you're going to
have to update all the various arch code that does use it correctly :/

There are a few sites besides BUG() that need it; eg, long jumps when
bootstrapping etc.

But basically nothing outside of arch code should ever need or want
unreachable.
