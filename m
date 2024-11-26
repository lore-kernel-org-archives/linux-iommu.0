Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED5D6FBF
	for <iommu@lists.linux.dev>; Tue, 26 Nov 2024 11:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732619564; cv=none; b=pIi//5veRVx0H0sGyyIGF3Q9AYIX2q6yZettfwZbtCpefKFplN4DBa1EIAg/o30IJaFJUgED8AEuN1ck7C3e2IFntg0/eHyIjBSMgRa6WKgk5zNi/bdyiYCZi+67KeHH113CR7zmNHCwwLNDQlMEdR1an6+LEO1bL8tT0Wgl7Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732619564; c=relaxed/simple;
	bh=B4pORm+OWCSzYi85j/Bzns+i4fHQYTWjRL39fI4d92w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjbCwfHtbf+7cVNZewvQxsPzxfodzYYZQpgjq9vFtoVX2ND0TNNaRUSU7N3URY7PFLhQF4mVV5JmbYkGo8zLaEpfK4ttTihHH+hTEgudgf7Mpf4qVQn+q/7LhszdmcZPZZRjxwt94Xt0HPlSGBLpXk0KyxWcBC2ffdlzv4BR3hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=xuB+wAbw; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="xuB+wAbw"
Received: from 8bytes.org (p54921e31.dip0.t-ipconnect.de [84.146.30.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 7F1302C2A5E;
	Tue, 26 Nov 2024 12:12:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1732619556;
	bh=B4pORm+OWCSzYi85j/Bzns+i4fHQYTWjRL39fI4d92w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xuB+wAbwLULWXTgKpvdzFebhbCsP34q+59GYCPCerNwH8Nsvhpf4ivibvuhARvVq1
	 VrxAfB1Rp9OudoQE/E8XWCZ+X0uMuG8D6VIAh6U0L0u62JQGCl7n1BGWY+7rL3RMzj
	 Q18sY06axoAyvXdzi/r9vI5itJ8qX525RPy5tAU5wdURMo1x+jmB0CfkIry7r+4nBl
	 MNe+iD5DMbghaRtYC4GgpQymECBwTmSXl2bJ3Pke69TqJ0XGB4HGW0wUHA/0PIgOJZ
	 n9BcuV++U8eCk1ASwXNU+3VsB+s9S7F0wp1VLG7w8MGMEBH5zrB6hgiO5Jtn8FOhMH
	 n91bWF2b/cBDw==
Date: Tue, 26 Nov 2024 12:12:35 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>, pr-tracker-bot@kernel.org,
	iommu@lists.linux.dev, open list <linux-kernel@vger.kernel.org>,
	Will Deacon <will@kernel.org>
Subject: Re: [git pull] IOMMU Updates for Linux v6.13
Message-ID: <Z0WtI9-Xxr1eY7Av@8bytes.org>
References: <CAJwJo6bu3vfogmzxpfzFV_guf5GS_1TsqdB29NZoUr-_6fd8pg@mail.gmail.com>
 <CAHk-=wiG+jR7TJdCX_Xa7_dbQP8wU966e8eimUs48VVG9ac0sw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiG+jR7TJdCX_Xa7_dbQP8wU966e8eimUs48VVG9ac0sw@mail.gmail.com>

On Mon, Nov 25, 2024 at 06:45:00PM -0800, Linus Torvalds wrote:
> Those octopus merges may look cool, but you should never use an
> octopus merge for anything that has any conflicts, because they are
> hard to get right. Joerg clearly didn't get that one right.

Yeah, sorry, my bad. This time around there were unusually many
conflicts between the topic branches, which also forced me to create
two merge commits to put everything together. In this process I
overlooked that the iommu_present() definition slipped through.

Regards,

	Joerg
