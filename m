Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB8C107B4
	for <iommu@lists.linux.dev>; Mon, 10 Jul 2023 17:29:14 +0000 (UTC)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6355e774d0aso26682446d6.1
        for <iommu@lists.linux.dev>; Mon, 10 Jul 2023 10:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689010153; x=1691602153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NijMvu4hDPVcn1xdPqxC+coZ9Y8AUqtC5nBuqj5T3eI=;
        b=HmtbopGCZEIoAGeA5xKlxgRxdSMmaMPuZJWEYjL6F+XIVF0kfNo4CmzxEH1m/e0WND
         BhKOOFPKkYxasJc4m2T36ZUAZi00BY25GduLfqKHLtYS++CuX7+7XyZlzEDYkQxBU7qV
         BA0b+CXNhHQX4UMb92RWjyFn8xejGejJwbsgmreeYsPVULuHm0DiHfIpJuT5k3QV418f
         9lbpUjDIYxRtqzlku2I6LGbzKWcejoFilD2TU3jeRYLdSMEmoZcy1RIxQgozCmcZ19dD
         XWYnpDcg53JFw1PCji7ANmzN+g3fAH4fgSBMY55TwdlC9UKKAMBWJJqztH3bum6ArnOw
         9bSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689010153; x=1691602153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NijMvu4hDPVcn1xdPqxC+coZ9Y8AUqtC5nBuqj5T3eI=;
        b=g/B1nHpdoNKk9vdZuM9pfJLL278Q8MI8tTXNqrj9iZU2/R01KaMEUVGSgibA3rPnpi
         +TnMLeVfY5cOUcacucugkDs4PRQ+rHzBQOvIcV76IyOyl3mKsiqJmydHypmnstZ/cLQK
         i/W43d3ECpreJGnMyNiQNJNkm4uxoTnM9sNncax+xKfI8XdhR/SJ/yNjIPpqlyzygQK4
         4bc7l0WrHMa4zitnIc0nUGcc9aCV6DK4err3b2SPlNV3hH8PMxYwhNfwS0URIcqlOQNH
         +IdP5ztSvdnNQFchswDx9p1akFegtWTgbVk4IyUGvq+cPf8ZAlMSnsCURRW3AjB+WmWy
         LQdA==
X-Gm-Message-State: ABy/qLbC9hlSWBAZqmDEphfy25sP0awBSQIdOVzMs6hsG+aE9uVknx/9
	eqkmsEzUeTjJGRmCOfZlLVS+uQ==
X-Google-Smtp-Source: APBJJlEt/sUmDLXrLxo45lionjYNQmEHJgq3ERqjFIlGob/IwNHCoqaKp2l5acb5H1OG3gitrRV6Fg==
X-Received: by 2002:a0c:cb8f:0:b0:62d:feee:2520 with SMTP id p15-20020a0ccb8f000000b0062dfeee2520mr6258429qvk.51.1689010153723;
        Mon, 10 Jul 2023 10:29:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id h16-20020a0cf210000000b00636bde318bcsm47891qvk.61.2023.07.10.10.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 10:29:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qIuhE-0004Gy-QG;
	Mon, 10 Jul 2023 14:29:12 -0300
Date: Mon, 10 Jul 2023 14:29:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tina Zhang <tina.zhang@intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 6/6] mm: Deprecate pasid field
Message-ID: <ZKw/6O4QmJMIRRP9@ziepe.ca>
References: <20230707013441.365583-1-tina.zhang@intel.com>
 <20230707013441.365583-7-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707013441.365583-7-tina.zhang@intel.com>

On Fri, Jul 07, 2023 at 09:34:41AM +0800, Tina Zhang wrote:
> Drop the pasid field, as all the information needed for sva domain
> management has been moved to the newly added iommu_mm field.
> 
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
>  mm/init-mm.c | 1 -
>  1 file changed, 1 deletion(-)

Shouldn't this remove the field from the mmu_struct as well??

Jason
