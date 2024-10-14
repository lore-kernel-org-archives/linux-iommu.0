Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF25231C97
	for <iommu@lists.linux.dev>; Mon, 14 Oct 2024 19:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728933880; cv=none; b=ruLsEv1vw0RRCalB8KqM+rly0lpVnvAfm6BEYIbP+rBosq7JD22/3hpnlYDblLeA5ZXC5k3208aThlwSdYyNMGQyBNINCkLb8aXqjwWbZ15e0Y/pHHc8jXSXL3rViEd2YaEdWdYS4YmdosJiEb06IbjHkOVsqIxFZrbCh8Q/UJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728933880; c=relaxed/simple;
	bh=Krf8aUu9wJoYrroG/l+uabcNMWjlfsDG1ymMzmhkTyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RK6u4E6Nkz2E0o+LQAaPtJqWjKqicUICLZRL4UCH0RdKVNgfdYM8SQbWYUJ8bISc9E8nmgIn5KjwGXDB4X5QEojOwqdbs6NG1CG7Mi+n2qv9aYqnpOiGKUDjIMc+7iQWRYwFqSl2xBkoa0KoIEwSo5c7mSlueJBerweQAHZWTtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=g+zyqTXf; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="g+zyqTXf"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e290582301fso5177497276.1
        for <iommu@lists.linux.dev>; Mon, 14 Oct 2024 12:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728933877; x=1729538677; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=chhtCPjzLYuNIHNBBWk7CoEmzEQjqCwVNlf9vMYQjEU=;
        b=g+zyqTXfuHYVpXiAl8U63NGhNcnMgyLrnzYdYPgamwPwbIMdbTpiAobc0g9b2J6R6x
         K0WlRlEkq7h+r0XoPaUQRYEJMCoEz177+cSXwVsZQvgJgz/gB7Y8DVXie7jdpqzBkhJN
         5W71wM2h7q2vWDdk2GK8rZORJFH9G0KjpOTnbYPXVAIaU740YcqvpFttGX7hSzYIN/bw
         Yo1cLwFrJdGqfXbVxwWzHxfKrUK4FOmM5ja7ifVMPAHeAd0Cqon80n5OEa6R430OIIQN
         yes9Y3AAwnqDuhm34wOGshtWYvYJnqlRVrbRPVZhVdX3DewnN2hz/LoDgiKkWRdKJTgR
         pyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728933877; x=1729538677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chhtCPjzLYuNIHNBBWk7CoEmzEQjqCwVNlf9vMYQjEU=;
        b=NSagBr+ZEanWaNfxB4PQ5SLKhyz0bw5YurbGuZyV97C9k26QpYUnWUDcS6uu1Xy2od
         YekELG58MbeZdbVuvEoIrROn1zyayIyPzqYY9qZMo8ar2lih1Z3EQJXh+YviI8hwEWHJ
         sZZuDKTZ2Jpx9yIlRX81OnQGlDozR4FcOwOshw4sm4fmnFlb19jsb0F4ayde45fRnQhX
         LOHLr8oKNBrK2BPbhYvouIFJKShv109U0q2NyJiviuKNZj8AcA8xrurP/5kyTWBNbLME
         Ww+l6aVD+Ey81xeHAiFUAubMQsCuExRB/J8LdORF2v9E4XnF5ZyqLw4DuWhJHGpcWE2t
         w12A==
X-Gm-Message-State: AOJu0YygK2/VeBjGL07+6nWJxQmiAumy2Zio9snMhXbYc+HM6O9fIX6T
	mfOK03i3Y0/ONEPT0LD2E33aupgJ9y3yaSqE8CNlwN+0gZyMnsUUZkR05nCl4D8=
X-Google-Smtp-Source: AGHT+IGiLMckZF/iDwtCPeOtlulkrsk3VgmFpLFFqeCWFo2lkhBdtTvvDGgrE7l+kfpS3rSDr/CbOw==
X-Received: by 2002:a05:6902:154c:b0:e29:2783:8707 with SMTP id 3f1490d57ef6-e29278387f9mr10259571276.48.1728933877447;
        Mon, 14 Oct 2024 12:24:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b11497ad55sm448982585a.112.2024.10.14.12.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 12:24:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t0QgG-008ikr-0S;
	Mon, 14 Oct 2024 16:24:36 -0300
Date: Mon, 14 Oct 2024 16:24:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] iommu/vt-d: Enhance compatibility check for paging
 domain attach
Message-ID: <20241014192436.GD1825128@ziepe.ca>
References: <20241011042722.73930-1-baolu.lu@linux.intel.com>
 <20241011042722.73930-4-baolu.lu@linux.intel.com>
 <20241011162703.GL762027@ziepe.ca>
 <7f829e9e-5db9-4861-8a58-27a57edbd9da@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f829e9e-5db9-4861-8a58-27a57edbd9da@linux.intel.com>

On Mon, Oct 14, 2024 at 09:25:03AM +0800, Baolu Lu wrote:
> > > +	if (domain->type & __IOMMU_DOMAIN_PAGING) {
> > 
> > It looks like this entire function is already never called for
> > anything but paging?
> > 
> > The only three callers are:
> > 
> > 	.default_domain_ops = &(const struct iommu_domain_ops) {
> > 		.attach_dev		= intel_iommu_attach_device,
> > 		.set_dev_pasid		= intel_iommu_set_dev_pasid,
> > 
> > and
> > 
> > static const struct iommu_domain_ops intel_nested_domain_ops = {
> > 	.attach_dev		= intel_nested_attach_dev,
> > 
> > And none of those cases can be anything except a paging domain by
> > definition.
> 
> A nested domain is not a paging domain. It represents a user-space page
> table that nested on a parent paging domain. Perhaps I overlooked
> anything?

It only calls it on the s2_parent which is always a paging domain?

	ret = prepare_domain_attach_device(&dmar_domain->s2_domain->domain, dev);

Jason
