Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7456C433EF
	for <iommu@archiver.kernel.org>; Tue, 24 May 2022 10:58:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6665B41A38;
	Tue, 24 May 2022 10:58:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Di_on3zC0C3G; Tue, 24 May 2022 10:58:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 06ADD41A3A;
	Tue, 24 May 2022 10:58:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9A54C0032;
	Tue, 24 May 2022 10:58:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED10BC002D
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 10:58:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DB89160BB2
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 10:58:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2Id0AN2lFMvK for <iommu@lists.linux-foundation.org>;
 Tue, 24 May 2022 10:58:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5CCDD60B69
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 10:58:26 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id p19so1901631wmg.2
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 03:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=eCjI61TxF/VhR4kH8WebLIwDAZqQH5lWWY5eksn1pk4=;
 b=vv0TNhcIJ4S4bv7c//57PxGJKqkVJwPgBpjuTOpLp+J5+358caS7gCJhwUY2f80H4Z
 Jgrh6OAVm1iAgDWdWVCBmf8NS9N7XjpDJ6LyhL3rzY3YxKDb44cHx8KemQcVBPkmexP6
 9w5aUBbryD0GbFuSEpJEysh3VHFFpD4S1pKgJ4DkOaPQ5qigvL5UMaT2urRAxdsXUS5e
 FDpv5zmJ64vnO5oSkS9A5eO+xAvBWaSMvk5BwkPSfPrM8dzNi6LkjvMSn8+d2yjSpGlY
 3XFx9G9TUqrsUeO/Fo1kcCoR108PWVQtJiYIH+d4lw3m7XUPjJxJVOl0qMIgwDtrsI/l
 VQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=eCjI61TxF/VhR4kH8WebLIwDAZqQH5lWWY5eksn1pk4=;
 b=IQYHYBAaLsRr/CA7SjeLEXbtW6BfY5uugAKO0RgOMFo6WYM68lD3s5aqIOscgyHNbT
 p+Mgo3tN2DEkh+OoTsWlgBsUKYCTwhPCE5xBlP7+qQU8JLPfQd19Ukz3oHmkByCPhDQv
 KkUOjWkIK/K6Ee6zAycbygqLa5aCiQGey+voaM2pTLay1kIRgpj4cOorcjnk25yKmw8q
 G5FY/wJyWeo6rUrstE8iTS0GXiUyzcy0VAwXiRgWr+lDT6StUss4HTthVQYprkJ+WN4M
 FiUAUZAJ/pj9fVTGuJuyqx22YNTey9YqRXsxWzGkEWJvhG9zQWwh/na1EnJDJwHdSJlC
 OzjQ==
X-Gm-Message-State: AOAM531u0KFhiTBNr0/1a0Kzvm2YHQ5wJgRDUym2VspBmgr8aCCkH0fe
 aZAIog9UJ8IvQhiAJGytxpnMuQ==
X-Google-Smtp-Source: ABdhPJxFTJkFYuZB+CyKxNj/VjuwuSt9WMAzvZj8TN9N3ciewWRevYgqK0102jXTQ5oECXV7bU5aGQ==
X-Received: by 2002:a05:600c:29d3:b0:397:4730:ee75 with SMTP id
 s19-20020a05600c29d300b003974730ee75mr3185384wmd.149.1653389904595; 
 Tue, 24 May 2022 03:58:24 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 o16-20020adf8b90000000b0020fc3e24041sm10338214wra.106.2022.05.24.03.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 May 2022 03:58:24 -0700 (PDT)
Date: Tue, 24 May 2022 11:57:59 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v7 06/10] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Message-ID: <Yoy6NxroLLZup0sE@myrica>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-7-baolu.lu@linux.intel.com>
 <BN9PR11MB5276E462E3B32DDE54DD66418CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276E462E3B32DDE54DD66418CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On Tue, May 24, 2022 at 10:22:28AM +0000, Tian, Kevin wrote:
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> > Sent: Thursday, May 19, 2022 3:21 PM
> > 
> > The existing iommu SVA interfaces are implemented by calling the SVA
> > specific iommu ops provided by the IOMMU drivers. There's no need for
> > any SVA specific ops in iommu_ops vector anymore as we can achieve
> > this through the generic attach/detach_dev_pasid domain ops.
> 
> set/block_pasid_dev, to be consistent.
> 
> > +
> > +	mutex_lock(&iommu_sva_lock);
> > +	/* Search for an existing domain. */
> > +	domain = iommu_get_domain_for_dev_pasid(dev, mm->pasid);
> > +	if (domain) {
> > +		sva_domain = to_sva_domain(domain);
> > +		refcount_inc(&sva_domain->bond.users);
> > +		goto out_success;
> > +	}
> > +
> 
> why would one device/pasid be bound to a mm more than once?

Device drivers can call bind() multiple times for the same device and mm,
for example if one process wants to open multiple accelerator queues.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
