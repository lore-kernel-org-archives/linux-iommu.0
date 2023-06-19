Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9203C6FAD
	for <iommu@lists.linux.dev>; Mon, 19 Jun 2023 11:31:31 +0000 (UTC)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-62ffcc309bfso22462336d6.1
        for <iommu@lists.linux.dev>; Mon, 19 Jun 2023 04:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1687174290; x=1689766290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CPLGtiQ9lZoVfMeR+SaSnJg3sKOJv1sdwDyyt+et504=;
        b=i/hTdbUvTYT+rfpf1jx7nqGfX2kftXvk5z+GdC4TdYaOYWP2bYy2DKG68zId4pGnOq
         lC4KxTHzdhEOTsgd0AGKdhMZy20LOPRTK5M48l+KNHyjW2ysp/JIJzc9lzLMregk0kp/
         peTCdXgSero0fatfuCaRJzdHzUSZUUCUUN5ICpXv2ryO+zeRSN6o2A2KqrEn81vBl8aQ
         wsK0+PM+rFl6oKQt0qDXXiqthr4RCRHvvUWpA+wQ+HcrjT9PoqKvWss+Qe6B8M0vF7rz
         WuBYnnNOPxXjJHmKd5jgudbA8JOGqrBBEZmza64lCx2NRLjkgAGLu8uEtv4c4y/8mqun
         7LsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687174290; x=1689766290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPLGtiQ9lZoVfMeR+SaSnJg3sKOJv1sdwDyyt+et504=;
        b=aHuKLP4B/d4RQ/hHfGylluemeCklx80dse1ARTKFkDUK1mkrNrx3h3TVeg7szFZIzH
         L0z6cJ6Wt6ByURc3hjQZw29NDgj3GSKx4qnaHRJjmLIucDd6mn3c8iAh3t0VzkkguXUa
         U2f2KFmr8XXJKYiK4o8nbt/FzPwypBOzHgdEJ1W/Nw3rdR2YSiOP0qH0VKKLeW3To+pL
         Q85QvMkSWpXbV7qS3Y9wz5ENklwQHOIhB5nA7d2TxDUEfeVnvvXZoNul9VS4RxnXDs84
         IK8j+EgyB4JsnmIrKKSDOIzd1XxXzP6JMmGlL44cJUAiIq2+2SxRwuJuhrSG8yu/P1xD
         Mg4A==
X-Gm-Message-State: AC+VfDyxIY8cpdsXQrMJNeCxFc5jqQhrWLy5kWr6+NNYmZEubIhsU0NQ
	qUvGLtDH7GsZJ+m2btw8whrC4w==
X-Google-Smtp-Source: ACHHUZ5J3sr8Q0+mMsULTkbj8c7IzIJDkx8JgI6zUQ4xAj+4gaRpaE3jSTx0pmat9I0dp07/mXCKmQ==
X-Received: by 2002:ad4:5c81:0:b0:62d:fd62:45fa with SMTP id o1-20020ad45c81000000b0062dfd6245famr14327347qvh.54.1687174290195;
        Mon, 19 Jun 2023 04:31:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id a29-20020a0cb35d000000b006263a9e7c63sm10253511qvf.104.2023.06.19.04.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 04:31:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qBD6W-006gI2-Rk;
	Mon, 19 Jun 2023 08:31:28 -0300
Date: Mon, 19 Jun 2023 08:31:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	baolu.lu@linux.intel.com,
	Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Subject: Re: [PATCH v2 iommu/next] iommu: Fix default domain setup
Message-ID: <ZJA8kDBSuNfbMPxr@ziepe.ca>
References: <20230619084945.6427-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619084945.6427-1-vasant.hegde@amd.com>

On Mon, Jun 19, 2023 at 08:49:45AM +0000, Vasant Hegde wrote:
> Commit 1000dccd5d13 ("iommu: Allow IOMMU_RESV_DIRECT to work on ARM")
> accidently restored "group->domain" to "old_domain" while keeping
> "group->default_domain" to new domain. Also freed new domain.
> 
> This works fine during boot as 'old_domain' is NULL. But if we try
> change domain via sysfs using below command then kernel crashes with
> "kernel NULL pointer dereference".

There is more wrong here then.. The error unwind should work even if
we do it at the wrong time.

Like this?

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8f3464ba204498..6fb4533905c37b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2960,14 +2960,11 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 		ret = __iommu_group_set_domain_internal(
 			group, dom, IOMMU_SET_DOMAIN_MUST_SUCCEED);
 		if (WARN_ON(ret))
-			goto out_free;
+			goto out_free_old;
 	} else {
 		ret = __iommu_group_set_domain(group, dom);
-		if (ret) {
-			iommu_domain_free(dom);
-			group->default_domain = old_dom;
-			return ret;
-		}
+		if (ret)
+			goto err_restore_def_domain;
 	}
 
 	/*
@@ -2980,21 +2977,25 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 		for_each_group_device(group, gdev) {
 			ret = iommu_create_device_direct_mappings(dom, gdev->dev);
 			if (ret)
-				goto err_restore;
+				goto err_restore_domain;
 		}
 	}
 
-err_restore:
-	if (old_dom) {
-		__iommu_group_set_domain_internal(
-			group, old_dom, IOMMU_SET_DOMAIN_MUST_SUCCEED);
-		iommu_domain_free(dom);
-		old_dom = NULL;
-	}
-out_free:
+out_free_old:
 	if (old_dom)
 		iommu_domain_free(old_dom);
 	return ret;
+
+err_restore_domain:
+	if (old_dom)
+		__iommu_group_set_domain_internal(
+			group, old_dom, IOMMU_SET_DOMAIN_MUST_SUCCEED);
+err_restore_def_domain:
+	if (old_dom) {
+		iommu_domain_free(dom);
+		group->default_domain = old_dom;
+	}
+	return ret;
 }
 
 /*
