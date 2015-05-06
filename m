From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v10 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
Date: Wed, 6 May 2015 09:51:35 +0800
Message-ID: <20150506015135.GB14065@dhcp-128-4.nay.redhat.com>
References: <20150415005731.GC19051@localhost.localdomain>
	<552DFB56.1070600@hp.com>
	<20150415064803.GF19051@localhost.localdomain>
	<20150424080147.GC4458@dhcp-16-116.nay.redhat.com>
	<20150424082528.GA23912@dhcp-128-91.nay.redhat.com>
	<20150424083530.GD4458@dhcp-16-116.nay.redhat.com>
	<20150424084957.GC23912@dhcp-128-91.nay.redhat.com>
	<20150504162318.GH15736@8bytes.org>
	<20150505061423.GC31063@dhcp-128-4.nay.redhat.com>
	<20150505153157.GQ15736@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150505153157.GQ15736-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, tom.vaden-VXdhtT5mjnY@public.gmane.org, rwright-VXdhtT5mjnY@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lisa.mitchell-VXdhtT5mjnY@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "Li,
	ZhenHua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>, doug.hatch-VXdhtT5mjnY@public.gmane.org, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, billsumnerlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, li.zhang6-VXdhtT5mjnY@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 05/05/15 at 05:31pm, Joerg Roedel wrote:
> On Tue, May 05, 2015 at 02:14:23PM +0800, Dave Young wrote:
> > The failure is nothing different, but as I said in another reply the
> > difference is we could use corrupted data to possiblly cause more failure.
> 
> I still fail to see how things can get more worse than they already are
> by reusing the old data (we just reuse it, we do not modify anything

DMA write will modify system ram, if the old data is corrupted  it is possible
that DMA operation modify wrong ram regions because of wrong mapping.
Am I missing something and is it not possible?

Thanks
Dave
