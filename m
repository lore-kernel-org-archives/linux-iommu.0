From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V5 RESEND 2/3] iommu/hisilicon: Add hi6220-SoC smmu driver
Date: Sat, 28 Nov 2015 13:19:58 +0100
Message-ID: <20151128121958.GA18805@8bytes.org>
References: <1447986309-47548-1-git-send-email-puck.chen@hisilicon.com>
	<1447986309-47548-3-git-send-email-puck.chen@hisilicon.com>
	<20151127120203.GI24300@8bytes.org> <56590F22.90105@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56590F22.90105-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: chenfeng <puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, guodong.xu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, w.f-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, haojian.zhuang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, puck.chen-Dw/NWeUnuQfQT0dZR+AlfA@public.gmane.org, arnd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Sat, Nov 28, 2015 at 10:19:14AM +0800, chenfeng wrote:
> On 2015/11/27 20:02, Joerg Roedel wrote:
> > You need to create an iommu-group per smmu in your system and put all
> > devices translated by this smmu in that group. And then you must change
> > your code to allow attaching/detaching this iommu-group to different
> > domains.
> > 
> I read the code,I am confused about these concepts.
> In my opinion,
> IOMMU-Domain: The masters in one domain share the same iova space. Is that right?

Yes, an iommu-domain is an abstraction of a single page-table and
describes one iova address space. The SMMU in your hardware supports
only on page-table, so all devices behind it share a single iova address
space, und must be in the same domain.

But the way you implemented it there could be only one domain per SMMU.
With the IOMMU-API we must support to change the domain of an SMMU.
Think of one domain for DMA-API usage and another for VFIO, for example.

> IOMMU-GROUP: As you mentioned up,all devices translated by this smmu
> should be into one group.  I can do this. But if there is only on
> domain in the system, how can I attaching/detaching the group to
> different domains.

IOMMU-groups describe the isolation capabilities of the IOMMU between
devices. If devices are in a different IOMMU-group, this means that
the hardware can isolate them from each other.

Attaching the devices in a group to a new domain means in your case,
that you set a different page-table for them. Since you can only do that
for all devices behind a SMMU, these devices must be in on IOMMU-group.



	Joerg
