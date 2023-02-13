Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89424AD39
	for <iommu@lists.linux.dev>; Mon, 13 Feb 2023 19:30:38 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id by3so12064577wrb.10
        for <iommu@lists.linux.dev>; Mon, 13 Feb 2023 11:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7+PQ5ihkLZBX24QKUEX6RYAfdl271h7g2O+CKjE4XF8=;
        b=W9Fhgi3XjTdcf7W0zcPgebL2IWIvv30t9YVJAYhFMJZgypIwvmhTDrlTjlx7bj4JyY
         PpAj2Rnj+Eu0F/ftO4StwyJ+ydtbU+O5Odfx3z9IVQx9MvXEN+LHzpORKuG7eB6fAvwt
         qVhWF4Qf3TXzdUUzRv9xX+MO49/Vyq13B8YiAjscE+Ww+WQKq8Yqzk7cvzMLN7Lepm4q
         IWAgciG95B8WQUxEIPkzY6VZuyEktXzzv1M81AHayyUqNTsEFvXOcDXuQFMus0P6j/zT
         PJa9kk5ViT/sg0qGq7qAQ8pmUHQIp2ybCri5YlLGTawCl3xOYjgFRVpIJIx1lhGDX87v
         sDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+PQ5ihkLZBX24QKUEX6RYAfdl271h7g2O+CKjE4XF8=;
        b=3lvpW0vKy/ZqQCDNoRyc2Etd5dUYRFRqlUwk63k9p//udPVWIoQddaCsx7ESorD/Yq
         jEdSp464ehcgHQBq4rnXOGTjTGDBXWDBBrkwVUyb16nXHsi8R2rEg87Wmt/72/OIwBDC
         W43a2N+BG2HEBzcHPMVhCzdHnoPRCBwZQLcb0vfrhoSJo8b/eGQ2TMA64OKDgIOJ4dEb
         +SHK9Mw0g/jzWgb4b8AzkSreqtg8uWY80MSZhvRG8ovZPv8CiOr+j7StEK0IPlT8YA8p
         dNAJAkOv+wQpn99oQMdvyYG2CBYiRLsBS+7/iTFPPwB4zpo9z0qhQWDxC4ypB5NgDBEy
         LUJA==
X-Gm-Message-State: AO0yUKWXR/qnC5Bbd8LE/PQbmeBizUXAPkH/NqTLDyI6kMwfJd5das9I
	3TwdHHNMCTVzGEPAIIoRFXCSNg==
X-Google-Smtp-Source: AK7set/SYf0lCxkP9aBTPKdR3/1lqJqR5cFvQtyk1WKeA0gQqK2dqeIy6SzYJwn/pOlPJbO9Mr0yMw==
X-Received: by 2002:a05:6000:10c2:b0:2c5:53e6:9aba with SMTP id b2-20020a05600010c200b002c553e69abamr4941296wrx.5.1676316636680;
        Mon, 13 Feb 2023 11:30:36 -0800 (PST)
Received: from myrica (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id j40-20020a05600c1c2800b003dc4480df80sm20126681wms.34.2023.02.13.11.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 11:30:36 -0800 (PST)
Date: Mon, 13 Feb 2023 19:30:26 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	Robin Murphy <robin.murphy@arm.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 2/2] iommu/ioasid: Remove custom IOASID allocator
Message-ID: <Y+qP0q9U0J2UfIxX@myrica>
References: <20230210230206.3160144-1-jacob.jun.pan@linux.intel.com>
 <20230210230206.3160144-3-jacob.jun.pan@linux.intel.com>
 <Y+pjTR80bnl9rMK1@myrica>
 <20230213103455.02f3ac37@jacob-builder>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213103455.02f3ac37@jacob-builder>

On Mon, Feb 13, 2023 at 10:34:55AM -0800, Jacob Pan wrote:
> > On a related note, it looks like 100b8a14a370 ("iommu/vt-d: Add pasid
> > private data helpers") removed the last user of ioasid_set_data(). I guess
> > that could be dropped too, unless you plan to still use it?
> > 
> You are right, will remove.
> I was planning on the other way around which will convert VT-d's private
> pasid data helpers to common ioasid code, but when I look closer the
> private pasid xa is just holding a list of pasid/mm which could be per iommu
> not global. Another cleanup I suppose.

Yes that should probably be common to SVA. I'm planning to take another
look at SVA on the SMMU side following the recent API changes, and from a
quick glance the problem that VT-d's private helpers solves is common.

> > We could also merge ioasid.c into iommu-sva.c at this point, since I
> > haven't seen any interest for having multiple IOASID sets on Arm, but I'm
> > not sure what the current plan is for vSVA on x86.
> VT-d do plan to use global PASIDs for DMA API with PASIDs since the
> work submited via ENQCMDS must use a PASID must != RIDPASID.
> https://lore.kernel.org/lkml/20220518182120.1136715-1-jacob.jun.pan@linux.intel.com/T/
> 
> So I was thinking a separate ioasid_set for devices that allocates global
> PASIDs for DMA API usage. ioasid_set will be useful here for limiting
> lookup and resource management. e.g. PASIDs used under in-kernel DMA API
> are not subject to cgroups.

Ok. Yes that was the goal of ioasid_set

Thanks,
Jean
