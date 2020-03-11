Return-Path: <SRS0=4Gp4=44=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCDDC0044D
	for <iommu@archiver.kernel.org>; Wed, 11 Mar 2020 21:48:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8785E206B1
	for <iommu@archiver.kernel.org>; Wed, 11 Mar 2020 21:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BSqLuFdR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8785E206B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id F127386CF9;
	Wed, 11 Mar 2020 21:48:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X0DN2y71aNvJ; Wed, 11 Mar 2020 21:48:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 52EF586D39;
	Wed, 11 Mar 2020 21:48:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D5E0C07FF;
	Wed, 11 Mar 2020 21:48:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 545F0C0177
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 21:48:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 507F8883FF
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 21:48:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H1TCjKslfJuX for <iommu@lists.linux-foundation.org>;
 Wed, 11 Mar 2020 21:48:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 08A86883F0
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 21:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583963310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=trXAOUXf8R0jK9KyR9z+fLazglkIkKVNTDuFFKwZMaA=;
 b=BSqLuFdRBCWqKYgQFMFCc+hvccUyqrKfC93WDQDwqhgq5GTmtD0rrAFhwaaTgKW3C428yv
 7YqVhKMf3+vkm+Pz/+A498SSVnCrWIZZ+5zywmx+l0hSI5EQlYYdQMFbckJRQ69yUEF3ka
 dkPoYkcVQN5gr4zbGVg/ib+ic2WwfS8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-IN7KOGWzPambGCoqRLkFZg-1; Wed, 11 Mar 2020 17:48:29 -0400
X-MC-Unique: IN7KOGWzPambGCoqRLkFZg-1
Received: by mail-qt1-f200.google.com with SMTP id d6so2190957qtn.2
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 14:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=trXAOUXf8R0jK9KyR9z+fLazglkIkKVNTDuFFKwZMaA=;
 b=MqWpy0LeAHIrtgiNM7M8PjSwTfXjq8ZKcFwtFhgM6KdlxD/XtzS7SeVFQntASqURri
 Tmq4uufevjbx8ImaXZjAqAFHwPQ244t4BrLGtTIBji1rZaI2MwrYKbgEWRfpWIDGAAiT
 gqski2oVFqT4gpIbUcUFoDUnUVyC9XMRGvopKJN8Gll7bRRdy9eZ1jwVAzVyacbLZDE3
 zgs7GCIB4usDviJqPduP507EGHzakku7kEqka7DnQdbcL/P89aFFUqVHvn1A3L7zMPgu
 6SZCGMvGFTDjGTtW4YD7ropWIZ+wbmmm0+6/f0w12V5NZRtCtn9z+7ZjfnSIQydiBtfN
 SZ+w==
X-Gm-Message-State: ANhLgQ0mMNIm4eEJY2Q/tUpQw7TwyneNxwOExWPBgioeZnDMTTRkoSiC
 cRgB4/SCc8VhJPl9rd9IstiwECp2tjqf07RLgWWhbwf2CWL1x+yj+b/GAoWaY4Y7sdHKG9qZuo7
 x84tx9zSGM+Otzpdqac4olEbHM3keEg==
X-Received: by 2002:ac8:4d83:: with SMTP id a3mr4594411qtw.259.1583963308860; 
 Wed, 11 Mar 2020 14:48:28 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtsEzdKfH7m2m28mgkpshSZzeyzQQNiRjBtaqGOgSv+gSun0NAQfBN9Lban03PlKiUdtVlsFw==
X-Received: by 2002:ac8:4d83:: with SMTP id a3mr4594391qtw.259.1583963308679; 
 Wed, 11 Mar 2020 14:48:28 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id g7sm251268qki.64.2020.03.11.14.48.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 14:48:27 -0700 (PDT)
Date: Wed, 11 Mar 2020 17:48:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v2 1/3] iommu/virtio: Add topology description to
 virtio-iommu config space
Message-ID: <20200311174348-mutt-send-email-mst@kernel.org>
References: <20200228172537.377327-1-jean-philippe@linaro.org>
 <20200228172537.377327-2-jean-philippe@linaro.org>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7BE404@SHSMSX104.ccr.corp.intel.com>
 <20200311174822.GA96893@myrica>
MIME-Version: 1.0
In-Reply-To: <20200311174822.GA96893@myrica>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Boeuf,
 Sebastien" <sebastien.boeuf@intel.com>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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

On Wed, Mar 11, 2020 at 06:48:22PM +0100, Jean-Philippe Brucker wrote:
> Yes "not elegant" in part because of the PCI fixup. Fixups are used to
> work around bugs

Not really - they are for anything unusual that common PCI code can not
handle on its own.

-- 
MST

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
