From: "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v9 12/18] vfio: Register/unregister irq_bypass_producer
Date: Mon, 21 Sep 2015 11:35:56 +0000
Message-ID: <E959C4978C3B6342920538CF579893F002723C42@SHSMSX104.ccr.corp.intel.com>
References: <1442586596-5920-1-git-send-email-feng.wu@intel.com>
	<1442586596-5920-13-git-send-email-feng.wu@intel.com>
	<E959C4978C3B6342920538CF579893F00272346C@SHSMSX104.ccr.corp.intel.com>
	<55FFCE9F.5090001@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <55FFCE9F.5090001-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
To: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Paolo Bonzini [mailto:pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]
> Sent: Monday, September 21, 2015 5:32 PM
> To: Wu, Feng; alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org;
> mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> Cc: eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [PATCH v9 12/18] vfio: Register/unregister irq_bypass_producer
> 
> 
> 
> On 21/09/2015 10:56, Wu, Feng wrote:
> > Hi Paolo & Alex,
> >
> > I find that there is a build error in the following two cases:
> > - KVM is configured as 'M' and VFIO as 'Y'
> > The reason is the build of irqbypass manager is triggered in
> > arch/x86/kvm/Makefile, and VFIO is built before KVM, hence
> > it cannot find the symbols in irqbypass manager.
> >
> > - Disable KVM and enable VFIO in .config
> > The reason is similar with the above one, the irqbypass manager
> > is not built since KVM is not configured.
> >
> > I think the point is that we cannot trigger the build of irqbypass
> > manager inside KVM or VFIO, we need trigger the build at a high
> > level and it should be built before VFIO and KVM. Any ideas?
> 
> We can add virt/Makefile and build virt/lib/ directly, not through
> arch/x86/kvm.

Yes, that can solve the build error. Should I send a new version?

Thanks,
Feng

> 
> Paolo
