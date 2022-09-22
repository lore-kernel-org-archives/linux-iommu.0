Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84855A90
	for <iommu@lists.linux.dev>; Thu, 22 Sep 2022 15:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663858811;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ivgdi3fE+izLxTvy4ifpBoyfleVt3cTHPO9YgRhhbIM=;
	b=BTAMCA3jrPD3v7YG9wAqDPh90thZZrO3MHzPEvP4w0TNFyga0EYgIvJocRE5WAx++T5nvh
	FvqE2veACXiDYov+lHY2Y1h+Cu/++uEgi1gh1YmwT7r9fvAjtR1JvJ4+9dzvpMQ3dAKfZl
	7Dd14WX7tXbqfZMpi3dyL41dBFEF+dI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-9-57ylKtF6NiakcnCBcnOY3A-1; Thu, 22 Sep 2022 11:00:09 -0400
X-MC-Unique: 57ylKtF6NiakcnCBcnOY3A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 63F4B29AA383;
	Thu, 22 Sep 2022 15:00:08 +0000 (UTC)
Received: from redhat.com (unknown [10.33.36.120])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 423BC2166B26;
	Thu, 22 Sep 2022 15:00:03 +0000 (UTC)
Date: Thu, 22 Sep 2022 16:00:00 +0100
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
Message-ID: <Yyx4cEU1n0l6sP7X@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <0-v2-f9436d0bde78+4bb-iommufd_jgg@nvidia.com>
 <BN9PR11MB52762909D64C1194F4FCB4528C479@BN9PR11MB5276.namprd11.prod.outlook.com>
 <d5e33ebb-29e6-029d-aef4-af5c4478185a@redhat.com>
 <Yyoa+kAJi2+/YTYn@nvidia.com>
 <20220921120649.5d2ff778.alex.williamson@redhat.com>
 <YytbiCx3CxCnP6fr@nvidia.com>
 <YyxFEpAOC2V1SZwk@redhat.com>
 <YyxsV5SH85YcwKum@nvidia.com>
 <Yyx13kXCF4ovsxZg@redhat.com>
 <Yyx2ijVjKOkhcPQR@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yyx2ijVjKOkhcPQR@nvidia.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6

On Thu, Sep 22, 2022 at 11:51:54AM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 22, 2022 at 03:49:02PM +0100, Daniel P. Berrangé wrote:
> > On Thu, Sep 22, 2022 at 11:08:23AM -0300, Jason Gunthorpe wrote:
> > > On Thu, Sep 22, 2022 at 12:20:50PM +0100, Daniel P. Berrangé wrote:
> > > > On Wed, Sep 21, 2022 at 03:44:24PM -0300, Jason Gunthorpe wrote:
> > > > > On Wed, Sep 21, 2022 at 12:06:49PM -0600, Alex Williamson wrote:
> > > > > > The issue is where we account these pinned pages, where accounting is
> > > > > > necessary such that a user cannot lock an arbitrary number of pages
> > > > > > into RAM to generate a DoS attack.  
> > > > > 
> > > > > It is worth pointing out that preventing a DOS attack doesn't actually
> > > > > work because a *task* limit is trivially bypassed by just spawning
> > > > > more tasks. So, as a security feature, this is already very
> > > > > questionable.
> > > > 
> > > > The malicious party on host VM hosts is generally the QEMU process.
> > > > QEMU is normally prevented from spawning more tasks, both by SELinux
> > > > controls and be the seccomp sandbox blocking clone() (except for
> > > > thread creation).  We need to constrain what any individual QEMU can
> > > > do to the host, and the per-task mem locking limits can do that.
> > > 
> > > Even with syscall limits simple things like execve (enabled eg for
> > > qemu self-upgrade) can corrupt the kernel task-based accounting to the
> > > point that the limits don't work.
> > 
> > Note, execve is currently blocked by default too by the default
> > seccomp sandbox used with libvirt, as well as by the SELinux
> > policy again.  self-upgrade isn't a feature that exists (yet).
> 
> That userspace has disabled half the kernel isn't an excuse for the
> kernel to be insecure by design :( This needs to be fixed to enable
> features we know are coming so..
> 
> What would libvirt land like to see given task based tracking cannot
> be fixed in the kernel?

There needs to be a mechanism to control individual VMs, whether by
task or by cgroup. User based limits are not suited to what we need
to achieve.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

