From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 3/5] iommu: Limit iommu_attach/detach_device to devices
	with their own group
Date: Tue, 3 Feb 2015 13:59:07 +0100
Message-ID: <20150203125907.GC3519@suse.de>
References: <1422317339-22620-1-git-send-email-joro@8bytes.org>
	<1422317339-22620-4-git-send-email-joro@8bytes.org>
	<20150203122506.GC15068@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150203122506.GC15068-AwZRO8vwLAwmlAP/+Wk3EA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 03, 2015 at 01:25:07PM +0100, Thierry Reding wrote:
> Sorry for my ignorance, but I don't understand what IOMMU groups are
> supposed to be or how to make use of them. It seems like a common idiom
> is to simply allocate a new group and add a device to it in the IOMMU's
> ->add_device() callback, but I fail to see the reason for that.
> 
> Can anybody point me to documentation about this? I've looked and I did
> not find anything.

An iommu group is a set of devices that the iommu hardware can isolate
from other devices. So devices in one group can't be isolated from each
other and have to share the same iommu page table.

This happens for example on legac 32 bit PCI buses. All devices on such
a bus use the request-id of the PCIe-PCI bridge, so they can't be
isolated from each other from the IOMMU and have to be in one iommu
group.


	Joerg
