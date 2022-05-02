Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B66C433F5
	for <iommu@archiver.kernel.org>; Mon,  2 May 2022 18:11:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9AEA460F48;
	Mon,  2 May 2022 18:11:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RlZstcDuhPWN; Mon,  2 May 2022 18:11:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7A7FF60EC1;
	Mon,  2 May 2022 18:11:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2481BC0039;
	Mon,  2 May 2022 18:11:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F602C002D
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 18:11:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5C99460F4E
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 18:11:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3SKbcWTz1e0n for <iommu@lists.linux-foundation.org>;
 Mon,  2 May 2022 18:11:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 027E460EC1
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 18:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651515074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OB2hOtFGf786xTKJG2c2V8jCJu7i8Ybw34LncXS8QJg=;
 b=dmMDtNgaOE2X8cgJP4W1e/yNgs5MJdzQS969aBqJ5jFod6m5o+Y6SsGLFFkvWCMw2d2oB6
 QhL6UF9E724cQ3IGhf37vsyDndBpGmA7xJrJQahyAIEBurbW9Nr1bbRSxwM9ga/RVnwE9V
 cQEl0sHkoGLrCdYIEsx40tI4h9AkV6w=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-575-lda2hfL6OI-mpugVOk82pw-1; Mon, 02 May 2022 14:11:12 -0400
X-MC-Unique: lda2hfL6OI-mpugVOk82pw-1
Received: by mail-io1-f72.google.com with SMTP id
 ay13-20020a5d9d8d000000b0065a631e7632so2418793iob.14
 for <iommu@lists.linux-foundation.org>; Mon, 02 May 2022 11:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OB2hOtFGf786xTKJG2c2V8jCJu7i8Ybw34LncXS8QJg=;
 b=b6sms86xCxxouV03KVPNtDxdf7EoeYmFhKlcs+q6s6gYaxZm69Ank5B7rE8BA5rmgq
 4r+LesZNs5xDkFBAYXKp/DchQs07ekztcYCAFgejeZRy0AtTjXxkuPA8UZrRj5MH0G3j
 MGbr8vnZvMy5BDzy2feELMBcvVcjo18FqKEojmgy7GpbTJVBHlioTdFu2k9RnXxhHUWe
 eHqcYM3V3+7gPjRA62Q+fJH7kGPYJHVOOoK3+BXffAGlkflHif4aKRrkOcnAPu9dNEQa
 akLJ6fVls4ABzePM751d/7V4NGhav/XXQoWxPye+5DZf7S8mauHO3BQV+krRZvevqNk6
 l0qQ==
X-Gm-Message-State: AOAM530UBWXMffljU3usAA3N24m2dwIAc44RgfTGNCe14OS9QkC9dvAB
 m5+jFYCpWnX2a4cbkvB1cPj1KmjHJxEl5GqiwWP4gNOum92mUnJRaga4Ipyalu8GMW1w9vgVxPH
 IBzKmnQuNwZ0izDBR+zUYHDlBpKE5Ng==
X-Received: by 2002:a05:6e02:1a2d:b0:2cc:4fb5:6007 with SMTP id
 g13-20020a056e021a2d00b002cc4fb56007mr4788058ile.124.1651515069188; 
 Mon, 02 May 2022 11:11:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3mKkLtOXlkpKnETd6PyjwpXqsT5TaGR1bDtZUr1B8qKfwqjSCM2B65ksgE07ihNdH8nI4Fg==
X-Received: by 2002:a05:6e02:1a2d:b0:2cc:4fb5:6007 with SMTP id
 g13-20020a056e021a2d00b002cc4fb56007mr4788033ile.124.1651515068830; 
 Mon, 02 May 2022 11:11:08 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 q13-20020a02a98d000000b0032b3a781741sm3252949jam.5.2022.05.02.11.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 May 2022 11:11:08 -0700 (PDT)
Date: Mon, 2 May 2022 12:11:07 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH RFC 00/19] IOMMUFD Dirty Tracking
Message-ID: <20220502121107.653ac0c5.alex.williamson@redhat.com>
In-Reply-To: <BN9PR11MB5276F104A27ACD5F20BABC7F8CFC9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220428210933.3583-1-joao.m.martins@oracle.com>
 <BN9PR11MB5276F104A27ACD5F20BABC7F8CFC9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Martins, Joao" <joao.m.martins@oracle.com>,
 David Woodhouse <dwmw2@infradead.org>, Robin Murphy <robin.murphy@arm.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, 29 Apr 2022 05:45:20 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:
> > From: Joao Martins <joao.m.martins@oracle.com>
> >  3) Unmapping an IOVA range while returning its dirty bit prior to
> > unmap. This case is specific for non-nested vIOMMU case where an
> > erronous guest (or device) DMAing to an address being unmapped at the
> > same time.  
> 
> an erroneous attempt like above cannot anticipate which DMAs can
> succeed in that window thus the end behavior is undefined. For an
> undefined behavior nothing will be broken by losing some bits dirtied
> in the window between reading back dirty bits of the range and
> actually calling unmap. From guest p.o.v. all those are black-box
> hardware logic to serve a virtual iotlb invalidation request which just
> cannot be completed in one cycle.
> 
> Hence in reality probably this is not required except to meet vfio
> compat requirement. Just in concept returning dirty bits at unmap
> is more accurate.
> 
> I'm slightly inclined to abandon it in iommufd uAPI.

Sorry, I'm not following why an unmap with returned dirty bitmap
operation is specific to a vIOMMU case, or in fact indicative of some
sort of erroneous, racy behavior of guest or device.  We need the
flexibility to support memory hot-unplug operations during migration,
but even in the vIOMMU case, isn't it fair for the VMM to ask whether a
device dirtied the range being unmapped?  This was implemented as a
single operation specifically to avoid races where ongoing access may be
available after retrieving a snapshot of the bitmap.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
