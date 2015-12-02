From: Thomas Monjalon <thomas.monjalon@6wind.com>
Subject: Re: [PATCH] vfio: Include No-IOMMU mode
Date: Wed, 02 Dec 2015 17:19:18 +0100
Message-ID: <1473285.yZJWhu9CPo@xps13>
References: <20151028211309.14155.23867.stgit@gimli.home>
 <564A0E70.4030409@scylladb.com> <1449070123.15753.35.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <dev-bounces@dpdk.org>
In-Reply-To: <1449070123.15753.35.camel@redhat.com>
List-Unsubscribe: <http://dpdk.org/ml/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://dpdk.org/ml/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <http://dpdk.org/ml/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org
Sender: "dev" <dev-bounces@dpdk.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Avi Kivity <avi@scylladb.com>, gleb@scylladb.com, corbet@lwn.net, dev@dpdk.org, gregkh@linuxfoundation.org, mst@redhat.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, hjk@hansjkoch.de
List-Id: iommu@lists.linux-foundation.org

Hi,

2015-12-02 08:28, Alex Williamson:
> On Mon, 2015-11-16 at 19:12 +0200, Avi Kivity wrote:
> > On 11/16/2015 07:06 PM, Alex Williamson wrote:
> > > FYI, this is now in v4.4-rc1 (the slightly modified v2 version).  I want
> > > to give fair warning though that while we seem to agree on this idea, it
> > > hasn't been proven with a userspace driver port.  I've opted to include
> > > it in this merge window rather than delaying it until v4.5, but I really
> > > need to see a user for this before the end of the v4.4 cycle or I think
> > > we'll need to revert and revisit for v4.5 anyway.  I don't really have
> > > any interest in adding and maintaining code that has no users.  Please
> > > keep me informed of progress with a dpdk port.  Thanks,
> > 
> > Thanks Alex.  Copying the dpdk mailing list, where the users live.
> > 
> > dpdk-ers: vfio-noiommu is a replacement for uio_pci_generic and 
> > uio_igb.  It supports MSI-X and so can be used on SR/IOV VF devices.  
> > The intent is that you can use dpdk without an external module, using 
> > vfio, whether you are on bare metal with an iommu, bare metal without an 
> > iommu, or virtualized.  However, dpdk needs modification to support this.
> 
> Still no users for this that I'm aware of.  I'm going to revert this in
> rc5 unless something changes.  Thanks,

Removing needs for out-of-tree modules is a really nice achievement.
Yes, we (in the DPDK project) should check how to use this no-iommu VFIO
and to replace igb_uio.

I'm sorry we failed to catch your email and follow up.
Is it really too late? What is the risk of keeping it in Linux 4.4?
Advertising a new feature and removing it would be frustrating.

Have you tried this VFIO mode with DPDK?
How complex would be the patch to support it?

Thanks
