Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B6513BACE
	for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724688913; cv=none; b=bikV7QSVXVP5ZeDUmuHevEBmxikM3/mIdteS4zRZSS8ncoH10oqlX/GzHVzO5VeIXk5TTA+nnVi4SEPytCecK2YAcG6JufYJqSWz/4A8Tyw5w19jOU5eJVIBday66bM0MOu5IFS6VJNaPs3sfS+/sV15Nj/vnkoEXyjmwS11E4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724688913; c=relaxed/simple;
	bh=PpyI/C464x6EhgM1qIUWeL7Sz+KNsLjuJE/7iztvuPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sQapONYX0ayc9VTiN57+LyWxJ+NLESg44BorcLaPMGkKFj4Wf6gvV9ErK4u2cVQLEXYrj7fXs/hE+ZwuU/Ps3ruAYmc+FlNk6qIPxmtsCzoUYc5GwkDlwSiCfEoSLnjR79MQXJhue3mQOf9lJNMCywu8KXQ1qMvsk+Lz+vaOPiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bpa2hNSe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bpa2hNSe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724688911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AnTt/v04kG2lCJ1eZ7LwMpc3AUHrXM5GXqq1e2Zccg4=;
	b=Bpa2hNSeO53f551uGBv5cb6GYA0cjERZwGDncIAKtaXkr95R733UO6tHa0mp3HUNa1v64A
	XHhyRw+qvqKgLxvKOSte3KM9tTJJB7WRWcwgFC6QcWemrpXY8KR9cY3NqADMK71tr8ewpU
	d4Epujk5mjV1c4HlpuPzu+OgRLTHSkk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-twJM6O3eMduE2YD29seG8A-1; Mon, 26 Aug 2024 12:15:09 -0400
X-MC-Unique: twJM6O3eMduE2YD29seG8A-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6c16da4e175so45288086d6.1
        for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 09:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724688909; x=1725293709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnTt/v04kG2lCJ1eZ7LwMpc3AUHrXM5GXqq1e2Zccg4=;
        b=jkQyFIP3dS7xDddJzI9uk6WWMti4WNzadwC0EmI0TSirI91RUQQBzm1DdF9nn+gTCs
         chwkNZmUW8ZLq3/IzB+mvSR83YvFfoC+Tqc+e6zJsY5IBITOE3c9bcdm6v2I1OCJbdEN
         5/CskE8iaBuazdCtzUYEKX2meQXgngePXHVveGIxj1FsJRbx0D+HBObfzZ/hBrMEVNlS
         ouJDmxFcpVzpJ9JO6u66ene9lzcTn9vGRjgHLxFNGCxasbO95618NdfvyByIH4Kfx4jB
         LPkXS2hT75B4ld5zdPP2sqV0bapklkXOrktysfpjcWFaXOa/imitDABBD/nGJvhj6FpM
         u3dQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb9tbcbbD2lRaux5hfjABjH9gdU+VSXkEaXGeKRQDziY1qh1zQdYa+F7Z1KzzM/Q2pz/DiUQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyyn3uG1tIQ/LNDSv1uJa082h0FdzzmVebkqUjsAkkKO1UO6Oax
	4aG1V4MK0SvlUyXLWVCW+0T8SAEtDEUUQMNuljHWfoFIgPPVm61d7LAO4VIfLL6xiG+XGhHBAZ/
	ddlVl499fqt6xb0X+4ecBvv4sPP8oaOp6Eklys1hfJxwxuyE9hcLQ
X-Received: by 2002:a05:6214:5544:b0:6bd:69a5:4fc4 with SMTP id 6a1803df08f44-6c16dc2a99cmr118357606d6.8.1724688909170;
        Mon, 26 Aug 2024 09:15:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHt/ipYTrvhVyJ0rdzo5CkEtbzz8pU+g9RFTfd5qHbSoX00nso7ovG4mPjxp57hJgjSH8DYXQ==
X-Received: by 2002:a05:6214:5544:b0:6bd:69a5:4fc4 with SMTP id 6a1803df08f44-6c16dc2a99cmr118357106d6.8.1724688908584;
        Mon, 26 Aug 2024 09:15:08 -0700 (PDT)
Received: from localhost (ip98-179-76-110.ph.ph.cox.net. [98.179.76.110])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162db067asm47686316d6.76.2024.08.26.09.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 09:15:08 -0700 (PDT)
Date: Mon, 26 Aug 2024 09:15:06 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix incorrect domain ID in context flush
 helper
Message-ID: <2h2gyzr3anhcpyiorkrjp3o4cdg7sg2rmrvgzmkxopabdsr3ph@jlhq77xjtcdf>
References: <20240815124857.70038-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240815124857.70038-1-baolu.lu@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 15, 2024 at 08:48:57PM GMT, Lu Baolu wrote:
> The helper intel_context_flush_present() is designed to flush all related
> caches when a context entry with the present bit set is modified. It
> currently retrieves the domain ID from the context entry and uses it to
> flush the IOTLB and context caches. This is incorrect when the context
> entry transitions from present to non-present, as the domain ID field is
> cleared before calling the helper.
> 
> Fix it by passing the domain ID programmed in the context entry before the
> change to intel_context_flush_present(). This ensures that the correct
> domain ID is used for cache invalidation.
> 
> Fixes: f90584f4beb8 ("iommu/vt-d: Add helper to flush caches for context change")
> Reported-by: Alex Williamson <alex.williamson@redhat.com>
> Closes: https://lore.kernel.org/linux-iommu/20240814162726.5efe1a6e.alex.williamson@redhat.com/
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Joerg,

Can this go into a fixes pr for 6.11?

Regards,
Jerry

