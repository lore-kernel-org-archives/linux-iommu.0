Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F443346A8
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 07:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778484755; cv=none; b=lDlkblu0awLSpFNXtmlh51WRqQLNa8WvFtq9qEWz5P/vEMtvrAzuynzKihBUAj2m8r5urfOwDgaNyVbpfaJHt+yU+3XPf2+iroWGIJ2LuEY6kWqfskMzYkas4thjLLgDEbZcT9sZvktx2puk3SJdPcgFjn7O/h95W8ttW0D+NLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778484755; c=relaxed/simple;
	bh=rhUVtRtxxw1hiniG+r+t/wW92iN9nycYbha8iiIYpWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8gNkjIa5IQLd8+PiukaCFsa8SqP/zroG6zFqxTSEJdGDyLBHet9upu7LNvEStB33qBwup1vtI+qQnNy5shhCk1nq7oaUWR8NxLFPaF9TooXICdqaJaCPyUPjipGZqQ1pfz20eJVosf93ed2Mg01qyTcrcrhdck9nX3u5unvQQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=oI6zY0LW; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="oI6zY0LW"
Received: from 8bytes.org (p200300f6af1d9600f5faa5cebd6c042e.dip0.t-ipconnect.de [IPv6:2003:f6:af1d:9600:f5fa:a5ce:bd6c:42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 6AF661C41F2;
	Mon, 11 May 2026 09:32:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1778484752;
	bh=rhUVtRtxxw1hiniG+r+t/wW92iN9nycYbha8iiIYpWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oI6zY0LWP0BoAn9eJ6ZUpKG4vEIv6r80ifjksN2hQxVDZltK5RN6TkekGSguZK4O8
	 gJmTaQDENLoMvu+BXtPJ8lmX7BwgnTewrPwS/lRGyT1YXWXG8DMO8/g6MSW/lR0QsE
	 SljJt2UFFww0Vr+Hrldzr6LSlocMiWJoc742bFH1bCV6aon+K7PiQqwTSASzgVZNJ4
	 8n6xlhvWhCPrsNKltg2ujQyn8eRkF6FRyDVDX/Qqeu/Q+982Akng+hM0TlFFoNY3N2
	 hnP/+a6mUdZGEBPH04Qg/0HpKYeVpZHbO4I4hr8zlsnJY8ktDhG19rQ1UlLeyiydd3
	 LA3Su/JtJfdwg==
Date: Mon, 11 May 2026 09:32:31 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Sean Christopherson <seanjc@google.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Fix a stale comment about which legacy mode
 is user visible
Message-ID: <zeimh34b5oajm7bngn6fxpqb5p4cq3qguybtw27byjgrgwkgj3@x5btxhie2rb5>
References: <20250315032148.2377902-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315032148.2377902-1-seanjc@google.com>

On Fri, Mar 14, 2025 at 08:21:48PM -0700, Sean Christopherson wrote:
> Update a stale comment about which of the legacy modes is visible to the
> user, i.e. can be forced via amd_iommu_intr=legacy.
> 
> Fixes: b74aa02d7a30 ("iommu/amd: Fix legacy interrupt remapping for x2APIC-enabled system")
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Applied, thanks.
