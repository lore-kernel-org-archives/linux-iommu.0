Return-Path: <SRS0=Tv0G=2I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF49C43603
	for <iommu@archiver.kernel.org>; Wed, 18 Dec 2019 11:20:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C2AF206E0
	for <iommu@archiver.kernel.org>; Wed, 18 Dec 2019 11:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vZD5Dd+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2AF206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3D72788419;
	Wed, 18 Dec 2019 11:20:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EocGxNbCng4b; Wed, 18 Dec 2019 11:20:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1BD3B88411;
	Wed, 18 Dec 2019 11:20:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 020B2C1AE8;
	Wed, 18 Dec 2019 11:20:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3BDBC077D
 for <iommu@lists.linux-foundation.org>; Wed, 18 Dec 2019 11:20:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DF47E87117
 for <iommu@lists.linux-foundation.org>; Wed, 18 Dec 2019 11:20:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q0lSZ3bPHZGQ for <iommu@lists.linux-foundation.org>;
 Wed, 18 Dec 2019 11:20:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B669B8745C
 for <iommu@lists.linux-foundation.org>; Wed, 18 Dec 2019 11:20:52 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id b6so1884442wrq.0
 for <iommu@lists.linux-foundation.org>; Wed, 18 Dec 2019 03:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=pMkceByH9eCryv82zRsOWRcNfp6S4hkvvS5VTqlG1c0=;
 b=vZD5Dd+n/3TPNldn1jITqf3ZHGQIDZcTIa/F/xxnIvcxm2m4qSnRD/mH/tOv7qucLd
 kGh+QhQEE3RZJUHhtq2KiQL1rCRF2pm6lgLxxi9h6CZpWALWW+1nJyf31aWZg0Phn3sm
 /vwes2L4Fk9SRH1k6CQyNnEp6Kfn0Jg/H2HDantOabtY4r4QHooB9zjVF2w0ND2vNtdx
 WMWL5z3V/xUBnFBPNvwD+fBAWBqkAHTe6X/TgtOTGsOIWuVURyorwjLf56rXOZRyAl1T
 lSrMcPsyYop89mF4dmuODnLyXXlGD8m5BUalhx7w1yst9yfm3xUIJBDY5FTyUxIAFtwg
 vbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pMkceByH9eCryv82zRsOWRcNfp6S4hkvvS5VTqlG1c0=;
 b=GDg8j1H505kq12Z5jQ/4MIfwy5K0gx5IsMVzyt1SXpLJPcXO1tV86ni02pkYL94WJr
 tR3AxyyiM8/zT15NnhD2z51BRBoZ1/ImKJlrJNjS2BD00fiXBxD6U7z6RfnOQMHP7cw0
 taipqh7xLO9vw52A0i/ui8WBjSzirie5JbPMymFmVh/UF20veyO9fIbr+oFsIiyScSHQ
 iuUH0XAXXoiAyOoTAvJeYcrqVKLkX0d94uO/6PoEoESQzpUmUUmX8g2i7XSYSejbklfN
 D0gCSucyzgSIyA0BDRUbAGDV0N3KWMC02ddKcvIEghNUOYH3eER+6zGtCw3jCLl+GLk3
 KRHg==
X-Gm-Message-State: APjAAAWb3JvqKSLt+aQgLuW9x9bfUGPuMOTTtmkoWcrkJrj7zeeqD0EJ
 fA24hpnRIJ9rQ2DViFAMJlIwgA==
X-Google-Smtp-Source: APXvYqyBIwIRMTHGPx7v8yVAQ5az67No8n6zIvx1fkP7hot2ar0GN4FuP0sV59XgyrhycW66+HTftQ==
X-Received: by 2002:adf:f80b:: with SMTP id s11mr2135192wrp.12.1576668051104; 
 Wed, 18 Dec 2019 03:20:51 -0800 (PST)
Received: from myrica (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
 by smtp.gmail.com with ESMTPSA id f17sm2138536wmc.8.2019.12.18.03.20.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2019 03:20:50 -0800 (PST)
Date: Wed, 18 Dec 2019 12:20:44 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Jacob Pan (Jun)" <jacob.jun.pan@intel.com>
Subject: Re: [RFC 00/13] virtio-iommu on non-devicetree platforms
Message-ID: <20191218112044.GA2371701@myrica>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
 <20191122160102.00004489@intel.com>
 <20191125180247.GD945122@lophozonia>
 <20191203190136.00007171@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191203190136.00007171@intel.com>
Cc: virtio-dev@lists.oasis-open.org, kevin.tian@intel.com,
 gregkh@linuxfoundation.org, linux-pci@vger.kernel.org, sudeep.holla@arm.com,
 rjw@rjwysocki.net, virtualization@lists.linux-foundation.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, mst@redhat.com, guohanjun@huawei.com,
 bhelgaas@google.com, jasowang@redhat.com, linux-arm-kernel@lists.infradead.org,
 lenb@kernel.org
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

On Tue, Dec 03, 2019 at 07:01:36PM -0800, Jacob Pan (Jun) wrote:
> Hi Jean,
> 
> Sorry for the delay, I was out last week. Comments inline below.
> 
> On Mon, 25 Nov 2019 19:02:47 +0100
> Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:
> 
> > On Fri, Nov 22, 2019 at 04:01:02PM -0800, Jacob Pan (Jun) wrote:
> > > > (1) ACPI has one table per vendor (DMAR for Intel, IVRS for AMD
> > > > and IORT for Arm). From my point of view IORT is easier to
> > > > extend, since we just need to introduce a new node type. There
> > > > are no dependencies to Arm in the Linux IORT driver, so it works
> > > > well with CONFIG_X86. 
> > > From my limited understanding, IORT and VIOT is to solve device
> > > topology enumeration only? I am not sure how it can be expanded to
> > > cover information beyond device topology. e.g. DMAR has NUMA
> > > information and root port ATS, I guess they are not used today in
> > > the guest but might be additions in the future.  
> > 
> > The PCI root-complex node of IORT has an ATS attribute, which we can
> > already use. However its scope is the root complex, not individual
> > root ports like with DMAR.
> > 
> > I'm not very familiar with NUMA, but it looks like we just need to
> > specify a proximity domain in relation to the SRAT table, for each
> > viommu? The SMMUv3 node in IORT has a 4-bytes "proximity domain"
> > field for this. We can add the same to the VIOT virtio-iommu nodes
> > later, since the structures are extensible.
> > 
> I think there the proximity domain is more for each assigned device
> than vIOMMU. vIOMMU in the guest can have assigned devices belong to
> different pIOMMU and proximity domains. If the guest owns the first
> level page tables (gIOVA or SVA), we want to make sure page tables are
> allocated from the close proximity domain.
> 
> My understanding is virtio IOMMU supports both virtio devices and
> assigned devices. we could care less about the former in terms of NUMA.
> 
> In ACPI, we have _PXM method to retrieve device proximity domain. I
> don't know if there is something equivalent or a generic way to get
> _PXM information. I think VMM also need to make sure when an assigned
> device is used with vIOMMU, there are some memory is allocated from the
> device's proximity domain.
> 
> > But it might be better to keep the bare minimum information in the FW
> > descriptor, and put the rest in the virtio-iommu. So yes topology
> > enumeration is something the device cannot do itself (not fully that
> > is, see (2)) but for the rest, virtio-iommu's PROBE request can
> > provide details about each endpoint in relation to their physical
> > IOMMU.
> > 
> > We could for example add a bit in a PROBE property saying that the
> > whole path between the IOMMU and the endpoint supports ATS. For NUMA
> > it might also be more interesting to have a finer granularity, since
> > one viommu could be managing endpoints that are behind different
> > physical IOMMUs. If in the future we want to allocate page tables
> > close to the physical IOMMU for example, we might need to describe
> > multiple NUMA nodes per viommu, using the PROBE request.
> > 
> Should we reinvent something for NUMA or use ACPI's SRAT, _PXM? 

Regardless whether we put it in the VIOT or in the virtio-iommu PROBE
request, we necessarily need to reuse the node IDs defined by SRAT (or
numa-node-id on devicetree, also a 32-bit value). A virtio-pci based
virtio-iommu already has the _PXM of its closest bridge and wouldn't need
anything more in the VIOT, while a virtio-mmio based virtio-iommu would
need a proximity domain field in the VIOT. That could be added later since
the table is extensible, but as you pointed out, that information might
not be very useful.

> I am not sure how it is handled today in QEMU in terms of guest-host
> NUMA proximity domain mapping.

It looks like the user can specify this guest-host mapping on the
command-line:

  -object memory-backend-ram,id=mem0,size=4G,host-nodes=3,policy=bind
  -object memory-backend-ram,id=mem1,size=4G,host-nodes=4,policy=bind
  -numa node,memdev=mem0,nodeid=numa0
  -numa node,memdev=mem1,nodeid=numa1
  -numa cpu,node-id=numa0,socket-id=0
  -numa cpu,node-id=numa1,socket-id=1

numa0 and numa1 would get proximity domains 0 and 1, corresponding to host
domains 3 and 4. It is also possible to specify the NUMA node of a PCI bus
(via the PCI expander bridge), and therefore to assign a VFIO PCI device
in the same proximity domain as its physical location.

  -device pxb,id=bridge1,bus=pci.0,numa_node=1 (simplified)
  -device vfio-pci,host=03:01.0,bus=bridge1

Linux can use this information to allocate DMA close to the endpoint (see
for example __iommu_dma_alloc_pages()). For page tables allocation,
io-pgtables currently takes the node ID of the IOMMU device, not the
endpoint. For the scenario you describe (virtio-iommu endpoints managed by
different physical IOMMU), we would need to take for example the node ID
of the first endpoint in the iommu_domain for which we're allocating page
tables.

Is it safe to assume that the pIOMMU is in the same proximity domain as
the physical endpoint?  If that's the case, then the guest already has all
the information it needs. Otherwise it's easy to add a proximity domain
PROBE property for each endpoint. Configuring the host to pass that
information might be more difficult.


Off topic, I've been wondering how to make iommu-sva aware of NUMA
topology as well, so that when handling a page request we allocate memory
on the faulting device's NUMA node, but I think it might require invasive
changes to the mm subsystem, to pass a NUMA node to handle_mm_fault().

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
