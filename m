From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: PROBLEM: Deadlock in attach_device() in AMD IOMMU driver
Date: Tue, 5 May 2015 17:33:44 +0200
Message-ID: <20150505153344.GR15736@8bytes.org>
References: <55488C3D.50509@solarflare.com> <20150505144159.GI15736@8bytes.org>
	<5548D814.6020807@solarflare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5548D814.6020807-s/n/eUQHGBpZroRs9YW3xA@public.gmane.org>
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

On Tue, May 05, 2015 at 03:47:48PM +0100, Gregor Dick wrote:
> Hi Joerg,
> 
> On 05/05/15 15:41, Joerg Roedel wrote:
> >Do you see a real deadlock or only the lockdep warning? In the code it
> >looks like virtfn_add() takes the sriov->lock of the physical device
> >while pci_enable_ats() (when called from there) takes the sriov->lock of
> >the virtual function. In this case it couldn't deadlock.
> 
> The thread does deadlock. It looks like pci_enable_ats() takes
> dev->physfn->sriov->lock, where dev is the VF. I'd understood this to be
> a lock protecting SR-IOV state for all VFs configured on the PF (but I'm
> not familiar with the code at all!).

Okay, I'll have a look into the SLES12 kernel sources to check there.
Can you reproduce this with a recent upstream kernel?


	Joerg
