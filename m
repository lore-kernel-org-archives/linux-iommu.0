From: Andy Burns <iommu+lists-6TVDe6PzSGq9FHfhHBbuYA@public.gmane.org>
Subject: Re: [RFC PATCH v2 2/2] iommu/intel: Make use of PCIe requester ID
	interface
Date: Tue, 26 Aug 2014 11:33:04 +0100
Message-ID: <53FC6260.1050901@adslpipe.co.uk>
References: <53FC33AF.5040407@adslpipe.co.uk> <53FC3C07.8050906@adslpipe.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <53FC3C07.8050906-6TVDe6PzSGq9FHfhHBbuYA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Andy Burns wrote:

> "should also enable motherboards with an onboard ASmedia
> ASM1083/1085 PCIe-to-PCI bridge to work with VT-d enabled"
>
> Are any parts of this in mainline yet?

I tried with an elrepo 3.17-rc1 kernel (which presumably includes 
dma-alias-v4 patches) and the warning from pci_find_upstream_pcie_bridge 
is now gone.

I still have to learn a little about how to pass through the whole group 
of devices using VT-d, to get PCI passthrough working.

Thanks.
