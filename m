Return-Path: <SRS0=Sm7F=2K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1587C2D0C8
	for <iommu@archiver.kernel.org>; Fri, 20 Dec 2019 18:54:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B73AA206D8
	for <iommu@archiver.kernel.org>; Fri, 20 Dec 2019 18:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B73AA206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 875C4226C2;
	Fri, 20 Dec 2019 18:54:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SKU0nsFbN63t; Fri, 20 Dec 2019 18:54:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E8DF920474;
	Fri, 20 Dec 2019 18:54:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD94CC1796;
	Fri, 20 Dec 2019 18:54:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A0E2C077D;
 Fri, 20 Dec 2019 18:54:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 084ED87319;
 Fri, 20 Dec 2019 18:54:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IY5ul91a3J2A; Fri, 20 Dec 2019 18:54:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C545787317;
 Fri, 20 Dec 2019 18:54:32 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Dec 2019 10:54:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,336,1571727600"; d="scan'208";a="267593304"
Received: from jpan9-mobl2.amr.corp.intel.com (HELO localhost)
 ([10.254.180.107])
 by FMSMGA003.fm.intel.com with ESMTP; 20 Dec 2019 10:54:31 -0800
Date: Fri, 20 Dec 2019 10:54:30 -0800
From: "Jacob Pan (Jun)" <jacob.jun.pan@intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [RFC 00/13] virtio-iommu on non-devicetree platforms
Message-ID: <20191220105430.0000437b@intel.com>
In-Reply-To: <20191218112044.GA2371701@myrica>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
 <20191122160102.00004489@intel.com>
 <20191125180247.GD945122@lophozonia>
 <20191203190136.00007171@intel.com>
 <20191218112044.GA2371701@myrica>
Organization: intel
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Cc: virtio-dev@lists.oasis-open.org, kevin.tian@intel.com,
 gregkh@linuxfoundation.org, linux-pci@vger.kernel.org, sudeep.holla@arm.com,
 rjw@rjwysocki.net, virtualization@lists.linux-foundation.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, mst@redhat.com, jacob.jun.pan@intel.com,
 guohanjun@huawei.com, bhelgaas@google.com, jasowang@redhat.com,
 linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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

On Wed, 18 Dec 2019 12:20:44 +0100
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> On Tue, Dec 03, 2019 at 07:01:36PM -0800, Jacob Pan (Jun) wrote:
> > Hi Jean,
> > 
> > Sorry for the delay, I was out last week. Comments inline below.
> > 
> > On Mon, 25 Nov 2019 19:02:47 +0100
> > Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:
> >   
> > > On Fri, Nov 22, 2019 at 04:01:02PM -0800, Jacob Pan (Jun) wrote:  
> > > > > (1) ACPI has one table per vendor (DMAR for Intel, IVRS for
> > > > > AMD and IORT for Arm). From my point of view IORT is easier to
> > > > > extend, since we just need to introduce a new node type. There
> > > > > are no dependencies to Arm in the Linux IORT driver, so it
> > > > > works well with CONFIG_X86.   
> > > > From my limited understanding, IORT and VIOT is to solve device
> > > > topology enumeration only? I am not sure how it can be expanded
> > > > to cover information beyond device topology. e.g. DMAR has NUMA
> > > > information and root port ATS, I guess they are not used today
> > > > in the guest but might be additions in the future.    
> > > 
> > > The PCI root-complex node of IORT has an ATS attribute, which we
> > > can already use. However its scope is the root complex, not
> > > individual root ports like with DMAR.
> > > 
> > > I'm not very familiar with NUMA, but it looks like we just need to
> > > specify a proximity domain in relation to the SRAT table, for each
> > > viommu? The SMMUv3 node in IORT has a 4-bytes "proximity domain"
> > > field for this. We can add the same to the VIOT virtio-iommu nodes
> > > later, since the structures are extensible.
> > >   
> > I think there the proximity domain is more for each assigned device
> > than vIOMMU. vIOMMU in the guest can have assigned devices belong to
> > different pIOMMU and proximity domains. If the guest owns the first
> > level page tables (gIOVA or SVA), we want to make sure page tables
> > are allocated from the close proximity domain.
> > 
> > My understanding is virtio IOMMU supports both virtio devices and
> > assigned devices. we could care less about the former in terms of
> > NUMA.
> > 
> > In ACPI, we have _PXM method to retrieve device proximity domain. I
> > don't know if there is something equivalent or a generic way to get
> > _PXM information. I think VMM also need to make sure when an
> > assigned device is used with vIOMMU, there are some memory is
> > allocated from the device's proximity domain.
> >   
> > > But it might be better to keep the bare minimum information in
> > > the FW descriptor, and put the rest in the virtio-iommu. So yes
> > > topology enumeration is something the device cannot do itself
> > > (not fully that is, see (2)) but for the rest, virtio-iommu's
> > > PROBE request can provide details about each endpoint in relation
> > > to their physical IOMMU.
> > > 
> > > We could for example add a bit in a PROBE property saying that the
> > > whole path between the IOMMU and the endpoint supports ATS. For
> > > NUMA it might also be more interesting to have a finer
> > > granularity, since one viommu could be managing endpoints that
> > > are behind different physical IOMMUs. If in the future we want to
> > > allocate page tables close to the physical IOMMU for example, we
> > > might need to describe multiple NUMA nodes per viommu, using the
> > > PROBE request. 
> > Should we reinvent something for NUMA or use ACPI's SRAT, _PXM?   
> 
> Regardless whether we put it in the VIOT or in the virtio-iommu PROBE
> request, we necessarily need to reuse the node IDs defined by SRAT (or
> numa-node-id on devicetree, also a 32-bit value). A virtio-pci based
> virtio-iommu already has the _PXM of its closest bridge and wouldn't
> need anything more in the VIOT, while a virtio-mmio based
> virtio-iommu would need a proximity domain field in the VIOT. That
> could be added later since the table is extensible, but as you
> pointed out, that information might not be very useful.
> 
> > I am not sure how it is handled today in QEMU in terms of guest-host
> > NUMA proximity domain mapping.  
> 
> It looks like the user can specify this guest-host mapping on the
> command-line:
> 
>   -object memory-backend-ram,id=mem0,size=4G,host-nodes=3,policy=bind
>   -object memory-backend-ram,id=mem1,size=4G,host-nodes=4,policy=bind
>   -numa node,memdev=mem0,nodeid=numa0
>   -numa node,memdev=mem1,nodeid=numa1
>   -numa cpu,node-id=numa0,socket-id=0
>   -numa cpu,node-id=numa1,socket-id=1
> 
> numa0 and numa1 would get proximity domains 0 and 1, corresponding to
> host domains 3 and 4. It is also possible to specify the NUMA node of
> a PCI bus (via the PCI expander bridge), and therefore to assign a
> VFIO PCI device in the same proximity domain as its physical location.
> 
>   -device pxb,id=bridge1,bus=pci.0,numa_node=1 (simplified)
>   -device vfio-pci,host=03:01.0,bus=bridge1
> 
Thanks a lot for the thorough explanation. I will give that a try on
x86, I assume the ACPI tables also built to match these cmdline options.
> Linux can use this information to allocate DMA close to the endpoint
> (see for example __iommu_dma_alloc_pages()). For page tables
> allocation, io-pgtables currently takes the node ID of the IOMMU
> device, not the endpoint. For the scenario you describe (virtio-iommu
> endpoints managed by different physical IOMMU), we would need to take
> for example the node ID of the first endpoint in the iommu_domain for
> which we're allocating page tables.
> 
If iommu_domain is shared by multiple device from different NUMA node,
I guess taking the first one is as good as anyone. It would not be
an optimal configuration.
> Is it safe to assume that the pIOMMU is in the same proximity domain
> as the physical endpoint?
I think it is a safe assumption.
>  If that's the case, then the guest already
> has all the information it needs. Otherwise it's easy to add a
> proximity domain PROBE property for each endpoint. Configuring the
> host to pass that information might be more difficult.
> 
I agree, guest should always allocate DMA and IOVA page tables basedon
the endpoint. VT-d currently allocates page table pages based on IOMMU
NUMA node, that might have to change.
> 
> Off topic, I've been wondering how to make iommu-sva aware of NUMA
> topology as well, so that when handling a page request we allocate
> memory on the faulting device's NUMA node, but I think it might
> require invasive changes to the mm subsystem, to pass a NUMA node to
> handle_mm_fault().
> 
> Thanks,
> Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
