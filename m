Return-Path: <SRS0=g+Up=LD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7D4C48BDF
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 08:14:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B8F961285
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 08:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B8F961285
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18BDF83BEF;
	Wed,  9 Jun 2021 08:14:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9DupcV1_V3lE; Wed,  9 Jun 2021 08:14:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F122D83A73;
	Wed,  9 Jun 2021 08:14:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C47B8C000D;
	Wed,  9 Jun 2021 08:14:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76DF8C000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 08:14:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 653C540297
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 08:14:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gvufEYaAY4ME for <iommu@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 08:14:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7CBBF400D4
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 08:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623226494;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BJdAIhBhaJHDTxxgy9Ey5Eqpozz7WMzGVnuX/u268J8=;
 b=B4WmiwIXLq2Ut0hykR2DN0UkrBmgsPK5hpC+3poG+rM862icUCA9wstjy9hCS3h2Q54xO1
 QdkRxFl79toWPX4aQGat22StmDt/KTnmNgQsNxTlqCxDEWSdCZ3mC8vmw8RheGybJgIMxx
 bDfwFU6qPJ3YijwXt/h2LULkTCbzamQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-tHrz8mLWNpWeCNvRjOmZLw-1; Wed, 09 Jun 2021 04:14:52 -0400
X-MC-Unique: tHrz8mLWNpWeCNvRjOmZLw-1
Received: by mail-wr1-f71.google.com with SMTP id
 q15-20020adfc50f0000b0290111f48b865cso10418099wrf.4
 for <iommu@lists.linux-foundation.org>; Wed, 09 Jun 2021 01:14:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=BJdAIhBhaJHDTxxgy9Ey5Eqpozz7WMzGVnuX/u268J8=;
 b=cQzbwiueirz8xkaLrjdw3ED9cVgymWjlwJOVt9Vbl4vRpP78TqDD+knAwOsxwUGKak
 Vn1bUtUroulxmMkxnk/xPNbQ7UpYfb0Fhs+shLOAdZCDFR0USNF8fkevxL6Ntk3wc45j
 4qQxlMrFBynaM3osyEFB3mrngVDCU3tdLgJDs5ipgsKemITt37a+5bwWikfoxQSM56r3
 i26zY1RAOfQEOyAwPjmvjlYLQAWXJ6ERKDS15iYLdjFuuDJDu/h0ehRCJCPUbkH0yPCE
 bnC9sg5aFkGdKIMu1peEMIASijT//vOHeMZ3C8zW3N81RoG5rxT+VnD9UpDWNIeuJOeQ
 h6vA==
X-Gm-Message-State: AOAM530qvi2IuGeuWybcFVuxds/h6gZl9zOFSpM9oyWw7ibbqqfhrKZY
 wqJqQw5+DeLLLsMgMykQbrNa3i4KIdbrneKxS6cPpmIj1/LJ0UPQdeDnqCmcCXR2NA/oZjQYZpX
 cEfc1v0nsH8kxYUbtN31xtVigRJLWAQ==
X-Received: by 2002:a1c:5452:: with SMTP id p18mr25986469wmi.176.1623226491776; 
 Wed, 09 Jun 2021 01:14:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHztkUAyI+BmnE5wcOSMiNwdss3hfpHeT1nOccAa3B1HkID/3sYMZnDdskmY46CLurO/tQVA==
X-Received: by 2002:a1c:5452:: with SMTP id p18mr25986454wmi.176.1623226491547; 
 Wed, 09 Jun 2021 01:14:51 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id w13sm24559323wrc.31.2021.06.09.01.14.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jun 2021 01:14:50 -0700 (PDT)
Subject: Re: Plan for /dev/ioasid RFC v2
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "Alex Williamson (alex.williamson@redhat.com)" <alex.williamson@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, Jason Wang
 <jasowang@redhat.com>, "parav@mellanox.com" <parav@mellanox.com>,
 "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Shenming Lu <lushenming@huawei.com>
References: <MWHPR11MB188699D0B9C10EB51686C4138C389@MWHPR11MB1886.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
Message-ID: <b1bb72b5-cb98-7739-8788-01e36ec415a8@redhat.com>
Date: Wed, 9 Jun 2021 10:14:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB188699D0B9C10EB51686C4138C389@MWHPR11MB1886.namprd11.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Jiang, Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 David Woodhouse <dwmw2@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 Robin Murphy <robin.murphy@arm.com>
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
Reply-To: eric.auger@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Kevin,

On 6/7/21 4:58 AM, Tian, Kevin wrote:
> Hi, all,
>
> We plan to work on v2 now, given many good comments already received
> and substantial changes envisioned. This is a very complex topic with
> many sub-threads being discussed. To ensure that I didn't miss valuable 
> suggestions (and also keep everyone on the same page), here I'd like to 
> provide a list of planned changes in my mind. Please let me know if 
> anything important is lost.  :)
>
> --
>
> (Remaining opens in v1)
>
> -   Protocol between kvm/vfio/ioasid for wbinvd/no-snoop. I'll see how
>     much can be refined based on discussion progress when v2 is out;
>
> -   Device-centric (Jason) vs. group-centric (David) uAPI. David is not fully
>     convinced yet. Based on discussion v2 will continue to have ioasid uAPI
>     being device-centric (but it's fine for vfio to be group-centric). A new
>     section will be added to elaborate this part;
>
> -   PASID virtualization (section 4) has not been thoroughly discussed yet. 
>     Jason gave some suggestion on how to categorize intended usages. 
>     I will rephrase this section and hope more discussions can be held for 
>     it in v2;
>
> (Adopted suggestions)
>
> -   (Jason) Rename /dev/ioasid to /dev/iommu (so does uAPI e.g. IOASID
>     _XXX to IOMMU_XXX). One suggestion (Jason) was to also rename 
>     RID+PASID to SID+SSID. But given the familiarity of the former, I will 
>     still use RID+PASID in v2 to ease the discussoin;
>
> -   (Jason) v1 prevents one device from binding to multiple ioasid_fd's. This 
>     will be fixed in v2;
>
> -   (Jean/Jason) No need to track guest I/O page tables on ARM/AMD. When 
>     a pasid table is bound, it becomes a container for all guest I/O page tables;
while I am totally in line with that change, I guess we need to revisit
the invalidate ioctl
to support PASID table invalidation.
>
> -   (Jean/Jason) Accordingly a device label is required so iotlb invalidation 
>     and fault handling can both support per-device operation. Per Jean's 
>     suggestion, this label will come from userspace (when VFIO_BIND_
>     IOASID_FD);

what is not totally clear to me is the correspondance between this label
and the SID/SSID tuple.
My understanding is it rather maps to the SID because you can attach
several ioasids to the device.
So it is not clear to me how you reconstruct the SSID info

Thanks

Eric
>
> -   (Jason) Addition of device label allows per-device capability/format 
>     check before IOASIDs are created. This leads to another major uAPI 
>     change in v2 - specify format info when creating an IOASID (mapping 
>     protocol, nesting, coherent, etc.). User is expected to check per-device 
>     format and then set proper format for IOASID upon to-be-attached 
>     device;

> -   (Jason/David) No restriction on map/unmap vs. bind/invalidate. They
>     can be used in either parent or child;
>
> -   (David) Change IOASID_GET_INFO to report permitted range instead of
>     reserved IOVA ranges. This works better for PPC;
>
> -   (Jason) For helper functions, expect to have explicit bus-type wrappers
>     e.g. ioasid_pci_device_attach;
>
> (Not adopted)
>
> -   (Parav) Make page pinning a syscall;
> -   (Jason. W/Enrico) one I/O page table per fd;
> -   (David) Replace IOASID_REGISTER_MEMORY through another ioasid
>     nesting (sort of passthrough mode). Need more thinking. v2 will not 
>     change this part;
>
> Thanks
> Kevin
>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
