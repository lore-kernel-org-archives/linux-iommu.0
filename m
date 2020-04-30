Return-Path: <SRS0=XdCg=6O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3644AC8300A
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 10:08:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 048892173E
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 10:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UD6FMXzN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 048892173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CB10388581;
	Thu, 30 Apr 2020 10:08:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EcBfY6Ik+b6u; Thu, 30 Apr 2020 10:08:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5C92D81E5B;
	Thu, 30 Apr 2020 10:08:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43808C0889;
	Thu, 30 Apr 2020 10:08:06 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C067C016F
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 10:08:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3291A204F1
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 10:08:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3OE4Ntv5FveU for <iommu@lists.linux-foundation.org>;
 Thu, 30 Apr 2020 10:08:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by silver.osuosl.org (Postfix) with ESMTPS id 59AEA204CC
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 10:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588241283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4neCHXAikGnDrEWLfrOwLMssDcW49SbEXywLj9zmi5k=;
 b=UD6FMXzNZlbJLJGlzJDZJ4xgMtznMU/Z4L82ofSoIMRqwqT0WjnFy7WequhRXCFwu3ROoC
 XUOujor2EdVEw/N25IbXZFLclbkKLOn3d117XuDWwe2vpSLJ8FLxDbMxi2IHpoBD1hIkCc
 ESssA7HCz3IiQbd1H/Pfr5fYmGBO7+0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-gJJRMSV6PpS3F1ycf1Shrw-1; Thu, 30 Apr 2020 06:08:01 -0400
X-MC-Unique: gJJRMSV6PpS3F1ycf1Shrw-1
Received: by mail-wr1-f72.google.com with SMTP id u4so3628642wrm.13
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 03:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4neCHXAikGnDrEWLfrOwLMssDcW49SbEXywLj9zmi5k=;
 b=tI00WkDm4R35Ol6MBf0Tn96y/18o1BR1u/JMkvffPR4fqbD59ybgnZLeyr8txKNqFU
 Icm9t7E4oVnFpyPUOT4n8KaJdz5Y5U0IsLlEyZERykIWqb1cIcIinSV/hyjH92LdL2kd
 Cm6dxb0jWjsBNZdhs+8Gu5GmoQcbHr6m/ES5gWTgHdSNXcbptoJuyAhdaYpQQWmSql2p
 imDDUh11Z+8HEAdmSYtoKhhbi1z7pV8apyK95GwJITFdF01rNbLniUOA1aljWGUBVoMg
 WotAZXVqPnEcBICpdZuMaihwWWAxH2C6f4BKTQ3bpNKCvaKfAhTnRzXQ4r3DFLD5F88h
 BcmA==
X-Gm-Message-State: AGi0PuZfb6mC30LCfDKrb4HRIEyz+1EDasKRcE6O2xoHfg4z2CHarsbG
 M6H3RfocMJ3er0h4kGM89QcZAUERJoQ7kR8gCkoFHXlPgwZ9fYfjChfwXgGKM2lbLArmvBr4p/t
 tjKSNsV+jhkDRPGhXpmMvbgmBn9OCxw==
X-Received: by 2002:a1c:2d0e:: with SMTP id t14mr2145467wmt.153.1588241280183; 
 Thu, 30 Apr 2020 03:08:00 -0700 (PDT)
X-Google-Smtp-Source: APiQypLHlrCbfCYrZ88o6DhjV70fA6mpNnqgpx+WR9c06xN4peVmevPZw2FufGVhiRy6EDg6FWX7OQ==
X-Received: by 2002:a1c:2d0e:: with SMTP id t14mr2145451wmt.153.1588241279982; 
 Thu, 30 Apr 2020 03:07:59 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 u30sm3470829wru.13.2020.04.30.03.07.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 03:07:59 -0700 (PDT)
Date: Thu, 30 Apr 2020 06:07:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Subject: Re: [RFC/PATCH 0/1] virtio_mmio: hypervisor specific interfaces for
 MMIO
Message-ID: <20200430060653-mutt-send-email-mst@kernel.org>
References: <1588240976-10213-1-git-send-email-vatsa@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <1588240976-10213-1-git-send-email-vatsa@codeaurora.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: tsoni@codeaurora.org, virtio-dev@lists.oasis-open.org,
 konrad.wilk@oracle.com, jan.kiszka@siemens.com, jasowang@redhat.com,
 christoffer.dall@arm.com, virtualization@lists.linux-foundation.org,
 alex.bennee@linaro.org, iommu@lists.linux-foundation.org,
 stefano.stabellini@xilinx.com, will@kernel.org, linux-kernel@vger.kernel.org,
 pratikp@codeaurora.org
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

On Thu, Apr 30, 2020 at 03:32:55PM +0530, Srivatsa Vaddagiri wrote:
> The Type-1 hypervisor we are dealing with does not allow for MMIO transport. 

How about PCI then?

-- 
MST

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
