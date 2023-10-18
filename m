Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E1539857
	for <iommu@lists.linux.dev>; Wed, 18 Oct 2023 23:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R4unvUN5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697670953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eGKv31T20FLnyp7D1PvYxnTsDDoyuURiN0uwwMl987c=;
	b=R4unvUN5to1Kkvvpk4bmruKvVNQKdAPBkcpgq7hM/4hu4fkFBmKRht7C1p7mjXvFI3xYsq
	DJY4QkKezz0LBs/0bDH33OQuWSnunYmfoEzm1/bMFaJN+DRc6NIeUbL86dHPT2QcQk5ejq
	px+7ooVp2ZDiYyzCQlLATSL2DzdeFAs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-WPj5syt9MfqD1rAdujbAAQ-1; Wed, 18 Oct 2023 19:15:52 -0400
X-MC-Unique: WPj5syt9MfqD1rAdujbAAQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-774086da4dbso898609985a.0
        for <iommu@lists.linux.dev>; Wed, 18 Oct 2023 16:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697670952; x=1698275752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGKv31T20FLnyp7D1PvYxnTsDDoyuURiN0uwwMl987c=;
        b=ffefxg9iXEohBpOHZYSkzaWgp0aZWLN/T+vEZhqFF5/Uw55mMArGcSVZBJbmUyb4nY
         IGh5mbsVAM7m5WSHBIkBkTZqjZJkwgNxjqZZV2/qesivLf5sGy2uPUh/ElHS1dAa+FbG
         0X9Ook9ngLJvsngE1VDaO9kYWB8YMws0onaphC/bV52OF8DccI2md4wztQSwJGc20lX+
         +xwJeTN16x5uJXTxRyHcZ2RV6rZm41ZyTBCqww9gk6SIOU30zfdPzJ+dc21TaA/rVgvk
         bGjEu9A67pB9yHEPA1ppjLSLh4bQjSkc+k36/0ueYtLQzMKN4yGCJ0TRlK71sWBbELnp
         ttUw==
X-Gm-Message-State: AOJu0Yy4+GWcmpjqAuq1FyTLlQZWNeg/XqOqxDunUbN0H/M9TdkciVzv
	bUeiebffKAeyutzDFIBPiguSzVj6KK4s3O6y0Rd4dDV5KmmEm68zoaWx6Ww/zSlTtKIM6Ix0hWv
	jyJluqJyJcneJCoE=
X-Received: by 2002:a05:620a:3d13:b0:778:8fdf:1b4 with SMTP id tq19-20020a05620a3d1300b007788fdf01b4mr490890qkn.57.1697670952098;
        Wed, 18 Oct 2023 16:15:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH83FrTQusK8U+MDDlLFi41YWVhe+5MZKC/wYYepqgKFRMYLkBBVQW2YlojFKwcDHI82+ylJQ==
X-Received: by 2002:a05:620a:3d13:b0:778:8fdf:1b4 with SMTP id tq19-20020a05620a3d1300b007788fdf01b4mr490878qkn.57.1697670951842;
        Wed, 18 Oct 2023 16:15:51 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id k16-20020a05620a07f000b00775bb02893esm311733qkk.96.2023.10.18.16.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 16:15:51 -0700 (PDT)
Date: Wed, 18 Oct 2023 16:15:50 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev, 
	jgg@nvidia.com, baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/7] iommu: Decouple iommu_domain_alloc() from bus ops
Message-ID: <oeso4k4afucpvzy7aavon6sazpamn6tonbmaa5rpybcy2bqph4@d7sng6fk3vyt>
References: <cover.1697047261.git.robin.murphy@arm.com>
 <81a0a66d76b3826f1a0b55d7fbaf0986034c7abc.1697047261.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <81a0a66d76b3826f1a0b55d7fbaf0986034c7abc.1697047261.git.robin.murphy@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 11, 2023 at 07:14:51PM +0100, Robin Murphy wrote:
> As the final remaining piece of bus-dependent API, iommu_domain_alloc()
> can now take responsibility for the "one iommu_ops per bus" rule for
> itself. It turns out we can't safely make the internal allocation call
> any more group-based or device-based yet - that will have to wait until
> the external callers can pass the right thing - but we can at least get
> as far as deriving "bus ops" based on which driver is actually managing
> devices on the given bus, rather than whichever driver won the race to
> register first.
> 
> This will then leave us able to convert the last of the core internals
> over to the IOMMU-instance model, allow multiple drivers to register and
> actually coexist (modulo the above limitation for unmanaged domain users
> in the short term), and start trying to solve the long-standing
> iommu_probe_device() mess.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> ---
> 
> v5: Rewrite, de-scoping to just retrieve ops under the same assumptions
>     as the existing code.
> ---

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

