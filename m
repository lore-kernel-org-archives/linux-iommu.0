Return-Path: <SRS0=8SnF=MO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30D7C6379B
	for <iommu@archiver.kernel.org>; Thu, 22 Jul 2021 16:46:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 839B661D65
	for <iommu@archiver.kernel.org>; Thu, 22 Jul 2021 16:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839B661D65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4484A833CE;
	Thu, 22 Jul 2021 16:46:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YteRuc865W1K; Thu, 22 Jul 2021 16:46:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 10846833C7;
	Thu, 22 Jul 2021 16:46:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8B3AC001A;
	Thu, 22 Jul 2021 16:46:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D309EC000E
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 16:46:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C1AED833CA
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 16:46:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8KOdl0G9O2UK for <iommu@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 16:46:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 71A99833C7
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 16:46:19 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id x17so7573237edd.12
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 09:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=W7EgR/KjyQstNuhpRlaCK/6CxtUIzCbapIFC82TrdSA=;
 b=xP8oApi+Bdr+OensXaaKE8LA+9sbUQwMXVBw6NjjQbKxXo1Yohg9cn+RrKIRtbfgco
 pkj5t/6ULCwiUcS4Bi9LAu9WRF5s7zBflC8bvLdkV+ATbo7uY7MK56xy2X6j3zy7MSZ4
 4xWw+tyqbU1iK8wcAXJwkrEWYAx8c23VGAtbXj4tsJ3jO7HPd1palC4627CYvJQKmyHI
 O66+K1ghpMK6vk3B6BpzCszBTf+HJTtXD8fFqb3sXRyURY5/8Np1zO/irLBFJddYJ9I6
 A9K9wCCJL3kBQ/tkTBN4WMGtc/MTaTyCUOMwZVaBNiNbSSfsbCf/USj1EkIh6nghbah7
 81yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=W7EgR/KjyQstNuhpRlaCK/6CxtUIzCbapIFC82TrdSA=;
 b=fRtLgj+x0Dp57UOtxxKpSY/U6yHSQhHzUPNmdUhG97t/g+j/m5FarKYLeD33qgEHTg
 Shbp+kXyvYr81GgFgekVxxDwiA1YdMQnvEgITYIQ0AY4hEPQRlUOPAIeRZ+R1SWebAQy
 Ct1N4rPnyoD5qYe7Npw7IMfQufF1dkfZQfgMArzYGmph5nW+tcAb2+PfGGK/M4lMwdCD
 3A0JIlHA9lc3tQntF48+YznitCahScQj8EZf34M8RLRWlkrBRpBqa7Q50ktHrs4ZHvyC
 CJiWJJR84TVK8csrzr57603ob36nQRpWc9ff1zQkPmnHiLuZUML2JPzO2F2ASssdSoNr
 +uxQ==
X-Gm-Message-State: AOAM532QSBg/BACRjHLsGEB0Z35gJVkKT5DGbzL4gMOxMp9/eDe0FQEE
 ynCwRDWW8kmWH22ASuNTZTXIkw==
X-Google-Smtp-Source: ABdhPJyaZqihTJvxMXbAmM8mW5XOhXvQdit5VNpHrh7U2L33+s17D1jweU/bvZeP06sbOOH1H+7sFw==
X-Received: by 2002:a05:6402:168f:: with SMTP id
 a15mr638501edv.3.1626972377612; 
 Thu, 22 Jul 2021 09:46:17 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
 by smtp.gmail.com with ESMTPSA id j1sm12673521edl.80.2021.07.22.09.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jul 2021 09:46:17 -0700 (PDT)
Date: Thu, 22 Jul 2021 18:45:55 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [RFC PATCH 4/5] iommu/arm-smmu-v3: Use pinned VMID for NESTED
 stage with BTM
Message-ID: <YPmgw5fQ59rCw2I6@myrica>
References: <20210222155338.26132-1-shameerali.kolothum.thodi@huawei.com>
 <20210222155338.26132-5-shameerali.kolothum.thodi@huawei.com>
 <YEEUocRn3IfIDpLj@myrica>
 <903a06a9db8c45fe88158e1c35f38c25@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <903a06a9db8c45fe88158e1c35f38c25@huawei.com>
Cc: "maz@kernel.org" <maz@kernel.org>, Linuxarm <linuxarm@huawei.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

Hi Shameer,

On Wed, Jul 21, 2021 at 08:54:00AM +0000, Shameerali Kolothum Thodi wrote:
> > More generally I think this pinned VMID set conflicts with that of
> > stage-2-only domains (which is the default state until a guest attaches a
> > PASID table). Say you have one guest using DOMAIN_NESTED without PASID
> > table, just DMA to IPA using VMID 0x8000. Now another guest attaches a
> > PASID table and obtains the same VMID from KVM. The stage-2 translation
> > might use TLB entries from the other guest, no?  They'll both create
> > stage-2 TLB entries with {StreamWorld=NS-EL1, VMID=0x8000}
> 
> Now that we are trying to align the KVM VMID allocation algorithm similar to
> that of the ASID allocator [1], I attempted to use that for the SMMU pinned 
> VMID allocation. But the issue you have mentioned above is still valid. 
> 
> And as a solution what I have tried now is follow what pinned ASID is doing 
> in SVA,
>  -Use xarray for private VMIDs
>  -Get pinned VMID from KVM for DOMAIN_NESTED with PASID table
>  -If the new pinned VMID is in use by private, then update the private
>   VMID(VMID update to a live STE).
> 
> This seems to work, but still need to run more tests with this though.  
>
> > It's tempting to allocate all VMIDs through KVM instead, but that will
> > force a dependency on KVM to use VFIO_TYPE1_NESTING_IOMMU and might
> > break
> > existing users of that extension (though I'm not sure there are any).
> > Instead we might need to restrict the SMMU VMID bitmap to match the
> > private VMID set in KVM.
> 
> Another solution I have in mind is, make the new KVM VMID allocator common
> between SMMUv3 and KVM. This will help to avoid all the private and shared
> VMID splitting, also no need for live updates to STE VMID. One possible drawback
> is less number of available KVM VMIDs but with 16 bit VMID space I am not sure
> how much that is a concern.

Yes I think that works too. In practice there shouldn't be many VMIDs on
the SMMU side, the feature's only enabled when a user wants to assign
devices with nesting translation (unlike ASIDs where each device in the
system gets a private ASID by default).

Note that you still need to pin all VMIDs used by the SMMU, otherwise
you'll have to update the STE after rollover.

The problem we have with VFIO_TYPE1_NESTING_IOMMU might be solved by the
upcoming deprecation of VFIO_*_IOMMU [2]. We need a specific sequence from
userspace:
1. Attach VFIO group to KVM (KVM_DEV_VFIO_GROUP_ADD)
2. Create nesting IOMMU domain and attach the group to it
   (VFIO_GROUP_SET_CONTAINER, VFIO_SET_IOMMU becomes
    IOMMU_IOASID_ALLOC, VFIO_DEVICE_ATTACH_IOASID)
Currently QEMU does 2 then 1, which would cause the SMMU to allocate a
separate VMID. If we wanted to extend VFIO_TYPE1_NESTING_IOMMU with PASID
tables we'd need to mandate 1-2 and may break existing users. In the new
design we can require from the start that creating a nesting IOMMU
container through /dev/iommu *must* come with a KVM context, that way
we're sure to reuse the existing VMID.

Thanks,
Jean

[2] https://lore.kernel.org/linux-iommu/BN9PR11MB5433B1E4AE5B0480369F97178C189@BN9PR11MB5433.namprd11.prod.outlook.com/
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
