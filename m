Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849BA2F33
	for <iommu@lists.linux.dev>; Thu, 22 Sep 2022 11:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663845660;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=VuYqmWHx8E1Kx7C1xkE5SwjBorzdn+d+oVW6/OMVJJw=;
	b=c2ciACADM36jRrr1SInY+ZY5NCOHru8XZI1LZIkUFP+4IoBlPVL8WP9lyDNS3Aq9tZciCM
	VjURlsbtLj4qsWZYrpuMXbnWnl+L4fMFKSyAfevmD/R++YHcqrlvppkW+uPHG5Ukx3o/EA
	jGnHe8rvPfDf2rxcq91IRwhmt44X2mM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-331-zeKxygzaOwWJIVJYYcOBYg-1; Thu, 22 Sep 2022 07:20:57 -0400
X-MC-Unique: zeKxygzaOwWJIVJYYcOBYg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 42D0C85A59D;
	Thu, 22 Sep 2022 11:20:56 +0000 (UTC)
Received: from redhat.com (unknown [10.33.36.120])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 629EE40C83DD;
	Thu, 22 Sep 2022 11:20:52 +0000 (UTC)
Date: Thu, 22 Sep 2022 12:20:50 +0100
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
Message-ID: <YyxFEpAOC2V1SZwk@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <0-v2-f9436d0bde78+4bb-iommufd_jgg@nvidia.com>
 <BN9PR11MB52762909D64C1194F4FCB4528C479@BN9PR11MB5276.namprd11.prod.outlook.com>
 <d5e33ebb-29e6-029d-aef4-af5c4478185a@redhat.com>
 <Yyoa+kAJi2+/YTYn@nvidia.com>
 <20220921120649.5d2ff778.alex.williamson@redhat.com>
 <YytbiCx3CxCnP6fr@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YytbiCx3CxCnP6fr@nvidia.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1

On Wed, Sep 21, 2022 at 03:44:24PM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 21, 2022 at 12:06:49PM -0600, Alex Williamson wrote:
> > The issue is where we account these pinned pages, where accounting is
> > necessary such that a user cannot lock an arbitrary number of pages
> > into RAM to generate a DoS attack.  
> 
> It is worth pointing out that preventing a DOS attack doesn't actually
> work because a *task* limit is trivially bypassed by just spawning
> more tasks. So, as a security feature, this is already very
> questionable.

The malicious party on host VM hosts is generally the QEMU process.
QEMU is normally prevented from spawning more tasks, both by SELinux
controls and be the seccomp sandbox blocking clone() (except for
thread creation).  We need to constrain what any individual QEMU can
do to the host, and the per-task mem locking limits can do that.

The mgmt app is what spawns more tasks (QEMU instances) and they
are generally a trusted party on the host, or they are already
constrained in other ways such as cgroups or namespaces. The
mgmt apps would be expected to not intentionally overcommit the
host with VMs needing too much cummulative locked RAM.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

