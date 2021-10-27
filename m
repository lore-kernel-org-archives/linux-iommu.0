Return-Path: <SRS0=XM0R=PP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F7FC4332F
	for <iommu@archiver.kernel.org>; Wed, 27 Oct 2021 10:32:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C70F6109E
	for <iommu@archiver.kernel.org>; Wed, 27 Oct 2021 10:32:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5C70F6109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2211C404E6;
	Wed, 27 Oct 2021 10:32:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5WpIQbc6WK9m; Wed, 27 Oct 2021 10:32:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E7BB240502;
	Wed, 27 Oct 2021 10:32:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2F9FC0019;
	Wed, 27 Oct 2021 10:32:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2CD4C000E
 for <iommu@lists.linux-foundation.org>; Wed, 27 Oct 2021 10:32:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B2B2F80D9C
 for <iommu@lists.linux-foundation.org>; Wed, 27 Oct 2021 10:32:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1ePAF2bXMdPr for <iommu@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 10:32:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ED64080D0B
 for <iommu@lists.linux-foundation.org>; Wed, 27 Oct 2021 10:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635330750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZpDTbLV2n+Qg6lI0UNtzA072Lo2usMm1q8b+tx7LSww=;
 b=ewCCCbPpqxJECAK54phuTv3dgFtjiBE69WczUFeNDWPUfFwCGOlK83MIg/AIVpOaChATnn
 lQXziwIsQj/RLvynisi+ycSxyMyHtkhfUxxQNpOrJQ/1iDfVDTee0fZVubDpmh/tyL7RRA
 oJoIbeb9L3jgGJIHu8jYel4EUtpH+qw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-OLo9ptcXP5-d2ePt79IwHQ-1; Wed, 27 Oct 2021 06:32:29 -0400
X-MC-Unique: OLo9ptcXP5-d2ePt79IwHQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 s12-20020a50dacc000000b003dbf7a78e88so1914049edj.2
 for <iommu@lists.linux-foundation.org>; Wed, 27 Oct 2021 03:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=ZpDTbLV2n+Qg6lI0UNtzA072Lo2usMm1q8b+tx7LSww=;
 b=bevMle59/qaUm0Wf0LpOFEoddGwr5R+o6zgOGasBqBpLpBOAFszXucvKrN4mQzfJzO
 SPHFHRAvjuj8WVQHd+55D2Mr9fMRFSh+aznSLHfeUXYXuIcM06PZkNDSrblyH/hqXZLy
 6ZP5etsiB1s/BrL57vbk17f2lqBULNcrmv8HD9fddba5UPJsKJwarYSdfH6Eh8faTE2L
 ALbbVRiOPpqLO1n2kb3DZ8LwISu+Pmw1bbkvO4XyWdnPdJ7a74hbGvjxxJxqHPpTJblD
 4SI+AtyUpQtfJqAXakRiK2ZwBW5zF3KyqGEHdwn8U8mppVpY26eEOkoAX/ZVWlVTcOf5
 kMrQ==
X-Gm-Message-State: AOAM533sinytY/HQYQadlG40Id7QxF4KF4sEIummGu1w+qD6JVhwuQS+
 pwBs0zcOFirhDb40tWryf+E+TeCitKU0CVcCPdINRHuDBIPL7rgwRnto2gtlqKJHBAT40EVGPxy
 3J0hrujq3ER6CyVtzfNUjAE4GGnI83g==
X-Received: by 2002:a17:906:646:: with SMTP id
 t6mr33637697ejb.209.1635330748436; 
 Wed, 27 Oct 2021 03:32:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJp0E2xSwEzNmUoGavtAqs86aKHQkha4V0D9DUdm+C+KykQjUFDJc6UWr5b0bUCQFwuTsmPQ==
X-Received: by 2002:a17:906:646:: with SMTP id
 t6mr33637680ejb.209.1635330748210; 
 Wed, 27 Oct 2021 03:32:28 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id nb1sm5770785ejc.56.2021.10.27.03.32.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Oct 2021 03:32:27 -0700 (PDT)
Message-ID: <861c6a1f-a68d-85fc-e6d2-1cd90f32f86a@redhat.com>
Date: Wed, 27 Oct 2021 12:32:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
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
 <b9df3330-3f27-7421-d5fc-3124c61bacf3@redhat.com>
 <BN9PR11MB5433B2E25895D240BA3B182B8C859@BN9PR11MB5433.namprd11.prod.outlook.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <BN9PR11MB5433B2E25895D240BA3B182B8C859@BN9PR11MB5433.namprd11.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 David Woodhouse <dwmw2@infradead.org>, Jason Wang <jasowang@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, Kirti Wankhede <kwankhede@nvidia.com>,
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

On 27/10/21 08:18, Tian, Kevin wrote:
>> I absolutely do *not* want an API that tells KVM to enable WBINVD.  This
>> is not up for discussion.
>>
>> But really, let's stop calling the file descriptor a security proof or a
>> capability.  It's overkill; all that we are doing here is kernel
>> acceleration of the WBINVD ioctl.
>>
>> As a thought experiment, let's consider what would happen if wbinvd
>> caused an unconditional exit from guest to userspace.  Userspace would
>> react by invoking the ioctl on the ioasid.  The proposed functionality
>> is just an acceleration of this same thing, avoiding the
>> guest->KVM->userspace->IOASID->wbinvd trip.
> 
> While the concept here makes sense, in reality implementing a wbinvd
> ioctl for userspace requiring iommufd (previous /dev/ioasid is renamed
> to /dev/iommu now) to track dirty CPUs that a given process has been
> running since wbinvd only flushes local cache.
> 
> Is it ok to omit the actual wbinvd ioctl here and just leverage vfio-kvm
> contract to manage whether guest wbinvd is emulated as no-op?

Yes, it'd be okay for me.  As I wrote in the message, the concept of a 
wbinvd ioctl is mostly important as a thought experiment for what is 
security sensitive and what is not.  If a wbinvd ioctl would not be 
privileged on the iommufd, then WBINVD is not considered privileged in a 
guest either.

That does not imply a requirement to implement the wbinvd ioctl, though. 
Of course, non-KVM usage of iommufd systems/devices with non-coherent 
DMA would be less useful; but that's already the case for VFIO.

> btw does kvm community set a strict criteria that any operation that
> the guest can do must be first carried in host uAPI first? In concept
> KVM deals with ISA-level to cover both guest kernel and guest user
> while host uAPI is only for host user. Introducing new uAPIs to allow
> host user doing whatever guest kernel can do sounds ideal, but not
> exactly necessary imho.

I agree; however, it's the right mindset in my opinion because 
virtualization (in a perfect world) should not be a way to give 
processes privilege to do something that they cannot do.  If it does, 
it's usually a good idea to ask yourself "should this functionality be 
accessible outside KVM too?".

Thanks,

Paolo

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
