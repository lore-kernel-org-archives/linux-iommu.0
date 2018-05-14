From: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Subject: Re: Difference between IOVA and bus address when SMMU is enabled
Date: Mon, 14 May 2018 11:53:03 +0100
Message-ID: <20180514105303.GE16141@n2100.armlinux.org.uk>
References: <c4fe00a3-33b1-7cd4-f613-768dee06ef6b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <c4fe00a3-33b1-7cd4-f613-768dee06ef6b-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: valmiki <valmikibow-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Sat, May 12, 2018 at 06:25:13PM +0530, valmiki wrote:
> Hi All,
> 
> What is the difference between IOVA address and bus address
> when SMMU is enabled ?
> 
> Is IOVA address term used only when hypervisor is present ?

IOVA = IO virtual address.  IOVA is the term normally used to describe
the address used on the _device_ side of an IOMMU.

For any general setup:

RAM ----- MMU ----- DEVICE
      ^         ^
  physical   virtual
  address    address

where "device" can be an IO device or a CPU, the terms still apply.

If you have something like this:

RAM ----- PCI bridge ----- MMU ----- DEVICE
      ^                ^         ^
   physical           bus     virtual
   address          address   address

You could also have (eg, in the case of a system MMU):

RAM ----- MMU ----- PCI bridge ----- DEVICE
      ^         ^                ^
   physical  virtual            bus
   address   address          address
           (this can also be
            considered a bus
            address!)

In both of the above two cases, the PCI bridge may perform some address
translation, meaning that the bus address is different from the address
seen on the other side of the bridge.

So, the terms used depend exactly on the overall bus topology.

In the case of a system MMU, where the system MMU sits between peripheral
devices and RAM, then the bus addresses are the same as the
_IOVA of the system MMU_.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
