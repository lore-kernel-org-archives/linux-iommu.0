From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 0/4] iommu/amd: Clean up patches
Date: Tue, 20 Sep 2016 09:07:32 +0800
Message-ID: <20160920010732.GB11495@x1.redhat.com>
References: <1473929453-3533-1-git-send-email-bhe@redhat.com>
	<20160919142058.GA7566@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160919142058.GA7566-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent.Wan-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 09/19/16 at 04:20pm, Joerg Roedel wrote:
> Hi Baoquan,
> 
> On Thu, Sep 15, 2016 at 04:50:49PM +0800, Baoquan He wrote:
> > These were found out when I tried to fix the kdump failure on system
> > with AMD iommu. Pack them into this patchset since they are not related
> > to the kdump issue and each other.
> > 
> > Baoquan He (4):
> >   iommu/amd: clean up the cmpxchg64 invocation
> >   iommu/amd: Use standard bitmap operation to set bitmap
> >   iommu/amd: Free domain id when free a domain of struct dma_ops_domain
> >   iommu/amd: No need to wait iommu completion if no dte irq entry change
> 
> I applied patches 1-3, but patch 4 had some conflicts. Can you please
> rebase this patch to my x86/amd branch and resend?

Finished, please try the resent post.

Thanks
Baoquan
