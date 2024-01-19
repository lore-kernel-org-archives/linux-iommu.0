Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AB84F20A
	for <iommu@lists.linux.dev>; Fri, 19 Jan 2024 19:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705691009; cv=none; b=RA0gZuB7v17O+3ZXxgJmsGjysyXmFzJyK3CkO9h4ts8n2VVwThDt779gWj4kK2VYwdh79YusK+PlcgU8utftu4iXhrfbLmPbPaynEfaJdw6btTc986IYuLm1316TeLXjWqckMbVdYVeCsLDkcay+iXbYrasv9nyMy49bZ6c7AXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705691009; c=relaxed/simple;
	bh=yx6yb8+BgiTjXZGq8VpgmXVYNbyhtvvnrlEEJMBkWcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNsSZ1Qk8KcL5iLUWoKijBiXa8FRQalvIEPaBjeavOc9kO3epSyxyJpbx+5Prg/dG9QGIB2wxIFUtffWTWokn0RMxY5X/rMSD74UT9GkygQU8bZ945gEiqdPsAKLlyuFP9mmsnn/JzbIc6qrmcJtZUeIHo1YRj7Tru2HWRQwgpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=il+plrro; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="il+plrro"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bda5be862eso463507b6e.0
        for <iommu@lists.linux.dev>; Fri, 19 Jan 2024 11:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1705691006; x=1706295806; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yOIrz7+hGKf9iZQ8booPkwnvXxLRHDIbJYofQvIh6TU=;
        b=il+plrroedksBoV17E4/2/lP5Z1ucsG311wdt7aeFD9rR04zlYLLjv2/IpRnrM6bCA
         uhEdcP7wUUnOoMgVKfbcHcVIBbbekQzOWv1nykU7J9T2XlAFYjHiP2d79K+jKz+H3TKc
         NmYkBwTj/gqXxS23Z77KjzhH/uyRePauafEWn4HDPKt9l2eUF40kGVo4Zx184I+2YClT
         YrFNbK5WPMeu/hfddW4dNtbFIZ5nDQqFBNS7tYeLYFRiMWE/zGsiVzaxQWj2vFrJJpDF
         Ut9pe4rgFrFYlikdh2I8vV7Xg4pKyJsI6AP7k9umOcBvwpmLaWXaR4ewLeyneFhGe9V0
         L/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705691006; x=1706295806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOIrz7+hGKf9iZQ8booPkwnvXxLRHDIbJYofQvIh6TU=;
        b=ZbvT9LN2RvT5pbLalXf8pBgvlHe03fBn8/DV/Ejw8wwskcTyzh+0hejguRE1NEy/J3
         RFytnC27WMmxitzS5rNnMv743MT1uwy72CukoAYlFd0YO8VKwofVAWMrJ1epqZFd7QwD
         fx80a9z9t3qPbHEK/CQ7RN41ybiqqLWwDxUrLp9ditO8eE1g+rHB7JbdkskZPKru4NJd
         qGbIHCq1AbZGNTYzu/tqZf/onkq94VPCbRAKmJm5LkSs1YK3bYAqZrtXR+9xVMB/T3XV
         hg8lvuRBPef6q819HN8L7lpv3kFWb8g3cGGp7FwX2xx/LczsRtFq7+eckdDQBz6+pnS8
         xlkQ==
X-Gm-Message-State: AOJu0YyNz/quK2S9ChXxEndTeirJE9nKI/I6lU0GoisSyKmn1FZCxI/t
	IuJaV8B4M0WwBSuuD5JTseNWq3TupbZlDrrRiVD5XuJiJVv4QIWtVNDnPsvENAN9ApuY3lKNbXz
	Q
X-Google-Smtp-Source: AGHT+IGSPiO2dxZMrHVYWNsx6lHblf0+2I61v9nbdzroLranl1BKZJ6sDG6yWiMqFDoS7i43W1EBAQ==
X-Received: by 2002:a05:6808:308f:b0:3bd:4ba6:a6ee with SMTP id bl15-20020a056808308f00b003bd4ba6a6eemr244064oib.69.1705691006642;
        Fri, 19 Jan 2024 11:03:26 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id j19-20020a544813000000b003bbc47b946csm704413oij.33.2024.01.19.11.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 11:03:26 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rQu9F-005lY7-81;
	Fri, 19 Jan 2024 15:03:25 -0400
Date: Fri, 19 Jan 2024 15:03:25 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v5 05/17] iommu/amd: Introduce per-device GCR3 table
Message-ID: <20240119190325.GL50608@ziepe.ca>
References: <20240116165335.6043-1-vasant.hegde@amd.com>
 <20240116165335.6043-6-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116165335.6043-6-vasant.hegde@amd.com>

On Tue, Jan 16, 2024 at 04:53:23PM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> AMD IOMMU GCR3 table is indexed by PASID. Each entry stores guest CR3
> register value, which is an address to the root of guest IO page table.
> The GCR3 table can be programmed per-device. However, Linux AMD IOMMU
> driver currently managing the table on a per-domain basis.
> 
> PASID is a device feature. When SVA is enabled it will bind PASID to
> device, not domain. Hence it makes sense to have per device GCR3 table.
> 
> Introduce struct iommu_dev_data.gcr3_tbl_info to keep track of GCR3 table
> configuration. This will eventually replaces gcr3 related variables in
> protection_domain structure.
> 
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
