Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FFB845E
	for <iommu@lists.linux.dev>; Thu, 22 Sep 2022 14:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663858038;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hzEQDHDkTMD8itCS1w4cOM4UkffChWXzmcJHVsFiWBw=;
	b=FDrJuzj5iCqg+KbV/VGgYFIvynSPT3S/3Bsjm6iigLebnN0Xrppq/KCvDNVQHW8Mj6pEes
	pI9oUqEOelhrs37Ge/6aDWuG61/rGWMPqN86jEJIWJHPhf4lZv4UDu8bkcQONBKUJ6Dwzi
	avVLRRUnHudNiJP2O5i3QP+bq1u/taQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-12-Q_jfnz-YOTGGfgOMZw3YMg-1; Thu, 22 Sep 2022 10:47:14 -0400
X-MC-Unique: Q_jfnz-YOTGGfgOMZw3YMg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA5E68A51C9;
	Thu, 22 Sep 2022 14:46:52 +0000 (UTC)
Received: from redhat.com (unknown [10.33.36.120])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DC122166BA5;
	Thu, 22 Sep 2022 14:46:41 +0000 (UTC)
Date: Thu, 22 Sep 2022 15:46:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Eric Auger <eric.auger@redhat.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	"Rodel, Jorg" <jroedel@suse.de>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Eric Farman <farman@linux.ibm.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Wang <jasowang@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	"Martins, Joao" <joao.m.martins@oracle.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Keqian Zhu <zhukeqian1@huawei.com>,
	Steve Sistare <steven.sistare@oracle.com>,
	"libvir-list@redhat.com" <libvir-list@redhat.com>,
	Laine Stump <laine@redhat.com>
Subject: Re: [PATCH RFC v2 00/13] IOMMUFD Generic interface
Message-ID: <Yyx1Tzi7KS8Xdg3V@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <0-v2-f9436d0bde78+4bb-iommufd_jgg@nvidia.com>
 <BN9PR11MB52762909D64C1194F4FCB4528C479@BN9PR11MB5276.namprd11.prod.outlook.com>
 <d5e33ebb-29e6-029d-aef4-af5c4478185a@redhat.com>
 <Yyoa+kAJi2+/YTYn@nvidia.com>
 <20220921120649.5d2ff778.alex.williamson@redhat.com>
 <YyxBuQwIUdiqGoR3@redhat.com>
 <YyxtljfKFYQh9Y+H@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YyxtljfKFYQh9Y+H@nvidia.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6

On Thu, Sep 22, 2022 at 11:13:42AM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 22, 2022 at 12:06:33PM +0100, Daniel P. Berrangé wrote:
> 
> > So per-user locked mem accounting looks like a regression in
> > our VM isolation abilities compared to the per-task accounting.
> 
> For this kind of API the management app needs to put each VM in its
> own user, which I'm a bit surprised it doesn't already do as a further
> protection against cross-process concerns.

Putting VMs in dedicated users is not practical to automatically do
on a general purpose OS install, because there's no arbitrator of
what UID ranges can be safely used without conflicting with other
usage on the OS. 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

