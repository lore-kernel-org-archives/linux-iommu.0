From: "Michael S. Tsirkin" <mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [dpdk-dev] [PATCH] vfio: Include No-IOMMU mode
Date: Wed, 2 Dec 2015 18:31:53 +0200
Message-ID: <20151202182704-mutt-send-email-mst@redhat.com>
References: <20151028211309.14155.23867.stgit@gimli.home>
	<564A0E70.4030409@scylladb.com>
	<1449070123.15753.35.camel@redhat.com> <1473285.yZJWhu9CPo@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1473285.yZJWhu9CPo@xps13>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thomas Monjalon <thomas.monjalon-pdR9zngts4EAvxtiuMwx3w@public.gmane.org>
Cc: Avi Kivity <avi-VrcmuVmyx1hWk0Htik3J/w@public.gmane.org>, gleb-VrcmuVmyx1hWk0Htik3J/w@public.gmane.org, corbet-T1hC0tSOHrs@public.gmane.org, dev-VfR2kkLFssw@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, hjk-vqZO0P4V72/QD6PfKP4TzA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Dec 02, 2015 at 05:19:18PM +0100, Thomas Monjalon wrote:
> Hi,
> 
> 2015-12-02 08:28, Alex Williamson:
> > On Mon, 2015-11-16 at 19:12 +0200, Avi Kivity wrote:
> > > On 11/16/2015 07:06 PM, Alex Williamson wrote:
> > > > FYI, this is now in v4.4-rc1 (the slightly modified v2 version).  I want
> > > > to give fair warning though that while we seem to agree on this idea, it
> > > > hasn't been proven with a userspace driver port.  I've opted to include
> > > > it in this merge window rather than delaying it until v4.5, but I really
> > > > need to see a user for this before the end of the v4.4 cycle or I think
> > > > we'll need to revert and revisit for v4.5 anyway.  I don't really have
> > > > any interest in adding and maintaining code that has no users.  Please
> > > > keep me informed of progress with a dpdk port.  Thanks,
> > > 
> > > Thanks Alex.  Copying the dpdk mailing list, where the users live.
> > > 
> > > dpdk-ers: vfio-noiommu is a replacement for uio_pci_generic and 
> > > uio_igb.  It supports MSI-X and so can be used on SR/IOV VF devices.  
> > > The intent is that you can use dpdk without an external module, using 
> > > vfio, whether you are on bare metal with an iommu, bare metal without an 
> > > iommu, or virtualized.  However, dpdk needs modification to support this.
> > 
> > Still no users for this that I'm aware of.  I'm going to revert this in
> > rc5 unless something changes.  Thanks,
> 
> Removing needs for out-of-tree modules is a really nice achievement.
> Yes, we (in the DPDK project) should check how to use this no-iommu VFIO
> and to replace igb_uio.
> 
> I'm sorry we failed to catch your email and follow up.
> Is it really too late? What is the risk of keeping it in Linux 4.4?
> Advertising a new feature and removing it would be frustrating.
> 
> Have you tried this VFIO mode with DPDK?
> How complex would be the patch to support it?
> 
> Thanks

These things need to be developed together, one can't be sure it meets
userspace needs if no one tried.  And then where would we be?
Supporting a broken interface forever.  If someone writes the userspace
code, then this feature can come back for 4.5.

-- 
MST
