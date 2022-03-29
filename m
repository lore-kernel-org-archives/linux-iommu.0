Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12879C433F5
	for <iommu@archiver.kernel.org>; Tue, 29 Mar 2022 05:00:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B44A840483;
	Tue, 29 Mar 2022 05:00:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HOli9Qu0YJCF; Tue, 29 Mar 2022 05:00:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 713A640AE5;
	Tue, 29 Mar 2022 05:00:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 279DEC002C;
	Tue, 29 Mar 2022 05:00:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9CEB4C0012
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 05:00:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 817F640ADB
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 05:00:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id liceyB8f5UXo for <iommu@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 05:00:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5C47C4047D
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 05:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648530007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K7gDC8bShBI9LHGd+WbA3yzlonPiUS4KeezNJU72OYg=;
 b=GhIW3Mky1w+z5GH5fHQjxpE9xVDald90TAiqXMu6eYVsDte2bFENjJez/EcizL7kIHHJro
 XO+7/TmldOqKfbM+yzfiO6z6uanZLA7kNWQJMesSn2TKCvp3utD+HvD4623AqqKrFM2TZg
 QNBA+El7XmGddoZmlQ8n40LS0bhgI7c=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-335-k_VeFBZoOumdBzhjXT2Phg-1; Tue, 29 Mar 2022 01:00:05 -0400
X-MC-Unique: k_VeFBZoOumdBzhjXT2Phg-1
Received: by mail-lj1-f200.google.com with SMTP id
 q5-20020a2e9145000000b002497bf0eaa1so6964295ljg.5
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 22:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=K7gDC8bShBI9LHGd+WbA3yzlonPiUS4KeezNJU72OYg=;
 b=IZDX1rzygZQUGm6g0opOY4MafbVW0MpzfL4lWWWKbzDWlg6YeDk/JwH/VJPdhq8eHj
 Si6WIqEE4JZQPx/qXM42McZLYDPsQNZVbWW/egjOQIrgJ3ZkpB0640ensMEvZXX82A2+
 O1zVhLbxbfC7JpoiXhZEKBYa7JjLGBTlyAj9WH3KkiDThvB5PiJf1KdOckYOSqE4ch7J
 aNUzla6GTB413XGE6HSe8gjzz/jAF5n+RgY4prkeQO4l35Dn/8mb4GAdEobRispBe0/P
 CHJPB1MBalQUzuKlppQtODlFAWeDUEU7tZAgbSj3aYn3VZHg75PpKLMBHeI/CU1cF8Wz
 K8Gw==
X-Gm-Message-State: AOAM530uJHWiKkWyL2Z1SWlow3d1gSytQWNV3qFFZ3NJwsGnrT30ruRn
 xGwqI6CBQIW/RdTlJooOib9sw1luheBUTIFVmdcDFVIl2CwiOmKHjhuSmSA/qIIuoiqZ92DJakc
 qkzsENK5sERA55Zjn/gr27/r4YvVXPWU0odqIQ7iardXSBg==
X-Received: by 2002:a05:6512:2203:b0:44a:12c9:8696 with SMTP id
 h3-20020a056512220300b0044a12c98696mr993994lfu.98.1648530003444; 
 Mon, 28 Mar 2022 22:00:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfk6lHA5WhshEQEE6YBIv+08Bg/UEgteU+mmeSwvo4lkCbmpArIaObJ6kzGXap+UvxE8xNiz9kZzmdXgTc6hA=
X-Received: by 2002:a05:6512:2203:b0:44a:12c9:8696 with SMTP id
 h3-20020a056512220300b0044a12c98696mr993973lfu.98.1648530003271; Mon, 28 Mar
 2022 22:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220322092923.5bc79861.alex.williamson@redhat.com>
 <20220322161521.GJ11336@nvidia.com>
 <BN9PR11MB5276BED72D82280C0A4C6F0C8C199@BN9PR11MB5276.namprd11.prod.outlook.com>
 <CACGkMEutpbOc_+5n3SDuNDyHn19jSH4ukSM9i0SUgWmXDydxnA@mail.gmail.com>
 <BN9PR11MB5276E3566D633CEE245004D08C199@BN9PR11MB5276.namprd11.prod.outlook.com>
 <CACGkMEvTmCFqAsc4z=2OXOdr7X--0BSDpH06kCiAP5MHBjaZtg@mail.gmail.com>
 <BN9PR11MB5276ECF1F1C7D0A80DA086D18C199@BN9PR11MB5276.namprd11.prod.outlook.com>
 <CACGkMEtpWemw6tj=suxNjvSHuixyzhMJBYmqdbhQkinuWNADCQ@mail.gmail.com>
 <20220324114605.GX11336@nvidia.com>
 <CACGkMEtTVMuc-JebEbTrb3vRUVaNJ28FV_VyFRdRquVQN9VeQA@mail.gmail.com>
 <20220328122239.GL1342626@nvidia.com>
In-Reply-To: <20220328122239.GL1342626@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 29 Mar 2022 12:59:52 +0800
Message-ID: <CACGkMEu_Zc+xBR0G9qNR6XQKNY9MLfTvbpgzpL2kNC4ri3DRQg@mail.gmail.com>
Subject: Re: [PATCH RFC 04/12] kernel/user: Allow user::locked_vm to be usable
 for iommufd
To: Jason Gunthorpe <jgg@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Niklas Schnelle <schnelle@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Daniel Jordan <daniel.m.jordan@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Martins,
 Joao" <joao.m.martins@oracle.com>, David Gibson <david@gibson.dropbear.id.au>,
 Sean Mooney <smooney@redhat.com>
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

On Mon, Mar 28, 2022 at 8:23 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Mon, Mar 28, 2022 at 09:53:27AM +0800, Jason Wang wrote:
> > To me, it looks more easier to not answer this question by letting
> > userspace know about the change,
>
> That is not backwards compatbile, so I don't think it helps unless we
> say if you open /dev/vfio/vfio you get old behavior and if you open
> /dev/iommu you get new...

Actually, this is one way to go. Trying to behave exactly like typ1
might be not easy.

>
> Nor does it answer if I can fix RDMA or not :\
>

vDPA has a backend feature negotiation, then actually, userspace can
tell vDPA to go with the new accounting approach. Not sure RDMA can do
the same.

Thanks

> So we really do need to know what exactly is the situation here.
>
> Jason
>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
