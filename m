Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFCE393DFB
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654238; cv=none; b=SHjzQZnH17WhB5lhX4mD8HWmWvpL7EwT4wZ1wAckJQFCAxNT1MQcTMijuzKWjCr/Nwm0hKVfRPTRmKRMhrWkjT5GawxAAge8En/kmBHZKLUrIvLJSrZGaAx4F+IG9t+LL538zi9VtATHuwPOeHHyPDAJzXxmzQnpZqV3OkRJnbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654238; c=relaxed/simple;
	bh=6Zmbfl5t350g/ikDeKV9bfW8BGWB5eR0UjWTzntGkJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gO2kvvddvnmGI8SMnU4forLvAp+bVyfsBrRDsEjuDNeh1G/Laq0OlotdY4ypc5LZxyzoCvAKU7D7kWPf3iq+dgMhmkuRRADAOq9zqTOXnV5NHnzlcKRUCTn0DkYmydPxvWrwvbq1+sQE9ktTJczfiQucxtoDCvJcYpHirLodqh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QnM3swWl; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QnM3swWl"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d3b445a84fso71055ad.1
        for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 03:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787654236; x=1788259036; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W7fh18dW+kUBCYJPdPDVxmB9qh9dvTUt5azKdgYfYsE=;
        b=QnM3swWlv2P3O6xVHu80yU9lBr7pHbnbHMDx0XbAft7i3muh2Yk9xXF4xuV2tNenwY
         vDYTwLgGVjdV2qJ7pBKhnjnEfxy5/si31+lISNyTPjuKiXoFjI4AXRmVVNsBdsS1VADJ
         LjPirkQR3W4tHZcUrsIh74R6rssGRJAOorChC6eKd/JkIE1BOlm95a6z43AkO6abTcMS
         PalqX/VZuGsnBpUPheG+xa0ksQdLQSkORvt1Nl/ouk5M/aHYhebqEvZzX0Q/ku5TaW3W
         rquUS5U1O9xRpb3n2OGI+cnpgZ7W+qfG/nDKH6aG8GtP4RBwF2OkZdVUcy+ja7tLCJWy
         /JLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787654236; x=1788259036;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W7fh18dW+kUBCYJPdPDVxmB9qh9dvTUt5azKdgYfYsE=;
        b=ro3qLapjZVXpZuOzm9sQkFYopcBCRmSD0KDd5CxYT/msYKbKZjbJgc+En5mfmfhYWz
         880AuVQ9ajuuLNKVKTOKadt+asLIgqazeyBe0V8fs/QoltfdXW4n9c0QwWFpjBoJBaK5
         KgwrSRbHbXIXeXbkLzLKuoa0G7HBbozbSq2/LyrGbBVJAGN3ftvA9BRqvDZxUEaT3GEJ
         zTZYTQRVDi/AGnptvcqJ8DGAY8UA/o3BDUFwqkyMEp4UQkp6sH5x6NppGRWLFjEFmyA0
         COWk037OS6O24wV304KH5E3NR/GI93AntJtrqN+SQVH3V0+SI5RK1w+G/ZV+5MGyhYn3
         REpA==
X-Gm-Message-State: AFuF++lNbT0RQdyMtVUvI1+WoawKD9bUSuxiaG84T9dyutSpur3lmk1/
	TLICNQk5v1TFIa7Y0ZucvpBJeDIbuerU3Lc6+HOIyPBZZqJ4wFJzFs9M+QWLZTZDkQ==
X-Gm-Gg: AR+sD11p5+fXp2VozO22vZPXcAVcxqqRzFGuqvnR51/x7wAQGUZuIV4LV7wDPLQfj8T
	0OtLq0DIvHXDYyWnEpjDZZo2qV7FIXVyqG/RwGZivI2PWWy1yTqB2lgA4HmPJNzblfy0IOQCN6R
	GqfnEP7G8013lyRUjmr10zrTZWIOGT5xZDJADkngbsXjHNNB+ofMCpQz/JOb6uF6HljNBmOnkMh
	9eFg/jHZSk1sUEb2FdtkG8MAp7WLD40itghcXI1ML5BT3N4exAchPwIC43J7O1i3lJ5VCPe7Fgo
	fBxIJE2XaTrcAlgCzOL3MqcIG9YnNgf7z/w2rvEXlm1MvHHj+T3uvpr2S4R5cThn0joUM21zPip
	b0I6CEALjhmYb5lVAonaM2r0BelIkdXywuTlUuHapGKrcqvBqVj8zwcxDZeklNwy0z3iLro53cs
	A4pJjJp2/Y9I541lMUww9BDFl28HZM5zKXtfgjcL45kVYsIRBqXm7oSjyjlJOopR7c7R7+nJFQE
	KLK6wvtsN1KzN/NPCdbBQXRbClEOHqqvNhGzw==
X-Received: by 2002:a17:903:acf:b0:2cf:4353:f117 with SMTP id d9443c01a7336-2d6e036d4cbmr5203815ad.0.1787654235552;
        Tue, 25 Aug 2026 03:37:15 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d676895799sm26786905ad.38.2026.08.25.03.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:37:15 -0700 (PDT)
Date: Tue, 25 Aug 2026 10:37:09 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Ankit Soni <ankit.soni@amd.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v3 0/5] iommu/amd: Refactors for ATS robustness
Message-ID: <ao1wVQzyCW22iNlQ@google.com>
References: <20260824122347.1588592-1-praan@google.com>
 <8e53fdee-2c3a-47c6-9478-19fbabef18eb@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e53fdee-2c3a-47c6-9478-19fbabef18eb@amd.com>

On Tue, Aug 25, 2026 at 12:36:18PM +0530, Vasant Hegde wrote:
> Pranjal,
> 
> 
> On 8/24/2026 5:53 PM, Pranjal Shrivastava wrote:
> > This series forms the second half of the subsystem-wide ATS robustness
> > updates. The first part (focusing on the core subsystem, Intel, and ARM
> > SMMUv3) has already been merged upstream [1]. This half addresses the
> > AMD IOMMU driver and standardizes the PCI ATS API.
> > 
> > In v2, the series has been significantly restructured based on feedback
> > on v1. 
> 
> Overall this looks good to me. We did run our CI w/ v2 and no regression found.
> 

Ack. v3 Just addressed a few comments. I'll send out a v4 based on the
feedback on this one soon.

Thanks,
Praan
