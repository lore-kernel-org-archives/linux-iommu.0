Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DD033E0
	for <iommu@lists.linux.dev>; Mon, 30 Oct 2023 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JfILW5qZ"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-41cd6e1d4fbso29154461cf.1
        for <iommu@lists.linux.dev>; Mon, 30 Oct 2023 07:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1698677437; x=1699282237; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XAVJg7KJEfcs7fsB5R/ELaG9gHihYCdsFZSthwigaas=;
        b=JfILW5qZbcUGJStmbnF0dvJejhH752jclOx3BSKbr9QRicoh0lR4nwuryN5T7plHJ5
         /XgMLNPNdbZlEvrUwILGy9TB5mV0L9awpqqvcpfCeAephYFd4xHSPo+uTsZilZ/i9HkA
         IoYTiiAoosuXxS7KP/LF7D4KU9VO9aQyFtS7L2MDXxE3yPtkKCvnvTzVt4z7H1ZInC5F
         olZlzUa5rsZd5YXKi1NQREoFOWI1AxKgD8WO8XVI/HNflAGJAwGoSDHeMbUa9UfGKtGs
         c+shNku3mdkmt7ckdVjLTTHGkgqaWKLvBtR2n9l17+k2NVi/8g84+QAHklcZio6R0iMq
         GXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698677437; x=1699282237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAVJg7KJEfcs7fsB5R/ELaG9gHihYCdsFZSthwigaas=;
        b=XFEQnbgWN/aTJT9K/mB81YlSPE2kLxYf4j+ED+JKXFVoM9G6eY4Eb9Qari7F7DNGOK
         iOifKzBXtlvt1ObyNvAwennikfyPwHFDjhbwVXXePT9dKmilb55SBAaMWuvxsnqUgonx
         pGTqvLvjRFEsuAV8TLluCLLRa91D/qp+dthGeCecINAmM7L8PPqE1u+h8IRbOYUgmrpZ
         GndZiQ5WoimONMwjIQoj85i2ms2p1HhA9VotLh/TvuBWPbIdFGdGV5NMrP2Snd4ZPo8j
         FbFQR+dFSbFm/FO4xofBaDlSMWkDf+Y1mYuwvPzNl3Jm1Rje2IMpjzpfFBZyNHseQhy1
         u8sw==
X-Gm-Message-State: AOJu0YzgKS/HcAXDTZLTsJ+cmYv7ODifl82Jt9YyJNPnCn7Uex0hW5i/
	iJifkqMYcKBoWKNSTV2gM9LATg==
X-Google-Smtp-Source: AGHT+IHIdAtzpDuOIzCWJ/BgrfKX8YAlCzUQ0du/QbPPSwBjZiTujSj+CqZEYi8uFUYxw4asFxqWkw==
X-Received: by 2002:a05:622a:648:b0:41c:da4f:fa26 with SMTP id a8-20020a05622a064800b0041cda4ffa26mr9856475qtb.66.1698677437263;
        Mon, 30 Oct 2023 07:50:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id g13-20020ac84dcd000000b00403cce833eesm3427727qtw.27.2023.10.30.07.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 07:50:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qxTb9-0074xP-UH;
	Mon, 30 Oct 2023 11:50:35 -0300
Date: Mon, 30 Oct 2023 11:50:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Koichiro Den <den@valinux.co.jp>
Cc: iommu@lists.linux.dev, kevin.tian@intel.com
Subject: Re: [PATCH] iommufd: Fix missing update of domains_itree after
 splitting iopt_area
Message-ID: <20231030145035.GG691768@ziepe.ca>
References: <20231027162941.2864615-2-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027162941.2864615-2-den@valinux.co.jp>

On Sat, Oct 28, 2023 at 01:29:42AM +0900, Koichiro Den wrote:
> In iopt_area_split(), if the original iopt_area has filled a domain and
> is linked to domains_itree, pages_nodes have to be properly reinserted.

Fixes: 51fe6141f0f6 ("iommufd: Data structure to provide IOVA to PFN mapping")

> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/iommu/iommufd/io_pagetable.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
> index 9f060abe53b6..5ba83296c91a 100644
> --- a/drivers/iommu/iommufd/io_pagetable.c
> +++ b/drivers/iommu/iommufd/io_pagetable.c
> @@ -1220,6 +1220,13 @@ static int iopt_area_split(struct iopt_area *area, unsigned long iova)
>  	if (WARN_ON(rc))
>  		goto err_remove_lhs;
>  
> +	/* If the original area has filled a domain, domains_itree has to be updated. */
> +	if (!RB_EMPTY_NODE(&area->pages_node.rb)) {

This isn't going to work entirely right because we never call
RB_CLEAR_NODE.. Checking area->storage_domain would be appropriate

> +		interval_tree_remove(&area->pages_node, &pages->domains_itree);
> +		interval_tree_insert(&lhs->pages_node, &pages->domains_itree);
> +		interval_tree_insert(&rhs->pages_node, &pages->domains_itree);

But yes, this is needed!!

I investigated for a while how come this doesn't crash already, and it
seems to be a bit because of how rb tree works, that the test never
does an access, and a bit because we never call RB_CLEAR_NODE.

Below improves things, and does make it crash without this change

Anyhow I picked this with the change and below as well, thanks!

From d906a485451dcce445f91aa207f5e724d1bf1e4e Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgg@nvidia.com>
Date: Mon, 30 Oct 2023 11:26:33 -0300
Subject: [PATCH] iommufd: Add iopt_area_alloc()

We never initialize the two interval tree nodes, and zero fill is not the
same as RB_CLEAR_NODE. This can hide issues where we missed adding
the area to the trees. Factor out the allocation and clear the two nodes.

Fixes: 51fe6141f0f6 ("iommufd: Data structure to provide IOVA to PFN mapping")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/io_pagetable.c | 18 +++++++++++++++---
 drivers/iommu/iommufd/pages.c        |  2 ++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 9f060abe53b6c9..87075cbc2c630b 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -222,6 +222,18 @@ static int iopt_insert_area(struct io_pagetable *iopt, struct iopt_area *area,
 	return 0;
 }
 
+static struct iopt_area *iopt_area_alloc(void)
+{
+	struct iopt_area *area;
+
+	area = kzalloc(sizeof(*area), GFP_KERNEL_ACCOUNT);
+	if (!area)
+		return NULL;
+	RB_CLEAR_NODE(&area->node.rb);
+	RB_CLEAR_NODE(&area->pages_node.rb);
+	return area;
+}
+
 static int iopt_alloc_area_pages(struct io_pagetable *iopt,
 				 struct list_head *pages_list,
 				 unsigned long length, unsigned long *dst_iova,
@@ -232,7 +244,7 @@ static int iopt_alloc_area_pages(struct io_pagetable *iopt,
 	int rc = 0;
 
 	list_for_each_entry(elm, pages_list, next) {
-		elm->area = kzalloc(sizeof(*elm->area), GFP_KERNEL_ACCOUNT);
+		elm->area = iopt_area_alloc();
 		if (!elm->area)
 			return -ENOMEM;
 	}
@@ -1177,11 +1189,11 @@ static int iopt_area_split(struct iopt_area *area, unsigned long iova)
 	    iopt_area_start_byte(area, new_start) & (alignment - 1))
 		return -EINVAL;
 
-	lhs = kzalloc(sizeof(*area), GFP_KERNEL_ACCOUNT);
+	lhs = iopt_area_alloc();
 	if (!lhs)
 		return -ENOMEM;
 
-	rhs = kzalloc(sizeof(*area), GFP_KERNEL_ACCOUNT);
+	rhs = iopt_area_alloc();
 	if (!rhs) {
 		rc = -ENOMEM;
 		goto err_free_lhs;
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 8d9aa297c117e4..528f356238b343 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1507,6 +1507,8 @@ void iopt_area_unfill_domains(struct iopt_area *area, struct iopt_pages *pages)
 				area, domain, iopt_area_index(area),
 				iopt_area_last_index(area));
 
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST))
+		WARN_ON(RB_EMPTY_NODE(&area->pages_node.rb));
 	interval_tree_remove(&area->pages_node, &pages->domains_itree);
 	iopt_area_unfill_domain(area, pages, area->storage_domain);
 	area->storage_domain = NULL;
-- 
2.42.0


