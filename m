Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB0D3D63
	for <iommu@lists.linux.dev>; Fri, 23 Sep 2022 14:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663941793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4w0e2qKjVlL2l3TiYoyEN7yHr9QOPhW8hihiff8HOpE=;
	b=BCSbSjDBP5wq5RvBeTnKR31muxboeJW/WODYeAgYX4NwQWEEj+sEzZUn1juRR9gydWH+ov
	5+i/sFqG4kTBSzV6BorlOTGaBio+LDwc6Jhq3y6i9d3Xby2oJlB/uQm4mDqEgMNNvqxeYy
	pCy2OFnI85mQiZzVkbeoMJuznOSw/XM=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-593-Xmn1MmgvOHiF0UnD6Z5AEA-1; Fri, 23 Sep 2022 10:03:12 -0400
X-MC-Unique: Xmn1MmgvOHiF0UnD6Z5AEA-1
Received: by mail-il1-f199.google.com with SMTP id x14-20020a056e021cae00b002f1d5aca8c6so267557ill.5
        for <iommu@lists.linux.dev>; Fri, 23 Sep 2022 07:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=4w0e2qKjVlL2l3TiYoyEN7yHr9QOPhW8hihiff8HOpE=;
        b=CArqCYf9e2u3KKVrYC5D6aWAWKEuLiOJixSpdZMeX9SqWgyLRxhmv7g2+Q89hlU/sc
         K+U3lR1Q3Ffa+xlZOkhNoJd/7tCmsdopiCWEWfSE+euWGDNwueU1pEl7JZFoneXJHcQs
         yd3u/lvM/7mMMjGWMNNY/eiHE4epUlrCAeZLZOQZxefpqQa3NOZn1CxXtGNwX8OcF5vt
         25B5jNLhKeqeRd/ARqol7G48RBq4apf1NuUbM/F2O+QMDRhQz+QPDyOyQ3/7FT8zSl8u
         AakS/qY87i892dV0LlhzLVPFRh7sdGe+1p3AufuoAkQr2zxRvvc7YE3oJit3fzeJ2Qjm
         vQpQ==
X-Gm-Message-State: ACrzQf2AdCNqWryRvedUQX6E4I8L7hxzrvL3AaCL8eAcyZC/CtVhaHYS
	OC0ISS7422IaS8GbGdqVP0QQJ9LRcX9EvuR51t79Ogj6iAOIqfvxWdAL4GerVVQhkOpJwUnWylx
	TQT2yQFcWum80xSg=
X-Received: by 2002:a05:6638:4907:b0:35a:88c3:594d with SMTP id cx7-20020a056638490700b0035a88c3594dmr4833176jab.194.1663941791990;
        Fri, 23 Sep 2022 07:03:11 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7rtG+aKW4uVpVRTemjU1wMA9ul0qLImqNjuSlGdG9o3Ayhgtkv7S2ZB45Ft3viH7Z1kZz4gw==
X-Received: by 2002:a05:6638:4907:b0:35a:88c3:594d with SMTP id cx7-20020a056638490700b0035a88c3594dmr4833120jab.194.1663941791435;
        Fri, 23 Sep 2022 07:03:11 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id t1-20020a028781000000b003428c21ed12sm3404639jai.167.2022.09.23.07.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 07:03:10 -0700 (PDT)
Date: Fri, 23 Sep 2022 08:03:07 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Eric Auger
 <eric.auger@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Rodel,
 Jorg" <jroedel@suse.de>, Lu Baolu <baolu.lu@linux.intel.com>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>, Cornelia Huck <cohuck@redhat.com>, Daniel
 Jordan <daniel.m.jordan@oracle.com>, David Gibson
 <david@gibson.dropbear.id.au>, Eric Farman <farman@linux.ibm.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>, Jason Wang
 <jasowang@redhat.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "Martins, Joao" <joao.m.martins@oracle.com>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, Matthew Rosato <mjrosato@linux.ibm.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>, Niklas
 Schnelle <schnelle@linux.ibm.com>, Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Keqian Zhu <zhukeqian1@huawei.com>, Steve Sistare
 <steven.sistare@oracle.com>, "libvir-list@redhat.com"
 <libvir-list@redhat.com>, Laine Stump <laine@redhat.com>
Subject: Re: [PATCH RFC v2 00/13] IOMMUFD Generic interface
Message-ID: <20220923080307.1d9a6166.alex.williamson@redhat.com>
In-Reply-To: <Yy20xURdYLzf0ikS@nvidia.com>
References: <Yyoa+kAJi2+/YTYn@nvidia.com>
	<20220921120649.5d2ff778.alex.williamson@redhat.com>
	<YytbiCx3CxCnP6fr@nvidia.com>
	<YyxFEpAOC2V1SZwk@redhat.com>
	<YyxsV5SH85YcwKum@nvidia.com>
	<Yyx13kXCF4ovsxZg@redhat.com>
	<Yyx2ijVjKOkhcPQR@nvidia.com>
	<Yyx4cEU1n0l6sP7X@redhat.com>
	<Yyx/yDQ/nDVOTKSD@nvidia.com>
	<Yy10WIgQK3Q74nBm@redhat.com>
	<Yy20xURdYLzf0ikS@nvidia.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 23 Sep 2022 10:29:41 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Fri, Sep 23, 2022 at 09:54:48AM +0100, Daniel P. Berrang=C3=A9 wrote:
>=20
> > Yes, we use cgroups extensively already. =20
>=20
> Ok, I will try to see about this
>=20
> Can you also tell me if the selinux/seccomp will prevent qemu from
> opening more than one /dev/vfio/vfio ? I suppose the answer is no?

QEMU manages the container:group association with legacy vfio, so it
can't be restricted from creating multiple containers.  Thanks,

Alex

