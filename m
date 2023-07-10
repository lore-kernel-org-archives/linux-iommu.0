Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ECE2581
	for <iommu@lists.linux.dev>; Mon, 10 Jul 2023 18:40:30 +0000 (UTC)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-766b22593faso345374885a.2
        for <iommu@lists.linux.dev>; Mon, 10 Jul 2023 11:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689014429; x=1691606429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zp4+jo/0AHmLulNuvIh/KwLGCyw4HNK3R4SueheNcGY=;
        b=lYxf8rghghWJv0Q/vA+V23rYsyKhY8pOyeUVCpJjWaQeoVTTwwX5NsHIOYN6eF/d5q
         1OzslYw7Mew3LXDQCKkepu0Mk88a/7qtxxHvKbssn1FyLQ7dc10gcdJv6dtWSE51dqeq
         EBE4968gpBAofOVhg3FiKpizWNQgR7ux/JcfgP37z0nzpjyNHw/6MYL38g/Aj1kfytSS
         A8QlNgghxoMgCo26xqlUi3iXl8p7ENNY9Ev6lhCIkFPIiEAhJUJvX/icgklDaLGZ772+
         GjDzmwjFSJsSnlH2SGmSoJi7KBvTF5JRBpQok9/rdqRbYvqTwGN2tDW0hQY2kjtQhndb
         +h3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689014429; x=1691606429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zp4+jo/0AHmLulNuvIh/KwLGCyw4HNK3R4SueheNcGY=;
        b=cDqUqmJi6tyL7e+VC41H9GxmyyBQbrajB1+3iamwK3VE+JB5ahPNGMb5GFGM6kUMxD
         YTfurrUeajdE8HI4lxOYA6PpKADznf0mU8nsFtilpRtffStwMtbv6K3bNKfY18k4yQWU
         ckf9BH7ObzPoWrKXZG5SsLD7ZskwbnH8OhW/E3veGglUWbNoq4wCuHzJVCzJEwUEnJef
         WsDFfx5FiSOZ4v5oTZm1yoKG63IpQKfMRDy4YKjEZsPUeo2qJUTXlbkICCYZMhHwYw6i
         Oe1YFEIyDvnH6KCrpWm9wC8MYlZqIcPMbXpL8AsDIgUH8lbQ49lBL7RI8bJgiMUsW6K8
         BKTA==
X-Gm-Message-State: ABy/qLadWpuQ7i2JF5pJYRatF8yUoCKMB4KSVGewH32KdxGYdhFf6/MQ
	7xzdNZpiW4qZ63pU7wAp8oUpGA==
X-Google-Smtp-Source: APBJJlHFbNkZF410er95MF4TKaxREjQwy7UnQBG18GsQoNgShoGn/BNZdT9yh3AybAWNLnEhuqOvOQ==
X-Received: by 2002:a05:620a:45a1:b0:767:3771:f770 with SMTP id bp33-20020a05620a45a100b007673771f770mr13588204qkb.40.1689014429364;
        Mon, 10 Jul 2023 11:40:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id 20-20020a05620a079400b0075772c756e0sm119355qka.101.2023.07.10.11.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 11:40:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qIvoC-0004j8-Gp;
	Mon, 10 Jul 2023 15:40:28 -0300
Date: Mon, 10 Jul 2023 15:40:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Subject: Re: [RFC PATCH] iommu: arm-smmu-nvidia: Add default domain type
 implementation op
Message-ID: <ZKxQnKhqKziyxX8f@ziepe.ca>
References: <20230710082252.9702-1-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710082252.9702-1-svarbanov@suse.de>

On Mon, Jul 10, 2023 at 11:22:52AM +0300, Stanimir Varbanov wrote:
> Add def_domain_type implementation op and override default IOMMU
> domain Kconfig option (CONFIG_IOMMU_DEFAULT_PASSTHROUGH=y), which
> could be enabled on some distros. The current quirk has been done
> for Tegra234 machine, because I found the issue on it. The issue
> itself appears on USB host controller which cannot be initialized
> without IOMMU translation. Something more, we proved that IOMMU
> translation is needed for display and GPU drivers as well.

Generically, if you find HW combinations where certain end points
cannot work with passthrough (which is really weird in the first
place) it should be narrowly quirked - not just an entire platform.

Also we don't really have a way to force non-passthrough, ARM32
systems will always run in passthrough, for instance. Broadly the
kernel expects it to work.

Jason
