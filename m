From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 0/5] iommu/vt-d: Fix crash dump failure caused by legacy
	DMA/IO
Date: Wed, 10 Dec 2014 16:46:52 +0800
Message-ID: <20141210084652.GA25091@dhcp-16-105.nay.redhat.com>
References: <1413878659-1383-1-git-send-email-zhen-hual@hp.com>
	<20141022100525.GD9060@dhcp-16-116.nay.redhat.com>
	<545ACF66.9050509@jp.fujitsu.com> <545AD061.4000102@hp.com>
	<545AD353.8060207@jp.fujitsu.com> <545AD8D3.90709@hp.com>
	<545B2885.8070009@jp.fujitsu.com> <545B2C07.1070701@hp.com>
	<5465A0E0.4020001@hp.com> <20141117133858.GA31920@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141117133858.GA31920-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: tom.vaden-VXdhtT5mjnY@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lisa.mitchell-VXdhtT5mjnY@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "Li,
	ZhenHua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>, doug.hatch-VXdhtT5mjnY@public.gmane.org, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, li.zhang6-VXdhtT5mjnY@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg, ZhenHua,

This issue happens on AMD iommu too, do you have any plans or
thoughts on that?

Thanks
Baoquan

On 11/17/14 at 02:38pm, Joerg Roedel wrote:
> On Fri, Nov 14, 2014 at 02:27:44PM +0800, Li, ZhenHua wrote:
> > I am working following  your directions:
> > 
> > 1.  If the VT-d driver finds the IOMMU enabled, it reuses its root entry
> > table, and do NOT disable-enable iommu. Other data will be copied.
> > 
> > 2. When a device driver issues the first dma_map command for a
> > device, we assign a new and empty page-table, thus removing all
> > mappings from the old kernel for the device.
> > 
> > Please let me know if I get something wrong.
> 
> Yes, this sounds right. Happily waiting for patches :)
> 
> 
> 	Joerg
> 
