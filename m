Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C621BC09A
	for <iommu@lists.linux.dev>; Mon,  9 Sep 2024 13:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889917; cv=none; b=puVu/0NrYd0uGZxJzTdDMe527FiGVAwe5XAwGFPNZbWkWPBr6R7A9hioSwEzfK34mgulLlpE/23G13eDEtP1gMUYixL/Kc/6fT2haEi/oJmYDkht+Tmeg2o9PpFX9lKHdrTx3YOq1sv5iwsiXBGtFj/8z7+n+FNOaujvanbcNqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889917; c=relaxed/simple;
	bh=yj7+HNUhZ42zQ7e1zqARXsVl9jwOBImumTxZ0tEXKC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6NYeEWE5Nc2FSTjU98OjnqRy3GHkTuGnQhB4EdOQhn4pDYBgKduLubxpYklVoXYgBViEyQKzmHCSQiThgZPGi476coWmMPcKlPVN63CpCeBmoU3/9gSiiEmMJP/wBl6daKISnlV6EWl4ZWrszMEIpKs3lW2ZiBib1a92fiodPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kyfv1dl5; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kyfv1dl5"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a9ab721058so138971385a.1
        for <iommu@lists.linux.dev>; Mon, 09 Sep 2024 06:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1725889914; x=1726494714; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yj7+HNUhZ42zQ7e1zqARXsVl9jwOBImumTxZ0tEXKC0=;
        b=kyfv1dl52LvqxF48+wNOGpwlpOTQVOD71AexL3SqxFZBBIXeqLAARmHEDj+UaOqADC
         Um2ia9jsyV+n8YZz6odwhIpNKbOpoVnC+Q5dzzpau15wiXqcxADU8K3+XwfnyOZSkgUe
         bHvn2a3KL4XK1JiDErDi1SygBzZI0lyCTvw1FhSqoXa6AbCIHZJzHl9VGuERLGg7j3o8
         KuUt/XxOcnN2r0Pgo3EmO+pULGJiNyds8g668VBCgTHg1PtJFxTHo3u8MxbOMH17XR0E
         PIXy2vDDM/cw9E3sl5P9GX1ut98ppIGg/eQu2XPGZ9yoG1v5Z+BcpWUn4PmQCNjbg0TT
         LE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725889914; x=1726494714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yj7+HNUhZ42zQ7e1zqARXsVl9jwOBImumTxZ0tEXKC0=;
        b=L1Hb3eVzpPijECSNtrAyMlbBID4u/FtwPF2SGXdsqjAEtwD9jUBECCJ8kKmM+6hZ6c
         RmsBS5HRSvBeGA/yBo8j6dviQvy0MSVLsVndBkW7Hst445o8SPdmhJZiKDCSC8rlpnHE
         p1blfa2ixOxDt7ALnTjYXnFIa6tgNueESpVZelAAAbwBjIVViQvOhVgMMxR4pOQFqtTZ
         FF5Wsnt3FZdhur9e153mFDFl0P7E/U0c7O9FBzgDdDSkfSgITwDTJeTiBA3wABS8hVY3
         0dcse6Muk6Dfmxnz9H43NetHKf5pYUJThB970syuaIt5FN8DN3FpyDJ4jETF1DrWLHSM
         NXqw==
X-Forwarded-Encrypted: i=1; AJvYcCUrU346bxnzwYsyqrCP7jeWmhmETcssI2VsN1XlH3AvuIELxNoERJTX/Cr87xIUvrwia3xNEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzL0phcZ4MLd5XX6O+IPE+Vbi29XnwlSGqkozPqLpVXW0/frtoD
	rdQwcv7ITO3e0Qx+KYsu+nGpxzo/Qa1jtjquFt2u0TrhVjZdnd1q8lyP0TqKzxw=
X-Google-Smtp-Source: AGHT+IE32skbFpKLVZQvvKRGIbOT+Lk4glz9hLQYid2tc58+roSuuIWcYGTezpJn4PsYDlHvh90irg==
X-Received: by 2002:a05:620a:24d3:b0:7a9:b80b:81e with SMTP id af79cd13be357-7a9b80b0f7dmr521832985a.10.1725889914151;
        Mon, 09 Sep 2024 06:51:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c5343295f7sm20958506d6.21.2024.09.09.06.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:51:53 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sneo4-000es1-U3;
	Mon, 09 Sep 2024 10:51:52 -0300
Date: Mon, 9 Sep 2024 10:51:52 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lyude Paul <lyude@redhat.com>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Karol Herbst <kherbst@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sandy Huang <hjc@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] drm/nouveau/tegra: Use iommu_paging_domain_alloc()
Message-ID: <20240909135152.GA105117@ziepe.ca>
References: <20240902014700.66095-1-baolu.lu@linux.intel.com>
 <20240902014700.66095-2-baolu.lu@linux.intel.com>
 <a43c31da6a6989874eb0998dc937d7a611ec542c.camel@redhat.com>
 <20240905132459.GG1909087@ziepe.ca>
 <243808ad949823a0d64cd785ed05a375ccdba096.camel@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <243808ad949823a0d64cd785ed05a375ccdba096.camel@redhat.com>

On Thu, Sep 05, 2024 at 12:26:31PM -0400, Lyude Paul wrote:
> I did take the one patch - but I'm happy to push the others to drm-misc
> (provided they all get reviewed. 2/3 seems to be reviewed already but not 3/3)

The whole series is acked now, can you pick it up please?

Thanks,
Jason
