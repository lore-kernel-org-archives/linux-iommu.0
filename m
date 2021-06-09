Return-Path: <SRS0=g+Up=LD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203B3C47095
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 09:11:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE10461285
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 09:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE10461285
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B68C608B9;
	Wed,  9 Jun 2021 09:11:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UU8NXKGgt1Az; Wed,  9 Jun 2021 09:11:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6AA1D6082B;
	Wed,  9 Jun 2021 09:11:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3227EC000E;
	Wed,  9 Jun 2021 09:11:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 374DDC000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 09:11:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1844E40169
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 09:11:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id clU5YpK0xHj9 for <iommu@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 09:11:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B54D7400D4
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 09:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623229883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ePZh2khRcBN5AJHEyhbtv31/bRFlPEJ4/4U8Xk0wMo=;
 b=M64qtcSJImQzhtgTOmErCPSUCVfDA27WQrMDsZFqi8D0nAbtoGdzbaTxmU2rm/6IvUdur8
 97wew9Q8uthhuJD3tN6uKK1eQumK/V2vxZ2P3dcpb+9mysRpkusFhUZ4m8MkTrcRWDmj4i
 WSpc2d9NP+6z2ZkajbUKi+AkS6m/jUU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-OFh-Ss3kPOezyuaw1mei1g-1; Wed, 09 Jun 2021 05:11:22 -0400
X-MC-Unique: OFh-Ss3kPOezyuaw1mei1g-1
Received: by mail-wm1-f71.google.com with SMTP id
 z62-20020a1c65410000b0290179bd585ef9so710273wmb.7
 for <iommu@lists.linux-foundation.org>; Wed, 09 Jun 2021 02:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2ePZh2khRcBN5AJHEyhbtv31/bRFlPEJ4/4U8Xk0wMo=;
 b=NYffQhlq65uTsyyQ7HlLWU7jMcH50FAAewj7Fbw/C9LObcNl0RxXHOP2pdzQ4wrv+v
 gYIapfML1eg4bVsJpBfh/umwwWo9L0dlaNzbPjEvKWsUY/l/fvayMJG7iEgtD+7t7BEa
 SfLRYHzRIUQlveGjurbbfYtrCtNGiaNjbcmAeT4PXsc6h3mSklIjMDP5/tps+E6v8yoU
 5MVsw9oOYoRKPV5HMM9HZrM+r1bRuzZXJ7cU3iOV9XZz8q68ByIM+a/dBQ71q2GCsEGt
 FKEGOWl76xbm1CQd7CrP1uWr4N+9zV6rq8OLZ3ynETI05ZJ2O4ZG/LmjlG63dzt02alL
 LjAA==
X-Gm-Message-State: AOAM533R2g1A2IO4Eb8erk7OPTgtpOVBStswRnWmbF5WegR2FbBVFJPK
 H9GmrZpT/MpnncnvieqL3/LgMCeDlJgJhWcygUMayfAJF1FFuNoM0NZOyWxRKRCUSVnlmWCs7XD
 iaOvvLEIl+8i8dj7PWUDhjKz6OGAxBA==
X-Received: by 2002:adf:e507:: with SMTP id j7mr26371289wrm.178.1623229880817; 
 Wed, 09 Jun 2021 02:11:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBSu8Kim/TFLMDmfSnepx2bA9qkajHoLuNSdNG99iK42XOJ0rk/n+XjBkjpM8nPppmmP/+6g==
X-Received: by 2002:adf:e507:: with SMTP id j7mr26371253wrm.178.1623229880319; 
 Wed, 09 Jun 2021 02:11:20 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id z3sm24335841wrl.13.2021.06.09.02.11.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jun 2021 02:11:19 -0700 (PDT)
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
 Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <30e5c597-b31c-56de-c75e-950c91947d8f@redhat.com>
 <20210604160336.GA414156@nvidia.com>
 <2c62b5c7-582a-c710-0436-4ac5e8fd8b39@redhat.com>
 <20210604172207.GT1002214@nvidia.com>
 <2d1ad075-bec6-bfb9-ce71-ed873795e973@redhat.com>
 <20210607175926.GJ1002214@nvidia.com>
 <fdb2f38c-da1f-9c12-af44-22df039fcfea@redhat.com>
 <20210608131547.GE1002214@nvidia.com>
 <89d30977-119c-49f3-3bf6-d3f7104e07d8@redhat.com>
 <20210608124700.7b9aa5a6.alex.williamson@redhat.com>
 <20210608190022.GM1002214@nvidia.com>
 <ec0b1ef9-ae2f-d6c7-99b7-4699ced146e4@metux.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <671efe89-2430-04fa-5f31-f52589276f01@redhat.com>
Date: Wed, 9 Jun 2021 11:11:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <ec0b1ef9-ae2f-d6c7-99b7-4699ced146e4@metux.net>
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

On 09/06/21 10:51, Enrico Weigelt, metux IT consult wrote:
> On 08.06.21 21:00, Jason Gunthorpe wrote:
> 
>> Eg I can do open() on a file and I get to keep that FD. I get to keep
>> that FD even if someone later does chmod() on that file so I can't
>> open it again.
>>
>> There are lots of examples where a one time access control check
>> provides continuing access to a resource. I feel the ongoing proof is
>> the rarity in Unix.. 'revoke' is an uncommon concept in Unix..
> 
> Yes, it's even possible that somebody w/ privileges opens an fd and
> hands it over to somebody unprivileged (eg. via unix socket). This is
> a very basic unix concept. If some (already opened) fd now suddenly
> behaves differently based on the current caller, that would be a break
> with traditional unix semantics.

That's already more or less meaningless for both KVM and VFIO, since 
they are tied to an mm.

Paolo

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
