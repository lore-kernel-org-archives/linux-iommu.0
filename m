From: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [RFC PATCH 03/10] iommu/vt-d: Allocate groups for mediated devices
Date: Thu, 26 Jul 2018 03:28:22 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D191282739@SHSMSX101.ccr.corp.intel.com>
References: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
	<1532239773-15325-4-git-send-email-baolu.lu@linux.intel.com>
	<A2975661238FB949B60364EF0F2C257439CA143E@SHSMSX104.ccr.corp.intel.com>
	<5B568D5B.5050606@linux.intel.com>
	<ccf6890a-30c6-770b-4299-8cabfdc32f2b@arm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19127FB9E@SHSMSX101.ccr.corp.intel.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19127FF05@SHSMSX101.ccr.corp.intel.com>
	<a530c220-9bf1-05ec-5698-526ccbea127f@arm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D1912826AE@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D1912826AE-0J0gbvR4kThpB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: 'Jean-Philippe Brucker' <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Kirti Wankhede <kwankhede-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Kumar,
	Sanjay K" <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Sun, Yi Y" <yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Pan,
	Jacob jun" <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> From: Tian, Kevin
> Sent: Thursday, July 26, 2018 11:04 AM
[...]
> >
> > The IOMMU operations we care about don't take a device handle, I think,
> > just a domain. And VFIO itself only deals with domains when doing
> > map/unmap. Maybe we could add this operation to the IOMMU
> subsystem:
> >
> > child_domain = domain_create_child(parent_dev, parent_domain)
> >
> > A child domain would be a smaller isolation granule, getting a PASID if
> > that's what the IOMMU implements or another mechanism for 2). It is
> > automatically attached to its parent's devices, so attach/detach
> > operations wouldn't be necessary on the child.
> >
> > Depending on the underlying architecture the child domain can support
> > map/unmap on a single stage, or map/unmap for 2nd level and
> > bind_pgtable
> > for 1st level.
> >
> > I'm not sure how this works for host SVA though. I think the
> > sva_bind_dev() API could stay the same, but the internals will need
> > to change.
> >
> 
> hierarchical domain might be the right way to go, but let's do more
> thinking on any corner cases.
> 

btw maybe we don't need make it 'hierarchical', as maintaining
hierarchy usually brings more work. What we require is possibly
just the capability of having one device bind to multiple 
iommu_domains. One domain is reserved for parent driver's
own DMA activities (e.g. serving DMA APIs), while other domains
are auxiliary and can be tagged with a PASID (or any other identifier
which IOMMU can use to support multiple domains). Such identifiers 
may be automatically provisioned when auxiliary domain is attached, 
i.e. not requiring an explicit request from caller. IMO it's safe to 
assume that supporting multiple iommu domains anyway implies 
some finer-grained capability than RID-based in underlying IOMMU.
Then there is no need of parent/child concept.

thoughts?

Thanks
Kevin
