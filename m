Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24065C433F5
	for <iommu@archiver.kernel.org>; Tue, 22 Mar 2022 15:29:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB40B84107;
	Tue, 22 Mar 2022 15:29:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yVEkG4ujRTZx; Tue, 22 Mar 2022 15:29:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9F3F8841BF;
	Tue, 22 Mar 2022 15:29:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68B4BC0012;
	Tue, 22 Mar 2022 15:29:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DDFF6C000B
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 15:29:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DA25A60B18
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 15:29:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cV7RArL_p1MU for <iommu@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 15:29:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A381460601
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 15:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647962970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MScNzTeLACv/blJ5opJ1hO/EvqNLQgxKvQznIBl9/rI=;
 b=V5ZmiIzA6pQrgxqaKRytnJ1VC3bvgzwvYC2OGLa9Y0gaHwy/BiEWGyfhEzkLxn+sOVDij5
 zTo/XNWo1dZIVzRXQrJdx9+xQErwP79dsh8pZ8hgR6z1VQML954XKHo51SPQ31ZTb0s6M3
 ni6jXtZ3NFwyor9frr3XBjk9gsZetQE=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-267-gsHRs3zoOKSaWEj5TyMKEQ-1; Tue, 22 Mar 2022 11:29:27 -0400
X-MC-Unique: gsHRs3zoOKSaWEj5TyMKEQ-1
Received: by mail-io1-f70.google.com with SMTP id
 d19-20020a0566022bf300b00645eba5c992so12705868ioy.4
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 08:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=MScNzTeLACv/blJ5opJ1hO/EvqNLQgxKvQznIBl9/rI=;
 b=povwsXOtf5Yk0GkEj9N0CCTZBdFq7XmEOdn0tpFGh12s+pdI7XtmfK3yOpJ+Z8ZAMU
 35Js2b6hRZSJgO7O5tkX3YqUsKg8NNvnEAhcWx9Z5s8tUVpvpIZsr7fEbUnfMqfod+nq
 1VZa2oHrFa9SoI5cUZIyo0Vc3QXTKcu1kiUzxwkh3899rcUXkaiODyXQuT8W6bo8VuMr
 AAsqQXekGqaL/VYfbLQCufwdUUOOnIKp3j44vnQ9a2yMuJ+1PH6oLnsq6NKQw9koxatn
 2FFVSXqpqK6FI6fJkDpxbqi64qZwCVRWCUXiFV4/S3AhTG0T+LkBRThkc9mYgBvsTPxw
 BhGg==
X-Gm-Message-State: AOAM533sKfkxIIFq6leyOp5shW8vnWv4P7hqgUhh4P4b1ry5+ol08J7I
 uwVmgrsQ2umJaNOwlHIfOrBo+QxGFFSm5sACNC9Vub8eDwbNaEszXfgin7McuH8k06F5ioTzTR+
 3Fegw9aAG7GiXr/vHtCBIqWykVAh6FA==
X-Received: by 2002:a05:6e02:154f:b0:2c7:d5da:f12f with SMTP id
 j15-20020a056e02154f00b002c7d5daf12fmr12617534ilu.66.1647962966469; 
 Tue, 22 Mar 2022 08:29:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbHmZV3ynK+/wJmFgzfxYFXrwfco3PQ0Ay6mx5+mA3xyESZZvxvI4GkxLR+NiZ77fhbkDDvQ==
X-Received: by 2002:a05:6e02:154f:b0:2c7:d5da:f12f with SMTP id
 j15-20020a056e02154f00b002c7d5daf12fmr12617512ilu.66.1647962966167; 
 Tue, 22 Mar 2022 08:29:26 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 i11-20020a056e021b0b00b002c83d5df5a2sm1727094ilv.81.2022.03.22.08.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Mar 2022 08:29:25 -0700 (PDT)
Date: Tue, 22 Mar 2022 09:29:23 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH RFC 04/12] kernel/user: Allow user::locked_vm to be
 usable for iommufd
Message-ID: <20220322092923.5bc79861.alex.williamson@redhat.com>
In-Reply-To: <20220322145741.GH11336@nvidia.com>
References: <4-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <808a871b3918dc067031085de3e8af6b49c6ef89.camel@linux.ibm.com>
 <20220322145741.GH11336@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, kvm@vger.kernel.org,
 Niklas Schnelle <schnelle@linux.ibm.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Kevin Tian <kevin.tian@intel.com>,
 Daniel Jordan <daniel.m.jordan@oracle.com>, iommu@lists.linux-foundation.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, 22 Mar 2022 11:57:41 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Mar 22, 2022 at 03:28:22PM +0100, Niklas Schnelle wrote:
> > On Fri, 2022-03-18 at 14:27 -0300, Jason Gunthorpe wrote:  
> > > 
> > > user->locked_vm is the correct accounting to use for ulimit because it is
> > > per-user, and the ulimit is not supposed to be per-process. Other
> > > places (vfio, vdpa and infiniband) have used mm->pinned_vm and/or
> > > mm->locked_vm for accounting pinned pages, but this is only per-process
> > > and inconsistent with the majority of the kernel.  
> > 
> > Since this will replace parts of vfio this difference seems
> > significant. Can you explain this a bit more?  
> 
> I'm not sure what to say more, this is the correct way to account for
> this. It is natural to see it is right because the ulimit is supposted
> to be global to the user, not effectively reset every time the user
> creates a new process.
> 
> So checking the ulimit against a per-process variable in the mm_struct
> doesn't make too much sense.

I'm still picking my way through the series, but the later compat
interface doesn't mention this difference as an outstanding issue.
Doesn't this difference need to be accounted in how libvirt manages VM
resource limits?  AIUI libvirt uses some form of prlimit(2) to set
process locked memory limits.  A compat interface might be an
interesting feature, but does it only provide ioctl compatibility and
not resource ulimit compatibility?  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
