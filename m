Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888DB1C57B1
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 08:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728980311; cv=none; b=WEdTU//BvI/USBjYy96rHnIx48MqX++mYZwya2NPCXYqt0jI2VNthlKo/N6irmqXE2tkrAzhh88OKTfQDhzJTEdo0dzdS34dNwMk1vhoFiB2DSah1/7s8RZNsMb471J0xiUWJgx4zjdSWEzynRlR4tMfe+slzruNynV1m9VeFeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728980311; c=relaxed/simple;
	bh=nfHbvO1IcVF9bicFNj/hF4m7F4P30o3eCLyPRgiKEws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CruNMiwssNgH50f9N+5z+Uc3Qd6FRJctKhaZ9ugHiXdLrohKUHUJLUUqPg3pOjrjLS6t5/ANvohXq9CULpJHwcED6oPAV83BgmQaz4T5HgkCUk5Omtv+JZg0FWnVTEm+6rDRuM+NBXjGDW7W5brGNWAGXtRyRmXm4t1LEJmQ15s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=e7GHw8iU; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="e7GHw8iU"
Received: from 8bytes.org (p549219d2.dip0.t-ipconnect.de [84.146.25.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 7BA2C2A7853;
	Tue, 15 Oct 2024 10:18:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1728980307;
	bh=nfHbvO1IcVF9bicFNj/hF4m7F4P30o3eCLyPRgiKEws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e7GHw8iUL6gYOLbo/xQ+4PjV9tQlNRmNMz9311Zoj4kATtnB1Hf/r3uV+4J4DSXlL
	 K2f7/HTNp+2E/bhM2bjRFdiAJH0UKpkDZlkrEvP/aqovP5lOjMH0UOKEg5ioHxHgra
	 wVgwFSEZ/tlbFpTmMUq5tYIqZUr8cgg/OsvSLkxVpEtkuBbpo9QL6OaY12teBFPW6m
	 1Mi3Ki6fEhV5xr+9F4z1UQY0D3/fwDFF7x7/JS8H4OYRD8SPL7IcXvhwZAP1qzZWYV
	 drSQbQhl1GIiCxBh/oA8v0HD39RJ5KP7YnT/hHO313iqEawqBCkUxR+dyrM/Y1KqI0
	 z8fTWaj9R/DHg==
Date: Tue, 15 Oct 2024 10:18:26 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] [PULL REQUEST] iommu/vt-d: Fixes for v6.12-rc
Message-ID: <Zw4lUhuPmbYDPK59@8bytes.org>
References: <20241014013744.102197-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014013744.102197-1-baolu.lu@linux.intel.com>

On Mon, Oct 14, 2024 at 09:37:43AM +0800, Lu Baolu wrote:
> Lu Baolu (1):
>   iommu/vt-d: Fix incorrect pci_for_each_dma_alias() for non-PCI devices
> 
>  drivers/iommu/intel/iommu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thanks Baolu.
