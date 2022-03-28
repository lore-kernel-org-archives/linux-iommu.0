Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06980C433F5
	for <iommu@archiver.kernel.org>; Mon, 28 Mar 2022 01:53:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 90981606E6;
	Mon, 28 Mar 2022 01:53:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Upagm2cmffwF; Mon, 28 Mar 2022 01:53:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6E0AD6061B;
	Mon, 28 Mar 2022 01:53:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4174DC002C;
	Mon, 28 Mar 2022 01:53:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A6DBC0012
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 01:53:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 818C360681
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 01:53:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WOZT6imwngkX for <iommu@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 01:53:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6CEBF6061B
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 01:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648432424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2dO/oV1qOltZyPId5baa2irih13HA1zn6mOKO291fhY=;
 b=YJfwTswsCZlK+pdf2uysa8otMmCqxmZ/IDHxMRQryEBnthuXseoyj7YJqTcuEupepx/egY
 +LZZDB1L4LGAyH+DIhTaLttBYrpY5xzIQuPEaMoR3Ief5o+4IZLYZZCVS0tLGvqvn1qsk+
 Z29WDCfmPdLIYe3Uy9hhG/qCkU+ke9Q=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-503-U702SJZnOhOVhbFyMJqrtA-1; Sun, 27 Mar 2022 21:53:40 -0400
X-MC-Unique: U702SJZnOhOVhbFyMJqrtA-1
Received: by mail-lj1-f198.google.com with SMTP id
 v8-20020a2e7a08000000b002498273eb20so5232916ljc.7
 for <iommu@lists.linux-foundation.org>; Sun, 27 Mar 2022 18:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2dO/oV1qOltZyPId5baa2irih13HA1zn6mOKO291fhY=;
 b=P0w1wxJgGv0+4HgLgjdTPaRS5ke16EPNF1ab7CukWNmTFJ5K3Iln0sWJx7VbODFBMX
 tOuWbQyzGawndTPgeVYOC1/Pwku2FewqeItHaJqTHcpfXYV0Z99r8T6dSAVgCvRDbMeT
 iOE67KGYS8ZI+Dtv7shte4T9QfkAoPE5gwT9Xx9yFe24hoU3nmatcPHRCECcbYR14QNC
 N9Vd07eHFQYwfcbDoD6FzYj+QcqgHlXb9Hil+HHnZMJnK2ELh8SeD/u7HjZd5KbxM5yN
 WCmeAWd8ukz9GgerxfHYJsu2GeG8bm2Q60G5uohgj++UVTI1XCiCrtJK8F0upzpgTRzC
 mTEg==
X-Gm-Message-State: AOAM533bJ/14tt7QKNDfYXCD6xv0A57PJ3H+B5KaOu5G3SAN6+B3vj1Z
 w1m287vHz7UldRc0eLSMMJTspCXKhWKHDYhn0X1sVVvixjJLYGXfIjnAbOP7EpiMhih2Czhp432
 WAIXvYIXYA8Pm9RJ18Vh3+6Vf/V2uHk1yY1oj0RYuDg7WTw==
X-Received: by 2002:a05:6512:3341:b0:433:b033:bd22 with SMTP id
 y1-20020a056512334100b00433b033bd22mr17655628lfd.190.1648432419154; 
 Sun, 27 Mar 2022 18:53:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxq8kzelEt+v1IsX1TZPbDlKbWX97klqcRsVueoo1G7JjrBUCzhgXc3wVkBT8uRlLsPpQUWTvhiKwixigMDGIE=
X-Received: by 2002:a05:6512:3341:b0:433:b033:bd22 with SMTP id
 y1-20020a056512334100b00433b033bd22mr17655598lfd.190.1648432418951; Sun, 27
 Mar 2022 18:53:38 -0700 (PDT)
MIME-Version: 1.0
References: <808a871b3918dc067031085de3e8af6b49c6ef89.camel@linux.ibm.com>
 <20220322145741.GH11336@nvidia.com>
 <20220322092923.5bc79861.alex.williamson@redhat.com>
 <20220322161521.GJ11336@nvidia.com>
 <BN9PR11MB5276BED72D82280C0A4C6F0C8C199@BN9PR11MB5276.namprd11.prod.outlook.com>
 <CACGkMEutpbOc_+5n3SDuNDyHn19jSH4ukSM9i0SUgWmXDydxnA@mail.gmail.com>
 <BN9PR11MB5276E3566D633CEE245004D08C199@BN9PR11MB5276.namprd11.prod.outlook.com>
 <CACGkMEvTmCFqAsc4z=2OXOdr7X--0BSDpH06kCiAP5MHBjaZtg@mail.gmail.com>
 <BN9PR11MB5276ECF1F1C7D0A80DA086D18C199@BN9PR11MB5276.namprd11.prod.outlook.com>
 <CACGkMEtpWemw6tj=suxNjvSHuixyzhMJBYmqdbhQkinuWNADCQ@mail.gmail.com>
 <20220324114605.GX11336@nvidia.com>
In-Reply-To: <20220324114605.GX11336@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 28 Mar 2022 09:53:27 +0800
Message-ID: <CACGkMEtTVMuc-JebEbTrb3vRUVaNJ28FV_VyFRdRquVQN9VeQA@mail.gmail.com>
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

On Thu, Mar 24, 2022 at 7:46 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Thu, Mar 24, 2022 at 11:50:47AM +0800, Jason Wang wrote:
>
> > It's simply because we don't want to break existing userspace. [1]
>
> I'm still waiting to hear what exactly breaks in real systems.
>
> As I explained this is not a significant change, but it could break
> something in a few special scenarios.
>
> Also the one place we do have ABI breaks is security, and ulimit is a
> security mechanism that isn't working right. So we do clearly need to
> understand *exactly* what real thing breaks - if anything.
>
> Jason
>

To tell the truth, I don't know. I remember that Openstack may do some
accounting so adding Sean for more comments. But we really can't image
openstack is the only userspace that may use this.

To me, it looks more easier to not answer this question by letting
userspace know about the change,

Thanks

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
