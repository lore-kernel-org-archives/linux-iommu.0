Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955951487E9
	for <iommu@lists.linux.dev>; Thu, 20 Feb 2025 18:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740074410; cv=none; b=INwltNbTp2brSHsj4Aws/EWNcYSI2Y4d/QzH+WtYNWI8joOaBLfyn9F/cQ4agnBWkptcq1ZBvm4S4pX1T3rG0oxZ7+8qSaXdE/VhQyMnG/fkf07s54O/KOFA7qlra0NL3c1Ysv/PO0Lg8FnJm26Wh3NG+g9SG8YmC/eYaXL8WcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740074410; c=relaxed/simple;
	bh=eSZ1FTDl17sy/1gqD/+wlyeyEdUOzIKAubEl/bdPJvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKTuV4/3PgN2I8nd/k5cGJh+runsQx/RyWgXC0F+wYt84O+h68bbj3RRvuefDj1UVUPOMO+TJpWjs+g8aQ/Wg+XKi9vajmmvNLYmj7Hv9p9sRq6Tw3VjV7JgT6zxhYRGZfm0/flzQ0o/yGcTPLeiwe1VkuDqAGrJpsplBd6zYLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jYSbkE5G; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jYSbkE5G"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-471eb0e3536so4682871cf.3
        for <iommu@lists.linux.dev>; Thu, 20 Feb 2025 10:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740074406; x=1740679206; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mqfOIw71GSnlOakkatpEUx/UlJU6cK2rQ1RtMvMbUys=;
        b=jYSbkE5GPr3g0vKPSHgKExtx7PLSY7sINyMI5s8LN6YdT+pu7JnA2+DycLXa1nvywX
         Qr8wGzsI606cRP90WxZPddzcwUt9qJOrVIhb9DLMaa35PjsHUc8xlMlv3DF0xvBfQAWS
         6yARIwc9vkrc02MtdHByQL/6YtR4K8qFopuyMy3cSiSrb4yoMfhfcprA6l/7uNOZG8JI
         j6vaKbzaSeCw+DqH9GKd77pX3P39lhlMNyU+EnB8OD8sFopqBDiqzkE9ZdX9M4vX6zO8
         cSQ3PmtZozX2JRDCMhcx2+NHK9woYqDW05FDBbLX05X+auaam6wGMAXbPg6GBdsrsia4
         5tHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740074406; x=1740679206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqfOIw71GSnlOakkatpEUx/UlJU6cK2rQ1RtMvMbUys=;
        b=GOCMM6Chnozi58NrLkdiR804LfVVIJO6f2FxUQtDtpJpQG+AitVFswRZVuNRmUhmP/
         QiyLttFQUZQjTxlhfJel10te17crjUAtfOx/XIy51Bmz3TVEAfNgN01GcihSNCdBUBqY
         cEPpdabR8ZKnOfamFFGFTd400URDty3u96yjJF22nIwdl9p/1jdf86QIY2UMnO+GUtnj
         /1frfPSygxzOh8tCwKegrmGTNeElXHulBR8qD7DDwQW174IqZEUAgYNRUJnV3bcvM/tI
         TmqWqgEZPVw97NhC7BWcU10xpPbxU+mbH9v4+DV4uk4lL4MIhvDqnhRAVNUyAn2w9LEG
         NY8g==
X-Forwarded-Encrypted: i=1; AJvYcCVP0T4P99cK+CBuhb5YoL/gtUa9uJNcJgv86Ee/WAKLSZiLDIUajE4cAdu8uQp6v9CpMr9Xvw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzloMdIqBicBTNBJ8ltie7c1OpiE3G8WonVEoHiKOK6MvfvqTHs
	sJlmvQWi31jQou2hY3y14R9feicPX0lyCUfHflblueZvHiA+d0GOmawyBKCrNU8=
X-Gm-Gg: ASbGncs5oIvf2EPnZJgv6YpfZP2OrRzNrSV9RrmYFfKnyrMnMUPNaQquK9uDg3Ea5cP
	Ty7lb8q8WQE+74KiGikMmnQJlwJqHBgIdDn6rF8EXorhpYtTzKQr+KR/IhXj8BlKJijr134IMeb
	Kx0rS08VyHHzyHBBsTJBvp7PF4LmdaCHHPMZX8FAAwOSX7L5Qla85d2Z/j+yP1jKC5UxgluQsl2
	7vvcSHgKawrB5WBmIjaoIwV9bAFuARmwjv0xc/JNEhJzQ/DI98wLO3sY3zyLyvrBHzT8Ij17NZ+
	2C1NWsYk0VJ8VuY9rW67pJYBULjBjRD3yT1RQb43SVSG2iROmQZE9qTC5nQ1G2t7
X-Google-Smtp-Source: AGHT+IHDKGAnl6DU9pk9/XM2fUS5ajQw/PBjTEaCphng7uBZ47O872Lj2r9xrDJ2GgiUB2EAVoAsaw==
X-Received: by 2002:a05:620a:8084:b0:7c0:c24a:ccab with SMTP id af79cd13be357-7c0cef0b032mr24535785a.28.1740074406291;
        Thu, 20 Feb 2025 10:00:06 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0c0e771e7sm145931885a.101.2025.02.20.10.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 10:00:05 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tlAqC-00000000Ik4-30cu;
	Thu, 20 Feb 2025 14:00:04 -0400
Date: Thu, 20 Feb 2025 14:00:04 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/12] iommufd/selftest: Put iopf enablement in domain
 attach path
Message-ID: <20250220180004.GX3696814@ziepe.ca>
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
 <20250214061104.1959525-9-baolu.lu@linux.intel.com>
 <20250220010250.GQ3696814@ziepe.ca>
 <d93c8cc9-77a5-4b78-85d2-6b4601f52266@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d93c8cc9-77a5-4b78-85d2-6b4601f52266@linux.intel.com>

On Thu, Feb 20, 2025 at 03:03:21PM +0800, Baolu Lu wrote:
> On 2/20/25 09:02, Jason Gunthorpe wrote:
> > On Fri, Feb 14, 2025 at 02:11:00PM +0800, Lu Baolu wrote:
> > > @@ -197,11 +201,19 @@ static int mock_domain_nop_attach(struct iommu_domain *domain,
> > >   	if (domain->dirty_ops && (mdev->flags & MOCK_FLAGS_DEVICE_NO_DIRTY))
> > >   		return -EINVAL;
> > > +	return mock_dev_enable_iopf(dev, domain);
> > > +}
> > 
> > This isn't going to work for a replace type operation? Maybe like:
> > 
> > if (old_domain->iopf_handler && !domain->iopf_handler)
> > 	return mock_dev_disable_iopf(dev, domain);
> > if (old_domain->iopf_handler && domain->iopf_handler)
> >          return 0;
> > return mock_dev_enable_iopf(dev, domain);
> > 
> > ?
> 
> The iommufd mock device driver appears not to support replacement.

That's not technically a choice the driver gets to have ..

> The
> replacement operation on this driver is likely handled as follows:
> 
> - attach domain_a attach blocking_domain attach domain_b

Nothing actually does that though?

Jason
