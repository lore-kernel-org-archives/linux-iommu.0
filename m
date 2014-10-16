From: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: PCIe PASID (Process Address Space ID) and iommu code
Date: Wed, 15 Oct 2014 21:50:58 -0600
Message-ID: <CAErSpo5YXZ8YRzhg0xvbHGCr22o+_+yi7HrCCBYBM9Ke42okJQ@mail.gmail.com>
References: <CA+QbAV6-C9wxPttEx0uDn_K5Y1LaGt8pxDWc8RJmN4DqR+NHtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CA+QbAV6-C9wxPttEx0uDn_K5Y1LaGt8pxDWc8RJmN4DqR+NHtQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Kallol Biswas <nucleodyne-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jay Cornwall <jay.cornwall-5C7GfCeVMHo@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

[+cc Joerg, Suravee, Jay, iommu list, linux-pci]

On Wed, Oct 15, 2014 at 5:44 PM, Kallol Biswas <nucleodyne-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Resending, as message got bounced for html content.
> --------------------------------------------
> Hi,
>     PCIe has introduced PASID TLP Prefix.  There are two ECNs on this.
>
> It seems that AMD iommu code makes use of PASID. Is there a device that
> utilizes this TLP prefix?
>
> PASID allocation and management within a device is not clear to me. How
> does device know which PASID to issue for which virtual address? Who makes
> the association? Must be software/OS, but how? There is no table for this
> like MSI-X table.
>
> Any pointer/documentation will be appreciated.
>
> Regards,
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
