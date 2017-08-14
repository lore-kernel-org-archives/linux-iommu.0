From: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Support SVM without PASID
Date: Mon, 14 Aug 2017 08:00:19 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190D716A4@SHSMSX101.ccr.corp.intel.com>
References: <a30962a6-2240-9263-96cc-10da1b179fcc@gmail.com>
	<20170708140257.2de02d63@w520.home>
	<73619426-6fcc-21ce-cfd4-8c66bde63f9a@gmail.com>
	<eb132dfa-6708-5898-c2ce-ce7ab08809b1@arm.com>
	<ee41f5d9-e7fb-8f7c-4b85-87cdb951ec70@gmail.com>
	<ca0d9f94-f5e2-aaaf-2c64-0cd6ecc62754@arm.com>
	<41333a03-bf91-1152-4779-6579845609f6@gmail.com>
	<564ba70b-db95-7fe0-86bb-bb4eefcd87ec@arm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D190D57191@SHSMSX101.ccr.corp.intel.com>
	<b973c557-1b4a-18d2-a05e-28680a49daf9@arm.com>
	<20170811162506.GB41059@otc-nc-03>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170811162506.GB41059@otc-nc-03>
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
To: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: "Lan, Tianyu" <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Pan, Jacob jun" <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> From: Raj, Ashok
> Sent: Saturday, August 12, 2017 12:25 AM
> 
> On Fri, Aug 04, 2017 at 10:42:41AM +0100, Jean-Philippe Brucker wrote:
> > Hi Kevin,
> >
> >
> > Consider the situation where a userspace driver (no virtualization) is
> > built in a client-server fashion: the server controls a device and spawns
> > new processes (clients), each sharing a context with the device using its
> > own PASID. If the server wants to hide parts of the client address space
> 
> Just to be sure, you are't expecting the PASID's to be duplicated or
> recreated after a new process is spawned. I would expect each process to
> get its own PASID by doing a bind. Threads of the same process would be
> sharing the same PASID since they all share the same first level
> mappings.
> 
> 
> > from the device (e.g. .text), then it could control stage-2 via MAP/UNMAP
> > to restrict the address space.
> 
> I'm confused.. maybe this is different from Intel IOMMU. the first level
> requiring a second level is only true when virtualization is in play.
> 
> First level is gVA->gPA, and second level is gPA->hPA (sort of the cloned
> EPT map that is setup via VFIO to set up second level)
> 
> When you are in native user application, there is no nesting between first
> and second level. The first level is directly VA->hPA. There is no need
> for a nested walk in this case?
> 

Strictly speaking nesting is just a hardware capability while 
virtualization is an use case using that capability. As long as 
some software entity (not hypervisor) can setup two level 
page tables, it should just work regardless of how the 
intermediate address is called.

I think Jean is trying to come up a non-virtualization usage
using nesting. Of course current example that he illustrated 
is not very meaningful (as I replied in another mail). :-)

Thanks
Kevin
