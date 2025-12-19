Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB84C30DED3
	for <iommu@lists.linux.dev>; Fri, 19 Dec 2025 10:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766140170; cv=none; b=JRQE2zhcY4ZTC+VYfSmtw01RbrUTJEc5i+ZjmnhXMEgmEcC2hWlEoqx3cr81nWyhkcg4mfAjR++iNXIRhrdHAAxOklwPYRxLXJLtMm6I599hi1OSa5fxqY2YOdkefvnHOGy5GH/biXkdRr4V3h1sDaJWve3x/pgdKkEvPnskodk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766140170; c=relaxed/simple;
	bh=6jcM+4MoFNCv3dhpqkiXK2y5tffm/F0MVVuy9Yty3Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2BSFLkfFK4XG6DKP9/qGdxjwGb2czN7jMINd+Pf/xEDYQ3AOI5lckdOh1xx7jLF6StQAddCEpnZFGJ+EmgyVWpz8tTaGeIcMRfIqKe5L/ZOGOdlW0QlkxBTG3v3rY4PZG2dpfaStBMBAGT8Ktni1G75c3nXvvTWQxOaoQ1sNko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=8AopJUeh; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="8AopJUeh"
Received: from 8bytes.org (p4ffe00f4.dip0.t-ipconnect.de [79.254.0.244])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 4CC865DB86;
	Fri, 19 Dec 2025 11:29:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1766140162;
	bh=6jcM+4MoFNCv3dhpqkiXK2y5tffm/F0MVVuy9Yty3Ts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=8AopJUehjT+nzf1GqYdGT9g5QIi5HLsd4aOHcDRYRicVx4RAhrmdStMEJLKNqhXib
	 7lfx4tGsy4BsQR6E/NPu0LBXh518083SmT72VGr5fHJnNuUWfgeIfKcctM9Who764F
	 hytmegbIGJZVBgNjpDz/l851s8jyta9KncE8YBUIWXxmlZojNdtd4SlV4UbQPe3MVi
	 HTnWYT6nB2NRYOZ2aKnsWH2gs4RnRoWY2Q+/t9MT20f5VzRIZIu0uX2onAaPyjSkYx
	 SXKLOKpK60tWn4NV0xhsXCI+1cINZWv1YN8DqZr396mfJxDRAoLg8eXg8AfUaj9/D1
	 e5pPn0l9RAqag==
Date: Fri, 19 Dec 2025 11:29:21 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Sairaj Kodilkar <sarunkod@amd.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, suravee.suthikulpanit@amd.com, robin.murphy@arm.com, 
	ashish.kalra@amd.com, will@kernel.org, jgg@nvidia.com
Subject: Re: [PATCH v2 0/2] amd/iommu: Preserve domain ids inside the kdump
 kernel
Message-ID: <sy5peinn2qu3xh5wxeehhhwcb7wl5qro6fet4crm2hzrb46ya6@4ufksw2xt2az>
References: <20251121091116.25663-1-sarunkod@amd.com>
 <53378d7e-8456-4885-aa55-9d43003810c8@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53378d7e-8456-4885-aa55-9d43003810c8@amd.com>

On Tue, Dec 02, 2025 at 10:53:45AM +0530, Vasant Hegde wrote:
> Hi Joerg,
> 
> 
> On 11/21/2025 2:41 PM, Sairaj Kodilkar wrote:
> > Patch 1: Reserves the Domain IDs allocated by the host kernel while reusing its
> > 	 device table inside kdump kernel
> > Patch 2: Cleanup around pdom allocation
> 
> Can you please pick this series as it fixes regression (may be for rc)?
> 
> Jason's suggestion are valid. We will address them along with some cleanup in
> kdump path as separate series.

Now applied, thanks.
