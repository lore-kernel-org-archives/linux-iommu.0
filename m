Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A0A4C433EF
	for <iommu@archiver.kernel.org>; Wed, 23 Mar 2022 19:10:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A2EB184A4C;
	Wed, 23 Mar 2022 19:10:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SwVb2cvw37TZ; Wed, 23 Mar 2022 19:10:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6654B84A24;
	Wed, 23 Mar 2022 19:10:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47899C0012;
	Wed, 23 Mar 2022 19:10:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68844C000B
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 19:10:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 57457418C5
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 19:10:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4Kz1wFUl1j1Y for <iommu@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 19:10:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6646C418C1
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 19:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648062644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hMSz6R8MljxH5tNM923iQc7Lkarfhq9MPHr06b3TmaI=;
 b=UIgzG7lk1qtjm84hfE7EoMgs6eelfBcA3N2vS8YWjvqHun95RRmd5Wg5RkxDMY7CcjKa/m
 nY+kEMvjuUYMk0Ese/fm4tPpSWhbkwfRFVMO+E3jXY3Cy362dL1aZAX3hdECV8vCcT0uPL
 iarNc9E4hRD1fZuynGl27o3HBuPuG5M=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-471-ij408z34NEuTpw3fFNF4fg-1; Wed, 23 Mar 2022 15:10:42 -0400
X-MC-Unique: ij408z34NEuTpw3fFNF4fg-1
Received: by mail-oi1-f197.google.com with SMTP id
 c11-20020aca1c0b000000b002da42e09f96so1465217oic.1
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 12:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=hMSz6R8MljxH5tNM923iQc7Lkarfhq9MPHr06b3TmaI=;
 b=1RidnlmP0kpzFNfVSSh0ZgAWfJz888uLhfYp2ycCJV2ngsXvb7HJ3J8v4mIOgKrsyB
 uyEXLtSismNRjAnY/eI/lXGRx9JFHa6RRdXyEN1q5gFEUfDzUR0QmO6mG4qBo8qWOFS8
 3TKRnMbEjoEEkQNhGRCciZo6LHPcz7S4l+aWBtCTSHcEKkDxpjkiTBCI72fPGcaNz+nG
 0wPMZJwWJkTPU77hn/AXEvR3b8d0p12lUpPwO6M0P/JgLk5Dmr1Lo4Wg+FpZKc5Q0vCr
 xfxft43q2pBiyCkmWtMa9dj3zmnhNEpMZEAbGUKCNzGER+zFmPpHrdWCsnwfZJSeLG59
 peZQ==
X-Gm-Message-State: AOAM530+0gTL4NjeBqR5jrR5P/06rVuxgLYpvsTblFcmR9PhfN/ZyLz8
 LMEIyZMvaj04fegEL84B/H03qzJ0zih49WzDhXaTBpMLPKwRJmAMrSW30SWMmRt4YpGZi8X1lKX
 37wuA3lUeHfTrqeKV1mzpEfKWAABPWw==
X-Received: by 2002:aca:220c:0:b0:2d9:eb5e:f4d0 with SMTP id
 b12-20020aca220c000000b002d9eb5ef4d0mr5440152oic.232.1648062642084; 
 Wed, 23 Mar 2022 12:10:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTy7pF0/xnQnJ15xFLURJLPj9g6wz5WiKdNGKM06ryRsQgJ9LxrLcXzTDlwF53gvwtUDHQ9g==
X-Received: by 2002:aca:220c:0:b0:2d9:eb5e:f4d0 with SMTP id
 b12-20020aca220c000000b002d9eb5ef4d0mr5440120oic.232.1648062641909; 
 Wed, 23 Mar 2022 12:10:41 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 d9-20020a9d51c9000000b005b2466cd7b3sm352588oth.36.2022.03.23.12.10.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Mar 2022 12:10:41 -0700 (PDT)
Date: Wed, 23 Mar 2022 13:10:38 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH RFC 08/12] iommufd: IOCTLs for the io_pagetable
Message-ID: <20220323131038.3b5cb95b.alex.williamson@redhat.com>
In-Reply-To: <8-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
References: <0-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <8-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 Kevin Tian <kevin.tian@intel.com>, Daniel Jordan <daniel.m.jordan@oracle.com>,
 iommu@lists.linux-foundation.org, Joao Martins <joao.m.martins@oracle.com>,
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

On Fri, 18 Mar 2022 14:27:33 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> +static int conv_iommu_prot(u32 map_flags)
> +{
> +	int iommu_prot;
> +
> +	/*
> +	 * We provide no manual cache coherency ioctls to userspace and most
> +	 * architectures make the CPU ops for cache flushing privileged.
> +	 * Therefore we require the underlying IOMMU to support CPU coherent
> +	 * operation.
> +	 */
> +	iommu_prot = IOMMU_CACHE;

Where is this requirement enforced?  AIUI we'd need to test
IOMMU_CAP_CACHE_COHERENCY somewhere since functions like
intel_iommu_map() simply drop the flag when not supported by HW.

This also seems like an issue relative to vfio compatibility that I
don't see mentioned in that patch.  Thanks,

Alex

> +	if (map_flags & IOMMU_IOAS_MAP_WRITEABLE)
> +		iommu_prot |= IOMMU_WRITE;
> +	if (map_flags & IOMMU_IOAS_MAP_READABLE)
> +		iommu_prot |= IOMMU_READ;
> +	return iommu_prot;
> +}


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
