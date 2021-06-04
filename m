Return-Path: <SRS0=eMD9=K6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7633C07E94
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 15:40:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7551861405
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 15:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7551861405
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4848260834;
	Fri,  4 Jun 2021 15:40:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wcjBlRTMIfRz; Fri,  4 Jun 2021 15:40:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E9DB6063D;
	Fri,  4 Jun 2021 15:40:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6DE84C000D;
	Fri,  4 Jun 2021 15:40:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92AFEC0001
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 15:40:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6FFCA84190
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 15:40:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XmmTG2wNGtiT for <iommu@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 15:40:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BA5A383D4E
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 15:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622821241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aDzH96dJVfpl3m5Uje4rnGEyfhG12oB1O5EB1V0U560=;
 b=ACq8eSq6nE2BrEckIns0/Pby6a+aAr6Wj0a5bSutIFmI6fcRhkMmRV775VBhGQNFFiaQyi
 b4v5SyD+0nz+gEwtKtKy0neDWPCAMi31CMyeUKxmdT6rD1bKVUXwTLNEmBqY+0n3EeUlDx
 PlbC7naWSEuX+GLKt2W4HU9oBQ5AVzk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-KF4gsOWVN5iUMurBfqkrJg-1; Fri, 04 Jun 2021 11:40:38 -0400
X-MC-Unique: KF4gsOWVN5iUMurBfqkrJg-1
Received: by mail-ed1-f71.google.com with SMTP id
 s25-20020aa7c5590000b0290392e051b029so151673edr.11
 for <iommu@lists.linux-foundation.org>; Fri, 04 Jun 2021 08:40:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aDzH96dJVfpl3m5Uje4rnGEyfhG12oB1O5EB1V0U560=;
 b=sD1s7b1Zl16f9bDu1rMvWrfSw1DmteLbUl4xHNGtwZBDVImpxgEHwVJOykTqFSegs0
 OBhb6WmiNtp/WvT5Di0kUziD7z5joZSXfTtU+cyS2ddXGoDutHq+b2IPVBx/cCcV8+AT
 QxQ7krNB50OuN3LpmjY4gne+m4YNTZtAqUvl16sisUbEttuhl9vf+abklnHHGw6VfElQ
 k58Vuzi3LZa1JUvMnzdXkH7PniK6f6o4Nvz3if1PAQe60uVT0IVSN1MRAWlZnLVpItJw
 4RuP1YViOpPwTWtYz+0LpMTns8hmZaIqx8ViEN7ThPu8Z0iXd4zpjU9sbdnY/OOIsjxX
 GILg==
X-Gm-Message-State: AOAM533e4qwXGm48rAzQjXGm32rWdHAoDBP1brmEVxYv5JDqBWDBT+n1
 2vMdCFLy3b1aG0Oect48d47G79C0miPGHlaEyQ+xxIz1q8Zi5ZJ9uXdDa2V4pv0dfbSS554FYSI
 0IVzDMYSiv53pT8P1AyqzUZwZsSA+Fw==
X-Received: by 2002:a17:906:1311:: with SMTP id
 w17mr4887090ejb.182.1622821237122; 
 Fri, 04 Jun 2021 08:40:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6OCuqC7otvjEPCd4UoW7TVyEyfhe9GbhSP/JT/jCZOXKJpVdvegR5UaYYFwES/zgZcL7xYQ==
X-Received: by 2002:a17:906:1311:: with SMTP id
 w17mr4887058ejb.182.1622821236938; 
 Fri, 04 Jun 2021 08:40:36 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id m12sm3393422edc.40.2021.06.04.08.40.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jun 2021 08:40:36 -0700 (PDT)
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20210602130053.615db578.alex.williamson@redhat.com>
 <20210602195404.GI1002214@nvidia.com>
 <20210602143734.72fb4fa4.alex.williamson@redhat.com>
 <20210602224536.GJ1002214@nvidia.com>
 <20210602205054.3505c9c3.alex.williamson@redhat.com>
 <20210603123401.GT1002214@nvidia.com>
 <20210603140146.5ce4f08a.alex.williamson@redhat.com>
 <20210603201018.GF1002214@nvidia.com>
 <20210603154407.6fe33880.alex.williamson@redhat.com>
 <MWHPR11MB1886469C0136C6523AB158B68C3B9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210604122830.GK1002214@nvidia.com>
 <20210604092620.16aaf5db.alex.williamson@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <815fd392-0870-f410-cbac-859070df1b83@redhat.com>
Date: Fri, 4 Jun 2021 17:40:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210604092620.16aaf5db.alex.williamson@redhat.com>
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

On 04/06/21 17:26, Alex Williamson wrote:
> Let's make sure the KVM folks are part of this decision; a re-cap for
> them, KVM currently automatically enables wbinvd emulation when
> potentially non-coherent devices are present which is determined solely
> based on the IOMMU's (or platform's, as exposed via the IOMMU) ability
> to essentially force no-snoop transactions from a device to be cache
> coherent.  This synchronization is triggered via the kvm-vfio device,
> where QEMU creates the device and adds/removes vfio group fd
> descriptors as an additionally layer to prevent the user from enabling
> wbinvd emulation on a whim.
> 
> IIRC, this latter association was considered a security/DoS issue to
> prevent a malicious guest/userspace from creating a disproportionate
> system load.
> 
> Where would KVM stand on allowing more direct userspace control of
> wbinvd behavior?  Would arbitrary control be acceptable or should we
> continue to require it only in association to a device requiring it for
> correct operation.

Extending the scenarios where WBINVD is not a nop is not a problem for 
me.  If possible I wouldn't mind keeping the existing kvm-vfio 
connection via the device, if only because then the decision remains in 
the VFIO camp (whose judgment I trust more than mine on this kind of issue).

For example, would it make sense if *VFIO* (not KVM) gets an API that 
says "I am going to do incoherent DMA"?  Then that API causes WBINVD to 
become not-a-nop even on otherwise coherent platforms.  (Would this make 
sense at all without a hypervisor that indirectly lets userspace execute 
WBINVD?  Perhaps VFIO would benefit from a WBINVD ioctl too).

Paolo

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
