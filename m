Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B267C971
	for <iommu@lists.linux.dev>; Fri, 10 Mar 2023 09:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1678441560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EK9itzNwztWEWdddqk8IMFWiym6+vyjgRi28eISez9E=;
	b=i8sCGw5oHBzJ1hPO5xt0Pjo0Q/DFUX395zov0etcLDQEjYUvM4yILpBy1Pm26FPcVLOe+P
	1Pj77p/tqZ4cd6EMu44S2hPh2P5o1OgBKfADqTSfozPTbiGvdUeNZDLXFAJPosYDLdup0G
	RC7kQpdmqSNwAKzRG6IiHq0SEEsywvQ=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-MrERoRzuMleOJvq8zVYIaA-1; Fri, 10 Mar 2023 04:45:58 -0500
X-MC-Unique: MrERoRzuMleOJvq8zVYIaA-1
Received: by mail-oo1-f71.google.com with SMTP id e137-20020a4a558f000000b0051a14b3d779so1496707oob.15
        for <iommu@lists.linux.dev>; Fri, 10 Mar 2023 01:45:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678441557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EK9itzNwztWEWdddqk8IMFWiym6+vyjgRi28eISez9E=;
        b=QxA4nxF/w8vNmhy8oqqRfaIS1awr0Efb2N3VG7/B4/vG4zQ6gJkMDnS3Y0XAK4S9SX
         vPoVZY0smJ6xygqYEQX9GND4NLU0nV6BN89UmuavAGkGgJA6iUQsQ5kzvao5BkrgtcMw
         s3hmU6C796ME2iblBO/+sUD9CrWrruD3gPbNQaUaFqJmTKllj7q5Jq/hFyuqSq11A811
         5SFn9+y4D7VwnXVkMh3N2A8jxlI/jBz63T28FNrrxUFPSSKoE9CUDVcrkFcNPGYi35e0
         SCjoLX5/2kxxDrWNw6aCo9wAed4hil4X4sGdkFhzyMk3Y5vkEBa7Q3cZTrOl0NIQhEBF
         lbEA==
X-Gm-Message-State: AO0yUKUhEPh47qDBXle6taQZ8org0lgeqBLukZxHZR75u/Iyk8+Od0Q9
	8dGI2LPIsJTjpXveM3QcoINpt15a9TXB6o4kZCsT6MYnYQm3co4P75VkSdl/RymvzlczvsYgRRy
	DQVx1cuW1MQSBiXSuNQ1uRYExrj7zuzo=
X-Received: by 2002:a05:6870:703:b0:172:cef0:4549 with SMTP id ea3-20020a056870070300b00172cef04549mr8547612oab.9.1678441557607;
        Fri, 10 Mar 2023 01:45:57 -0800 (PST)
X-Google-Smtp-Source: AK7set8wFTyGoabixP5OFNVzySToAyCse4a2PQn/SiQim9SvqUPTZJzF14tUdNW7G51x0q/0hGPiEqTsuhQVjiiGEfc=
X-Received: by 2002:a05:6870:703:b0:172:cef0:4549 with SMTP id
 ea3-20020a056870070300b00172cef04549mr8547605oab.9.1678441557382; Fri, 10 Mar
 2023 01:45:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230207120843.1580403-1-sunnanyong@huawei.com>
 <Y+7G+tiBCjKYnxcZ@nvidia.com> <20230217051158-mutt-send-email-mst@kernel.org>
 <Y+92c9us3HVjO2Zq@nvidia.com> <CACGkMEsVBhxtpUFs7TrQzAecO8kK_NR+b1EvD2H7MjJ+2aEKJw@mail.gmail.com>
 <20230310034101-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230310034101-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 10 Mar 2023 17:45:46 +0800
Message-ID: <CACGkMEsr3xSa=1WtU35CepWSJ8CK9g4nGXgmHS_9D09LHi7H8g@mail.gmail.com>
Subject: Re: [PATCH v2] vhost/vdpa: Add MSI translation tables to iommu for
 software-managed MSI
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Nanyong Sun <sunnanyong@huawei.com>, joro@8bytes.org, 
	will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	wangrong68@huawei.com, Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 10, 2023 at 4:41=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Feb 20, 2023 at 10:37:18AM +0800, Jason Wang wrote:
> > On Fri, Feb 17, 2023 at 8:43 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > On Fri, Feb 17, 2023 at 05:12:29AM -0500, Michael S. Tsirkin wrote:
> > > > On Thu, Feb 16, 2023 at 08:14:50PM -0400, Jason Gunthorpe wrote:
> > > > > On Tue, Feb 07, 2023 at 08:08:43PM +0800, Nanyong Sun wrote:
> > > > > > From: Rong Wang <wangrong68@huawei.com>
> > > > > >
> > > > > > Once enable iommu domain for one device, the MSI
> > > > > > translation tables have to be there for software-managed MSI.
> > > > > > Otherwise, platform with software-managed MSI without an
> > > > > > irq bypass function, can not get a correct memory write event
> > > > > > from pcie, will not get irqs.
> > > > > > The solution is to obtain the MSI phy base address from
> > > > > > iommu reserved region, and set it to iommu MSI cookie,
> > > > > > then translation tables will be created while request irq.
> > > > >
> > > > > Probably not what anyone wants to hear, but I would prefer we not=
 add
> > > > > more uses of this stuff. It looks like we have to get rid of
> > > > > iommu_get_msi_cookie() :\
> > > > >
> > > > > I'd like it if vdpa could move to iommufd not keep copying stuff =
from
> > > > > it..
> > > >
> > > > Absolutely but when is that happening?
> > >
> > > Don't know, I think it has to come from the VDPA maintainers, Nicolin
> > > made some drafts but wasn't able to get it beyond that.
> >
> > Cindy (cced) will carry on the work.
> >
> > Thanks
>
> Hmm didn't see anything yet. Nanyong Sun maybe you can take a look?

Just to clarify, Cindy will work on the iommufd conversion for
vhost-vDPA, the changes are non-trivial and may take time. Before we
are able to achieve that,  I think we still need something like this
patch to make vDPA work on software managed MSI platforms.

Maybe Nanyong can post a new version that addresses the comment so far?

Thanks

>
> > >
> > > Please have people who need more iommu platform enablement to pick it
> > > up instead of merging hacks like this..
> > >
> > > We are very close to having nested translation on ARM so anyone who i=
s
> > > serious about VDPA on ARM is going to need iommufd anyhow.
> > >
> > > Jason
> > >
>

