From: Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: [RFC PATCH 0/2] iommu/s390: Fix iommu-groups and add sysfs support
Date: Fri, 28 Apr 2017 17:25:20 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1704281709350.1788@schleppi.fritz.box>
References: <1493306905-32334-1-git-send-email-joro@8bytes.org>
	<20170427201018.70c8be5a@thinkpad>
	<20170427210325.GE1332@8bytes.org>
	<20170428144634.7950c8cf@thinkpad>
	<20170428145513.GH1332@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170428145513.GH1332-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Gerald Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, 28 Apr 2017, Joerg Roedel wrote:
> On Fri, Apr 28, 2017 at 02:46:34PM +0200, Gerald Schaefer wrote:
> > On Thu, 27 Apr 2017 23:03:25 +0200
> > Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> > 
> > > > Well, there is a separate zpci_dev for each pci_dev on s390,
> > > > and each of those has its own separate dma-table (thus not shared).  
> > > 
> > > Is that true for all functions of a PCIe card, so does every function of
> > > a device has its own zpci_dev structure and thus its own DMA-table?
> > 
> > Yes, clp_add_pci_device() is called for every function, which in turn calls
> > zpci_create_device() with a freshly allocated zdev. zpci_enable_device()
> > then sets up a new DMA address space for each function.
> 
> That sounds special :) So will every function of a single device end up
> as a seperate device on a seperate root-bus?

Yes. That's true even for multi-function and SRIOV.

> > > My assumption came from the fact that the zpci_dev is read from
> > > pci_dev->sysdata, which is propagated there from the pci_bridge
> > > through the pci_root_bus structures.
> > 
> > The zdev gets there via zpci_create_device() -> zpci_scan_bus() ->
> > pci_scan_root_bus(), which is done for every single function.
> > 
> > Not sure if I understand this right, but it looks like we set up a new PCI
> > bus for each function.
> 
> Yeah, it sounds like this. Maybe Sebastian can confirm that?

Yes. Confirmed.

Regards,
Sebastian
