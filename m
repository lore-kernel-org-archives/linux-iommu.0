Return-Path: <SRS0=69++=LC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E11C47082
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 07:56:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 926346127A
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 07:56:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926346127A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A1E6403EC;
	Tue,  8 Jun 2021 07:56:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6ppy6RpLyZns; Tue,  8 Jun 2021 07:56:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id E8F6840386;
	Tue,  8 Jun 2021 07:56:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8865C000B;
	Tue,  8 Jun 2021 07:56:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3DC69C0001
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 07:56:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 25CA383A8B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 07:56:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HX4cLGHIMzGt for <iommu@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 07:56:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2945783A8A
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 07:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623138978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zYa5WyN5uAc4A4H86TawfNojJdggPMlZ/sRJ1BGKDOY=;
 b=hJBLqZ2NABIxr2ZV/r0H++Ps67V0vrQNBltsHD0Ce9zuaGgBVtguo+h2fvqRTfBqiwvJYY
 /ImCqOUAEHYx2B9OUYc9eZJZ5cgDPfcdXTg4pvqWldpjI4devyGLiOmr0d6Ig42yQzbzkw
 LMMSkGjo5s6gF+aERP8hIA6M1EGnwdY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-K1fe8Q6tMCS4jsc7W-uuqA-1; Tue, 08 Jun 2021 03:56:13 -0400
X-MC-Unique: K1fe8Q6tMCS4jsc7W-uuqA-1
Received: by mail-wm1-f72.google.com with SMTP id
 z62-20020a1c65410000b0290179bd585ef9so347971wmb.7
 for <iommu@lists.linux-foundation.org>; Tue, 08 Jun 2021 00:56:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zYa5WyN5uAc4A4H86TawfNojJdggPMlZ/sRJ1BGKDOY=;
 b=dVtWRNUTKhLfxPnuM/zP/Cg7f67rsY6Ky06uozgxBSVcJKIhBCULBFhvhlVCp8XLCU
 sr6fwIErh+POXXf0EM86g61oyrvTiWMIdiT2g/tjPFZ5a3QjZJxrdNKoog0ALryOrqrm
 YsSCn2CQ8jJmUkhwrIK5v7d9BjJ0EubJW/MhtmEAvxEXg1lg2FinEYH19xwQF0DXxgHY
 nkH75LJX0HjGWSauiIXol2wAbeHrAkOukSTFfqSGI5mRmgsEoqRgsHYYlzJFm7KJTfNF
 P7cWJHtouxwpybQjU6nB/0haVgX1sgl8QKvpwt2fkvKDL2E8YHfVBCqdJ471muf6pfp6
 NnCg==
X-Gm-Message-State: AOAM531gwCLX9nLqEcECUDVQhLUHTFUXXvOE8oC4Ty9leIqQtPatzCv0
 AVyWfodHKn/ccMevILzHZ2n/hOuwbIzVc68wQyzbICovV/ESUkANdcU8R+kxL9/RmU4v+AHJn2D
 pBk/0pE5ol/pOTPj5LVEwKqTlLQDhyw==
X-Received: by 2002:a5d:5752:: with SMTP id q18mr21241453wrw.419.1623138972168; 
 Tue, 08 Jun 2021 00:56:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxv6B3Fm9uWkkuLZ42Sp23/j0I/On5RIFlSJAMEPX1XlarvGPgTQWrWA1V8+3s21lkavNZEgg==
X-Received: by 2002:a5d:5752:: with SMTP id q18mr21241386wrw.419.1623138971579; 
 Tue, 08 Jun 2021 00:56:11 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e?
 ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id l31sm1910414wms.16.2021.06.08.00.56.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jun 2021 00:56:11 -0700 (PDT)
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: Jason Gunthorpe <jgg@nvidia.com>
References: <MWHPR11MB1886469C0136C6523AB158B68C3B9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210604122830.GK1002214@nvidia.com>
 <20210604092620.16aaf5db.alex.williamson@redhat.com>
 <815fd392-0870-f410-cbac-859070df1b83@redhat.com>
 <20210604155016.GR1002214@nvidia.com>
 <30e5c597-b31c-56de-c75e-950c91947d8f@redhat.com>
 <20210604160336.GA414156@nvidia.com>
 <2c62b5c7-582a-c710-0436-4ac5e8fd8b39@redhat.com>
 <20210604172207.GT1002214@nvidia.com>
 <2d1ad075-bec6-bfb9-ce71-ed873795e973@redhat.com>
 <20210607175926.GJ1002214@nvidia.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fdb2f38c-da1f-9c12-af44-22df039fcfea@redhat.com>
Date: Tue, 8 Jun 2021 09:56:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210607175926.GJ1002214@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
 David Gibson <david@gibson.dropbear.id.au>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 07/06/21 19:59, Jason Gunthorpe wrote:
>> The KVM interface is the same kvm-vfio device that exists already.  The
>> userspace API does not need to change at all: adding one VFIO file
>> descriptor with WBINVD enabled to the kvm-vfio device lets the VM use WBINVD
>> functionality (see kvm_vfio_update_coherency).
>
> The problem is we are talking about adding a new /dev/ioasid FD and it
> won't fit into the existing KVM VFIO FD interface. There are lots of
> options here, one is to add new ioctls that specifically use the new
> FD, the other is to somehow use VFIO as a proxy to carry things to the
> /dev/ioasid FD code.

Exactly.

>> Alternatively you can add a KVM_DEV_IOASID_{ADD,DEL} pair of ioctls. But it
>> seems useless complication compared to just using what we have now, at least
>> while VMs only use IOASIDs via VFIO.
>
> The simplest is KVM_ENABLE_WBINVD(<fd security proof>) and be done
> with it.

The simplest one is KVM_DEV_VFIO_GROUP_ADD/DEL, that already exists and 
also covers hot-unplug.  The second simplest one is KVM_DEV_IOASID_ADD/DEL.

It need not be limited to wbinvd support, it's just a generic "let VMs 
do what userspace can do if it has access to this file descriptor". 
That it enables guest WBINVD is an implementation detail.

>> Either way, there should be no policy attached to the add/delete operations.
>> KVM users want to add the VFIO (or IOASID) file descriptors to the device
>> independent of WBINVD.  If userspace wants/needs to apply its own policy on
>> whether to enable WBINVD or not, they can do it on the VFIO/IOASID side:
> 
> Why does KVM need to know abut IOASID's? I don't think it can do
> anything with this general information.

Indeed, it only uses them as the security proofs---either VFIO or IOASID 
file descriptors can be used as such.

Paolo

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
