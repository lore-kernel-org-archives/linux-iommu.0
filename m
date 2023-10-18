Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CBA31A86
	for <iommu@lists.linux.dev>; Wed, 18 Oct 2023 16:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eo+X9nQk"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5a81ab75f21so69790677b3.2
        for <iommu@lists.linux.dev>; Wed, 18 Oct 2023 09:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1697645961; x=1698250761; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aEBRhObNmbrXOo55vTi5+G40xk3z5o+PBikMxvbjN7A=;
        b=eo+X9nQk38MMeq2UXKykH37dc+c8iAAQ+DaEWfbKaBYdl2qHvGRcGwGpziCIZcbuFo
         wAUver3yR/E7qRghITCQlZ8UnWJeTdDGb506Q1SjysKBtZW+bE5xWvph73qTqVbV1fHr
         eRrXdFs5udUpgtkH1LhgWXzyzZ2xY770uKNcC4DAmRHKSq4kJrVM4dZCukfKjsvQNSUR
         Vdu/2NShQ77pxv8Eb5Ab4UHOYdVn81uhrpv9h1cEk4Dc56Fw8WbUoefi4dlbRSjsiCZQ
         r1be2ajYR/wnJCQ/pBFNTaMzVAhuRomzlMrSyc0Bg5btTPa4Ml/bRVrtFHyLg/qlREuc
         HHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697645961; x=1698250761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEBRhObNmbrXOo55vTi5+G40xk3z5o+PBikMxvbjN7A=;
        b=kjb6rvZyuwPTMq8LVeBDZ0u6XrZk5UhErqZ7TPmhYuzoGoMIUu0FN4pGmWPmm7e54Z
         Of1yJW7jpyXhlinmHavX8/KzPbjYNXXDwM3WIhzC3Am3enN/23QkDC5j9Q6/d+8bADL3
         xFIAl6SawVT7vV/F77NfoJYVmhZq5i17jR0LtOO0hyUMfwogBKFVEbDzsSb8VjTbVI/F
         JbiSry5aQOaKjE7h0HLbfSyLEG1rBA8vWswc7jiOkhLW9Pe6lCLF3X/9lBJ//Zstomq0
         bH2CUi7RMS1CZtwhrzgK9QYU3f8YDEd2nkfmjRp+MaHtvpzej50yqgBPfUTcJ/W/y+g0
         c9YQ==
X-Gm-Message-State: AOJu0YwWRLSqQV4/DYbutxlLUzGKJij7p8qwWExBK5IyyqoH7eBGl0r8
	6sE63/iZhWlU6feNhQmB3SZ7/g==
X-Google-Smtp-Source: AGHT+IHPlPAWW/cHLF6dkefYjVQHPy2wMPgOd2XGTlFeR7Bd0Sulo6mXnsUh5sgMaM3EX0gNIJTINQ==
X-Received: by 2002:a81:c30d:0:b0:5a7:c4a7:21c3 with SMTP id r13-20020a81c30d000000b005a7c4a721c3mr6365606ywk.38.1697645961207;
        Wed, 18 Oct 2023 09:19:21 -0700 (PDT)
Received: from ziepe.ca ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id u70-20020a0deb49000000b005956b451fb8sm1593919ywe.100.2023.10.18.09.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 09:19:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qt9GQ-0030Tr-Nk;
	Wed, 18 Oct 2023 13:19:18 -0300
Date: Wed, 18 Oct 2023 13:19:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Zhenhua Huang <quic_zhenhuah@quicinc.com>, will@kernel.org,
	joro@8bytes.org, baolu.lu@linux.intel.com, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, quic_tingweiz@quicinc.com
Subject: Re: [ARM IOMMU] IOMMU framework concurrency issue
Message-ID: <20231018161918.GB691768@ziepe.ca>
References: <e2e20e1c-6450-4ac5-9804-b0000acdf7de@quicinc.com>
 <20231017163337.GE282036@ziepe.ca>
 <70cc8d3d-1ddf-4700-ac15-bcd74fae2b2a@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70cc8d3d-1ddf-4700-ac15-bcd74fae2b2a@arm.com>

On Wed, Oct 18, 2023 at 04:34:20PM +0100, Robin Murphy wrote:
> On 2023-10-17 17:33, Jason Gunthorpe wrote:
> >
> > eg make sure the iommu driver is fully registered before allowing any
> > concurrent probes. Once the iommu driver is registered it will be able
> > to catch the bus notifiers and serialize things properly.
> 
> Ugh, I think I see at least how this happens for device which *don't* have
> an IOMMU - because iommu_init_device() has to transiently allocate
> dev->iommu in order to call ops->probe_device in order to discover
> that the

Hmm! Is it essential though? That ordering was C&P from before, I
didn't study it closely when I copied it..

I only checked some drivers, but something like this looked like it
could resolve the situation you described - Zhenhua is that your
situation, a non-probed device?

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 47172f1084d8fd..580e74afdb0765 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -386,6 +386,16 @@ static u32 dev_iommu_get_max_pasids(struct device *dev)
 	return min_t(u32, max_pasids, dev->iommu->iommu_dev->max_pasids);
 }
 
+void dev_iommu_priv_set(struct device *dev, void *priv)
+{
+	struct dev_iommu *dev_iommu;
+
+	dev_iommu = dev_iommu_get(dev);
+	if (WARN_ON(!dev_iommu))
+		return; // FIXME handle failure in drivers
+	dev->iommu->priv = priv;
+}
+
 /*
  * Init the dev->iommu and dev->iommu_group in the struct device and get the
  * driver probed
@@ -393,12 +403,10 @@ static u32 dev_iommu_get_max_pasids(struct device *dev)
 static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
 {
 	struct iommu_device *iommu_dev;
+	struct dev_iommu *dev_iommu;
 	struct iommu_group *group;
 	int ret;
 
-	if (!dev_iommu_get(dev))
-		return -ENOMEM;
-
 	if (!try_module_get(ops->owner)) {
 		ret = -EINVAL;
 		goto err_free;
@@ -409,7 +417,14 @@ static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
 		ret = PTR_ERR(iommu_dev);
 		goto err_module_put;
 	}
-	dev->iommu->iommu_dev = iommu_dev;
+
+	dev_iommu = dev_iommu_get(dev);
+	if (WARN_ON(!dev_iommu)) {
+		ret = -ENOMEM;
+		goto err_release;
+	}
+
+	dev_iommu->iommu_dev = iommu_dev;
 
 	ret = iommu_device_link(iommu_dev, dev);
 	if (ret)
@@ -424,9 +439,9 @@ static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
 	}
 	dev->iommu_group = group;
 
-	dev->iommu->max_pasids = dev_iommu_get_max_pasids(dev);
+	dev_iommu->max_pasids = dev_iommu_get_max_pasids(dev);
 	if (ops->is_attach_deferred)
-		dev->iommu->attach_deferred = ops->is_attach_deferred(dev);
+		dev_iommu->attach_deferred = ops->is_attach_deferred(dev);
 	return 0;
 
 err_unlink:
@@ -438,7 +453,11 @@ static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
 	module_put(ops->owner);
 err_free:
 	dev->iommu->iommu_dev = NULL;
-	dev_iommu_free(dev);
+	/*
+	 * If probe_device allocated a dev->iommu and things failed later
+	 * we just leave it. We don't yet have robust locking, there
+	 * could be concurrent users.
+	 */
 	return ret;
 }
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 68c9be9293e4c0..5c25c378a13ece 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -713,10 +713,7 @@ static inline void *dev_iommu_priv_get(struct device *dev)
 		return NULL;
 }
 
-static inline void dev_iommu_priv_set(struct device *dev, void *priv)
-{
-	dev->iommu->priv = priv;
-}
+void dev_iommu_priv_set(struct device *dev, void *priv);
 
 int iommu_probe_device(struct device *dev);
 
