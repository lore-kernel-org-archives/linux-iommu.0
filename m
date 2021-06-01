Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA980C47080
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 22:22:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92459613AE
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 22:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92459613AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 569DC83753;
	Tue,  1 Jun 2021 22:22:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OwunaZNFe-TS; Tue,  1 Jun 2021 22:22:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 342AB8376E;
	Tue,  1 Jun 2021 22:22:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EED41C000D;
	Tue,  1 Jun 2021 22:22:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38161C0001
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 22:22:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 26CB140238
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 22:22:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KjX0EXWULzqJ for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 22:22:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6DFA54017C
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 22:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622586154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QQ6OOCiaBJ+Tmwz5+IKCbPSSgkslxV7sVjnAnThBj/I=;
 b=hEZx7zjfPBuCOIZ4Tgl9SXqxfhJ3AZqEHR++vSfFarWtC0NnXWSg4tmeGTzfkfssXfSsly
 zbn7kDa2qrPBqXXAeBYB8xiPy1HmxOIjv6Mewld1wSXC+PNmrf4uxbCBZf6CPPg4EeLyvI
 xRmi/dnEj4Oc0vyGDaWiOqYG4OUcmkQ=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-OnrgJ6VrNCWbVO2tx4KBrQ-1; Tue, 01 Jun 2021 18:22:30 -0400
X-MC-Unique: OnrgJ6VrNCWbVO2tx4KBrQ-1
Received: by mail-oi1-f199.google.com with SMTP id
 y137-20020aca4b8f0000b02901f110a6ffedso418890oia.16
 for <iommu@lists.linux-foundation.org>; Tue, 01 Jun 2021 15:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QQ6OOCiaBJ+Tmwz5+IKCbPSSgkslxV7sVjnAnThBj/I=;
 b=N0iujtQzvnAkYE4YYyZmcOUcx22WdKhkxiPHBJse+uviSYTXfoFc7MyocH/juuF/vD
 3wubs2cJy0nPR9FflScfPighft3sinPYnsiRECJ54If+TpyIXNNXQyHMxwRnJqIGt/ET
 VhenDn9hOIdt+6FFP9VWVuNujKnbC0A/elOHIoNVp/smbBHQj+AwbsxIFz8XKecgkjol
 sNQspixWjPfDoHPJcr91wVO0pIOwdldBDyje19/r/jP7PiZFgMqGc5Jsn0xMroApwa+Z
 C+eT5jMAzK4BdA63knQexpHTNUxSI/zzufubpAiorHxUjlf9aoeBp10ptsHkStDQBhA+
 UCDg==
X-Gm-Message-State: AOAM531skhQ35SRWXuupjXtJN1L45nsb/Kc0Q12pQ9xit9TQBhAAR5av
 s7mL4rWHqQM8nsPifAHw39fj6Gex9QzSyn7YbjkL0vDB4LEUl/rcXqwW+Msdj56bkAhc5TxLOB9
 hkeCLYF4Cy88Ertb3lPxHf8Ltsmiawg==
X-Received: by 2002:aca:6505:: with SMTP id m5mr18776747oim.93.1622586150038; 
 Tue, 01 Jun 2021 15:22:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxi5D5R/YKBkpuFV42WBo2g+RPZt7CRIoVFlvzPv1SWguiDXnA+px3cN3uoGLgwkwtxnkMPhw==
X-Received: by 2002:aca:6505:: with SMTP id m5mr18776727oim.93.1622586149841; 
 Tue, 01 Jun 2021 15:22:29 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
 by smtp.gmail.com with ESMTPSA id w10sm3658007oou.35.2021.06.01.15.22.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jun 2021 15:22:29 -0700 (PDT)
Date: Tue, 1 Jun 2021 16:22:25 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210601162225.259923bc.alex.williamson@redhat.com>
In-Reply-To: <MWHPR11MB188685D57653827B566BF9B38C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528200311.GP1002214@nvidia.com>
 <MWHPR11MB188685D57653827B566BF9B38C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Gibson <david@gibson.dropbear.id.au>, Jason Gunthorpe <jgg@nvidia.com>,
 David Woodhouse <dwmw2@infradead.org>, Jason Wang <jasowang@redhat.com>
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

On Tue, 1 Jun 2021 07:01:57 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:
> 
> I summarized five opens here, about:
> 
> 1)  Finalizing the name to replace /dev/ioasid;
> 2)  Whether one device is allowed to bind to multiple IOASID fd's;
> 3)  Carry device information in invalidation/fault reporting uAPI;
> 4)  What should/could be specified when allocating an IOASID;
> 5)  The protocol between vfio group and kvm;
> 
...
> 
> For 5), I'd expect Alex to chime in. Per my understanding looks the
> original purpose of this protocol is not about I/O address space. It's
> for KVM to know whether any device is assigned to this VM and then
> do something special (e.g. posted interrupt, EPT cache attribute, etc.).

Right, the original use case was for KVM to determine whether it needs
to emulate invlpg, so it needs to be aware when an assigned device is
present and be able to test if DMA for that device is cache coherent.
The user, QEMU, creates a KVM "pseudo" device representing the vfio
group, providing the file descriptor of that group to show ownership.
The ugly symbol_get code is to avoid hard module dependencies, ie. the
kvm module should not pull in or require the vfio module, but vfio will
be present if attempting to register this device.

With kvmgt, the interface also became a way to register the kvm pointer
with vfio for the translation mentioned elsewhere in this thread.

The PPC/SPAPR support allows KVM to associate a vfio group to an IOMMU
page table so that it can handle iotlb programming from pre-registered
memory without trapping out to userspace.

> Because KVM deduces some policy based on the fact of assigned device, 
> it needs to hold a reference to related vfio group. this part is irrelevant
> to this RFC. 

All of these use cases are related to the IOMMU, whether DMA is
coherent, translating device IOVA to GPA, and an acceleration path to
emulate IOMMU programming in kernel... they seem pretty relevant.

> But ARM's VMID usage is related to I/O address space thus needs some
> consideration. Another strange thing is about PPC. Looks it also leverages
> this protocol to do iommu group attach: kvm_spapr_tce_attach_iommu_
> group. I don't know why it's done through KVM instead of VFIO uAPI in
> the first place.

AIUI, IOMMU programming on PPC is done through hypercalls, so KVM needs
to know how to handle those for in-kernel acceleration.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
