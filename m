From: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] PCI: Save properties required to handle FLR for
	replay purposes.
Date: Wed, 24 May 2017 16:21:09 -0500
Message-ID: <20170524212109.GA2794@bhelgaas-glaptop.roam.corp.google.com>
References: <1494441543-8216-1-git-send-email-ashok.raj@intel.com>
	<20170523203322.GA15055@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170523203322.GA15055-1RhO1Y9PlrlHTL0Zs8A6p5iNqAH0jzoTYJqu5kTmcBRl57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, May 23, 2017 at 03:33:22PM -0500, Bjorn Helgaas wrote:
> On Wed, May 10, 2017 at 11:39:02AM -0700, Ashok Raj wrote:
> > From: CQ Tang <cq.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > 
> > Requires: https://patchwork.kernel.org/patch/9593891
> 
> I'm not sure what the status of the patch above is.  I acked it, but it's
> part of a 30-patch IOMMU series, so I expect it to be merged via an IOMMU
> tree.
> 
> In any case, it's not in v4.12-rc1, so I can't apply *this* patch yet.

Ashok or CQ, would you mind reposting this when the patch it depends
on has been merged?  I'm going to drop it from patchwork for now since
I can't do anything with it, and that means it will completely
disappear from my to-do list.

Bjorn
