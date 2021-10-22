Return-Path: <SRS0=cgap=PK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD047C433EF
	for <iommu@archiver.kernel.org>; Fri, 22 Oct 2021 07:49:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4381D6115B
	for <iommu@archiver.kernel.org>; Fri, 22 Oct 2021 07:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4381D6115B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE911402D1;
	Fri, 22 Oct 2021 07:49:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0goRlWN5elSm; Fri, 22 Oct 2021 07:49:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9E0864041A;
	Fri, 22 Oct 2021 07:49:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71F29C0020;
	Fri, 22 Oct 2021 07:49:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CEE0CC001E
 for <iommu@lists.linux-foundation.org>; Fri, 22 Oct 2021 07:49:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B5F8680DE1
 for <iommu@lists.linux-foundation.org>; Fri, 22 Oct 2021 07:49:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U6-Kxt_tIkrx for <iommu@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 07:49:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 62C9080DAF
 for <iommu@lists.linux-foundation.org>; Fri, 22 Oct 2021 07:49:28 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id d3so3354588wrh.8
 for <iommu@lists.linux-foundation.org>; Fri, 22 Oct 2021 00:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=l4ig/cSrg8mQN6aKAdfHWEATu5gWqjzgX7zon10Q9+E=;
 b=XNhjtbDMlD0fLOkQBRfHMcymLt/KXEWZO0gzlFJJkY7tBULpUdJRS/3zpdmfMBLV4H
 mDyJzKhY7XbOJxQruVq5kcUcL2jZDv1gnvQ9jlhLZbg5KSBTSxZeZvrngodKSZNSEl8T
 Pf8RChum9PCyRSCLuC4ch1v42ocyebTEN4wJh8w08Ks8CqkjNEC8HhO8Cuuz4OWdpkPv
 Ndv3qIL1U/ZUkmavejbqkHMkEQvYMfDd9YjvNpLjTz2JkhjTIni3XGjzgxXkPKZKg+Qy
 kQmnSmqvnDz0Wh6heFLPsNne7vzaPPNcev9WX9RnAprj7p04Nm7y9wLDcgRl/bor6Ngj
 L0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=l4ig/cSrg8mQN6aKAdfHWEATu5gWqjzgX7zon10Q9+E=;
 b=dwPGFIS7GLleUMOjSwQtg02IupDtPkdSQDl8oYK9S2BrPn1LlyBdVXXa8J64ZlP9X0
 WkFjfmGRrOs8o4tX2JtjVGqRKsSEqjRCEg1wqiIzrVtHGAhhN48zTiE29+WeL3Z/aiKl
 QWRqGsFZ5t/CDMn4j3Pd4KL6dVhkFt/+G5wsGKhy5npVkaOeMZXffWVuTJeaxWCXEF/R
 bFibB/hF8hQcFAzLeKb94FW4WiO7/tAWl6xV3WI+uRrFELGpzu/ZJeNyxL4rG8b/DXdO
 gCKechp8g4OQGwfCqbZLM4BztH0ZSE3VaqTdr8yqtNDJNQQRL5kzHz2YHNKr+5jPOmQw
 I5pg==
X-Gm-Message-State: AOAM531vtHro9jRCd1mS2VkiuEH/iTZ1M8pcvktw0vku2rM9u9Cu+O8d
 RdnheNYSMVVWJnMd9FJnbEP7Xg==
X-Google-Smtp-Source: ABdhPJxpO/NacPoc1tCOWgCvmhl6vzuBziA4+8Ev+IfkXnOna1GvDwP4ExJS99BeJ3odnzDfvvbRCQ==
X-Received: by 2002:a5d:6d81:: with SMTP id l1mr13601357wrs.110.1634888966529; 
 Fri, 22 Oct 2021 00:49:26 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id l2sm8802620wrs.90.2021.10.22.00.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Oct 2021 00:49:25 -0700 (PDT)
Date: Fri, 22 Oct 2021 08:49:03 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC 10/20] iommu/iommufd: Add IOMMU_DEVICE_GET_INFO
Message-ID: <YXJs7+nQJ++EKIyT@myrica>
References: <BN9PR11MB54333BDB1E58387FD9999DF18CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210923114219.GG964074@nvidia.com>
 <BN9PR11MB5433519229319BA951CA97638CAA9@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210930222355.GH964074@nvidia.com>
 <BN9PR11MB5433530032DC8400B71FCB788CB89@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20211014154259.GT2744544@nvidia.com>
 <BN9PR11MB543327BB6D58AEF91AD2C9D18CB99@BN9PR11MB5433.namprd11.prod.outlook.com>
 <BL1PR11MB5429973588E4FBCEC8F519A88CBF9@BL1PR11MB5429.namprd11.prod.outlook.com>
 <YXF/+jxRtjnlXU7w@myrica> <20211021232223.GM2744544@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211021232223.GM2744544@nvidia.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "Jiang, Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "Tian, Kevin" <kevin.tian@intel.com>,
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

On Thu, Oct 21, 2021 at 08:22:23PM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 21, 2021 at 03:58:02PM +0100, Jean-Philippe Brucker wrote:
> > On Thu, Oct 21, 2021 at 02:26:00AM +0000, Tian, Kevin wrote:
> > > > I'll leave it to Jean to confirm. If only coherent DMA can be used in
> > > > the guest on other platforms, suppose VFIO should not blindly set
> > > > IOMMU_CACHE and in concept it should deny assigning a non-coherent
> > > > device since no co-ordination with guest exists today.
> > > 
> > > Jean, what's your opinion?
> > 
> > Yes a sanity check to prevent assigning non-coherent devices would be
> > good, though I'm not particularly worried about non-coherent devices. PCIe
> > on Arm should be coherent (according to the Base System Architecture). So
> > vfio-pci devices should be coherent, but vfio-platform and mdev are
> > case-by-case (hopefully all coherent since it concerns newer platforms).
> > 
> > More worrying, I thought we disabled No-Snoop for VFIO but I was wrong,
> > it's left enabled. On Arm I don't think userspace can perform the right
> > cache maintenance operations to maintain coherency with a device that
> > issues No-Snoop writes. Userspace can issue clean+invalidate but not
> > invalidate alone, so there is no equivalent to
> > arch_sync_dma_for_cpu().
> 
> So what happens in a VM? Does a VM know that arch_sync_dma_for_cpu()
> is not available?

This would only affect userspace drivers, it's only host or guest
userspace that cannot issue the maintenance operations. The VM can do
arch_sync_dma_for_cpu()

Thanks,
Jean

> 
> And how does this work with the nested IOMMU translation? I thought I
> read in the SMMU spec that the io page table entries could control
> cachability including in nesting cases?
> 
> > I think the worse that can happen is the device owner shooting itself in
> > the foot by using No-Snoop, but would it hurt to disable it?
> 
> No, the worst is the same as Intel - a driver running in the guest VM
> assumes it can use arch_sync_dma_for_cpu() and acts accordingly,
> resulting in a broken VM.
> 
> Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
