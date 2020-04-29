Return-Path: <SRS0=AFVC=6N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FB7C83004
	for <iommu@archiver.kernel.org>; Wed, 29 Apr 2020 10:21:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CEA42087E
	for <iommu@archiver.kernel.org>; Wed, 29 Apr 2020 10:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P528IEdk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CEA42087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 238B62041C;
	Wed, 29 Apr 2020 10:21:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CNaXmsxQbn4b; Wed, 29 Apr 2020 10:20:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 69B522012D;
	Wed, 29 Apr 2020 10:20:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 522BDC0865;
	Wed, 29 Apr 2020 10:20:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CDEC5C0172
 for <iommu@lists.linux-foundation.org>; Wed, 29 Apr 2020 10:20:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id BA8E22041C
 for <iommu@lists.linux-foundation.org>; Wed, 29 Apr 2020 10:20:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vgBjTk0utg4z for <iommu@lists.linux-foundation.org>;
 Wed, 29 Apr 2020 10:20:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by silver.osuosl.org (Postfix) with ESMTPS id AD01B2012D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Apr 2020 10:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588155654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HvmAgJ1OCqs5BSQtwGJP89ITCctRl3ojWHctS5awxpw=;
 b=P528IEdk04/iYzcxSpJ6P0bg7t6A7Cn9+AteIY9oM5lvXt995bMNkSW8eN52WA41UGn1uF
 g/8QtoWNNpKMojw1E5mjSm8t2hbmJwvRcH1GeT8oOGdl4XnRYczEJmO0/oeQn3yVP+tXLy
 PPhpgqVBMN8ASVcwA0hVrWcZ6+wV8BE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-brC5NRonOSeOHto23celCw-1; Wed, 29 Apr 2020 06:20:52 -0400
X-MC-Unique: brC5NRonOSeOHto23celCw-1
Received: by mail-wm1-f72.google.com with SMTP id 14so806014wmo.9
 for <iommu@lists.linux-foundation.org>; Wed, 29 Apr 2020 03:20:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HvmAgJ1OCqs5BSQtwGJP89ITCctRl3ojWHctS5awxpw=;
 b=m70xjpMoZpdEWeNzQmwo250Sym0dct0egdoskM512zb6RSWWIzdKy0eofVik7oIw5r
 IuixZOniXJTyiCLD/Vd2yJJKkxFjw/5Qfv9cLxVqMdPasM1YmOHaPOYfrGVN6lhHH5JA
 Odc179SXotgVSiVj3fr8cw6KZZEcNJoyqNuja8VAPqm52AgO4MOX+giXkiSXtShyfbhQ
 3OZb6vuKaVrNWHNs7xkwk2lscRuWW8mlVWnmjDvYHbLWrfarkeG7oijCBV0IB0wx1z6L
 37Mv3vQW2JmcOIJtzrBysTx1x8n0+QJPvjCSHCHpiG/waidaJATvE3QO2g3oU1UwEhvs
 c9Fw==
X-Gm-Message-State: AGi0PuaF8AEKU5zoz50xL9Xy9v78lY0sC6jEjHCw4FmUOLuUHK8A5has
 reFAZYsOssYcmXzTrCUyg9VDJpDXoRStha4fhxnt2IX1gXt19r4dCwzoAYYLk7W5QzMvNvWBf7/
 dIPJXaQaC5P4OO+e/7X9yQ9aD1ubwog==
X-Received: by 2002:adf:f748:: with SMTP id z8mr36689670wrp.45.1588155651955; 
 Wed, 29 Apr 2020 03:20:51 -0700 (PDT)
X-Google-Smtp-Source: APiQypL7W87TuCEBCh4Hv8OBMcyMuv2V+tdXaHVIwWppnAllxcN7DLIJZP5w+iV7A/NbopWJbzldOA==
X-Received: by 2002:adf:f748:: with SMTP id z8mr36689638wrp.45.1588155651690; 
 Wed, 29 Apr 2020 03:20:51 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 t67sm7743622wmg.40.2020.04.29.03.20.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2020 03:20:50 -0700 (PDT)
Date: Wed, 29 Apr 2020 06:20:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Subject: Re: [PATCH 5/5] virtio: Add bounce DMA ops
Message-ID: <20200429061621-mutt-send-email-mst@kernel.org>
References: <20200428121232-mutt-send-email-mst@kernel.org>
 <20200428174952.GA5097@quicinc.com>
 <20200428163448-mutt-send-email-mst@kernel.org>
 <275eba4b-dd35-aa95-b2e3-9c5cbf7c6d71@linux.intel.com>
 <20200429004531-mutt-send-email-mst@kernel.org>
 <b676430c-65b3-096e-ca48-ceebf10f4b28@linux.intel.com>
 <20200429023842-mutt-send-email-mst@kernel.org>
 <20200429094410.GD5097@quicinc.com>
 <20200429055125-mutt-send-email-mst@kernel.org>
 <20200429100953.GE5097@quicinc.com>
MIME-Version: 1.0
In-Reply-To: <20200429100953.GE5097@quicinc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: tsoni@codeaurora.org, virtio-dev@lists.oasis-open.org, will@kernel.org,
 konrad.wilk@oracle.com, jan.kiszka@siemens.com, jasowang@redhat.com,
 christoffer.dall@arm.com, pratikp@codeaurora.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 stefano.stabellini@xilinx.com, alex.bennee@linaro.org,
 linux-kernel@vger.kernel.org
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

On Wed, Apr 29, 2020 at 03:39:53PM +0530, Srivatsa Vaddagiri wrote:
> That would still not work I think where swiotlb is used for pass-thr devices
> (when private memory is fine) as well as virtio devices (when shared memory is
> required).

So that is a separate question. When there are multiple untrusted
devices, at the moment it looks like a single bounce buffer is used.

Which to me seems like a security problem, I think we should protect
untrusted devices from each other.





> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
