From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC PATCH 03/10] iommu/vt-d: Allocate groups for mediated
 devices
Date: Thu, 26 Jul 2018 16:09:19 +0100
Message-ID: <68bacab4-7729-59cd-07dc-e8d1f9580ec4@arm.com>
References: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
 <1532239773-15325-4-git-send-email-baolu.lu@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439CA143E@SHSMSX104.ccr.corp.intel.com>
 <5B568D5B.5050606@linux.intel.com>
 <ccf6890a-30c6-770b-4299-8cabfdc32f2b@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19127FB9E@SHSMSX101.ccr.corp.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19127FF05@SHSMSX101.ccr.corp.intel.com>
 <a530c220-9bf1-05ec-5698-526ccbea127f@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D1912826AE@SHSMSX101.ccr.corp.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191282739@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D191282739@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Tian, Kevin" <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>
Cc: "Raj, Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>
List-Id: iommu@lists.linux-foundation.org

On 26/07/18 04:28, Tian, Kevin wrote:
>> hierarchical domain might be the right way to go, but let's do more
>> thinking on any corner cases.
>>
> 
> btw maybe we don't need make it 'hierarchical', as maintaining
> hierarchy usually brings more work. What we require is possibly
> just the capability of having one device bind to multiple 
> iommu_domains. One domain is reserved for parent driver's
> own DMA activities (e.g. serving DMA APIs), while other domains
> are auxiliary and can be tagged with a PASID (or any other identifier
> which IOMMU can use to support multiple domains). Such identifiers 
> may be automatically provisioned when auxiliary domain is attached, 
> i.e. not requiring an explicit request from caller. IMO it's safe to 
> assume that supporting multiple iommu domains anyway implies 
> some finer-grained capability than RID-based in underlying IOMMU.
> Then there is no need of parent/child concept.

Right, we probably don't need a hierarchy. I like this model (it's
actually the one I favor for supporting PASID in virtio-iommu), though
I'm hoping we can avoid changing the logic of iommu_attach/detach, and
instead introduce a new "get_child_domain", "attach_aux_domain" or
simply "clone" op.

Currently the attach_dev() op toggles the domain of a device. For
example a device automatically gets a default domain for kernel DMA,
then VFIO attaches a new domain for assigning to a VM. attach_dev()
disables the default domain and installs fresh page tables. detach_dev()
isn't called, and the SMMU drivers don't even implement it. If we wanted
to reuse attach_dev() for auxiliary domains, we'd need some flag to
differentiate the "add auxiliary domain" operation from the "detach
everything and attach one new domain" one

Thanks,
Jean
