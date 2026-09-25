Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA24A44A409
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 12:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790339333; cv=none; b=EAvPzG/WDVh0MoQ67IWdPWbKBw9rNejK/mY7WTpLg0/mlZa/m5R3mDE44N1iArlsLZaBcL77GV3rWUUDnLng16RF3XBC7a4bOAl6248A30y/sBOD+OcGeHOe3Ka3liQHd7Tc2oSeZynZK8lI4xjyMID5rqvfnuQ3hB6Gd143HmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790339333; c=relaxed/simple;
	bh=BvNvgvqL183EVIKa2VcO67Z2y90SLGmnAvA7iYVM18o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fziWxUfMxpi7KhLdOzflaDmW0m5dnhrNIpCJkoFSykXbys4iCBlBQN7eMbza8K0MCcYP14+Zxh6dFhtKjfP/EDLub0/d+YlduO0HbwZBtV2zhbibkttSy7IlGgP6BnHmZIrOxMtD9vxDE3/KvgWkU8eslEkxgvRQ0ycmoBM9lRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=D8QGHrUW; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="D8QGHrUW"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-341fe27b718so426883eec.0
        for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 05:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1790339330; x=1790944130; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IYBi22JlMsDFxH8u3SI63AaYNIN6lXRFrma2FvtvBGo=;
        b=D8QGHrUWLzab0g3AgducHepmYe4UmBYe6KtRZo6hbBC8IZwhyXVTUnOpRR6T14Om07
         RpllLC8Wy15TBCxscC5JM3Imi5qlXbSYxswvCVjpzPqTWAKfflRGecQXalPv0mzloLGt
         Th7KU63QhZAu39itn1yiIQg9Umb0xkt5jyYWaCLlLTdtKhRCjXSEadfH0/89wOVwWzZx
         j//lQo73v1hFaq2OQG1Pyr/ymF5CyHmfboQgOKT9kUJQP7mLDFuZ5x5vB7ad1FgsIefX
         P2moyilaVPFfmk/7GT0y5HlGB5I2SmzzmlLvTyKTauD6moMU2RguN5YigQtKVp/2r3/5
         4NSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790339330; x=1790944130;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IYBi22JlMsDFxH8u3SI63AaYNIN6lXRFrma2FvtvBGo=;
        b=V1GRkwZ2bq3wtQE9R7z8ftf5ollNeXJXLSebA+3FDbxfhECAlQAj5vIcVA9B3VfY5F
         ujJrDi7Ei3b6WT0r2gVymblpL4mWyQVehevVAQX79fWf9LCAbkH0yiz+inja3FzOtDLH
         rIsBAgmvLUo8Hz4x3Vfykj8NwEHCRlU8X86aHJvQWD/UMoGBDWGUO34Vg5kEW0payCCD
         M+OLytt06KpkozeLswGssfQo69rOW5+cy0YFSMYy/8erssRhd+9s9yOnlvZ7KOvOLZHz
         V8RXs7gtbr181RhuQGec3sq3bisEGC6X9yxDsWGtZndBroFl71StyqWV10b2SE1n9Jnf
         UNNg==
X-Forwarded-Encrypted: i=1; AKwUvBxw/h13llEAsM0juOzu6NSCrGX8HGt44L/SG/AWaZItSbfrFptcuSlD44sqcrOPxq82R6wq+g==@lists.linux.dev
X-Gm-Message-State: AFuF++kdchSUq4cp+AVRbCunDDww/sdFRp5Hh/QOx21BFkGQlDGGCwRY
	85IJqoUeciOalfsEnFdO3Mp9C/BuI2aQvESghoxgFmRSeE/tVAUT5Ie4PNnGUijmV8E=
X-Gm-Gg: AYBFou2wsMmtsvcQFu4IowxY7BjLK7t01Pn8HwrwACASCMw1AyeWhydKMhGFMtKVk3s
	664gb9LOEBOS+3opbiStH93Dp9W7d+p1HzVRmS9pgS8u6GBsz8HolnLNpah+RSPiUXjPjK5VgQJ
	PjV3b2v5Vr/XDIcokj2Y3ezxyto29dSwHVX6xNTYFUYzLQJXtFyhdSxq0+bJNh1QctQdVh2bGEm
	xNGSnZXeRAtH2xc+jvgT1c/XmXGkdZTpmTBpgIWlztPTPDdqOc71RkScDWD2IG55cFCJofP7jy6
	2dzUf5SsPf6K0P4q74lKNqxEA7tt61dIUzqPova/Ovmm+lruOEnJQGma8E/zE6FEUPKeq3Fger0
	BqAKE9evkGWHlpo1owMg8MyewphlbYM/WtGVXg3jXLyrNMZKzkkGKQI00xDfEzKWegxR9bdKLKy
	b6RVv6pcPS+cqo1d4UWgzdtzrkHMfd3ydP6nd6ogHuMx7q
X-Received: by 2002:a05:7300:e11c:b0:33e:633c:7f70 with SMTP id 5a478bee46e88-34272b3bbb7mr97724eec.35.1790339330310;
        Fri, 25 Sep 2026 05:28:50 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3414456b496sm6623329eec.11.2026.09.25.05.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 05:28:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xA52m-00000001FlS-2vL4;
	Fri, 25 Sep 2026 09:28:48 -0300
Date: Fri, 25 Sep 2026 09:28:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joerg Roedel <joro@8bytes.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>,
	Jatin Kataria <jkataria@netflix.com>,
	Boqun Feng <boqunf@netflix.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>
Subject: Re: [PATCH v2 1/2] iommu/amd: Add PerfOpt IOMMU performance
 optimization support
Message-ID: <20260925122848.GD163130@ziepe.ca>
References: <20260908041207.38113-1-mario.limonciello@amd.com>
 <20260908041207.38113-2-mario.limonciello@amd.com>
 <20260924225018.GB16465@ziepe.ca>
 <arYf3iJW7hfTua__@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arYf3iJW7hfTua__@8bytes.org>

On Fri, Sep 25, 2026 at 09:20:02AM +0200, Joerg Roedel wrote:
> On Thu, Sep 24, 2026 at 07:50:18PM -0300, Jason Gunthorpe wrote:
> > Why does the GPU driver have to request this? Why can't the iommu
> > driver know that this is a special device that can use this magic fast
> > path and then auto set it when identity is asked for?
> 
> This is a layering violation either way. Either the IOMMU driver needs to poke
> into device details and their relations or the device driver needs to poke into
> IOMMU details.

There are no device details, this is just a module option in the gpu
driver.

> This is not perfect but to some degree unavoidable with these highly integrated
> SOCs.

This is exactly the sort of hacky thing ACPI should describe so the
drivers can just turn things on automatically.

Who is ever going to track down and figure out it is OK to set these
kinds of module options in the first place? There is general negative
sentiment in the kernel to doing things like this with modue options.

How does Windows do it? There certainly isn't a "module option" there?

Jason
