Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31ED91EF399
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756968; cv=none; b=djgN7dOssO49yjtVXqm704Xv5xZBP5R3tr90CN2BMlA9IIJHa0wjNhM1ujbZR7fcJvSvQqPllGyxbnFQqUNUbM8+fW4xpcmgoVu257lbL7DQ5K4yL3O610Z/H4sK41aDbDVuCBTORNbxqnag5OCnq+76zEXEtnNbiS9CNcMjut4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756968; c=relaxed/simple;
	bh=mq8LIxjSNPZQfQe8nHzbKlJqYlSqAK6mbdKyPNRn5e0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrV+S7nUbJoOI0Isg1GIOvOi43RHUdCrxvED/yaRKGbWWY5qER4FHUXltXyYVAaHlpUaTZUIX9whToyEh5HO1nV0jkTzAfR1tIHVqVDRNF8oHhC38JQ7KD9Us+nWXjLK9H8GfX4I0AjHtHNLpGxwWwRtwyfDqGuTwMJkQc6+MzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=tQQilXxN; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="tQQilXxN"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id CBD0A4408B;
	Fri, 28 Feb 2025 16:36:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1740756964;
	bh=mq8LIxjSNPZQfQe8nHzbKlJqYlSqAK6mbdKyPNRn5e0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tQQilXxNDvz4hRVoQMXQP9EEpdAm4fxF0VayGhvPVnLbTuzUbOBNZAur/n3zjIBRU
	 EUShpncu4bfyKu3P03AQendQ7h9OPKumbJqtWEltHt//d2ljExYoE9me/fm9B/zsNU
	 EjU6WgfxkMMbInDejvHClUxHNtv7C9S1R4gi5p7Qw7h1s4feZqY49XLyAek5Rz58DV
	 cjbIXpTruurPhrvkIP9JRPOsr4rA8QtJXbCpydUhrkdhi+O6xkc3P04LIOgfFtoGpL
	 aYsIMCaPCLlBLJg6pJqcA0a/el0xvl2N5QksWPvmuT94S5ZOoOGC5o0Ka24T7sMsMW
	 FuIrj+6JvOKtw==
Date: Fri, 28 Feb 2025 16:36:03 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>
Subject: Re: [GIT PULL] Please pull IOMMUFD shared branch
Message-ID: <Z8HX43k1VkoVfEXR@8bytes.org>
References: <20250228142933.GA105053@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228142933.GA105053@nvidia.com>

On Fri, Feb 28, 2025 at 10:29:33AM -0400, Jason Gunthorpe wrote:
> Hi Joerg,
> 
> As discussed here is the shared branch with the three series.

Pulled into core branch, thanks Jason.
