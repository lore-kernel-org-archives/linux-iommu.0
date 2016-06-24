From: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/2] PCI: Add PCI device flag
	PCI_DEV_FLAGS_DMA_ALIAS_ROOT
Date: Thu, 23 Jun 2016 22:37:05 -0500
Message-ID: <20160624033705.GG17987@localhost>
References: <linux-pci@vger.kernel.org>
	<1462700001-30086-1-git-send-email-jchandra@broadcom.com>
	<5730621B.2050503@arm.com>
	<CAKc_7PVAV6uAbEFLWHyh1hngLa1PdJxPzk7bPoppexU1oAJHnw@mail.gmail.com>
	<573340F9.6050507@arm.com>
	<037404e2-3168-8f99-0bdb-bb929776108e@redhat.com>
	<576BD031.7090105@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <576BD031.7090105-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jun 23, 2016 at 01:04:01PM +0100, Robin Murphy wrote:
> On 23/06/16 06:01, Jon Masters wrote:
> >On 05/11/2016 10:26 AM, Robin Murphy wrote:
> >>(I have no actual objection to this patch, though, and at this point
> >>I'm just chucking ideas about).
> >
> >Can I ask what the next steps are here? We're looking for upstream
> >direction to guide some internal activities and could really do with
> >understanding how you'd like to solve this one longer term as well as
> >what interim solution could be acceptable until we get there.
> 
> Well, for now I'm planning to leave the explicit "terminate the
> alias walk from the callback function" behaviour in the DT-parsing
> code[1], since there doesn't seem any good reason not to. As Bjorn
> says, though, it probably is generally useful for the PCI code to
> have its own knowledge of exactly where DMA can escape the PCI
> hierarchy - I now wonder if we could actually just do that from the
> DT/IORT code; if firmware says a particular bridge/etc. has a
> relationship with an ITS or SMMU, then presumably it's reasonable to
> infer that DMA can come out of it, thus we could inform the PCI code
> there and then without it having to quirk things on its own?
> 
> Robin.
> 
> [1]:http://article.gmane.org/gmane.linux.kernel.iommu/13932

Just a reminder that I'm going to be on vacation for about the next
three weeks, so it's not that I'm ignoring this, but it seems like
it's not fully baked quite yet.

Bjorn
