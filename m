Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4135413C682;
	Thu, 27 Mar 2025 12:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743079051; cv=none; b=CQoHIcn/JqDaY8hMMgS+0KkBXeqL18CsdYG7jzzqZApmdaZN7Rog+mziUWCmd5a58qy7uLGNZLLFzNBexlnqlcMBAb8M7/P1YJM+GPwz1MGTHa7ew61IlsjIuxjG1JkERNo2F3pTBI/yuWn1GCC0kBAzPi2c7ufa2oHr5hRNBV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743079051; c=relaxed/simple;
	bh=ASawpOXLYiO9EGGxFKl+iyHKlwIDpJ7N6QNXSk35rrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otx9cIvvh0uTwTYaAzPFk0l8QjY7Ct7m9ZuP7k9Y5guKHzFP07Ye6dMwGv43xcUS1DIU5K74jJGLKbYsp0V+/8envrd2QRzsk+SQ2jsEyfD/4ofEcUPX3xSAA8hUzdGRK1Nj8VSBwK6lEy0FheXqhPBTheNyZAzbAiuZuo3A3jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PEMIeNYB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PEMIeNYB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3376d4KIquRr4S14YL9iDRozqmnXLoJGM2yh6hYYuT0=; b=PEMIeNYBexW38ZaS4VC/lv0MLd
	t+z8kTR3LFql/cB7yPDLrah2TRE0TG5BCGCNz6CxOYJzJynsGBoOHG8nixoumWsJmai643dsz8i2w
	RvH9qReXZ6Ux4QYYPh+XcFYJ5448j8LUGDm07EIv1nkbukkFBBudo815lTZmvCt3vXNz6TGmbPxPl
	taOlf5Pq/VfDbkdFIpX2g23gyiczzbDsPU+V33OZCPIvXG4aIthWXGL9s++tUcptvhHogmCc5zb2z
	rGrOhEyyOQ5d1xvCaipISYtM4nsA1/s3WV2eHgb2+1yaSqRmWqC2Id707ACcUCckkZeEom5txNmz7
	vRoqFCbQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txmU3-0000000BrJl-1gDH;
	Thu, 27 Mar 2025 12:37:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E68063004AF; Thu, 27 Mar 2025 13:37:18 +0100 (CET)
Date: Thu, 27 Mar 2025 13:37:18 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] iommu: Convert unreachable() to BUG()
Message-ID: <20250327123718.GB31358@noisy.programming.kicks-ass.net>
References: <0c801ae017ec078cacd39f8f0898fc7780535f85.1743053325.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c801ae017ec078cacd39f8f0898fc7780535f85.1743053325.git.jpoimboe@kernel.org>

On Wed, Mar 26, 2025 at 10:28:46PM -0700, Josh Poimboeuf wrote:
> Bare unreachable() should be avoided as it generates undefined behavior,
> e.g. falling through to the next function.  Use BUG() instead so the
> error is defined.

Right; I did a pass like this a while ago and thought I'd removed all
unreachable() abuse.

Compilers see this as a clue to just stop code-gen. Very bad behaviour
if you ever actually get there. BUG() at the very least stops the kernel
dead, instead of continuing to run random code that comes after.
