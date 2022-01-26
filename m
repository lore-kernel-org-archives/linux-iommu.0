Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720EDC2BA4C
	for <iommu@archiver.kernel.org>; Wed, 26 Jan 2022 09:41:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 16FC160B44;
	Wed, 26 Jan 2022 09:41:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qv2eD_Nx1R-j; Wed, 26 Jan 2022 09:41:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E73CC60E9A;
	Wed, 26 Jan 2022 09:41:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D2A9C0031;
	Wed, 26 Jan 2022 09:41:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75204C002D
 for <iommu@lists.linux-foundation.org>; Wed, 26 Jan 2022 09:41:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5B6164034B
 for <iommu@lists.linux-foundation.org>; Wed, 26 Jan 2022 09:41:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id olICjUqRniuN for <iommu@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 09:41:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9F0D140183
 for <iommu@lists.linux-foundation.org>; Wed, 26 Jan 2022 09:41:39 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id r126so3113102wma.0
 for <iommu@lists.linux-foundation.org>; Wed, 26 Jan 2022 01:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=DgC3fBf+JMernk9UtJYHLs3WXUQ4WF2uVpf9z50+mN4=;
 b=KSl6lTYmsVi33WHBN3QnElkvHgGznKo+f/d/ZSM8+9YhM6kZn6ta1q4C0eEBpR7H7H
 q2pHOPd4qHOfapjgox1untAEzse5dCyt6yyT3CefQZZRFK8z0sNVUWu4xyM9qaQ/lCmz
 +UfOOiLYGJw99mue93gUeV/HldhzX3TQrtN5o5o/ka41LY2jN0+yuckYPwxVyrDXvIKN
 D7y6CqTsUwSdza5+t0tNt8p0zDQi9zhZNVyhiANXZjPp2NifE/JOmirFKQeBVO8hTTiq
 2PmDXc+706mQQ+8M4xyBRdTU9kB6hy0N6wsGZXqd3kgdyQb7qUDcIchacnRsxDTVOvjt
 Faog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DgC3fBf+JMernk9UtJYHLs3WXUQ4WF2uVpf9z50+mN4=;
 b=h87gsnphs9ZdT3nY6hJNhiqhV6EvF/1GQitcSUt0518kTomF2hp6XtbJ0MP9Hgqh7w
 7aFXY3sYi66jwYgRlwkk/vF1+chnaQYLXifFdnG6o+tQF4rYHMZ0CrQEOvQOhCq5BJOY
 Utzdn7AgObDgNdjT0jXP93fVmLgR/hdKsDqgIxDnaLyTn4Oxs7FJTaucqGLKMbeq/ylS
 tDVUsDF3LfDtqyDB7SRxjVcwGMh/iAIPTU7oixeB5bszX+KTvYLVqrNW72KlaxHN+fVp
 EjURTVUI8LocG+og8uAaHCMtTwNzF/jf4xz0tLcbi9HvCm+DgVNNEt4Pr4JIVVdsytyn
 Rmiw==
X-Gm-Message-State: AOAM533JmahD+2JDQZ4jb1hiDN/dnM6YsMW8icwEbDHKzqEKXDBVU/0v
 xAOl0Q1zZCXVg80ph11CPpJLWg==
X-Google-Smtp-Source: ABdhPJyX5OAK0KhXelGAEpKETNqy81bEQDZkxHDK+f3lOrdKefGHj06CmnX/XERSYPKAu/YjnUtCJg==
X-Received: by 2002:a05:600c:4a09:: with SMTP id
 c9mr6475785wmp.83.1643190097727; 
 Wed, 26 Jan 2022 01:41:37 -0800 (PST)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id m4sm2710543wmc.1.2022.01.26.01.41.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jan 2022 01:41:36 -0800 (PST)
Date: Wed, 26 Jan 2022 09:41:13 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 7/7] iommu: Add iommu_domain::domain_ops
Message-ID: <YfEXOegPuG846NEb@myrica>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-8-baolu.lu@linux.intel.com>
 <BN9PR11MB5276BE30652988271878E78C8C5E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Ye58Zxi+F9TQszgQ@myrica> <20220124163302.GC966497@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220124163302.GC966497@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, David Airlie <airlied@linux.ie>,
 Robin Murphy <robin.murphy@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Thierry Reding <thierry.reding@gmail.com>, Ben Skeggs <bskeggs@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Will Deacon <will@kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Jan 24, 2022 at 12:33:02PM -0400, Jason Gunthorpe wrote:
> On Mon, Jan 24, 2022 at 10:16:07AM +0000, Jean-Philippe Brucker wrote:
> > On Mon, Jan 24, 2022 at 09:58:18AM +0000, Tian, Kevin wrote:
> > > > From: Lu Baolu <baolu.lu@linux.intel.com>
> > > > Sent: Monday, January 24, 2022 3:11 PM
> > > > +/**
> > > > + * struct domain_ops - per-domain ops
> > > > + * @attach_dev: attach an iommu domain to a device
> > > > + * @detach_dev: detach an iommu domain from a device
> > > 
> > > What is the criteria about whether an op should be iommu_ops or domain_ops
> > > when it requires both domain and device pointers like above two (and future
> > > PASID-based attach)?
> > > 
> > > Other examples include:
> > > 	@apply_resv_region
> > > 	@is_attach_deferred
> > 
> > Could attach_dev() be an IOMMU op?  So a driver could set the domain ops
> > in attach_dev() rather than domain_alloc(). That would allow to install
> > map()/unmap() ops that are tailored for the device's IOMMU, which we don't
> > know at domain_alloc() time. 
> 
> I think we should be moving toward 'domain_alloc' returning the
> correct domain and the way the driver implements the domain shouldn't
> change after that.
> 
> > I'm thinking about a guest that has both physical and virtual
> > endpoints, which would ideally use different kinds of domain ops to
> > support both efficiently (caching mode vs page tables)
> 
> In this case shouldn't domain_alloc() reached from the struct device
> already do the correct thing?

Sure, if we can finalise the domains before attach that could also clean
up the drivers a bit.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
