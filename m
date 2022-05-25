Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA8EC433EF
	for <iommu@archiver.kernel.org>; Wed, 25 May 2022 07:30:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0ABEA84026;
	Wed, 25 May 2022 07:30:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u1GQjeI_vHwj; Wed, 25 May 2022 07:30:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BA3BA8402A;
	Wed, 25 May 2022 07:30:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6572AC0032;
	Wed, 25 May 2022 07:30:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FDD1C002D
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 07:30:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 26C85612BF
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 07:30:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iMJZsbiWOwzZ for <iommu@lists.linux-foundation.org>;
 Wed, 25 May 2022 07:30:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 42DD2612BB
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 07:30:16 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id jx22so26446692ejb.12
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 00:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Fka4U6j+4zi9FbIDyA05x8GB1WOLwNpWSqnnKjoitMg=;
 b=oHhiDqqjJeC/j21AryPAJw+WSqZB6TeRWYeIE7HKoSC+q9ja0g9HSBtnvBHMYu/4qK
 GzhRInTPX2MGtp94iRzu8dw3QhI5MhKJQTalAlQ6dviuvCCuubtzBaO6QX1IKKbSNbcd
 4Xbl3bMgqUoRswyFyuY+SGAzfrlG8dOOQqN62WA0cEhXzpohiCk/47gqpCEVxQwEEcmy
 hwYBLsRsF48EpqUqYVAooTr+CVUgZ68Xngs+fIZAodyUh68Bak1MYSTwbwQk9lesQzFG
 BUyXQpf8bEre+tzSh8SxbBN8eCpcT4xtFd2Ueyz+oaZbXvk6evEIWxJ5qJgI/PkSyR4N
 tPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Fka4U6j+4zi9FbIDyA05x8GB1WOLwNpWSqnnKjoitMg=;
 b=NUcALudlUBE1ol0z9BWC3mnSbA+687Trzf2mGAw4VFbD1zkOg8sMILrP9TMboY1MOU
 bK2x5wQAl0radcMlXHyMNONPBT3uykcgdjn8Q3nEbieQyIvsX/RVxxBzmsqwnUyJdYDQ
 3oshRPsfUuA7mJC8OCPEiQf8JO55X2/H28aZ46yQeHW0QH2LKmmclbA3+6mgW4VM2WC8
 RvKt8PACxNfcIn3ZBCXL0LDaE4+xvWracoGWntvF9zRucoQgHDN6SVmBQ3+6xkbcNSNO
 pqnXhyeV0DgL9DV9O3U9Oh1c1k8xtw73O0OoOIpfPDDA7kkobvtnzGBVDmQ/WuXUbVxu
 yPgQ==
X-Gm-Message-State: AOAM531MeJf14FV8OmXDRyhMBYZa9QcNbnpS+WkYdr8j/W9uy0EZCsVE
 /ApXlQnQSH787BY8Pmu2wHy7EA==
X-Google-Smtp-Source: ABdhPJwerQ5UGQoKT85YJagGsyI2jp+UwkrVV45C7cSVfQ1QlsOOd4R9jUTNP0VovEJ5Sp184Cn4/Q==
X-Received: by 2002:a17:907:d86:b0:6ff:1557:a080 with SMTP id
 go6-20020a1709070d8600b006ff1557a080mr770913ejc.678.1653463814422; 
 Wed, 25 May 2022 00:30:14 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 q14-20020a50c34e000000b0042ba8658d1csm1095864edb.73.2022.05.25.00.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 May 2022 00:30:14 -0700 (PDT)
Date: Wed, 25 May 2022 08:29:49 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v7 06/10] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Message-ID: <Yo3a7U9kSaSzagkX@myrica>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-7-baolu.lu@linux.intel.com>
 <BN9PR11MB5276E462E3B32DDE54DD66418CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Yoy6NxroLLZup0sE@myrica>
 <BN9PR11MB5276FF0D52CF82942CB84D608CD69@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276FF0D52CF82942CB84D608CD69@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: "Jiang, Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
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

On Wed, May 25, 2022 at 02:04:49AM +0000, Tian, Kevin wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Sent: Tuesday, May 24, 2022 6:58 PM
> > 
> > On Tue, May 24, 2022 at 10:22:28AM +0000, Tian, Kevin wrote:
> > > > From: Lu Baolu <baolu.lu@linux.intel.com>
> > > > Sent: Thursday, May 19, 2022 3:21 PM
> > > >
> > > > The existing iommu SVA interfaces are implemented by calling the SVA
> > > > specific iommu ops provided by the IOMMU drivers. There's no need for
> > > > any SVA specific ops in iommu_ops vector anymore as we can achieve
> > > > this through the generic attach/detach_dev_pasid domain ops.
> > >
> > > set/block_pasid_dev, to be consistent.
> > >
> > > > +
> > > > +	mutex_lock(&iommu_sva_lock);
> > > > +	/* Search for an existing domain. */
> > > > +	domain = iommu_get_domain_for_dev_pasid(dev, mm->pasid);
> > > > +	if (domain) {
> > > > +		sva_domain = to_sva_domain(domain);
> > > > +		refcount_inc(&sva_domain->bond.users);
> > > > +		goto out_success;
> > > > +	}
> > > > +
> > >
> > > why would one device/pasid be bound to a mm more than once?
> > 
> > Device drivers can call bind() multiple times for the same device and mm,
> > for example if one process wants to open multiple accelerator queues.
> > 
> 
> Is it clearer to have a sva_bond_get/put() pair instead of calling
> bind() multiple times here? 

I don't think it's clearer, and it would force device drivers to keep
track of {dev, mm} pairs, when the IOMMU subsystem already does that.
At the moment a device driver calls

	bond = iommu_sva_bind_device(dev, mm)

for each ADI that it wants to assign to userspace. If a process happens to
want multiple ADIs on one device, then the {dev, mm} parameters are the
same and bind() returns the same bond. Since the IOMMU driver needs to
track these anyway, it might as well refcount them.

Thanks,
Jean


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
