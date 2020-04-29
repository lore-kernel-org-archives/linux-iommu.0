Return-Path: <SRS0=AFVC=6N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA9DC83004
	for <iommu@archiver.kernel.org>; Wed, 29 Apr 2020 10:45:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8723D2074A
	for <iommu@archiver.kernel.org>; Wed, 29 Apr 2020 10:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CbULZWEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8723D2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2F50C20489;
	Wed, 29 Apr 2020 10:45:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qwvY3B8IxOJV; Wed, 29 Apr 2020 10:45:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 74AC622EDD;
	Wed, 29 Apr 2020 10:45:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39FE9C0865;
	Wed, 29 Apr 2020 10:45:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44E15C0172
 for <iommu@lists.linux-foundation.org>; Wed, 29 Apr 2020 10:45:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3240122EDD
 for <iommu@lists.linux-foundation.org>; Wed, 29 Apr 2020 10:45:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4fdp6ya8gf9s for <iommu@lists.linux-foundation.org>;
 Wed, 29 Apr 2020 10:45:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by silver.osuosl.org (Postfix) with ESMTPS id 2360B20489
 for <iommu@lists.linux-foundation.org>; Wed, 29 Apr 2020 10:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588157116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ivrbfu7nXm6urIi13dgUtl5GkaF/JA7ff8SBWPZh/VU=;
 b=CbULZWEbZAKH9bV+G8IywQ2Nrlwm0X/us8Vph1uNAI+3tt4/n+Sc6HBfYjMWUDJ03wY8cQ
 yWCbaONHY5XfUXnQUFlm4DEYH2dqlura8NS7Vc/uxjUS3J8mRoRu0Tx4gWoehtm3sJXwKr
 qMAZZvstaD885/aEtu4ULUo1M/NRAJ4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-spBLKlieOHK5PWZII1CJ_A-1; Wed, 29 Apr 2020 06:45:15 -0400
X-MC-Unique: spBLKlieOHK5PWZII1CJ_A-1
Received: by mail-wr1-f69.google.com with SMTP id m5so1507302wru.15
 for <iommu@lists.linux-foundation.org>; Wed, 29 Apr 2020 03:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ivrbfu7nXm6urIi13dgUtl5GkaF/JA7ff8SBWPZh/VU=;
 b=EiHdHxkGYHacKLx7e/fP+O6Lo3skdmx3qzgWYRKGlCS1bpWD6zSFEIuGWA7M/tjRQR
 l8EwIKLT/dhR4drAzw+lwJCJqHVhoRQqwX6RYN7S4IED/PNpGL3gBzbp84vV7QJNPAt1
 FUDZF0atcYlVRsrEjKwzMp8i7ikTi5oWUV+pSjAZcTmKgc1PYS6cEwgCBBjwyOJ7Z/uV
 aVpKfKqK5adNjsDXXTrgTR4eapr3FXpq7fDpWuXSRdB7MzRynNT2vTpDPuEZRL5Fw53h
 zCMchptY32JHPlymGfVPAQrewRuLcV1FOLi3utOgPZ3rpJrvjhBg+Qg4XK7Rj1exJvXY
 uGGw==
X-Gm-Message-State: AGi0PuZumss/LBkTr6WGkQgDJMJvQ/kGc+i6VzSGNYvGuIoZO1EMOGVD
 n4tI2Fs/0FacrBCKIi4LKIgeAM92vk2a+Tmj5GgF3nU6/7Je9MrbfJR1MYCAn9G77pim4jXXtAv
 8NkaAS4RHdAyXaBQXV1EQ1EoKBx3IGg==
X-Received: by 2002:a1c:770f:: with SMTP id t15mr2494545wmi.178.1588157114091; 
 Wed, 29 Apr 2020 03:45:14 -0700 (PDT)
X-Google-Smtp-Source: APiQypLWNbQEy2iyMW7HWmtuY5GYzKFC5cfUOhqKta7BJe6nQlsQf8vGhfuT+8lQWfwqNmKnzgzCfQ==
X-Received: by 2002:a1c:770f:: with SMTP id t15mr2494510wmi.178.1588157113807; 
 Wed, 29 Apr 2020 03:45:13 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 y70sm7706812wmc.36.2020.04.29.03.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2020 03:45:13 -0700 (PDT)
Date: Wed, 29 Apr 2020 06:45:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH 5/5] virtio: Add bounce DMA ops
Message-ID: <20200429064458-mutt-send-email-mst@kernel.org>
References: <20200428163448-mutt-send-email-mst@kernel.org>
 <275eba4b-dd35-aa95-b2e3-9c5cbf7c6d71@linux.intel.com>
 <20200429004531-mutt-send-email-mst@kernel.org>
 <b676430c-65b3-096e-ca48-ceebf10f4b28@linux.intel.com>
 <20200429023842-mutt-send-email-mst@kernel.org>
 <20200429094410.GD5097@quicinc.com>
 <20200429055125-mutt-send-email-mst@kernel.org>
 <20200429100953.GE5097@quicinc.com>
 <20200429061621-mutt-send-email-mst@kernel.org>
 <f52556e2-253e-2dbc-cb7a-a7991e3bcfde@siemens.com>
MIME-Version: 1.0
In-Reply-To: <f52556e2-253e-2dbc-cb7a-a7991e3bcfde@siemens.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: tsoni@codeaurora.org, virtio-dev@lists.oasis-open.org,
 konrad.wilk@oracle.com, will@kernel.org, jasowang@redhat.com,
 Srivatsa Vaddagiri <vatsa@codeaurora.org>, christoffer.dall@arm.com,
 pratikp@codeaurora.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org, stefano.stabellini@xilinx.com,
 alex.bennee@linaro.org, linux-kernel@vger.kernel.org
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

On Wed, Apr 29, 2020 at 12:26:43PM +0200, Jan Kiszka wrote:
> On 29.04.20 12:20, Michael S. Tsirkin wrote:
> > On Wed, Apr 29, 2020 at 03:39:53PM +0530, Srivatsa Vaddagiri wrote:
> > > That would still not work I think where swiotlb is used for pass-thr devices
> > > (when private memory is fine) as well as virtio devices (when shared memory is
> > > required).
> > 
> > So that is a separate question. When there are multiple untrusted
> > devices, at the moment it looks like a single bounce buffer is used.
> > 
> > Which to me seems like a security problem, I think we should protect
> > untrusted devices from each other.
> > 
> 
> Definitely. That's the model we have for ivshmem-virtio as well.
> 
> Jan

Want to try implementing that?

> -- 
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
