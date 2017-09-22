From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] iommu/of: Remove PCI host bridge node check
Date: Fri, 22 Sep 2017 10:56:19 +0200
Message-ID: <20170922085618.GI8398@8bytes.org>
References: <7ff4e56719d2e90426d9338eab00396bb2b61995.1505988973.git.robin.murphy@arm.com>
	<56a797382ffc65243169205c36d9f9fb1173dddd.1505989095.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56a797382ffc65243169205c36d9f9fb1173dddd.1505989095.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hey Robin,

On Thu, Sep 21, 2017 at 11:20:58AM +0100, Robin Murphy wrote:
> of_pci_iommu_init() tries to be clever and stop its alias walk at the
> device represented by master_np, in case of weird PCI topologies where
> the bridge to the IOMMU and the rest of the system is not at the root.
> It turns out this is a bit short-sighted, since there are plenty of
> other callers of pci_for_each_dma_alias() which would also need the same
> behaviour in that situation, and the only platform so far with such a
> topology (Cavium ThunderX2) already solves it more generally via a PCI
> quirk. As this check is effectively redundant, and returning a boolean
> value as an int is a bit broken anyway, let's just get rid of it.
> 
> Reported-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

Can you send me a Fixes: tag for this please? No need to resend the
whole patch, I just need the tag.

Thanks,

	Joerg
