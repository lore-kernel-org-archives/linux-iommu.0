Return-Path: <SRS0=eMD9=K6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89CFC4708F
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 16:11:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58A7C613F4
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 16:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A7C613F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D68160799;
	Fri,  4 Jun 2021 16:11:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WSpSW8kFnrwY; Fri,  4 Jun 2021 16:11:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0920B606F5;
	Fri,  4 Jun 2021 16:11:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD777C000E;
	Fri,  4 Jun 2021 16:11:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F824C0001
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 16:11:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3CEA660795
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 16:11:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7MQoW_XBpSwN for <iommu@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 16:10:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 69B0C606F5
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 16:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622823057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RTnd3yVJTH9740JT32WVCu1PAebhuUq28dsvMUvas14=;
 b=VdWuZWdOacPiVTeS3sclnw7wH3U7ujutYCBGUnyP/EYYnJc7wcwvy0ZjRIODov9pbQcW0v
 yxkqLBkSTQoPPR43I8b1LSfkd090gjlwUIAu9+eUtMie1DDr3xHg9bfwNQLo/Vq8R3NHq7
 j0snjd8uaVvGf3xtiSo0cPJRBxs3I+0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-zHMdWogNOVWLx8-QHy-_aQ-1; Fri, 04 Jun 2021 12:10:55 -0400
X-MC-Unique: zHMdWogNOVWLx8-QHy-_aQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 q7-20020a1709063607b02903f57f85ac45so3608951ejb.15
 for <iommu@lists.linux-foundation.org>; Fri, 04 Jun 2021 09:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:subject:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RTnd3yVJTH9740JT32WVCu1PAebhuUq28dsvMUvas14=;
 b=aJwrU1grvALQtGJWDWou2/U4lrC5ObbWvOh5Tm7Bb4DguZ9nrnAoyIxEev1/09nT1A
 nnZMyQxXmqhUQusdsMiNR3304xepT1RoFeDaQhrcSPiti91VePSZAjxfS5wYjTeTJfgz
 nygU77sy+eju1CCcda8B8GUmOHGVdsqgIVBKi+EX4VdflZVQ54eH1tRFe9CjDGi0xqJC
 qhTcGc/4Jzu0lhpC2D5LSKyVPjK6iCArLgTTPRNz7xYm9IAAYAf52J4JKrOQWN582XL3
 tue34NcbY+Yatcf9Qlc6EllUmdz3eHr+FU8kSlsXcKm4g51zCLGKmjEnSapd6F7SXJ3y
 SJJQ==
X-Gm-Message-State: AOAM532WhR9iGt2u4cr1TGUrotpyJrB9kPHfaBzFhYCgCNmWEmgHK/fr
 j2F+RRISjftECj8eAco8l9hcEwhPrhS5aPamxAUxPH4n/TbD4zN/q0NFCN2umleroWXgCBB+ykd
 m14Ad08w4Sx+mTaHJOOfUR3vJbp/i0Q==
X-Received: by 2002:a05:6402:342:: with SMTP id
 r2mr5564713edw.69.1622823054172; 
 Fri, 04 Jun 2021 09:10:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxl+Ws1Chi8vFl+XGY47+7Vk/he3YcPPXFlfuf7NcSLW1TqV0Dzd1EqxORRIL3XKm5Xuw9+Ww==
X-Received: by 2002:a05:6402:342:: with SMTP id
 r2mr5564684edw.69.1622823053958; 
 Fri, 04 Jun 2021 09:10:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id m4sm2915547eje.8.2021.06.04.09.10.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jun 2021 09:10:53 -0700 (PDT)
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20210603123401.GT1002214@nvidia.com>
 <20210603140146.5ce4f08a.alex.williamson@redhat.com>
 <20210603201018.GF1002214@nvidia.com>
 <20210603154407.6fe33880.alex.williamson@redhat.com>
 <MWHPR11MB1886469C0136C6523AB158B68C3B9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210604122830.GK1002214@nvidia.com>
 <20210604092620.16aaf5db.alex.williamson@redhat.com>
 <815fd392-0870-f410-cbac-859070df1b83@redhat.com>
 <20210604155016.GR1002214@nvidia.com>
 <30e5c597-b31c-56de-c75e-950c91947d8f@redhat.com>
 <20210604160336.GA414156@nvidia.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <2c62b5c7-582a-c710-0436-4ac5e8fd8b39@redhat.com>
Date: Fri, 4 Jun 2021 18:10:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210604160336.GA414156@nvidia.com>
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

On 04/06/21 18:03, Jason Gunthorpe wrote:
> On Fri, Jun 04, 2021 at 05:57:19PM +0200, Paolo Bonzini wrote:
>> I don't want a security proof myself; I want to trust VFIO to make the right
>> judgment and I'm happy to defer to it (via the KVM-VFIO device).
>>
>> Given how KVM is just a device driver inside Linux, VMs should be a slightly
>> more roundabout way to do stuff that is accessible to bare metal; not a way
>> to gain extra privilege.
> 
> Okay, fine, lets turn the question on its head then.
> 
> VFIO should provide a IOCTL VFIO_EXECUTE_WBINVD so that userspace VFIO
> application can make use of no-snoop optimizations. The ability of KVM
> to execute wbinvd should be tied to the ability of that IOCTL to run
> in a normal process context.
> 
> So, under what conditions do we want to allow VFIO to giave a process
> elevated access to the CPU:

Ok, I would definitely not want to tie it *only* to CAP_SYS_RAWIO (i.e. 
#2+#3 would be worse than what we have today), but IIUC the proposal 
(was it yours or Kevin's?) was to keep #2 and add #1 with an 
enable/disable ioctl, which then would be on VFIO and not on KVM.  I 
assumed Alex was more or less okay with it, given he included me in the 
discussion.

If later y'all switch to "it's always okay to issue the enable/disable 
ioctl", I guess the rationale would be documented in the commit message.

Paolo

>>>    1) User has access to a device that can issue no-snoop TLPS
>>>    2) User has access to an IOMMU that can not block no-snoop (today)
>>>    3) Require CAP_SYS_RAW_IO
>>>    4) Anyone
> 
> Jason
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
