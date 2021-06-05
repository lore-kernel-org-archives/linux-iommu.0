Return-Path: <SRS0=O6fU=K7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00733C47082
	for <iommu@archiver.kernel.org>; Sat,  5 Jun 2021 06:22:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FDFF61261
	for <iommu@archiver.kernel.org>; Sat,  5 Jun 2021 06:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FDFF61261
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C79083B2F;
	Sat,  5 Jun 2021 06:22:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gVB0AJX_SETn; Sat,  5 Jun 2021 06:22:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 30E6283B2B;
	Sat,  5 Jun 2021 06:22:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09E68C000D;
	Sat,  5 Jun 2021 06:22:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B880AC0001
 for <iommu@lists.linux-foundation.org>; Sat,  5 Jun 2021 06:22:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AC01F83B2C
 for <iommu@lists.linux-foundation.org>; Sat,  5 Jun 2021 06:22:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4kHRcQE1UqcV for <iommu@lists.linux-foundation.org>;
 Sat,  5 Jun 2021 06:22:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DDCFC83B2B
 for <iommu@lists.linux-foundation.org>; Sat,  5 Jun 2021 06:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622874155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZvsAQtJxlvGYxKy6a0thmzjRiqSNuCzh2tI1IIgfJ74=;
 b=ioFijiH4AMWDyvOcrUAOKpeNl5pUbRc2qKc5N+gYkAJnARGNOZYRA4GBbV7YLvTG9LTCqz
 /jiab7dP+c/FC4Ewh1vxnPumZywczp/JU9300Xg1FpfX044BsE1TYr/bmJjYUlsTPZMrmh
 HLPaT6KuYJWRJCuf3nmVHloOYoD0Vx8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-Uu8Wy_WoOZKgKlRK6Xs8eQ-1; Sat, 05 Jun 2021 02:22:30 -0400
X-MC-Unique: Uu8Wy_WoOZKgKlRK6Xs8eQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 s20-20020a0564025214b029038752a2d8f3so6339402edd.2
 for <iommu@lists.linux-foundation.org>; Fri, 04 Jun 2021 23:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:subject:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZvsAQtJxlvGYxKy6a0thmzjRiqSNuCzh2tI1IIgfJ74=;
 b=bAUudMTgxnffrg4J8FFmOF99+xZhcA1q3kNJ/Xv6nd3qNxGRSjYc2nRf8TKB5W7Wkj
 LkmL3xE/SscbUIu81eb7yvcbf5FABXqTH5IbvpKbjsWY2VDDDohku8LMT4y2SNRPzb5W
 kj8czWeALimYzW6meFzrseOhN27ZrFQ2/WItHTriwaLd9EvJGqxrHC31kb2vBgn5+gpI
 5RpifVKFTvrrDcWQPv9P2la4D6nATyBkmNcF6d0UxzgUc0Fyth615zFBSjwGGPTNF7VB
 gz4f5saEwH0ifthfi4090GCqEqyBahQnU+c0tuTxIamx+G7ekX0hDqDaWAe776Zyhl5f
 gQtw==
X-Gm-Message-State: AOAM530+ey4K4YsJH0cwIg+ztzniNtS/d2QaElK40RlyPUbyKgs2nAhR
 EEB9lBoQppP1hZWT86VsiYHVkJZZ5SxKSQDzymP2nX/PWVvZrDOgoFrNMOlszTUYnQNPCBDW4M3
 G2h3Cno1pOClVEH5ovo4ikMYRrBw+gw==
X-Received: by 2002:a05:6402:2317:: with SMTP id
 l23mr8829085eda.265.1622874149500; 
 Fri, 04 Jun 2021 23:22:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwK49j50iCoLz8VXH//DU+8dprCuzL/LFKrh/1Hkw7FIj9PlE8uSbie4kS68iqbJU9lm7EMQg==
X-Received: by 2002:a05:6402:2317:: with SMTP id
 l23mr8829061eda.265.1622874149296; 
 Fri, 04 Jun 2021 23:22:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id cx7sm4246774edb.65.2021.06.04.23.22.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jun 2021 23:22:28 -0700 (PDT)
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20210603201018.GF1002214@nvidia.com>
 <20210603154407.6fe33880.alex.williamson@redhat.com>
 <MWHPR11MB1886469C0136C6523AB158B68C3B9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210604122830.GK1002214@nvidia.com>
 <20210604092620.16aaf5db.alex.williamson@redhat.com>
 <815fd392-0870-f410-cbac-859070df1b83@redhat.com>
 <20210604155016.GR1002214@nvidia.com>
 <30e5c597-b31c-56de-c75e-950c91947d8f@redhat.com>
 <20210604160336.GA414156@nvidia.com>
 <2c62b5c7-582a-c710-0436-4ac5e8fd8b39@redhat.com>
 <20210604172207.GT1002214@nvidia.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <2d1ad075-bec6-bfb9-ce71-ed873795e973@redhat.com>
Date: Sat, 5 Jun 2021 08:22:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210604172207.GT1002214@nvidia.com>
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

On 04/06/21 19:22, Jason Gunthorpe wrote:
>   4) The KVM interface is the very simple enable/disable WBINVD.
>      Possessing a FD that can do IOMMU_EXECUTE_WBINVD is required
>      to enable WBINVD at KVM.

The KVM interface is the same kvm-vfio device that exists already.  The 
userspace API does not need to change at all: adding one VFIO file 
descriptor with WBINVD enabled to the kvm-vfio device lets the VM use 
WBINVD functionality (see kvm_vfio_update_coherency).

Alternatively you can add a KVM_DEV_IOASID_{ADD,DEL} pair of ioctls. 
But it seems useless complication compared to just using what we have 
now, at least while VMs only use IOASIDs via VFIO.

Either way, there should be no policy attached to the add/delete 
operations.  KVM users want to add the VFIO (or IOASID) file descriptors 
to the device independent of WBINVD.  If userspace wants/needs to apply 
its own policy on whether to enable WBINVD or not, they can do it on the 
VFIO/IOASID side:

>  1) When the device is attached to the IOASID via VFIO_ATTACH_IOASID
>     it communicates its no-snoop configuration:
>      - 0 enable, allow WBINVD
>      - 1 automatic disable, block WBINVD if the platform
>        IOMMU can police it (what we do today)
>      - 2 force disable, do not allow BINVD ever

Though, like Alex, it's also not clear to me whether force-disable is 
useful.  Instead userspace can query the IOMMU or the device to ensure 
it's not enabled.

Paolo

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
