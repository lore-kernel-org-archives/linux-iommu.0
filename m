From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 1/3] Device isolation group infrastructure (v3)
Date: Thu, 09 Feb 2012 08:43:25 +1100
Message-ID: <1328737405.2903.39.camel@pasglop>
References: <1328071614-8320-1-git-send-email-david@gibson.dropbear.id.au>
	<1328071614-8320-2-git-send-email-david@gibson.dropbear.id.au>
	<20120208152748.GD22598@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120208152748.GD22598-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 2012-02-08 at 16:27 +0100, Joerg Roedel wrote:
> Again, device grouping is done by the IOMMU drivers, so this all
> belongs
> into the generic iommu-code rather than the driver core.
> 
> I think it makes sense to introduce a device->iommu pointer which
> depends on CONFIG_IOMMU_API and put the group information into it.
> This also has the benefit that we can consolidate all the
> device->arch.iommu pointers into device->iommu as well.

 ... and I pressed sent too quickly before.

So not only that, but these patches are simply a mechanism to expose
those groups to userspace and allow ownership (ie synchronize with the
attachment/detachment of kernel drivers).

So this code totally belongs in the driver core.

It does -not- address the issue of deciding how the groups are formed,
for this, it expects the information to be provided by the arch iommu
layer and we'll have to work on that.

The way iommu grouping work is too dependent on a given HW setup, you
can't really do that generically.

Yes, some factors are going to be common, such as the already mentioned
ricoh chip, but I think the best we can do here is provide quirks for
the iommu code to use.

There are capacity limits on how bdfn filtering works on bridges, either
CAM size or simply how it is arranged (ie on power for example, I can
chose to identify a function, a device, or a range of bus numbers but in
the later case it has to be an aligned power of two up to 32), etc...

I wouldn't try to solve that generically just yet.

Cheers,
Ben.
