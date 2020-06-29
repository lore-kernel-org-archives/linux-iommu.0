Return-Path: <SRS0=qe9F=AK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6AFC433DF
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 06:33:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C1EC23132
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 06:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RvTva7yv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C1EC23132
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C40F9887E9;
	Mon, 29 Jun 2020 06:33:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id USBc6cLe1yKM; Mon, 29 Jun 2020 06:33:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CF220886E0;
	Mon, 29 Jun 2020 06:33:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD532C0865;
	Mon, 29 Jun 2020 06:33:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFA7CC016E
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 06:33:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C011F892A5
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 06:33:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 95zOpZcIYWYV for <iommu@lists.linux-foundation.org>;
 Mon, 29 Jun 2020 06:33:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 26C33892A4
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 06:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593412428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Iiom3LNVi9ET0XgfPNiU1I3DflByt3ZNInrS8hmdp2U=;
 b=RvTva7yvWQJRqvtjLrnc/EM+idCCJEHhG9hgfioileljWjAEPy856c65mhWJCfuOmXs9e9
 OGXr2wScFqvevQWvWrrh5xDvzlgKdMnIO/IQPEkBgNn2g9yq2yG8tMvII9ABOJLEUQn9jv
 HbblSDoldsoqs73nUBpU7Aoazs5mAQE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-q7KImB1-Pr-FeMlDeoyszg-1; Mon, 29 Jun 2020 02:33:44 -0400
X-MC-Unique: q7KImB1-Pr-FeMlDeoyszg-1
Received: by mail-wm1-f69.google.com with SMTP id o138so16785308wme.4
 for <iommu@lists.linux-foundation.org>; Sun, 28 Jun 2020 23:33:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Iiom3LNVi9ET0XgfPNiU1I3DflByt3ZNInrS8hmdp2U=;
 b=Fhl6dKJVMpSD5SHf7NmJmEyuHkvgY7z0f0dAMWEw5D62tKD+yY7+3wEIEByPyj6nPY
 4iCrMkp4rudpda3+eu848ACXBcUku7IziWjl+R+jJxVRXUllzNb9cCOjduB8xEt6G0LQ
 VfJ/5xxbb8pikDn4E3J0UZ0JOE8x5F/daIpO4ATznJwnN2bIS5UEX647aWHUu0guHLXz
 92C8DLFkhAEtjD+JDEuHBhkuhVd8UMhXBpY6kuc4QDcaqimRALmgd1Q2lBqr7MW/UBvz
 3X4YqVC8/312ZoTiRZVup6Rzy6nd3FKyQ3hGl5SP0LuH2SjaZ8SIXurbDtbWXjxKO78w
 wFqA==
X-Gm-Message-State: AOAM531hT0O42mvmQbKQCNGsm+iJV3cKGoh0C6Ys9YHYN12winMdf59j
 iODxHYgIPzGL91qQ5rUBxibE6TDQuMm9F2ZGBcQMpD9se68A0I/X99no/rLNqsL7SogXjgm4v22
 URd6GK0MCfE55Hcq9AvRHeQviuHCuQg==
X-Received: by 2002:adf:8067:: with SMTP id 94mr14821912wrk.427.1593412423743; 
 Sun, 28 Jun 2020 23:33:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfYJ1M6jIB+Bt9+iuqmCS+1/JuHYbah8AxWL9RwY6izIKRHTcVkotYUsuHjo+DZqHXAwCswQ==
X-Received: by 2002:adf:8067:: with SMTP id 94mr14821888wrk.427.1593412423531; 
 Sun, 28 Jun 2020 23:33:43 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 s8sm41059111wru.38.2020.06.28.23.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2020 23:33:42 -0700 (PDT)
Date: Mon, 29 Jun 2020 02:33:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] xen: introduce xen_vring_use_dma
Message-ID: <20200629023225-mutt-send-email-mst@kernel.org>
References: <20200624050355-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006241047010.8121@sstabellini-ThinkPad-T480s>
 <20200624163940-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006241351430.8121@sstabellini-ThinkPad-T480s>
 <20200624181026-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006251014230.8121@sstabellini-ThinkPad-T480s>
 <20200626110629-mutt-send-email-mst@kernel.org>
 <DB6PR0402MB27601CA74B85DA5A9F5E5DD6886E0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <20200629022124-mutt-send-email-mst@kernel.org>
 <DB6PR0402MB27602AB2A9A242D79343CE48886E0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <DB6PR0402MB27602AB2A9A242D79343CE48886E0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "jgross@suse.com" <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

On Mon, Jun 29, 2020 at 06:25:41AM +0000, Peng Fan wrote:
> > > > > Anyway, re-reading the last messages of the original thread [1],
> > > > > it looks like Peng had a clear idea on how to fix the general issue.
> > > > > Peng, what happened with that?
> > >
> > > We shrinked the rpmsg reserved area to workaround the issue.
> > > So still use the dma apis in rpmsg.
> > >
> > > But here I am going to address domu android trusty issue using virtio.
> > 
> > My suggestion is to first of all fix DMA API so it works properly.
> 
> Could you please elaborate more details?
> 
> You mean the DMA API usage of rpmsg? Or xen domu dma_ops?
> 
> Thanks,
> Peng. 

Not 100% sure but I think xen dma ops.

-- 
MST

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
