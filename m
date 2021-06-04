Return-Path: <SRS0=eMD9=K6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA66C07E94
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 15:57:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5232D613F1
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 15:57:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5232D613F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 12E8440173;
	Fri,  4 Jun 2021 15:57:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cOF_mJycuKXw; Fri,  4 Jun 2021 15:57:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 80F75400AB;
	Fri,  4 Jun 2021 15:57:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D572C000D;
	Fri,  4 Jun 2021 15:57:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2BF9C0001
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 15:57:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D4198400E4
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 15:57:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I9zpZAi_Nt8J for <iommu@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 15:57:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F41FD400AB
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 15:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622822244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4VeXpVaVm3Sgm4ExODkCf4+TTdsJEk4SxRvRR3xCWPQ=;
 b=UYQ9C9jupD4UXP/KA1trOe4ynHhNVxkTynCMl+wIZmtmhKGG1N8jWSdPU5cJY/EYWaf/IY
 lAvL4kv0922yMaKRo9PeIjiK5EkCTdvFbCcazo3sPgS7lXKbsfFsOxC3LKJhRC+Qz12F/T
 xsESKvHOR21vSu7LshFh9csRDCv+tU8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-fXD73bM1OUKjvnHZt5c7YQ-1; Fri, 04 Jun 2021 11:57:23 -0400
X-MC-Unique: fXD73bM1OUKjvnHZt5c7YQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 s18-20020a0564020372b029038febc2d475so5200744edw.3
 for <iommu@lists.linux-foundation.org>; Fri, 04 Jun 2021 08:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4VeXpVaVm3Sgm4ExODkCf4+TTdsJEk4SxRvRR3xCWPQ=;
 b=QapJ2/DTZMlLOtFB6JcAOaMudqYDxy3lkTharEugjhsvxWt5IJYWnFCy5gsi6EflSc
 Yk9XZoOavcS9uFhFgGihds8+u1Twk4vCjYPlYF0pCy8slHVQLcimZW9dV/o8DWsyOpjf
 Yq5TUKxgRMj1e+NLna+8juzpsGDP1GYt6pJrR0U6eWO52ldieH8UJxfxVOFtzVctiBpv
 9eQaTOMKR72eCaWfrzIrQzN8pUWEpT6y71nTBrjyuMKx93Jj0qkE4HvpscUZtfLwyoTe
 KFS1lRtUFxceOU5sTpOH8V/ZIKDb646tZLjo3tleSM1vMq2VEXI3oAn2rT8tXcM540A7
 BuXg==
X-Gm-Message-State: AOAM532Z9we/4VRHsoxPuUWCwLe1JQHB9Ta4RQ9V2Kh3hxiVrF3Z6jpU
 9ztW6seIaDZzWbblsieIKHf7hRNxtOT/jowBbbqXSRbODW+ke1zq1tp+x31Girx/CgVFwQMoDCy
 sRVie0T4yMSndOMCDFFVhfpGINSu0tQ==
X-Received: by 2002:a17:907:1b11:: with SMTP id
 mp17mr4825427ejc.1.1622822242026; 
 Fri, 04 Jun 2021 08:57:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPRjcRc6XoOVz7KqxGJ8Jr4Ru7H/KBEWYfYYsX/zRmiAg3G+v0VaBWdVmTVXEoxLZyb0lcDw==
X-Received: by 2002:a17:907:1b11:: with SMTP id
 mp17mr4825416ejc.1.1622822241873; 
 Fri, 04 Jun 2021 08:57:21 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id p13sm2917846ejr.87.2021.06.04.08.57.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jun 2021 08:57:21 -0700 (PDT)
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20210602224536.GJ1002214@nvidia.com>
 <20210602205054.3505c9c3.alex.williamson@redhat.com>
 <20210603123401.GT1002214@nvidia.com>
 <20210603140146.5ce4f08a.alex.williamson@redhat.com>
 <20210603201018.GF1002214@nvidia.com>
 <20210603154407.6fe33880.alex.williamson@redhat.com>
 <MWHPR11MB1886469C0136C6523AB158B68C3B9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210604122830.GK1002214@nvidia.com>
 <20210604092620.16aaf5db.alex.williamson@redhat.com>
 <815fd392-0870-f410-cbac-859070df1b83@redhat.com>
 <20210604155016.GR1002214@nvidia.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <30e5c597-b31c-56de-c75e-950c91947d8f@redhat.com>
Date: Fri, 4 Jun 2021 17:57:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210604155016.GR1002214@nvidia.com>
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

On 04/06/21 17:50, Jason Gunthorpe wrote:
>> Extending the scenarios where WBINVD is not a nop is not a problem for me.
>> If possible I wouldn't mind keeping the existing kvm-vfio connection via the
>> device, if only because then the decision remains in the VFIO camp (whose
>> judgment I trust more than mine on this kind of issue).
> Really the question to answer is what "security proof" do you want
> before the wbinvd can be enabled

I don't want a security proof myself; I want to trust VFIO to make the 
right judgment and I'm happy to defer to it (via the KVM-VFIO device).

Given how KVM is just a device driver inside Linux, VMs should be a 
slightly more roundabout way to do stuff that is accessible to bare 
metal; not a way to gain extra privilege.

Paolo

>   1) User has access to a device that can issue no-snoop TLPS
>   2) User has access to an IOMMU that can not block no-snoop (today)
>   3) Require CAP_SYS_RAW_IO
>   4) Anyone
> 
> #1 is an improvement because it allows userspace to enable wbinvd and
> no-snoop optimizations based on user choice
> 
> #2 is where we are today and wbinvd effectively becomes a fixed
> platform choice. Userspace has no say
> 
> #3 is "there is a problem, but not so serious, root is powerful
>     enough to override"

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
