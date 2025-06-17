Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4644E1E834F
	for <iommu@lists.linux.dev>; Tue, 17 Jun 2025 23:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750201419; cv=none; b=H1HGGIWLnV4fFErLpx+rjIq058QmI5i3b9MMt+h9f1TjgyWmtoHm54cLk3pMEL1jlALW++Y1sewTKmCalc56739D5A5o1qC1/Of1wkS1bgoHySDAXtBQhiJ/pUhR+QqGO8/i+QKMtuWECgVvaAOhqVGeOVtjTdO/RlWiRvnRugk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750201419; c=relaxed/simple;
	bh=7yQyAg9QQkikdevayCOR4HwJNpcyiWJT9okKkefa+HI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4JHC1b+ImMK/MoiYcp7ibhk2xxq0+GCtTskYp7GR8FWBH12tIBXNBVk88KJbtw0xwwW96/JgmprN+xjXBEtTDyP2yOvB5t6vqdcMyKDGCbyfKkRi+6BHPetp77Cf+raL5mshjFgK8PUAruq5F9MgPLAhrsgnpuBfHFHn1uCwCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iglruPSZ; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iglruPSZ"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a6f6d52af7so68433811cf.1
        for <iommu@lists.linux.dev>; Tue, 17 Jun 2025 16:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1750201416; x=1750806216; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qeHg/OOZNjjpk2NyiVqmd4EaAAlIU7s30yRkT324JII=;
        b=iglruPSZ4QoNl6G7LEaB1hRTVfvUHeNppRaSFpHOzBg576btvEq6C9fOmUS1NuQcQ4
         9u+sCE3m7LhZI/kwqgD1l/NBKaQAXeohMaRvdpxpEcAhX+Aw8iBMYYgZcQ8pzYBO9e/f
         mZF3etmMptY0UB4qfGErIhjbfmYzNkxDFIs5DKWOA31A1Ex7RZ/MM/e4jY6U72NA6lrS
         16SfoaqCjq9yrNXN/3FeS1t+Udx4b9v3WDcjR2cDT82px7jCkp5+H65kpq7uzMtbuOLc
         mT2irn5Cu+vdnjzd0FTv7bXDRJw/M3GgR3ExGrblEbaY/ifZh/227zPlwh562XDhn1/c
         okaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750201416; x=1750806216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qeHg/OOZNjjpk2NyiVqmd4EaAAlIU7s30yRkT324JII=;
        b=ARCEXE4pFRmScBINgmh41/+kMFFImNUw/6YgQh6seSJq3QfrAa4HTo7200iW7YN+p7
         GOnot9NSKK6K4p45G0Qdb31I3y4Obph59gsLhN97cg6SD+W6y+WKcIQavhPZUnhEK7Z9
         Et9+aITGVuNMAdtcMJIoyrf54epKu2ZcD6DmmqYkuRo1a+GEajMHu6isAtjGaU/yXkPB
         Sl8JrmiCkkNuSlHaBzk2Rti4h4/FGOrDxSsLIaC/HVMkH/PbXKLYzHSuWwlYvBwtlgOO
         wxTst/QoEBLjyIDQ1QxDXgzczScahicYmX/1mDlX8yvd7BU0/2+3EgOEYGsENFOji61h
         qeBw==
X-Forwarded-Encrypted: i=1; AJvYcCW7kfz3FvO/QP3fei1t5o//oEmZi+bP8AOx7MCwruG42bd53WbDT+mlVCKevUMEtGWPvKwkxQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyaaO5eimiGvN0PafuD8iaDZkVnRt/VMLUUV5e2EABqKtAgXX7Y
	smJoO2PH6mNJL+WdMhn+lwidhaY/z7WRbtsx2Vclj7WgFhuKPdcSrCSGRiBbTRQQqTU=
X-Gm-Gg: ASbGncscqUyeH51K69G/6ZdFqd9c4Xu9KhHzVSk/jBKuBp6/LkFkUYmhLfEH6BQ89vb
	p1DWiTZfoWFAwkuUXBW+l2rmfWVU64BK+6qrZ+SuFJtU46+OBYzSMe4ROuoiPTd8sb/yEbie2Wc
	OMwnFeF+rLPfLm1B/WslA6J/Z/DZqNesk5VHN3ysZ+pe63b5QQr2WgnREPLHDuVpHfSm8BTqLY2
	Tmweo2MXT2uzpQFeDONiCE2PnjL34Xs/c42rQU2/VAigw5m8nYma2LVX6azMFbY472dF12A9y44
	bddFCHaN3lUdBlXUm98LHVgtBZY64BoQiDdGcphPMzL8SYPuU2QWbYg0b2HQZm9ogpPSQAMoYhM
	Si/kj1/4+EopRA+A3cQTgpy3FnA6/crbWHx4rwQ==
X-Google-Smtp-Source: AGHT+IG5E4/SL5wvb+OTW2Z6g1HmGu8oKyQFTaoQSeLjiG0Pk8NLxhD4sGUeZI2iyMgdjVlOfelwLQ==
X-Received: by 2002:a05:620a:404b:b0:7d0:9519:8329 with SMTP id af79cd13be357-7d3c6c09cb8mr2841621585a.8.1750201416029;
        Tue, 17 Jun 2025 16:03:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8eaca05sm705183585a.73.2025.06.17.16.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 16:03:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uRfL4-00000006eJX-07UY;
	Tue, 17 Jun 2025 20:03:34 -0300
Date: Tue, 17 Jun 2025 20:03:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Demi Marie Obenour <demiobenour@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Alyssa Ross <hi@alyssa.is>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev, x86@kernel.org,
	Spectrum OS Development <devel@spectrum-os.org>
Subject: Re: Virtio-IOMMU interrupt remapping design
Message-ID: <20250617230334.GJ1376515@ziepe.ca>
References: <>
 <a65d955c-192b-4e79-ab11-8e2af78b62af@gmail.com>
 <20250616132031.GB1354058@ziepe.ca>
 <20250617154331-mutt-send-email-mst@kernel.org>
 <20250617195720.GI1376515@ziepe.ca>
 <20250617160103-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617160103-mutt-send-email-mst@kernel.org>

On Tue, Jun 17, 2025 at 04:01:53PM -0400, Michael S. Tsirkin wrote:
> > On x86 you also need to use remapping to exceed the max CPU count that
> > can be encoded in the MSI, no iommu required to need this.
> 
> More of an x86 quirk though, isn't it?

Yes, but so is bundling IOMMU and remapping HW together <shrug>

GIC fully integrates it into the interrupt controller architecture.

Jason
