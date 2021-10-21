Return-Path: <SRS0=0R9D=PJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1019C433FE
	for <iommu@archiver.kernel.org>; Thu, 21 Oct 2021 14:58:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60503611CE
	for <iommu@archiver.kernel.org>; Thu, 21 Oct 2021 14:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 60503611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0CBA683C08;
	Thu, 21 Oct 2021 14:58:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2wCzih4qJyFA; Thu, 21 Oct 2021 14:58:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DCD3983BEA;
	Thu, 21 Oct 2021 14:58:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE7EFC0033;
	Thu, 21 Oct 2021 14:58:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A62E6C0011
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 14:58:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7F3F4406D6
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 14:58:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1-VEruR-LuOv for <iommu@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 14:58:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 493FE40017
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 14:58:27 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id e12so1589137wra.4
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 07:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=9NBqHjMa3wMvruHtwVGUR1gd7leMzib5uaeU+3Io4Fg=;
 b=qBP2L8NVoLfZGeQzfQjTFTNz0gG7byHV4/NfKy7g3ACmXnfyTURs/kJuCENa0ErjIS
 9gMeeYKQSF1EERRPA76Ma8B/Z6HgB6SfFqm9Il709BrqR/YoDXAldgU5CKMlgADTSnN2
 +xWx7oJkoq0MVJEHZ5Q30hgftm1JS1Tc3a1bbSPvAJb5xXVPzI2AcsY9t8VjUaYhnSP6
 TWAeS06C5u3UV5FCNmiy9Xh37uKHLLnkG2a0XPDHvr/phujaMvRMutXBnYx4hChmpAKu
 +6yYVvun+7Oh3nH135puLcVD82OOGl5Hh8iajWjPrmyw7VlXzrBoqR+P+P9nNKdBh9FR
 6ezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9NBqHjMa3wMvruHtwVGUR1gd7leMzib5uaeU+3Io4Fg=;
 b=6uvgwVPLj3UDD5e6ZU0gmn4l1/mAYMOxnNxWHsYK0T2OacS2YyDmu2ORDhfYN1jVzO
 5GbDETsIleoNrP23xgmLJdapDo4+xdGAnFRENR0UNLCXI2fqA8m2xD0xQSQDAtRkabpV
 G9yxcm26EpJ+WE7CfubZKO8KvMk/Yn9EdODv9iDtPuO0IoWEx8beHuanuyR9D5Jxr9iX
 jru/Mqc6cV6tlADclobWWQpB0Ij0iQYzseq5GSW7KSJNLB9FR+59cUDuqW13FrWSducg
 u/O66XUNwG0Y7SKFW1fcAyqRK1AkXwzCZhhTaNyYpbjVWny3JWpVrd5Of8sq+dbLIGnf
 Jd2g==
X-Gm-Message-State: AOAM530vbP5RJeEPE7DkbH4Fn50uy6Ax4F/ny5auOL/gyTSzwvapOqF2
 0ctDUsZgmTip964gMlLmBJX6sQ==
X-Google-Smtp-Source: ABdhPJx5RVth8E6qcEBrzprytwqqvFi257rdO6QMjjNBkE3Npatj68fYhqVFmrNYJlMyrm2jHzKLvw==
X-Received: by 2002:a5d:55cd:: with SMTP id i13mr8018641wrw.410.1634828305512; 
 Thu, 21 Oct 2021 07:58:25 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id d24sm4977061wmb.35.2021.10.21.07.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Oct 2021 07:58:24 -0700 (PDT)
Date: Thu, 21 Oct 2021 15:58:02 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC 10/20] iommu/iommufd: Add IOMMU_DEVICE_GET_INFO
Message-ID: <YXF/+jxRtjnlXU7w@myrica>
References: <20210922234954.GB964074@nvidia.com>
 <BN9PR11MB5433409DF766AAEF1BB2CF258CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
 <BN9PR11MB54333BDB1E58387FD9999DF18CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210923114219.GG964074@nvidia.com>
 <BN9PR11MB5433519229319BA951CA97638CAA9@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210930222355.GH964074@nvidia.com>
 <BN9PR11MB5433530032DC8400B71FCB788CB89@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20211014154259.GT2744544@nvidia.com>
 <BN9PR11MB543327BB6D58AEF91AD2C9D18CB99@BN9PR11MB5433.namprd11.prod.outlook.com>
 <BL1PR11MB5429973588E4FBCEC8F519A88CBF9@BL1PR11MB5429.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BL1PR11MB5429973588E4FBCEC8F519A88CBF9@BL1PR11MB5429.namprd11.prod.outlook.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "Jiang, Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, Jason Gunthorpe <jgg@nvidia.com>,
 "parav@mellanox.com" <parav@mellanox.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "lkml@metux.net" <lkml@metux.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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

On Thu, Oct 21, 2021 at 02:26:00AM +0000, Tian, Kevin wrote:
> > I'll leave it to Jean to confirm. If only coherent DMA can be used in
> > the guest on other platforms, suppose VFIO should not blindly set
> > IOMMU_CACHE and in concept it should deny assigning a non-coherent
> > device since no co-ordination with guest exists today.
> 
> Jean, what's your opinion?

Yes a sanity check to prevent assigning non-coherent devices would be
good, though I'm not particularly worried about non-coherent devices. PCIe
on Arm should be coherent (according to the Base System Architecture). So
vfio-pci devices should be coherent, but vfio-platform and mdev are
case-by-case (hopefully all coherent since it concerns newer platforms).

More worrying, I thought we disabled No-Snoop for VFIO but I was wrong,
it's left enabled. On Arm I don't think userspace can perform the right
cache maintenance operations to maintain coherency with a device that
issues No-Snoop writes. Userspace can issue clean+invalidate but not
invalidate alone, so there is no equivalent to arch_sync_dma_for_cpu().
I think the worse that can happen is the device owner shooting itself in
the foot by using No-Snoop, but would it hurt to disable it?

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
