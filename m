Return-Path: <SRS0=Rn8G=OM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D0BC433F5
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 21:02:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17BCE6112F
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 21:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 17BCE6112F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D0070415B1;
	Wed, 22 Sep 2021 21:02:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zmyiyVljGOMU; Wed, 22 Sep 2021 21:02:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AF8CA415B2;
	Wed, 22 Sep 2021 21:02:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B6B1C0011;
	Wed, 22 Sep 2021 21:02:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C58B6C000D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 21:02:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BEF9C415B2
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 21:02:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OaPghSJcAULY for <iommu@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 21:02:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0552A415B1
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 21:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632344535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EkcI36nWkyMmdwAV3luppztFyqzSlOhfIH0Z+Rmy1YE=;
 b=XvF3p9pvrkVMdPEGfrseBGS+vBXJFnWq6NVdJb0XR4T6UnzWgePwqqPotDCIY4+9zHSEk8
 f3sb6HWPFP0/FcRmx5IKsFZ+5DM6pcgOUDZDCsIe4u3AFzvEz1TshppghNUAFVClQNrMPE
 5H5tc9rHHn80uHervzsQthGuZmpPF5w=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17--21t9ovnMQuF-NA-L-n_ew-1; Wed, 22 Sep 2021 17:01:05 -0400
X-MC-Unique: -21t9ovnMQuF-NA-L-n_ew-1
Received: by mail-oi1-f198.google.com with SMTP id
 o8-20020a0568080bc800b0026bf78d5d98so2520170oik.19
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 14:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=EkcI36nWkyMmdwAV3luppztFyqzSlOhfIH0Z+Rmy1YE=;
 b=wczKQfjlGNuBtPLujoJmGyyymKMHBwGjx4zQZSk2VkHjvKiFaBzkJcGAQ6zNllH5Wx
 VjrvPs1IhjrjZ3iOFPpJ9ilPJoAr5HFQ74qhS/8DbpFWGOP7+epA+Ig/KqCuotbO+8vU
 eIsPLeM8ZKOh4hJgmFdfSpJJ5PVIFX+DVXkD9kc7Kfd+2M4GywqXTu83X/CLmtSLVOJH
 N0mWyVHH6zJWasHbio9NgT4RJC4Tienln99Whb1o6dthIN3vuRh8DLYvTaBHpkmd9RhX
 3G7K6RQDPokIiNU5pjTm/G+QiEIWdMfLOv1ZkROgeMy5wqqhPzFbVCJWsN5S2JYlYxZF
 qrOA==
X-Gm-Message-State: AOAM530HMb+yvm4TnOHs/zkmwLUP4cy7GalCyrc3YJfmUhMCFaUUDXk8
 C9TnJezZgHt/tJwKyudtLkaLGTLeUTLeEn/LlRktDoBaGFEU2E6hkV7pqhdaBQe8XY0+EKtcjQw
 R8tKwSlNCDwVhGhrpqBnTNIJVGNYqXw==
X-Received: by 2002:a9d:72db:: with SMTP id d27mr1019231otk.279.1632344464351; 
 Wed, 22 Sep 2021 14:01:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1foDmaxSBss0gFC+IJcIZIQhSoVK6YGjP2/EeJFqHN5DuMyQV2c7d4zQ3lhJ0DoWQZHDvuQ==
X-Received: by 2002:a9d:72db:: with SMTP id d27mr1019192otk.279.1632344464096; 
 Wed, 22 Sep 2021 14:01:04 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
 by smtp.gmail.com with ESMTPSA id v4sm696691ott.72.2021.09.22.14.01.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Sep 2021 14:01:03 -0700 (PDT)
Date: Wed, 22 Sep 2021 15:01:01 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC 08/20] vfio/pci: Add VFIO_DEVICE_BIND_IOMMUFD
Message-ID: <20210922150101.5548eb6f.alex.williamson@redhat.com>
In-Reply-To: <20210921172939.GU327412@nvidia.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-9-yi.l.liu@intel.com>
 <20210921172939.GU327412@nvidia.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, jasowang@redhat.com, kwankhede@nvidia.com, hch@lst.de,
 jean-philippe@linaro.org, dave.jiang@intel.com, ashok.raj@intel.com,
 corbet@lwn.net, kevin.tian@intel.com, parav@mellanox.com, lkml@metux.net,
 david@gibson.dropbear.id.au, dwmw2@infradead.org, jun.j.tian@intel.com,
 linux-kernel@vger.kernel.org, lushenming@huawei.com,
 iommu@lists.linux-foundation.org, pbonzini@redhat.com, robin.murphy@arm.com
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

On Tue, 21 Sep 2021 14:29:39 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Sun, Sep 19, 2021 at 02:38:36PM +0800, Liu Yi L wrote:
> > +struct vfio_device_iommu_bind_data {
> > +	__u32	argsz;
> > +	__u32	flags;
> > +	__s32	iommu_fd;
> > +	__u64	dev_cookie;  
> 
> Missing explicit padding
> 
> Always use __aligned_u64 in uapi headers, fix all the patches.

We don't need padding or explicit alignment if we just swap the order
of iommu_fd and dev_cookie.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
