Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1FE3C063B
	for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 14:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775830616; cv=none; b=UtlmkJE6XgRduHtA2jLGj+ZqshCJA0GKyNkG4ZTEd7KfJadOxogK+8haBDv211QJiDJMviVzzG9hZmrE/nk4zLKELXVLx3mDOUQRICul4NHGDXH16YCmGM4eg9ZoTcibrHwJg6JJjxDj+/g2myyaiwccl2MjOZ3wk1EyPP88f9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775830616; c=relaxed/simple;
	bh=kJqjSwGVHtHlddEwLDzR5ggbE1iOYckpmNJiUUn/UZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqvZexmYPzyImna34cMxfPFjZ0/oqqM4D7MZvB59u3cuIPe+BzN2F+eeVQd10SVHEq0Kz0m00UAuMJHwZgnju4PqLfBLKRuHiXP5z4stkxny22J/GC8I57N9AaRuJl+8To4aUO34kEp+/5USiLUV2W6Ay7BigKFdWf9Sx9oDRg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=b9/ao+h1; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="b9/ao+h1"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8d7e7f48499so210596285a.1
        for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 07:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775830614; x=1776435414; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IUmeZoWdB0ROYhfKB6+Zrugoi68cG/8aJYwj9uhE8lc=;
        b=b9/ao+h1gbTRG6xca2uDKLI5jTfZMLbZXKmJOAAq4SlvfbCBOVn26O8gSto6xUljzT
         uWZ5odw4WrYjIKq7+rq1/dWjbKexrUZUV9hqx9VkIhh/fHaJNsO/y/BfeP6Y31aXDTtn
         RSZd9KSsO2XqLoH1JgdIwVy/e1pt5rCCwn7wyDbqRXpe/zJCqijAHro4xHg9UAGEYIbH
         dIDl7SlfNisD4Olxcy+EBaTY9kS7qXzO2uVQkLAvEdxKr/FrItc38gInFypNC+/PITmD
         ghXQqWC5+9Ow7Seh4y93pF/XxgHHh2XGwv7OwqfV2qIlPPjEq0oa+Z8fy3sLJIDRNNrh
         wq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775830614; x=1776435414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IUmeZoWdB0ROYhfKB6+Zrugoi68cG/8aJYwj9uhE8lc=;
        b=KlMOB5nr0B3t2tw/5a6zBxsun+rbmp34iCi9UsCGNIFUSBL/JkLHSlDyISsVYRkGRS
         uBxpTkvxTyyiTz9joabmKNSIpV9w/bUyKpJ7NBh29/OZ2vFC6KlNQSzny8sJvc48lFbJ
         oAQ54AP/x1yjpj1nNQVI3WI679BlUdCMTgD+wUjK2H5oawPZwjhIBB6C+A90I81UTufg
         pyQ1Qk/YiBDQR1ADt5djjMHbPbCMQy5BycWHXUnulQS8VZ02/KyCH01irniMeU6jeg37
         hozOBqJ+mwHVYBmYZJVv4mcS3GU71yFRD4KfxKD08bdqv23t7oKJWhFhilyZf8N7+Mvt
         yvgQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/sqRGP1NEpYBKsKyXsM/weyAIlNaDvOwpOLNe24Uz9+Uo9oqY44Ga2ILGGrdV0plLoqRUjg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxlFXh9qB4dy2/ULOu/1tDreWALfhE3v4Dfh/nIvg8f2upitLKu
	D/gLRW2D5/sSSOoJHsp68G0tLDn8S6b6FlP4ymt/sAkllCJcwrB70PbhB5qerUPIn3o=
X-Gm-Gg: AeBDietVMXg4zw9uNdw51JQYE7trhzGOijo0fyS+fRlMjfKAO+M6kGFvaMdrAkOtBtA
	n9oUNzH/IM+BSLskD+7edkJEBTLdqP2pl3xMkxCvlFUL0lNIeiKhouTx55dDdH7LBN1X/skNx7b
	e7LszsvE0xKk6aPtGac1IYlS41XZ0GT3A+pzpoPzpDV3n5WIbhVhQNvY4g5w4zj11KcojkUnOaw
	aTU8ImmYJJChp24wD4lU65km+xIqNwQcGdNFC4marzMSqVPIWbEmOyzbmarHVHoQtJUR+tpSNbg
	8Vu2FNQgnL1CY/B03C0MMsfYpsbLDdTi/75vXrlnK5hX1HUu1+iLpEwdwy9V0oWv+Ocin55XGDt
	ytTz8OyGftVFy4G9NKsfEBvVChEhuITJimVGIImeKgKVNAaD0Qv+s57PFzRkp9eF9zTIr2VK36j
	Uly5pOptY2YtQdiV/xTAuiMlPv9qf9XO+wxw2o3clbdgrv7KMGLxWX+p7+Bv3dU3NZfburnPHV3
	eB+Bm0E
X-Received: by 2002:a05:620a:d85:b0:8cf:e152:592d with SMTP id af79cd13be357-8ddcdae4eb7mr475410785a.21.1775830614053;
        Fri, 10 Apr 2026 07:16:54 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb9351afasm211855285a.36.2026.04.10.07.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 07:16:53 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wBCfE-0000000EL76-3L3i;
	Fri, 10 Apr 2026 11:16:52 -0300
Date: Fri, 10 Apr 2026 11:16:52 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: Samiullah Khawaja <skhawaja@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 05/14] iommupt: Implement preserve/unpreserve/restore
 callbacks
Message-ID: <20260410141652.GV2551565@ziepe.ca>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-6-skhawaja@google.com>
 <ab3CtC0vN6J975V5@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab3CtC0vN6J975V5@google.com>

On Fri, Mar 20, 2026 at 09:57:08PM +0000, Pranjal Shrivastava wrote:
> > +static int __restore_tables(struct pt_range *range, void *arg,
> > +			    unsigned int level, struct pt_table_p *table)
> > +{
> > +	struct pt_state pts = pt_init(range, level, table);
> > +	int ret;
> > +
> > +	for_each_pt_level_entry(&pts) {
> > +		if (pts.type == PT_ENTRY_TABLE) {
> > +			iommu_restore_page(virt_to_phys(pts.table_lower));
> > +			ret = pt_descend(&pts, arg, __restore_tables);
> > +			if (ret)
> > +				return ret;
> 
> If pt_descend() returns an error, we immediately return ret. However, we
> have already successfully called iommu_restore_page() on pts.table_lower
> and potentially many other tables earlier in the loop or higher up in
> the tree..

It doesn't return an error, it just propogates errors from the
callbacks which this one never errors. So this is just dead code.

> > +int DOMAIN_NS(restore)(struct iommu_domain *domain, struct iommu_domain_ser *ser)
> > +{
> > +	struct pt_iommu *iommu_table =
> > +		container_of(domain, struct pt_iommu, domain);
> > +	struct pt_common *common = common_from_iommu(iommu_table);
> > +	struct pt_range range = pt_all_range(common);
> > +
> > +	iommu_restore_page(ser->top_table);
> > +
> > +	/* Free new table */
> > +	iommu_free_pages(range.top_table);
> > +
> > +	/* Set the restored top table */
> > +	pt_top_set(common, phys_to_virt(ser->top_table), ser->top_level);
> > +
> > +	/* Restore all pages*/
> > +	range = pt_all_range(common);
> > +	return pt_walk_range(&range, __restore_tables, NULL);

This should probably be doing something with the FEAT flags and
ias/oas too or do you imagine the calling driver has to deal with
that?

Jason
