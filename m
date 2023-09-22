Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0678518C2D
	for <iommu@lists.linux.dev>; Fri, 22 Sep 2023 07:52:26 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-405361bb94eso15052165e9.0
        for <iommu@lists.linux.dev>; Fri, 22 Sep 2023 00:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695369145; x=1695973945; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hcD2WxWIK5nogl0nPGxwYMClWdYAi/+TaekySrDVVbY=;
        b=PH2CN6WjXmeUWvda0QGH9NAQ04g5/dlVAIIPqk7K94Pk4eDdXD+586CmYm9lAlYdd7
         T4SmU3RhkhfnHZge/xD2Yfyvy5Tz74YWN/oKVQugHOt7EZITA2vpjX20DhxDZHypjN6V
         uPP8QDnLccg35S73dQhSrqY+fDp5cYDdQGZK2ZrgaBuQFW9i8HP0p2o/yL+oaBXpOygz
         8nNZtbcNcbMHyxu/Oa5sCzHBJFmusRT2ZCpl1N517arWRbch/QHiMyV9eKlRj25UiAPf
         SENlJwXwByjXSSJKex0J1gB0Xzq32Oyxr3hF0UNl/6DY0HnlHwJCD1oc8oI+gnzd0M0t
         OR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695369145; x=1695973945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcD2WxWIK5nogl0nPGxwYMClWdYAi/+TaekySrDVVbY=;
        b=d8zJT1kN52JF+G7xFH4Zx4PubjsB483SXVijn6S8KqQGUh+3OUONBYYoAQfeuCECKm
         pF1iff4F04HMg4iKtIv9iiJgiCaasTU0s18il9/FCQnuWZtY3G359t4yRIA5OPCQhQPn
         jbTTn/Wp73eAWTzuqvVrGvbsAD9y9gOMlFDrfr3mMxkLIhz9I2ZGtl+5pujc2ne2Z891
         1qidBAZxBBTUyIi0MpTHGAKFa6/I71Fzlhtv7b8kwAkij0OUqBJR/zjaj1niE98gC3CV
         ETTc57jspVieJWMYXd19b7bAFj3o7UGrEEaZYcwLCf0vH0dRROJ1AKBg1Ri38y1f1JOX
         b/eA==
X-Gm-Message-State: AOJu0Yx5wLM96k5FG4uVRM1vTewRBPoiZPMgjBSevB1H6NA6EsAJhZt/
	FkC3Erq/XkLs3CBrItVYSTDCXw==
X-Google-Smtp-Source: AGHT+IH50+JuT0hNWVHhO8l5lBOC4otqoUC+uD8KQFJh7d5H2c8inCy3MrjHonCe1JbAgZ2NZbenow==
X-Received: by 2002:a05:600c:c5:b0:3fe:2f31:8bf7 with SMTP id u5-20020a05600c00c500b003fe2f318bf7mr6796220wmm.26.1695369145016;
        Fri, 22 Sep 2023 00:52:25 -0700 (PDT)
Received: from myrica ([2a02:c7c:7290:b00:fd32:2b31:6755:400c])
        by smtp.gmail.com with ESMTPSA id j2-20020a5d4642000000b00317e77106dbsm3731065wrs.48.2023.09.22.00.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 00:52:24 -0700 (PDT)
Date: Fri, 22 Sep 2023 08:52:30 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Message-ID: <20230922075230.GA1361815@myrica>
References: <20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com>
 <20230918-viommu-sync-map-v2-1-f33767f6cf7a@linux.ibm.com>
 <ae7e513b-eb86-97e2-bed0-3cca91b8c959@arm.com>
 <20230919081519.GA3860249@myrica>
 <1d513178-bab9-0522-87f5-1a058bb8121d@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d513178-bab9-0522-87f5-1a058bb8121d@arm.com>

On Tue, Sep 19, 2023 at 09:28:08AM +0100, Robin Murphy wrote:
> On 2023-09-19 09:15, Jean-Philippe Brucker wrote:
> > On Mon, Sep 18, 2023 at 05:37:47PM +0100, Robin Murphy wrote:
> > > > diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> > > > index 17dcd826f5c2..3649586f0e5c 100644
> > > > --- a/drivers/iommu/virtio-iommu.c
> > > > +++ b/drivers/iommu/virtio-iommu.c
> > > > @@ -189,6 +189,12 @@ static int viommu_sync_req(struct viommu_dev *viommu)
> > > >    	int ret;
> > > >    	unsigned long flags;
> > > > +	/*
> > > > +	 * .iotlb_sync_map and .flush_iotlb_all may be called before the viommu
> > > > +	 * is initialized e.g. via iommu_create_device_direct_mappings()
> > > > +	 */
> > > > +	if (!viommu)
> > > > +		return 0;
> > > 
> > > Minor nit: I'd be inclined to make that check explicitly in the places where
> > > it definitely is expected, rather than allowing *any* sync to silently do
> > > nothing if called incorrectly. Plus then they could use
> > > vdomain->nr_endpoints for consistency with the equivalent checks elsewhere
> > > (it did take me a moment to figure out how we could get to .iotlb_sync_map
> > > with a NULL viommu without viommu_map_pages() blowing up first...)
> > 
> > They're not strictly equivalent: this check works around a temporary issue
> > with the IOMMU core, which calls map/unmap before the domain is finalized.
> > Once we merge domain_alloc() and finalize(), then this check disappears,
> > but we still need to test nr_endpoints in map/unmap to handle detached
> > domains (and we still need to fix the synchronization of nr_endpoints
> > against attach/detach). That's why I preferred doing this on viommu and
> > keeping it in one place.
> 
> Fair enough - it just seems to me that in both cases it's a detached domain,
> so its previous history of whether it's ever been otherwise or not shouldn't
> matter. Even once viommu is initialised, does it really make sense to send
> sync commands for a mapping on a detached domain where we haven't actually
> sent any map/unmap commands?

If no requests were added by map/unmap, then viommu_sync_req() is
essentially a nop because virtio doesn't use sync commands (and
virtqueue_kick() only kicks the host when the queue's not empty, if I
remember correctly). It still does a bit of work so is less efficient than
a preliminary check on nr_endpoints, but it feels nicer to streamline the
case where the domain is attached, since map/unmap on detached domains
happens rarely, if ever.

Either is fine by me. An extra test won't make much difference performance
wise, and I guess will look less confusing. Niklas, do you mind resending
the version with nr_endpoints check (and updated commit messages)?

Thanks,
Jean
