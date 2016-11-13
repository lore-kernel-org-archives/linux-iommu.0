From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v6 0/9] Fix kdump faults on system with amd iommu
Date: Sun, 13 Nov 2016 13:07:06 +0800
Message-ID: <20161113050706.GA19995@x1>
References: <1476963440-23039-1-git-send-email-bhe@redhat.com>
	<20161110115218.GF9996@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161110115218.GF9996-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent.Wan-5C7GfCeVMHo@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 11/10/16 at 12:52pm, Joerg Roedel wrote:
> Hi Baoquan,
> 
> thanks for working on this, really appreciated!
> 
> On Thu, Oct 20, 2016 at 07:37:11PM +0800, Baoquan He wrote:
> > This is v6 post. 
> > 
> > The principle of the fix is similar to intel iommu. Just defer the assignment
> > of device to domain to device driver init. But there's difference than
> > intel iommu. AMD iommu create protection domain and assign device to
> > domain in iommu driver init stage. So in this patchset I just allow the
> > assignment of device to domain in software level, but defer updating the
> > domain info, especially the pte_root to dev table entry to device driver
> > init stage.
> 
> I recently talked with the IOMMU guys from AMD about whether it is safe
> to update the device-table pointer while the iommu is enabled. It turns
> out that device-table pointer update is split up into two 32bit writes
> in the IOMMU hardware. So updating it while the IOMMU is enabled could
> have some nasty side effects.
> 
> The only way to work around this is to allocate the device-table
> below 4GB, but that needs more low-mem then in the kdump kernel. So some
> adjustments are needed there too. Anyway, can you add that to your
> patch-set?

Yes, sure. Seems this is the only way to work around the 64bit address
being split up into two times of 32bit writes into IOMMU hardware risk.

I guess we need add a GFP_DMA32 flag when allocate pages for
amd_iommu_dev_table in kdump kernel. And better add a note in kdump.txt.
I have been told on some big advanced servers they don't need low mem
reseved at all with the help of hardware iommu. Now server with amd
iommu hardware have to be exceptional.

Thanks
Baoquan
