Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C033BA253
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 13:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034049; cv=none; b=GyN2CHNQX4TLXkTZ+geWqlt3AFpMSe7wjYWnzZIJAqEPtyu+nnKxcOeWhr3KfpbXl9CXu6cvGyJ+F435VSsRhQM46Ozy3hhPP0iDCVBwOx75kJf/zU0nwIPX18bwhTEDjW4PCh3NFb33i02hdVm+RB30YUJYY97E+cC+W2AzIBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034049; c=relaxed/simple;
	bh=6JVdvVNVt572PUZ7EuMOb+NxVezh363Z8fGIp8Tm+bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkMxUh5IsxzJxUO25ZbKYmSOgmB9ovaACmPWbKZmyqISE6BMGGPzb9vqvz43hdqSFBSy/KXWTiUK2c1cYQonWOaN2Nh4yWlas1gcYQkH2kUVKadB8w48F8g1X5JbuBjiW4wTNdQrkmjI+b+hdk1YQuArIBWn21+NVcthfDeIf9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UBry9/Im; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UBry9/Im"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c10ed63c0so274431cf.1
        for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 06:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784034047; x=1784638847; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uIGZ/z4hY5ZNRt8p1qIWG745rMH9lv/GU7QvdqB/JiE=;
        b=UBry9/Im2exajT94zL34zx/1sMwlf+AGVJ7CiFBUeVlrG5i4QC7P2Qp++8ufb2WfSE
         oW4+hzz2oL8WqHO5gClhMBlElX7c6qK3QbqZ1UkskjaKVHhpB4hr4LZIT/uyDkiCVQLz
         LScX+Mq3Za5w6z/uN/gJP1EgLfHKLIlbqFYN7/piwBpQqeUfCC3XI98I+zCmzP3yZx7V
         yLyKjh5CWXN5CsRncpYbDafHGueGoFK7XLz4waYYQkqNOUp9VCFO2HhGawB8nJXbF0PG
         pZUIdjsiCyaxhkvJ/so5dr4eWLElQy8mkqncRdzjdckYArIdNKozZRCyEIcGsPInGUuE
         3lJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784034047; x=1784638847;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uIGZ/z4hY5ZNRt8p1qIWG745rMH9lv/GU7QvdqB/JiE=;
        b=kAD1bv6uqG9EAu88t/3aMuA7Qodnu05ki5PXZuWExtKpa5ydXl18/M7EL9+yvVoUmB
         ODUFBqmiY6qm9++THpGt2N74f1DYuIhUqjPCjDGp/MGdvdsxNXvKmvl9I4WrhIifITLR
         YwBSynsjjRSeyn533Qf4CRuLixRlDRT6ey8KqEqDMRagKeMV7doNoX9P/XcffAw+83ME
         94Cy/87+G9Ungul5BBjiEb+dnNHAwWNauVKLo9ND9eOb84G5xxmfIMQL4xqS/eKdWOou
         z9njW4O5vL/pv+Q4OVMnqYQe2tH8K2hltm4nkYk4nV5Z+JCNhrNGunVn+mjgFRZjODBt
         p4VA==
X-Forwarded-Encrypted: i=1; AHgh+Rob7L087wrqn3wAfbBYqlV71buNqJJXNpw9XlXm9c8Vu2hd2O+2qtup2rgiTVaxVk8qW3dVRg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6kJItrELzcuyGxJD5pDIkYpbNFgsiorxhan2x2jLh7XG3lP58
	9l8SldwA9sfYqVJI9axr8iVEfTe1JdEiqKbueinS3XFqvQfDJ65HVxb24KtwTZD7vw==
X-Gm-Gg: AfdE7ckCdtZXNoOkqhlUGw5FFVaqja3d9sbeba5jOXwicaIAktc8HGARPjilWCIge3V
	Bayp5wi0ht21DCTTJ1XgfdBkbQB9fNGwuGfDal/lEX/SDpeN8T1ubwbk3XmMfu0rS6B320nE2de
	3XNZdTk5wbg7RgBcO/P+RCkCJcfHP0VEgm/MmCgl7gVDHaOAv3RVqN1wdrx8gZCZfdQbwQ4Z/6W
	Fqv59zbkTGIZzU5t2NYgR9CXnJ+iCuD4759I5UBIt5FZkCyMcjjUchPEawdgRVgSKBp34IpuMOd
	QBLDPlDVzsCIyOnoF7KKY79W68WDSmsHOribZ0NY+bDn/Xt9rqEDL5bhMx1L05cmWkI9AjlWJuj
	J64e8XPHDuvpzq6UnfMkxstbuhGtlFZt/sdB20pcc8Mk8LTjnhIJif90pvzrtgWXp51ondtFqsi
	/+EBuPKGQl5nX81p3drah157ETLz+vQXipuFg92oSGUWOMduc=
X-Received: by 2002:ac8:5d56:0:b0:517:5c70:46bd with SMTP id d75a77b69052e-51d7bc73cecmr14531951cf.11.1784034043910;
        Tue, 14 Jul 2026 06:00:43 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bface91766sm6434972e0c.10.2026.07.14.06.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 06:00:43 -0700 (PDT)
Date: Tue, 14 Jul 2026 13:00:36 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
	David Woodhouse <dwmw2@infradead.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] iommu/arm-smmu-v3-iommufd: Reject unsupported
 bits in invalidation commands
Message-ID: <alYy9GMeIPMWeD-9@google.com>
References: <cover.1783539724.git.nicolinc@nvidia.com>
 <194fec44b30b7b4233d218686cd76d63208932ff.1783539724.git.nicolinc@nvidia.com>
 <alYC3bNbXY9l0eVn@google.com>
 <20260714121451.GJ674038@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714121451.GJ674038@nvidia.com>

On Tue, Jul 14, 2026 at 09:14:51AM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 14, 2026 at 09:35:25AM +0000, Pranjal Shrivastava wrote:
> > > +	u8 ttl = FIELD_GET(CMDQ_TLBI_1_TTL, cmd->cmd.data[1]);
> > > +	u8 tg = FIELD_GET(CMDQ_TLBI_1_TG, cmd->cmd.data[1]);
> > > +
> > > +	/* NUM, SCALE and TTL are RES0 when TG == 0 */
> > > +	if (!tg)
> > > +		return (range || ttl) ? -EIO : 0;
> > > +	/* TTL == 0b01 with a 16KB TG requires SMMU_IDR5.DS */
> > > +	if (tg == 2 && ttl == 1 && !(smmu->features & ARM_SMMU_FEAT_DS))
> > 
> > I agree we must check this but I'm a little confused, How is a user /
> > VMM depending on the IDR5.DS bit today? The IDR5 is exposed to the user
> > via hw_info AND in the uAPI documentation block we explicitly mention 
> > for struct iommu_hw_info_arm_smmuv3 the following valid fields for IDR5:
> >
> > idr[5]: VAX, GRAN64K, GRAN16K, GRAN4K
> 
> Probably soon we will add DS to that comment and it will be fully
> backwards compatible so a new VMM following the new guidance can just
> read DS.
> 
> Thus we can't have any kernel release that doesn't work with a VMM
> following DS...
> 

Ack. Understood.

Praan
