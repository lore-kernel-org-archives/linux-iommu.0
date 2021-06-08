Return-Path: <SRS0=69++=LC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E9DC4743E
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 13:44:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13A466128E
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 13:44:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A466128E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D010A400ED;
	Tue,  8 Jun 2021 13:44:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xlyauTLcdAJR; Tue,  8 Jun 2021 13:44:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id B8F61400E7;
	Tue,  8 Jun 2021 13:44:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F7CCC000B;
	Tue,  8 Jun 2021 13:44:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E80D1C0001
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 13:44:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D227940454
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 13:44:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pRGmS-j2cduY for <iommu@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 13:44:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0665B40450
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 13:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623159870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A5paOCX7lF4w7/DDN73q8qlAZey0BD12yaLQLY3fG8Y=;
 b=OgVbcMjuLZxP/Q38FMVw8iDIel+vGOS38pVWmZMGt+1MJb3d1iopbsogUv9k3ONEXYJGpP
 sI0LdfqG1BRchVtJGFx7uVUg0qpvINw/dKVYUdYhAczJ/eJHx1CvyVxM0c9dU/DVmnr1zX
 op8V94r4MJfsKp3+wOHeZdauVboqBSU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-lSvMpEzHOEierXBvVY7S-Q-1; Tue, 08 Jun 2021 09:44:29 -0400
X-MC-Unique: lSvMpEzHOEierXBvVY7S-Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 18-20020a05600c0252b029019a0ce35d36so1223196wmj.4
 for <iommu@lists.linux-foundation.org>; Tue, 08 Jun 2021 06:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:subject:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=A5paOCX7lF4w7/DDN73q8qlAZey0BD12yaLQLY3fG8Y=;
 b=fm0MRTRcZZ5l8CdzBOIHtJfgpIS8mhFg0QvGXTxpKmc+XhhmYNlBePdf9wium7lSUL
 6ybPP3jzDyU1HrAiVLmQnDNziImCuBT8+VcnH+3KcWBdC6jafRnXR8rKgxLa1QkshRJq
 3/wRaL9WQgAAFZrcJIBE3kT3XDS4p2Uj1bLppCPPozZHp1EIheMJNw74EL+7Dn/w0aAF
 cOquTRkrZDcuhgKDlRZ7pGQmkBaWY03JKDS5yA5ViyrMK3BJGwLiKmm49kuhJ/r3DOFg
 00DwbNyvurGoWP1zk009F7fiGqqjAHqED7bu7FqZ8T5eP/P5Liz1uCQedGFjxaFNpLPN
 aIeQ==
X-Gm-Message-State: AOAM531cx+nN4KMAam58QvMdUK7iqQxzNe8nu0TGM/RRdfYegosCs0F1
 /f4JMczNIO8J6ZjimZ3wEMInkOcj5nwe/gS6uD66k7qL4L3cz0p8UjcIbYlcg7bmf4ZhX12+lnY
 FtAK9DisUntldccXHr9SEOADmQVNr3Q==
X-Received: by 2002:a1c:770b:: with SMTP id t11mr4365990wmi.79.1623159868319; 
 Tue, 08 Jun 2021 06:44:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQ4k7LKRkmCCY0f1XvUXyPaQaBTTeWBOUxIheggqPU28l8+khIBLNZhCQK0mJgXqCT2XApuw==
X-Received: by 2002:a1c:770b:: with SMTP id t11mr4365974wmi.79.1623159868149; 
 Tue, 08 Jun 2021 06:44:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id o17sm19012181wrp.47.2021.06.08.06.44.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jun 2021 06:44:27 -0700 (PDT)
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20210604092620.16aaf5db.alex.williamson@redhat.com>
 <815fd392-0870-f410-cbac-859070df1b83@redhat.com>
 <20210604155016.GR1002214@nvidia.com>
 <30e5c597-b31c-56de-c75e-950c91947d8f@redhat.com>
 <20210604160336.GA414156@nvidia.com>
 <2c62b5c7-582a-c710-0436-4ac5e8fd8b39@redhat.com>
 <20210604172207.GT1002214@nvidia.com>
 <2d1ad075-bec6-bfb9-ce71-ed873795e973@redhat.com>
 <20210607175926.GJ1002214@nvidia.com>
 <fdb2f38c-da1f-9c12-af44-22df039fcfea@redhat.com>
 <20210608131547.GE1002214@nvidia.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <89d30977-119c-49f3-3bf6-d3f7104e07d8@redhat.com>
Date: Tue, 8 Jun 2021 15:44:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210608131547.GE1002214@nvidia.com>
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

On 08/06/21 15:15, Jason Gunthorpe wrote:
> On Tue, Jun 08, 2021 at 09:56:09AM +0200, Paolo Bonzini wrote:
> 
>>>> Alternatively you can add a KVM_DEV_IOASID_{ADD,DEL} pair of ioctls. But it
>>>> seems useless complication compared to just using what we have now, at least
>>>> while VMs only use IOASIDs via VFIO.
>>>
>>> The simplest is KVM_ENABLE_WBINVD(<fd security proof>) and be done
>>> with it.
>>
>> The simplest one is KVM_DEV_VFIO_GROUP_ADD/DEL, that already exists and also
>> covers hot-unplug.  The second simplest one is KVM_DEV_IOASID_ADD/DEL.
> 
> This isn't the same thing, this is back to trying to have the kernel
> set policy for userspace.

If you want a userspace policy then there would be three states:

* WBINVD enabled because a WBINVD-enabled VFIO device is attached.

* WBINVD potentially enabled but no WBINVD-enabled VFIO device attached

* WBINVD forcefully disabled

KVM_DEV_VFIO_GROUP_ADD/DEL can still be used to distinguish the first 
two.  Due to backwards compatibility, those two describe the default 
behavior; disabling wbinvd can be done easily with a new sub-ioctl of 
KVM_ENABLE_CAP and doesn't require any security proof.

The meaning of WBINVD-enabled is "won't return -ENXIO for the wbinvd 
ioctl", nothing more nothing less.  If all VFIO devices are going to be 
WBINVD-enabled, then that will reflect on KVM as well, and I won't have 
anything to object if there's consensus on the device assignment side of 
things that the wbinvd ioctl won't ever fail.

Paolo

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
