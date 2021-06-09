Return-Path: <SRS0=g+Up=LD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29322C48BDF
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 15:20:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDBF660E0B
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 15:20:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDBF660E0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7262483CAB;
	Wed,  9 Jun 2021 15:20:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JfITCrb173q2; Wed,  9 Jun 2021 15:20:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5EC3383CA2;
	Wed,  9 Jun 2021 15:20:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28B73C000E;
	Wed,  9 Jun 2021 15:20:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0ECC7C000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 15:20:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E36B0400CB
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 15:20:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oqj-PNk35P6S for <iommu@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 15:20:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E3AF8400C3
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 15:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623252044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PicVeDSzjJZ/mxS+TZr8f7kpWvXfmAyXLh8N/PLr3hQ=;
 b=FSQeZP1LlH8fRB+7wEkGByJvelbAA26sEu5E6VnO05HaTCKk484fQw0Q8z9bSnVTyKX98E
 402xsCuViQlKj2JSYN0Q4vgY7JqHF1ttBgVl+y4qqdkMrf0Hm6h1rr3X/8vVeZGed6hxY1
 raaZW0x+r6FdP1X09xxXecbQxMSL2os=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-0gFp2TsbOnWR-XRiDmyXbw-1; Wed, 09 Jun 2021 11:20:43 -0400
X-MC-Unique: 0gFp2TsbOnWR-XRiDmyXbw-1
Received: by mail-wr1-f70.google.com with SMTP id
 z4-20020adfe5440000b0290114f89c9931so10869890wrm.17
 for <iommu@lists.linux-foundation.org>; Wed, 09 Jun 2021 08:20:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:subject:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PicVeDSzjJZ/mxS+TZr8f7kpWvXfmAyXLh8N/PLr3hQ=;
 b=OV5yjMJxngSzEj3cmvzMhpFio5MvGZWeqp7L3aXJ3l+/nnEG0xTRQBLRQkjiG7CvR/
 STbyWb/ZcBZI1K7oTqSyiOTNzijtc/MMsypooGvUbaSfAYVNApw1qAUWKrDK5fYbOjj7
 SABVDJinD8LcZh6pf3gNkhoQ0A1PqPdC8+Y9icPGtWRilhJTZUxnBIoEDLbhupjTuIIX
 0MU9zjwXPFyHv8iAlxHJKw532V23wrj//VcdrI9aqKNq4cmlo335UaxM6vQu1qQa2wpH
 XAnUemtncDCNiUfoZS9fPyvYqQzUN92r9yqBLzG7Oi1WfKm8TkDk16FC6KyWHyNZAwCy
 YuQQ==
X-Gm-Message-State: AOAM532eg8F5nyBZQAor/Z352i2k9NrrDi7azJdQeX/wLTbh2pQPn4UC
 tVc+2N6+nJx/aya+VAim8BLA1rS7V1epaNdLu524UMwtRJzOUpuBjLDc2/hvhiPD6ZASXphs1Y2
 Ue4Y/Z8XIPA5OdzNGjG5h0pDG36lNPA==
X-Received: by 2002:a05:600c:19d3:: with SMTP id
 u19mr389692wmq.100.1623252042082; 
 Wed, 09 Jun 2021 08:20:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUeEEwYkVR8QC7aBvWAjJFFsb6cPvIYtUmt8RzdHkXYWY8OazB5nxTKs/d19ZLhoyVa+icZg==
X-Received: by 2002:a05:600c:19d3:: with SMTP id
 u19mr389652wmq.100.1623252041769; 
 Wed, 09 Jun 2021 08:20:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id g21sm253830wrb.46.2021.06.09.08.20.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jun 2021 08:20:41 -0700 (PDT)
To: Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20210607175926.GJ1002214@nvidia.com>
 <fdb2f38c-da1f-9c12-af44-22df039fcfea@redhat.com>
 <20210608131547.GE1002214@nvidia.com>
 <89d30977-119c-49f3-3bf6-d3f7104e07d8@redhat.com>
 <20210608124700.7b9aa5a6.alex.williamson@redhat.com>
 <20210608190022.GM1002214@nvidia.com>
 <ec0b1ef9-ae2f-d6c7-99b7-4699ced146e4@metux.net>
 <671efe89-2430-04fa-5f31-f52589276f01@redhat.com>
 <20210609115445.GX1002214@nvidia.com>
 <20210609083134.396055e3.alex.williamson@redhat.com>
 <20210609144530.GD1002214@nvidia.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <b9df3330-3f27-7421-d5fc-3124c61bacf3@redhat.com>
Date: Wed, 9 Jun 2021 17:20:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210609144530.GD1002214@nvidia.com>
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
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
 Robin Murphy <robin.murphy@arm.com>,
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

On 09/06/21 16:45, Jason Gunthorpe wrote:
> On Wed, Jun 09, 2021 at 08:31:34AM -0600, Alex Williamson wrote:
> 
>> If we go back to the wbinvd ioctl mechanism, if I call that ioctl with
>> an ioasidfd that contains no devices, then I shouldn't be able to
>> generate a wbinvd on the processor, right?  If I add a device,
>> especially in a configuration that can generate non-coherent DMA, now
>> that ioctl should work.  If I then remove all devices from that ioasid,
>> what then is the difference from the initial state.  Should the ioctl
>> now work because it worked once in the past?
> 
> The ioctl is fine, but telling KVM to enable WBINVD is very similar to
> open and then reconfiguring the ioasid_fd is very similar to
> chmod. From a security perspective revoke is not strictly required,
> IMHO.

I absolutely do *not* want an API that tells KVM to enable WBINVD.  This 
is not up for discussion.

But really, let's stop calling the file descriptor a security proof or a 
capability.  It's overkill; all that we are doing here is kernel 
acceleration of the WBINVD ioctl.

As a thought experiment, let's consider what would happen if wbinvd 
caused an unconditional exit from guest to userspace.  Userspace would 
react by invoking the ioctl on the ioasid.  The proposed functionality 
is just an acceleration of this same thing, avoiding the 
guest->KVM->userspace->IOASID->wbinvd trip.

This is why the API that I want, and that is already exists for VFIO 
group file descriptors, informs KVM of which "ioctls" the guest should 
be able to do via privileged instructions[1].  Then the kernel works out 
with KVM how to ensure a 1:1 correspondence between the operation of the 
ioctls and the privileged operations.

One way to do it would be to always trap WBINVD and invoke the same 
kernel function that implements the ioctl.  The function would do either 
a wbinvd or nothing, based on whether the ioasid has any device.  The 
next logical step is a notification mechanism that enables WBINVD (by 
disabling the WBINVD intercept) when there are devices in the ioasidfd, 
and disables WBINVD (by enabling a no-op intercept) when there are none.

And in fact once all VFIO devices are gone, wbinvd is for all purposes a 
no-op as far as the guest kernel can tell.  So there's no reason to 
treat it as anything but a no-op.

Thanks,

Paolo

[1] As an aside, I must admit I didn't entirely understand the design of 
the KVM-VFIO device back when Alex added it.  But with this model it was 
absolutely the right thing to do, and it remains the right thing to do 
even if VFIO groups are replaced with IOASID file descriptors.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
