Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF20C433FE
	for <iommu@archiver.kernel.org>; Mon, 24 Jan 2022 10:16:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F6D5401FE;
	Mon, 24 Jan 2022 10:16:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9hjEr8xxCqFA; Mon, 24 Jan 2022 10:16:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0C080403C8;
	Mon, 24 Jan 2022 10:16:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD7EDC0039;
	Mon, 24 Jan 2022 10:16:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ABF41C002F
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 10:16:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 932D0401FE
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 10:16:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jm4o6gdT26WT for <iommu@lists.linux-foundation.org>;
 Mon, 24 Jan 2022 10:16:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 684F0400CB
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 10:16:31 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id c2so22559801wml.1
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 02:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ojZJfUHtm9ovOFBOfA3TS4i8XJuJzbk79ufS2uBVn1k=;
 b=avLmskQetnZLKS5POUDQ2emSgSxJP5gcaKobddCdXaX5XQR+TWhvS/hzwwNKCwC8rn
 oFFjf9l4z1YaETQpoK/vV9EvVjFQzb257aXYGPS7bVURv2toU4x9sZHaqJvfNC16FVuL
 Xo9e/lqUTA7XhuPdWxVSqljH4zcKUV3HGD6OGX18wzRBdWbMeI5KwKsSFPcqt6WM5tfC
 ti8vt1E9MNPepWL0kyFg2l9zFBDatbyVdYsMScFR9iM/NUBttzZ4tlaPVtvXkGIoG+IT
 wbXClwtS/a5uZ+Aq0lzabLrQdz2BPA+nSjem+g9wZZBfnDsLB8447OhCSx9OLu+8pIfP
 +euA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ojZJfUHtm9ovOFBOfA3TS4i8XJuJzbk79ufS2uBVn1k=;
 b=QBog+garKrb4ga3X0dcgtc7jEQ3zqIO7Y7p+Thceea0/NqUY34Fv8jomnX/aVBZDya
 SwPZ2s7lcX+Ibi5E6FQ29BIA/81M7N11tg4x1kQlOeWCXApwsxcTI8Gvdn29MyCdqBeu
 fCAjLndf6Emc8tmnqTa13zydAAVKXmOkdtiOJqKjZ+cBA0aSM2u/IF3gT1AudtSHEby4
 IIR3pHpgG70ai8sPC49cPVXjMEIPd1YH7FYe5ZC48PLpsKbLeFqWL0g4V7nObyMYqEn6
 pbZxJwp4TlSH906JENOOErwyH0qzrb/ZlODatUQET7UbsY/SgX9Z+aqw6rmT2zMlIW3W
 mmkQ==
X-Gm-Message-State: AOAM532fQaw3eww1gq539XLELGDqd8JH4qR4c+vEAOExuZBC2YNcIH0t
 Z3E+OSpVB7QDcb5YRtNtofhgNQ==
X-Google-Smtp-Source: ABdhPJzTyJ37K64BBQ+VM4xpU821ze6oPztog2El56Hbio1gSm89H/59lEo4Gs8K2NJwJCfoSu3rEw==
X-Received: by 2002:a1c:7312:: with SMTP id d18mr1171835wmb.130.1643019389594; 
 Mon, 24 Jan 2022 02:16:29 -0800 (PST)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id r7sm17548515wma.39.2022.01.24.02.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jan 2022 02:16:29 -0800 (PST)
Date: Mon, 24 Jan 2022 10:16:07 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH 7/7] iommu: Add iommu_domain::domain_ops
Message-ID: <Ye58Zxi+F9TQszgQ@myrica>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-8-baolu.lu@linux.intel.com>
 <BN9PR11MB5276BE30652988271878E78C8C5E9@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276BE30652988271878E78C8C5E9@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, David Airlie <airlied@linux.ie>,
 Robin Murphy <robin.murphy@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Thierry Reding <thierry.reding@gmail.com>, Ben Skeggs <bskeggs@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Daniel Vetter <daniel@ffwll.ch>,
 Will Deacon <will@kernel.org>
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

On Mon, Jan 24, 2022 at 09:58:18AM +0000, Tian, Kevin wrote:
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> > Sent: Monday, January 24, 2022 3:11 PM
> > +/**
> > + * struct domain_ops - per-domain ops
> > + * @attach_dev: attach an iommu domain to a device
> > + * @detach_dev: detach an iommu domain from a device
> 
> What is the criteria about whether an op should be iommu_ops or domain_ops
> when it requires both domain and device pointers like above two (and future
> PASID-based attach)?
> 
> Other examples include:
> 	@apply_resv_region
> 	@is_attach_deferred

Could attach_dev() be an IOMMU op?  So a driver could set the domain ops
in attach_dev() rather than domain_alloc(). That would allow to install
map()/unmap() ops that are tailored for the device's IOMMU, which we don't
know at domain_alloc() time. I'm thinking about a guest that has both
physical and virtual endpoints, which would ideally use different kinds of
domain ops to support both efficiently (caching mode vs page tables)

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
