Return-Path: <SRS0=BxgK=4Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F65C3F2D2
	for <iommu@archiver.kernel.org>; Fri, 28 Feb 2020 14:43:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1631246A3
	for <iommu@archiver.kernel.org>; Fri, 28 Feb 2020 14:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LFAojzvb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1631246A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9027581E3C;
	Fri, 28 Feb 2020 14:43:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VQge2Nt9RAGK; Fri, 28 Feb 2020 14:43:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D543D815BC;
	Fri, 28 Feb 2020 14:43:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1EF3C08A0;
	Fri, 28 Feb 2020 14:43:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 907AFC0177
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 14:43:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7BF1A2036C
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 14:43:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iW0ytzFFH0yf for <iommu@lists.linux-foundation.org>;
 Fri, 28 Feb 2020 14:43:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by silver.osuosl.org (Postfix) with ESMTPS id DBE4F2014B
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 14:43:13 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id z15so3260419wrl.1
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 06:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=qBpilYEWq2t+l8+AOrjDoZbJdmvWTjFRjglgj0Qxg8I=;
 b=LFAojzvb8+bNMCU7cSiB3vXcCDnY1zZdvnUhwLqZilVnqW9kL5OnILTiAzuTdyRtJx
 qe+XQElAl/2IL/JqCqkGz/fluhOqodjABtbuisRhl/NfHWngs773n7qtR7EWdGfKTKzF
 OQ5tWMN4+uPwzyxwoEOCPzkgZ87HVi9wFiYbKsumPoJ5SJ63TMDuzzR8z8r175jC3XDo
 2JEyaVpyR2jqIqIjQPF7g0Lbx2PmFTUqNexlxLmA3fnn35L8UgGDScg4qebKAC2KLt8a
 343+w8RyA5UHCZ+0xlPFW/v9fCEy58w7rqdgs7gk3WfRlZ3QK6OlQOvWUiyI1wLu7QMw
 QiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qBpilYEWq2t+l8+AOrjDoZbJdmvWTjFRjglgj0Qxg8I=;
 b=pJ5MuZXNHN7zzQbooXfLmPaaHcwr43SL9zgu5iWQV4kwDRbDzbGCKlT2P2H82VhoP3
 Xtr5pdh24JaxNyqhOG1cSFdVDkY7J29fLgptlozYdjXAw2jRU977k7loC4JUfwEReMzF
 402mtu6JdT6zGlUvQ3YGnS/vyNlbMgZPkMp047oFumLh47fr0PFipE+HwnV1BhUFlNOo
 kiRnC/nt8yyA8lyI3d6LzfufFFt/3o8PbCZ2tnS/Qdx9nSmv3SL+SnGqZY+Psv3vmaDO
 aSPwJLOY1ouIoJrPbHY3LHBEmQQ6kq3PRfAFSywbCR6y3YFNFEHvk9pHmsaSKYacQTm1
 yEHA==
X-Gm-Message-State: APjAAAUvKQW+YZD/s2ddV7OdIqMHaX/Nb6ELU1vMtRfiDaroxkBBfzwK
 VOLGblKH0ajFGF9GIcxW1YAYpg==
X-Google-Smtp-Source: APXvYqzoxcpHfodMdyiHU+ccf1iNtP76SMhYvRYWjjQPlYBvWNyIzTVjKSiBL7Zis29LI/cnQRDe/w==
X-Received: by 2002:adf:8382:: with SMTP id 2mr4851994wre.243.1582900991687;
 Fri, 28 Feb 2020 06:43:11 -0800 (PST)
Received: from myrica ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id t10sm12750189wru.59.2020.02.28.06.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 06:43:11 -0800 (PST)
Date: Fri, 28 Feb 2020 15:43:04 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v4 02/26] iommu/sva: Manage process address spaces
Message-ID: <20200228144304.GC2156@myrica>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
 <20200224182401.353359-3-jean-philippe@linaro.org>
 <20200226123506.000076fb@Huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200226123506.000076fb@Huawei.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, kevin.tian@intel.com,
 Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
 linux-pci@vger.kernel.org, robin.murphy@arm.com, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org, catalin.marinas@arm.com,
 zhangfei.gao@linaro.org, will@kernel.org, christian.koenig@amd.com,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Feb 26, 2020 at 12:35:06PM +0000, Jonathan Cameron wrote:
> > + * A single Process Address Space ID (PASID) is allocated for each mm. In the
> > + * example, devices use PASID 1 to read/write into address space X and PASID 2
> > + * to read/write into address space Y. Calling iommu_sva_get_pasid() on bond 1
> > + * returns 1, and calling it on bonds 2-4 returns 2.
> > + *
> > + * Hardware tables describing this configuration in the IOMMU would typically
> > + * look like this:
> > + *
> > + *                                PASID tables
> > + *                                 of domain A
> > + *                              .->+--------+
> > + *                             / 0 |        |-------> io_pgtable
> > + *                            /    +--------+
> > + *            Device tables  /   1 |        |-------> pgd X
> > + *              +--------+  /      +--------+
> > + *      00:00.0 |      A |-'     2 |        |--.
> > + *              +--------+         +--------+   \
> > + *              :        :       3 |        |    \
> > + *              +--------+         +--------+     --> pgd Y
> > + *      00:01.0 |      B |--.                    /
> > + *              +--------+   \                  |
> > + *      00:01.1 |      B |----+   PASID tables  |
> > + *              +--------+     \   of domain B  |
> > + *                              '->+--------+   |
> > + *                               0 |        |-- | --> io_pgtable
> > + *                                 +--------+   |
> > + *                               1 |        |   |
> > + *                                 +--------+   |
> > + *                               2 |        |---'
> > + *                                 +--------+
> > + *                               3 |        |
> > + *                                 +--------+
> > + *
> > + * With this model, a single call binds all devices in a given domain to an
> > + * address space. Other devices in the domain will get the same bond implicitly.
> > + * However, users must issue one bind() for each device, because IOMMUs may
> > + * implement SVA differently. Furthermore, mandating one bind() per device
> > + * allows the driver to perform sanity-checks on device capabilities.
> 
> > + *
> > + * In some IOMMUs, one entry of the PASID table (typically the first one) can
> > + * hold non-PASID translations. In this case PASID 0 is reserved and the first
> > + * entry points to the io_pgtable pointer. In other IOMMUs the io_pgtable
> > + * pointer is held in the device table and PASID 0 is available to the
> > + * allocator.
> 
> Is it worth hammering home in here that we can only do this because the PASID space
> is global (with exception of PASID 0)?  It's a convenient simplification but not
> necessarily a hardware restriction so perhaps we should remind people somewhere in here?

I could add this four paragraphs up:

"A single Process Address Space ID (PASID) is allocated for each mm. It is
a choice made for the Linux SVA implementation, not a hardware
restriction."

> > + */
> > +
> > +struct io_mm {
> > +	struct list_head		devices;
> > +	struct mm_struct		*mm;
> > +	struct mmu_notifier		notifier;
> > +
> > +	/* Late initialization */
> > +	const struct io_mm_ops		*ops;
> > +	void				*ctx;
> > +	int				pasid;
> > +};
> > +
> > +#define to_io_mm(mmu_notifier)	container_of(mmu_notifier, struct io_mm, notifier)
> > +#define to_iommu_bond(handle)	container_of(handle, struct iommu_bond, sva)
> 
> Code ordering wise, do we want this after the definition of iommu_bond?
> 
> For both of these it's a bit non obvious what they come 'from'.
> I wouldn't naturally assume to_io_mm gets me from notifier to the io_mm
> for example.  Not sure it matters though if these are only used in a few
> places.

Right, I can rename the first one to mn_to_io_mm(). The second one I think
might be good enough.


> > +static struct iommu_sva *
> > +io_mm_attach(struct device *dev, struct io_mm *io_mm, void *drvdata)
> > +{
> > +	int ret = 0;
> 
> I'm fairly sure this is set in all paths below.  Now, of course the
> compiler might not think that in which case fair enough :)
> 
> > +	bool attach_domain = true;
> > +	struct iommu_bond *bond, *tmp;
> > +	struct iommu_domain *domain, *other;
> > +	struct iommu_sva_param *param = dev->iommu_param->sva_param;
> > +
> > +	domain = iommu_get_domain_for_dev(dev);
> > +
> > +	bond = kzalloc(sizeof(*bond), GFP_KERNEL);
> > +	if (!bond)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	bond->sva.dev	= dev;
> > +	bond->drvdata	= drvdata;
> > +	refcount_set(&bond->refs, 1);
> > +	RCU_INIT_POINTER(bond->io_mm, io_mm);
> > +
> > +	mutex_lock(&iommu_sva_lock);
> > +	/* Is it already bound to the device or domain? */
> > +	list_for_each_entry(tmp, &io_mm->devices, mm_head) {
> > +		if (tmp->sva.dev != dev) {
> > +			other = iommu_get_domain_for_dev(tmp->sva.dev);
> > +			if (domain == other)
> > +				attach_domain = false;
> > +
> > +			continue;
> > +		}
> > +
> > +		if (WARN_ON(tmp->drvdata != drvdata)) {
> > +			ret = -EINVAL;
> > +			goto err_free;
> > +		}
> > +
> > +		/*
> > +		 * Hold a single io_mm reference per bond. Note that we can't
> > +		 * return an error after this, otherwise the caller would drop
> > +		 * an additional reference to the io_mm.
> > +		 */
> > +		refcount_inc(&tmp->refs);
> > +		io_mm_put(io_mm);
> > +		kfree(bond);
> 
> Free outside the lock would be ever so slightly more logical given we allocated
> before taking the lock.
> 
> > +		mutex_unlock(&iommu_sva_lock);
> > +		return &tmp->sva;
> > +	}
> > +
> > +	list_add_rcu(&bond->mm_head, &io_mm->devices);
> > +	param->nr_bonds++;
> > +	mutex_unlock(&iommu_sva_lock);
> > +
> > +	ret = io_mm->ops->attach(bond->sva.dev, io_mm->pasid, io_mm->ctx,
> > +				 attach_domain);
> > +	if (ret)
> > +		goto err_remove;
> > +
> > +	return &bond->sva;
> > +
> > +err_remove:
> > +	/*
> > +	 * At this point concurrent threads may have started to access the
> > +	 * io_mm->devices list in order to invalidate address ranges, which
> > +	 * requires to free the bond via kfree_rcu()
> > +	 */
> > +	mutex_lock(&iommu_sva_lock);
> > +	param->nr_bonds--;
> > +	list_del_rcu(&bond->mm_head);
> > +
> > +err_free:
> > +	mutex_unlock(&iommu_sva_lock);
> > +	kfree_rcu(bond, rcu_head);
> 
> I don't suppose it matters really but we don't need the rcu free if
> we follow the err_free goto.  Perhaps we are cleaner in this case
> to not use a unified exit path but do that case inline?

Agreed, though I moved the kzalloc() later as suggested by Jacob, I think
it looks a little better and simplifies the error paths

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
