Return-Path: <SRS0=g+Up=LD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F61EC48BCD
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 13:24:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08634613B9
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 13:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08634613B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B926040529;
	Wed,  9 Jun 2021 13:24:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9rNV5uh1Ivmv; Wed,  9 Jun 2021 13:24:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9E9DD40137;
	Wed,  9 Jun 2021 13:24:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6285BC000E;
	Wed,  9 Jun 2021 13:24:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57B2BC000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 13:24:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4488E4053A
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 13:24:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wxzlNKiy2_3I for <iommu@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 13:24:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6104A40530
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 13:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623245057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=20U4EvP+/4P7U+6EGZKMPnMwVak4M1Pove365pXCudk=;
 b=VnRNFVkJKa+j0AFWYs8Ms/9Kp/ldZPgsrzDFacZf9mOY7eKRzlSXMRIE40UMfkgD4CDAEV
 QfioZneITW0ssjGWLYQpYX5szclp1ONabGnnf2/FXrWTa4VRQmK1fA4vJWnLrespyyS4B1
 JRveNf0V/CjpmSyPn5oS2th2SdZwOhc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-sN9vPC0dPkuMouy1k6Rt8Q-1; Wed, 09 Jun 2021 09:24:15 -0400
X-MC-Unique: sN9vPC0dPkuMouy1k6Rt8Q-1
Received: by mail-wm1-f69.google.com with SMTP id
 j6-20020a05600c1906b029019e9c982271so2624450wmq.0
 for <iommu@lists.linux-foundation.org>; Wed, 09 Jun 2021 06:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:subject:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=20U4EvP+/4P7U+6EGZKMPnMwVak4M1Pove365pXCudk=;
 b=iDgbUs5aJLNQhaxWZj5TilUvWqyE/kEiw5jSmswASlvuA9PGgkDoF715eWB55Beasa
 6K9j7HTHN1p6LV5AOR21HZ5JnFLYbovZvE8Mp+emNpApqLVl7KJ1G0HAqZLihvHaHu3Y
 LngKV79ILLthI8Y30lWS38KCbjVVZ0ZEz+eovEPurF7n2EzRZRTaLHVQVY1W4JGLnx2y
 zBTS3auIn6Ziezi8elwwhulRJ6e5Vz29qXxLL23z8eQw8nktwYrL8zL1ezYUc3D1/nH5
 5CvY94fc8RcES/3CGuCOPLwhkYkoqW9bPl4lKMZ+NGD+I0ZBkJ2sce6ffy49yS/qP4YM
 c6iQ==
X-Gm-Message-State: AOAM53152xtJDEXDuYhm1OPu6OIrqvrBlSsSGOqZpL1+sVGWwYQvprcB
 WDMg0CjCWKuDlbvapqbCD7rZvapycPrCbFL0S4T6DPRcxEdtWo36k9hZZU2HQOXuy7VXRw5ZPJV
 wifYoVi1lq8Vt543YSG4n8Kfw7nWYvw==
X-Received: by 2002:a5d:4a43:: with SMTP id v3mr28228658wrs.397.1623245054486; 
 Wed, 09 Jun 2021 06:24:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZHa62Nu93nfcNXj9gZ2LfL0bfkGDMGaOIWtXI/yBXylwFuKfSs0RPk1+NDaNWif1T7to5CQ==
X-Received: by 2002:a5d:4a43:: with SMTP id v3mr28228631wrs.397.1623245054289; 
 Wed, 09 Jun 2021 06:24:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id x10sm13071040wrt.26.2021.06.09.06.24.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jun 2021 06:24:13 -0700 (PDT)
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20210604172207.GT1002214@nvidia.com>
 <2d1ad075-bec6-bfb9-ce71-ed873795e973@redhat.com>
 <20210607175926.GJ1002214@nvidia.com>
 <fdb2f38c-da1f-9c12-af44-22df039fcfea@redhat.com>
 <20210608131547.GE1002214@nvidia.com>
 <89d30977-119c-49f3-3bf6-d3f7104e07d8@redhat.com>
 <20210608124700.7b9aa5a6.alex.williamson@redhat.com>
 <MWHPR11MB18861A89FE6620921E7A7CAC8C369@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210609115759.GY1002214@nvidia.com>
 <086ca28f-42e5-a432-8bef-ac47a0a6df45@redhat.com>
 <20210609124742.GB1002214@nvidia.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <8433033c-daf2-c9b7-56f7-e354320dc5b5@redhat.com>
Date: Wed, 9 Jun 2021 15:24:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210609124742.GB1002214@nvidia.com>
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

On 09/06/21 14:47, Jason Gunthorpe wrote:
> On Wed, Jun 09, 2021 at 02:46:05PM +0200, Paolo Bonzini wrote:
>> On 09/06/21 13:57, Jason Gunthorpe wrote:
>>> On Wed, Jun 09, 2021 at 02:49:32AM +0000, Tian, Kevin wrote:
>>>
>>>> Last unclosed open. Jason, you dislike symbol_get in this contract per
>>>> earlier comment. As Alex explained, looks it's more about module
>>>> dependency which is orthogonal to how this contract is designed. What
>>>> is your opinion now?
>>>
>>> Generally when you see symbol_get like this it suggests something is
>>> wrong in the layering..
>>>
>>> Why shouldn't kvm have a normal module dependency on drivers/iommu?
>>
>> It allows KVM to load even if there's an "install /bin/false" for vfio
>> (typically used together with the blacklist directive) in modprobe.conf.
>> This rationale should apply to iommu as well.
> 
> I can vaugely understand this rational for vfio, but not at all for
> the platform's iommu driver, sorry.

Sorry, should apply to ioasid, not iommu (assuming that /dev/ioasid 
support would be modular).

Paolo

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
