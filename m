From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: PROBLEM: Deadlock in attach_device() in AMD IOMMU driver
Date: Tue, 5 May 2015 16:41:59 +0200
Message-ID: <20150505144159.GI15736@8bytes.org>
References: <55488C3D.50509@solarflare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55488C3D.50509-s/n/eUQHGBpZroRs9YW3xA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Gregor Dick <gdick-s/n/eUQHGBpZroRs9YW3xA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Kieran Mansley <kmansley-s/n/eUQHGBpZroRs9YW3xA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Gregor,

On Tue, May 05, 2015 at 10:24:13AM +0100, Gregor Dick wrote:
> The problem occurs when a network driver (sfc.ko, here an internal
> testing version) enables SR-IOV on its device by calling
> pci_enable_sriov(). There are two PFs for this physical device. This
> call in turn results in a call to virtfn_add(), which takes the
> pci_sriov lock for the first function on the bus. The AMD IOMMU driver
> then handles the device-change notification by calling attach_device()
> which in turn calls pci_enable_ats().  This latter function also
> attempts to take the pci_sriov lock (although this time for
> dev->physfn rather than dev->sriov->dev, but these need not be
> distinct).

Do you see a real deadlock or only the lockdep warning? In the code it
looks like virtfn_add() takes the sriov->lock of the physical device
while pci_enable_ats() (when called from there) takes the sriov->lock of
the virtual function. In this case it couldn't deadlock.


	Joerg
