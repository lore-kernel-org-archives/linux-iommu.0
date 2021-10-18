Return-Path: <SRS0=5Tlr=PG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F18EC433F5
	for <iommu@archiver.kernel.org>; Mon, 18 Oct 2021 15:24:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16BE760EFE
	for <iommu@archiver.kernel.org>; Mon, 18 Oct 2021 15:24:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 16BE760EFE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE25640627;
	Mon, 18 Oct 2021 15:24:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r_NUzIJosmih; Mon, 18 Oct 2021 15:24:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A63F7405CF;
	Mon, 18 Oct 2021 15:24:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7CBE5C000F;
	Mon, 18 Oct 2021 15:24:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E942FC000D
 for <iommu@lists.linux-foundation.org>; Mon, 18 Oct 2021 15:24:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E5F8A6059C
 for <iommu@lists.linux-foundation.org>; Mon, 18 Oct 2021 15:24:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OB4dEO4hlDuc for <iommu@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 15:24:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C0D47600C7
 for <iommu@lists.linux-foundation.org>; Mon, 18 Oct 2021 15:24:05 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id y3so42272990wrl.1
 for <iommu@lists.linux-foundation.org>; Mon, 18 Oct 2021 08:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=b18ivha38ZiS/SavfqQyfz2Op8dQ1w9CjDl92LOvcRI=;
 b=bzud5keGFt9eLWbfAS/kSlwj2d6YFC/diEFlh59G+auULTDXfm1YU4t3eyLEZ+uCJV
 UXVbgcjNPeWndDdwB+fijJIw3bt3bwNL+waR95hjekXY/kNwhu/dd3BV9pUeWy9lj+Qx
 X6Yv+FH4gSRu7TkMCcJmajTzAzzbxjW7O3te22p4SvkS1BJXap7pUwa5T16xcOR8M93o
 NoS5kj1tEIcNybIfyu5FTo8H7R/PRbEyCua8Nen3OW6mg/340JAldzR1+CXeHdd1nteB
 8cQoisaJNaEo90czjpEId+GgBehTKGznLt2qW1S3Gl2KeyGSutVEUuk6w33vtq/sPItJ
 uY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=b18ivha38ZiS/SavfqQyfz2Op8dQ1w9CjDl92LOvcRI=;
 b=u6WpRqZV2eUxhsCy9XmuxkDVa/77kpcSZX3rLQf0gVJzeX5DGdLS/gS+GHiay1/d8U
 3dpffC2ct0UVJsf01qvk3Wk5C8x3WR5IpTFeQOzqYlNvjwtIICFmGimrZ62IAN0ah+2S
 eambs+0ymGzq0AWFhJ0nnA+lSXyCjQm4w0mrUtpHxRr6mRREvpqCMQvYn9zjuhcWLe2m
 fxZlSkl6+RmBQXb4m2K6h/+B5os5yO4eX5L6oKFZUPnp3rKwtarX0pG2aZlJRuJiTtfj
 wHcXpaBjsUNpj+QpWIabUwS5ZA18t9Xiw+I6NSS45DJfh+hXverf7OS7O3CZgucbAR1K
 5rAg==
X-Gm-Message-State: AOAM530ephd7WhmVlVokx8F4KIywxcKFh9AOdw17Coq8XdeELWo8JAml
 32vC+G3mPKxqd1EbClK/Wrl4jg==
X-Google-Smtp-Source: ABdhPJxz3q/7gaMqfZXxHG4mMDNpo8L1aIOYy14BS6iaIobQ4ktyNqn7bTK1veXTf2msL6VgVY2r1w==
X-Received: by 2002:adf:b19c:: with SMTP id q28mr36649350wra.348.1634570643911; 
 Mon, 18 Oct 2021 08:24:03 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id a63sm16963052wmd.34.2021.10.18.08.24.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Oct 2021 08:24:03 -0700 (PDT)
Date: Mon, 18 Oct 2021 16:23:41 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH 0/5] iommu/virtio: Add identity domains
Message-ID: <YW2RfXJwAxFYOYzs@myrica>
References: <20211013121052.518113-1-jean-philippe@linaro.org>
 <BN9PR11MB5433EFF47E5FABC1D7D95F6F8CB89@BN9PR11MB5433.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5433EFF47E5FABC1D7D95F6F8CB89@BN9PR11MB5433.namprd11.prod.outlook.com>
Cc: "mst@redhat.com" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Boeuf,
 Sebastien" <sebastien.boeuf@intel.com>, "will@kernel.org" <will@kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>
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

On Thu, Oct 14, 2021 at 03:00:38AM +0000, Tian, Kevin wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Sent: Wednesday, October 13, 2021 8:11 PM
> > 
> > Support identity domains, allowing to only enable IOMMU protection for a
> > subset of endpoints (those assigned to userspace, for example). Users
> > may enable identity domains at compile time
> > (CONFIG_IOMMU_DEFAULT_PASSTHROUGH), boot time
> > (iommu.passthrough=1) or
> > runtime (/sys/kernel/iommu_groups/*/type = identity).
> 
> Do we want to use consistent terms between spec (bypass domain) 
> and code (identity domain)? 

I don't think we have to. Linux uses "identity" domains and "passthrough"
IOMMU. The old virtio-iommu feature was "bypass" so we should keep that
for the new one, to be consistent. And then I've used "bypass" for domains
as well, in the spec, because it would look strange to use a different
term for the same concept. I find that it sort of falls into place: Linux'
identity domains can be implemented either with bypass or identity-mapped
virtio-iommu domains.

> > 
> > Patches 1-2 support identity domains using the optional
> > VIRTIO_IOMMU_F_BYPASS_CONFIG feature. The feature bit is not yet in the
> > spec, see [1] for the latest proposal.
> > 
> > Patches 3-5 add a fallback to identity mappings, when the feature is not
> > supported.
> > 
> > Note that this series doesn't touch the global bypass bit added by
> > VIRTIO_IOMMU_F_BYPASS_CONFIG. All endpoints managed by the IOMMU
> > should
> > be attached to a domain, so global bypass isn't in use after endpoints
> 
> I saw a concept of deferred attach in iommu core. See iommu_is_
> attach_deferred(). Currently this is vendor specific and I haven't
> looked into the exact reason why some vendor sets it now. Just
> be curious whether the same reason might be applied to virtio-iommu.
> 
> > are probed. Before that, the global bypass policy is decided by the
> > hypervisor and firmware. So I don't think Linux needs to touch the
> 
> This reminds me one thing. The spec says that the global bypass
> bit is sticky and not affected by reset.

The spec talks about *device* reset, triggered by software writing 0 to
the status register, but it doesn't mention system reset. Would be good to
clarify that. Something like:

    If the device offers the VIRTIO_IOMMU_F_BYPASS_CONFIG feature, it MAY
    initialize the \field{bypass} field to 1. Field \field{bypass} SHOULD
    NOT change on device reset, but SHOULD be restored to its initial
    value on system reset.

> This implies that in the case
> of rebooting the VM into a different OS, the previous OS actually
> has the right to override this setting for the next OS. Is it a right
> design? Even the firmware itself is unable to identify the original
> setting enforced by the hypervisor after reboot. I feel the hypervisor
> setting should be recovered after reset since it reflects the 
> security measure enforced by the virtual platform?

So I think clarifying system reset should address your questions.
I believe we should leave bypass sticky across device reset, so a FW->OS
transition, where the OS resets the device, does not open a vulnerability
(if bypass was enabled at boot and then left disabled by FW.)

It's still a good idea for the OS to restore on shutdown the bypass value
it was booted with. So it can kexec into an OS that doesn't support
virtio-iommu, for example.

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
