Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A4CC43334
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 09:44:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EC473417D8;
	Tue, 28 Jun 2022 09:44:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EC473417D8
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=eCCsODKy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b-8cFbYs0Grr; Tue, 28 Jun 2022 09:44:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5C4274090F;
	Tue, 28 Jun 2022 09:44:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5C4274090F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26CEBC0032;
	Tue, 28 Jun 2022 09:44:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21C75C002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 09:44:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F0F7E824C1
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 09:44:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F0F7E824C1
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=eCCsODKy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7wtcKytKb26Q for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 09:44:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0A219819C8
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0A219819C8
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 09:44:35 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 l2-20020a05600c4f0200b0039c55c50482so9094021wmq.0
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 02:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=wi1R/bUTiY7+3hGQ5VIW8xv0nt+HW5ohTHS2cOsUuxA=;
 b=eCCsODKyUzUbN1l+lGklBxP8DoyEl8UmwdVrUn6DZyD9ii78730U+Cbd30f/zxSYeI
 yCiAHujMhO733mZ5V6alMA8quWRk1Pf5nh1HVEohYgs3Gja59ggRrPil6gz/kA+3tXX1
 A4lhouHwDfP9cSkOeBmKou4+fC1/rLn0QJhxTThQtXEV/LHO564Di3ht8/rwb+q0l4f/
 LAwjukId2/g9qceJansG1tgOOMtQ+w8le1lsc3ODF9mnJaMHi60ySGLEEN5+Ge3AKlba
 LaWoebxIcMycIJgzd5O+WwYc7juwHC+e6SmYoZgOgMU7SArd7RwqeY+9M7IamZd5NPKg
 Rtrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wi1R/bUTiY7+3hGQ5VIW8xv0nt+HW5ohTHS2cOsUuxA=;
 b=lssjLZBaeFUl5iQ3hi3kOZ/XB/C/BV1iP4ItxRpob9wUknmV12JxnxLmemXP3+evCp
 /Qat+YASY/hqqhT/UMkFqGQ36XPYdNqTNvaJsqpG8lGNJ/waG48KzNwKDpLGhAzuSiDW
 9nDYoEJwPsLEX4IyliiVSWmP0NdhQmMlE00KX2ZdY8JQLYoktdJew2X10LweMpw23Us4
 KAGUFDBlAZo6wYmXjkVhVluQGXep9PfU235aig80CsvY4ESf7aJmSmtDbX6qOnmqUEbU
 aHvFSuw74LZaqzmWYsAgOLFKodcARbYT7nY0OUsOVxOmM75aPBiqtakB3kRJAtLz7nzr
 fcXQ==
X-Gm-Message-State: AJIora+EA5BgCwDcRHmB157jlrdQXIO3I4w4JFe+WlyJOOAAr/tmjv/2
 imKWsiGFIW2Oe/n0nErszDnA0g==
X-Google-Smtp-Source: AGRyM1uc+0wZLX7veWfVUWspRrMtzkpH+FPfFbZjdcbIISE//UQJ0kznPtVc7bKy9D8Gn6FVxMQfGQ==
X-Received: by 2002:a05:600c:1d0e:b0:3a0:50bb:55e0 with SMTP id
 l14-20020a05600c1d0e00b003a050bb55e0mr4035158wms.89.1656409474286; 
 Tue, 28 Jun 2022 02:44:34 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 j9-20020a05600c1c0900b0039c7f790f6asm22093111wms.30.2022.06.28.02.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jun 2022 02:44:33 -0700 (PDT)
Date: Tue, 28 Jun 2022 10:44:10 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v9 10/11] iommu: Per-domain I/O page fault handling
Message-ID: <YrrNarTWvMydIDwQ@myrica>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-11-baolu.lu@linux.intel.com>
 <BN9PR11MB52768181B0EB29DBCB11AEA68CB89@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52768181B0EB29DBCB11AEA68CB89@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: "Jiang, Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Robin Murphy <robin.murphy@arm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Vinod Koul <vkoul@kernel.org>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>
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

On Tue, Jun 28, 2022 at 08:39:36AM +0000, Tian, Kevin wrote:
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> > Sent: Tuesday, June 21, 2022 10:44 PM
> > 
> > Tweak the I/O page fault handling framework to route the page faults to
> > the domain and call the page fault handler retrieved from the domain.
> > This makes the I/O page fault handling framework possible to serve more
> > usage scenarios as long as they have an IOMMU domain and install a page
> > fault handler in it. Some unused functions are also removed to avoid
> > dead code.
> > 
> > The iommu_get_domain_for_dev_pasid() which retrieves attached domain
> > for a {device, PASID} pair is used. It will be used by the page fault
> > handling framework which knows {device, PASID} reported from the iommu
> > driver. We have a guarantee that the SVA domain doesn't go away during
> > IOPF handling, because unbind() waits for pending faults with
> > iopf_queue_flush_dev() before freeing the domain. Hence, there's no need
> > to synchronize life cycle of the iommu domains between the unbind() and
> > the interrupt threads.
> 
> I found iopf_queue_flush_dev() is only called in intel-iommu driver. Did
> I overlook anything?

The SMMU driver will need it as well when we upstream PRI support.
Currently it only supports stall, and that requires the device driver to
flush all DMA including stalled transactions *before* calling unbind(), so
ne need for iopf_queue_flush_dev() in this case.

Thanks,
Jean

> 
> >  static void iopf_handle_group(struct work_struct *work)
> >  {
> >  	struct iopf_group *group;
> > +	struct iommu_domain *domain;
> >  	struct iopf_fault *iopf, *next;
> >  	enum iommu_page_response_code status =
> > IOMMU_PAGE_RESP_SUCCESS;
> > 
> >  	group = container_of(work, struct iopf_group, work);
> > +	domain = iommu_get_domain_for_dev_pasid(group->dev,
> > +				group->last_fault.fault.prm.pasid);
> > +	if (!domain || !domain->iopf_handler)
> > +		status = IOMMU_PAGE_RESP_INVALID;
> 
> Miss a comment on why no refcnt is required on domain as explained
> in the commit msg.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
