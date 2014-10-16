From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: PCIe PASID (Process Address Space ID) and iommu code
Date: Thu, 16 Oct 2014 11:14:33 +0200
Message-ID: <20141016091433.GI28786@8bytes.org>
References: <CA+QbAV6-C9wxPttEx0uDn_K5Y1LaGt8pxDWc8RJmN4DqR+NHtQ@mail.gmail.com>
	<CAErSpo5YXZ8YRzhg0xvbHGCr22o+_+yi7HrCCBYBM9Ke42okJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAErSpo5YXZ8YRzhg0xvbHGCr22o+_+yi7HrCCBYBM9Ke42okJQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Jay Cornwall <jay.cornwall-5C7GfCeVMHo@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kallol Biswas <nucleodyne-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Oct 15, 2014 at 09:50:58PM -0600, Bjorn Helgaas wrote:
> [+cc Joerg, Suravee, Jay, iommu list, linux-pci]
> 
> On Wed, Oct 15, 2014 at 5:44 PM, Kallol Biswas <nucleodyne-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > Resending, as message got bounced for html content.
> > --------------------------------------------
> > Hi,
> >     PCIe has introduced PASID TLP Prefix.  There are two ECNs on this.
> >
> > It seems that AMD iommu code makes use of PASID. Is there a device that
> > utilizes this TLP prefix?

Yes, recent radeon GPUs can make use of the TLP prefix.

> > PASID allocation and management within a device is not clear to me. How
> > does device know which PASID to issue for which virtual address? Who makes
> > the association? Must be software/OS, but how? There is no table for this
> > like MSI-X table.

The setup of the PASIDs is device specific, so there is no standard for
setting up PASID address spaces on devices.


HTH,

	Joerg
