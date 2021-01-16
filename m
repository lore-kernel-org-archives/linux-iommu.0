Return-Path: <SRS0=uK2e=GT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63964C433DB
	for <iommu@archiver.kernel.org>; Sat, 16 Jan 2021 08:39:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFDC023403
	for <iommu@archiver.kernel.org>; Sat, 16 Jan 2021 08:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFDC023403
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A322986D5F;
	Sat, 16 Jan 2021 08:39:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X9NKV+oTGqZb; Sat, 16 Jan 2021 08:39:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 66C5D86D56;
	Sat, 16 Jan 2021 08:39:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 496FAC088B;
	Sat, 16 Jan 2021 08:39:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1BFBEC013A
 for <iommu@lists.linux-foundation.org>; Sat, 16 Jan 2021 08:39:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id EE8AD2037E
 for <iommu@lists.linux-foundation.org>; Sat, 16 Jan 2021 08:39:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JtS9TOXnLIAX for <iommu@lists.linux-foundation.org>;
 Sat, 16 Jan 2021 08:39:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 5B85B2037A
 for <iommu@lists.linux-foundation.org>; Sat, 16 Jan 2021 08:39:08 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A2A323339;
 Sat, 16 Jan 2021 08:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610786347;
 bh=OTU/ZiHDfKKS3DGAIXMuHsKqoyF0ThtCMaNSJ7Psvjo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Jz5EIWi/XmKCHgceatEQXnZqkRblFMiPdEbfMUHCCMWeCbc7HTDuNmtG7y/uGuZ4H
 /5Tar/XvIMVLcKRvp6hYsy7+A/BoGdjcHmy8msunKBcPdOKI3PZksX7XfYizzNpwdv
 63ufhfOpjeHnFy5NO5rtDFQ/ZMIXeepbXj/3s4uN5rkVZ+bS8U5MafqvIB/cEH6Wbq
 Q3qkA3QMFFT0VVmln2VY432TGr1zPsXgGfEEGWI+T+/l1Httq+JDO8kGZ6UKgELrkp
 Y+bVljKtVkgF1FiycqJwUdOPzBXuws/uaPeejspDpp4ZdsABXBf4ITh/ctuppYpxTE
 k9uGQfCC4KYaw==
Date: Sat, 16 Jan 2021 10:39:04 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFC PATCH v3 1/2] iommu: Add capability IOMMU_CAP_VIOMMU
Message-ID: <20210116083904.GN944463@unreal>
References: <20210114013003.297050-1-baolu.lu@linux.intel.com>
 <20210114013003.297050-2-baolu.lu@linux.intel.com>
 <20210114132627.GA944463@unreal>
 <b0c8b260-8e23-a5bd-d2da-ca1d67cdfa8a@linux.intel.com>
 <20210115063108.GI944463@unreal>
 <c58adc13-306a-8df8-19e1-27f834b3a7c9@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c58adc13-306a-8df8-19e1-27f834b3a7c9@linux.intel.com>
Cc: kvm@vger.kernel.org, rafael@kernel.org, linux-pci@vger.kernel.org,
 sanjay.k.kumar@intel.com, mona.hossain@intel.com, samuel.ortiz@intel.com,
 kwankhede@nvidia.com, will@kernel.org, dan.j.williams@intel.com,
 dave.jiang@intel.com, ashok.raj@intel.com, netanelg@mellanox.com,
 maz@kernel.org, vkoul@kernel.org, jgg@mellanox.com, yan.y.zhao@linux.intel.com,
 shahafs@mellanox.com, kevin.tian@intel.com, parav@mellanox.com,
 alex.williamson@redhat.com, bhelgaas@google.com, tglx@linutronix.de,
 megha.dey@intel.com, tony.luck@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
 dmaengine@vger.kernel.org, pbonzini@redhat.com, dwmw2@infradead.org
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

On Sat, Jan 16, 2021 at 09:20:16AM +0800, Lu Baolu wrote:
> Hi,
>
> On 2021/1/15 14:31, Leon Romanovsky wrote:
> > On Fri, Jan 15, 2021 at 07:49:47AM +0800, Lu Baolu wrote:
> > > Hi Leon,
> > >
> > > On 1/14/21 9:26 PM, Leon Romanovsky wrote:
> > > > On Thu, Jan 14, 2021 at 09:30:02AM +0800, Lu Baolu wrote:
> > > > > Some vendor IOMMU drivers are able to declare that it is running in a VM
> > > > > context. This is very valuable for the features that only want to be
> > > > > supported on bare metal. Add a capability bit so that it could be used.
> > > >
> > > > And how is it used? Who and how will set it?
> > >
> > > Use the existing iommu_capable(). I should add more descriptions about
> > > who and how to use it.
> >
> > I want to see the code that sets this capability.
>
> Currently we have Intel VT-d and the virt-iommu setting this capability.
>
>  static bool intel_iommu_capable(enum iommu_cap cap)
>  {
>  	if (cap == IOMMU_CAP_CACHE_COHERENCY)
>  		return domain_update_iommu_snooping(NULL) == 1;
>  	if (cap == IOMMU_CAP_INTR_REMAP)
>  		return irq_remapping_enabled == 1;
> +	if (cap == IOMMU_CAP_VIOMMU)
> +		return caching_mode_enabled();
>
>  	return false;
>  }
>
> And,
>
> +static bool viommu_capable(enum iommu_cap cap)
> +{
> +	if (cap == IOMMU_CAP_VIOMMU)
> +		return true;
> +
> +	return false;
> +}

These two functions are reading this cap and not setting.
Where can I see code that does "cap = IOMMU_CAP_VIOMMU" and not "=="?

>
> Best regards,
> baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
